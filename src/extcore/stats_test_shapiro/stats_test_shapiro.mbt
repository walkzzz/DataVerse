///===
/// extcore/stats_test_shapiro

pub(all) struct StatstestshapiroPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_shapiro_make_point(x : Double, y : Double) -> StatstestshapiroPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_shapiro_make_point3(x : Double, y : Double, z : Double) -> StatstestshapiroPoint {
  { x, y, z, label: 0 }
}

pub fn stats_test_shapiro_point_x(pt : StatstestshapiroPoint) -> Double { pt.x }

pub fn stats_test_shapiro_point_y(pt : StatstestshapiroPoint) -> Double { pt.y }

pub fn stats_test_shapiro_point_z(pt : StatstestshapiroPoint) -> Double { pt.z }

pub fn stats_test_shapiro_point_label(pt : StatstestshapiroPoint) -> Int { pt.label }

pub fn stats_test_shapiro_point_dist(a : StatstestshapiroPoint, b : StatstestshapiroPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_test_shapiro_point_add(a : StatstestshapiroPoint, b : StatstestshapiroPoint) -> StatstestshapiroPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_test_shapiro_point_sub(a : StatstestshapiroPoint, b : StatstestshapiroPoint) -> StatstestshapiroPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_test_shapiro_point_scale(pt : StatstestshapiroPoint, s : Double) -> StatstestshapiroPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_test_shapiro_point_dot(a : StatstestshapiroPoint, b : StatstestshapiroPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_test_shapiro_point_cross(a : StatstestshapiroPoint, b : StatstestshapiroPoint) -> StatstestshapiroPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_test_shapiro_point_norm(pt : StatstestshapiroPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_test_shapiro_point_normalize(pt : StatstestshapiroPoint) -> StatstestshapiroPoint {
  let n = stats_test_shapiro_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_test_shapiro_point_scale(pt, 1.0 / n) }
}

pub fn stats_test_shapiro_point_negate(pt : StatstestshapiroPoint) -> StatstestshapiroPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_test_shapiro_point_mid(a : StatstestshapiroPoint, b : StatstestshapiroPoint) -> StatstestshapiroPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_test_shapiro_point_lerp(a : StatstestshapiroPoint, b : StatstestshapiroPoint, t : Double) -> StatstestshapiroPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_test_shapiro_point_to_string(pt : StatstestshapiroPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatstestshapiroSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_shapiro_make_series(vals : Array[Double], name : String) -> StatstestshapiroSeries {
  { vals, name, meta: 0 }
}

pub fn stats_test_shapiro_series_len(s : StatstestshapiroSeries) -> Int { s.vals.length() }

pub fn stats_test_shapiro_series_sum(s : StatstestshapiroSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_test_shapiro_series_mean(s : StatstestshapiroSeries) -> Double {
  let n = stats_test_shapiro_series_len(s)
  if n == 0 { 0.0 } else { stats_test_shapiro_series_sum(s) / n.to_double() }
}

pub fn stats_test_shapiro_series_min(s : StatstestshapiroSeries) -> Double {
  let n = stats_test_shapiro_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_test_shapiro_series_max(s : StatstestshapiroSeries) -> Double {
  let n = stats_test_shapiro_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_test_shapiro_series_range(s : StatstestshapiroSeries) -> Double {
  stats_test_shapiro_series_max(s) - stats_test_shapiro_series_min(s)
}

pub fn stats_test_shapiro_series_var(s : StatstestshapiroSeries) -> Double {
  let n = stats_test_shapiro_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_test_shapiro_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_test_shapiro_series_std(s : StatstestshapiroSeries) -> Double { @_common.sqrt(stats_test_shapiro_series_var(s)) }

pub fn stats_test_shapiro_series_median(s : StatstestshapiroSeries) -> Double {
  let n = stats_test_shapiro_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_test_shapiro_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_test_shapiro_series_scale(s : StatstestshapiroSeries, f : Double) -> StatstestshapiroSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_test_shapiro_series_add(a : StatstestshapiroSeries, b : StatstestshapiroSeries) -> StatstestshapiroSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_test_shapiro_series_sub(a : StatstestshapiroSeries, b : StatstestshapiroSeries) -> StatstestshapiroSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_test_shapiro_series_normalize(s : StatstestshapiroSeries) -> StatstestshapiroSeries {
  let mn = stats_test_shapiro_series_min(s)
  let mx = stats_test_shapiro_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_test_shapiro_series_cumsum(s : StatstestshapiroSeries) -> StatstestshapiroSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_test_shapiro_series_to_string(s : StatstestshapiroSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestshapiroMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_shapiro_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestshapiroMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_shapiro_matrix_identity(n : Int) -> StatstestshapiroMatrix {
  let m = stats_test_shapiro_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_test_shapiro_matrix_get(m : StatstestshapiroMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_test_shapiro_matrix_transpose(m : StatstestshapiroMatrix) -> StatstestshapiroMatrix {
  let result = stats_test_shapiro_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_test_shapiro_matrix_add(a : StatstestshapiroMatrix, b : StatstestshapiroMatrix) -> StatstestshapiroMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_test_shapiro_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_test_shapiro_matrix_scale(m : StatstestshapiroMatrix, s : Double) -> StatstestshapiroMatrix {
  let result = stats_test_shapiro_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_test_shapiro_matrix_multiply(a : StatstestshapiroMatrix, b : StatstestshapiroMatrix) -> StatstestshapiroMatrix {
  if a.cols != b.rows { return stats_test_shapiro_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_test_shapiro_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_test_shapiro_matrix_trace(m : StatstestshapiroMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_test_shapiro_matrix_det(m : StatstestshapiroMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_test_shapiro_matrix_norm(m : StatstestshapiroMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_test_shapiro_matrix_to_string(m : StatstestshapiroMatrix) -> String {
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

pub(all) struct StatstestshapiroVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_shapiro_make_vector(comps : Array[Double]) -> StatstestshapiroVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_shapiro_vector_zero(dim : Int) -> StatstestshapiroVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_test_shapiro_vector_add(a : StatstestshapiroVector, b : StatstestshapiroVector) -> StatstestshapiroVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_shapiro_vector_sub(a : StatstestshapiroVector, b : StatstestshapiroVector) -> StatstestshapiroVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_test_shapiro_vector_scale(v : StatstestshapiroVector, s : Double) -> StatstestshapiroVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_test_shapiro_vector_dot(a : StatstestshapiroVector, b : StatstestshapiroVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_test_shapiro_vector_norm(v : StatstestshapiroVector) -> Double { @_common.sqrt(stats_test_shapiro_vector_dot(v, v)) }

pub fn stats_test_shapiro_vector_normalize(v : StatstestshapiroVector) -> StatstestshapiroVector {
  let n = stats_test_shapiro_vector_norm(v)
  if n < 0.0000001 { v } else { stats_test_shapiro_vector_scale(v, 1.0 / n) }
}

pub fn stats_test_shapiro_vector_dist(a : StatstestshapiroVector, b : StatstestshapiroVector) -> Double {
  stats_test_shapiro_vector_norm(stats_test_shapiro_vector_sub(a, b))
}

pub fn stats_test_shapiro_vector_to_string(v : StatstestshapiroVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_shapiro_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_test_shapiro_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_test_shapiro_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_test_shapiro_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_test_shapiro_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_test_shapiro_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_test_shapiro_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_test_shapiro_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_test_shapiro_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_test_shapiro_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_test_shapiro_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_test_shapiro_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_test_shapiro_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_test_shapiro_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_test_shapiro_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_test_shapiro_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_test_shapiro_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_test_shapiro_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_test_shapiro_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_test_shapiro_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_test_shapiro_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_test_shapiro_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_test_shapiro_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_test_shapiro_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_test_shapiro_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_test_shapiro_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_test_shapiro_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_test_shapiro_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_test_shapiro_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatstestshapiroFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_frame_make(size : Int) -> StatstestshapiroFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_frame_len(s : StatstestshapiroFrame) -> Int { s.size }

pub fn stats_test_shapiro_frame_get(s : StatstestshapiroFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_frame_set(s : StatstestshapiroFrame, i : Int, v : Double) -> StatstestshapiroFrame {
  let result = stats_test_shapiro_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_frame_sum(s : StatstestshapiroFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_shapiro_frame_mean(s : StatstestshapiroFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_shapiro_frame_sum(s) / s.size.to_double() }
}

pub fn stats_test_shapiro_frame_scale(s : StatstestshapiroFrame, f : Double) -> StatstestshapiroFrame {
  let result = stats_test_shapiro_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_shapiro_frame_add(a : StatstestshapiroFrame, b : StatstestshapiroFrame) -> StatstestshapiroFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_shapiro_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_shapiro_frame_copy(s : StatstestshapiroFrame) -> StatstestshapiroFrame {
  let result = stats_test_shapiro_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_shapiro_frame_fill(s : StatstestshapiroFrame, v : Double) -> StatstestshapiroFrame {
  let result = stats_test_shapiro_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_frame_min(s : StatstestshapiroFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_frame_max(s : StatstestshapiroFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_frame_to_string(s : StatstestshapiroFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_table_make(size : Int) -> StatstestshapiroTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_table_len(s : StatstestshapiroTable) -> Int { s.size }

pub fn stats_test_shapiro_table_get(s : StatstestshapiroTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_table_set(s : StatstestshapiroTable, i : Int, v : Double) -> StatstestshapiroTable {
  let result = stats_test_shapiro_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_table_sum(s : StatstestshapiroTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_shapiro_table_mean(s : StatstestshapiroTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_shapiro_table_sum(s) / s.size.to_double() }
}

pub fn stats_test_shapiro_table_scale(s : StatstestshapiroTable, f : Double) -> StatstestshapiroTable {
  let result = stats_test_shapiro_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_shapiro_table_add(a : StatstestshapiroTable, b : StatstestshapiroTable) -> StatstestshapiroTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_shapiro_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_shapiro_table_copy(s : StatstestshapiroTable) -> StatstestshapiroTable {
  let result = stats_test_shapiro_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_shapiro_table_fill(s : StatstestshapiroTable, v : Double) -> StatstestshapiroTable {
  let result = stats_test_shapiro_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_table_min(s : StatstestshapiroTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_table_max(s : StatstestshapiroTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_table_to_string(s : StatstestshapiroTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_graphn_make(size : Int) -> StatstestshapiroGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_graphn_len(s : StatstestshapiroGraphN) -> Int { s.size }

pub fn stats_test_shapiro_graphn_get(s : StatstestshapiroGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_graphn_set(s : StatstestshapiroGraphN, i : Int, v : Double) -> StatstestshapiroGraphN {
  let result = stats_test_shapiro_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_graphn_sum(s : StatstestshapiroGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_shapiro_graphn_mean(s : StatstestshapiroGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_shapiro_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_test_shapiro_graphn_scale(s : StatstestshapiroGraphN, f : Double) -> StatstestshapiroGraphN {
  let result = stats_test_shapiro_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_shapiro_graphn_add(a : StatstestshapiroGraphN, b : StatstestshapiroGraphN) -> StatstestshapiroGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_shapiro_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_shapiro_graphn_copy(s : StatstestshapiroGraphN) -> StatstestshapiroGraphN {
  let result = stats_test_shapiro_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_shapiro_graphn_fill(s : StatstestshapiroGraphN, v : Double) -> StatstestshapiroGraphN {
  let result = stats_test_shapiro_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_graphn_min(s : StatstestshapiroGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_graphn_max(s : StatstestshapiroGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_graphn_to_string(s : StatstestshapiroGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_node_make(size : Int) -> StatstestshapiroNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_node_len(s : StatstestshapiroNode) -> Int { s.size }

pub fn stats_test_shapiro_node_get(s : StatstestshapiroNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_node_set(s : StatstestshapiroNode, i : Int, v : Double) -> StatstestshapiroNode {
  let result = stats_test_shapiro_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_node_sum(s : StatstestshapiroNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_shapiro_node_mean(s : StatstestshapiroNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_shapiro_node_sum(s) / s.size.to_double() }
}

pub fn stats_test_shapiro_node_scale(s : StatstestshapiroNode, f : Double) -> StatstestshapiroNode {
  let result = stats_test_shapiro_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_shapiro_node_add(a : StatstestshapiroNode, b : StatstestshapiroNode) -> StatstestshapiroNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_shapiro_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_shapiro_node_copy(s : StatstestshapiroNode) -> StatstestshapiroNode {
  let result = stats_test_shapiro_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_shapiro_node_fill(s : StatstestshapiroNode, v : Double) -> StatstestshapiroNode {
  let result = stats_test_shapiro_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_node_min(s : StatstestshapiroNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_node_max(s : StatstestshapiroNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_node_to_string(s : StatstestshapiroNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_edge_make(size : Int) -> StatstestshapiroEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_edge_len(s : StatstestshapiroEdge) -> Int { s.size }

pub fn stats_test_shapiro_edge_get(s : StatstestshapiroEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_edge_set(s : StatstestshapiroEdge, i : Int, v : Double) -> StatstestshapiroEdge {
  let result = stats_test_shapiro_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_edge_sum(s : StatstestshapiroEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_shapiro_edge_mean(s : StatstestshapiroEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_shapiro_edge_sum(s) / s.size.to_double() }
}

pub fn stats_test_shapiro_edge_scale(s : StatstestshapiroEdge, f : Double) -> StatstestshapiroEdge {
  let result = stats_test_shapiro_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_shapiro_edge_add(a : StatstestshapiroEdge, b : StatstestshapiroEdge) -> StatstestshapiroEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_shapiro_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_shapiro_edge_copy(s : StatstestshapiroEdge) -> StatstestshapiroEdge {
  let result = stats_test_shapiro_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_shapiro_edge_fill(s : StatstestshapiroEdge, v : Double) -> StatstestshapiroEdge {
  let result = stats_test_shapiro_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_edge_min(s : StatstestshapiroEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_edge_max(s : StatstestshapiroEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_edge_to_string(s : StatstestshapiroEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_path_make(size : Int) -> StatstestshapiroPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_path_len(s : StatstestshapiroPath) -> Int { s.size }

pub fn stats_test_shapiro_path_get(s : StatstestshapiroPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_path_set(s : StatstestshapiroPath, i : Int, v : Double) -> StatstestshapiroPath {
  let result = stats_test_shapiro_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_path_sum(s : StatstestshapiroPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_shapiro_path_mean(s : StatstestshapiroPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_shapiro_path_sum(s) / s.size.to_double() }
}

pub fn stats_test_shapiro_path_scale(s : StatstestshapiroPath, f : Double) -> StatstestshapiroPath {
  let result = stats_test_shapiro_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_shapiro_path_add(a : StatstestshapiroPath, b : StatstestshapiroPath) -> StatstestshapiroPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_shapiro_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_shapiro_path_copy(s : StatstestshapiroPath) -> StatstestshapiroPath {
  let result = stats_test_shapiro_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_shapiro_path_fill(s : StatstestshapiroPath, v : Double) -> StatstestshapiroPath {
  let result = stats_test_shapiro_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_path_min(s : StatstestshapiroPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_path_max(s : StatstestshapiroPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_path_to_string(s : StatstestshapiroPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_cluster_make(size : Int) -> StatstestshapiroCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_cluster_len(s : StatstestshapiroCluster) -> Int { s.size }

pub fn stats_test_shapiro_cluster_get(s : StatstestshapiroCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_cluster_set(s : StatstestshapiroCluster, i : Int, v : Double) -> StatstestshapiroCluster {
  let result = stats_test_shapiro_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_cluster_sum(s : StatstestshapiroCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_shapiro_cluster_mean(s : StatstestshapiroCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_shapiro_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_test_shapiro_cluster_scale(s : StatstestshapiroCluster, f : Double) -> StatstestshapiroCluster {
  let result = stats_test_shapiro_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_shapiro_cluster_add(a : StatstestshapiroCluster, b : StatstestshapiroCluster) -> StatstestshapiroCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_shapiro_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_shapiro_cluster_copy(s : StatstestshapiroCluster) -> StatstestshapiroCluster {
  let result = stats_test_shapiro_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_shapiro_cluster_fill(s : StatstestshapiroCluster, v : Double) -> StatstestshapiroCluster {
  let result = stats_test_shapiro_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_cluster_min(s : StatstestshapiroCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_cluster_max(s : StatstestshapiroCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_cluster_to_string(s : StatstestshapiroCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_model_make(size : Int) -> StatstestshapiroModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_model_len(s : StatstestshapiroModel) -> Int { s.size }

pub fn stats_test_shapiro_model_get(s : StatstestshapiroModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_model_set(s : StatstestshapiroModel, i : Int, v : Double) -> StatstestshapiroModel {
  let result = stats_test_shapiro_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_model_sum(s : StatstestshapiroModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_shapiro_model_mean(s : StatstestshapiroModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_shapiro_model_sum(s) / s.size.to_double() }
}

pub fn stats_test_shapiro_model_scale(s : StatstestshapiroModel, f : Double) -> StatstestshapiroModel {
  let result = stats_test_shapiro_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_shapiro_model_add(a : StatstestshapiroModel, b : StatstestshapiroModel) -> StatstestshapiroModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_shapiro_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_shapiro_model_copy(s : StatstestshapiroModel) -> StatstestshapiroModel {
  let result = stats_test_shapiro_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_shapiro_model_fill(s : StatstestshapiroModel, v : Double) -> StatstestshapiroModel {
  let result = stats_test_shapiro_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_model_min(s : StatstestshapiroModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_model_max(s : StatstestshapiroModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_model_to_string(s : StatstestshapiroModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_layer_make(size : Int) -> StatstestshapiroLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_layer_len(s : StatstestshapiroLayer) -> Int { s.size }

pub fn stats_test_shapiro_layer_get(s : StatstestshapiroLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_layer_set(s : StatstestshapiroLayer, i : Int, v : Double) -> StatstestshapiroLayer {
  let result = stats_test_shapiro_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_layer_sum(s : StatstestshapiroLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_shapiro_layer_mean(s : StatstestshapiroLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_shapiro_layer_sum(s) / s.size.to_double() }
}

pub fn stats_test_shapiro_layer_scale(s : StatstestshapiroLayer, f : Double) -> StatstestshapiroLayer {
  let result = stats_test_shapiro_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_shapiro_layer_add(a : StatstestshapiroLayer, b : StatstestshapiroLayer) -> StatstestshapiroLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_shapiro_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_shapiro_layer_copy(s : StatstestshapiroLayer) -> StatstestshapiroLayer {
  let result = stats_test_shapiro_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_shapiro_layer_fill(s : StatstestshapiroLayer, v : Double) -> StatstestshapiroLayer {
  let result = stats_test_shapiro_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_layer_min(s : StatstestshapiroLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_layer_max(s : StatstestshapiroLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_layer_to_string(s : StatstestshapiroLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_buffer_make(size : Int) -> StatstestshapiroBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_buffer_len(s : StatstestshapiroBuffer) -> Int { s.size }

pub fn stats_test_shapiro_buffer_get(s : StatstestshapiroBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_buffer_set(s : StatstestshapiroBuffer, i : Int, v : Double) -> StatstestshapiroBuffer {
  let result = stats_test_shapiro_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_buffer_sum(s : StatstestshapiroBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_shapiro_buffer_mean(s : StatstestshapiroBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_shapiro_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_test_shapiro_buffer_scale(s : StatstestshapiroBuffer, f : Double) -> StatstestshapiroBuffer {
  let result = stats_test_shapiro_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_shapiro_buffer_add(a : StatstestshapiroBuffer, b : StatstestshapiroBuffer) -> StatstestshapiroBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_shapiro_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_shapiro_buffer_copy(s : StatstestshapiroBuffer) -> StatstestshapiroBuffer {
  let result = stats_test_shapiro_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_shapiro_buffer_fill(s : StatstestshapiroBuffer, v : Double) -> StatstestshapiroBuffer {
  let result = stats_test_shapiro_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_buffer_min(s : StatstestshapiroBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_buffer_max(s : StatstestshapiroBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_buffer_to_string(s : StatstestshapiroBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_cursor_make(size : Int) -> StatstestshapiroCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_cursor_len(s : StatstestshapiroCursor) -> Int { s.size }

pub fn stats_test_shapiro_cursor_get(s : StatstestshapiroCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_cursor_set(s : StatstestshapiroCursor, i : Int, v : Double) -> StatstestshapiroCursor {
  let result = stats_test_shapiro_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_cursor_sum(s : StatstestshapiroCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_shapiro_cursor_mean(s : StatstestshapiroCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_shapiro_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_test_shapiro_cursor_scale(s : StatstestshapiroCursor, f : Double) -> StatstestshapiroCursor {
  let result = stats_test_shapiro_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_shapiro_cursor_add(a : StatstestshapiroCursor, b : StatstestshapiroCursor) -> StatstestshapiroCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_shapiro_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_shapiro_cursor_copy(s : StatstestshapiroCursor) -> StatstestshapiroCursor {
  let result = stats_test_shapiro_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_shapiro_cursor_fill(s : StatstestshapiroCursor, v : Double) -> StatstestshapiroCursor {
  let result = stats_test_shapiro_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_cursor_min(s : StatstestshapiroCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_cursor_max(s : StatstestshapiroCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_cursor_to_string(s : StatstestshapiroCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_view_make(size : Int) -> StatstestshapiroView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_view_len(s : StatstestshapiroView) -> Int { s.size }

pub fn stats_test_shapiro_view_get(s : StatstestshapiroView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_view_set(s : StatstestshapiroView, i : Int, v : Double) -> StatstestshapiroView {
  let result = stats_test_shapiro_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_view_sum(s : StatstestshapiroView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_shapiro_view_mean(s : StatstestshapiroView) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_shapiro_view_sum(s) / s.size.to_double() }
}

pub fn stats_test_shapiro_view_scale(s : StatstestshapiroView, f : Double) -> StatstestshapiroView {
  let result = stats_test_shapiro_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_shapiro_view_add(a : StatstestshapiroView, b : StatstestshapiroView) -> StatstestshapiroView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_shapiro_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_shapiro_view_copy(s : StatstestshapiroView) -> StatstestshapiroView {
  let result = stats_test_shapiro_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_shapiro_view_fill(s : StatstestshapiroView, v : Double) -> StatstestshapiroView {
  let result = stats_test_shapiro_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_view_min(s : StatstestshapiroView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_view_max(s : StatstestshapiroView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_view_to_string(s : StatstestshapiroView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_range_make(size : Int) -> StatstestshapiroRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_range_len(s : StatstestshapiroRange) -> Int { s.size }

pub fn stats_test_shapiro_range_get(s : StatstestshapiroRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_range_set(s : StatstestshapiroRange, i : Int, v : Double) -> StatstestshapiroRange {
  let result = stats_test_shapiro_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_range_sum(s : StatstestshapiroRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_shapiro_range_mean(s : StatstestshapiroRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_shapiro_range_sum(s) / s.size.to_double() }
}

pub fn stats_test_shapiro_range_scale(s : StatstestshapiroRange, f : Double) -> StatstestshapiroRange {
  let result = stats_test_shapiro_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_shapiro_range_add(a : StatstestshapiroRange, b : StatstestshapiroRange) -> StatstestshapiroRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_shapiro_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_shapiro_range_copy(s : StatstestshapiroRange) -> StatstestshapiroRange {
  let result = stats_test_shapiro_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_shapiro_range_fill(s : StatstestshapiroRange, v : Double) -> StatstestshapiroRange {
  let result = stats_test_shapiro_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_range_min(s : StatstestshapiroRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_range_max(s : StatstestshapiroRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_range_to_string(s : StatstestshapiroRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestshapiroSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_shapiro_slice_make(size : Int) -> StatstestshapiroSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_shapiro_slice_len(s : StatstestshapiroSlice) -> Int { s.size }

pub fn stats_test_shapiro_slice_get(s : StatstestshapiroSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_shapiro_slice_set(s : StatstestshapiroSlice, i : Int, v : Double) -> StatstestshapiroSlice {
  let result = stats_test_shapiro_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_slice_sum(s : StatstestshapiroSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_test_shapiro_slice_mean(s : StatstestshapiroSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_test_shapiro_slice_sum(s) / s.size.to_double() }
}

pub fn stats_test_shapiro_slice_scale(s : StatstestshapiroSlice, f : Double) -> StatstestshapiroSlice {
  let result = stats_test_shapiro_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_test_shapiro_slice_add(a : StatstestshapiroSlice, b : StatstestshapiroSlice) -> StatstestshapiroSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_test_shapiro_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_test_shapiro_slice_copy(s : StatstestshapiroSlice) -> StatstestshapiroSlice {
  let result = stats_test_shapiro_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_test_shapiro_slice_fill(s : StatstestshapiroSlice, v : Double) -> StatstestshapiroSlice {
  let result = stats_test_shapiro_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_test_shapiro_slice_min(s : StatstestshapiroSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_slice_max(s : StatstestshapiroSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_test_shapiro_slice_to_string(s : StatstestshapiroSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

