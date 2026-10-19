///===
/// extcore/nlp_tokenize_unigram

pub(all) struct NlptokenizeunigramPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_tokenize_unigram_make_point(x : Double, y : Double) -> NlptokenizeunigramPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_tokenize_unigram_make_point3(x : Double, y : Double, z : Double) -> NlptokenizeunigramPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_tokenize_unigram_point_x(pt : NlptokenizeunigramPoint) -> Double { pt.x }

pub fn nlp_tokenize_unigram_point_y(pt : NlptokenizeunigramPoint) -> Double { pt.y }

pub fn nlp_tokenize_unigram_point_z(pt : NlptokenizeunigramPoint) -> Double { pt.z }

pub fn nlp_tokenize_unigram_point_label(pt : NlptokenizeunigramPoint) -> Int { pt.label }

pub fn nlp_tokenize_unigram_point_dist(a : NlptokenizeunigramPoint, b : NlptokenizeunigramPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_tokenize_unigram_point_add(a : NlptokenizeunigramPoint, b : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_tokenize_unigram_point_sub(a : NlptokenizeunigramPoint, b : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_tokenize_unigram_point_scale(pt : NlptokenizeunigramPoint, s : Double) -> NlptokenizeunigramPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_tokenize_unigram_point_dot(a : NlptokenizeunigramPoint, b : NlptokenizeunigramPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_tokenize_unigram_point_cross(a : NlptokenizeunigramPoint, b : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_tokenize_unigram_point_norm(pt : NlptokenizeunigramPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_tokenize_unigram_point_normalize(pt : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  let n = nlp_tokenize_unigram_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_tokenize_unigram_point_scale(pt, 1.0 / n) }
}

pub fn nlp_tokenize_unigram_point_negate(pt : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_tokenize_unigram_point_mid(a : NlptokenizeunigramPoint, b : NlptokenizeunigramPoint) -> NlptokenizeunigramPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_tokenize_unigram_point_lerp(a : NlptokenizeunigramPoint, b : NlptokenizeunigramPoint, t : Double) -> NlptokenizeunigramPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_tokenize_unigram_point_to_string(pt : NlptokenizeunigramPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlptokenizeunigramSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_tokenize_unigram_make_series(vals : Array[Double], name : String) -> NlptokenizeunigramSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_tokenize_unigram_series_len(s : NlptokenizeunigramSeries) -> Int { s.vals.length() }

pub fn nlp_tokenize_unigram_series_sum(s : NlptokenizeunigramSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_tokenize_unigram_series_mean(s : NlptokenizeunigramSeries) -> Double {
  let n = nlp_tokenize_unigram_series_len(s)
  if n == 0 { 0.0 } else { nlp_tokenize_unigram_series_sum(s) / n.to_double() }
}

pub fn nlp_tokenize_unigram_series_min(s : NlptokenizeunigramSeries) -> Double {
  let n = nlp_tokenize_unigram_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_series_max(s : NlptokenizeunigramSeries) -> Double {
  let n = nlp_tokenize_unigram_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_series_range(s : NlptokenizeunigramSeries) -> Double {
  nlp_tokenize_unigram_series_max(s) - nlp_tokenize_unigram_series_min(s)
}

pub fn nlp_tokenize_unigram_series_var(s : NlptokenizeunigramSeries) -> Double {
  let n = nlp_tokenize_unigram_series_len(s)
  if n == 0 { 0.0 } else {
    let m = nlp_tokenize_unigram_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn nlp_tokenize_unigram_series_std(s : NlptokenizeunigramSeries) -> Double { @_common.sqrt(nlp_tokenize_unigram_series_var(s)) }

pub fn nlp_tokenize_unigram_series_median(s : NlptokenizeunigramSeries) -> Double {
  let n = nlp_tokenize_unigram_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = nlp_tokenize_unigram_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_tokenize_unigram_series_scale(s : NlptokenizeunigramSeries, f : Double) -> NlptokenizeunigramSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_tokenize_unigram_series_add(a : NlptokenizeunigramSeries, b : NlptokenizeunigramSeries) -> NlptokenizeunigramSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_unigram_series_sub(a : NlptokenizeunigramSeries, b : NlptokenizeunigramSeries) -> NlptokenizeunigramSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_tokenize_unigram_series_normalize(s : NlptokenizeunigramSeries) -> NlptokenizeunigramSeries {
  let mn = nlp_tokenize_unigram_series_min(s)
  let mx = nlp_tokenize_unigram_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_tokenize_unigram_series_cumsum(s : NlptokenizeunigramSeries) -> NlptokenizeunigramSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_tokenize_unigram_series_to_string(s : NlptokenizeunigramSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlptokenizeunigramMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_tokenize_unigram_make_matrix(rows : Int, cols : Int, val : Double) -> NlptokenizeunigramMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_tokenize_unigram_matrix_identity(n : Int) -> NlptokenizeunigramMatrix {
  let m = nlp_tokenize_unigram_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_tokenize_unigram_matrix_get(m : NlptokenizeunigramMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_tokenize_unigram_matrix_transpose(m : NlptokenizeunigramMatrix) -> NlptokenizeunigramMatrix {
  let result = nlp_tokenize_unigram_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_tokenize_unigram_matrix_add(a : NlptokenizeunigramMatrix, b : NlptokenizeunigramMatrix) -> NlptokenizeunigramMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_tokenize_unigram_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_tokenize_unigram_matrix_scale(m : NlptokenizeunigramMatrix, s : Double) -> NlptokenizeunigramMatrix {
  let result = nlp_tokenize_unigram_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_tokenize_unigram_matrix_multiply(a : NlptokenizeunigramMatrix, b : NlptokenizeunigramMatrix) -> NlptokenizeunigramMatrix {
  if a.cols != b.rows { return nlp_tokenize_unigram_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_tokenize_unigram_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_tokenize_unigram_matrix_trace(m : NlptokenizeunigramMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_tokenize_unigram_matrix_det(m : NlptokenizeunigramMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_tokenize_unigram_matrix_norm(m : NlptokenizeunigramMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_tokenize_unigram_matrix_to_string(m : NlptokenizeunigramMatrix) -> String {
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

pub(all) struct NlptokenizeunigramVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_tokenize_unigram_make_vector(comps : Array[Double]) -> NlptokenizeunigramVector {
  { comps, dim: comps.length() }
}

pub fn nlp_tokenize_unigram_vector_zero(dim : Int) -> NlptokenizeunigramVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_tokenize_unigram_vector_add(a : NlptokenizeunigramVector, b : NlptokenizeunigramVector) -> NlptokenizeunigramVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_tokenize_unigram_vector_sub(a : NlptokenizeunigramVector, b : NlptokenizeunigramVector) -> NlptokenizeunigramVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_tokenize_unigram_vector_scale(v : NlptokenizeunigramVector, s : Double) -> NlptokenizeunigramVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_tokenize_unigram_vector_dot(a : NlptokenizeunigramVector, b : NlptokenizeunigramVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_tokenize_unigram_vector_norm(v : NlptokenizeunigramVector) -> Double { @_common.sqrt(nlp_tokenize_unigram_vector_dot(v, v)) }

pub fn nlp_tokenize_unigram_vector_normalize(v : NlptokenizeunigramVector) -> NlptokenizeunigramVector {
  let n = nlp_tokenize_unigram_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_tokenize_unigram_vector_scale(v, 1.0 / n) }
}

pub fn nlp_tokenize_unigram_vector_dist(a : NlptokenizeunigramVector, b : NlptokenizeunigramVector) -> Double {
  nlp_tokenize_unigram_vector_norm(nlp_tokenize_unigram_vector_sub(a, b))
}

pub fn nlp_tokenize_unigram_vector_to_string(v : NlptokenizeunigramVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_tokenize_unigram_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_tokenize_unigram_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_tokenize_unigram_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_tokenize_unigram_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_tokenize_unigram_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_tokenize_unigram_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_tokenize_unigram_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_tokenize_unigram_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_tokenize_unigram_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_tokenize_unigram_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_tokenize_unigram_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_tokenize_unigram_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_tokenize_unigram_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_tokenize_unigram_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_tokenize_unigram_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_tokenize_unigram_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_tokenize_unigram_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_tokenize_unigram_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_tokenize_unigram_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_tokenize_unigram_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_tokenize_unigram_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_tokenize_unigram_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_tokenize_unigram_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_tokenize_unigram_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_tokenize_unigram_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_tokenize_unigram_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_tokenize_unigram_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_tokenize_unigram_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_tokenize_unigram_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlptokenizeunigramFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_frame_make(size : Int) -> NlptokenizeunigramFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_frame_len(s : NlptokenizeunigramFrame) -> Int { s.size }

pub fn nlp_tokenize_unigram_frame_get(s : NlptokenizeunigramFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_frame_set(s : NlptokenizeunigramFrame, i : Int, v : Double) -> NlptokenizeunigramFrame {
  let result = nlp_tokenize_unigram_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_frame_sum(s : NlptokenizeunigramFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_unigram_frame_mean(s : NlptokenizeunigramFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_unigram_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_unigram_frame_scale(s : NlptokenizeunigramFrame, f : Double) -> NlptokenizeunigramFrame {
  let result = nlp_tokenize_unigram_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_unigram_frame_add(a : NlptokenizeunigramFrame, b : NlptokenizeunigramFrame) -> NlptokenizeunigramFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_unigram_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_unigram_frame_copy(s : NlptokenizeunigramFrame) -> NlptokenizeunigramFrame {
  let result = nlp_tokenize_unigram_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_unigram_frame_fill(s : NlptokenizeunigramFrame, v : Double) -> NlptokenizeunigramFrame {
  let result = nlp_tokenize_unigram_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_frame_min(s : NlptokenizeunigramFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_frame_max(s : NlptokenizeunigramFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_frame_to_string(s : NlptokenizeunigramFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_table_make(size : Int) -> NlptokenizeunigramTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_table_len(s : NlptokenizeunigramTable) -> Int { s.size }

pub fn nlp_tokenize_unigram_table_get(s : NlptokenizeunigramTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_table_set(s : NlptokenizeunigramTable, i : Int, v : Double) -> NlptokenizeunigramTable {
  let result = nlp_tokenize_unigram_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_table_sum(s : NlptokenizeunigramTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_unigram_table_mean(s : NlptokenizeunigramTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_unigram_table_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_unigram_table_scale(s : NlptokenizeunigramTable, f : Double) -> NlptokenizeunigramTable {
  let result = nlp_tokenize_unigram_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_unigram_table_add(a : NlptokenizeunigramTable, b : NlptokenizeunigramTable) -> NlptokenizeunigramTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_unigram_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_unigram_table_copy(s : NlptokenizeunigramTable) -> NlptokenizeunigramTable {
  let result = nlp_tokenize_unigram_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_unigram_table_fill(s : NlptokenizeunigramTable, v : Double) -> NlptokenizeunigramTable {
  let result = nlp_tokenize_unigram_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_table_min(s : NlptokenizeunigramTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_table_max(s : NlptokenizeunigramTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_table_to_string(s : NlptokenizeunigramTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_graphn_make(size : Int) -> NlptokenizeunigramGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_graphn_len(s : NlptokenizeunigramGraphN) -> Int { s.size }

pub fn nlp_tokenize_unigram_graphn_get(s : NlptokenizeunigramGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_graphn_set(s : NlptokenizeunigramGraphN, i : Int, v : Double) -> NlptokenizeunigramGraphN {
  let result = nlp_tokenize_unigram_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_graphn_sum(s : NlptokenizeunigramGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_unigram_graphn_mean(s : NlptokenizeunigramGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_unigram_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_unigram_graphn_scale(s : NlptokenizeunigramGraphN, f : Double) -> NlptokenizeunigramGraphN {
  let result = nlp_tokenize_unigram_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_unigram_graphn_add(a : NlptokenizeunigramGraphN, b : NlptokenizeunigramGraphN) -> NlptokenizeunigramGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_unigram_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_unigram_graphn_copy(s : NlptokenizeunigramGraphN) -> NlptokenizeunigramGraphN {
  let result = nlp_tokenize_unigram_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_unigram_graphn_fill(s : NlptokenizeunigramGraphN, v : Double) -> NlptokenizeunigramGraphN {
  let result = nlp_tokenize_unigram_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_graphn_min(s : NlptokenizeunigramGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_graphn_max(s : NlptokenizeunigramGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_graphn_to_string(s : NlptokenizeunigramGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_node_make(size : Int) -> NlptokenizeunigramNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_node_len(s : NlptokenizeunigramNode) -> Int { s.size }

pub fn nlp_tokenize_unigram_node_get(s : NlptokenizeunigramNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_node_set(s : NlptokenizeunigramNode, i : Int, v : Double) -> NlptokenizeunigramNode {
  let result = nlp_tokenize_unigram_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_node_sum(s : NlptokenizeunigramNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_unigram_node_mean(s : NlptokenizeunigramNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_unigram_node_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_unigram_node_scale(s : NlptokenizeunigramNode, f : Double) -> NlptokenizeunigramNode {
  let result = nlp_tokenize_unigram_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_unigram_node_add(a : NlptokenizeunigramNode, b : NlptokenizeunigramNode) -> NlptokenizeunigramNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_unigram_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_unigram_node_copy(s : NlptokenizeunigramNode) -> NlptokenizeunigramNode {
  let result = nlp_tokenize_unigram_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_unigram_node_fill(s : NlptokenizeunigramNode, v : Double) -> NlptokenizeunigramNode {
  let result = nlp_tokenize_unigram_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_node_min(s : NlptokenizeunigramNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_node_max(s : NlptokenizeunigramNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_node_to_string(s : NlptokenizeunigramNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_edge_make(size : Int) -> NlptokenizeunigramEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_edge_len(s : NlptokenizeunigramEdge) -> Int { s.size }

pub fn nlp_tokenize_unigram_edge_get(s : NlptokenizeunigramEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_edge_set(s : NlptokenizeunigramEdge, i : Int, v : Double) -> NlptokenizeunigramEdge {
  let result = nlp_tokenize_unigram_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_edge_sum(s : NlptokenizeunigramEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_unigram_edge_mean(s : NlptokenizeunigramEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_unigram_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_unigram_edge_scale(s : NlptokenizeunigramEdge, f : Double) -> NlptokenizeunigramEdge {
  let result = nlp_tokenize_unigram_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_unigram_edge_add(a : NlptokenizeunigramEdge, b : NlptokenizeunigramEdge) -> NlptokenizeunigramEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_unigram_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_unigram_edge_copy(s : NlptokenizeunigramEdge) -> NlptokenizeunigramEdge {
  let result = nlp_tokenize_unigram_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_unigram_edge_fill(s : NlptokenizeunigramEdge, v : Double) -> NlptokenizeunigramEdge {
  let result = nlp_tokenize_unigram_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_edge_min(s : NlptokenizeunigramEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_edge_max(s : NlptokenizeunigramEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_edge_to_string(s : NlptokenizeunigramEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_path_make(size : Int) -> NlptokenizeunigramPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_path_len(s : NlptokenizeunigramPath) -> Int { s.size }

pub fn nlp_tokenize_unigram_path_get(s : NlptokenizeunigramPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_path_set(s : NlptokenizeunigramPath, i : Int, v : Double) -> NlptokenizeunigramPath {
  let result = nlp_tokenize_unigram_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_path_sum(s : NlptokenizeunigramPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_unigram_path_mean(s : NlptokenizeunigramPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_unigram_path_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_unigram_path_scale(s : NlptokenizeunigramPath, f : Double) -> NlptokenizeunigramPath {
  let result = nlp_tokenize_unigram_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_unigram_path_add(a : NlptokenizeunigramPath, b : NlptokenizeunigramPath) -> NlptokenizeunigramPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_unigram_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_unigram_path_copy(s : NlptokenizeunigramPath) -> NlptokenizeunigramPath {
  let result = nlp_tokenize_unigram_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_unigram_path_fill(s : NlptokenizeunigramPath, v : Double) -> NlptokenizeunigramPath {
  let result = nlp_tokenize_unigram_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_path_min(s : NlptokenizeunigramPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_path_max(s : NlptokenizeunigramPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_path_to_string(s : NlptokenizeunigramPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_cluster_make(size : Int) -> NlptokenizeunigramCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_cluster_len(s : NlptokenizeunigramCluster) -> Int { s.size }

pub fn nlp_tokenize_unigram_cluster_get(s : NlptokenizeunigramCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_cluster_set(s : NlptokenizeunigramCluster, i : Int, v : Double) -> NlptokenizeunigramCluster {
  let result = nlp_tokenize_unigram_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_cluster_sum(s : NlptokenizeunigramCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_unigram_cluster_mean(s : NlptokenizeunigramCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_unigram_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_unigram_cluster_scale(s : NlptokenizeunigramCluster, f : Double) -> NlptokenizeunigramCluster {
  let result = nlp_tokenize_unigram_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_unigram_cluster_add(a : NlptokenizeunigramCluster, b : NlptokenizeunigramCluster) -> NlptokenizeunigramCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_unigram_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_unigram_cluster_copy(s : NlptokenizeunigramCluster) -> NlptokenizeunigramCluster {
  let result = nlp_tokenize_unigram_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_unigram_cluster_fill(s : NlptokenizeunigramCluster, v : Double) -> NlptokenizeunigramCluster {
  let result = nlp_tokenize_unigram_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_cluster_min(s : NlptokenizeunigramCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_cluster_max(s : NlptokenizeunigramCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_cluster_to_string(s : NlptokenizeunigramCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_model_make(size : Int) -> NlptokenizeunigramModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_model_len(s : NlptokenizeunigramModel) -> Int { s.size }

pub fn nlp_tokenize_unigram_model_get(s : NlptokenizeunigramModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_model_set(s : NlptokenizeunigramModel, i : Int, v : Double) -> NlptokenizeunigramModel {
  let result = nlp_tokenize_unigram_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_model_sum(s : NlptokenizeunigramModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_unigram_model_mean(s : NlptokenizeunigramModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_unigram_model_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_unigram_model_scale(s : NlptokenizeunigramModel, f : Double) -> NlptokenizeunigramModel {
  let result = nlp_tokenize_unigram_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_unigram_model_add(a : NlptokenizeunigramModel, b : NlptokenizeunigramModel) -> NlptokenizeunigramModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_unigram_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_unigram_model_copy(s : NlptokenizeunigramModel) -> NlptokenizeunigramModel {
  let result = nlp_tokenize_unigram_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_unigram_model_fill(s : NlptokenizeunigramModel, v : Double) -> NlptokenizeunigramModel {
  let result = nlp_tokenize_unigram_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_model_min(s : NlptokenizeunigramModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_model_max(s : NlptokenizeunigramModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_model_to_string(s : NlptokenizeunigramModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_layer_make(size : Int) -> NlptokenizeunigramLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_layer_len(s : NlptokenizeunigramLayer) -> Int { s.size }

pub fn nlp_tokenize_unigram_layer_get(s : NlptokenizeunigramLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_layer_set(s : NlptokenizeunigramLayer, i : Int, v : Double) -> NlptokenizeunigramLayer {
  let result = nlp_tokenize_unigram_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_layer_sum(s : NlptokenizeunigramLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_unigram_layer_mean(s : NlptokenizeunigramLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_unigram_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_unigram_layer_scale(s : NlptokenizeunigramLayer, f : Double) -> NlptokenizeunigramLayer {
  let result = nlp_tokenize_unigram_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_unigram_layer_add(a : NlptokenizeunigramLayer, b : NlptokenizeunigramLayer) -> NlptokenizeunigramLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_unigram_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_unigram_layer_copy(s : NlptokenizeunigramLayer) -> NlptokenizeunigramLayer {
  let result = nlp_tokenize_unigram_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_unigram_layer_fill(s : NlptokenizeunigramLayer, v : Double) -> NlptokenizeunigramLayer {
  let result = nlp_tokenize_unigram_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_layer_min(s : NlptokenizeunigramLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_layer_max(s : NlptokenizeunigramLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_layer_to_string(s : NlptokenizeunigramLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_buffer_make(size : Int) -> NlptokenizeunigramBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_buffer_len(s : NlptokenizeunigramBuffer) -> Int { s.size }

pub fn nlp_tokenize_unigram_buffer_get(s : NlptokenizeunigramBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_buffer_set(s : NlptokenizeunigramBuffer, i : Int, v : Double) -> NlptokenizeunigramBuffer {
  let result = nlp_tokenize_unigram_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_buffer_sum(s : NlptokenizeunigramBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_unigram_buffer_mean(s : NlptokenizeunigramBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_unigram_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_unigram_buffer_scale(s : NlptokenizeunigramBuffer, f : Double) -> NlptokenizeunigramBuffer {
  let result = nlp_tokenize_unigram_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_unigram_buffer_add(a : NlptokenizeunigramBuffer, b : NlptokenizeunigramBuffer) -> NlptokenizeunigramBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_unigram_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_unigram_buffer_copy(s : NlptokenizeunigramBuffer) -> NlptokenizeunigramBuffer {
  let result = nlp_tokenize_unigram_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_unigram_buffer_fill(s : NlptokenizeunigramBuffer, v : Double) -> NlptokenizeunigramBuffer {
  let result = nlp_tokenize_unigram_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_buffer_min(s : NlptokenizeunigramBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_buffer_max(s : NlptokenizeunigramBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_buffer_to_string(s : NlptokenizeunigramBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_cursor_make(size : Int) -> NlptokenizeunigramCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_cursor_len(s : NlptokenizeunigramCursor) -> Int { s.size }

pub fn nlp_tokenize_unigram_cursor_get(s : NlptokenizeunigramCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_cursor_set(s : NlptokenizeunigramCursor, i : Int, v : Double) -> NlptokenizeunigramCursor {
  let result = nlp_tokenize_unigram_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_cursor_sum(s : NlptokenizeunigramCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_unigram_cursor_mean(s : NlptokenizeunigramCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_unigram_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_unigram_cursor_scale(s : NlptokenizeunigramCursor, f : Double) -> NlptokenizeunigramCursor {
  let result = nlp_tokenize_unigram_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_unigram_cursor_add(a : NlptokenizeunigramCursor, b : NlptokenizeunigramCursor) -> NlptokenizeunigramCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_unigram_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_unigram_cursor_copy(s : NlptokenizeunigramCursor) -> NlptokenizeunigramCursor {
  let result = nlp_tokenize_unigram_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_unigram_cursor_fill(s : NlptokenizeunigramCursor, v : Double) -> NlptokenizeunigramCursor {
  let result = nlp_tokenize_unigram_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_cursor_min(s : NlptokenizeunigramCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_cursor_max(s : NlptokenizeunigramCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_cursor_to_string(s : NlptokenizeunigramCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_view_make(size : Int) -> NlptokenizeunigramView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_view_len(s : NlptokenizeunigramView) -> Int { s.size }

pub fn nlp_tokenize_unigram_view_get(s : NlptokenizeunigramView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_view_set(s : NlptokenizeunigramView, i : Int, v : Double) -> NlptokenizeunigramView {
  let result = nlp_tokenize_unigram_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_view_sum(s : NlptokenizeunigramView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_unigram_view_mean(s : NlptokenizeunigramView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_unigram_view_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_unigram_view_scale(s : NlptokenizeunigramView, f : Double) -> NlptokenizeunigramView {
  let result = nlp_tokenize_unigram_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_unigram_view_add(a : NlptokenizeunigramView, b : NlptokenizeunigramView) -> NlptokenizeunigramView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_unigram_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_unigram_view_copy(s : NlptokenizeunigramView) -> NlptokenizeunigramView {
  let result = nlp_tokenize_unigram_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_unigram_view_fill(s : NlptokenizeunigramView, v : Double) -> NlptokenizeunigramView {
  let result = nlp_tokenize_unigram_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_view_min(s : NlptokenizeunigramView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_view_max(s : NlptokenizeunigramView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_view_to_string(s : NlptokenizeunigramView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_range_make(size : Int) -> NlptokenizeunigramRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_range_len(s : NlptokenizeunigramRange) -> Int { s.size }

pub fn nlp_tokenize_unigram_range_get(s : NlptokenizeunigramRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_range_set(s : NlptokenizeunigramRange, i : Int, v : Double) -> NlptokenizeunigramRange {
  let result = nlp_tokenize_unigram_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_range_sum(s : NlptokenizeunigramRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_unigram_range_mean(s : NlptokenizeunigramRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_unigram_range_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_unigram_range_scale(s : NlptokenizeunigramRange, f : Double) -> NlptokenizeunigramRange {
  let result = nlp_tokenize_unigram_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_unigram_range_add(a : NlptokenizeunigramRange, b : NlptokenizeunigramRange) -> NlptokenizeunigramRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_unigram_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_unigram_range_copy(s : NlptokenizeunigramRange) -> NlptokenizeunigramRange {
  let result = nlp_tokenize_unigram_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_unigram_range_fill(s : NlptokenizeunigramRange, v : Double) -> NlptokenizeunigramRange {
  let result = nlp_tokenize_unigram_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_range_min(s : NlptokenizeunigramRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_range_max(s : NlptokenizeunigramRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_range_to_string(s : NlptokenizeunigramRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlptokenizeunigramSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_tokenize_unigram_slice_make(size : Int) -> NlptokenizeunigramSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_tokenize_unigram_slice_len(s : NlptokenizeunigramSlice) -> Int { s.size }

pub fn nlp_tokenize_unigram_slice_get(s : NlptokenizeunigramSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_tokenize_unigram_slice_set(s : NlptokenizeunigramSlice, i : Int, v : Double) -> NlptokenizeunigramSlice {
  let result = nlp_tokenize_unigram_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_slice_sum(s : NlptokenizeunigramSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_tokenize_unigram_slice_mean(s : NlptokenizeunigramSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_tokenize_unigram_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_tokenize_unigram_slice_scale(s : NlptokenizeunigramSlice, f : Double) -> NlptokenizeunigramSlice {
  let result = nlp_tokenize_unigram_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_tokenize_unigram_slice_add(a : NlptokenizeunigramSlice, b : NlptokenizeunigramSlice) -> NlptokenizeunigramSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_tokenize_unigram_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_tokenize_unigram_slice_copy(s : NlptokenizeunigramSlice) -> NlptokenizeunigramSlice {
  let result = nlp_tokenize_unigram_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_tokenize_unigram_slice_fill(s : NlptokenizeunigramSlice, v : Double) -> NlptokenizeunigramSlice {
  let result = nlp_tokenize_unigram_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_tokenize_unigram_slice_min(s : NlptokenizeunigramSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_slice_max(s : NlptokenizeunigramSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_tokenize_unigram_slice_to_string(s : NlptokenizeunigramSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

