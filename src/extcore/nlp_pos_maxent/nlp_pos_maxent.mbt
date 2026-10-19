///===
/// extcore/nlp_pos_maxent

pub(all) struct NlpposmaxentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_maxent_make_point(x : Double, y : Double) -> NlpposmaxentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_maxent_make_point3(x : Double, y : Double, z : Double) -> NlpposmaxentPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_pos_maxent_point_x(pt : NlpposmaxentPoint) -> Double { pt.x }

pub fn nlp_pos_maxent_point_y(pt : NlpposmaxentPoint) -> Double { pt.y }

pub fn nlp_pos_maxent_point_z(pt : NlpposmaxentPoint) -> Double { pt.z }

pub fn nlp_pos_maxent_point_label(pt : NlpposmaxentPoint) -> Int { pt.label }

pub fn nlp_pos_maxent_point_dist(a : NlpposmaxentPoint, b : NlpposmaxentPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_pos_maxent_point_add(a : NlpposmaxentPoint, b : NlpposmaxentPoint) -> NlpposmaxentPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_pos_maxent_point_sub(a : NlpposmaxentPoint, b : NlpposmaxentPoint) -> NlpposmaxentPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_pos_maxent_point_scale(pt : NlpposmaxentPoint, s : Double) -> NlpposmaxentPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_pos_maxent_point_dot(a : NlpposmaxentPoint, b : NlpposmaxentPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_pos_maxent_point_cross(a : NlpposmaxentPoint, b : NlpposmaxentPoint) -> NlpposmaxentPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_pos_maxent_point_norm(pt : NlpposmaxentPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_pos_maxent_point_normalize(pt : NlpposmaxentPoint) -> NlpposmaxentPoint {
  let n = nlp_pos_maxent_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_pos_maxent_point_scale(pt, 1.0 / n) }
}

pub fn nlp_pos_maxent_point_negate(pt : NlpposmaxentPoint) -> NlpposmaxentPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_pos_maxent_point_mid(a : NlpposmaxentPoint, b : NlpposmaxentPoint) -> NlpposmaxentPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_pos_maxent_point_lerp(a : NlpposmaxentPoint, b : NlpposmaxentPoint, t : Double) -> NlpposmaxentPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_pos_maxent_point_to_string(pt : NlpposmaxentPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpposmaxentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_maxent_make_series(vals : Array[Double], name : String) -> NlpposmaxentSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_pos_maxent_series_len(s : NlpposmaxentSeries) -> Int { s.vals.length() }

pub fn nlp_pos_maxent_series_sum(s : NlpposmaxentSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_pos_maxent_series_mean(s : NlpposmaxentSeries) -> Double {
  let n = nlp_pos_maxent_series_len(s)
  if n == 0 { 0.0 } else { nlp_pos_maxent_series_sum(s) / n.to_double() }
}

pub fn nlp_pos_maxent_series_min(s : NlpposmaxentSeries) -> Double {
  let n = nlp_pos_maxent_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_pos_maxent_series_max(s : NlpposmaxentSeries) -> Double {
  let n = nlp_pos_maxent_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_pos_maxent_series_range(s : NlpposmaxentSeries) -> Double {
  nlp_pos_maxent_series_max(s) - nlp_pos_maxent_series_min(s)
}

pub fn nlp_pos_maxent_series_var(s : NlpposmaxentSeries) -> Double {
  let n = nlp_pos_maxent_series_len(s)
  if n == 0 { 0.0 } else {
    let m = nlp_pos_maxent_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn nlp_pos_maxent_series_std(s : NlpposmaxentSeries) -> Double { @_common.sqrt(nlp_pos_maxent_series_var(s)) }

pub fn nlp_pos_maxent_series_median(s : NlpposmaxentSeries) -> Double {
  let n = nlp_pos_maxent_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = nlp_pos_maxent_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_pos_maxent_series_scale(s : NlpposmaxentSeries, f : Double) -> NlpposmaxentSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_pos_maxent_series_add(a : NlpposmaxentSeries, b : NlpposmaxentSeries) -> NlpposmaxentSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_pos_maxent_series_sub(a : NlpposmaxentSeries, b : NlpposmaxentSeries) -> NlpposmaxentSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_pos_maxent_series_normalize(s : NlpposmaxentSeries) -> NlpposmaxentSeries {
  let mn = nlp_pos_maxent_series_min(s)
  let mx = nlp_pos_maxent_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_pos_maxent_series_cumsum(s : NlpposmaxentSeries) -> NlpposmaxentSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_pos_maxent_series_to_string(s : NlpposmaxentSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposmaxentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_maxent_make_matrix(rows : Int, cols : Int, val : Double) -> NlpposmaxentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_maxent_matrix_identity(n : Int) -> NlpposmaxentMatrix {
  let m = nlp_pos_maxent_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_pos_maxent_matrix_get(m : NlpposmaxentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_pos_maxent_matrix_transpose(m : NlpposmaxentMatrix) -> NlpposmaxentMatrix {
  let result = nlp_pos_maxent_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_pos_maxent_matrix_add(a : NlpposmaxentMatrix, b : NlpposmaxentMatrix) -> NlpposmaxentMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_pos_maxent_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_pos_maxent_matrix_scale(m : NlpposmaxentMatrix, s : Double) -> NlpposmaxentMatrix {
  let result = nlp_pos_maxent_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_pos_maxent_matrix_multiply(a : NlpposmaxentMatrix, b : NlpposmaxentMatrix) -> NlpposmaxentMatrix {
  if a.cols != b.rows { return nlp_pos_maxent_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_pos_maxent_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_pos_maxent_matrix_trace(m : NlpposmaxentMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_pos_maxent_matrix_det(m : NlpposmaxentMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_pos_maxent_matrix_norm(m : NlpposmaxentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_pos_maxent_matrix_to_string(m : NlpposmaxentMatrix) -> String {
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

pub(all) struct NlpposmaxentVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_maxent_make_vector(comps : Array[Double]) -> NlpposmaxentVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_maxent_vector_zero(dim : Int) -> NlpposmaxentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_pos_maxent_vector_add(a : NlpposmaxentVector, b : NlpposmaxentVector) -> NlpposmaxentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_maxent_vector_sub(a : NlpposmaxentVector, b : NlpposmaxentVector) -> NlpposmaxentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_maxent_vector_scale(v : NlpposmaxentVector, s : Double) -> NlpposmaxentVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_pos_maxent_vector_dot(a : NlpposmaxentVector, b : NlpposmaxentVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_pos_maxent_vector_norm(v : NlpposmaxentVector) -> Double { @_common.sqrt(nlp_pos_maxent_vector_dot(v, v)) }

pub fn nlp_pos_maxent_vector_normalize(v : NlpposmaxentVector) -> NlpposmaxentVector {
  let n = nlp_pos_maxent_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_pos_maxent_vector_scale(v, 1.0 / n) }
}

pub fn nlp_pos_maxent_vector_dist(a : NlpposmaxentVector, b : NlpposmaxentVector) -> Double {
  nlp_pos_maxent_vector_norm(nlp_pos_maxent_vector_sub(a, b))
}

pub fn nlp_pos_maxent_vector_to_string(v : NlpposmaxentVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_maxent_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_pos_maxent_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_pos_maxent_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_pos_maxent_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_pos_maxent_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_pos_maxent_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_pos_maxent_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_pos_maxent_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_pos_maxent_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_pos_maxent_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_pos_maxent_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_pos_maxent_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_pos_maxent_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_pos_maxent_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_pos_maxent_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_pos_maxent_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_pos_maxent_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_pos_maxent_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_pos_maxent_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_pos_maxent_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_pos_maxent_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_pos_maxent_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_pos_maxent_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_pos_maxent_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_pos_maxent_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_pos_maxent_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_pos_maxent_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_pos_maxent_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_pos_maxent_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpposmaxentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_frame_make(size : Int) -> NlpposmaxentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_frame_len(s : NlpposmaxentFrame) -> Int { s.size }

pub fn nlp_pos_maxent_frame_get(s : NlpposmaxentFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_frame_set(s : NlpposmaxentFrame, i : Int, v : Double) -> NlpposmaxentFrame {
  let result = nlp_pos_maxent_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_frame_sum(s : NlpposmaxentFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_maxent_frame_mean(s : NlpposmaxentFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_maxent_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_maxent_frame_scale(s : NlpposmaxentFrame, f : Double) -> NlpposmaxentFrame {
  let result = nlp_pos_maxent_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_maxent_frame_add(a : NlpposmaxentFrame, b : NlpposmaxentFrame) -> NlpposmaxentFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_maxent_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_maxent_frame_copy(s : NlpposmaxentFrame) -> NlpposmaxentFrame {
  let result = nlp_pos_maxent_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_maxent_frame_fill(s : NlpposmaxentFrame, v : Double) -> NlpposmaxentFrame {
  let result = nlp_pos_maxent_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_frame_min(s : NlpposmaxentFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_frame_max(s : NlpposmaxentFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_frame_to_string(s : NlpposmaxentFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_table_make(size : Int) -> NlpposmaxentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_table_len(s : NlpposmaxentTable) -> Int { s.size }

pub fn nlp_pos_maxent_table_get(s : NlpposmaxentTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_table_set(s : NlpposmaxentTable, i : Int, v : Double) -> NlpposmaxentTable {
  let result = nlp_pos_maxent_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_table_sum(s : NlpposmaxentTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_maxent_table_mean(s : NlpposmaxentTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_maxent_table_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_maxent_table_scale(s : NlpposmaxentTable, f : Double) -> NlpposmaxentTable {
  let result = nlp_pos_maxent_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_maxent_table_add(a : NlpposmaxentTable, b : NlpposmaxentTable) -> NlpposmaxentTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_maxent_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_maxent_table_copy(s : NlpposmaxentTable) -> NlpposmaxentTable {
  let result = nlp_pos_maxent_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_maxent_table_fill(s : NlpposmaxentTable, v : Double) -> NlpposmaxentTable {
  let result = nlp_pos_maxent_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_table_min(s : NlpposmaxentTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_table_max(s : NlpposmaxentTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_table_to_string(s : NlpposmaxentTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_graphn_make(size : Int) -> NlpposmaxentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_graphn_len(s : NlpposmaxentGraphN) -> Int { s.size }

pub fn nlp_pos_maxent_graphn_get(s : NlpposmaxentGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_graphn_set(s : NlpposmaxentGraphN, i : Int, v : Double) -> NlpposmaxentGraphN {
  let result = nlp_pos_maxent_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_graphn_sum(s : NlpposmaxentGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_maxent_graphn_mean(s : NlpposmaxentGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_maxent_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_maxent_graphn_scale(s : NlpposmaxentGraphN, f : Double) -> NlpposmaxentGraphN {
  let result = nlp_pos_maxent_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_maxent_graphn_add(a : NlpposmaxentGraphN, b : NlpposmaxentGraphN) -> NlpposmaxentGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_maxent_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_maxent_graphn_copy(s : NlpposmaxentGraphN) -> NlpposmaxentGraphN {
  let result = nlp_pos_maxent_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_maxent_graphn_fill(s : NlpposmaxentGraphN, v : Double) -> NlpposmaxentGraphN {
  let result = nlp_pos_maxent_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_graphn_min(s : NlpposmaxentGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_graphn_max(s : NlpposmaxentGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_graphn_to_string(s : NlpposmaxentGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_node_make(size : Int) -> NlpposmaxentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_node_len(s : NlpposmaxentNode) -> Int { s.size }

pub fn nlp_pos_maxent_node_get(s : NlpposmaxentNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_node_set(s : NlpposmaxentNode, i : Int, v : Double) -> NlpposmaxentNode {
  let result = nlp_pos_maxent_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_node_sum(s : NlpposmaxentNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_maxent_node_mean(s : NlpposmaxentNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_maxent_node_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_maxent_node_scale(s : NlpposmaxentNode, f : Double) -> NlpposmaxentNode {
  let result = nlp_pos_maxent_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_maxent_node_add(a : NlpposmaxentNode, b : NlpposmaxentNode) -> NlpposmaxentNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_maxent_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_maxent_node_copy(s : NlpposmaxentNode) -> NlpposmaxentNode {
  let result = nlp_pos_maxent_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_maxent_node_fill(s : NlpposmaxentNode, v : Double) -> NlpposmaxentNode {
  let result = nlp_pos_maxent_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_node_min(s : NlpposmaxentNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_node_max(s : NlpposmaxentNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_node_to_string(s : NlpposmaxentNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_edge_make(size : Int) -> NlpposmaxentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_edge_len(s : NlpposmaxentEdge) -> Int { s.size }

pub fn nlp_pos_maxent_edge_get(s : NlpposmaxentEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_edge_set(s : NlpposmaxentEdge, i : Int, v : Double) -> NlpposmaxentEdge {
  let result = nlp_pos_maxent_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_edge_sum(s : NlpposmaxentEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_maxent_edge_mean(s : NlpposmaxentEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_maxent_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_maxent_edge_scale(s : NlpposmaxentEdge, f : Double) -> NlpposmaxentEdge {
  let result = nlp_pos_maxent_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_maxent_edge_add(a : NlpposmaxentEdge, b : NlpposmaxentEdge) -> NlpposmaxentEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_maxent_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_maxent_edge_copy(s : NlpposmaxentEdge) -> NlpposmaxentEdge {
  let result = nlp_pos_maxent_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_maxent_edge_fill(s : NlpposmaxentEdge, v : Double) -> NlpposmaxentEdge {
  let result = nlp_pos_maxent_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_edge_min(s : NlpposmaxentEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_edge_max(s : NlpposmaxentEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_edge_to_string(s : NlpposmaxentEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_path_make(size : Int) -> NlpposmaxentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_path_len(s : NlpposmaxentPath) -> Int { s.size }

pub fn nlp_pos_maxent_path_get(s : NlpposmaxentPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_path_set(s : NlpposmaxentPath, i : Int, v : Double) -> NlpposmaxentPath {
  let result = nlp_pos_maxent_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_path_sum(s : NlpposmaxentPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_maxent_path_mean(s : NlpposmaxentPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_maxent_path_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_maxent_path_scale(s : NlpposmaxentPath, f : Double) -> NlpposmaxentPath {
  let result = nlp_pos_maxent_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_maxent_path_add(a : NlpposmaxentPath, b : NlpposmaxentPath) -> NlpposmaxentPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_maxent_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_maxent_path_copy(s : NlpposmaxentPath) -> NlpposmaxentPath {
  let result = nlp_pos_maxent_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_maxent_path_fill(s : NlpposmaxentPath, v : Double) -> NlpposmaxentPath {
  let result = nlp_pos_maxent_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_path_min(s : NlpposmaxentPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_path_max(s : NlpposmaxentPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_path_to_string(s : NlpposmaxentPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_cluster_make(size : Int) -> NlpposmaxentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_cluster_len(s : NlpposmaxentCluster) -> Int { s.size }

pub fn nlp_pos_maxent_cluster_get(s : NlpposmaxentCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_cluster_set(s : NlpposmaxentCluster, i : Int, v : Double) -> NlpposmaxentCluster {
  let result = nlp_pos_maxent_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_cluster_sum(s : NlpposmaxentCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_maxent_cluster_mean(s : NlpposmaxentCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_maxent_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_maxent_cluster_scale(s : NlpposmaxentCluster, f : Double) -> NlpposmaxentCluster {
  let result = nlp_pos_maxent_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_maxent_cluster_add(a : NlpposmaxentCluster, b : NlpposmaxentCluster) -> NlpposmaxentCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_maxent_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_maxent_cluster_copy(s : NlpposmaxentCluster) -> NlpposmaxentCluster {
  let result = nlp_pos_maxent_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_maxent_cluster_fill(s : NlpposmaxentCluster, v : Double) -> NlpposmaxentCluster {
  let result = nlp_pos_maxent_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_cluster_min(s : NlpposmaxentCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_cluster_max(s : NlpposmaxentCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_cluster_to_string(s : NlpposmaxentCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_model_make(size : Int) -> NlpposmaxentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_model_len(s : NlpposmaxentModel) -> Int { s.size }

pub fn nlp_pos_maxent_model_get(s : NlpposmaxentModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_model_set(s : NlpposmaxentModel, i : Int, v : Double) -> NlpposmaxentModel {
  let result = nlp_pos_maxent_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_model_sum(s : NlpposmaxentModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_maxent_model_mean(s : NlpposmaxentModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_maxent_model_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_maxent_model_scale(s : NlpposmaxentModel, f : Double) -> NlpposmaxentModel {
  let result = nlp_pos_maxent_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_maxent_model_add(a : NlpposmaxentModel, b : NlpposmaxentModel) -> NlpposmaxentModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_maxent_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_maxent_model_copy(s : NlpposmaxentModel) -> NlpposmaxentModel {
  let result = nlp_pos_maxent_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_maxent_model_fill(s : NlpposmaxentModel, v : Double) -> NlpposmaxentModel {
  let result = nlp_pos_maxent_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_model_min(s : NlpposmaxentModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_model_max(s : NlpposmaxentModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_model_to_string(s : NlpposmaxentModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_layer_make(size : Int) -> NlpposmaxentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_layer_len(s : NlpposmaxentLayer) -> Int { s.size }

pub fn nlp_pos_maxent_layer_get(s : NlpposmaxentLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_layer_set(s : NlpposmaxentLayer, i : Int, v : Double) -> NlpposmaxentLayer {
  let result = nlp_pos_maxent_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_layer_sum(s : NlpposmaxentLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_maxent_layer_mean(s : NlpposmaxentLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_maxent_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_maxent_layer_scale(s : NlpposmaxentLayer, f : Double) -> NlpposmaxentLayer {
  let result = nlp_pos_maxent_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_maxent_layer_add(a : NlpposmaxentLayer, b : NlpposmaxentLayer) -> NlpposmaxentLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_maxent_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_maxent_layer_copy(s : NlpposmaxentLayer) -> NlpposmaxentLayer {
  let result = nlp_pos_maxent_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_maxent_layer_fill(s : NlpposmaxentLayer, v : Double) -> NlpposmaxentLayer {
  let result = nlp_pos_maxent_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_layer_min(s : NlpposmaxentLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_layer_max(s : NlpposmaxentLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_layer_to_string(s : NlpposmaxentLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_buffer_make(size : Int) -> NlpposmaxentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_buffer_len(s : NlpposmaxentBuffer) -> Int { s.size }

pub fn nlp_pos_maxent_buffer_get(s : NlpposmaxentBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_buffer_set(s : NlpposmaxentBuffer, i : Int, v : Double) -> NlpposmaxentBuffer {
  let result = nlp_pos_maxent_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_buffer_sum(s : NlpposmaxentBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_maxent_buffer_mean(s : NlpposmaxentBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_maxent_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_maxent_buffer_scale(s : NlpposmaxentBuffer, f : Double) -> NlpposmaxentBuffer {
  let result = nlp_pos_maxent_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_maxent_buffer_add(a : NlpposmaxentBuffer, b : NlpposmaxentBuffer) -> NlpposmaxentBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_maxent_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_maxent_buffer_copy(s : NlpposmaxentBuffer) -> NlpposmaxentBuffer {
  let result = nlp_pos_maxent_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_maxent_buffer_fill(s : NlpposmaxentBuffer, v : Double) -> NlpposmaxentBuffer {
  let result = nlp_pos_maxent_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_buffer_min(s : NlpposmaxentBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_buffer_max(s : NlpposmaxentBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_buffer_to_string(s : NlpposmaxentBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_cursor_make(size : Int) -> NlpposmaxentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_cursor_len(s : NlpposmaxentCursor) -> Int { s.size }

pub fn nlp_pos_maxent_cursor_get(s : NlpposmaxentCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_cursor_set(s : NlpposmaxentCursor, i : Int, v : Double) -> NlpposmaxentCursor {
  let result = nlp_pos_maxent_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_cursor_sum(s : NlpposmaxentCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_maxent_cursor_mean(s : NlpposmaxentCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_maxent_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_maxent_cursor_scale(s : NlpposmaxentCursor, f : Double) -> NlpposmaxentCursor {
  let result = nlp_pos_maxent_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_maxent_cursor_add(a : NlpposmaxentCursor, b : NlpposmaxentCursor) -> NlpposmaxentCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_maxent_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_maxent_cursor_copy(s : NlpposmaxentCursor) -> NlpposmaxentCursor {
  let result = nlp_pos_maxent_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_maxent_cursor_fill(s : NlpposmaxentCursor, v : Double) -> NlpposmaxentCursor {
  let result = nlp_pos_maxent_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_cursor_min(s : NlpposmaxentCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_cursor_max(s : NlpposmaxentCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_cursor_to_string(s : NlpposmaxentCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_view_make(size : Int) -> NlpposmaxentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_view_len(s : NlpposmaxentView) -> Int { s.size }

pub fn nlp_pos_maxent_view_get(s : NlpposmaxentView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_view_set(s : NlpposmaxentView, i : Int, v : Double) -> NlpposmaxentView {
  let result = nlp_pos_maxent_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_view_sum(s : NlpposmaxentView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_maxent_view_mean(s : NlpposmaxentView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_maxent_view_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_maxent_view_scale(s : NlpposmaxentView, f : Double) -> NlpposmaxentView {
  let result = nlp_pos_maxent_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_maxent_view_add(a : NlpposmaxentView, b : NlpposmaxentView) -> NlpposmaxentView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_maxent_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_maxent_view_copy(s : NlpposmaxentView) -> NlpposmaxentView {
  let result = nlp_pos_maxent_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_maxent_view_fill(s : NlpposmaxentView, v : Double) -> NlpposmaxentView {
  let result = nlp_pos_maxent_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_view_min(s : NlpposmaxentView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_view_max(s : NlpposmaxentView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_view_to_string(s : NlpposmaxentView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_range_make(size : Int) -> NlpposmaxentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_range_len(s : NlpposmaxentRange) -> Int { s.size }

pub fn nlp_pos_maxent_range_get(s : NlpposmaxentRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_range_set(s : NlpposmaxentRange, i : Int, v : Double) -> NlpposmaxentRange {
  let result = nlp_pos_maxent_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_range_sum(s : NlpposmaxentRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_maxent_range_mean(s : NlpposmaxentRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_maxent_range_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_maxent_range_scale(s : NlpposmaxentRange, f : Double) -> NlpposmaxentRange {
  let result = nlp_pos_maxent_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_maxent_range_add(a : NlpposmaxentRange, b : NlpposmaxentRange) -> NlpposmaxentRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_maxent_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_maxent_range_copy(s : NlpposmaxentRange) -> NlpposmaxentRange {
  let result = nlp_pos_maxent_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_maxent_range_fill(s : NlpposmaxentRange, v : Double) -> NlpposmaxentRange {
  let result = nlp_pos_maxent_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_range_min(s : NlpposmaxentRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_range_max(s : NlpposmaxentRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_range_to_string(s : NlpposmaxentRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposmaxentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_maxent_slice_make(size : Int) -> NlpposmaxentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_maxent_slice_len(s : NlpposmaxentSlice) -> Int { s.size }

pub fn nlp_pos_maxent_slice_get(s : NlpposmaxentSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_maxent_slice_set(s : NlpposmaxentSlice, i : Int, v : Double) -> NlpposmaxentSlice {
  let result = nlp_pos_maxent_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_slice_sum(s : NlpposmaxentSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_maxent_slice_mean(s : NlpposmaxentSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_maxent_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_maxent_slice_scale(s : NlpposmaxentSlice, f : Double) -> NlpposmaxentSlice {
  let result = nlp_pos_maxent_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_maxent_slice_add(a : NlpposmaxentSlice, b : NlpposmaxentSlice) -> NlpposmaxentSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_maxent_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_maxent_slice_copy(s : NlpposmaxentSlice) -> NlpposmaxentSlice {
  let result = nlp_pos_maxent_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_maxent_slice_fill(s : NlpposmaxentSlice, v : Double) -> NlpposmaxentSlice {
  let result = nlp_pos_maxent_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_maxent_slice_min(s : NlpposmaxentSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_slice_max(s : NlpposmaxentSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_maxent_slice_to_string(s : NlpposmaxentSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

