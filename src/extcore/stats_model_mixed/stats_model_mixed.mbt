///===
/// extcore/stats_model_mixed

pub(all) struct StatsmodelmixedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_model_mixed_make_point(x : Double, y : Double) -> StatsmodelmixedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_model_mixed_make_point3(x : Double, y : Double, z : Double) -> StatsmodelmixedPoint {
  { x, y, z, label: 0 }
}

pub fn stats_model_mixed_point_x(pt : StatsmodelmixedPoint) -> Double { pt.x }

pub fn stats_model_mixed_point_y(pt : StatsmodelmixedPoint) -> Double { pt.y }

pub fn stats_model_mixed_point_z(pt : StatsmodelmixedPoint) -> Double { pt.z }

pub fn stats_model_mixed_point_label(pt : StatsmodelmixedPoint) -> Int { pt.label }

pub fn stats_model_mixed_point_dist(a : StatsmodelmixedPoint, b : StatsmodelmixedPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_model_mixed_point_add(a : StatsmodelmixedPoint, b : StatsmodelmixedPoint) -> StatsmodelmixedPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_model_mixed_point_sub(a : StatsmodelmixedPoint, b : StatsmodelmixedPoint) -> StatsmodelmixedPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_model_mixed_point_scale(pt : StatsmodelmixedPoint, s : Double) -> StatsmodelmixedPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_model_mixed_point_dot(a : StatsmodelmixedPoint, b : StatsmodelmixedPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_model_mixed_point_cross(a : StatsmodelmixedPoint, b : StatsmodelmixedPoint) -> StatsmodelmixedPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_model_mixed_point_norm(pt : StatsmodelmixedPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_model_mixed_point_normalize(pt : StatsmodelmixedPoint) -> StatsmodelmixedPoint {
  let n = stats_model_mixed_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_model_mixed_point_scale(pt, 1.0 / n) }
}

pub fn stats_model_mixed_point_negate(pt : StatsmodelmixedPoint) -> StatsmodelmixedPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_model_mixed_point_mid(a : StatsmodelmixedPoint, b : StatsmodelmixedPoint) -> StatsmodelmixedPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_model_mixed_point_lerp(a : StatsmodelmixedPoint, b : StatsmodelmixedPoint, t : Double) -> StatsmodelmixedPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_model_mixed_point_to_string(pt : StatsmodelmixedPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsmodelmixedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_model_mixed_make_series(vals : Array[Double], name : String) -> StatsmodelmixedSeries {
  { vals, name, meta: 0 }
}

pub fn stats_model_mixed_series_len(s : StatsmodelmixedSeries) -> Int { s.vals.length() }

pub fn stats_model_mixed_series_sum(s : StatsmodelmixedSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_model_mixed_series_mean(s : StatsmodelmixedSeries) -> Double {
  let n = stats_model_mixed_series_len(s)
  if n == 0 { 0.0 } else { stats_model_mixed_series_sum(s) / n.to_double() }
}

pub fn stats_model_mixed_series_min(s : StatsmodelmixedSeries) -> Double {
  let n = stats_model_mixed_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_model_mixed_series_max(s : StatsmodelmixedSeries) -> Double {
  let n = stats_model_mixed_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_model_mixed_series_range(s : StatsmodelmixedSeries) -> Double {
  stats_model_mixed_series_max(s) - stats_model_mixed_series_min(s)
}

pub fn stats_model_mixed_series_var(s : StatsmodelmixedSeries) -> Double {
  let n = stats_model_mixed_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_model_mixed_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_model_mixed_series_std(s : StatsmodelmixedSeries) -> Double { @_common.sqrt(stats_model_mixed_series_var(s)) }

pub fn stats_model_mixed_series_median(s : StatsmodelmixedSeries) -> Double {
  let n = stats_model_mixed_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_model_mixed_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_model_mixed_series_scale(s : StatsmodelmixedSeries, f : Double) -> StatsmodelmixedSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_model_mixed_series_add(a : StatsmodelmixedSeries, b : StatsmodelmixedSeries) -> StatsmodelmixedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_model_mixed_series_sub(a : StatsmodelmixedSeries, b : StatsmodelmixedSeries) -> StatsmodelmixedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_model_mixed_series_normalize(s : StatsmodelmixedSeries) -> StatsmodelmixedSeries {
  let mn = stats_model_mixed_series_min(s)
  let mx = stats_model_mixed_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_model_mixed_series_cumsum(s : StatsmodelmixedSeries) -> StatsmodelmixedSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_model_mixed_series_to_string(s : StatsmodelmixedSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsmodelmixedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_model_mixed_make_matrix(rows : Int, cols : Int, val : Double) -> StatsmodelmixedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_model_mixed_matrix_identity(n : Int) -> StatsmodelmixedMatrix {
  let m = stats_model_mixed_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_model_mixed_matrix_get(m : StatsmodelmixedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_model_mixed_matrix_transpose(m : StatsmodelmixedMatrix) -> StatsmodelmixedMatrix {
  let result = stats_model_mixed_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_model_mixed_matrix_add(a : StatsmodelmixedMatrix, b : StatsmodelmixedMatrix) -> StatsmodelmixedMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_model_mixed_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_model_mixed_matrix_scale(m : StatsmodelmixedMatrix, s : Double) -> StatsmodelmixedMatrix {
  let result = stats_model_mixed_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_model_mixed_matrix_multiply(a : StatsmodelmixedMatrix, b : StatsmodelmixedMatrix) -> StatsmodelmixedMatrix {
  if a.cols != b.rows { return stats_model_mixed_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_model_mixed_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_model_mixed_matrix_trace(m : StatsmodelmixedMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_model_mixed_matrix_det(m : StatsmodelmixedMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_model_mixed_matrix_norm(m : StatsmodelmixedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_model_mixed_matrix_to_string(m : StatsmodelmixedMatrix) -> String {
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

pub(all) struct StatsmodelmixedVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_model_mixed_make_vector(comps : Array[Double]) -> StatsmodelmixedVector {
  { comps, dim: comps.length() }
}

pub fn stats_model_mixed_vector_zero(dim : Int) -> StatsmodelmixedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_model_mixed_vector_add(a : StatsmodelmixedVector, b : StatsmodelmixedVector) -> StatsmodelmixedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_model_mixed_vector_sub(a : StatsmodelmixedVector, b : StatsmodelmixedVector) -> StatsmodelmixedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_model_mixed_vector_scale(v : StatsmodelmixedVector, s : Double) -> StatsmodelmixedVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_model_mixed_vector_dot(a : StatsmodelmixedVector, b : StatsmodelmixedVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_model_mixed_vector_norm(v : StatsmodelmixedVector) -> Double { @_common.sqrt(stats_model_mixed_vector_dot(v, v)) }

pub fn stats_model_mixed_vector_normalize(v : StatsmodelmixedVector) -> StatsmodelmixedVector {
  let n = stats_model_mixed_vector_norm(v)
  if n < 0.0000001 { v } else { stats_model_mixed_vector_scale(v, 1.0 / n) }
}

pub fn stats_model_mixed_vector_dist(a : StatsmodelmixedVector, b : StatsmodelmixedVector) -> Double {
  stats_model_mixed_vector_norm(stats_model_mixed_vector_sub(a, b))
}

pub fn stats_model_mixed_vector_to_string(v : StatsmodelmixedVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_model_mixed_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_model_mixed_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_model_mixed_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_model_mixed_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_model_mixed_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_model_mixed_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_model_mixed_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_model_mixed_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_model_mixed_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_model_mixed_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_model_mixed_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_model_mixed_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_model_mixed_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_model_mixed_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_model_mixed_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_model_mixed_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_model_mixed_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_model_mixed_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_model_mixed_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_model_mixed_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_model_mixed_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_model_mixed_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_model_mixed_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_model_mixed_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_model_mixed_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_model_mixed_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_model_mixed_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_model_mixed_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_model_mixed_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsmodelmixedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_frame_make(size : Int) -> StatsmodelmixedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_frame_len(s : StatsmodelmixedFrame) -> Int { s.size }

pub fn stats_model_mixed_frame_get(s : StatsmodelmixedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_frame_set(s : StatsmodelmixedFrame, i : Int, v : Double) -> StatsmodelmixedFrame {
  let result = stats_model_mixed_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_frame_sum(s : StatsmodelmixedFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_frame_mean(s : StatsmodelmixedFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_frame_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_frame_scale(s : StatsmodelmixedFrame, f : Double) -> StatsmodelmixedFrame {
  let result = stats_model_mixed_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_frame_add(a : StatsmodelmixedFrame, b : StatsmodelmixedFrame) -> StatsmodelmixedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_frame_copy(s : StatsmodelmixedFrame) -> StatsmodelmixedFrame {
  let result = stats_model_mixed_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_frame_fill(s : StatsmodelmixedFrame, v : Double) -> StatsmodelmixedFrame {
  let result = stats_model_mixed_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_frame_min(s : StatsmodelmixedFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_frame_max(s : StatsmodelmixedFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_frame_to_string(s : StatsmodelmixedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_table_make(size : Int) -> StatsmodelmixedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_table_len(s : StatsmodelmixedTable) -> Int { s.size }

pub fn stats_model_mixed_table_get(s : StatsmodelmixedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_table_set(s : StatsmodelmixedTable, i : Int, v : Double) -> StatsmodelmixedTable {
  let result = stats_model_mixed_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_table_sum(s : StatsmodelmixedTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_table_mean(s : StatsmodelmixedTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_table_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_table_scale(s : StatsmodelmixedTable, f : Double) -> StatsmodelmixedTable {
  let result = stats_model_mixed_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_table_add(a : StatsmodelmixedTable, b : StatsmodelmixedTable) -> StatsmodelmixedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_table_copy(s : StatsmodelmixedTable) -> StatsmodelmixedTable {
  let result = stats_model_mixed_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_table_fill(s : StatsmodelmixedTable, v : Double) -> StatsmodelmixedTable {
  let result = stats_model_mixed_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_table_min(s : StatsmodelmixedTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_table_max(s : StatsmodelmixedTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_table_to_string(s : StatsmodelmixedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_graphn_make(size : Int) -> StatsmodelmixedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_graphn_len(s : StatsmodelmixedGraphN) -> Int { s.size }

pub fn stats_model_mixed_graphn_get(s : StatsmodelmixedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_graphn_set(s : StatsmodelmixedGraphN, i : Int, v : Double) -> StatsmodelmixedGraphN {
  let result = stats_model_mixed_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_graphn_sum(s : StatsmodelmixedGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_graphn_mean(s : StatsmodelmixedGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_graphn_scale(s : StatsmodelmixedGraphN, f : Double) -> StatsmodelmixedGraphN {
  let result = stats_model_mixed_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_graphn_add(a : StatsmodelmixedGraphN, b : StatsmodelmixedGraphN) -> StatsmodelmixedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_graphn_copy(s : StatsmodelmixedGraphN) -> StatsmodelmixedGraphN {
  let result = stats_model_mixed_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_graphn_fill(s : StatsmodelmixedGraphN, v : Double) -> StatsmodelmixedGraphN {
  let result = stats_model_mixed_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_graphn_min(s : StatsmodelmixedGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_graphn_max(s : StatsmodelmixedGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_graphn_to_string(s : StatsmodelmixedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_node_make(size : Int) -> StatsmodelmixedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_node_len(s : StatsmodelmixedNode) -> Int { s.size }

pub fn stats_model_mixed_node_get(s : StatsmodelmixedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_node_set(s : StatsmodelmixedNode, i : Int, v : Double) -> StatsmodelmixedNode {
  let result = stats_model_mixed_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_node_sum(s : StatsmodelmixedNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_node_mean(s : StatsmodelmixedNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_node_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_node_scale(s : StatsmodelmixedNode, f : Double) -> StatsmodelmixedNode {
  let result = stats_model_mixed_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_node_add(a : StatsmodelmixedNode, b : StatsmodelmixedNode) -> StatsmodelmixedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_node_copy(s : StatsmodelmixedNode) -> StatsmodelmixedNode {
  let result = stats_model_mixed_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_node_fill(s : StatsmodelmixedNode, v : Double) -> StatsmodelmixedNode {
  let result = stats_model_mixed_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_node_min(s : StatsmodelmixedNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_node_max(s : StatsmodelmixedNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_node_to_string(s : StatsmodelmixedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_edge_make(size : Int) -> StatsmodelmixedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_edge_len(s : StatsmodelmixedEdge) -> Int { s.size }

pub fn stats_model_mixed_edge_get(s : StatsmodelmixedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_edge_set(s : StatsmodelmixedEdge, i : Int, v : Double) -> StatsmodelmixedEdge {
  let result = stats_model_mixed_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_edge_sum(s : StatsmodelmixedEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_edge_mean(s : StatsmodelmixedEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_edge_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_edge_scale(s : StatsmodelmixedEdge, f : Double) -> StatsmodelmixedEdge {
  let result = stats_model_mixed_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_edge_add(a : StatsmodelmixedEdge, b : StatsmodelmixedEdge) -> StatsmodelmixedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_edge_copy(s : StatsmodelmixedEdge) -> StatsmodelmixedEdge {
  let result = stats_model_mixed_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_edge_fill(s : StatsmodelmixedEdge, v : Double) -> StatsmodelmixedEdge {
  let result = stats_model_mixed_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_edge_min(s : StatsmodelmixedEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_edge_max(s : StatsmodelmixedEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_edge_to_string(s : StatsmodelmixedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_path_make(size : Int) -> StatsmodelmixedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_path_len(s : StatsmodelmixedPath) -> Int { s.size }

pub fn stats_model_mixed_path_get(s : StatsmodelmixedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_path_set(s : StatsmodelmixedPath, i : Int, v : Double) -> StatsmodelmixedPath {
  let result = stats_model_mixed_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_path_sum(s : StatsmodelmixedPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_path_mean(s : StatsmodelmixedPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_path_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_path_scale(s : StatsmodelmixedPath, f : Double) -> StatsmodelmixedPath {
  let result = stats_model_mixed_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_path_add(a : StatsmodelmixedPath, b : StatsmodelmixedPath) -> StatsmodelmixedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_path_copy(s : StatsmodelmixedPath) -> StatsmodelmixedPath {
  let result = stats_model_mixed_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_path_fill(s : StatsmodelmixedPath, v : Double) -> StatsmodelmixedPath {
  let result = stats_model_mixed_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_path_min(s : StatsmodelmixedPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_path_max(s : StatsmodelmixedPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_path_to_string(s : StatsmodelmixedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_cluster_make(size : Int) -> StatsmodelmixedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_cluster_len(s : StatsmodelmixedCluster) -> Int { s.size }

pub fn stats_model_mixed_cluster_get(s : StatsmodelmixedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_cluster_set(s : StatsmodelmixedCluster, i : Int, v : Double) -> StatsmodelmixedCluster {
  let result = stats_model_mixed_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_cluster_sum(s : StatsmodelmixedCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_cluster_mean(s : StatsmodelmixedCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_cluster_scale(s : StatsmodelmixedCluster, f : Double) -> StatsmodelmixedCluster {
  let result = stats_model_mixed_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_cluster_add(a : StatsmodelmixedCluster, b : StatsmodelmixedCluster) -> StatsmodelmixedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_cluster_copy(s : StatsmodelmixedCluster) -> StatsmodelmixedCluster {
  let result = stats_model_mixed_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_cluster_fill(s : StatsmodelmixedCluster, v : Double) -> StatsmodelmixedCluster {
  let result = stats_model_mixed_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_cluster_min(s : StatsmodelmixedCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_cluster_max(s : StatsmodelmixedCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_cluster_to_string(s : StatsmodelmixedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_model_make(size : Int) -> StatsmodelmixedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_model_len(s : StatsmodelmixedModel) -> Int { s.size }

pub fn stats_model_mixed_model_get(s : StatsmodelmixedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_model_set(s : StatsmodelmixedModel, i : Int, v : Double) -> StatsmodelmixedModel {
  let result = stats_model_mixed_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_model_sum(s : StatsmodelmixedModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_model_mean(s : StatsmodelmixedModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_model_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_model_scale(s : StatsmodelmixedModel, f : Double) -> StatsmodelmixedModel {
  let result = stats_model_mixed_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_model_add(a : StatsmodelmixedModel, b : StatsmodelmixedModel) -> StatsmodelmixedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_model_copy(s : StatsmodelmixedModel) -> StatsmodelmixedModel {
  let result = stats_model_mixed_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_model_fill(s : StatsmodelmixedModel, v : Double) -> StatsmodelmixedModel {
  let result = stats_model_mixed_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_model_min(s : StatsmodelmixedModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_model_max(s : StatsmodelmixedModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_model_to_string(s : StatsmodelmixedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_layer_make(size : Int) -> StatsmodelmixedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_layer_len(s : StatsmodelmixedLayer) -> Int { s.size }

pub fn stats_model_mixed_layer_get(s : StatsmodelmixedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_layer_set(s : StatsmodelmixedLayer, i : Int, v : Double) -> StatsmodelmixedLayer {
  let result = stats_model_mixed_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_layer_sum(s : StatsmodelmixedLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_layer_mean(s : StatsmodelmixedLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_layer_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_layer_scale(s : StatsmodelmixedLayer, f : Double) -> StatsmodelmixedLayer {
  let result = stats_model_mixed_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_layer_add(a : StatsmodelmixedLayer, b : StatsmodelmixedLayer) -> StatsmodelmixedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_layer_copy(s : StatsmodelmixedLayer) -> StatsmodelmixedLayer {
  let result = stats_model_mixed_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_layer_fill(s : StatsmodelmixedLayer, v : Double) -> StatsmodelmixedLayer {
  let result = stats_model_mixed_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_layer_min(s : StatsmodelmixedLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_layer_max(s : StatsmodelmixedLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_layer_to_string(s : StatsmodelmixedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_buffer_make(size : Int) -> StatsmodelmixedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_buffer_len(s : StatsmodelmixedBuffer) -> Int { s.size }

pub fn stats_model_mixed_buffer_get(s : StatsmodelmixedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_buffer_set(s : StatsmodelmixedBuffer, i : Int, v : Double) -> StatsmodelmixedBuffer {
  let result = stats_model_mixed_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_buffer_sum(s : StatsmodelmixedBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_buffer_mean(s : StatsmodelmixedBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_buffer_scale(s : StatsmodelmixedBuffer, f : Double) -> StatsmodelmixedBuffer {
  let result = stats_model_mixed_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_buffer_add(a : StatsmodelmixedBuffer, b : StatsmodelmixedBuffer) -> StatsmodelmixedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_buffer_copy(s : StatsmodelmixedBuffer) -> StatsmodelmixedBuffer {
  let result = stats_model_mixed_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_buffer_fill(s : StatsmodelmixedBuffer, v : Double) -> StatsmodelmixedBuffer {
  let result = stats_model_mixed_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_buffer_min(s : StatsmodelmixedBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_buffer_max(s : StatsmodelmixedBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_buffer_to_string(s : StatsmodelmixedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_cursor_make(size : Int) -> StatsmodelmixedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_cursor_len(s : StatsmodelmixedCursor) -> Int { s.size }

pub fn stats_model_mixed_cursor_get(s : StatsmodelmixedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_cursor_set(s : StatsmodelmixedCursor, i : Int, v : Double) -> StatsmodelmixedCursor {
  let result = stats_model_mixed_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_cursor_sum(s : StatsmodelmixedCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_cursor_mean(s : StatsmodelmixedCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_cursor_scale(s : StatsmodelmixedCursor, f : Double) -> StatsmodelmixedCursor {
  let result = stats_model_mixed_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_cursor_add(a : StatsmodelmixedCursor, b : StatsmodelmixedCursor) -> StatsmodelmixedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_cursor_copy(s : StatsmodelmixedCursor) -> StatsmodelmixedCursor {
  let result = stats_model_mixed_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_cursor_fill(s : StatsmodelmixedCursor, v : Double) -> StatsmodelmixedCursor {
  let result = stats_model_mixed_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_cursor_min(s : StatsmodelmixedCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_cursor_max(s : StatsmodelmixedCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_cursor_to_string(s : StatsmodelmixedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_view_make(size : Int) -> StatsmodelmixedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_view_len(s : StatsmodelmixedView) -> Int { s.size }

pub fn stats_model_mixed_view_get(s : StatsmodelmixedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_view_set(s : StatsmodelmixedView, i : Int, v : Double) -> StatsmodelmixedView {
  let result = stats_model_mixed_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_view_sum(s : StatsmodelmixedView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_view_mean(s : StatsmodelmixedView) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_view_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_view_scale(s : StatsmodelmixedView, f : Double) -> StatsmodelmixedView {
  let result = stats_model_mixed_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_view_add(a : StatsmodelmixedView, b : StatsmodelmixedView) -> StatsmodelmixedView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_view_copy(s : StatsmodelmixedView) -> StatsmodelmixedView {
  let result = stats_model_mixed_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_view_fill(s : StatsmodelmixedView, v : Double) -> StatsmodelmixedView {
  let result = stats_model_mixed_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_view_min(s : StatsmodelmixedView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_view_max(s : StatsmodelmixedView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_view_to_string(s : StatsmodelmixedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_range_make(size : Int) -> StatsmodelmixedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_range_len(s : StatsmodelmixedRange) -> Int { s.size }

pub fn stats_model_mixed_range_get(s : StatsmodelmixedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_range_set(s : StatsmodelmixedRange, i : Int, v : Double) -> StatsmodelmixedRange {
  let result = stats_model_mixed_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_range_sum(s : StatsmodelmixedRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_range_mean(s : StatsmodelmixedRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_range_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_range_scale(s : StatsmodelmixedRange, f : Double) -> StatsmodelmixedRange {
  let result = stats_model_mixed_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_range_add(a : StatsmodelmixedRange, b : StatsmodelmixedRange) -> StatsmodelmixedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_range_copy(s : StatsmodelmixedRange) -> StatsmodelmixedRange {
  let result = stats_model_mixed_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_range_fill(s : StatsmodelmixedRange, v : Double) -> StatsmodelmixedRange {
  let result = stats_model_mixed_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_range_min(s : StatsmodelmixedRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_range_max(s : StatsmodelmixedRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_range_to_string(s : StatsmodelmixedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelmixedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_mixed_slice_make(size : Int) -> StatsmodelmixedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_mixed_slice_len(s : StatsmodelmixedSlice) -> Int { s.size }

pub fn stats_model_mixed_slice_get(s : StatsmodelmixedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_mixed_slice_set(s : StatsmodelmixedSlice, i : Int, v : Double) -> StatsmodelmixedSlice {
  let result = stats_model_mixed_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_slice_sum(s : StatsmodelmixedSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_model_mixed_slice_mean(s : StatsmodelmixedSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_model_mixed_slice_sum(s) / s.size.to_double() }
}

pub fn stats_model_mixed_slice_scale(s : StatsmodelmixedSlice, f : Double) -> StatsmodelmixedSlice {
  let result = stats_model_mixed_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_model_mixed_slice_add(a : StatsmodelmixedSlice, b : StatsmodelmixedSlice) -> StatsmodelmixedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_model_mixed_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_model_mixed_slice_copy(s : StatsmodelmixedSlice) -> StatsmodelmixedSlice {
  let result = stats_model_mixed_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_model_mixed_slice_fill(s : StatsmodelmixedSlice, v : Double) -> StatsmodelmixedSlice {
  let result = stats_model_mixed_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_model_mixed_slice_min(s : StatsmodelmixedSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_slice_max(s : StatsmodelmixedSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_model_mixed_slice_to_string(s : StatsmodelmixedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

