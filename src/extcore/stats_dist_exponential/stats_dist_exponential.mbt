///===
/// extcore/stats_dist_exponential

pub(all) struct StatsdistexponentialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_exponential_make_point(x : Double, y : Double) -> StatsdistexponentialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_exponential_make_point3(x : Double, y : Double, z : Double) -> StatsdistexponentialPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_exponential_point_x(pt : StatsdistexponentialPoint) -> Double { pt.x }

pub fn stats_dist_exponential_point_y(pt : StatsdistexponentialPoint) -> Double { pt.y }

pub fn stats_dist_exponential_point_z(pt : StatsdistexponentialPoint) -> Double { pt.z }

pub fn stats_dist_exponential_point_label(pt : StatsdistexponentialPoint) -> Int { pt.label }

pub fn stats_dist_exponential_point_dist(a : StatsdistexponentialPoint, b : StatsdistexponentialPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_exponential_point_add(a : StatsdistexponentialPoint, b : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_exponential_point_sub(a : StatsdistexponentialPoint, b : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_exponential_point_scale(pt : StatsdistexponentialPoint, s : Double) -> StatsdistexponentialPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_exponential_point_dot(a : StatsdistexponentialPoint, b : StatsdistexponentialPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_exponential_point_cross(a : StatsdistexponentialPoint, b : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_exponential_point_norm(pt : StatsdistexponentialPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_exponential_point_normalize(pt : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  let n = stats_dist_exponential_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_exponential_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_exponential_point_negate(pt : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_exponential_point_mid(a : StatsdistexponentialPoint, b : StatsdistexponentialPoint) -> StatsdistexponentialPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_exponential_point_lerp(a : StatsdistexponentialPoint, b : StatsdistexponentialPoint, t : Double) -> StatsdistexponentialPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_exponential_point_to_string(pt : StatsdistexponentialPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistexponentialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_exponential_make_series(vals : Array[Double], name : String) -> StatsdistexponentialSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_exponential_series_len(s : StatsdistexponentialSeries) -> Int { s.vals.length() }

pub fn stats_dist_exponential_series_sum(s : StatsdistexponentialSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_dist_exponential_series_mean(s : StatsdistexponentialSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_dist_exponential_series_min(s : StatsdistexponentialSeries) -> Double { @_common.min(s.vals) }

pub fn stats_dist_exponential_series_max(s : StatsdistexponentialSeries) -> Double { @_common.max(s.vals) }

pub fn stats_dist_exponential_series_range(s : StatsdistexponentialSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_dist_exponential_series_var(s : StatsdistexponentialSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_dist_exponential_series_std(s : StatsdistexponentialSeries) -> Double { @_common.std(s.vals) }

pub fn stats_dist_exponential_series_median(s : StatsdistexponentialSeries) -> Double { @_common.median(s.vals) }

pub fn stats_dist_exponential_series_scale(s : StatsdistexponentialSeries, f : Double) -> StatsdistexponentialSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_exponential_series_add(a : StatsdistexponentialSeries, b : StatsdistexponentialSeries) -> StatsdistexponentialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_exponential_series_sub(a : StatsdistexponentialSeries, b : StatsdistexponentialSeries) -> StatsdistexponentialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_exponential_series_normalize(s : StatsdistexponentialSeries) -> StatsdistexponentialSeries {
  let mn = stats_dist_exponential_series_min(s)
  let mx = stats_dist_exponential_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_exponential_series_cumsum(s : StatsdistexponentialSeries) -> StatsdistexponentialSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_exponential_series_to_string(s : StatsdistexponentialSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistexponentialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_exponential_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistexponentialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_exponential_matrix_identity(n : Int) -> StatsdistexponentialMatrix {
  let m = stats_dist_exponential_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_exponential_matrix_get(m : StatsdistexponentialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_exponential_matrix_transpose(m : StatsdistexponentialMatrix) -> StatsdistexponentialMatrix {
  let result = stats_dist_exponential_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_exponential_matrix_add(a : StatsdistexponentialMatrix, b : StatsdistexponentialMatrix) -> StatsdistexponentialMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_exponential_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_exponential_matrix_scale(m : StatsdistexponentialMatrix, s : Double) -> StatsdistexponentialMatrix {
  let result = stats_dist_exponential_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_exponential_matrix_multiply(a : StatsdistexponentialMatrix, b : StatsdistexponentialMatrix) -> StatsdistexponentialMatrix {
  if a.cols != b.rows { return stats_dist_exponential_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_exponential_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_exponential_matrix_trace(m : StatsdistexponentialMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_exponential_matrix_det(m : StatsdistexponentialMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_exponential_matrix_norm(m : StatsdistexponentialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_exponential_matrix_to_string(m : StatsdistexponentialMatrix) -> String {
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

pub(all) struct StatsdistexponentialVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_exponential_make_vector(comps : Array[Double]) -> StatsdistexponentialVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_exponential_vector_zero(dim : Int) -> StatsdistexponentialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_exponential_vector_add(a : StatsdistexponentialVector, b : StatsdistexponentialVector) -> StatsdistexponentialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_exponential_vector_sub(a : StatsdistexponentialVector, b : StatsdistexponentialVector) -> StatsdistexponentialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_exponential_vector_scale(v : StatsdistexponentialVector, s : Double) -> StatsdistexponentialVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_exponential_vector_dot(a : StatsdistexponentialVector, b : StatsdistexponentialVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_exponential_vector_norm(v : StatsdistexponentialVector) -> Double { @_common.sqrt(stats_dist_exponential_vector_dot(v, v)) }

pub fn stats_dist_exponential_vector_normalize(v : StatsdistexponentialVector) -> StatsdistexponentialVector {
  let n = stats_dist_exponential_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_exponential_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_exponential_vector_dist(a : StatsdistexponentialVector, b : StatsdistexponentialVector) -> Double {
  stats_dist_exponential_vector_norm(stats_dist_exponential_vector_sub(a, b))
}

pub fn stats_dist_exponential_vector_to_string(v : StatsdistexponentialVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_exponential_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_exponential_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_exponential_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_exponential_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_exponential_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_exponential_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_exponential_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_exponential_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_exponential_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_exponential_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_exponential_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_exponential_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_exponential_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_exponential_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_exponential_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_exponential_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_exponential_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_exponential_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_exponential_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_exponential_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_exponential_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_exponential_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_exponential_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_exponential_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_exponential_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_exponential_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_exponential_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_exponential_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_exponential_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistexponentialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_frame_make(size : Int) -> StatsdistexponentialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_frame_len(s : StatsdistexponentialFrame) -> Int { s.size }

pub fn stats_dist_exponential_frame_get(s : StatsdistexponentialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_frame_set(s : StatsdistexponentialFrame, i : Int, v : Double) -> StatsdistexponentialFrame {
  let result = stats_dist_exponential_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_frame_sum(s : StatsdistexponentialFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_frame_mean(s : StatsdistexponentialFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_frame_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_frame_scale(s : StatsdistexponentialFrame, f : Double) -> StatsdistexponentialFrame {
  let result = stats_dist_exponential_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_frame_add(a : StatsdistexponentialFrame, b : StatsdistexponentialFrame) -> StatsdistexponentialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_frame_copy(s : StatsdistexponentialFrame) -> StatsdistexponentialFrame {
  let result = stats_dist_exponential_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_frame_fill(s : StatsdistexponentialFrame, v : Double) -> StatsdistexponentialFrame {
  let result = stats_dist_exponential_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_frame_min(s : StatsdistexponentialFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_frame_max(s : StatsdistexponentialFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_frame_to_string(s : StatsdistexponentialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_table_make(size : Int) -> StatsdistexponentialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_table_len(s : StatsdistexponentialTable) -> Int { s.size }

pub fn stats_dist_exponential_table_get(s : StatsdistexponentialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_table_set(s : StatsdistexponentialTable, i : Int, v : Double) -> StatsdistexponentialTable {
  let result = stats_dist_exponential_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_table_sum(s : StatsdistexponentialTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_table_mean(s : StatsdistexponentialTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_table_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_table_scale(s : StatsdistexponentialTable, f : Double) -> StatsdistexponentialTable {
  let result = stats_dist_exponential_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_table_add(a : StatsdistexponentialTable, b : StatsdistexponentialTable) -> StatsdistexponentialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_table_copy(s : StatsdistexponentialTable) -> StatsdistexponentialTable {
  let result = stats_dist_exponential_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_table_fill(s : StatsdistexponentialTable, v : Double) -> StatsdistexponentialTable {
  let result = stats_dist_exponential_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_table_min(s : StatsdistexponentialTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_table_max(s : StatsdistexponentialTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_table_to_string(s : StatsdistexponentialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_graphn_make(size : Int) -> StatsdistexponentialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_graphn_len(s : StatsdistexponentialGraphN) -> Int { s.size }

pub fn stats_dist_exponential_graphn_get(s : StatsdistexponentialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_graphn_set(s : StatsdistexponentialGraphN, i : Int, v : Double) -> StatsdistexponentialGraphN {
  let result = stats_dist_exponential_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_graphn_sum(s : StatsdistexponentialGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_graphn_mean(s : StatsdistexponentialGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_graphn_scale(s : StatsdistexponentialGraphN, f : Double) -> StatsdistexponentialGraphN {
  let result = stats_dist_exponential_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_graphn_add(a : StatsdistexponentialGraphN, b : StatsdistexponentialGraphN) -> StatsdistexponentialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_graphn_copy(s : StatsdistexponentialGraphN) -> StatsdistexponentialGraphN {
  let result = stats_dist_exponential_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_graphn_fill(s : StatsdistexponentialGraphN, v : Double) -> StatsdistexponentialGraphN {
  let result = stats_dist_exponential_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_graphn_min(s : StatsdistexponentialGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_graphn_max(s : StatsdistexponentialGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_graphn_to_string(s : StatsdistexponentialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_node_make(size : Int) -> StatsdistexponentialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_node_len(s : StatsdistexponentialNode) -> Int { s.size }

pub fn stats_dist_exponential_node_get(s : StatsdistexponentialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_node_set(s : StatsdistexponentialNode, i : Int, v : Double) -> StatsdistexponentialNode {
  let result = stats_dist_exponential_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_node_sum(s : StatsdistexponentialNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_node_mean(s : StatsdistexponentialNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_node_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_node_scale(s : StatsdistexponentialNode, f : Double) -> StatsdistexponentialNode {
  let result = stats_dist_exponential_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_node_add(a : StatsdistexponentialNode, b : StatsdistexponentialNode) -> StatsdistexponentialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_node_copy(s : StatsdistexponentialNode) -> StatsdistexponentialNode {
  let result = stats_dist_exponential_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_node_fill(s : StatsdistexponentialNode, v : Double) -> StatsdistexponentialNode {
  let result = stats_dist_exponential_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_node_min(s : StatsdistexponentialNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_node_max(s : StatsdistexponentialNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_node_to_string(s : StatsdistexponentialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_edge_make(size : Int) -> StatsdistexponentialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_edge_len(s : StatsdistexponentialEdge) -> Int { s.size }

pub fn stats_dist_exponential_edge_get(s : StatsdistexponentialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_edge_set(s : StatsdistexponentialEdge, i : Int, v : Double) -> StatsdistexponentialEdge {
  let result = stats_dist_exponential_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_edge_sum(s : StatsdistexponentialEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_edge_mean(s : StatsdistexponentialEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_edge_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_edge_scale(s : StatsdistexponentialEdge, f : Double) -> StatsdistexponentialEdge {
  let result = stats_dist_exponential_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_edge_add(a : StatsdistexponentialEdge, b : StatsdistexponentialEdge) -> StatsdistexponentialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_edge_copy(s : StatsdistexponentialEdge) -> StatsdistexponentialEdge {
  let result = stats_dist_exponential_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_edge_fill(s : StatsdistexponentialEdge, v : Double) -> StatsdistexponentialEdge {
  let result = stats_dist_exponential_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_edge_min(s : StatsdistexponentialEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_edge_max(s : StatsdistexponentialEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_edge_to_string(s : StatsdistexponentialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_path_make(size : Int) -> StatsdistexponentialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_path_len(s : StatsdistexponentialPath) -> Int { s.size }

pub fn stats_dist_exponential_path_get(s : StatsdistexponentialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_path_set(s : StatsdistexponentialPath, i : Int, v : Double) -> StatsdistexponentialPath {
  let result = stats_dist_exponential_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_path_sum(s : StatsdistexponentialPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_path_mean(s : StatsdistexponentialPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_path_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_path_scale(s : StatsdistexponentialPath, f : Double) -> StatsdistexponentialPath {
  let result = stats_dist_exponential_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_path_add(a : StatsdistexponentialPath, b : StatsdistexponentialPath) -> StatsdistexponentialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_path_copy(s : StatsdistexponentialPath) -> StatsdistexponentialPath {
  let result = stats_dist_exponential_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_path_fill(s : StatsdistexponentialPath, v : Double) -> StatsdistexponentialPath {
  let result = stats_dist_exponential_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_path_min(s : StatsdistexponentialPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_path_max(s : StatsdistexponentialPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_path_to_string(s : StatsdistexponentialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_cluster_make(size : Int) -> StatsdistexponentialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_cluster_len(s : StatsdistexponentialCluster) -> Int { s.size }

pub fn stats_dist_exponential_cluster_get(s : StatsdistexponentialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_cluster_set(s : StatsdistexponentialCluster, i : Int, v : Double) -> StatsdistexponentialCluster {
  let result = stats_dist_exponential_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_cluster_sum(s : StatsdistexponentialCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_cluster_mean(s : StatsdistexponentialCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_cluster_scale(s : StatsdistexponentialCluster, f : Double) -> StatsdistexponentialCluster {
  let result = stats_dist_exponential_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_cluster_add(a : StatsdistexponentialCluster, b : StatsdistexponentialCluster) -> StatsdistexponentialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_cluster_copy(s : StatsdistexponentialCluster) -> StatsdistexponentialCluster {
  let result = stats_dist_exponential_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_cluster_fill(s : StatsdistexponentialCluster, v : Double) -> StatsdistexponentialCluster {
  let result = stats_dist_exponential_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_cluster_min(s : StatsdistexponentialCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_cluster_max(s : StatsdistexponentialCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_cluster_to_string(s : StatsdistexponentialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_model_make(size : Int) -> StatsdistexponentialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_model_len(s : StatsdistexponentialModel) -> Int { s.size }

pub fn stats_dist_exponential_model_get(s : StatsdistexponentialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_model_set(s : StatsdistexponentialModel, i : Int, v : Double) -> StatsdistexponentialModel {
  let result = stats_dist_exponential_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_model_sum(s : StatsdistexponentialModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_model_mean(s : StatsdistexponentialModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_model_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_model_scale(s : StatsdistexponentialModel, f : Double) -> StatsdistexponentialModel {
  let result = stats_dist_exponential_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_model_add(a : StatsdistexponentialModel, b : StatsdistexponentialModel) -> StatsdistexponentialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_model_copy(s : StatsdistexponentialModel) -> StatsdistexponentialModel {
  let result = stats_dist_exponential_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_model_fill(s : StatsdistexponentialModel, v : Double) -> StatsdistexponentialModel {
  let result = stats_dist_exponential_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_model_min(s : StatsdistexponentialModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_model_max(s : StatsdistexponentialModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_model_to_string(s : StatsdistexponentialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_layer_make(size : Int) -> StatsdistexponentialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_layer_len(s : StatsdistexponentialLayer) -> Int { s.size }

pub fn stats_dist_exponential_layer_get(s : StatsdistexponentialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_layer_set(s : StatsdistexponentialLayer, i : Int, v : Double) -> StatsdistexponentialLayer {
  let result = stats_dist_exponential_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_layer_sum(s : StatsdistexponentialLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_layer_mean(s : StatsdistexponentialLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_layer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_layer_scale(s : StatsdistexponentialLayer, f : Double) -> StatsdistexponentialLayer {
  let result = stats_dist_exponential_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_layer_add(a : StatsdistexponentialLayer, b : StatsdistexponentialLayer) -> StatsdistexponentialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_layer_copy(s : StatsdistexponentialLayer) -> StatsdistexponentialLayer {
  let result = stats_dist_exponential_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_layer_fill(s : StatsdistexponentialLayer, v : Double) -> StatsdistexponentialLayer {
  let result = stats_dist_exponential_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_layer_min(s : StatsdistexponentialLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_layer_max(s : StatsdistexponentialLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_layer_to_string(s : StatsdistexponentialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_buffer_make(size : Int) -> StatsdistexponentialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_buffer_len(s : StatsdistexponentialBuffer) -> Int { s.size }

pub fn stats_dist_exponential_buffer_get(s : StatsdistexponentialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_buffer_set(s : StatsdistexponentialBuffer, i : Int, v : Double) -> StatsdistexponentialBuffer {
  let result = stats_dist_exponential_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_buffer_sum(s : StatsdistexponentialBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_buffer_mean(s : StatsdistexponentialBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_buffer_scale(s : StatsdistexponentialBuffer, f : Double) -> StatsdistexponentialBuffer {
  let result = stats_dist_exponential_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_buffer_add(a : StatsdistexponentialBuffer, b : StatsdistexponentialBuffer) -> StatsdistexponentialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_buffer_copy(s : StatsdistexponentialBuffer) -> StatsdistexponentialBuffer {
  let result = stats_dist_exponential_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_buffer_fill(s : StatsdistexponentialBuffer, v : Double) -> StatsdistexponentialBuffer {
  let result = stats_dist_exponential_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_buffer_min(s : StatsdistexponentialBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_buffer_max(s : StatsdistexponentialBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_buffer_to_string(s : StatsdistexponentialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_cursor_make(size : Int) -> StatsdistexponentialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_cursor_len(s : StatsdistexponentialCursor) -> Int { s.size }

pub fn stats_dist_exponential_cursor_get(s : StatsdistexponentialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_cursor_set(s : StatsdistexponentialCursor, i : Int, v : Double) -> StatsdistexponentialCursor {
  let result = stats_dist_exponential_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_cursor_sum(s : StatsdistexponentialCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_cursor_mean(s : StatsdistexponentialCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_cursor_scale(s : StatsdistexponentialCursor, f : Double) -> StatsdistexponentialCursor {
  let result = stats_dist_exponential_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_cursor_add(a : StatsdistexponentialCursor, b : StatsdistexponentialCursor) -> StatsdistexponentialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_cursor_copy(s : StatsdistexponentialCursor) -> StatsdistexponentialCursor {
  let result = stats_dist_exponential_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_cursor_fill(s : StatsdistexponentialCursor, v : Double) -> StatsdistexponentialCursor {
  let result = stats_dist_exponential_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_cursor_min(s : StatsdistexponentialCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_cursor_max(s : StatsdistexponentialCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_cursor_to_string(s : StatsdistexponentialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_view_make(size : Int) -> StatsdistexponentialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_view_len(s : StatsdistexponentialView) -> Int { s.size }

pub fn stats_dist_exponential_view_get(s : StatsdistexponentialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_view_set(s : StatsdistexponentialView, i : Int, v : Double) -> StatsdistexponentialView {
  let result = stats_dist_exponential_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_view_sum(s : StatsdistexponentialView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_view_mean(s : StatsdistexponentialView) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_view_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_view_scale(s : StatsdistexponentialView, f : Double) -> StatsdistexponentialView {
  let result = stats_dist_exponential_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_view_add(a : StatsdistexponentialView, b : StatsdistexponentialView) -> StatsdistexponentialView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_view_copy(s : StatsdistexponentialView) -> StatsdistexponentialView {
  let result = stats_dist_exponential_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_view_fill(s : StatsdistexponentialView, v : Double) -> StatsdistexponentialView {
  let result = stats_dist_exponential_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_view_min(s : StatsdistexponentialView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_view_max(s : StatsdistexponentialView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_view_to_string(s : StatsdistexponentialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_range_make(size : Int) -> StatsdistexponentialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_range_len(s : StatsdistexponentialRange) -> Int { s.size }

pub fn stats_dist_exponential_range_get(s : StatsdistexponentialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_range_set(s : StatsdistexponentialRange, i : Int, v : Double) -> StatsdistexponentialRange {
  let result = stats_dist_exponential_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_range_sum(s : StatsdistexponentialRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_range_mean(s : StatsdistexponentialRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_range_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_range_scale(s : StatsdistexponentialRange, f : Double) -> StatsdistexponentialRange {
  let result = stats_dist_exponential_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_range_add(a : StatsdistexponentialRange, b : StatsdistexponentialRange) -> StatsdistexponentialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_range_copy(s : StatsdistexponentialRange) -> StatsdistexponentialRange {
  let result = stats_dist_exponential_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_range_fill(s : StatsdistexponentialRange, v : Double) -> StatsdistexponentialRange {
  let result = stats_dist_exponential_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_range_min(s : StatsdistexponentialRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_range_max(s : StatsdistexponentialRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_range_to_string(s : StatsdistexponentialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistexponentialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_exponential_slice_make(size : Int) -> StatsdistexponentialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_exponential_slice_len(s : StatsdistexponentialSlice) -> Int { s.size }

pub fn stats_dist_exponential_slice_get(s : StatsdistexponentialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_exponential_slice_set(s : StatsdistexponentialSlice, i : Int, v : Double) -> StatsdistexponentialSlice {
  let result = stats_dist_exponential_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_slice_sum(s : StatsdistexponentialSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_exponential_slice_mean(s : StatsdistexponentialSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_exponential_slice_sum(s) / s.size.to_double() }
}

pub fn stats_dist_exponential_slice_scale(s : StatsdistexponentialSlice, f : Double) -> StatsdistexponentialSlice {
  let result = stats_dist_exponential_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_exponential_slice_add(a : StatsdistexponentialSlice, b : StatsdistexponentialSlice) -> StatsdistexponentialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_exponential_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_exponential_slice_copy(s : StatsdistexponentialSlice) -> StatsdistexponentialSlice {
  let result = stats_dist_exponential_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_exponential_slice_fill(s : StatsdistexponentialSlice, v : Double) -> StatsdistexponentialSlice {
  let result = stats_dist_exponential_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_exponential_slice_min(s : StatsdistexponentialSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_slice_max(s : StatsdistexponentialSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_exponential_slice_to_string(s : StatsdistexponentialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

