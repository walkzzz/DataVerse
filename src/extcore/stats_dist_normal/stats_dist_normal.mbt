///===
/// extcore/stats_dist_normal

pub(all) struct StatsdistnormalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_normal_make_point(x : Double, y : Double) -> StatsdistnormalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_normal_make_point3(x : Double, y : Double, z : Double) -> StatsdistnormalPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_normal_point_x(pt : StatsdistnormalPoint) -> Double { pt.x }

pub fn stats_dist_normal_point_y(pt : StatsdistnormalPoint) -> Double { pt.y }

pub fn stats_dist_normal_point_z(pt : StatsdistnormalPoint) -> Double { pt.z }

pub fn stats_dist_normal_point_label(pt : StatsdistnormalPoint) -> Int { pt.label }

pub fn stats_dist_normal_point_dist(a : StatsdistnormalPoint, b : StatsdistnormalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_normal_point_add(a : StatsdistnormalPoint, b : StatsdistnormalPoint) -> StatsdistnormalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_normal_point_sub(a : StatsdistnormalPoint, b : StatsdistnormalPoint) -> StatsdistnormalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_normal_point_scale(pt : StatsdistnormalPoint, s : Double) -> StatsdistnormalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_normal_point_dot(a : StatsdistnormalPoint, b : StatsdistnormalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_normal_point_cross(a : StatsdistnormalPoint, b : StatsdistnormalPoint) -> StatsdistnormalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_normal_point_norm(pt : StatsdistnormalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_normal_point_normalize(pt : StatsdistnormalPoint) -> StatsdistnormalPoint {
  let n = stats_dist_normal_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_normal_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_normal_point_negate(pt : StatsdistnormalPoint) -> StatsdistnormalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_normal_point_mid(a : StatsdistnormalPoint, b : StatsdistnormalPoint) -> StatsdistnormalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_normal_point_lerp(a : StatsdistnormalPoint, b : StatsdistnormalPoint, t : Double) -> StatsdistnormalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_normal_point_to_string(pt : StatsdistnormalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistnormalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_normal_make_series(vals : Array[Double], name : String) -> StatsdistnormalSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_normal_series_len(s : StatsdistnormalSeries) -> Int { s.vals.length() }

pub fn stats_dist_normal_series_sum(s : StatsdistnormalSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_dist_normal_series_mean(s : StatsdistnormalSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_dist_normal_series_min(s : StatsdistnormalSeries) -> Double { @_common.min(s.vals) }

pub fn stats_dist_normal_series_max(s : StatsdistnormalSeries) -> Double { @_common.max(s.vals) }

pub fn stats_dist_normal_series_range(s : StatsdistnormalSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_dist_normal_series_var(s : StatsdistnormalSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_dist_normal_series_std(s : StatsdistnormalSeries) -> Double { @_common.std(s.vals) }

pub fn stats_dist_normal_series_median(s : StatsdistnormalSeries) -> Double { @_common.median(s.vals) }

pub fn stats_dist_normal_series_scale(s : StatsdistnormalSeries, f : Double) -> StatsdistnormalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_normal_series_add(a : StatsdistnormalSeries, b : StatsdistnormalSeries) -> StatsdistnormalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_normal_series_sub(a : StatsdistnormalSeries, b : StatsdistnormalSeries) -> StatsdistnormalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_normal_series_normalize(s : StatsdistnormalSeries) -> StatsdistnormalSeries {
  let mn = stats_dist_normal_series_min(s)
  let mx = stats_dist_normal_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_normal_series_cumsum(s : StatsdistnormalSeries) -> StatsdistnormalSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_normal_series_to_string(s : StatsdistnormalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistnormalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_normal_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistnormalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_normal_matrix_identity(n : Int) -> StatsdistnormalMatrix {
  let m = stats_dist_normal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_normal_matrix_get(m : StatsdistnormalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_normal_matrix_transpose(m : StatsdistnormalMatrix) -> StatsdistnormalMatrix {
  let result = stats_dist_normal_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_normal_matrix_add(a : StatsdistnormalMatrix, b : StatsdistnormalMatrix) -> StatsdistnormalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_normal_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_normal_matrix_scale(m : StatsdistnormalMatrix, s : Double) -> StatsdistnormalMatrix {
  let result = stats_dist_normal_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_normal_matrix_multiply(a : StatsdistnormalMatrix, b : StatsdistnormalMatrix) -> StatsdistnormalMatrix {
  if a.cols != b.rows { return stats_dist_normal_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_normal_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_normal_matrix_trace(m : StatsdistnormalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_normal_matrix_det(m : StatsdistnormalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_normal_matrix_norm(m : StatsdistnormalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_normal_matrix_to_string(m : StatsdistnormalMatrix) -> String {
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

pub(all) struct StatsdistnormalVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_normal_make_vector(comps : Array[Double]) -> StatsdistnormalVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_normal_vector_zero(dim : Int) -> StatsdistnormalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_normal_vector_add(a : StatsdistnormalVector, b : StatsdistnormalVector) -> StatsdistnormalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_normal_vector_sub(a : StatsdistnormalVector, b : StatsdistnormalVector) -> StatsdistnormalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_normal_vector_scale(v : StatsdistnormalVector, s : Double) -> StatsdistnormalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_normal_vector_dot(a : StatsdistnormalVector, b : StatsdistnormalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_normal_vector_norm(v : StatsdistnormalVector) -> Double { @_common.sqrt(stats_dist_normal_vector_dot(v, v)) }

pub fn stats_dist_normal_vector_normalize(v : StatsdistnormalVector) -> StatsdistnormalVector {
  let n = stats_dist_normal_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_normal_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_normal_vector_dist(a : StatsdistnormalVector, b : StatsdistnormalVector) -> Double {
  stats_dist_normal_vector_norm(stats_dist_normal_vector_sub(a, b))
}

pub fn stats_dist_normal_vector_to_string(v : StatsdistnormalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_normal_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_normal_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_normal_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_normal_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_normal_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_normal_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_normal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_normal_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_normal_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_normal_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_normal_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_normal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_normal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_normal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_normal_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_normal_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_normal_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_normal_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_normal_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_normal_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_normal_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_normal_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_normal_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_normal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_normal_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_normal_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_normal_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_normal_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_normal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistnormalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_frame_make(size : Int) -> StatsdistnormalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_frame_len(s : StatsdistnormalFrame) -> Int { s.size }

pub fn stats_dist_normal_frame_get(s : StatsdistnormalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_frame_set(s : StatsdistnormalFrame, i : Int, v : Double) -> StatsdistnormalFrame {
  let result = stats_dist_normal_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_frame_sum(s : StatsdistnormalFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_normal_frame_mean(s : StatsdistnormalFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_normal_frame_sum(s) / s.size.to_double() }
}

pub fn stats_dist_normal_frame_scale(s : StatsdistnormalFrame, f : Double) -> StatsdistnormalFrame {
  let result = stats_dist_normal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_normal_frame_add(a : StatsdistnormalFrame, b : StatsdistnormalFrame) -> StatsdistnormalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_normal_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_normal_frame_copy(s : StatsdistnormalFrame) -> StatsdistnormalFrame {
  let result = stats_dist_normal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_normal_frame_fill(s : StatsdistnormalFrame, v : Double) -> StatsdistnormalFrame {
  let result = stats_dist_normal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_frame_min(s : StatsdistnormalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_frame_max(s : StatsdistnormalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_frame_to_string(s : StatsdistnormalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_table_make(size : Int) -> StatsdistnormalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_table_len(s : StatsdistnormalTable) -> Int { s.size }

pub fn stats_dist_normal_table_get(s : StatsdistnormalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_table_set(s : StatsdistnormalTable, i : Int, v : Double) -> StatsdistnormalTable {
  let result = stats_dist_normal_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_table_sum(s : StatsdistnormalTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_normal_table_mean(s : StatsdistnormalTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_normal_table_sum(s) / s.size.to_double() }
}

pub fn stats_dist_normal_table_scale(s : StatsdistnormalTable, f : Double) -> StatsdistnormalTable {
  let result = stats_dist_normal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_normal_table_add(a : StatsdistnormalTable, b : StatsdistnormalTable) -> StatsdistnormalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_normal_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_normal_table_copy(s : StatsdistnormalTable) -> StatsdistnormalTable {
  let result = stats_dist_normal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_normal_table_fill(s : StatsdistnormalTable, v : Double) -> StatsdistnormalTable {
  let result = stats_dist_normal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_table_min(s : StatsdistnormalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_table_max(s : StatsdistnormalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_table_to_string(s : StatsdistnormalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_graphn_make(size : Int) -> StatsdistnormalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_graphn_len(s : StatsdistnormalGraphN) -> Int { s.size }

pub fn stats_dist_normal_graphn_get(s : StatsdistnormalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_graphn_set(s : StatsdistnormalGraphN, i : Int, v : Double) -> StatsdistnormalGraphN {
  let result = stats_dist_normal_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_graphn_sum(s : StatsdistnormalGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_normal_graphn_mean(s : StatsdistnormalGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_normal_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_dist_normal_graphn_scale(s : StatsdistnormalGraphN, f : Double) -> StatsdistnormalGraphN {
  let result = stats_dist_normal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_normal_graphn_add(a : StatsdistnormalGraphN, b : StatsdistnormalGraphN) -> StatsdistnormalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_normal_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_normal_graphn_copy(s : StatsdistnormalGraphN) -> StatsdistnormalGraphN {
  let result = stats_dist_normal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_normal_graphn_fill(s : StatsdistnormalGraphN, v : Double) -> StatsdistnormalGraphN {
  let result = stats_dist_normal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_graphn_min(s : StatsdistnormalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_graphn_max(s : StatsdistnormalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_graphn_to_string(s : StatsdistnormalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_node_make(size : Int) -> StatsdistnormalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_node_len(s : StatsdistnormalNode) -> Int { s.size }

pub fn stats_dist_normal_node_get(s : StatsdistnormalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_node_set(s : StatsdistnormalNode, i : Int, v : Double) -> StatsdistnormalNode {
  let result = stats_dist_normal_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_node_sum(s : StatsdistnormalNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_normal_node_mean(s : StatsdistnormalNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_normal_node_sum(s) / s.size.to_double() }
}

pub fn stats_dist_normal_node_scale(s : StatsdistnormalNode, f : Double) -> StatsdistnormalNode {
  let result = stats_dist_normal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_normal_node_add(a : StatsdistnormalNode, b : StatsdistnormalNode) -> StatsdistnormalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_normal_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_normal_node_copy(s : StatsdistnormalNode) -> StatsdistnormalNode {
  let result = stats_dist_normal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_normal_node_fill(s : StatsdistnormalNode, v : Double) -> StatsdistnormalNode {
  let result = stats_dist_normal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_node_min(s : StatsdistnormalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_node_max(s : StatsdistnormalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_node_to_string(s : StatsdistnormalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_edge_make(size : Int) -> StatsdistnormalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_edge_len(s : StatsdistnormalEdge) -> Int { s.size }

pub fn stats_dist_normal_edge_get(s : StatsdistnormalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_edge_set(s : StatsdistnormalEdge, i : Int, v : Double) -> StatsdistnormalEdge {
  let result = stats_dist_normal_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_edge_sum(s : StatsdistnormalEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_normal_edge_mean(s : StatsdistnormalEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_normal_edge_sum(s) / s.size.to_double() }
}

pub fn stats_dist_normal_edge_scale(s : StatsdistnormalEdge, f : Double) -> StatsdistnormalEdge {
  let result = stats_dist_normal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_normal_edge_add(a : StatsdistnormalEdge, b : StatsdistnormalEdge) -> StatsdistnormalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_normal_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_normal_edge_copy(s : StatsdistnormalEdge) -> StatsdistnormalEdge {
  let result = stats_dist_normal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_normal_edge_fill(s : StatsdistnormalEdge, v : Double) -> StatsdistnormalEdge {
  let result = stats_dist_normal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_edge_min(s : StatsdistnormalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_edge_max(s : StatsdistnormalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_edge_to_string(s : StatsdistnormalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_path_make(size : Int) -> StatsdistnormalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_path_len(s : StatsdistnormalPath) -> Int { s.size }

pub fn stats_dist_normal_path_get(s : StatsdistnormalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_path_set(s : StatsdistnormalPath, i : Int, v : Double) -> StatsdistnormalPath {
  let result = stats_dist_normal_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_path_sum(s : StatsdistnormalPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_normal_path_mean(s : StatsdistnormalPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_normal_path_sum(s) / s.size.to_double() }
}

pub fn stats_dist_normal_path_scale(s : StatsdistnormalPath, f : Double) -> StatsdistnormalPath {
  let result = stats_dist_normal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_normal_path_add(a : StatsdistnormalPath, b : StatsdistnormalPath) -> StatsdistnormalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_normal_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_normal_path_copy(s : StatsdistnormalPath) -> StatsdistnormalPath {
  let result = stats_dist_normal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_normal_path_fill(s : StatsdistnormalPath, v : Double) -> StatsdistnormalPath {
  let result = stats_dist_normal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_path_min(s : StatsdistnormalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_path_max(s : StatsdistnormalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_path_to_string(s : StatsdistnormalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_cluster_make(size : Int) -> StatsdistnormalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_cluster_len(s : StatsdistnormalCluster) -> Int { s.size }

pub fn stats_dist_normal_cluster_get(s : StatsdistnormalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_cluster_set(s : StatsdistnormalCluster, i : Int, v : Double) -> StatsdistnormalCluster {
  let result = stats_dist_normal_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_cluster_sum(s : StatsdistnormalCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_normal_cluster_mean(s : StatsdistnormalCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_normal_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_dist_normal_cluster_scale(s : StatsdistnormalCluster, f : Double) -> StatsdistnormalCluster {
  let result = stats_dist_normal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_normal_cluster_add(a : StatsdistnormalCluster, b : StatsdistnormalCluster) -> StatsdistnormalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_normal_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_normal_cluster_copy(s : StatsdistnormalCluster) -> StatsdistnormalCluster {
  let result = stats_dist_normal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_normal_cluster_fill(s : StatsdistnormalCluster, v : Double) -> StatsdistnormalCluster {
  let result = stats_dist_normal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_cluster_min(s : StatsdistnormalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_cluster_max(s : StatsdistnormalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_cluster_to_string(s : StatsdistnormalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_model_make(size : Int) -> StatsdistnormalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_model_len(s : StatsdistnormalModel) -> Int { s.size }

pub fn stats_dist_normal_model_get(s : StatsdistnormalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_model_set(s : StatsdistnormalModel, i : Int, v : Double) -> StatsdistnormalModel {
  let result = stats_dist_normal_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_model_sum(s : StatsdistnormalModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_normal_model_mean(s : StatsdistnormalModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_normal_model_sum(s) / s.size.to_double() }
}

pub fn stats_dist_normal_model_scale(s : StatsdistnormalModel, f : Double) -> StatsdistnormalModel {
  let result = stats_dist_normal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_normal_model_add(a : StatsdistnormalModel, b : StatsdistnormalModel) -> StatsdistnormalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_normal_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_normal_model_copy(s : StatsdistnormalModel) -> StatsdistnormalModel {
  let result = stats_dist_normal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_normal_model_fill(s : StatsdistnormalModel, v : Double) -> StatsdistnormalModel {
  let result = stats_dist_normal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_model_min(s : StatsdistnormalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_model_max(s : StatsdistnormalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_model_to_string(s : StatsdistnormalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_layer_make(size : Int) -> StatsdistnormalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_layer_len(s : StatsdistnormalLayer) -> Int { s.size }

pub fn stats_dist_normal_layer_get(s : StatsdistnormalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_layer_set(s : StatsdistnormalLayer, i : Int, v : Double) -> StatsdistnormalLayer {
  let result = stats_dist_normal_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_layer_sum(s : StatsdistnormalLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_normal_layer_mean(s : StatsdistnormalLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_normal_layer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_normal_layer_scale(s : StatsdistnormalLayer, f : Double) -> StatsdistnormalLayer {
  let result = stats_dist_normal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_normal_layer_add(a : StatsdistnormalLayer, b : StatsdistnormalLayer) -> StatsdistnormalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_normal_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_normal_layer_copy(s : StatsdistnormalLayer) -> StatsdistnormalLayer {
  let result = stats_dist_normal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_normal_layer_fill(s : StatsdistnormalLayer, v : Double) -> StatsdistnormalLayer {
  let result = stats_dist_normal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_layer_min(s : StatsdistnormalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_layer_max(s : StatsdistnormalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_layer_to_string(s : StatsdistnormalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_buffer_make(size : Int) -> StatsdistnormalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_buffer_len(s : StatsdistnormalBuffer) -> Int { s.size }

pub fn stats_dist_normal_buffer_get(s : StatsdistnormalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_buffer_set(s : StatsdistnormalBuffer, i : Int, v : Double) -> StatsdistnormalBuffer {
  let result = stats_dist_normal_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_buffer_sum(s : StatsdistnormalBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_normal_buffer_mean(s : StatsdistnormalBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_normal_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_normal_buffer_scale(s : StatsdistnormalBuffer, f : Double) -> StatsdistnormalBuffer {
  let result = stats_dist_normal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_normal_buffer_add(a : StatsdistnormalBuffer, b : StatsdistnormalBuffer) -> StatsdistnormalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_normal_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_normal_buffer_copy(s : StatsdistnormalBuffer) -> StatsdistnormalBuffer {
  let result = stats_dist_normal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_normal_buffer_fill(s : StatsdistnormalBuffer, v : Double) -> StatsdistnormalBuffer {
  let result = stats_dist_normal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_buffer_min(s : StatsdistnormalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_buffer_max(s : StatsdistnormalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_buffer_to_string(s : StatsdistnormalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_cursor_make(size : Int) -> StatsdistnormalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_cursor_len(s : StatsdistnormalCursor) -> Int { s.size }

pub fn stats_dist_normal_cursor_get(s : StatsdistnormalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_cursor_set(s : StatsdistnormalCursor, i : Int, v : Double) -> StatsdistnormalCursor {
  let result = stats_dist_normal_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_cursor_sum(s : StatsdistnormalCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_normal_cursor_mean(s : StatsdistnormalCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_normal_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_dist_normal_cursor_scale(s : StatsdistnormalCursor, f : Double) -> StatsdistnormalCursor {
  let result = stats_dist_normal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_normal_cursor_add(a : StatsdistnormalCursor, b : StatsdistnormalCursor) -> StatsdistnormalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_normal_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_normal_cursor_copy(s : StatsdistnormalCursor) -> StatsdistnormalCursor {
  let result = stats_dist_normal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_normal_cursor_fill(s : StatsdistnormalCursor, v : Double) -> StatsdistnormalCursor {
  let result = stats_dist_normal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_cursor_min(s : StatsdistnormalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_cursor_max(s : StatsdistnormalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_cursor_to_string(s : StatsdistnormalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_view_make(size : Int) -> StatsdistnormalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_view_len(s : StatsdistnormalView) -> Int { s.size }

pub fn stats_dist_normal_view_get(s : StatsdistnormalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_view_set(s : StatsdistnormalView, i : Int, v : Double) -> StatsdistnormalView {
  let result = stats_dist_normal_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_view_sum(s : StatsdistnormalView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_normal_view_mean(s : StatsdistnormalView) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_normal_view_sum(s) / s.size.to_double() }
}

pub fn stats_dist_normal_view_scale(s : StatsdistnormalView, f : Double) -> StatsdistnormalView {
  let result = stats_dist_normal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_normal_view_add(a : StatsdistnormalView, b : StatsdistnormalView) -> StatsdistnormalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_normal_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_normal_view_copy(s : StatsdistnormalView) -> StatsdistnormalView {
  let result = stats_dist_normal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_normal_view_fill(s : StatsdistnormalView, v : Double) -> StatsdistnormalView {
  let result = stats_dist_normal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_view_min(s : StatsdistnormalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_view_max(s : StatsdistnormalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_view_to_string(s : StatsdistnormalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_range_make(size : Int) -> StatsdistnormalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_range_len(s : StatsdistnormalRange) -> Int { s.size }

pub fn stats_dist_normal_range_get(s : StatsdistnormalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_range_set(s : StatsdistnormalRange, i : Int, v : Double) -> StatsdistnormalRange {
  let result = stats_dist_normal_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_range_sum(s : StatsdistnormalRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_normal_range_mean(s : StatsdistnormalRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_normal_range_sum(s) / s.size.to_double() }
}

pub fn stats_dist_normal_range_scale(s : StatsdistnormalRange, f : Double) -> StatsdistnormalRange {
  let result = stats_dist_normal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_normal_range_add(a : StatsdistnormalRange, b : StatsdistnormalRange) -> StatsdistnormalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_normal_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_normal_range_copy(s : StatsdistnormalRange) -> StatsdistnormalRange {
  let result = stats_dist_normal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_normal_range_fill(s : StatsdistnormalRange, v : Double) -> StatsdistnormalRange {
  let result = stats_dist_normal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_range_min(s : StatsdistnormalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_range_max(s : StatsdistnormalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_range_to_string(s : StatsdistnormalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistnormalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_normal_slice_make(size : Int) -> StatsdistnormalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_normal_slice_len(s : StatsdistnormalSlice) -> Int { s.size }

pub fn stats_dist_normal_slice_get(s : StatsdistnormalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_normal_slice_set(s : StatsdistnormalSlice, i : Int, v : Double) -> StatsdistnormalSlice {
  let result = stats_dist_normal_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_slice_sum(s : StatsdistnormalSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_normal_slice_mean(s : StatsdistnormalSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_normal_slice_sum(s) / s.size.to_double() }
}

pub fn stats_dist_normal_slice_scale(s : StatsdistnormalSlice, f : Double) -> StatsdistnormalSlice {
  let result = stats_dist_normal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_normal_slice_add(a : StatsdistnormalSlice, b : StatsdistnormalSlice) -> StatsdistnormalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_normal_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_normal_slice_copy(s : StatsdistnormalSlice) -> StatsdistnormalSlice {
  let result = stats_dist_normal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_normal_slice_fill(s : StatsdistnormalSlice, v : Double) -> StatsdistnormalSlice {
  let result = stats_dist_normal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_normal_slice_min(s : StatsdistnormalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_slice_max(s : StatsdistnormalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_normal_slice_to_string(s : StatsdistnormalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

