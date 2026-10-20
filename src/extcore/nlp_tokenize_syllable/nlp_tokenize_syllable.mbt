///===
/// extcore/nlp_tokenize_syllable

pub(all) struct NlptokenizesyllablePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_syllable_make_point(x : Double, y : Double) -> NlptokenizesyllablePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_syllable_make_point3(x : Double, y : Double, z : Double) -> NlptokenizesyllablePoint {
  { x, y, z, label: 0 }
}

pub fn nlp_tokenize_syllable_point_x(pt : NlptokenizesyllablePoint) -> Double { pt.x }

pub fn nlp_tokenize_syllable_point_y(pt : NlptokenizesyllablePoint) -> Double { pt.y }

pub fn nlp_tokenize_syllable_point_z(pt : NlptokenizesyllablePoint) -> Double { pt.z }

pub fn nlp_tokenize_syllable_point_label(pt : NlptokenizesyllablePoint) -> Int { pt.label }

pub fn nlp_tokenize_syllable_point_dist(a : NlptokenizesyllablePoint, b : NlptokenizesyllablePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_tokenize_syllable_point_add(a : NlptokenizesyllablePoint, b : NlptokenizesyllablePoint) -> NlptokenizesyllablePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_tokenize_syllable_point_sub(a : NlptokenizesyllablePoint, b : NlptokenizesyllablePoint) -> NlptokenizesyllablePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_tokenize_syllable_point_scale(pt : NlptokenizesyllablePoint, s : Double) -> NlptokenizesyllablePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_tokenize_syllable_point_dot(a : NlptokenizesyllablePoint, b : NlptokenizesyllablePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_tokenize_syllable_point_cross(a : NlptokenizesyllablePoint, b : NlptokenizesyllablePoint) -> NlptokenizesyllablePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_tokenize_syllable_point_norm(pt : NlptokenizesyllablePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_tokenize_syllable_point_normalize(pt : NlptokenizesyllablePoint) -> NlptokenizesyllablePoint {
  let n = nlp_tokenize_syllable_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_tokenize_syllable_point_scale(pt, 1.0 / n) }
}

pub fn nlp_tokenize_syllable_point_negate(pt : NlptokenizesyllablePoint) -> NlptokenizesyllablePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_tokenize_syllable_point_mid(a : NlptokenizesyllablePoint, b : NlptokenizesyllablePoint) -> NlptokenizesyllablePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_tokenize_syllable_point_lerp(a : NlptokenizesyllablePoint, b : NlptokenizesyllablePoint, t : Double) -> NlptokenizesyllablePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_tokenize_syllable_point_to_string(pt : NlptokenizesyllablePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlptokenizesyllableSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_syllable_make_series(vals : Array[Double], name : String) -> NlptokenizesyllableSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_tokenize_syllable_series_len(s : NlptokenizesyllableSeries) -> Int { s.vals.length() }

pub fn nlp_tokenize_syllable_series_sum(s : NlptokenizesyllableSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_tokenize_syllable_series_mean(s : NlptokenizesyllableSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_tokenize_syllable_series_min(s : NlptokenizesyllableSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_tokenize_syllable_series_max(s : NlptokenizesyllableSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_tokenize_syllable_series_range(s : NlptokenizesyllableSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_tokenize_syllable_series_var(s : NlptokenizesyllableSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_tokenize_syllable_series_std(s : NlptokenizesyllableSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_tokenize_syllable_series_median(s : NlptokenizesyllableSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_tokenize_syllable_series_scale(s : NlptokenizesyllableSeries, f : Double) -> NlptokenizesyllableSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_tokenize_syllable_series_add(a : NlptokenizesyllableSeries, b : NlptokenizesyllableSeries) -> NlptokenizesyllableSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_syllable_series_sub(a : NlptokenizesyllableSeries, b : NlptokenizesyllableSeries) -> NlptokenizesyllableSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_syllable_series_normalize(s : NlptokenizesyllableSeries) -> NlptokenizesyllableSeries {
  let mn = nlp_tokenize_syllable_series_min(s)
  let mx = nlp_tokenize_syllable_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_tokenize_syllable_series_cumsum(s : NlptokenizesyllableSeries) -> NlptokenizesyllableSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_tokenize_syllable_series_to_string(s : NlptokenizesyllableSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizesyllableMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_syllable_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizesyllableMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_syllable_matrix_identity(n : Int) -> NlptokenizesyllableMatrix {
  let m = nlp_tokenize_syllable_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_tokenize_syllable_matrix_get(m : NlptokenizesyllableMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_tokenize_syllable_matrix_transpose(m : NlptokenizesyllableMatrix) -> NlptokenizesyllableMatrix {
  let result = nlp_tokenize_syllable_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_tokenize_syllable_matrix_add(a : NlptokenizesyllableMatrix, b : NlptokenizesyllableMatrix) -> NlptokenizesyllableMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_tokenize_syllable_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_tokenize_syllable_matrix_scale(m : NlptokenizesyllableMatrix, s : Double) -> NlptokenizesyllableMatrix {
  let result = nlp_tokenize_syllable_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_tokenize_syllable_matrix_multiply(a : NlptokenizesyllableMatrix, b : NlptokenizesyllableMatrix) -> NlptokenizesyllableMatrix {
  if a.cols != b.rows { return nlp_tokenize_syllable_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_tokenize_syllable_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_tokenize_syllable_matrix_trace(m : NlptokenizesyllableMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_tokenize_syllable_matrix_det(m : NlptokenizesyllableMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_tokenize_syllable_matrix_norm(m : NlptokenizesyllableMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_tokenize_syllable_matrix_to_string(m : NlptokenizesyllableMatrix) -> String {
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

pub(all) struct NlptokenizesyllableVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_syllable_make_vector(comps : Array[Double]) -> NlptokenizesyllableVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_syllable_vector_zero(dim : Int) -> NlptokenizesyllableVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_tokenize_syllable_vector_add(a : NlptokenizesyllableVector, b : NlptokenizesyllableVector) -> NlptokenizesyllableVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_tokenize_syllable_vector_sub(a : NlptokenizesyllableVector, b : NlptokenizesyllableVector) -> NlptokenizesyllableVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_tokenize_syllable_vector_scale(v : NlptokenizesyllableVector, s : Double) -> NlptokenizesyllableVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_tokenize_syllable_vector_dot(a : NlptokenizesyllableVector, b : NlptokenizesyllableVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_tokenize_syllable_vector_norm(v : NlptokenizesyllableVector) -> Double { @_common.sqrt(nlp_tokenize_syllable_vector_dot(v, v)) }

pub fn nlp_tokenize_syllable_vector_normalize(v : NlptokenizesyllableVector) -> NlptokenizesyllableVector {
  let n = nlp_tokenize_syllable_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_tokenize_syllable_vector_scale(v, 1.0 / n) }
}

pub fn nlp_tokenize_syllable_vector_dist(a : NlptokenizesyllableVector, b : NlptokenizesyllableVector) -> Double {
  nlp_tokenize_syllable_vector_norm(nlp_tokenize_syllable_vector_sub(a, b))
}

pub fn nlp_tokenize_syllable_vector_to_string(v : NlptokenizesyllableVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_syllable_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_syllable_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_syllable_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_syllable_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_syllable_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_syllable_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_syllable_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_syllable_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_syllable_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_syllable_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_syllable_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_syllable_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_syllable_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_syllable_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_syllable_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_syllable_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_syllable_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_syllable_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_syllable_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_syllable_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_syllable_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_syllable_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_syllable_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_syllable_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_syllable_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_syllable_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_syllable_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_syllable_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_syllable_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizesyllableFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_frame_make(size : Int) -> NlptokenizesyllableFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_frame_len(s : NlptokenizesyllableFrame) -> Int { s.size }

pub fn nlp_tokenize_syllable_frame_get(s : NlptokenizesyllableFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_frame_set(s : NlptokenizesyllableFrame, i : Int, v : Double) -> NlptokenizesyllableFrame {
  let result = nlp_tokenize_syllable_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_frame_sum(s : NlptokenizesyllableFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_syllable_frame_mean(s : NlptokenizesyllableFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_syllable_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_syllable_frame_scale(s : NlptokenizesyllableFrame, f : Double) -> NlptokenizesyllableFrame {
  let result = nlp_tokenize_syllable_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_syllable_frame_add(a : NlptokenizesyllableFrame, b : NlptokenizesyllableFrame) -> NlptokenizesyllableFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_syllable_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_syllable_frame_copy(s : NlptokenizesyllableFrame) -> NlptokenizesyllableFrame {
  let result = nlp_tokenize_syllable_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_syllable_frame_fill(s : NlptokenizesyllableFrame, v : Double) -> NlptokenizesyllableFrame {
  let result = nlp_tokenize_syllable_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_frame_min(s : NlptokenizesyllableFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_frame_max(s : NlptokenizesyllableFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_frame_to_string(s : NlptokenizesyllableFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_table_make(size : Int) -> NlptokenizesyllableTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_table_len(s : NlptokenizesyllableTable) -> Int { s.size }

pub fn nlp_tokenize_syllable_table_get(s : NlptokenizesyllableTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_table_set(s : NlptokenizesyllableTable, i : Int, v : Double) -> NlptokenizesyllableTable {
  let result = nlp_tokenize_syllable_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_table_sum(s : NlptokenizesyllableTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_syllable_table_mean(s : NlptokenizesyllableTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_syllable_table_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_syllable_table_scale(s : NlptokenizesyllableTable, f : Double) -> NlptokenizesyllableTable {
  let result = nlp_tokenize_syllable_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_syllable_table_add(a : NlptokenizesyllableTable, b : NlptokenizesyllableTable) -> NlptokenizesyllableTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_syllable_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_syllable_table_copy(s : NlptokenizesyllableTable) -> NlptokenizesyllableTable {
  let result = nlp_tokenize_syllable_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_syllable_table_fill(s : NlptokenizesyllableTable, v : Double) -> NlptokenizesyllableTable {
  let result = nlp_tokenize_syllable_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_table_min(s : NlptokenizesyllableTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_table_max(s : NlptokenizesyllableTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_table_to_string(s : NlptokenizesyllableTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_graphn_make(size : Int) -> NlptokenizesyllableGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_graphn_len(s : NlptokenizesyllableGraphN) -> Int { s.size }

pub fn nlp_tokenize_syllable_graphn_get(s : NlptokenizesyllableGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_graphn_set(s : NlptokenizesyllableGraphN, i : Int, v : Double) -> NlptokenizesyllableGraphN {
  let result = nlp_tokenize_syllable_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_graphn_sum(s : NlptokenizesyllableGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_syllable_graphn_mean(s : NlptokenizesyllableGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_syllable_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_syllable_graphn_scale(s : NlptokenizesyllableGraphN, f : Double) -> NlptokenizesyllableGraphN {
  let result = nlp_tokenize_syllable_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_syllable_graphn_add(a : NlptokenizesyllableGraphN, b : NlptokenizesyllableGraphN) -> NlptokenizesyllableGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_syllable_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_syllable_graphn_copy(s : NlptokenizesyllableGraphN) -> NlptokenizesyllableGraphN {
  let result = nlp_tokenize_syllable_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_syllable_graphn_fill(s : NlptokenizesyllableGraphN, v : Double) -> NlptokenizesyllableGraphN {
  let result = nlp_tokenize_syllable_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_graphn_min(s : NlptokenizesyllableGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_graphn_max(s : NlptokenizesyllableGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_graphn_to_string(s : NlptokenizesyllableGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_node_make(size : Int) -> NlptokenizesyllableNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_node_len(s : NlptokenizesyllableNode) -> Int { s.size }

pub fn nlp_tokenize_syllable_node_get(s : NlptokenizesyllableNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_node_set(s : NlptokenizesyllableNode, i : Int, v : Double) -> NlptokenizesyllableNode {
  let result = nlp_tokenize_syllable_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_node_sum(s : NlptokenizesyllableNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_syllable_node_mean(s : NlptokenizesyllableNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_syllable_node_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_syllable_node_scale(s : NlptokenizesyllableNode, f : Double) -> NlptokenizesyllableNode {
  let result = nlp_tokenize_syllable_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_syllable_node_add(a : NlptokenizesyllableNode, b : NlptokenizesyllableNode) -> NlptokenizesyllableNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_syllable_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_syllable_node_copy(s : NlptokenizesyllableNode) -> NlptokenizesyllableNode {
  let result = nlp_tokenize_syllable_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_syllable_node_fill(s : NlptokenizesyllableNode, v : Double) -> NlptokenizesyllableNode {
  let result = nlp_tokenize_syllable_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_node_min(s : NlptokenizesyllableNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_node_max(s : NlptokenizesyllableNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_node_to_string(s : NlptokenizesyllableNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_edge_make(size : Int) -> NlptokenizesyllableEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_edge_len(s : NlptokenizesyllableEdge) -> Int { s.size }

pub fn nlp_tokenize_syllable_edge_get(s : NlptokenizesyllableEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_edge_set(s : NlptokenizesyllableEdge, i : Int, v : Double) -> NlptokenizesyllableEdge {
  let result = nlp_tokenize_syllable_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_edge_sum(s : NlptokenizesyllableEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_syllable_edge_mean(s : NlptokenizesyllableEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_syllable_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_syllable_edge_scale(s : NlptokenizesyllableEdge, f : Double) -> NlptokenizesyllableEdge {
  let result = nlp_tokenize_syllable_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_syllable_edge_add(a : NlptokenizesyllableEdge, b : NlptokenizesyllableEdge) -> NlptokenizesyllableEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_syllable_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_syllable_edge_copy(s : NlptokenizesyllableEdge) -> NlptokenizesyllableEdge {
  let result = nlp_tokenize_syllable_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_syllable_edge_fill(s : NlptokenizesyllableEdge, v : Double) -> NlptokenizesyllableEdge {
  let result = nlp_tokenize_syllable_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_edge_min(s : NlptokenizesyllableEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_edge_max(s : NlptokenizesyllableEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_edge_to_string(s : NlptokenizesyllableEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllablePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_path_make(size : Int) -> NlptokenizesyllablePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_path_len(s : NlptokenizesyllablePath) -> Int { s.size }

pub fn nlp_tokenize_syllable_path_get(s : NlptokenizesyllablePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_path_set(s : NlptokenizesyllablePath, i : Int, v : Double) -> NlptokenizesyllablePath {
  let result = nlp_tokenize_syllable_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_path_sum(s : NlptokenizesyllablePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_syllable_path_mean(s : NlptokenizesyllablePath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_syllable_path_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_syllable_path_scale(s : NlptokenizesyllablePath, f : Double) -> NlptokenizesyllablePath {
  let result = nlp_tokenize_syllable_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_syllable_path_add(a : NlptokenizesyllablePath, b : NlptokenizesyllablePath) -> NlptokenizesyllablePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_syllable_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_syllable_path_copy(s : NlptokenizesyllablePath) -> NlptokenizesyllablePath {
  let result = nlp_tokenize_syllable_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_syllable_path_fill(s : NlptokenizesyllablePath, v : Double) -> NlptokenizesyllablePath {
  let result = nlp_tokenize_syllable_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_path_min(s : NlptokenizesyllablePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_path_max(s : NlptokenizesyllablePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_path_to_string(s : NlptokenizesyllablePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_cluster_make(size : Int) -> NlptokenizesyllableCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_cluster_len(s : NlptokenizesyllableCluster) -> Int { s.size }

pub fn nlp_tokenize_syllable_cluster_get(s : NlptokenizesyllableCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_cluster_set(s : NlptokenizesyllableCluster, i : Int, v : Double) -> NlptokenizesyllableCluster {
  let result = nlp_tokenize_syllable_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_cluster_sum(s : NlptokenizesyllableCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_syllable_cluster_mean(s : NlptokenizesyllableCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_syllable_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_syllable_cluster_scale(s : NlptokenizesyllableCluster, f : Double) -> NlptokenizesyllableCluster {
  let result = nlp_tokenize_syllable_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_syllable_cluster_add(a : NlptokenizesyllableCluster, b : NlptokenizesyllableCluster) -> NlptokenizesyllableCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_syllable_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_syllable_cluster_copy(s : NlptokenizesyllableCluster) -> NlptokenizesyllableCluster {
  let result = nlp_tokenize_syllable_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_syllable_cluster_fill(s : NlptokenizesyllableCluster, v : Double) -> NlptokenizesyllableCluster {
  let result = nlp_tokenize_syllable_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_cluster_min(s : NlptokenizesyllableCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_cluster_max(s : NlptokenizesyllableCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_cluster_to_string(s : NlptokenizesyllableCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_model_make(size : Int) -> NlptokenizesyllableModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_model_len(s : NlptokenizesyllableModel) -> Int { s.size }

pub fn nlp_tokenize_syllable_model_get(s : NlptokenizesyllableModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_model_set(s : NlptokenizesyllableModel, i : Int, v : Double) -> NlptokenizesyllableModel {
  let result = nlp_tokenize_syllable_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_model_sum(s : NlptokenizesyllableModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_syllable_model_mean(s : NlptokenizesyllableModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_syllable_model_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_syllable_model_scale(s : NlptokenizesyllableModel, f : Double) -> NlptokenizesyllableModel {
  let result = nlp_tokenize_syllable_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_syllable_model_add(a : NlptokenizesyllableModel, b : NlptokenizesyllableModel) -> NlptokenizesyllableModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_syllable_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_syllable_model_copy(s : NlptokenizesyllableModel) -> NlptokenizesyllableModel {
  let result = nlp_tokenize_syllable_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_syllable_model_fill(s : NlptokenizesyllableModel, v : Double) -> NlptokenizesyllableModel {
  let result = nlp_tokenize_syllable_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_model_min(s : NlptokenizesyllableModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_model_max(s : NlptokenizesyllableModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_model_to_string(s : NlptokenizesyllableModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_layer_make(size : Int) -> NlptokenizesyllableLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_layer_len(s : NlptokenizesyllableLayer) -> Int { s.size }

pub fn nlp_tokenize_syllable_layer_get(s : NlptokenizesyllableLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_layer_set(s : NlptokenizesyllableLayer, i : Int, v : Double) -> NlptokenizesyllableLayer {
  let result = nlp_tokenize_syllable_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_layer_sum(s : NlptokenizesyllableLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_syllable_layer_mean(s : NlptokenizesyllableLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_syllable_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_syllable_layer_scale(s : NlptokenizesyllableLayer, f : Double) -> NlptokenizesyllableLayer {
  let result = nlp_tokenize_syllable_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_syllable_layer_add(a : NlptokenizesyllableLayer, b : NlptokenizesyllableLayer) -> NlptokenizesyllableLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_syllable_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_syllable_layer_copy(s : NlptokenizesyllableLayer) -> NlptokenizesyllableLayer {
  let result = nlp_tokenize_syllable_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_syllable_layer_fill(s : NlptokenizesyllableLayer, v : Double) -> NlptokenizesyllableLayer {
  let result = nlp_tokenize_syllable_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_layer_min(s : NlptokenizesyllableLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_layer_max(s : NlptokenizesyllableLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_layer_to_string(s : NlptokenizesyllableLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_buffer_make(size : Int) -> NlptokenizesyllableBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_buffer_len(s : NlptokenizesyllableBuffer) -> Int { s.size }

pub fn nlp_tokenize_syllable_buffer_get(s : NlptokenizesyllableBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_buffer_set(s : NlptokenizesyllableBuffer, i : Int, v : Double) -> NlptokenizesyllableBuffer {
  let result = nlp_tokenize_syllable_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_buffer_sum(s : NlptokenizesyllableBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_syllable_buffer_mean(s : NlptokenizesyllableBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_syllable_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_syllable_buffer_scale(s : NlptokenizesyllableBuffer, f : Double) -> NlptokenizesyllableBuffer {
  let result = nlp_tokenize_syllable_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_syllable_buffer_add(a : NlptokenizesyllableBuffer, b : NlptokenizesyllableBuffer) -> NlptokenizesyllableBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_syllable_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_syllable_buffer_copy(s : NlptokenizesyllableBuffer) -> NlptokenizesyllableBuffer {
  let result = nlp_tokenize_syllable_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_syllable_buffer_fill(s : NlptokenizesyllableBuffer, v : Double) -> NlptokenizesyllableBuffer {
  let result = nlp_tokenize_syllable_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_buffer_min(s : NlptokenizesyllableBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_buffer_max(s : NlptokenizesyllableBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_buffer_to_string(s : NlptokenizesyllableBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_cursor_make(size : Int) -> NlptokenizesyllableCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_cursor_len(s : NlptokenizesyllableCursor) -> Int { s.size }

pub fn nlp_tokenize_syllable_cursor_get(s : NlptokenizesyllableCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_cursor_set(s : NlptokenizesyllableCursor, i : Int, v : Double) -> NlptokenizesyllableCursor {
  let result = nlp_tokenize_syllable_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_cursor_sum(s : NlptokenizesyllableCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_syllable_cursor_mean(s : NlptokenizesyllableCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_syllable_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_syllable_cursor_scale(s : NlptokenizesyllableCursor, f : Double) -> NlptokenizesyllableCursor {
  let result = nlp_tokenize_syllable_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_syllable_cursor_add(a : NlptokenizesyllableCursor, b : NlptokenizesyllableCursor) -> NlptokenizesyllableCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_syllable_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_syllable_cursor_copy(s : NlptokenizesyllableCursor) -> NlptokenizesyllableCursor {
  let result = nlp_tokenize_syllable_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_syllable_cursor_fill(s : NlptokenizesyllableCursor, v : Double) -> NlptokenizesyllableCursor {
  let result = nlp_tokenize_syllable_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_cursor_min(s : NlptokenizesyllableCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_cursor_max(s : NlptokenizesyllableCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_cursor_to_string(s : NlptokenizesyllableCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_view_make(size : Int) -> NlptokenizesyllableView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_view_len(s : NlptokenizesyllableView) -> Int { s.size }

pub fn nlp_tokenize_syllable_view_get(s : NlptokenizesyllableView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_view_set(s : NlptokenizesyllableView, i : Int, v : Double) -> NlptokenizesyllableView {
  let result = nlp_tokenize_syllable_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_view_sum(s : NlptokenizesyllableView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_syllable_view_mean(s : NlptokenizesyllableView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_syllable_view_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_syllable_view_scale(s : NlptokenizesyllableView, f : Double) -> NlptokenizesyllableView {
  let result = nlp_tokenize_syllable_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_syllable_view_add(a : NlptokenizesyllableView, b : NlptokenizesyllableView) -> NlptokenizesyllableView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_syllable_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_syllable_view_copy(s : NlptokenizesyllableView) -> NlptokenizesyllableView {
  let result = nlp_tokenize_syllable_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_syllable_view_fill(s : NlptokenizesyllableView, v : Double) -> NlptokenizesyllableView {
  let result = nlp_tokenize_syllable_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_view_min(s : NlptokenizesyllableView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_view_max(s : NlptokenizesyllableView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_view_to_string(s : NlptokenizesyllableView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_range_make(size : Int) -> NlptokenizesyllableRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_range_len(s : NlptokenizesyllableRange) -> Int { s.size }

pub fn nlp_tokenize_syllable_range_get(s : NlptokenizesyllableRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_range_set(s : NlptokenizesyllableRange, i : Int, v : Double) -> NlptokenizesyllableRange {
  let result = nlp_tokenize_syllable_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_range_sum(s : NlptokenizesyllableRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_syllable_range_mean(s : NlptokenizesyllableRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_syllable_range_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_syllable_range_scale(s : NlptokenizesyllableRange, f : Double) -> NlptokenizesyllableRange {
  let result = nlp_tokenize_syllable_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_syllable_range_add(a : NlptokenizesyllableRange, b : NlptokenizesyllableRange) -> NlptokenizesyllableRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_syllable_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_syllable_range_copy(s : NlptokenizesyllableRange) -> NlptokenizesyllableRange {
  let result = nlp_tokenize_syllable_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_syllable_range_fill(s : NlptokenizesyllableRange, v : Double) -> NlptokenizesyllableRange {
  let result = nlp_tokenize_syllable_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_range_min(s : NlptokenizesyllableRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_range_max(s : NlptokenizesyllableRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_range_to_string(s : NlptokenizesyllableRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizesyllableSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_syllable_slice_make(size : Int) -> NlptokenizesyllableSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_syllable_slice_len(s : NlptokenizesyllableSlice) -> Int { s.size }

pub fn nlp_tokenize_syllable_slice_get(s : NlptokenizesyllableSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_syllable_slice_set(s : NlptokenizesyllableSlice, i : Int, v : Double) -> NlptokenizesyllableSlice {
  let result = nlp_tokenize_syllable_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_slice_sum(s : NlptokenizesyllableSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_syllable_slice_mean(s : NlptokenizesyllableSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_syllable_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_syllable_slice_scale(s : NlptokenizesyllableSlice, f : Double) -> NlptokenizesyllableSlice {
  let result = nlp_tokenize_syllable_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_syllable_slice_add(a : NlptokenizesyllableSlice, b : NlptokenizesyllableSlice) -> NlptokenizesyllableSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_syllable_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_syllable_slice_copy(s : NlptokenizesyllableSlice) -> NlptokenizesyllableSlice {
  let result = nlp_tokenize_syllable_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_syllable_slice_fill(s : NlptokenizesyllableSlice, v : Double) -> NlptokenizesyllableSlice {
  let result = nlp_tokenize_syllable_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_syllable_slice_min(s : NlptokenizesyllableSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_slice_max(s : NlptokenizesyllableSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_syllable_slice_to_string(s : NlptokenizesyllableSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

