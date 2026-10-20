///===
/// extcore/stats_test_t

pub(all) struct StatstesttPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_t_make_point(x : Double, y : Double) -> StatstesttPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_t_make_point3(x : Double, y : Double, z : Double) -> StatstesttPoint {
  { x, y, z, label: 0 }
}

pub fn stats_test_t_point_x(pt : StatstesttPoint) -> Double { pt.x }

pub fn stats_test_t_point_y(pt : StatstesttPoint) -> Double { pt.y }

pub fn stats_test_t_point_z(pt : StatstesttPoint) -> Double { pt.z }

pub fn stats_test_t_point_label(pt : StatstesttPoint) -> Int { pt.label }

pub fn stats_test_t_point_dist(a : StatstesttPoint, b : StatstesttPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_test_t_point_add(a : StatstesttPoint, b : StatstesttPoint) -> StatstesttPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_test_t_point_sub(a : StatstesttPoint, b : StatstesttPoint) -> StatstesttPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_test_t_point_scale(pt : StatstesttPoint, s : Double) -> StatstesttPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_test_t_point_dot(a : StatstesttPoint, b : StatstesttPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_test_t_point_cross(a : StatstesttPoint, b : StatstesttPoint) -> StatstesttPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_test_t_point_norm(pt : StatstesttPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_test_t_point_normalize(pt : StatstesttPoint) -> StatstesttPoint {
  let n = stats_test_t_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_test_t_point_scale(pt, 1.0 / n) }
}

pub fn stats_test_t_point_negate(pt : StatstesttPoint) -> StatstesttPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_test_t_point_mid(a : StatstesttPoint, b : StatstesttPoint) -> StatstesttPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_test_t_point_lerp(a : StatstesttPoint, b : StatstesttPoint, t : Double) -> StatstesttPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_test_t_point_to_string(pt : StatstesttPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatstesttSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_t_make_series(vals : Array[Double], name : String) -> StatstesttSeries {
  { vals, name, meta: 0 }
}

pub fn stats_test_t_series_len(s : StatstesttSeries) -> Int { s.vals.length() }

pub fn stats_test_t_series_sum(s : StatstesttSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_test_t_series_mean(s : StatstesttSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_test_t_series_min(s : StatstesttSeries) -> Double { @_common.min(s.vals) }

pub fn stats_test_t_series_max(s : StatstesttSeries) -> Double { @_common.max(s.vals) }

pub fn stats_test_t_series_range(s : StatstesttSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_test_t_series_var(s : StatstesttSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_test_t_series_std(s : StatstesttSeries) -> Double { @_common.std(s.vals) }

pub fn stats_test_t_series_median(s : StatstesttSeries) -> Double { @_common.median(s.vals) }

pub fn stats_test_t_series_scale(s : StatstesttSeries, f : Double) -> StatstesttSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_test_t_series_add(a : StatstesttSeries, b : StatstesttSeries) -> StatstesttSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_test_t_series_sub(a : StatstesttSeries, b : StatstesttSeries) -> StatstesttSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_test_t_series_normalize(s : StatstesttSeries) -> StatstesttSeries {
  let mn = stats_test_t_series_min(s)
  let mx = stats_test_t_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_test_t_series_cumsum(s : StatstesttSeries) -> StatstesttSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_test_t_series_to_string(s : StatstesttSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstesttMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_t_make_matrix(rows : Int, cols : Int, val : Double) -> StatstesttMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_t_matrix_identity(n : Int) -> StatstesttMatrix {
  let m = stats_test_t_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_test_t_matrix_get(m : StatstesttMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_test_t_matrix_transpose(m : StatstesttMatrix) -> StatstesttMatrix {
  let result = stats_test_t_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_test_t_matrix_add(a : StatstesttMatrix, b : StatstesttMatrix) -> StatstesttMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_test_t_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_test_t_matrix_scale(m : StatstesttMatrix, s : Double) -> StatstesttMatrix {
  let result = stats_test_t_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_test_t_matrix_multiply(a : StatstesttMatrix, b : StatstesttMatrix) -> StatstesttMatrix {
  if a.cols != b.rows { return stats_test_t_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_test_t_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_test_t_matrix_trace(m : StatstesttMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_test_t_matrix_det(m : StatstesttMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_test_t_matrix_norm(m : StatstesttMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_test_t_matrix_to_string(m : StatstesttMatrix) -> String {
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

pub(all) struct StatstesttVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_t_make_vector(comps : Array[Double]) -> StatstesttVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_t_vector_zero(dim : Int) -> StatstesttVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_test_t_vector_add(a : StatstesttVector, b : StatstesttVector) -> StatstesttVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_t_vector_sub(a : StatstesttVector, b : StatstesttVector) -> StatstesttVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_t_vector_scale(v : StatstesttVector, s : Double) -> StatstesttVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_test_t_vector_dot(a : StatstesttVector, b : StatstesttVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_test_t_vector_norm(v : StatstesttVector) -> Double { @_common.sqrt(stats_test_t_vector_dot(v, v)) }

pub fn stats_test_t_vector_normalize(v : StatstesttVector) -> StatstesttVector {
  let n = stats_test_t_vector_norm(v)
  if n < 0.0000001 { v } else { stats_test_t_vector_scale(v, 1.0 / n) }
}

pub fn stats_test_t_vector_dist(a : StatstesttVector, b : StatstesttVector) -> Double {
  stats_test_t_vector_norm(stats_test_t_vector_sub(a, b))
}

pub fn stats_test_t_vector_to_string(v : StatstesttVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_t_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_test_t_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_test_t_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_test_t_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_test_t_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_test_t_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_test_t_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_test_t_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_test_t_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_test_t_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_test_t_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_test_t_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_test_t_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_test_t_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_test_t_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_test_t_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_test_t_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_test_t_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_test_t_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_test_t_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_test_t_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_test_t_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_test_t_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_test_t_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_test_t_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_test_t_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_test_t_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_test_t_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_test_t_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatstesttFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_frame_make(size : Int) -> StatstesttFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_frame_len(s : StatstesttFrame) -> Int { s.size }

pub fn stats_test_t_frame_get(s : StatstesttFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_frame_set(s : StatstesttFrame, i : Int, v : Double) -> StatstesttFrame {
  let result = stats_test_t_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_frame_sum(s : StatstesttFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_t_frame_mean(s : StatstesttFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_t_frame_sum(s) / s.size.to_double() }
}

pub fn stats_test_t_frame_scale(s : StatstesttFrame, f : Double) -> StatstesttFrame {
  let result = stats_test_t_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_t_frame_add(a : StatstesttFrame, b : StatstesttFrame) -> StatstesttFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_t_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_t_frame_copy(s : StatstesttFrame) -> StatstesttFrame {
  let result = stats_test_t_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_t_frame_fill(s : StatstesttFrame, v : Double) -> StatstesttFrame {
  let result = stats_test_t_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_frame_min(s : StatstesttFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_frame_max(s : StatstesttFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_frame_to_string(s : StatstesttFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_table_make(size : Int) -> StatstesttTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_table_len(s : StatstesttTable) -> Int { s.size }

pub fn stats_test_t_table_get(s : StatstesttTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_table_set(s : StatstesttTable, i : Int, v : Double) -> StatstesttTable {
  let result = stats_test_t_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_table_sum(s : StatstesttTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_t_table_mean(s : StatstesttTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_t_table_sum(s) / s.size.to_double() }
}

pub fn stats_test_t_table_scale(s : StatstesttTable, f : Double) -> StatstesttTable {
  let result = stats_test_t_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_t_table_add(a : StatstesttTable, b : StatstesttTable) -> StatstesttTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_t_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_t_table_copy(s : StatstesttTable) -> StatstesttTable {
  let result = stats_test_t_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_t_table_fill(s : StatstesttTable, v : Double) -> StatstesttTable {
  let result = stats_test_t_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_table_min(s : StatstesttTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_table_max(s : StatstesttTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_table_to_string(s : StatstesttTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_graphn_make(size : Int) -> StatstesttGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_graphn_len(s : StatstesttGraphN) -> Int { s.size }

pub fn stats_test_t_graphn_get(s : StatstesttGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_graphn_set(s : StatstesttGraphN, i : Int, v : Double) -> StatstesttGraphN {
  let result = stats_test_t_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_graphn_sum(s : StatstesttGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_t_graphn_mean(s : StatstesttGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_t_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_test_t_graphn_scale(s : StatstesttGraphN, f : Double) -> StatstesttGraphN {
  let result = stats_test_t_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_t_graphn_add(a : StatstesttGraphN, b : StatstesttGraphN) -> StatstesttGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_t_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_t_graphn_copy(s : StatstesttGraphN) -> StatstesttGraphN {
  let result = stats_test_t_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_t_graphn_fill(s : StatstesttGraphN, v : Double) -> StatstesttGraphN {
  let result = stats_test_t_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_graphn_min(s : StatstesttGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_graphn_max(s : StatstesttGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_graphn_to_string(s : StatstesttGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_node_make(size : Int) -> StatstesttNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_node_len(s : StatstesttNode) -> Int { s.size }

pub fn stats_test_t_node_get(s : StatstesttNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_node_set(s : StatstesttNode, i : Int, v : Double) -> StatstesttNode {
  let result = stats_test_t_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_node_sum(s : StatstesttNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_t_node_mean(s : StatstesttNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_t_node_sum(s) / s.size.to_double() }
}

pub fn stats_test_t_node_scale(s : StatstesttNode, f : Double) -> StatstesttNode {
  let result = stats_test_t_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_t_node_add(a : StatstesttNode, b : StatstesttNode) -> StatstesttNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_t_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_t_node_copy(s : StatstesttNode) -> StatstesttNode {
  let result = stats_test_t_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_t_node_fill(s : StatstesttNode, v : Double) -> StatstesttNode {
  let result = stats_test_t_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_node_min(s : StatstesttNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_node_max(s : StatstesttNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_node_to_string(s : StatstesttNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_edge_make(size : Int) -> StatstesttEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_edge_len(s : StatstesttEdge) -> Int { s.size }

pub fn stats_test_t_edge_get(s : StatstesttEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_edge_set(s : StatstesttEdge, i : Int, v : Double) -> StatstesttEdge {
  let result = stats_test_t_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_edge_sum(s : StatstesttEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_t_edge_mean(s : StatstesttEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_t_edge_sum(s) / s.size.to_double() }
}

pub fn stats_test_t_edge_scale(s : StatstesttEdge, f : Double) -> StatstesttEdge {
  let result = stats_test_t_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_t_edge_add(a : StatstesttEdge, b : StatstesttEdge) -> StatstesttEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_t_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_t_edge_copy(s : StatstesttEdge) -> StatstesttEdge {
  let result = stats_test_t_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_t_edge_fill(s : StatstesttEdge, v : Double) -> StatstesttEdge {
  let result = stats_test_t_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_edge_min(s : StatstesttEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_edge_max(s : StatstesttEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_edge_to_string(s : StatstesttEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_path_make(size : Int) -> StatstesttPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_path_len(s : StatstesttPath) -> Int { s.size }

pub fn stats_test_t_path_get(s : StatstesttPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_path_set(s : StatstesttPath, i : Int, v : Double) -> StatstesttPath {
  let result = stats_test_t_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_path_sum(s : StatstesttPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_t_path_mean(s : StatstesttPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_t_path_sum(s) / s.size.to_double() }
}

pub fn stats_test_t_path_scale(s : StatstesttPath, f : Double) -> StatstesttPath {
  let result = stats_test_t_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_t_path_add(a : StatstesttPath, b : StatstesttPath) -> StatstesttPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_t_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_t_path_copy(s : StatstesttPath) -> StatstesttPath {
  let result = stats_test_t_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_t_path_fill(s : StatstesttPath, v : Double) -> StatstesttPath {
  let result = stats_test_t_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_path_min(s : StatstesttPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_path_max(s : StatstesttPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_path_to_string(s : StatstesttPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_cluster_make(size : Int) -> StatstesttCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_cluster_len(s : StatstesttCluster) -> Int { s.size }

pub fn stats_test_t_cluster_get(s : StatstesttCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_cluster_set(s : StatstesttCluster, i : Int, v : Double) -> StatstesttCluster {
  let result = stats_test_t_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_cluster_sum(s : StatstesttCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_t_cluster_mean(s : StatstesttCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_t_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_test_t_cluster_scale(s : StatstesttCluster, f : Double) -> StatstesttCluster {
  let result = stats_test_t_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_t_cluster_add(a : StatstesttCluster, b : StatstesttCluster) -> StatstesttCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_t_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_t_cluster_copy(s : StatstesttCluster) -> StatstesttCluster {
  let result = stats_test_t_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_t_cluster_fill(s : StatstesttCluster, v : Double) -> StatstesttCluster {
  let result = stats_test_t_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_cluster_min(s : StatstesttCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_cluster_max(s : StatstesttCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_cluster_to_string(s : StatstesttCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_model_make(size : Int) -> StatstesttModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_model_len(s : StatstesttModel) -> Int { s.size }

pub fn stats_test_t_model_get(s : StatstesttModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_model_set(s : StatstesttModel, i : Int, v : Double) -> StatstesttModel {
  let result = stats_test_t_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_model_sum(s : StatstesttModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_t_model_mean(s : StatstesttModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_t_model_sum(s) / s.size.to_double() }
}

pub fn stats_test_t_model_scale(s : StatstesttModel, f : Double) -> StatstesttModel {
  let result = stats_test_t_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_t_model_add(a : StatstesttModel, b : StatstesttModel) -> StatstesttModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_t_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_t_model_copy(s : StatstesttModel) -> StatstesttModel {
  let result = stats_test_t_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_t_model_fill(s : StatstesttModel, v : Double) -> StatstesttModel {
  let result = stats_test_t_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_model_min(s : StatstesttModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_model_max(s : StatstesttModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_model_to_string(s : StatstesttModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_layer_make(size : Int) -> StatstesttLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_layer_len(s : StatstesttLayer) -> Int { s.size }

pub fn stats_test_t_layer_get(s : StatstesttLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_layer_set(s : StatstesttLayer, i : Int, v : Double) -> StatstesttLayer {
  let result = stats_test_t_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_layer_sum(s : StatstesttLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_t_layer_mean(s : StatstesttLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_t_layer_sum(s) / s.size.to_double() }
}

pub fn stats_test_t_layer_scale(s : StatstesttLayer, f : Double) -> StatstesttLayer {
  let result = stats_test_t_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_t_layer_add(a : StatstesttLayer, b : StatstesttLayer) -> StatstesttLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_t_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_t_layer_copy(s : StatstesttLayer) -> StatstesttLayer {
  let result = stats_test_t_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_t_layer_fill(s : StatstesttLayer, v : Double) -> StatstesttLayer {
  let result = stats_test_t_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_layer_min(s : StatstesttLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_layer_max(s : StatstesttLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_layer_to_string(s : StatstesttLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_buffer_make(size : Int) -> StatstesttBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_buffer_len(s : StatstesttBuffer) -> Int { s.size }

pub fn stats_test_t_buffer_get(s : StatstesttBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_buffer_set(s : StatstesttBuffer, i : Int, v : Double) -> StatstesttBuffer {
  let result = stats_test_t_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_buffer_sum(s : StatstesttBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_t_buffer_mean(s : StatstesttBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_t_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_test_t_buffer_scale(s : StatstesttBuffer, f : Double) -> StatstesttBuffer {
  let result = stats_test_t_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_t_buffer_add(a : StatstesttBuffer, b : StatstesttBuffer) -> StatstesttBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_t_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_t_buffer_copy(s : StatstesttBuffer) -> StatstesttBuffer {
  let result = stats_test_t_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_t_buffer_fill(s : StatstesttBuffer, v : Double) -> StatstesttBuffer {
  let result = stats_test_t_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_buffer_min(s : StatstesttBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_buffer_max(s : StatstesttBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_buffer_to_string(s : StatstesttBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_cursor_make(size : Int) -> StatstesttCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_cursor_len(s : StatstesttCursor) -> Int { s.size }

pub fn stats_test_t_cursor_get(s : StatstesttCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_cursor_set(s : StatstesttCursor, i : Int, v : Double) -> StatstesttCursor {
  let result = stats_test_t_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_cursor_sum(s : StatstesttCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_t_cursor_mean(s : StatstesttCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_t_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_test_t_cursor_scale(s : StatstesttCursor, f : Double) -> StatstesttCursor {
  let result = stats_test_t_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_t_cursor_add(a : StatstesttCursor, b : StatstesttCursor) -> StatstesttCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_t_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_t_cursor_copy(s : StatstesttCursor) -> StatstesttCursor {
  let result = stats_test_t_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_t_cursor_fill(s : StatstesttCursor, v : Double) -> StatstesttCursor {
  let result = stats_test_t_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_cursor_min(s : StatstesttCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_cursor_max(s : StatstesttCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_cursor_to_string(s : StatstesttCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_view_make(size : Int) -> StatstesttView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_view_len(s : StatstesttView) -> Int { s.size }

pub fn stats_test_t_view_get(s : StatstesttView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_view_set(s : StatstesttView, i : Int, v : Double) -> StatstesttView {
  let result = stats_test_t_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_view_sum(s : StatstesttView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_t_view_mean(s : StatstesttView) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_t_view_sum(s) / s.size.to_double() }
}

pub fn stats_test_t_view_scale(s : StatstesttView, f : Double) -> StatstesttView {
  let result = stats_test_t_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_t_view_add(a : StatstesttView, b : StatstesttView) -> StatstesttView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_t_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_t_view_copy(s : StatstesttView) -> StatstesttView {
  let result = stats_test_t_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_t_view_fill(s : StatstesttView, v : Double) -> StatstesttView {
  let result = stats_test_t_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_view_min(s : StatstesttView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_view_max(s : StatstesttView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_view_to_string(s : StatstesttView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_range_make(size : Int) -> StatstesttRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_range_len(s : StatstesttRange) -> Int { s.size }

pub fn stats_test_t_range_get(s : StatstesttRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_range_set(s : StatstesttRange, i : Int, v : Double) -> StatstesttRange {
  let result = stats_test_t_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_range_sum(s : StatstesttRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_t_range_mean(s : StatstesttRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_t_range_sum(s) / s.size.to_double() }
}

pub fn stats_test_t_range_scale(s : StatstesttRange, f : Double) -> StatstesttRange {
  let result = stats_test_t_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_t_range_add(a : StatstesttRange, b : StatstesttRange) -> StatstesttRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_t_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_t_range_copy(s : StatstesttRange) -> StatstesttRange {
  let result = stats_test_t_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_t_range_fill(s : StatstesttRange, v : Double) -> StatstesttRange {
  let result = stats_test_t_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_range_min(s : StatstesttRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_range_max(s : StatstesttRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_range_to_string(s : StatstesttRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstesttSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_t_slice_make(size : Int) -> StatstesttSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_t_slice_len(s : StatstesttSlice) -> Int { s.size }

pub fn stats_test_t_slice_get(s : StatstesttSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_t_slice_set(s : StatstesttSlice, i : Int, v : Double) -> StatstesttSlice {
  let result = stats_test_t_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_slice_sum(s : StatstesttSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_t_slice_mean(s : StatstesttSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_t_slice_sum(s) / s.size.to_double() }
}

pub fn stats_test_t_slice_scale(s : StatstesttSlice, f : Double) -> StatstesttSlice {
  let result = stats_test_t_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_t_slice_add(a : StatstesttSlice, b : StatstesttSlice) -> StatstesttSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_t_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_t_slice_copy(s : StatstesttSlice) -> StatstesttSlice {
  let result = stats_test_t_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_t_slice_fill(s : StatstesttSlice, v : Double) -> StatstesttSlice {
  let result = stats_test_t_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_t_slice_min(s : StatstesttSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_slice_max(s : StatstesttSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_t_slice_to_string(s : StatstesttSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

