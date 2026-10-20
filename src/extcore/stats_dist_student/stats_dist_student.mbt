///===
/// extcore/stats_dist_student

pub(all) struct StatsdiststudentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_student_make_point(x : Double, y : Double) -> StatsdiststudentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_student_make_point3(x : Double, y : Double, z : Double) -> StatsdiststudentPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_student_point_x(pt : StatsdiststudentPoint) -> Double { pt.x }

pub fn stats_dist_student_point_y(pt : StatsdiststudentPoint) -> Double { pt.y }

pub fn stats_dist_student_point_z(pt : StatsdiststudentPoint) -> Double { pt.z }

pub fn stats_dist_student_point_label(pt : StatsdiststudentPoint) -> Int { pt.label }

pub fn stats_dist_student_point_dist(a : StatsdiststudentPoint, b : StatsdiststudentPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_student_point_add(a : StatsdiststudentPoint, b : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_student_point_sub(a : StatsdiststudentPoint, b : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_student_point_scale(pt : StatsdiststudentPoint, s : Double) -> StatsdiststudentPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_student_point_dot(a : StatsdiststudentPoint, b : StatsdiststudentPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_student_point_cross(a : StatsdiststudentPoint, b : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_student_point_norm(pt : StatsdiststudentPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_student_point_normalize(pt : StatsdiststudentPoint) -> StatsdiststudentPoint {
  let n = stats_dist_student_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_student_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_student_point_negate(pt : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_student_point_mid(a : StatsdiststudentPoint, b : StatsdiststudentPoint) -> StatsdiststudentPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_student_point_lerp(a : StatsdiststudentPoint, b : StatsdiststudentPoint, t : Double) -> StatsdiststudentPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_student_point_to_string(pt : StatsdiststudentPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdiststudentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_student_make_series(vals : Array[Double], name : String) -> StatsdiststudentSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_student_series_len(s : StatsdiststudentSeries) -> Int { s.vals.length() }

pub fn stats_dist_student_series_sum(s : StatsdiststudentSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_dist_student_series_mean(s : StatsdiststudentSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_dist_student_series_min(s : StatsdiststudentSeries) -> Double { @_common.min(s.vals) }

pub fn stats_dist_student_series_max(s : StatsdiststudentSeries) -> Double { @_common.max(s.vals) }

pub fn stats_dist_student_series_range(s : StatsdiststudentSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_dist_student_series_var(s : StatsdiststudentSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_dist_student_series_std(s : StatsdiststudentSeries) -> Double { @_common.std(s.vals) }

pub fn stats_dist_student_series_median(s : StatsdiststudentSeries) -> Double { @_common.median(s.vals) }

pub fn stats_dist_student_series_scale(s : StatsdiststudentSeries, f : Double) -> StatsdiststudentSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_student_series_add(a : StatsdiststudentSeries, b : StatsdiststudentSeries) -> StatsdiststudentSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_student_series_sub(a : StatsdiststudentSeries, b : StatsdiststudentSeries) -> StatsdiststudentSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_student_series_normalize(s : StatsdiststudentSeries) -> StatsdiststudentSeries {
  let mn = stats_dist_student_series_min(s)
  let mx = stats_dist_student_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_student_series_cumsum(s : StatsdiststudentSeries) -> StatsdiststudentSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_student_series_to_string(s : StatsdiststudentSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdiststudentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_student_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdiststudentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_student_matrix_identity(n : Int) -> StatsdiststudentMatrix {
  let m = stats_dist_student_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_student_matrix_get(m : StatsdiststudentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_student_matrix_transpose(m : StatsdiststudentMatrix) -> StatsdiststudentMatrix {
  let result = stats_dist_student_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_student_matrix_add(a : StatsdiststudentMatrix, b : StatsdiststudentMatrix) -> StatsdiststudentMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_student_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_student_matrix_scale(m : StatsdiststudentMatrix, s : Double) -> StatsdiststudentMatrix {
  let result = stats_dist_student_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_student_matrix_multiply(a : StatsdiststudentMatrix, b : StatsdiststudentMatrix) -> StatsdiststudentMatrix {
  if a.cols != b.rows { return stats_dist_student_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_student_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_student_matrix_trace(m : StatsdiststudentMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_student_matrix_det(m : StatsdiststudentMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_student_matrix_norm(m : StatsdiststudentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_student_matrix_to_string(m : StatsdiststudentMatrix) -> String {
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

pub(all) struct StatsdiststudentVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_student_make_vector(comps : Array[Double]) -> StatsdiststudentVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_student_vector_zero(dim : Int) -> StatsdiststudentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_student_vector_add(a : StatsdiststudentVector, b : StatsdiststudentVector) -> StatsdiststudentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_student_vector_sub(a : StatsdiststudentVector, b : StatsdiststudentVector) -> StatsdiststudentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_student_vector_scale(v : StatsdiststudentVector, s : Double) -> StatsdiststudentVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_student_vector_dot(a : StatsdiststudentVector, b : StatsdiststudentVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_student_vector_norm(v : StatsdiststudentVector) -> Double { @_common.sqrt(stats_dist_student_vector_dot(v, v)) }

pub fn stats_dist_student_vector_normalize(v : StatsdiststudentVector) -> StatsdiststudentVector {
  let n = stats_dist_student_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_student_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_student_vector_dist(a : StatsdiststudentVector, b : StatsdiststudentVector) -> Double {
  stats_dist_student_vector_norm(stats_dist_student_vector_sub(a, b))
}

pub fn stats_dist_student_vector_to_string(v : StatsdiststudentVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_student_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_student_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_student_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_student_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_student_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_student_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_student_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_student_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_student_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_student_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_student_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_student_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_student_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_student_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_student_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_student_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_student_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_student_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_student_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_student_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_student_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_student_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_student_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_student_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_student_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_student_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_student_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_student_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_student_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdiststudentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_frame_make(size : Int) -> StatsdiststudentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_frame_len(s : StatsdiststudentFrame) -> Int { s.size }

pub fn stats_dist_student_frame_get(s : StatsdiststudentFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_frame_set(s : StatsdiststudentFrame, i : Int, v : Double) -> StatsdiststudentFrame {
  let result = stats_dist_student_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_frame_sum(s : StatsdiststudentFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_frame_mean(s : StatsdiststudentFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_frame_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_frame_scale(s : StatsdiststudentFrame, f : Double) -> StatsdiststudentFrame {
  let result = stats_dist_student_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_frame_add(a : StatsdiststudentFrame, b : StatsdiststudentFrame) -> StatsdiststudentFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_frame_copy(s : StatsdiststudentFrame) -> StatsdiststudentFrame {
  let result = stats_dist_student_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_frame_fill(s : StatsdiststudentFrame, v : Double) -> StatsdiststudentFrame {
  let result = stats_dist_student_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_frame_min(s : StatsdiststudentFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_frame_max(s : StatsdiststudentFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_frame_to_string(s : StatsdiststudentFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_table_make(size : Int) -> StatsdiststudentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_table_len(s : StatsdiststudentTable) -> Int { s.size }

pub fn stats_dist_student_table_get(s : StatsdiststudentTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_table_set(s : StatsdiststudentTable, i : Int, v : Double) -> StatsdiststudentTable {
  let result = stats_dist_student_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_table_sum(s : StatsdiststudentTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_table_mean(s : StatsdiststudentTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_table_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_table_scale(s : StatsdiststudentTable, f : Double) -> StatsdiststudentTable {
  let result = stats_dist_student_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_table_add(a : StatsdiststudentTable, b : StatsdiststudentTable) -> StatsdiststudentTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_table_copy(s : StatsdiststudentTable) -> StatsdiststudentTable {
  let result = stats_dist_student_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_table_fill(s : StatsdiststudentTable, v : Double) -> StatsdiststudentTable {
  let result = stats_dist_student_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_table_min(s : StatsdiststudentTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_table_max(s : StatsdiststudentTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_table_to_string(s : StatsdiststudentTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_graphn_make(size : Int) -> StatsdiststudentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_graphn_len(s : StatsdiststudentGraphN) -> Int { s.size }

pub fn stats_dist_student_graphn_get(s : StatsdiststudentGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_graphn_set(s : StatsdiststudentGraphN, i : Int, v : Double) -> StatsdiststudentGraphN {
  let result = stats_dist_student_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_graphn_sum(s : StatsdiststudentGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_graphn_mean(s : StatsdiststudentGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_graphn_scale(s : StatsdiststudentGraphN, f : Double) -> StatsdiststudentGraphN {
  let result = stats_dist_student_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_graphn_add(a : StatsdiststudentGraphN, b : StatsdiststudentGraphN) -> StatsdiststudentGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_graphn_copy(s : StatsdiststudentGraphN) -> StatsdiststudentGraphN {
  let result = stats_dist_student_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_graphn_fill(s : StatsdiststudentGraphN, v : Double) -> StatsdiststudentGraphN {
  let result = stats_dist_student_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_graphn_min(s : StatsdiststudentGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_graphn_max(s : StatsdiststudentGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_graphn_to_string(s : StatsdiststudentGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_node_make(size : Int) -> StatsdiststudentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_node_len(s : StatsdiststudentNode) -> Int { s.size }

pub fn stats_dist_student_node_get(s : StatsdiststudentNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_node_set(s : StatsdiststudentNode, i : Int, v : Double) -> StatsdiststudentNode {
  let result = stats_dist_student_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_node_sum(s : StatsdiststudentNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_node_mean(s : StatsdiststudentNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_node_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_node_scale(s : StatsdiststudentNode, f : Double) -> StatsdiststudentNode {
  let result = stats_dist_student_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_node_add(a : StatsdiststudentNode, b : StatsdiststudentNode) -> StatsdiststudentNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_node_copy(s : StatsdiststudentNode) -> StatsdiststudentNode {
  let result = stats_dist_student_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_node_fill(s : StatsdiststudentNode, v : Double) -> StatsdiststudentNode {
  let result = stats_dist_student_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_node_min(s : StatsdiststudentNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_node_max(s : StatsdiststudentNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_node_to_string(s : StatsdiststudentNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_edge_make(size : Int) -> StatsdiststudentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_edge_len(s : StatsdiststudentEdge) -> Int { s.size }

pub fn stats_dist_student_edge_get(s : StatsdiststudentEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_edge_set(s : StatsdiststudentEdge, i : Int, v : Double) -> StatsdiststudentEdge {
  let result = stats_dist_student_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_edge_sum(s : StatsdiststudentEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_edge_mean(s : StatsdiststudentEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_edge_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_edge_scale(s : StatsdiststudentEdge, f : Double) -> StatsdiststudentEdge {
  let result = stats_dist_student_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_edge_add(a : StatsdiststudentEdge, b : StatsdiststudentEdge) -> StatsdiststudentEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_edge_copy(s : StatsdiststudentEdge) -> StatsdiststudentEdge {
  let result = stats_dist_student_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_edge_fill(s : StatsdiststudentEdge, v : Double) -> StatsdiststudentEdge {
  let result = stats_dist_student_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_edge_min(s : StatsdiststudentEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_edge_max(s : StatsdiststudentEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_edge_to_string(s : StatsdiststudentEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_path_make(size : Int) -> StatsdiststudentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_path_len(s : StatsdiststudentPath) -> Int { s.size }

pub fn stats_dist_student_path_get(s : StatsdiststudentPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_path_set(s : StatsdiststudentPath, i : Int, v : Double) -> StatsdiststudentPath {
  let result = stats_dist_student_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_path_sum(s : StatsdiststudentPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_path_mean(s : StatsdiststudentPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_path_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_path_scale(s : StatsdiststudentPath, f : Double) -> StatsdiststudentPath {
  let result = stats_dist_student_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_path_add(a : StatsdiststudentPath, b : StatsdiststudentPath) -> StatsdiststudentPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_path_copy(s : StatsdiststudentPath) -> StatsdiststudentPath {
  let result = stats_dist_student_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_path_fill(s : StatsdiststudentPath, v : Double) -> StatsdiststudentPath {
  let result = stats_dist_student_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_path_min(s : StatsdiststudentPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_path_max(s : StatsdiststudentPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_path_to_string(s : StatsdiststudentPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_cluster_make(size : Int) -> StatsdiststudentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_cluster_len(s : StatsdiststudentCluster) -> Int { s.size }

pub fn stats_dist_student_cluster_get(s : StatsdiststudentCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_cluster_set(s : StatsdiststudentCluster, i : Int, v : Double) -> StatsdiststudentCluster {
  let result = stats_dist_student_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_cluster_sum(s : StatsdiststudentCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_cluster_mean(s : StatsdiststudentCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_cluster_scale(s : StatsdiststudentCluster, f : Double) -> StatsdiststudentCluster {
  let result = stats_dist_student_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_cluster_add(a : StatsdiststudentCluster, b : StatsdiststudentCluster) -> StatsdiststudentCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_cluster_copy(s : StatsdiststudentCluster) -> StatsdiststudentCluster {
  let result = stats_dist_student_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_cluster_fill(s : StatsdiststudentCluster, v : Double) -> StatsdiststudentCluster {
  let result = stats_dist_student_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_cluster_min(s : StatsdiststudentCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_cluster_max(s : StatsdiststudentCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_cluster_to_string(s : StatsdiststudentCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_model_make(size : Int) -> StatsdiststudentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_model_len(s : StatsdiststudentModel) -> Int { s.size }

pub fn stats_dist_student_model_get(s : StatsdiststudentModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_model_set(s : StatsdiststudentModel, i : Int, v : Double) -> StatsdiststudentModel {
  let result = stats_dist_student_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_model_sum(s : StatsdiststudentModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_model_mean(s : StatsdiststudentModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_model_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_model_scale(s : StatsdiststudentModel, f : Double) -> StatsdiststudentModel {
  let result = stats_dist_student_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_model_add(a : StatsdiststudentModel, b : StatsdiststudentModel) -> StatsdiststudentModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_model_copy(s : StatsdiststudentModel) -> StatsdiststudentModel {
  let result = stats_dist_student_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_model_fill(s : StatsdiststudentModel, v : Double) -> StatsdiststudentModel {
  let result = stats_dist_student_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_model_min(s : StatsdiststudentModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_model_max(s : StatsdiststudentModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_model_to_string(s : StatsdiststudentModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_layer_make(size : Int) -> StatsdiststudentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_layer_len(s : StatsdiststudentLayer) -> Int { s.size }

pub fn stats_dist_student_layer_get(s : StatsdiststudentLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_layer_set(s : StatsdiststudentLayer, i : Int, v : Double) -> StatsdiststudentLayer {
  let result = stats_dist_student_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_layer_sum(s : StatsdiststudentLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_layer_mean(s : StatsdiststudentLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_layer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_layer_scale(s : StatsdiststudentLayer, f : Double) -> StatsdiststudentLayer {
  let result = stats_dist_student_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_layer_add(a : StatsdiststudentLayer, b : StatsdiststudentLayer) -> StatsdiststudentLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_layer_copy(s : StatsdiststudentLayer) -> StatsdiststudentLayer {
  let result = stats_dist_student_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_layer_fill(s : StatsdiststudentLayer, v : Double) -> StatsdiststudentLayer {
  let result = stats_dist_student_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_layer_min(s : StatsdiststudentLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_layer_max(s : StatsdiststudentLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_layer_to_string(s : StatsdiststudentLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_buffer_make(size : Int) -> StatsdiststudentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_buffer_len(s : StatsdiststudentBuffer) -> Int { s.size }

pub fn stats_dist_student_buffer_get(s : StatsdiststudentBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_buffer_set(s : StatsdiststudentBuffer, i : Int, v : Double) -> StatsdiststudentBuffer {
  let result = stats_dist_student_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_buffer_sum(s : StatsdiststudentBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_buffer_mean(s : StatsdiststudentBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_buffer_scale(s : StatsdiststudentBuffer, f : Double) -> StatsdiststudentBuffer {
  let result = stats_dist_student_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_buffer_add(a : StatsdiststudentBuffer, b : StatsdiststudentBuffer) -> StatsdiststudentBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_buffer_copy(s : StatsdiststudentBuffer) -> StatsdiststudentBuffer {
  let result = stats_dist_student_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_buffer_fill(s : StatsdiststudentBuffer, v : Double) -> StatsdiststudentBuffer {
  let result = stats_dist_student_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_buffer_min(s : StatsdiststudentBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_buffer_max(s : StatsdiststudentBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_buffer_to_string(s : StatsdiststudentBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_cursor_make(size : Int) -> StatsdiststudentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_cursor_len(s : StatsdiststudentCursor) -> Int { s.size }

pub fn stats_dist_student_cursor_get(s : StatsdiststudentCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_cursor_set(s : StatsdiststudentCursor, i : Int, v : Double) -> StatsdiststudentCursor {
  let result = stats_dist_student_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_cursor_sum(s : StatsdiststudentCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_cursor_mean(s : StatsdiststudentCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_cursor_scale(s : StatsdiststudentCursor, f : Double) -> StatsdiststudentCursor {
  let result = stats_dist_student_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_cursor_add(a : StatsdiststudentCursor, b : StatsdiststudentCursor) -> StatsdiststudentCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_cursor_copy(s : StatsdiststudentCursor) -> StatsdiststudentCursor {
  let result = stats_dist_student_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_cursor_fill(s : StatsdiststudentCursor, v : Double) -> StatsdiststudentCursor {
  let result = stats_dist_student_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_cursor_min(s : StatsdiststudentCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_cursor_max(s : StatsdiststudentCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_cursor_to_string(s : StatsdiststudentCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_view_make(size : Int) -> StatsdiststudentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_view_len(s : StatsdiststudentView) -> Int { s.size }

pub fn stats_dist_student_view_get(s : StatsdiststudentView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_view_set(s : StatsdiststudentView, i : Int, v : Double) -> StatsdiststudentView {
  let result = stats_dist_student_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_view_sum(s : StatsdiststudentView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_view_mean(s : StatsdiststudentView) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_view_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_view_scale(s : StatsdiststudentView, f : Double) -> StatsdiststudentView {
  let result = stats_dist_student_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_view_add(a : StatsdiststudentView, b : StatsdiststudentView) -> StatsdiststudentView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_view_copy(s : StatsdiststudentView) -> StatsdiststudentView {
  let result = stats_dist_student_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_view_fill(s : StatsdiststudentView, v : Double) -> StatsdiststudentView {
  let result = stats_dist_student_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_view_min(s : StatsdiststudentView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_view_max(s : StatsdiststudentView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_view_to_string(s : StatsdiststudentView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_range_make(size : Int) -> StatsdiststudentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_range_len(s : StatsdiststudentRange) -> Int { s.size }

pub fn stats_dist_student_range_get(s : StatsdiststudentRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_range_set(s : StatsdiststudentRange, i : Int, v : Double) -> StatsdiststudentRange {
  let result = stats_dist_student_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_range_sum(s : StatsdiststudentRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_range_mean(s : StatsdiststudentRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_range_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_range_scale(s : StatsdiststudentRange, f : Double) -> StatsdiststudentRange {
  let result = stats_dist_student_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_range_add(a : StatsdiststudentRange, b : StatsdiststudentRange) -> StatsdiststudentRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_range_copy(s : StatsdiststudentRange) -> StatsdiststudentRange {
  let result = stats_dist_student_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_range_fill(s : StatsdiststudentRange, v : Double) -> StatsdiststudentRange {
  let result = stats_dist_student_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_range_min(s : StatsdiststudentRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_range_max(s : StatsdiststudentRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_range_to_string(s : StatsdiststudentRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdiststudentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_student_slice_make(size : Int) -> StatsdiststudentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_student_slice_len(s : StatsdiststudentSlice) -> Int { s.size }

pub fn stats_dist_student_slice_get(s : StatsdiststudentSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_student_slice_set(s : StatsdiststudentSlice, i : Int, v : Double) -> StatsdiststudentSlice {
  let result = stats_dist_student_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_slice_sum(s : StatsdiststudentSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_student_slice_mean(s : StatsdiststudentSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_student_slice_sum(s) / s.size.to_double() }
}

pub fn stats_dist_student_slice_scale(s : StatsdiststudentSlice, f : Double) -> StatsdiststudentSlice {
  let result = stats_dist_student_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_student_slice_add(a : StatsdiststudentSlice, b : StatsdiststudentSlice) -> StatsdiststudentSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_student_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_student_slice_copy(s : StatsdiststudentSlice) -> StatsdiststudentSlice {
  let result = stats_dist_student_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_student_slice_fill(s : StatsdiststudentSlice, v : Double) -> StatsdiststudentSlice {
  let result = stats_dist_student_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_student_slice_min(s : StatsdiststudentSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_slice_max(s : StatsdiststudentSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_student_slice_to_string(s : StatsdiststudentSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

