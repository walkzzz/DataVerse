///===
/// extcore/stats_dist_cauchy

pub(all) struct StatsdistcauchyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_cauchy_make_point(x : Double, y : Double) -> StatsdistcauchyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_cauchy_make_point3(x : Double, y : Double, z : Double) -> StatsdistcauchyPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_cauchy_point_x(pt : StatsdistcauchyPoint) -> Double { pt.x }

pub fn stats_dist_cauchy_point_y(pt : StatsdistcauchyPoint) -> Double { pt.y }

pub fn stats_dist_cauchy_point_z(pt : StatsdistcauchyPoint) -> Double { pt.z }

pub fn stats_dist_cauchy_point_label(pt : StatsdistcauchyPoint) -> Int { pt.label }

pub fn stats_dist_cauchy_point_dist(a : StatsdistcauchyPoint, b : StatsdistcauchyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_cauchy_point_add(a : StatsdistcauchyPoint, b : StatsdistcauchyPoint) -> StatsdistcauchyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_cauchy_point_sub(a : StatsdistcauchyPoint, b : StatsdistcauchyPoint) -> StatsdistcauchyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_cauchy_point_scale(pt : StatsdistcauchyPoint, s : Double) -> StatsdistcauchyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_cauchy_point_dot(a : StatsdistcauchyPoint, b : StatsdistcauchyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_cauchy_point_cross(a : StatsdistcauchyPoint, b : StatsdistcauchyPoint) -> StatsdistcauchyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_cauchy_point_norm(pt : StatsdistcauchyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_cauchy_point_normalize(pt : StatsdistcauchyPoint) -> StatsdistcauchyPoint {
  let n = stats_dist_cauchy_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_cauchy_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_cauchy_point_negate(pt : StatsdistcauchyPoint) -> StatsdistcauchyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_cauchy_point_mid(a : StatsdistcauchyPoint, b : StatsdistcauchyPoint) -> StatsdistcauchyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_cauchy_point_lerp(a : StatsdistcauchyPoint, b : StatsdistcauchyPoint, t : Double) -> StatsdistcauchyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_cauchy_point_to_string(pt : StatsdistcauchyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistcauchySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_cauchy_make_series(vals : Array[Double], name : String) -> StatsdistcauchySeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_cauchy_series_len(s : StatsdistcauchySeries) -> Int { s.vals.length() }

pub fn stats_dist_cauchy_series_sum(s : StatsdistcauchySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_dist_cauchy_series_mean(s : StatsdistcauchySeries) -> Double { @_common.mean(s.vals) }

pub fn stats_dist_cauchy_series_min(s : StatsdistcauchySeries) -> Double { @_common.min(s.vals) }

pub fn stats_dist_cauchy_series_max(s : StatsdistcauchySeries) -> Double { @_common.max(s.vals) }

pub fn stats_dist_cauchy_series_range(s : StatsdistcauchySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_dist_cauchy_series_var(s : StatsdistcauchySeries) -> Double { @_common.variance(s.vals) }

pub fn stats_dist_cauchy_series_std(s : StatsdistcauchySeries) -> Double { @_common.std(s.vals) }

pub fn stats_dist_cauchy_series_median(s : StatsdistcauchySeries) -> Double { @_common.median(s.vals) }

pub fn stats_dist_cauchy_series_scale(s : StatsdistcauchySeries, f : Double) -> StatsdistcauchySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_cauchy_series_add(a : StatsdistcauchySeries, b : StatsdistcauchySeries) -> StatsdistcauchySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_cauchy_series_sub(a : StatsdistcauchySeries, b : StatsdistcauchySeries) -> StatsdistcauchySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_cauchy_series_normalize(s : StatsdistcauchySeries) -> StatsdistcauchySeries {
  let mn = stats_dist_cauchy_series_min(s)
  let mx = stats_dist_cauchy_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_cauchy_series_cumsum(s : StatsdistcauchySeries) -> StatsdistcauchySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_cauchy_series_to_string(s : StatsdistcauchySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistcauchyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_cauchy_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistcauchyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_cauchy_matrix_identity(n : Int) -> StatsdistcauchyMatrix {
  let m = stats_dist_cauchy_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_cauchy_matrix_get(m : StatsdistcauchyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_cauchy_matrix_transpose(m : StatsdistcauchyMatrix) -> StatsdistcauchyMatrix {
  let result = stats_dist_cauchy_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_cauchy_matrix_add(a : StatsdistcauchyMatrix, b : StatsdistcauchyMatrix) -> StatsdistcauchyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_cauchy_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_cauchy_matrix_scale(m : StatsdistcauchyMatrix, s : Double) -> StatsdistcauchyMatrix {
  let result = stats_dist_cauchy_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_cauchy_matrix_multiply(a : StatsdistcauchyMatrix, b : StatsdistcauchyMatrix) -> StatsdistcauchyMatrix {
  if a.cols != b.rows { return stats_dist_cauchy_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_cauchy_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_cauchy_matrix_trace(m : StatsdistcauchyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_cauchy_matrix_det(m : StatsdistcauchyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_cauchy_matrix_norm(m : StatsdistcauchyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_cauchy_matrix_to_string(m : StatsdistcauchyMatrix) -> String {
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

pub(all) struct StatsdistcauchyVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_cauchy_make_vector(comps : Array[Double]) -> StatsdistcauchyVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_cauchy_vector_zero(dim : Int) -> StatsdistcauchyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_cauchy_vector_add(a : StatsdistcauchyVector, b : StatsdistcauchyVector) -> StatsdistcauchyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_cauchy_vector_sub(a : StatsdistcauchyVector, b : StatsdistcauchyVector) -> StatsdistcauchyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_cauchy_vector_scale(v : StatsdistcauchyVector, s : Double) -> StatsdistcauchyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_cauchy_vector_dot(a : StatsdistcauchyVector, b : StatsdistcauchyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_cauchy_vector_norm(v : StatsdistcauchyVector) -> Double { @_common.sqrt(stats_dist_cauchy_vector_dot(v, v)) }

pub fn stats_dist_cauchy_vector_normalize(v : StatsdistcauchyVector) -> StatsdistcauchyVector {
  let n = stats_dist_cauchy_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_cauchy_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_cauchy_vector_dist(a : StatsdistcauchyVector, b : StatsdistcauchyVector) -> Double {
  stats_dist_cauchy_vector_norm(stats_dist_cauchy_vector_sub(a, b))
}

pub fn stats_dist_cauchy_vector_to_string(v : StatsdistcauchyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_cauchy_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_cauchy_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_cauchy_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_cauchy_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_cauchy_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_cauchy_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_cauchy_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_cauchy_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_cauchy_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_cauchy_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_cauchy_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_cauchy_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_cauchy_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_cauchy_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_cauchy_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_cauchy_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_cauchy_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_cauchy_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_cauchy_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_cauchy_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_cauchy_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_cauchy_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_cauchy_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_cauchy_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_cauchy_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_cauchy_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_cauchy_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_cauchy_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_cauchy_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistcauchyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_frame_make(size : Int) -> StatsdistcauchyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_frame_len(s : StatsdistcauchyFrame) -> Int { s.size }

pub fn stats_dist_cauchy_frame_get(s : StatsdistcauchyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_frame_set(s : StatsdistcauchyFrame, i : Int, v : Double) -> StatsdistcauchyFrame {
  let result = stats_dist_cauchy_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_frame_sum(s : StatsdistcauchyFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_cauchy_frame_mean(s : StatsdistcauchyFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_cauchy_frame_sum(s) / s.size.to_double() }
}

pub fn stats_dist_cauchy_frame_scale(s : StatsdistcauchyFrame, f : Double) -> StatsdistcauchyFrame {
  let result = stats_dist_cauchy_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_cauchy_frame_add(a : StatsdistcauchyFrame, b : StatsdistcauchyFrame) -> StatsdistcauchyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_cauchy_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_cauchy_frame_copy(s : StatsdistcauchyFrame) -> StatsdistcauchyFrame {
  let result = stats_dist_cauchy_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_cauchy_frame_fill(s : StatsdistcauchyFrame, v : Double) -> StatsdistcauchyFrame {
  let result = stats_dist_cauchy_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_frame_min(s : StatsdistcauchyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_frame_max(s : StatsdistcauchyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_frame_to_string(s : StatsdistcauchyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_table_make(size : Int) -> StatsdistcauchyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_table_len(s : StatsdistcauchyTable) -> Int { s.size }

pub fn stats_dist_cauchy_table_get(s : StatsdistcauchyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_table_set(s : StatsdistcauchyTable, i : Int, v : Double) -> StatsdistcauchyTable {
  let result = stats_dist_cauchy_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_table_sum(s : StatsdistcauchyTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_cauchy_table_mean(s : StatsdistcauchyTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_cauchy_table_sum(s) / s.size.to_double() }
}

pub fn stats_dist_cauchy_table_scale(s : StatsdistcauchyTable, f : Double) -> StatsdistcauchyTable {
  let result = stats_dist_cauchy_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_cauchy_table_add(a : StatsdistcauchyTable, b : StatsdistcauchyTable) -> StatsdistcauchyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_cauchy_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_cauchy_table_copy(s : StatsdistcauchyTable) -> StatsdistcauchyTable {
  let result = stats_dist_cauchy_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_cauchy_table_fill(s : StatsdistcauchyTable, v : Double) -> StatsdistcauchyTable {
  let result = stats_dist_cauchy_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_table_min(s : StatsdistcauchyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_table_max(s : StatsdistcauchyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_table_to_string(s : StatsdistcauchyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_graphn_make(size : Int) -> StatsdistcauchyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_graphn_len(s : StatsdistcauchyGraphN) -> Int { s.size }

pub fn stats_dist_cauchy_graphn_get(s : StatsdistcauchyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_graphn_set(s : StatsdistcauchyGraphN, i : Int, v : Double) -> StatsdistcauchyGraphN {
  let result = stats_dist_cauchy_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_graphn_sum(s : StatsdistcauchyGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_cauchy_graphn_mean(s : StatsdistcauchyGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_cauchy_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_dist_cauchy_graphn_scale(s : StatsdistcauchyGraphN, f : Double) -> StatsdistcauchyGraphN {
  let result = stats_dist_cauchy_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_cauchy_graphn_add(a : StatsdistcauchyGraphN, b : StatsdistcauchyGraphN) -> StatsdistcauchyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_cauchy_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_cauchy_graphn_copy(s : StatsdistcauchyGraphN) -> StatsdistcauchyGraphN {
  let result = stats_dist_cauchy_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_cauchy_graphn_fill(s : StatsdistcauchyGraphN, v : Double) -> StatsdistcauchyGraphN {
  let result = stats_dist_cauchy_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_graphn_min(s : StatsdistcauchyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_graphn_max(s : StatsdistcauchyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_graphn_to_string(s : StatsdistcauchyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_node_make(size : Int) -> StatsdistcauchyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_node_len(s : StatsdistcauchyNode) -> Int { s.size }

pub fn stats_dist_cauchy_node_get(s : StatsdistcauchyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_node_set(s : StatsdistcauchyNode, i : Int, v : Double) -> StatsdistcauchyNode {
  let result = stats_dist_cauchy_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_node_sum(s : StatsdistcauchyNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_cauchy_node_mean(s : StatsdistcauchyNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_cauchy_node_sum(s) / s.size.to_double() }
}

pub fn stats_dist_cauchy_node_scale(s : StatsdistcauchyNode, f : Double) -> StatsdistcauchyNode {
  let result = stats_dist_cauchy_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_cauchy_node_add(a : StatsdistcauchyNode, b : StatsdistcauchyNode) -> StatsdistcauchyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_cauchy_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_cauchy_node_copy(s : StatsdistcauchyNode) -> StatsdistcauchyNode {
  let result = stats_dist_cauchy_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_cauchy_node_fill(s : StatsdistcauchyNode, v : Double) -> StatsdistcauchyNode {
  let result = stats_dist_cauchy_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_node_min(s : StatsdistcauchyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_node_max(s : StatsdistcauchyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_node_to_string(s : StatsdistcauchyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_edge_make(size : Int) -> StatsdistcauchyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_edge_len(s : StatsdistcauchyEdge) -> Int { s.size }

pub fn stats_dist_cauchy_edge_get(s : StatsdistcauchyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_edge_set(s : StatsdistcauchyEdge, i : Int, v : Double) -> StatsdistcauchyEdge {
  let result = stats_dist_cauchy_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_edge_sum(s : StatsdistcauchyEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_cauchy_edge_mean(s : StatsdistcauchyEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_cauchy_edge_sum(s) / s.size.to_double() }
}

pub fn stats_dist_cauchy_edge_scale(s : StatsdistcauchyEdge, f : Double) -> StatsdistcauchyEdge {
  let result = stats_dist_cauchy_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_cauchy_edge_add(a : StatsdistcauchyEdge, b : StatsdistcauchyEdge) -> StatsdistcauchyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_cauchy_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_cauchy_edge_copy(s : StatsdistcauchyEdge) -> StatsdistcauchyEdge {
  let result = stats_dist_cauchy_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_cauchy_edge_fill(s : StatsdistcauchyEdge, v : Double) -> StatsdistcauchyEdge {
  let result = stats_dist_cauchy_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_edge_min(s : StatsdistcauchyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_edge_max(s : StatsdistcauchyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_edge_to_string(s : StatsdistcauchyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_path_make(size : Int) -> StatsdistcauchyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_path_len(s : StatsdistcauchyPath) -> Int { s.size }

pub fn stats_dist_cauchy_path_get(s : StatsdistcauchyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_path_set(s : StatsdistcauchyPath, i : Int, v : Double) -> StatsdistcauchyPath {
  let result = stats_dist_cauchy_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_path_sum(s : StatsdistcauchyPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_cauchy_path_mean(s : StatsdistcauchyPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_cauchy_path_sum(s) / s.size.to_double() }
}

pub fn stats_dist_cauchy_path_scale(s : StatsdistcauchyPath, f : Double) -> StatsdistcauchyPath {
  let result = stats_dist_cauchy_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_cauchy_path_add(a : StatsdistcauchyPath, b : StatsdistcauchyPath) -> StatsdistcauchyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_cauchy_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_cauchy_path_copy(s : StatsdistcauchyPath) -> StatsdistcauchyPath {
  let result = stats_dist_cauchy_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_cauchy_path_fill(s : StatsdistcauchyPath, v : Double) -> StatsdistcauchyPath {
  let result = stats_dist_cauchy_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_path_min(s : StatsdistcauchyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_path_max(s : StatsdistcauchyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_path_to_string(s : StatsdistcauchyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_cluster_make(size : Int) -> StatsdistcauchyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_cluster_len(s : StatsdistcauchyCluster) -> Int { s.size }

pub fn stats_dist_cauchy_cluster_get(s : StatsdistcauchyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_cluster_set(s : StatsdistcauchyCluster, i : Int, v : Double) -> StatsdistcauchyCluster {
  let result = stats_dist_cauchy_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_cluster_sum(s : StatsdistcauchyCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_cauchy_cluster_mean(s : StatsdistcauchyCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_cauchy_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_dist_cauchy_cluster_scale(s : StatsdistcauchyCluster, f : Double) -> StatsdistcauchyCluster {
  let result = stats_dist_cauchy_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_cauchy_cluster_add(a : StatsdistcauchyCluster, b : StatsdistcauchyCluster) -> StatsdistcauchyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_cauchy_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_cauchy_cluster_copy(s : StatsdistcauchyCluster) -> StatsdistcauchyCluster {
  let result = stats_dist_cauchy_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_cauchy_cluster_fill(s : StatsdistcauchyCluster, v : Double) -> StatsdistcauchyCluster {
  let result = stats_dist_cauchy_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_cluster_min(s : StatsdistcauchyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_cluster_max(s : StatsdistcauchyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_cluster_to_string(s : StatsdistcauchyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_model_make(size : Int) -> StatsdistcauchyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_model_len(s : StatsdistcauchyModel) -> Int { s.size }

pub fn stats_dist_cauchy_model_get(s : StatsdistcauchyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_model_set(s : StatsdistcauchyModel, i : Int, v : Double) -> StatsdistcauchyModel {
  let result = stats_dist_cauchy_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_model_sum(s : StatsdistcauchyModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_cauchy_model_mean(s : StatsdistcauchyModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_cauchy_model_sum(s) / s.size.to_double() }
}

pub fn stats_dist_cauchy_model_scale(s : StatsdistcauchyModel, f : Double) -> StatsdistcauchyModel {
  let result = stats_dist_cauchy_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_cauchy_model_add(a : StatsdistcauchyModel, b : StatsdistcauchyModel) -> StatsdistcauchyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_cauchy_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_cauchy_model_copy(s : StatsdistcauchyModel) -> StatsdistcauchyModel {
  let result = stats_dist_cauchy_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_cauchy_model_fill(s : StatsdistcauchyModel, v : Double) -> StatsdistcauchyModel {
  let result = stats_dist_cauchy_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_model_min(s : StatsdistcauchyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_model_max(s : StatsdistcauchyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_model_to_string(s : StatsdistcauchyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_layer_make(size : Int) -> StatsdistcauchyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_layer_len(s : StatsdistcauchyLayer) -> Int { s.size }

pub fn stats_dist_cauchy_layer_get(s : StatsdistcauchyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_layer_set(s : StatsdistcauchyLayer, i : Int, v : Double) -> StatsdistcauchyLayer {
  let result = stats_dist_cauchy_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_layer_sum(s : StatsdistcauchyLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_cauchy_layer_mean(s : StatsdistcauchyLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_cauchy_layer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_cauchy_layer_scale(s : StatsdistcauchyLayer, f : Double) -> StatsdistcauchyLayer {
  let result = stats_dist_cauchy_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_cauchy_layer_add(a : StatsdistcauchyLayer, b : StatsdistcauchyLayer) -> StatsdistcauchyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_cauchy_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_cauchy_layer_copy(s : StatsdistcauchyLayer) -> StatsdistcauchyLayer {
  let result = stats_dist_cauchy_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_cauchy_layer_fill(s : StatsdistcauchyLayer, v : Double) -> StatsdistcauchyLayer {
  let result = stats_dist_cauchy_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_layer_min(s : StatsdistcauchyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_layer_max(s : StatsdistcauchyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_layer_to_string(s : StatsdistcauchyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_buffer_make(size : Int) -> StatsdistcauchyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_buffer_len(s : StatsdistcauchyBuffer) -> Int { s.size }

pub fn stats_dist_cauchy_buffer_get(s : StatsdistcauchyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_buffer_set(s : StatsdistcauchyBuffer, i : Int, v : Double) -> StatsdistcauchyBuffer {
  let result = stats_dist_cauchy_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_buffer_sum(s : StatsdistcauchyBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_cauchy_buffer_mean(s : StatsdistcauchyBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_cauchy_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_cauchy_buffer_scale(s : StatsdistcauchyBuffer, f : Double) -> StatsdistcauchyBuffer {
  let result = stats_dist_cauchy_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_cauchy_buffer_add(a : StatsdistcauchyBuffer, b : StatsdistcauchyBuffer) -> StatsdistcauchyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_cauchy_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_cauchy_buffer_copy(s : StatsdistcauchyBuffer) -> StatsdistcauchyBuffer {
  let result = stats_dist_cauchy_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_cauchy_buffer_fill(s : StatsdistcauchyBuffer, v : Double) -> StatsdistcauchyBuffer {
  let result = stats_dist_cauchy_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_buffer_min(s : StatsdistcauchyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_buffer_max(s : StatsdistcauchyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_buffer_to_string(s : StatsdistcauchyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_cursor_make(size : Int) -> StatsdistcauchyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_cursor_len(s : StatsdistcauchyCursor) -> Int { s.size }

pub fn stats_dist_cauchy_cursor_get(s : StatsdistcauchyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_cursor_set(s : StatsdistcauchyCursor, i : Int, v : Double) -> StatsdistcauchyCursor {
  let result = stats_dist_cauchy_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_cursor_sum(s : StatsdistcauchyCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_cauchy_cursor_mean(s : StatsdistcauchyCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_cauchy_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_dist_cauchy_cursor_scale(s : StatsdistcauchyCursor, f : Double) -> StatsdistcauchyCursor {
  let result = stats_dist_cauchy_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_cauchy_cursor_add(a : StatsdistcauchyCursor, b : StatsdistcauchyCursor) -> StatsdistcauchyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_cauchy_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_cauchy_cursor_copy(s : StatsdistcauchyCursor) -> StatsdistcauchyCursor {
  let result = stats_dist_cauchy_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_cauchy_cursor_fill(s : StatsdistcauchyCursor, v : Double) -> StatsdistcauchyCursor {
  let result = stats_dist_cauchy_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_cursor_min(s : StatsdistcauchyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_cursor_max(s : StatsdistcauchyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_cursor_to_string(s : StatsdistcauchyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_view_make(size : Int) -> StatsdistcauchyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_view_len(s : StatsdistcauchyView) -> Int { s.size }

pub fn stats_dist_cauchy_view_get(s : StatsdistcauchyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_view_set(s : StatsdistcauchyView, i : Int, v : Double) -> StatsdistcauchyView {
  let result = stats_dist_cauchy_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_view_sum(s : StatsdistcauchyView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_cauchy_view_mean(s : StatsdistcauchyView) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_cauchy_view_sum(s) / s.size.to_double() }
}

pub fn stats_dist_cauchy_view_scale(s : StatsdistcauchyView, f : Double) -> StatsdistcauchyView {
  let result = stats_dist_cauchy_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_cauchy_view_add(a : StatsdistcauchyView, b : StatsdistcauchyView) -> StatsdistcauchyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_cauchy_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_cauchy_view_copy(s : StatsdistcauchyView) -> StatsdistcauchyView {
  let result = stats_dist_cauchy_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_cauchy_view_fill(s : StatsdistcauchyView, v : Double) -> StatsdistcauchyView {
  let result = stats_dist_cauchy_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_view_min(s : StatsdistcauchyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_view_max(s : StatsdistcauchyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_view_to_string(s : StatsdistcauchyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_range_make(size : Int) -> StatsdistcauchyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_range_len(s : StatsdistcauchyRange) -> Int { s.size }

pub fn stats_dist_cauchy_range_get(s : StatsdistcauchyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_range_set(s : StatsdistcauchyRange, i : Int, v : Double) -> StatsdistcauchyRange {
  let result = stats_dist_cauchy_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_range_sum(s : StatsdistcauchyRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_cauchy_range_mean(s : StatsdistcauchyRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_cauchy_range_sum(s) / s.size.to_double() }
}

pub fn stats_dist_cauchy_range_scale(s : StatsdistcauchyRange, f : Double) -> StatsdistcauchyRange {
  let result = stats_dist_cauchy_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_cauchy_range_add(a : StatsdistcauchyRange, b : StatsdistcauchyRange) -> StatsdistcauchyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_cauchy_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_cauchy_range_copy(s : StatsdistcauchyRange) -> StatsdistcauchyRange {
  let result = stats_dist_cauchy_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_cauchy_range_fill(s : StatsdistcauchyRange, v : Double) -> StatsdistcauchyRange {
  let result = stats_dist_cauchy_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_range_min(s : StatsdistcauchyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_range_max(s : StatsdistcauchyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_range_to_string(s : StatsdistcauchyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistcauchySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_cauchy_slice_make(size : Int) -> StatsdistcauchySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_cauchy_slice_len(s : StatsdistcauchySlice) -> Int { s.size }

pub fn stats_dist_cauchy_slice_get(s : StatsdistcauchySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_cauchy_slice_set(s : StatsdistcauchySlice, i : Int, v : Double) -> StatsdistcauchySlice {
  let result = stats_dist_cauchy_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_slice_sum(s : StatsdistcauchySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_cauchy_slice_mean(s : StatsdistcauchySlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_cauchy_slice_sum(s) / s.size.to_double() }
}

pub fn stats_dist_cauchy_slice_scale(s : StatsdistcauchySlice, f : Double) -> StatsdistcauchySlice {
  let result = stats_dist_cauchy_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_cauchy_slice_add(a : StatsdistcauchySlice, b : StatsdistcauchySlice) -> StatsdistcauchySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_cauchy_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_cauchy_slice_copy(s : StatsdistcauchySlice) -> StatsdistcauchySlice {
  let result = stats_dist_cauchy_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_cauchy_slice_fill(s : StatsdistcauchySlice, v : Double) -> StatsdistcauchySlice {
  let result = stats_dist_cauchy_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_cauchy_slice_min(s : StatsdistcauchySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_slice_max(s : StatsdistcauchySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_cauchy_slice_to_string(s : StatsdistcauchySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

