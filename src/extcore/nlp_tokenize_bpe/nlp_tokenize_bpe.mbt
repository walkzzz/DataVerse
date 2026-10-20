///===
/// extcore/nlp_tokenize_bpe

pub(all) struct NlptokenizebpePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_bpe_make_point(x : Double, y : Double) -> NlptokenizebpePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_bpe_make_point3(x : Double, y : Double, z : Double) -> NlptokenizebpePoint {
  { x, y, z, label: 0 }
}

pub fn nlp_tokenize_bpe_point_x(pt : NlptokenizebpePoint) -> Double { pt.x }

pub fn nlp_tokenize_bpe_point_y(pt : NlptokenizebpePoint) -> Double { pt.y }

pub fn nlp_tokenize_bpe_point_z(pt : NlptokenizebpePoint) -> Double { pt.z }

pub fn nlp_tokenize_bpe_point_label(pt : NlptokenizebpePoint) -> Int { pt.label }

pub fn nlp_tokenize_bpe_point_dist(a : NlptokenizebpePoint, b : NlptokenizebpePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_tokenize_bpe_point_add(a : NlptokenizebpePoint, b : NlptokenizebpePoint) -> NlptokenizebpePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_tokenize_bpe_point_sub(a : NlptokenizebpePoint, b : NlptokenizebpePoint) -> NlptokenizebpePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_tokenize_bpe_point_scale(pt : NlptokenizebpePoint, s : Double) -> NlptokenizebpePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_tokenize_bpe_point_dot(a : NlptokenizebpePoint, b : NlptokenizebpePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_tokenize_bpe_point_cross(a : NlptokenizebpePoint, b : NlptokenizebpePoint) -> NlptokenizebpePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_tokenize_bpe_point_norm(pt : NlptokenizebpePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_tokenize_bpe_point_normalize(pt : NlptokenizebpePoint) -> NlptokenizebpePoint {
  let n = nlp_tokenize_bpe_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_tokenize_bpe_point_scale(pt, 1.0 / n) }
}

pub fn nlp_tokenize_bpe_point_negate(pt : NlptokenizebpePoint) -> NlptokenizebpePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_tokenize_bpe_point_mid(a : NlptokenizebpePoint, b : NlptokenizebpePoint) -> NlptokenizebpePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_tokenize_bpe_point_lerp(a : NlptokenizebpePoint, b : NlptokenizebpePoint, t : Double) -> NlptokenizebpePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_tokenize_bpe_point_to_string(pt : NlptokenizebpePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlptokenizebpeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_bpe_make_series(vals : Array[Double], name : String) -> NlptokenizebpeSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_tokenize_bpe_series_len(s : NlptokenizebpeSeries) -> Int { s.vals.length() }

pub fn nlp_tokenize_bpe_series_sum(s : NlptokenizebpeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_tokenize_bpe_series_mean(s : NlptokenizebpeSeries) -> Double { @_common.mean(s.vals) }

pub fn nlp_tokenize_bpe_series_min(s : NlptokenizebpeSeries) -> Double { @_common.min(s.vals) }

pub fn nlp_tokenize_bpe_series_max(s : NlptokenizebpeSeries) -> Double { @_common.max(s.vals) }

pub fn nlp_tokenize_bpe_series_range(s : NlptokenizebpeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn nlp_tokenize_bpe_series_var(s : NlptokenizebpeSeries) -> Double { @_common.variance(s.vals) }

pub fn nlp_tokenize_bpe_series_std(s : NlptokenizebpeSeries) -> Double { @_common.std(s.vals) }

pub fn nlp_tokenize_bpe_series_median(s : NlptokenizebpeSeries) -> Double { @_common.median(s.vals) }

pub fn nlp_tokenize_bpe_series_scale(s : NlptokenizebpeSeries, f : Double) -> NlptokenizebpeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_tokenize_bpe_series_add(a : NlptokenizebpeSeries, b : NlptokenizebpeSeries) -> NlptokenizebpeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_bpe_series_sub(a : NlptokenizebpeSeries, b : NlptokenizebpeSeries) -> NlptokenizebpeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_bpe_series_normalize(s : NlptokenizebpeSeries) -> NlptokenizebpeSeries {
  let mn = nlp_tokenize_bpe_series_min(s)
  let mx = nlp_tokenize_bpe_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_tokenize_bpe_series_cumsum(s : NlptokenizebpeSeries) -> NlptokenizebpeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_tokenize_bpe_series_to_string(s : NlptokenizebpeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizebpeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_bpe_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizebpeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_bpe_matrix_identity(n : Int) -> NlptokenizebpeMatrix {
  let m = nlp_tokenize_bpe_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_tokenize_bpe_matrix_get(m : NlptokenizebpeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_tokenize_bpe_matrix_transpose(m : NlptokenizebpeMatrix) -> NlptokenizebpeMatrix {
  let result = nlp_tokenize_bpe_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_tokenize_bpe_matrix_add(a : NlptokenizebpeMatrix, b : NlptokenizebpeMatrix) -> NlptokenizebpeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_tokenize_bpe_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_tokenize_bpe_matrix_scale(m : NlptokenizebpeMatrix, s : Double) -> NlptokenizebpeMatrix {
  let result = nlp_tokenize_bpe_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_tokenize_bpe_matrix_multiply(a : NlptokenizebpeMatrix, b : NlptokenizebpeMatrix) -> NlptokenizebpeMatrix {
  if a.cols != b.rows { return nlp_tokenize_bpe_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_tokenize_bpe_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_tokenize_bpe_matrix_trace(m : NlptokenizebpeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_tokenize_bpe_matrix_det(m : NlptokenizebpeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_tokenize_bpe_matrix_norm(m : NlptokenizebpeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_tokenize_bpe_matrix_to_string(m : NlptokenizebpeMatrix) -> String {
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

pub(all) struct NlptokenizebpeVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_bpe_make_vector(comps : Array[Double]) -> NlptokenizebpeVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_bpe_vector_zero(dim : Int) -> NlptokenizebpeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_tokenize_bpe_vector_add(a : NlptokenizebpeVector, b : NlptokenizebpeVector) -> NlptokenizebpeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_tokenize_bpe_vector_sub(a : NlptokenizebpeVector, b : NlptokenizebpeVector) -> NlptokenizebpeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_tokenize_bpe_vector_scale(v : NlptokenizebpeVector, s : Double) -> NlptokenizebpeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_tokenize_bpe_vector_dot(a : NlptokenizebpeVector, b : NlptokenizebpeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_tokenize_bpe_vector_norm(v : NlptokenizebpeVector) -> Double { @_common.sqrt(nlp_tokenize_bpe_vector_dot(v, v)) }

pub fn nlp_tokenize_bpe_vector_normalize(v : NlptokenizebpeVector) -> NlptokenizebpeVector {
  let n = nlp_tokenize_bpe_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_tokenize_bpe_vector_scale(v, 1.0 / n) }
}

pub fn nlp_tokenize_bpe_vector_dist(a : NlptokenizebpeVector, b : NlptokenizebpeVector) -> Double {
  nlp_tokenize_bpe_vector_norm(nlp_tokenize_bpe_vector_sub(a, b))
}

pub fn nlp_tokenize_bpe_vector_to_string(v : NlptokenizebpeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_bpe_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_bpe_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_bpe_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_bpe_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_bpe_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_bpe_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_bpe_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_bpe_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_bpe_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_bpe_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_bpe_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_bpe_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_bpe_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_bpe_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_bpe_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_bpe_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_bpe_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_bpe_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_bpe_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_bpe_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_bpe_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_bpe_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_bpe_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_bpe_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_bpe_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_bpe_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_bpe_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_bpe_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_bpe_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizebpeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_frame_make(size : Int) -> NlptokenizebpeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_frame_len(s : NlptokenizebpeFrame) -> Int { s.size }

pub fn nlp_tokenize_bpe_frame_get(s : NlptokenizebpeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_frame_set(s : NlptokenizebpeFrame, i : Int, v : Double) -> NlptokenizebpeFrame {
  let result = nlp_tokenize_bpe_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_frame_sum(s : NlptokenizebpeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_bpe_frame_mean(s : NlptokenizebpeFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_bpe_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_bpe_frame_scale(s : NlptokenizebpeFrame, f : Double) -> NlptokenizebpeFrame {
  let result = nlp_tokenize_bpe_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_bpe_frame_add(a : NlptokenizebpeFrame, b : NlptokenizebpeFrame) -> NlptokenizebpeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_bpe_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_bpe_frame_copy(s : NlptokenizebpeFrame) -> NlptokenizebpeFrame {
  let result = nlp_tokenize_bpe_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_bpe_frame_fill(s : NlptokenizebpeFrame, v : Double) -> NlptokenizebpeFrame {
  let result = nlp_tokenize_bpe_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_frame_min(s : NlptokenizebpeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_frame_max(s : NlptokenizebpeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_frame_to_string(s : NlptokenizebpeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_table_make(size : Int) -> NlptokenizebpeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_table_len(s : NlptokenizebpeTable) -> Int { s.size }

pub fn nlp_tokenize_bpe_table_get(s : NlptokenizebpeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_table_set(s : NlptokenizebpeTable, i : Int, v : Double) -> NlptokenizebpeTable {
  let result = nlp_tokenize_bpe_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_table_sum(s : NlptokenizebpeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_bpe_table_mean(s : NlptokenizebpeTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_bpe_table_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_bpe_table_scale(s : NlptokenizebpeTable, f : Double) -> NlptokenizebpeTable {
  let result = nlp_tokenize_bpe_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_bpe_table_add(a : NlptokenizebpeTable, b : NlptokenizebpeTable) -> NlptokenizebpeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_bpe_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_bpe_table_copy(s : NlptokenizebpeTable) -> NlptokenizebpeTable {
  let result = nlp_tokenize_bpe_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_bpe_table_fill(s : NlptokenizebpeTable, v : Double) -> NlptokenizebpeTable {
  let result = nlp_tokenize_bpe_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_table_min(s : NlptokenizebpeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_table_max(s : NlptokenizebpeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_table_to_string(s : NlptokenizebpeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_graphn_make(size : Int) -> NlptokenizebpeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_graphn_len(s : NlptokenizebpeGraphN) -> Int { s.size }

pub fn nlp_tokenize_bpe_graphn_get(s : NlptokenizebpeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_graphn_set(s : NlptokenizebpeGraphN, i : Int, v : Double) -> NlptokenizebpeGraphN {
  let result = nlp_tokenize_bpe_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_graphn_sum(s : NlptokenizebpeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_bpe_graphn_mean(s : NlptokenizebpeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_bpe_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_bpe_graphn_scale(s : NlptokenizebpeGraphN, f : Double) -> NlptokenizebpeGraphN {
  let result = nlp_tokenize_bpe_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_bpe_graphn_add(a : NlptokenizebpeGraphN, b : NlptokenizebpeGraphN) -> NlptokenizebpeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_bpe_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_bpe_graphn_copy(s : NlptokenizebpeGraphN) -> NlptokenizebpeGraphN {
  let result = nlp_tokenize_bpe_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_bpe_graphn_fill(s : NlptokenizebpeGraphN, v : Double) -> NlptokenizebpeGraphN {
  let result = nlp_tokenize_bpe_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_graphn_min(s : NlptokenizebpeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_graphn_max(s : NlptokenizebpeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_graphn_to_string(s : NlptokenizebpeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_node_make(size : Int) -> NlptokenizebpeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_node_len(s : NlptokenizebpeNode) -> Int { s.size }

pub fn nlp_tokenize_bpe_node_get(s : NlptokenizebpeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_node_set(s : NlptokenizebpeNode, i : Int, v : Double) -> NlptokenizebpeNode {
  let result = nlp_tokenize_bpe_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_node_sum(s : NlptokenizebpeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_bpe_node_mean(s : NlptokenizebpeNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_bpe_node_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_bpe_node_scale(s : NlptokenizebpeNode, f : Double) -> NlptokenizebpeNode {
  let result = nlp_tokenize_bpe_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_bpe_node_add(a : NlptokenizebpeNode, b : NlptokenizebpeNode) -> NlptokenizebpeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_bpe_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_bpe_node_copy(s : NlptokenizebpeNode) -> NlptokenizebpeNode {
  let result = nlp_tokenize_bpe_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_bpe_node_fill(s : NlptokenizebpeNode, v : Double) -> NlptokenizebpeNode {
  let result = nlp_tokenize_bpe_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_node_min(s : NlptokenizebpeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_node_max(s : NlptokenizebpeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_node_to_string(s : NlptokenizebpeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_edge_make(size : Int) -> NlptokenizebpeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_edge_len(s : NlptokenizebpeEdge) -> Int { s.size }

pub fn nlp_tokenize_bpe_edge_get(s : NlptokenizebpeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_edge_set(s : NlptokenizebpeEdge, i : Int, v : Double) -> NlptokenizebpeEdge {
  let result = nlp_tokenize_bpe_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_edge_sum(s : NlptokenizebpeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_bpe_edge_mean(s : NlptokenizebpeEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_bpe_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_bpe_edge_scale(s : NlptokenizebpeEdge, f : Double) -> NlptokenizebpeEdge {
  let result = nlp_tokenize_bpe_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_bpe_edge_add(a : NlptokenizebpeEdge, b : NlptokenizebpeEdge) -> NlptokenizebpeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_bpe_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_bpe_edge_copy(s : NlptokenizebpeEdge) -> NlptokenizebpeEdge {
  let result = nlp_tokenize_bpe_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_bpe_edge_fill(s : NlptokenizebpeEdge, v : Double) -> NlptokenizebpeEdge {
  let result = nlp_tokenize_bpe_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_edge_min(s : NlptokenizebpeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_edge_max(s : NlptokenizebpeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_edge_to_string(s : NlptokenizebpeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_path_make(size : Int) -> NlptokenizebpePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_path_len(s : NlptokenizebpePath) -> Int { s.size }

pub fn nlp_tokenize_bpe_path_get(s : NlptokenizebpePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_path_set(s : NlptokenizebpePath, i : Int, v : Double) -> NlptokenizebpePath {
  let result = nlp_tokenize_bpe_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_path_sum(s : NlptokenizebpePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_bpe_path_mean(s : NlptokenizebpePath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_bpe_path_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_bpe_path_scale(s : NlptokenizebpePath, f : Double) -> NlptokenizebpePath {
  let result = nlp_tokenize_bpe_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_bpe_path_add(a : NlptokenizebpePath, b : NlptokenizebpePath) -> NlptokenizebpePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_bpe_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_bpe_path_copy(s : NlptokenizebpePath) -> NlptokenizebpePath {
  let result = nlp_tokenize_bpe_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_bpe_path_fill(s : NlptokenizebpePath, v : Double) -> NlptokenizebpePath {
  let result = nlp_tokenize_bpe_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_path_min(s : NlptokenizebpePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_path_max(s : NlptokenizebpePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_path_to_string(s : NlptokenizebpePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_cluster_make(size : Int) -> NlptokenizebpeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_cluster_len(s : NlptokenizebpeCluster) -> Int { s.size }

pub fn nlp_tokenize_bpe_cluster_get(s : NlptokenizebpeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_cluster_set(s : NlptokenizebpeCluster, i : Int, v : Double) -> NlptokenizebpeCluster {
  let result = nlp_tokenize_bpe_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_cluster_sum(s : NlptokenizebpeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_bpe_cluster_mean(s : NlptokenizebpeCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_bpe_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_bpe_cluster_scale(s : NlptokenizebpeCluster, f : Double) -> NlptokenizebpeCluster {
  let result = nlp_tokenize_bpe_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_bpe_cluster_add(a : NlptokenizebpeCluster, b : NlptokenizebpeCluster) -> NlptokenizebpeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_bpe_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_bpe_cluster_copy(s : NlptokenizebpeCluster) -> NlptokenizebpeCluster {
  let result = nlp_tokenize_bpe_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_bpe_cluster_fill(s : NlptokenizebpeCluster, v : Double) -> NlptokenizebpeCluster {
  let result = nlp_tokenize_bpe_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_cluster_min(s : NlptokenizebpeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_cluster_max(s : NlptokenizebpeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_cluster_to_string(s : NlptokenizebpeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_model_make(size : Int) -> NlptokenizebpeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_model_len(s : NlptokenizebpeModel) -> Int { s.size }

pub fn nlp_tokenize_bpe_model_get(s : NlptokenizebpeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_model_set(s : NlptokenizebpeModel, i : Int, v : Double) -> NlptokenizebpeModel {
  let result = nlp_tokenize_bpe_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_model_sum(s : NlptokenizebpeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_bpe_model_mean(s : NlptokenizebpeModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_bpe_model_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_bpe_model_scale(s : NlptokenizebpeModel, f : Double) -> NlptokenizebpeModel {
  let result = nlp_tokenize_bpe_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_bpe_model_add(a : NlptokenizebpeModel, b : NlptokenizebpeModel) -> NlptokenizebpeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_bpe_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_bpe_model_copy(s : NlptokenizebpeModel) -> NlptokenizebpeModel {
  let result = nlp_tokenize_bpe_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_bpe_model_fill(s : NlptokenizebpeModel, v : Double) -> NlptokenizebpeModel {
  let result = nlp_tokenize_bpe_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_model_min(s : NlptokenizebpeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_model_max(s : NlptokenizebpeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_model_to_string(s : NlptokenizebpeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_layer_make(size : Int) -> NlptokenizebpeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_layer_len(s : NlptokenizebpeLayer) -> Int { s.size }

pub fn nlp_tokenize_bpe_layer_get(s : NlptokenizebpeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_layer_set(s : NlptokenizebpeLayer, i : Int, v : Double) -> NlptokenizebpeLayer {
  let result = nlp_tokenize_bpe_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_layer_sum(s : NlptokenizebpeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_bpe_layer_mean(s : NlptokenizebpeLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_bpe_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_bpe_layer_scale(s : NlptokenizebpeLayer, f : Double) -> NlptokenizebpeLayer {
  let result = nlp_tokenize_bpe_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_bpe_layer_add(a : NlptokenizebpeLayer, b : NlptokenizebpeLayer) -> NlptokenizebpeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_bpe_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_bpe_layer_copy(s : NlptokenizebpeLayer) -> NlptokenizebpeLayer {
  let result = nlp_tokenize_bpe_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_bpe_layer_fill(s : NlptokenizebpeLayer, v : Double) -> NlptokenizebpeLayer {
  let result = nlp_tokenize_bpe_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_layer_min(s : NlptokenizebpeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_layer_max(s : NlptokenizebpeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_layer_to_string(s : NlptokenizebpeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_buffer_make(size : Int) -> NlptokenizebpeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_buffer_len(s : NlptokenizebpeBuffer) -> Int { s.size }

pub fn nlp_tokenize_bpe_buffer_get(s : NlptokenizebpeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_buffer_set(s : NlptokenizebpeBuffer, i : Int, v : Double) -> NlptokenizebpeBuffer {
  let result = nlp_tokenize_bpe_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_buffer_sum(s : NlptokenizebpeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_bpe_buffer_mean(s : NlptokenizebpeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_bpe_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_bpe_buffer_scale(s : NlptokenizebpeBuffer, f : Double) -> NlptokenizebpeBuffer {
  let result = nlp_tokenize_bpe_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_bpe_buffer_add(a : NlptokenizebpeBuffer, b : NlptokenizebpeBuffer) -> NlptokenizebpeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_bpe_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_bpe_buffer_copy(s : NlptokenizebpeBuffer) -> NlptokenizebpeBuffer {
  let result = nlp_tokenize_bpe_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_bpe_buffer_fill(s : NlptokenizebpeBuffer, v : Double) -> NlptokenizebpeBuffer {
  let result = nlp_tokenize_bpe_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_buffer_min(s : NlptokenizebpeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_buffer_max(s : NlptokenizebpeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_buffer_to_string(s : NlptokenizebpeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_cursor_make(size : Int) -> NlptokenizebpeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_cursor_len(s : NlptokenizebpeCursor) -> Int { s.size }

pub fn nlp_tokenize_bpe_cursor_get(s : NlptokenizebpeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_cursor_set(s : NlptokenizebpeCursor, i : Int, v : Double) -> NlptokenizebpeCursor {
  let result = nlp_tokenize_bpe_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_cursor_sum(s : NlptokenizebpeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_bpe_cursor_mean(s : NlptokenizebpeCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_bpe_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_bpe_cursor_scale(s : NlptokenizebpeCursor, f : Double) -> NlptokenizebpeCursor {
  let result = nlp_tokenize_bpe_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_bpe_cursor_add(a : NlptokenizebpeCursor, b : NlptokenizebpeCursor) -> NlptokenizebpeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_bpe_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_bpe_cursor_copy(s : NlptokenizebpeCursor) -> NlptokenizebpeCursor {
  let result = nlp_tokenize_bpe_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_bpe_cursor_fill(s : NlptokenizebpeCursor, v : Double) -> NlptokenizebpeCursor {
  let result = nlp_tokenize_bpe_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_cursor_min(s : NlptokenizebpeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_cursor_max(s : NlptokenizebpeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_cursor_to_string(s : NlptokenizebpeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_view_make(size : Int) -> NlptokenizebpeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_view_len(s : NlptokenizebpeView) -> Int { s.size }

pub fn nlp_tokenize_bpe_view_get(s : NlptokenizebpeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_view_set(s : NlptokenizebpeView, i : Int, v : Double) -> NlptokenizebpeView {
  let result = nlp_tokenize_bpe_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_view_sum(s : NlptokenizebpeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_bpe_view_mean(s : NlptokenizebpeView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_bpe_view_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_bpe_view_scale(s : NlptokenizebpeView, f : Double) -> NlptokenizebpeView {
  let result = nlp_tokenize_bpe_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_bpe_view_add(a : NlptokenizebpeView, b : NlptokenizebpeView) -> NlptokenizebpeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_bpe_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_bpe_view_copy(s : NlptokenizebpeView) -> NlptokenizebpeView {
  let result = nlp_tokenize_bpe_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_bpe_view_fill(s : NlptokenizebpeView, v : Double) -> NlptokenizebpeView {
  let result = nlp_tokenize_bpe_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_view_min(s : NlptokenizebpeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_view_max(s : NlptokenizebpeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_view_to_string(s : NlptokenizebpeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_range_make(size : Int) -> NlptokenizebpeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_range_len(s : NlptokenizebpeRange) -> Int { s.size }

pub fn nlp_tokenize_bpe_range_get(s : NlptokenizebpeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_range_set(s : NlptokenizebpeRange, i : Int, v : Double) -> NlptokenizebpeRange {
  let result = nlp_tokenize_bpe_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_range_sum(s : NlptokenizebpeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_bpe_range_mean(s : NlptokenizebpeRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_bpe_range_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_bpe_range_scale(s : NlptokenizebpeRange, f : Double) -> NlptokenizebpeRange {
  let result = nlp_tokenize_bpe_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_bpe_range_add(a : NlptokenizebpeRange, b : NlptokenizebpeRange) -> NlptokenizebpeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_bpe_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_bpe_range_copy(s : NlptokenizebpeRange) -> NlptokenizebpeRange {
  let result = nlp_tokenize_bpe_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_bpe_range_fill(s : NlptokenizebpeRange, v : Double) -> NlptokenizebpeRange {
  let result = nlp_tokenize_bpe_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_range_min(s : NlptokenizebpeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_range_max(s : NlptokenizebpeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_range_to_string(s : NlptokenizebpeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizebpeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_bpe_slice_make(size : Int) -> NlptokenizebpeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_bpe_slice_len(s : NlptokenizebpeSlice) -> Int { s.size }

pub fn nlp_tokenize_bpe_slice_get(s : NlptokenizebpeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_bpe_slice_set(s : NlptokenizebpeSlice, i : Int, v : Double) -> NlptokenizebpeSlice {
  let result = nlp_tokenize_bpe_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_slice_sum(s : NlptokenizebpeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_bpe_slice_mean(s : NlptokenizebpeSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_bpe_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_bpe_slice_scale(s : NlptokenizebpeSlice, f : Double) -> NlptokenizebpeSlice {
  let result = nlp_tokenize_bpe_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_bpe_slice_add(a : NlptokenizebpeSlice, b : NlptokenizebpeSlice) -> NlptokenizebpeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_bpe_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_bpe_slice_copy(s : NlptokenizebpeSlice) -> NlptokenizebpeSlice {
  let result = nlp_tokenize_bpe_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_bpe_slice_fill(s : NlptokenizebpeSlice, v : Double) -> NlptokenizebpeSlice {
  let result = nlp_tokenize_bpe_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_bpe_slice_min(s : NlptokenizebpeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_slice_max(s : NlptokenizebpeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_bpe_slice_to_string(s : NlptokenizebpeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

