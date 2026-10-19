///===
/// extcore/stats_dist_chi_sq

pub(all) struct StatsdistchisqPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_chi_sq_make_point(x : Double, y : Double) -> StatsdistchisqPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_chi_sq_make_point3(x : Double, y : Double, z : Double) -> StatsdistchisqPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_chi_sq_point_x(pt : StatsdistchisqPoint) -> Double { pt.x }

pub fn stats_dist_chi_sq_point_y(pt : StatsdistchisqPoint) -> Double { pt.y }

pub fn stats_dist_chi_sq_point_z(pt : StatsdistchisqPoint) -> Double { pt.z }

pub fn stats_dist_chi_sq_point_label(pt : StatsdistchisqPoint) -> Int { pt.label }

pub fn stats_dist_chi_sq_point_dist(a : StatsdistchisqPoint, b : StatsdistchisqPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_chi_sq_point_add(a : StatsdistchisqPoint, b : StatsdistchisqPoint) -> StatsdistchisqPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_chi_sq_point_sub(a : StatsdistchisqPoint, b : StatsdistchisqPoint) -> StatsdistchisqPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_chi_sq_point_scale(pt : StatsdistchisqPoint, s : Double) -> StatsdistchisqPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_chi_sq_point_dot(a : StatsdistchisqPoint, b : StatsdistchisqPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_chi_sq_point_cross(a : StatsdistchisqPoint, b : StatsdistchisqPoint) -> StatsdistchisqPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_chi_sq_point_norm(pt : StatsdistchisqPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_chi_sq_point_normalize(pt : StatsdistchisqPoint) -> StatsdistchisqPoint {
  let n = stats_dist_chi_sq_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_chi_sq_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_chi_sq_point_negate(pt : StatsdistchisqPoint) -> StatsdistchisqPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_chi_sq_point_mid(a : StatsdistchisqPoint, b : StatsdistchisqPoint) -> StatsdistchisqPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_chi_sq_point_lerp(a : StatsdistchisqPoint, b : StatsdistchisqPoint, t : Double) -> StatsdistchisqPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_chi_sq_point_to_string(pt : StatsdistchisqPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistchisqSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_chi_sq_make_series(vals : Array[Double], name : String) -> StatsdistchisqSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_chi_sq_series_len(s : StatsdistchisqSeries) -> Int { s.vals.length() }

pub fn stats_dist_chi_sq_series_sum(s : StatsdistchisqSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_dist_chi_sq_series_mean(s : StatsdistchisqSeries) -> Double {
  let n = stats_dist_chi_sq_series_len(s)
  if n == 0 { 0.0 } else { stats_dist_chi_sq_series_sum(s) / n.to_double() }
}

pub fn stats_dist_chi_sq_series_min(s : StatsdistchisqSeries) -> Double {
  let n = stats_dist_chi_sq_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_series_max(s : StatsdistchisqSeries) -> Double {
  let n = stats_dist_chi_sq_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_series_range(s : StatsdistchisqSeries) -> Double {
  stats_dist_chi_sq_series_max(s) - stats_dist_chi_sq_series_min(s)
}

pub fn stats_dist_chi_sq_series_var(s : StatsdistchisqSeries) -> Double {
  let n = stats_dist_chi_sq_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_dist_chi_sq_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_dist_chi_sq_series_std(s : StatsdistchisqSeries) -> Double { @_common.sqrt(stats_dist_chi_sq_series_var(s)) }

pub fn stats_dist_chi_sq_series_median(s : StatsdistchisqSeries) -> Double {
  let n = stats_dist_chi_sq_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_dist_chi_sq_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_dist_chi_sq_series_scale(s : StatsdistchisqSeries, f : Double) -> StatsdistchisqSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_chi_sq_series_add(a : StatsdistchisqSeries, b : StatsdistchisqSeries) -> StatsdistchisqSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_chi_sq_series_sub(a : StatsdistchisqSeries, b : StatsdistchisqSeries) -> StatsdistchisqSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_chi_sq_series_normalize(s : StatsdistchisqSeries) -> StatsdistchisqSeries {
  let mn = stats_dist_chi_sq_series_min(s)
  let mx = stats_dist_chi_sq_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_chi_sq_series_cumsum(s : StatsdistchisqSeries) -> StatsdistchisqSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_chi_sq_series_to_string(s : StatsdistchisqSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistchisqMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_chi_sq_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistchisqMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_chi_sq_matrix_identity(n : Int) -> StatsdistchisqMatrix {
  let m = stats_dist_chi_sq_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_chi_sq_matrix_get(m : StatsdistchisqMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_chi_sq_matrix_transpose(m : StatsdistchisqMatrix) -> StatsdistchisqMatrix {
  let result = stats_dist_chi_sq_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_chi_sq_matrix_add(a : StatsdistchisqMatrix, b : StatsdistchisqMatrix) -> StatsdistchisqMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_chi_sq_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_chi_sq_matrix_scale(m : StatsdistchisqMatrix, s : Double) -> StatsdistchisqMatrix {
  let result = stats_dist_chi_sq_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_chi_sq_matrix_multiply(a : StatsdistchisqMatrix, b : StatsdistchisqMatrix) -> StatsdistchisqMatrix {
  if a.cols != b.rows { return stats_dist_chi_sq_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_chi_sq_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_chi_sq_matrix_trace(m : StatsdistchisqMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_chi_sq_matrix_det(m : StatsdistchisqMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_chi_sq_matrix_norm(m : StatsdistchisqMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_chi_sq_matrix_to_string(m : StatsdistchisqMatrix) -> String {
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

pub(all) struct StatsdistchisqVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_chi_sq_make_vector(comps : Array[Double]) -> StatsdistchisqVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_chi_sq_vector_zero(dim : Int) -> StatsdistchisqVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_chi_sq_vector_add(a : StatsdistchisqVector, b : StatsdistchisqVector) -> StatsdistchisqVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_chi_sq_vector_sub(a : StatsdistchisqVector, b : StatsdistchisqVector) -> StatsdistchisqVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_chi_sq_vector_scale(v : StatsdistchisqVector, s : Double) -> StatsdistchisqVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_chi_sq_vector_dot(a : StatsdistchisqVector, b : StatsdistchisqVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_chi_sq_vector_norm(v : StatsdistchisqVector) -> Double { @_common.sqrt(stats_dist_chi_sq_vector_dot(v, v)) }

pub fn stats_dist_chi_sq_vector_normalize(v : StatsdistchisqVector) -> StatsdistchisqVector {
  let n = stats_dist_chi_sq_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_chi_sq_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_chi_sq_vector_dist(a : StatsdistchisqVector, b : StatsdistchisqVector) -> Double {
  stats_dist_chi_sq_vector_norm(stats_dist_chi_sq_vector_sub(a, b))
}

pub fn stats_dist_chi_sq_vector_to_string(v : StatsdistchisqVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_chi_sq_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_chi_sq_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_chi_sq_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_chi_sq_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_chi_sq_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_chi_sq_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_chi_sq_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_chi_sq_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_chi_sq_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_chi_sq_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_chi_sq_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_chi_sq_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_chi_sq_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_chi_sq_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_chi_sq_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_chi_sq_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_chi_sq_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_chi_sq_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_chi_sq_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_chi_sq_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_chi_sq_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_chi_sq_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_chi_sq_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_chi_sq_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_chi_sq_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_chi_sq_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_chi_sq_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_chi_sq_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_chi_sq_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistchisqFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_frame_make(size : Int) -> StatsdistchisqFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_frame_len(s : StatsdistchisqFrame) -> Int { s.size }

pub fn stats_dist_chi_sq_frame_get(s : StatsdistchisqFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_frame_set(s : StatsdistchisqFrame, i : Int, v : Double) -> StatsdistchisqFrame {
  let result = stats_dist_chi_sq_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_frame_sum(s : StatsdistchisqFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_chi_sq_frame_mean(s : StatsdistchisqFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_chi_sq_frame_sum(s) / s.size.to_double() }
}

pub fn stats_dist_chi_sq_frame_scale(s : StatsdistchisqFrame, f : Double) -> StatsdistchisqFrame {
  let result = stats_dist_chi_sq_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_chi_sq_frame_add(a : StatsdistchisqFrame, b : StatsdistchisqFrame) -> StatsdistchisqFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_chi_sq_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_chi_sq_frame_copy(s : StatsdistchisqFrame) -> StatsdistchisqFrame {
  let result = stats_dist_chi_sq_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_chi_sq_frame_fill(s : StatsdistchisqFrame, v : Double) -> StatsdistchisqFrame {
  let result = stats_dist_chi_sq_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_frame_min(s : StatsdistchisqFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_frame_max(s : StatsdistchisqFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_frame_to_string(s : StatsdistchisqFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_table_make(size : Int) -> StatsdistchisqTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_table_len(s : StatsdistchisqTable) -> Int { s.size }

pub fn stats_dist_chi_sq_table_get(s : StatsdistchisqTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_table_set(s : StatsdistchisqTable, i : Int, v : Double) -> StatsdistchisqTable {
  let result = stats_dist_chi_sq_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_table_sum(s : StatsdistchisqTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_chi_sq_table_mean(s : StatsdistchisqTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_chi_sq_table_sum(s) / s.size.to_double() }
}

pub fn stats_dist_chi_sq_table_scale(s : StatsdistchisqTable, f : Double) -> StatsdistchisqTable {
  let result = stats_dist_chi_sq_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_chi_sq_table_add(a : StatsdistchisqTable, b : StatsdistchisqTable) -> StatsdistchisqTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_chi_sq_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_chi_sq_table_copy(s : StatsdistchisqTable) -> StatsdistchisqTable {
  let result = stats_dist_chi_sq_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_chi_sq_table_fill(s : StatsdistchisqTable, v : Double) -> StatsdistchisqTable {
  let result = stats_dist_chi_sq_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_table_min(s : StatsdistchisqTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_table_max(s : StatsdistchisqTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_table_to_string(s : StatsdistchisqTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_graphn_make(size : Int) -> StatsdistchisqGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_graphn_len(s : StatsdistchisqGraphN) -> Int { s.size }

pub fn stats_dist_chi_sq_graphn_get(s : StatsdistchisqGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_graphn_set(s : StatsdistchisqGraphN, i : Int, v : Double) -> StatsdistchisqGraphN {
  let result = stats_dist_chi_sq_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_graphn_sum(s : StatsdistchisqGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_chi_sq_graphn_mean(s : StatsdistchisqGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_chi_sq_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_dist_chi_sq_graphn_scale(s : StatsdistchisqGraphN, f : Double) -> StatsdistchisqGraphN {
  let result = stats_dist_chi_sq_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_chi_sq_graphn_add(a : StatsdistchisqGraphN, b : StatsdistchisqGraphN) -> StatsdistchisqGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_chi_sq_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_chi_sq_graphn_copy(s : StatsdistchisqGraphN) -> StatsdistchisqGraphN {
  let result = stats_dist_chi_sq_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_chi_sq_graphn_fill(s : StatsdistchisqGraphN, v : Double) -> StatsdistchisqGraphN {
  let result = stats_dist_chi_sq_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_graphn_min(s : StatsdistchisqGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_graphn_max(s : StatsdistchisqGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_graphn_to_string(s : StatsdistchisqGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_node_make(size : Int) -> StatsdistchisqNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_node_len(s : StatsdistchisqNode) -> Int { s.size }

pub fn stats_dist_chi_sq_node_get(s : StatsdistchisqNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_node_set(s : StatsdistchisqNode, i : Int, v : Double) -> StatsdistchisqNode {
  let result = stats_dist_chi_sq_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_node_sum(s : StatsdistchisqNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_chi_sq_node_mean(s : StatsdistchisqNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_chi_sq_node_sum(s) / s.size.to_double() }
}

pub fn stats_dist_chi_sq_node_scale(s : StatsdistchisqNode, f : Double) -> StatsdistchisqNode {
  let result = stats_dist_chi_sq_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_chi_sq_node_add(a : StatsdistchisqNode, b : StatsdistchisqNode) -> StatsdistchisqNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_chi_sq_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_chi_sq_node_copy(s : StatsdistchisqNode) -> StatsdistchisqNode {
  let result = stats_dist_chi_sq_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_chi_sq_node_fill(s : StatsdistchisqNode, v : Double) -> StatsdistchisqNode {
  let result = stats_dist_chi_sq_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_node_min(s : StatsdistchisqNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_node_max(s : StatsdistchisqNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_node_to_string(s : StatsdistchisqNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_edge_make(size : Int) -> StatsdistchisqEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_edge_len(s : StatsdistchisqEdge) -> Int { s.size }

pub fn stats_dist_chi_sq_edge_get(s : StatsdistchisqEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_edge_set(s : StatsdistchisqEdge, i : Int, v : Double) -> StatsdistchisqEdge {
  let result = stats_dist_chi_sq_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_edge_sum(s : StatsdistchisqEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_chi_sq_edge_mean(s : StatsdistchisqEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_chi_sq_edge_sum(s) / s.size.to_double() }
}

pub fn stats_dist_chi_sq_edge_scale(s : StatsdistchisqEdge, f : Double) -> StatsdistchisqEdge {
  let result = stats_dist_chi_sq_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_chi_sq_edge_add(a : StatsdistchisqEdge, b : StatsdistchisqEdge) -> StatsdistchisqEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_chi_sq_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_chi_sq_edge_copy(s : StatsdistchisqEdge) -> StatsdistchisqEdge {
  let result = stats_dist_chi_sq_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_chi_sq_edge_fill(s : StatsdistchisqEdge, v : Double) -> StatsdistchisqEdge {
  let result = stats_dist_chi_sq_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_edge_min(s : StatsdistchisqEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_edge_max(s : StatsdistchisqEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_edge_to_string(s : StatsdistchisqEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_path_make(size : Int) -> StatsdistchisqPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_path_len(s : StatsdistchisqPath) -> Int { s.size }

pub fn stats_dist_chi_sq_path_get(s : StatsdistchisqPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_path_set(s : StatsdistchisqPath, i : Int, v : Double) -> StatsdistchisqPath {
  let result = stats_dist_chi_sq_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_path_sum(s : StatsdistchisqPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_chi_sq_path_mean(s : StatsdistchisqPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_chi_sq_path_sum(s) / s.size.to_double() }
}

pub fn stats_dist_chi_sq_path_scale(s : StatsdistchisqPath, f : Double) -> StatsdistchisqPath {
  let result = stats_dist_chi_sq_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_chi_sq_path_add(a : StatsdistchisqPath, b : StatsdistchisqPath) -> StatsdistchisqPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_chi_sq_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_chi_sq_path_copy(s : StatsdistchisqPath) -> StatsdistchisqPath {
  let result = stats_dist_chi_sq_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_chi_sq_path_fill(s : StatsdistchisqPath, v : Double) -> StatsdistchisqPath {
  let result = stats_dist_chi_sq_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_path_min(s : StatsdistchisqPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_path_max(s : StatsdistchisqPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_path_to_string(s : StatsdistchisqPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_cluster_make(size : Int) -> StatsdistchisqCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_cluster_len(s : StatsdistchisqCluster) -> Int { s.size }

pub fn stats_dist_chi_sq_cluster_get(s : StatsdistchisqCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_cluster_set(s : StatsdistchisqCluster, i : Int, v : Double) -> StatsdistchisqCluster {
  let result = stats_dist_chi_sq_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_cluster_sum(s : StatsdistchisqCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_chi_sq_cluster_mean(s : StatsdistchisqCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_chi_sq_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_dist_chi_sq_cluster_scale(s : StatsdistchisqCluster, f : Double) -> StatsdistchisqCluster {
  let result = stats_dist_chi_sq_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_chi_sq_cluster_add(a : StatsdistchisqCluster, b : StatsdistchisqCluster) -> StatsdistchisqCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_chi_sq_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_chi_sq_cluster_copy(s : StatsdistchisqCluster) -> StatsdistchisqCluster {
  let result = stats_dist_chi_sq_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_chi_sq_cluster_fill(s : StatsdistchisqCluster, v : Double) -> StatsdistchisqCluster {
  let result = stats_dist_chi_sq_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_cluster_min(s : StatsdistchisqCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_cluster_max(s : StatsdistchisqCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_cluster_to_string(s : StatsdistchisqCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_model_make(size : Int) -> StatsdistchisqModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_model_len(s : StatsdistchisqModel) -> Int { s.size }

pub fn stats_dist_chi_sq_model_get(s : StatsdistchisqModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_model_set(s : StatsdistchisqModel, i : Int, v : Double) -> StatsdistchisqModel {
  let result = stats_dist_chi_sq_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_model_sum(s : StatsdistchisqModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_chi_sq_model_mean(s : StatsdistchisqModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_chi_sq_model_sum(s) / s.size.to_double() }
}

pub fn stats_dist_chi_sq_model_scale(s : StatsdistchisqModel, f : Double) -> StatsdistchisqModel {
  let result = stats_dist_chi_sq_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_chi_sq_model_add(a : StatsdistchisqModel, b : StatsdistchisqModel) -> StatsdistchisqModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_chi_sq_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_chi_sq_model_copy(s : StatsdistchisqModel) -> StatsdistchisqModel {
  let result = stats_dist_chi_sq_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_chi_sq_model_fill(s : StatsdistchisqModel, v : Double) -> StatsdistchisqModel {
  let result = stats_dist_chi_sq_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_model_min(s : StatsdistchisqModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_model_max(s : StatsdistchisqModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_model_to_string(s : StatsdistchisqModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_layer_make(size : Int) -> StatsdistchisqLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_layer_len(s : StatsdistchisqLayer) -> Int { s.size }

pub fn stats_dist_chi_sq_layer_get(s : StatsdistchisqLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_layer_set(s : StatsdistchisqLayer, i : Int, v : Double) -> StatsdistchisqLayer {
  let result = stats_dist_chi_sq_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_layer_sum(s : StatsdistchisqLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_chi_sq_layer_mean(s : StatsdistchisqLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_chi_sq_layer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_chi_sq_layer_scale(s : StatsdistchisqLayer, f : Double) -> StatsdistchisqLayer {
  let result = stats_dist_chi_sq_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_chi_sq_layer_add(a : StatsdistchisqLayer, b : StatsdistchisqLayer) -> StatsdistchisqLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_chi_sq_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_chi_sq_layer_copy(s : StatsdistchisqLayer) -> StatsdistchisqLayer {
  let result = stats_dist_chi_sq_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_chi_sq_layer_fill(s : StatsdistchisqLayer, v : Double) -> StatsdistchisqLayer {
  let result = stats_dist_chi_sq_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_layer_min(s : StatsdistchisqLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_layer_max(s : StatsdistchisqLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_layer_to_string(s : StatsdistchisqLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_buffer_make(size : Int) -> StatsdistchisqBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_buffer_len(s : StatsdistchisqBuffer) -> Int { s.size }

pub fn stats_dist_chi_sq_buffer_get(s : StatsdistchisqBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_buffer_set(s : StatsdistchisqBuffer, i : Int, v : Double) -> StatsdistchisqBuffer {
  let result = stats_dist_chi_sq_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_buffer_sum(s : StatsdistchisqBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_chi_sq_buffer_mean(s : StatsdistchisqBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_chi_sq_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_chi_sq_buffer_scale(s : StatsdistchisqBuffer, f : Double) -> StatsdistchisqBuffer {
  let result = stats_dist_chi_sq_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_chi_sq_buffer_add(a : StatsdistchisqBuffer, b : StatsdistchisqBuffer) -> StatsdistchisqBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_chi_sq_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_chi_sq_buffer_copy(s : StatsdistchisqBuffer) -> StatsdistchisqBuffer {
  let result = stats_dist_chi_sq_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_chi_sq_buffer_fill(s : StatsdistchisqBuffer, v : Double) -> StatsdistchisqBuffer {
  let result = stats_dist_chi_sq_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_buffer_min(s : StatsdistchisqBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_buffer_max(s : StatsdistchisqBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_buffer_to_string(s : StatsdistchisqBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_cursor_make(size : Int) -> StatsdistchisqCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_cursor_len(s : StatsdistchisqCursor) -> Int { s.size }

pub fn stats_dist_chi_sq_cursor_get(s : StatsdistchisqCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_cursor_set(s : StatsdistchisqCursor, i : Int, v : Double) -> StatsdistchisqCursor {
  let result = stats_dist_chi_sq_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_cursor_sum(s : StatsdistchisqCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_chi_sq_cursor_mean(s : StatsdistchisqCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_chi_sq_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_dist_chi_sq_cursor_scale(s : StatsdistchisqCursor, f : Double) -> StatsdistchisqCursor {
  let result = stats_dist_chi_sq_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_chi_sq_cursor_add(a : StatsdistchisqCursor, b : StatsdistchisqCursor) -> StatsdistchisqCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_chi_sq_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_chi_sq_cursor_copy(s : StatsdistchisqCursor) -> StatsdistchisqCursor {
  let result = stats_dist_chi_sq_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_chi_sq_cursor_fill(s : StatsdistchisqCursor, v : Double) -> StatsdistchisqCursor {
  let result = stats_dist_chi_sq_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_cursor_min(s : StatsdistchisqCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_cursor_max(s : StatsdistchisqCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_cursor_to_string(s : StatsdistchisqCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_view_make(size : Int) -> StatsdistchisqView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_view_len(s : StatsdistchisqView) -> Int { s.size }

pub fn stats_dist_chi_sq_view_get(s : StatsdistchisqView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_view_set(s : StatsdistchisqView, i : Int, v : Double) -> StatsdistchisqView {
  let result = stats_dist_chi_sq_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_view_sum(s : StatsdistchisqView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_chi_sq_view_mean(s : StatsdistchisqView) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_chi_sq_view_sum(s) / s.size.to_double() }
}

pub fn stats_dist_chi_sq_view_scale(s : StatsdistchisqView, f : Double) -> StatsdistchisqView {
  let result = stats_dist_chi_sq_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_chi_sq_view_add(a : StatsdistchisqView, b : StatsdistchisqView) -> StatsdistchisqView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_chi_sq_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_chi_sq_view_copy(s : StatsdistchisqView) -> StatsdistchisqView {
  let result = stats_dist_chi_sq_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_chi_sq_view_fill(s : StatsdistchisqView, v : Double) -> StatsdistchisqView {
  let result = stats_dist_chi_sq_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_view_min(s : StatsdistchisqView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_view_max(s : StatsdistchisqView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_view_to_string(s : StatsdistchisqView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_range_make(size : Int) -> StatsdistchisqRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_range_len(s : StatsdistchisqRange) -> Int { s.size }

pub fn stats_dist_chi_sq_range_get(s : StatsdistchisqRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_range_set(s : StatsdistchisqRange, i : Int, v : Double) -> StatsdistchisqRange {
  let result = stats_dist_chi_sq_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_range_sum(s : StatsdistchisqRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_chi_sq_range_mean(s : StatsdistchisqRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_chi_sq_range_sum(s) / s.size.to_double() }
}

pub fn stats_dist_chi_sq_range_scale(s : StatsdistchisqRange, f : Double) -> StatsdistchisqRange {
  let result = stats_dist_chi_sq_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_chi_sq_range_add(a : StatsdistchisqRange, b : StatsdistchisqRange) -> StatsdistchisqRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_chi_sq_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_chi_sq_range_copy(s : StatsdistchisqRange) -> StatsdistchisqRange {
  let result = stats_dist_chi_sq_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_chi_sq_range_fill(s : StatsdistchisqRange, v : Double) -> StatsdistchisqRange {
  let result = stats_dist_chi_sq_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_range_min(s : StatsdistchisqRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_range_max(s : StatsdistchisqRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_range_to_string(s : StatsdistchisqRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistchisqSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_chi_sq_slice_make(size : Int) -> StatsdistchisqSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_chi_sq_slice_len(s : StatsdistchisqSlice) -> Int { s.size }

pub fn stats_dist_chi_sq_slice_get(s : StatsdistchisqSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_chi_sq_slice_set(s : StatsdistchisqSlice, i : Int, v : Double) -> StatsdistchisqSlice {
  let result = stats_dist_chi_sq_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_slice_sum(s : StatsdistchisqSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_chi_sq_slice_mean(s : StatsdistchisqSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_chi_sq_slice_sum(s) / s.size.to_double() }
}

pub fn stats_dist_chi_sq_slice_scale(s : StatsdistchisqSlice, f : Double) -> StatsdistchisqSlice {
  let result = stats_dist_chi_sq_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_chi_sq_slice_add(a : StatsdistchisqSlice, b : StatsdistchisqSlice) -> StatsdistchisqSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_chi_sq_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_chi_sq_slice_copy(s : StatsdistchisqSlice) -> StatsdistchisqSlice {
  let result = stats_dist_chi_sq_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_chi_sq_slice_fill(s : StatsdistchisqSlice, v : Double) -> StatsdistchisqSlice {
  let result = stats_dist_chi_sq_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_chi_sq_slice_min(s : StatsdistchisqSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_slice_max(s : StatsdistchisqSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_chi_sq_slice_to_string(s : StatsdistchisqSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

