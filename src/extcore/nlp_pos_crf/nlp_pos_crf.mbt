///===
/// extcore/nlp_pos_crf

pub(all) struct NlpposcrfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_crf_make_point(x : Double, y : Double) -> NlpposcrfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_crf_make_point3(x : Double, y : Double, z : Double) -> NlpposcrfPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_pos_crf_point_x(pt : NlpposcrfPoint) -> Double { pt.x }

pub fn nlp_pos_crf_point_y(pt : NlpposcrfPoint) -> Double { pt.y }

pub fn nlp_pos_crf_point_z(pt : NlpposcrfPoint) -> Double { pt.z }

pub fn nlp_pos_crf_point_label(pt : NlpposcrfPoint) -> Int { pt.label }

pub fn nlp_pos_crf_point_dist(a : NlpposcrfPoint, b : NlpposcrfPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_pos_crf_point_add(a : NlpposcrfPoint, b : NlpposcrfPoint) -> NlpposcrfPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_pos_crf_point_sub(a : NlpposcrfPoint, b : NlpposcrfPoint) -> NlpposcrfPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_pos_crf_point_scale(pt : NlpposcrfPoint, s : Double) -> NlpposcrfPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_pos_crf_point_dot(a : NlpposcrfPoint, b : NlpposcrfPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_pos_crf_point_cross(a : NlpposcrfPoint, b : NlpposcrfPoint) -> NlpposcrfPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_pos_crf_point_norm(pt : NlpposcrfPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_pos_crf_point_normalize(pt : NlpposcrfPoint) -> NlpposcrfPoint {
  let n = nlp_pos_crf_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_pos_crf_point_scale(pt, 1.0 / n) }
}

pub fn nlp_pos_crf_point_negate(pt : NlpposcrfPoint) -> NlpposcrfPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_pos_crf_point_mid(a : NlpposcrfPoint, b : NlpposcrfPoint) -> NlpposcrfPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_pos_crf_point_lerp(a : NlpposcrfPoint, b : NlpposcrfPoint, t : Double) -> NlpposcrfPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_pos_crf_point_to_string(pt : NlpposcrfPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpposcrfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_crf_make_series(vals : Array[Double], name : String) -> NlpposcrfSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_pos_crf_series_len(s : NlpposcrfSeries) -> Int { s.vals.length() }

pub fn nlp_pos_crf_series_sum(s : NlpposcrfSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_pos_crf_series_mean(s : NlpposcrfSeries) -> Double {
  let n = nlp_pos_crf_series_len(s)
  if n == 0 { 0.0 } else { nlp_pos_crf_series_sum(s) / n.to_double() }
}

pub fn nlp_pos_crf_series_min(s : NlpposcrfSeries) -> Double {
  let n = nlp_pos_crf_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_pos_crf_series_max(s : NlpposcrfSeries) -> Double {
  let n = nlp_pos_crf_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_pos_crf_series_range(s : NlpposcrfSeries) -> Double {
  nlp_pos_crf_series_max(s) - nlp_pos_crf_series_min(s)
}

pub fn nlp_pos_crf_series_var(s : NlpposcrfSeries) -> Double {
  let n = nlp_pos_crf_series_len(s)
  if n == 0 { 0.0 } else {
    let m = nlp_pos_crf_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn nlp_pos_crf_series_std(s : NlpposcrfSeries) -> Double { @_common.sqrt(nlp_pos_crf_series_var(s)) }

pub fn nlp_pos_crf_series_median(s : NlpposcrfSeries) -> Double {
  let n = nlp_pos_crf_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = nlp_pos_crf_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_pos_crf_series_scale(s : NlpposcrfSeries, f : Double) -> NlpposcrfSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_pos_crf_series_add(a : NlpposcrfSeries, b : NlpposcrfSeries) -> NlpposcrfSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_pos_crf_series_sub(a : NlpposcrfSeries, b : NlpposcrfSeries) -> NlpposcrfSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_pos_crf_series_normalize(s : NlpposcrfSeries) -> NlpposcrfSeries {
  let mn = nlp_pos_crf_series_min(s)
  let mx = nlp_pos_crf_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_pos_crf_series_cumsum(s : NlpposcrfSeries) -> NlpposcrfSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_pos_crf_series_to_string(s : NlpposcrfSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposcrfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_crf_make_matrix(rows : Int, cols : Int, val : Double) -> NlpposcrfMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_crf_matrix_identity(n : Int) -> NlpposcrfMatrix {
  let m = nlp_pos_crf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_pos_crf_matrix_get(m : NlpposcrfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_pos_crf_matrix_transpose(m : NlpposcrfMatrix) -> NlpposcrfMatrix {
  let result = nlp_pos_crf_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_pos_crf_matrix_add(a : NlpposcrfMatrix, b : NlpposcrfMatrix) -> NlpposcrfMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_pos_crf_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_pos_crf_matrix_scale(m : NlpposcrfMatrix, s : Double) -> NlpposcrfMatrix {
  let result = nlp_pos_crf_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_pos_crf_matrix_multiply(a : NlpposcrfMatrix, b : NlpposcrfMatrix) -> NlpposcrfMatrix {
  if a.cols != b.rows { return nlp_pos_crf_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_pos_crf_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_pos_crf_matrix_trace(m : NlpposcrfMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_pos_crf_matrix_det(m : NlpposcrfMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_pos_crf_matrix_norm(m : NlpposcrfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_pos_crf_matrix_to_string(m : NlpposcrfMatrix) -> String {
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

pub(all) struct NlpposcrfVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_crf_make_vector(comps : Array[Double]) -> NlpposcrfVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_crf_vector_zero(dim : Int) -> NlpposcrfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_pos_crf_vector_add(a : NlpposcrfVector, b : NlpposcrfVector) -> NlpposcrfVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_crf_vector_sub(a : NlpposcrfVector, b : NlpposcrfVector) -> NlpposcrfVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_crf_vector_scale(v : NlpposcrfVector, s : Double) -> NlpposcrfVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_pos_crf_vector_dot(a : NlpposcrfVector, b : NlpposcrfVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_pos_crf_vector_norm(v : NlpposcrfVector) -> Double { @_common.sqrt(nlp_pos_crf_vector_dot(v, v)) }

pub fn nlp_pos_crf_vector_normalize(v : NlpposcrfVector) -> NlpposcrfVector {
  let n = nlp_pos_crf_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_pos_crf_vector_scale(v, 1.0 / n) }
}

pub fn nlp_pos_crf_vector_dist(a : NlpposcrfVector, b : NlpposcrfVector) -> Double {
  nlp_pos_crf_vector_norm(nlp_pos_crf_vector_sub(a, b))
}

pub fn nlp_pos_crf_vector_to_string(v : NlpposcrfVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_crf_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_pos_crf_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_pos_crf_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_pos_crf_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_pos_crf_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_pos_crf_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_pos_crf_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_pos_crf_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_pos_crf_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_pos_crf_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_pos_crf_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_pos_crf_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_pos_crf_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_pos_crf_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_pos_crf_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_pos_crf_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_pos_crf_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_pos_crf_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_pos_crf_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_pos_crf_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_pos_crf_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_pos_crf_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_pos_crf_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_pos_crf_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_pos_crf_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_pos_crf_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_pos_crf_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_pos_crf_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_pos_crf_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpposcrfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_frame_make(size : Int) -> NlpposcrfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_frame_len(s : NlpposcrfFrame) -> Int { s.size }

pub fn nlp_pos_crf_frame_get(s : NlpposcrfFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_frame_set(s : NlpposcrfFrame, i : Int, v : Double) -> NlpposcrfFrame {
  let result = nlp_pos_crf_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_frame_sum(s : NlpposcrfFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_crf_frame_mean(s : NlpposcrfFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_crf_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_crf_frame_scale(s : NlpposcrfFrame, f : Double) -> NlpposcrfFrame {
  let result = nlp_pos_crf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_crf_frame_add(a : NlpposcrfFrame, b : NlpposcrfFrame) -> NlpposcrfFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_crf_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_crf_frame_copy(s : NlpposcrfFrame) -> NlpposcrfFrame {
  let result = nlp_pos_crf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_crf_frame_fill(s : NlpposcrfFrame, v : Double) -> NlpposcrfFrame {
  let result = nlp_pos_crf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_frame_min(s : NlpposcrfFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_frame_max(s : NlpposcrfFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_frame_to_string(s : NlpposcrfFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_table_make(size : Int) -> NlpposcrfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_table_len(s : NlpposcrfTable) -> Int { s.size }

pub fn nlp_pos_crf_table_get(s : NlpposcrfTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_table_set(s : NlpposcrfTable, i : Int, v : Double) -> NlpposcrfTable {
  let result = nlp_pos_crf_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_table_sum(s : NlpposcrfTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_crf_table_mean(s : NlpposcrfTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_crf_table_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_crf_table_scale(s : NlpposcrfTable, f : Double) -> NlpposcrfTable {
  let result = nlp_pos_crf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_crf_table_add(a : NlpposcrfTable, b : NlpposcrfTable) -> NlpposcrfTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_crf_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_crf_table_copy(s : NlpposcrfTable) -> NlpposcrfTable {
  let result = nlp_pos_crf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_crf_table_fill(s : NlpposcrfTable, v : Double) -> NlpposcrfTable {
  let result = nlp_pos_crf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_table_min(s : NlpposcrfTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_table_max(s : NlpposcrfTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_table_to_string(s : NlpposcrfTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_graphn_make(size : Int) -> NlpposcrfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_graphn_len(s : NlpposcrfGraphN) -> Int { s.size }

pub fn nlp_pos_crf_graphn_get(s : NlpposcrfGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_graphn_set(s : NlpposcrfGraphN, i : Int, v : Double) -> NlpposcrfGraphN {
  let result = nlp_pos_crf_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_graphn_sum(s : NlpposcrfGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_crf_graphn_mean(s : NlpposcrfGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_crf_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_crf_graphn_scale(s : NlpposcrfGraphN, f : Double) -> NlpposcrfGraphN {
  let result = nlp_pos_crf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_crf_graphn_add(a : NlpposcrfGraphN, b : NlpposcrfGraphN) -> NlpposcrfGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_crf_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_crf_graphn_copy(s : NlpposcrfGraphN) -> NlpposcrfGraphN {
  let result = nlp_pos_crf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_crf_graphn_fill(s : NlpposcrfGraphN, v : Double) -> NlpposcrfGraphN {
  let result = nlp_pos_crf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_graphn_min(s : NlpposcrfGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_graphn_max(s : NlpposcrfGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_graphn_to_string(s : NlpposcrfGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_node_make(size : Int) -> NlpposcrfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_node_len(s : NlpposcrfNode) -> Int { s.size }

pub fn nlp_pos_crf_node_get(s : NlpposcrfNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_node_set(s : NlpposcrfNode, i : Int, v : Double) -> NlpposcrfNode {
  let result = nlp_pos_crf_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_node_sum(s : NlpposcrfNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_crf_node_mean(s : NlpposcrfNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_crf_node_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_crf_node_scale(s : NlpposcrfNode, f : Double) -> NlpposcrfNode {
  let result = nlp_pos_crf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_crf_node_add(a : NlpposcrfNode, b : NlpposcrfNode) -> NlpposcrfNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_crf_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_crf_node_copy(s : NlpposcrfNode) -> NlpposcrfNode {
  let result = nlp_pos_crf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_crf_node_fill(s : NlpposcrfNode, v : Double) -> NlpposcrfNode {
  let result = nlp_pos_crf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_node_min(s : NlpposcrfNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_node_max(s : NlpposcrfNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_node_to_string(s : NlpposcrfNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_edge_make(size : Int) -> NlpposcrfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_edge_len(s : NlpposcrfEdge) -> Int { s.size }

pub fn nlp_pos_crf_edge_get(s : NlpposcrfEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_edge_set(s : NlpposcrfEdge, i : Int, v : Double) -> NlpposcrfEdge {
  let result = nlp_pos_crf_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_edge_sum(s : NlpposcrfEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_crf_edge_mean(s : NlpposcrfEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_crf_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_crf_edge_scale(s : NlpposcrfEdge, f : Double) -> NlpposcrfEdge {
  let result = nlp_pos_crf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_crf_edge_add(a : NlpposcrfEdge, b : NlpposcrfEdge) -> NlpposcrfEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_crf_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_crf_edge_copy(s : NlpposcrfEdge) -> NlpposcrfEdge {
  let result = nlp_pos_crf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_crf_edge_fill(s : NlpposcrfEdge, v : Double) -> NlpposcrfEdge {
  let result = nlp_pos_crf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_edge_min(s : NlpposcrfEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_edge_max(s : NlpposcrfEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_edge_to_string(s : NlpposcrfEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_path_make(size : Int) -> NlpposcrfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_path_len(s : NlpposcrfPath) -> Int { s.size }

pub fn nlp_pos_crf_path_get(s : NlpposcrfPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_path_set(s : NlpposcrfPath, i : Int, v : Double) -> NlpposcrfPath {
  let result = nlp_pos_crf_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_path_sum(s : NlpposcrfPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_crf_path_mean(s : NlpposcrfPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_crf_path_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_crf_path_scale(s : NlpposcrfPath, f : Double) -> NlpposcrfPath {
  let result = nlp_pos_crf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_crf_path_add(a : NlpposcrfPath, b : NlpposcrfPath) -> NlpposcrfPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_crf_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_crf_path_copy(s : NlpposcrfPath) -> NlpposcrfPath {
  let result = nlp_pos_crf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_crf_path_fill(s : NlpposcrfPath, v : Double) -> NlpposcrfPath {
  let result = nlp_pos_crf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_path_min(s : NlpposcrfPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_path_max(s : NlpposcrfPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_path_to_string(s : NlpposcrfPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_cluster_make(size : Int) -> NlpposcrfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_cluster_len(s : NlpposcrfCluster) -> Int { s.size }

pub fn nlp_pos_crf_cluster_get(s : NlpposcrfCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_cluster_set(s : NlpposcrfCluster, i : Int, v : Double) -> NlpposcrfCluster {
  let result = nlp_pos_crf_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_cluster_sum(s : NlpposcrfCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_crf_cluster_mean(s : NlpposcrfCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_crf_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_crf_cluster_scale(s : NlpposcrfCluster, f : Double) -> NlpposcrfCluster {
  let result = nlp_pos_crf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_crf_cluster_add(a : NlpposcrfCluster, b : NlpposcrfCluster) -> NlpposcrfCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_crf_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_crf_cluster_copy(s : NlpposcrfCluster) -> NlpposcrfCluster {
  let result = nlp_pos_crf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_crf_cluster_fill(s : NlpposcrfCluster, v : Double) -> NlpposcrfCluster {
  let result = nlp_pos_crf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_cluster_min(s : NlpposcrfCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_cluster_max(s : NlpposcrfCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_cluster_to_string(s : NlpposcrfCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_model_make(size : Int) -> NlpposcrfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_model_len(s : NlpposcrfModel) -> Int { s.size }

pub fn nlp_pos_crf_model_get(s : NlpposcrfModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_model_set(s : NlpposcrfModel, i : Int, v : Double) -> NlpposcrfModel {
  let result = nlp_pos_crf_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_model_sum(s : NlpposcrfModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_crf_model_mean(s : NlpposcrfModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_crf_model_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_crf_model_scale(s : NlpposcrfModel, f : Double) -> NlpposcrfModel {
  let result = nlp_pos_crf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_crf_model_add(a : NlpposcrfModel, b : NlpposcrfModel) -> NlpposcrfModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_crf_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_crf_model_copy(s : NlpposcrfModel) -> NlpposcrfModel {
  let result = nlp_pos_crf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_crf_model_fill(s : NlpposcrfModel, v : Double) -> NlpposcrfModel {
  let result = nlp_pos_crf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_model_min(s : NlpposcrfModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_model_max(s : NlpposcrfModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_model_to_string(s : NlpposcrfModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_layer_make(size : Int) -> NlpposcrfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_layer_len(s : NlpposcrfLayer) -> Int { s.size }

pub fn nlp_pos_crf_layer_get(s : NlpposcrfLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_layer_set(s : NlpposcrfLayer, i : Int, v : Double) -> NlpposcrfLayer {
  let result = nlp_pos_crf_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_layer_sum(s : NlpposcrfLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_crf_layer_mean(s : NlpposcrfLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_crf_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_crf_layer_scale(s : NlpposcrfLayer, f : Double) -> NlpposcrfLayer {
  let result = nlp_pos_crf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_crf_layer_add(a : NlpposcrfLayer, b : NlpposcrfLayer) -> NlpposcrfLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_crf_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_crf_layer_copy(s : NlpposcrfLayer) -> NlpposcrfLayer {
  let result = nlp_pos_crf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_crf_layer_fill(s : NlpposcrfLayer, v : Double) -> NlpposcrfLayer {
  let result = nlp_pos_crf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_layer_min(s : NlpposcrfLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_layer_max(s : NlpposcrfLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_layer_to_string(s : NlpposcrfLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_buffer_make(size : Int) -> NlpposcrfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_buffer_len(s : NlpposcrfBuffer) -> Int { s.size }

pub fn nlp_pos_crf_buffer_get(s : NlpposcrfBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_buffer_set(s : NlpposcrfBuffer, i : Int, v : Double) -> NlpposcrfBuffer {
  let result = nlp_pos_crf_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_buffer_sum(s : NlpposcrfBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_crf_buffer_mean(s : NlpposcrfBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_crf_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_crf_buffer_scale(s : NlpposcrfBuffer, f : Double) -> NlpposcrfBuffer {
  let result = nlp_pos_crf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_crf_buffer_add(a : NlpposcrfBuffer, b : NlpposcrfBuffer) -> NlpposcrfBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_crf_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_crf_buffer_copy(s : NlpposcrfBuffer) -> NlpposcrfBuffer {
  let result = nlp_pos_crf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_crf_buffer_fill(s : NlpposcrfBuffer, v : Double) -> NlpposcrfBuffer {
  let result = nlp_pos_crf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_buffer_min(s : NlpposcrfBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_buffer_max(s : NlpposcrfBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_buffer_to_string(s : NlpposcrfBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_cursor_make(size : Int) -> NlpposcrfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_cursor_len(s : NlpposcrfCursor) -> Int { s.size }

pub fn nlp_pos_crf_cursor_get(s : NlpposcrfCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_cursor_set(s : NlpposcrfCursor, i : Int, v : Double) -> NlpposcrfCursor {
  let result = nlp_pos_crf_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_cursor_sum(s : NlpposcrfCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_crf_cursor_mean(s : NlpposcrfCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_crf_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_crf_cursor_scale(s : NlpposcrfCursor, f : Double) -> NlpposcrfCursor {
  let result = nlp_pos_crf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_crf_cursor_add(a : NlpposcrfCursor, b : NlpposcrfCursor) -> NlpposcrfCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_crf_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_crf_cursor_copy(s : NlpposcrfCursor) -> NlpposcrfCursor {
  let result = nlp_pos_crf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_crf_cursor_fill(s : NlpposcrfCursor, v : Double) -> NlpposcrfCursor {
  let result = nlp_pos_crf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_cursor_min(s : NlpposcrfCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_cursor_max(s : NlpposcrfCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_cursor_to_string(s : NlpposcrfCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_view_make(size : Int) -> NlpposcrfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_view_len(s : NlpposcrfView) -> Int { s.size }

pub fn nlp_pos_crf_view_get(s : NlpposcrfView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_view_set(s : NlpposcrfView, i : Int, v : Double) -> NlpposcrfView {
  let result = nlp_pos_crf_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_view_sum(s : NlpposcrfView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_crf_view_mean(s : NlpposcrfView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_crf_view_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_crf_view_scale(s : NlpposcrfView, f : Double) -> NlpposcrfView {
  let result = nlp_pos_crf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_crf_view_add(a : NlpposcrfView, b : NlpposcrfView) -> NlpposcrfView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_crf_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_crf_view_copy(s : NlpposcrfView) -> NlpposcrfView {
  let result = nlp_pos_crf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_crf_view_fill(s : NlpposcrfView, v : Double) -> NlpposcrfView {
  let result = nlp_pos_crf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_view_min(s : NlpposcrfView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_view_max(s : NlpposcrfView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_view_to_string(s : NlpposcrfView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_range_make(size : Int) -> NlpposcrfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_range_len(s : NlpposcrfRange) -> Int { s.size }

pub fn nlp_pos_crf_range_get(s : NlpposcrfRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_range_set(s : NlpposcrfRange, i : Int, v : Double) -> NlpposcrfRange {
  let result = nlp_pos_crf_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_range_sum(s : NlpposcrfRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_crf_range_mean(s : NlpposcrfRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_crf_range_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_crf_range_scale(s : NlpposcrfRange, f : Double) -> NlpposcrfRange {
  let result = nlp_pos_crf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_crf_range_add(a : NlpposcrfRange, b : NlpposcrfRange) -> NlpposcrfRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_crf_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_crf_range_copy(s : NlpposcrfRange) -> NlpposcrfRange {
  let result = nlp_pos_crf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_crf_range_fill(s : NlpposcrfRange, v : Double) -> NlpposcrfRange {
  let result = nlp_pos_crf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_range_min(s : NlpposcrfRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_range_max(s : NlpposcrfRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_range_to_string(s : NlpposcrfRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_slice_make(size : Int) -> NlpposcrfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_slice_len(s : NlpposcrfSlice) -> Int { s.size }

pub fn nlp_pos_crf_slice_get(s : NlpposcrfSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_slice_set(s : NlpposcrfSlice, i : Int, v : Double) -> NlpposcrfSlice {
  let result = nlp_pos_crf_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_slice_sum(s : NlpposcrfSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_crf_slice_mean(s : NlpposcrfSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_crf_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_crf_slice_scale(s : NlpposcrfSlice, f : Double) -> NlpposcrfSlice {
  let result = nlp_pos_crf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_crf_slice_add(a : NlpposcrfSlice, b : NlpposcrfSlice) -> NlpposcrfSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_crf_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_crf_slice_copy(s : NlpposcrfSlice) -> NlpposcrfSlice {
  let result = nlp_pos_crf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_crf_slice_fill(s : NlpposcrfSlice, v : Double) -> NlpposcrfSlice {
  let result = nlp_pos_crf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_crf_slice_min(s : NlpposcrfSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_slice_max(s : NlpposcrfSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_crf_slice_to_string(s : NlpposcrfSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

