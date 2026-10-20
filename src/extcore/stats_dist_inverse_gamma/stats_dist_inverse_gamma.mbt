///===
/// extcore/stats_dist_inverse_gamma

pub(all) struct StatsdistinversegammaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_dist_inverse_gamma_make_point(x : Double, y : Double) -> StatsdistinversegammaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_dist_inverse_gamma_make_point3(x : Double, y : Double, z : Double) -> StatsdistinversegammaPoint {
  { x, y, z, label: 0 }
}

pub fn stats_dist_inverse_gamma_point_x(pt : StatsdistinversegammaPoint) -> Double { pt.x }

pub fn stats_dist_inverse_gamma_point_y(pt : StatsdistinversegammaPoint) -> Double { pt.y }

pub fn stats_dist_inverse_gamma_point_z(pt : StatsdistinversegammaPoint) -> Double { pt.z }

pub fn stats_dist_inverse_gamma_point_label(pt : StatsdistinversegammaPoint) -> Int { pt.label }

pub fn stats_dist_inverse_gamma_point_dist(a : StatsdistinversegammaPoint, b : StatsdistinversegammaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_dist_inverse_gamma_point_add(a : StatsdistinversegammaPoint, b : StatsdistinversegammaPoint) -> StatsdistinversegammaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_dist_inverse_gamma_point_sub(a : StatsdistinversegammaPoint, b : StatsdistinversegammaPoint) -> StatsdistinversegammaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_dist_inverse_gamma_point_scale(pt : StatsdistinversegammaPoint, s : Double) -> StatsdistinversegammaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_dist_inverse_gamma_point_dot(a : StatsdistinversegammaPoint, b : StatsdistinversegammaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_dist_inverse_gamma_point_cross(a : StatsdistinversegammaPoint, b : StatsdistinversegammaPoint) -> StatsdistinversegammaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_dist_inverse_gamma_point_norm(pt : StatsdistinversegammaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_dist_inverse_gamma_point_normalize(pt : StatsdistinversegammaPoint) -> StatsdistinversegammaPoint {
  let n = stats_dist_inverse_gamma_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_dist_inverse_gamma_point_scale(pt, 1.0 / n) }
}

pub fn stats_dist_inverse_gamma_point_negate(pt : StatsdistinversegammaPoint) -> StatsdistinversegammaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_dist_inverse_gamma_point_mid(a : StatsdistinversegammaPoint, b : StatsdistinversegammaPoint) -> StatsdistinversegammaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_dist_inverse_gamma_point_lerp(a : StatsdistinversegammaPoint, b : StatsdistinversegammaPoint, t : Double) -> StatsdistinversegammaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_dist_inverse_gamma_point_to_string(pt : StatsdistinversegammaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdistinversegammaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_dist_inverse_gamma_make_series(vals : Array[Double], name : String) -> StatsdistinversegammaSeries {
  { vals, name, meta: 0 }
}

pub fn stats_dist_inverse_gamma_series_len(s : StatsdistinversegammaSeries) -> Int { s.vals.length() }

pub fn stats_dist_inverse_gamma_series_sum(s : StatsdistinversegammaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_dist_inverse_gamma_series_mean(s : StatsdistinversegammaSeries) -> Double { @_common.mean(s.vals) }

pub fn stats_dist_inverse_gamma_series_min(s : StatsdistinversegammaSeries) -> Double { @_common.min(s.vals) }

pub fn stats_dist_inverse_gamma_series_max(s : StatsdistinversegammaSeries) -> Double { @_common.max(s.vals) }

pub fn stats_dist_inverse_gamma_series_range(s : StatsdistinversegammaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn stats_dist_inverse_gamma_series_var(s : StatsdistinversegammaSeries) -> Double { @_common.variance(s.vals) }

pub fn stats_dist_inverse_gamma_series_std(s : StatsdistinversegammaSeries) -> Double { @_common.std(s.vals) }

pub fn stats_dist_inverse_gamma_series_median(s : StatsdistinversegammaSeries) -> Double { @_common.median(s.vals) }

pub fn stats_dist_inverse_gamma_series_scale(s : StatsdistinversegammaSeries, f : Double) -> StatsdistinversegammaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_dist_inverse_gamma_series_add(a : StatsdistinversegammaSeries, b : StatsdistinversegammaSeries) -> StatsdistinversegammaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_dist_inverse_gamma_series_sub(a : StatsdistinversegammaSeries, b : StatsdistinversegammaSeries) -> StatsdistinversegammaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_dist_inverse_gamma_series_normalize(s : StatsdistinversegammaSeries) -> StatsdistinversegammaSeries {
  let mn = stats_dist_inverse_gamma_series_min(s)
  let mx = stats_dist_inverse_gamma_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_dist_inverse_gamma_series_cumsum(s : StatsdistinversegammaSeries) -> StatsdistinversegammaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_dist_inverse_gamma_series_to_string(s : StatsdistinversegammaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdistinversegammaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_dist_inverse_gamma_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdistinversegammaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_dist_inverse_gamma_matrix_identity(n : Int) -> StatsdistinversegammaMatrix {
  let m = stats_dist_inverse_gamma_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_dist_inverse_gamma_matrix_get(m : StatsdistinversegammaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_dist_inverse_gamma_matrix_transpose(m : StatsdistinversegammaMatrix) -> StatsdistinversegammaMatrix {
  let result = stats_dist_inverse_gamma_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_dist_inverse_gamma_matrix_add(a : StatsdistinversegammaMatrix, b : StatsdistinversegammaMatrix) -> StatsdistinversegammaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_dist_inverse_gamma_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_dist_inverse_gamma_matrix_scale(m : StatsdistinversegammaMatrix, s : Double) -> StatsdistinversegammaMatrix {
  let result = stats_dist_inverse_gamma_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_dist_inverse_gamma_matrix_multiply(a : StatsdistinversegammaMatrix, b : StatsdistinversegammaMatrix) -> StatsdistinversegammaMatrix {
  if a.cols != b.rows { return stats_dist_inverse_gamma_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_dist_inverse_gamma_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_dist_inverse_gamma_matrix_trace(m : StatsdistinversegammaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_dist_inverse_gamma_matrix_det(m : StatsdistinversegammaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_dist_inverse_gamma_matrix_norm(m : StatsdistinversegammaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_dist_inverse_gamma_matrix_to_string(m : StatsdistinversegammaMatrix) -> String {
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

pub(all) struct StatsdistinversegammaVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_dist_inverse_gamma_make_vector(comps : Array[Double]) -> StatsdistinversegammaVector {
  { comps, dim: comps.length() }
}

pub fn stats_dist_inverse_gamma_vector_zero(dim : Int) -> StatsdistinversegammaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_dist_inverse_gamma_vector_add(a : StatsdistinversegammaVector, b : StatsdistinversegammaVector) -> StatsdistinversegammaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_inverse_gamma_vector_sub(a : StatsdistinversegammaVector, b : StatsdistinversegammaVector) -> StatsdistinversegammaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_dist_inverse_gamma_vector_scale(v : StatsdistinversegammaVector, s : Double) -> StatsdistinversegammaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_dist_inverse_gamma_vector_dot(a : StatsdistinversegammaVector, b : StatsdistinversegammaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_dist_inverse_gamma_vector_norm(v : StatsdistinversegammaVector) -> Double { @_common.sqrt(stats_dist_inverse_gamma_vector_dot(v, v)) }

pub fn stats_dist_inverse_gamma_vector_normalize(v : StatsdistinversegammaVector) -> StatsdistinversegammaVector {
  let n = stats_dist_inverse_gamma_vector_norm(v)
  if n < 0.0000001 { v } else { stats_dist_inverse_gamma_vector_scale(v, 1.0 / n) }
}

pub fn stats_dist_inverse_gamma_vector_dist(a : StatsdistinversegammaVector, b : StatsdistinversegammaVector) -> Double {
  stats_dist_inverse_gamma_vector_norm(stats_dist_inverse_gamma_vector_sub(a, b))
}

pub fn stats_dist_inverse_gamma_vector_to_string(v : StatsdistinversegammaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_dist_inverse_gamma_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_dist_inverse_gamma_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_dist_inverse_gamma_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_dist_inverse_gamma_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_dist_inverse_gamma_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_dist_inverse_gamma_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_dist_inverse_gamma_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_dist_inverse_gamma_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_dist_inverse_gamma_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_dist_inverse_gamma_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_dist_inverse_gamma_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_dist_inverse_gamma_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_dist_inverse_gamma_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_dist_inverse_gamma_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_dist_inverse_gamma_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_dist_inverse_gamma_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_dist_inverse_gamma_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_dist_inverse_gamma_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_dist_inverse_gamma_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_dist_inverse_gamma_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_dist_inverse_gamma_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_dist_inverse_gamma_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_dist_inverse_gamma_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_dist_inverse_gamma_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_dist_inverse_gamma_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_dist_inverse_gamma_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_dist_inverse_gamma_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_dist_inverse_gamma_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_dist_inverse_gamma_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdistinversegammaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_frame_make(size : Int) -> StatsdistinversegammaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_frame_len(s : StatsdistinversegammaFrame) -> Int { s.size }

pub fn stats_dist_inverse_gamma_frame_get(s : StatsdistinversegammaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_frame_set(s : StatsdistinversegammaFrame, i : Int, v : Double) -> StatsdistinversegammaFrame {
  let result = stats_dist_inverse_gamma_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_frame_sum(s : StatsdistinversegammaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_inverse_gamma_frame_mean(s : StatsdistinversegammaFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_inverse_gamma_frame_sum(s) / s.size.to_double() }
}

pub fn stats_dist_inverse_gamma_frame_scale(s : StatsdistinversegammaFrame, f : Double) -> StatsdistinversegammaFrame {
  let result = stats_dist_inverse_gamma_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_inverse_gamma_frame_add(a : StatsdistinversegammaFrame, b : StatsdistinversegammaFrame) -> StatsdistinversegammaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_inverse_gamma_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_frame_copy(s : StatsdistinversegammaFrame) -> StatsdistinversegammaFrame {
  let result = stats_dist_inverse_gamma_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_frame_fill(s : StatsdistinversegammaFrame, v : Double) -> StatsdistinversegammaFrame {
  let result = stats_dist_inverse_gamma_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_frame_min(s : StatsdistinversegammaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_frame_max(s : StatsdistinversegammaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_frame_to_string(s : StatsdistinversegammaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_table_make(size : Int) -> StatsdistinversegammaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_table_len(s : StatsdistinversegammaTable) -> Int { s.size }

pub fn stats_dist_inverse_gamma_table_get(s : StatsdistinversegammaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_table_set(s : StatsdistinversegammaTable, i : Int, v : Double) -> StatsdistinversegammaTable {
  let result = stats_dist_inverse_gamma_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_table_sum(s : StatsdistinversegammaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_inverse_gamma_table_mean(s : StatsdistinversegammaTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_inverse_gamma_table_sum(s) / s.size.to_double() }
}

pub fn stats_dist_inverse_gamma_table_scale(s : StatsdistinversegammaTable, f : Double) -> StatsdistinversegammaTable {
  let result = stats_dist_inverse_gamma_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_inverse_gamma_table_add(a : StatsdistinversegammaTable, b : StatsdistinversegammaTable) -> StatsdistinversegammaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_inverse_gamma_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_table_copy(s : StatsdistinversegammaTable) -> StatsdistinversegammaTable {
  let result = stats_dist_inverse_gamma_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_table_fill(s : StatsdistinversegammaTable, v : Double) -> StatsdistinversegammaTable {
  let result = stats_dist_inverse_gamma_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_table_min(s : StatsdistinversegammaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_table_max(s : StatsdistinversegammaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_table_to_string(s : StatsdistinversegammaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_graphn_make(size : Int) -> StatsdistinversegammaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_graphn_len(s : StatsdistinversegammaGraphN) -> Int { s.size }

pub fn stats_dist_inverse_gamma_graphn_get(s : StatsdistinversegammaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_graphn_set(s : StatsdistinversegammaGraphN, i : Int, v : Double) -> StatsdistinversegammaGraphN {
  let result = stats_dist_inverse_gamma_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_graphn_sum(s : StatsdistinversegammaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_inverse_gamma_graphn_mean(s : StatsdistinversegammaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_inverse_gamma_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_dist_inverse_gamma_graphn_scale(s : StatsdistinversegammaGraphN, f : Double) -> StatsdistinversegammaGraphN {
  let result = stats_dist_inverse_gamma_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_inverse_gamma_graphn_add(a : StatsdistinversegammaGraphN, b : StatsdistinversegammaGraphN) -> StatsdistinversegammaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_inverse_gamma_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_graphn_copy(s : StatsdistinversegammaGraphN) -> StatsdistinversegammaGraphN {
  let result = stats_dist_inverse_gamma_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_graphn_fill(s : StatsdistinversegammaGraphN, v : Double) -> StatsdistinversegammaGraphN {
  let result = stats_dist_inverse_gamma_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_graphn_min(s : StatsdistinversegammaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_graphn_max(s : StatsdistinversegammaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_graphn_to_string(s : StatsdistinversegammaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_node_make(size : Int) -> StatsdistinversegammaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_node_len(s : StatsdistinversegammaNode) -> Int { s.size }

pub fn stats_dist_inverse_gamma_node_get(s : StatsdistinversegammaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_node_set(s : StatsdistinversegammaNode, i : Int, v : Double) -> StatsdistinversegammaNode {
  let result = stats_dist_inverse_gamma_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_node_sum(s : StatsdistinversegammaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_inverse_gamma_node_mean(s : StatsdistinversegammaNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_inverse_gamma_node_sum(s) / s.size.to_double() }
}

pub fn stats_dist_inverse_gamma_node_scale(s : StatsdistinversegammaNode, f : Double) -> StatsdistinversegammaNode {
  let result = stats_dist_inverse_gamma_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_inverse_gamma_node_add(a : StatsdistinversegammaNode, b : StatsdistinversegammaNode) -> StatsdistinversegammaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_inverse_gamma_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_node_copy(s : StatsdistinversegammaNode) -> StatsdistinversegammaNode {
  let result = stats_dist_inverse_gamma_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_node_fill(s : StatsdistinversegammaNode, v : Double) -> StatsdistinversegammaNode {
  let result = stats_dist_inverse_gamma_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_node_min(s : StatsdistinversegammaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_node_max(s : StatsdistinversegammaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_node_to_string(s : StatsdistinversegammaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_edge_make(size : Int) -> StatsdistinversegammaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_edge_len(s : StatsdistinversegammaEdge) -> Int { s.size }

pub fn stats_dist_inverse_gamma_edge_get(s : StatsdistinversegammaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_edge_set(s : StatsdistinversegammaEdge, i : Int, v : Double) -> StatsdistinversegammaEdge {
  let result = stats_dist_inverse_gamma_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_edge_sum(s : StatsdistinversegammaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_inverse_gamma_edge_mean(s : StatsdistinversegammaEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_inverse_gamma_edge_sum(s) / s.size.to_double() }
}

pub fn stats_dist_inverse_gamma_edge_scale(s : StatsdistinversegammaEdge, f : Double) -> StatsdistinversegammaEdge {
  let result = stats_dist_inverse_gamma_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_inverse_gamma_edge_add(a : StatsdistinversegammaEdge, b : StatsdistinversegammaEdge) -> StatsdistinversegammaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_inverse_gamma_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_edge_copy(s : StatsdistinversegammaEdge) -> StatsdistinversegammaEdge {
  let result = stats_dist_inverse_gamma_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_edge_fill(s : StatsdistinversegammaEdge, v : Double) -> StatsdistinversegammaEdge {
  let result = stats_dist_inverse_gamma_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_edge_min(s : StatsdistinversegammaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_edge_max(s : StatsdistinversegammaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_edge_to_string(s : StatsdistinversegammaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_path_make(size : Int) -> StatsdistinversegammaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_path_len(s : StatsdistinversegammaPath) -> Int { s.size }

pub fn stats_dist_inverse_gamma_path_get(s : StatsdistinversegammaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_path_set(s : StatsdistinversegammaPath, i : Int, v : Double) -> StatsdistinversegammaPath {
  let result = stats_dist_inverse_gamma_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_path_sum(s : StatsdistinversegammaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_inverse_gamma_path_mean(s : StatsdistinversegammaPath) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_inverse_gamma_path_sum(s) / s.size.to_double() }
}

pub fn stats_dist_inverse_gamma_path_scale(s : StatsdistinversegammaPath, f : Double) -> StatsdistinversegammaPath {
  let result = stats_dist_inverse_gamma_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_inverse_gamma_path_add(a : StatsdistinversegammaPath, b : StatsdistinversegammaPath) -> StatsdistinversegammaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_inverse_gamma_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_path_copy(s : StatsdistinversegammaPath) -> StatsdistinversegammaPath {
  let result = stats_dist_inverse_gamma_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_path_fill(s : StatsdistinversegammaPath, v : Double) -> StatsdistinversegammaPath {
  let result = stats_dist_inverse_gamma_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_path_min(s : StatsdistinversegammaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_path_max(s : StatsdistinversegammaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_path_to_string(s : StatsdistinversegammaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_cluster_make(size : Int) -> StatsdistinversegammaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_cluster_len(s : StatsdistinversegammaCluster) -> Int { s.size }

pub fn stats_dist_inverse_gamma_cluster_get(s : StatsdistinversegammaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_cluster_set(s : StatsdistinversegammaCluster, i : Int, v : Double) -> StatsdistinversegammaCluster {
  let result = stats_dist_inverse_gamma_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_cluster_sum(s : StatsdistinversegammaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_inverse_gamma_cluster_mean(s : StatsdistinversegammaCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_inverse_gamma_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_dist_inverse_gamma_cluster_scale(s : StatsdistinversegammaCluster, f : Double) -> StatsdistinversegammaCluster {
  let result = stats_dist_inverse_gamma_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_inverse_gamma_cluster_add(a : StatsdistinversegammaCluster, b : StatsdistinversegammaCluster) -> StatsdistinversegammaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_inverse_gamma_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_cluster_copy(s : StatsdistinversegammaCluster) -> StatsdistinversegammaCluster {
  let result = stats_dist_inverse_gamma_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_cluster_fill(s : StatsdistinversegammaCluster, v : Double) -> StatsdistinversegammaCluster {
  let result = stats_dist_inverse_gamma_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_cluster_min(s : StatsdistinversegammaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_cluster_max(s : StatsdistinversegammaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_cluster_to_string(s : StatsdistinversegammaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_model_make(size : Int) -> StatsdistinversegammaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_model_len(s : StatsdistinversegammaModel) -> Int { s.size }

pub fn stats_dist_inverse_gamma_model_get(s : StatsdistinversegammaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_model_set(s : StatsdistinversegammaModel, i : Int, v : Double) -> StatsdistinversegammaModel {
  let result = stats_dist_inverse_gamma_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_model_sum(s : StatsdistinversegammaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_inverse_gamma_model_mean(s : StatsdistinversegammaModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_inverse_gamma_model_sum(s) / s.size.to_double() }
}

pub fn stats_dist_inverse_gamma_model_scale(s : StatsdistinversegammaModel, f : Double) -> StatsdistinversegammaModel {
  let result = stats_dist_inverse_gamma_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_inverse_gamma_model_add(a : StatsdistinversegammaModel, b : StatsdistinversegammaModel) -> StatsdistinversegammaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_inverse_gamma_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_model_copy(s : StatsdistinversegammaModel) -> StatsdistinversegammaModel {
  let result = stats_dist_inverse_gamma_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_model_fill(s : StatsdistinversegammaModel, v : Double) -> StatsdistinversegammaModel {
  let result = stats_dist_inverse_gamma_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_model_min(s : StatsdistinversegammaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_model_max(s : StatsdistinversegammaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_model_to_string(s : StatsdistinversegammaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_layer_make(size : Int) -> StatsdistinversegammaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_layer_len(s : StatsdistinversegammaLayer) -> Int { s.size }

pub fn stats_dist_inverse_gamma_layer_get(s : StatsdistinversegammaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_layer_set(s : StatsdistinversegammaLayer, i : Int, v : Double) -> StatsdistinversegammaLayer {
  let result = stats_dist_inverse_gamma_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_layer_sum(s : StatsdistinversegammaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_inverse_gamma_layer_mean(s : StatsdistinversegammaLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_inverse_gamma_layer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_inverse_gamma_layer_scale(s : StatsdistinversegammaLayer, f : Double) -> StatsdistinversegammaLayer {
  let result = stats_dist_inverse_gamma_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_inverse_gamma_layer_add(a : StatsdistinversegammaLayer, b : StatsdistinversegammaLayer) -> StatsdistinversegammaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_inverse_gamma_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_layer_copy(s : StatsdistinversegammaLayer) -> StatsdistinversegammaLayer {
  let result = stats_dist_inverse_gamma_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_layer_fill(s : StatsdistinversegammaLayer, v : Double) -> StatsdistinversegammaLayer {
  let result = stats_dist_inverse_gamma_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_layer_min(s : StatsdistinversegammaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_layer_max(s : StatsdistinversegammaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_layer_to_string(s : StatsdistinversegammaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_buffer_make(size : Int) -> StatsdistinversegammaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_buffer_len(s : StatsdistinversegammaBuffer) -> Int { s.size }

pub fn stats_dist_inverse_gamma_buffer_get(s : StatsdistinversegammaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_buffer_set(s : StatsdistinversegammaBuffer, i : Int, v : Double) -> StatsdistinversegammaBuffer {
  let result = stats_dist_inverse_gamma_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_buffer_sum(s : StatsdistinversegammaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_inverse_gamma_buffer_mean(s : StatsdistinversegammaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_inverse_gamma_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_dist_inverse_gamma_buffer_scale(s : StatsdistinversegammaBuffer, f : Double) -> StatsdistinversegammaBuffer {
  let result = stats_dist_inverse_gamma_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_inverse_gamma_buffer_add(a : StatsdistinversegammaBuffer, b : StatsdistinversegammaBuffer) -> StatsdistinversegammaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_inverse_gamma_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_buffer_copy(s : StatsdistinversegammaBuffer) -> StatsdistinversegammaBuffer {
  let result = stats_dist_inverse_gamma_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_buffer_fill(s : StatsdistinversegammaBuffer, v : Double) -> StatsdistinversegammaBuffer {
  let result = stats_dist_inverse_gamma_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_buffer_min(s : StatsdistinversegammaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_buffer_max(s : StatsdistinversegammaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_buffer_to_string(s : StatsdistinversegammaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_cursor_make(size : Int) -> StatsdistinversegammaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_cursor_len(s : StatsdistinversegammaCursor) -> Int { s.size }

pub fn stats_dist_inverse_gamma_cursor_get(s : StatsdistinversegammaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_cursor_set(s : StatsdistinversegammaCursor, i : Int, v : Double) -> StatsdistinversegammaCursor {
  let result = stats_dist_inverse_gamma_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_cursor_sum(s : StatsdistinversegammaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_inverse_gamma_cursor_mean(s : StatsdistinversegammaCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_inverse_gamma_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_dist_inverse_gamma_cursor_scale(s : StatsdistinversegammaCursor, f : Double) -> StatsdistinversegammaCursor {
  let result = stats_dist_inverse_gamma_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_inverse_gamma_cursor_add(a : StatsdistinversegammaCursor, b : StatsdistinversegammaCursor) -> StatsdistinversegammaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_inverse_gamma_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_cursor_copy(s : StatsdistinversegammaCursor) -> StatsdistinversegammaCursor {
  let result = stats_dist_inverse_gamma_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_cursor_fill(s : StatsdistinversegammaCursor, v : Double) -> StatsdistinversegammaCursor {
  let result = stats_dist_inverse_gamma_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_cursor_min(s : StatsdistinversegammaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_cursor_max(s : StatsdistinversegammaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_cursor_to_string(s : StatsdistinversegammaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_view_make(size : Int) -> StatsdistinversegammaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_view_len(s : StatsdistinversegammaView) -> Int { s.size }

pub fn stats_dist_inverse_gamma_view_get(s : StatsdistinversegammaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_view_set(s : StatsdistinversegammaView, i : Int, v : Double) -> StatsdistinversegammaView {
  let result = stats_dist_inverse_gamma_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_view_sum(s : StatsdistinversegammaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_inverse_gamma_view_mean(s : StatsdistinversegammaView) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_inverse_gamma_view_sum(s) / s.size.to_double() }
}

pub fn stats_dist_inverse_gamma_view_scale(s : StatsdistinversegammaView, f : Double) -> StatsdistinversegammaView {
  let result = stats_dist_inverse_gamma_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_inverse_gamma_view_add(a : StatsdistinversegammaView, b : StatsdistinversegammaView) -> StatsdistinversegammaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_inverse_gamma_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_view_copy(s : StatsdistinversegammaView) -> StatsdistinversegammaView {
  let result = stats_dist_inverse_gamma_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_view_fill(s : StatsdistinversegammaView, v : Double) -> StatsdistinversegammaView {
  let result = stats_dist_inverse_gamma_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_view_min(s : StatsdistinversegammaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_view_max(s : StatsdistinversegammaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_view_to_string(s : StatsdistinversegammaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_range_make(size : Int) -> StatsdistinversegammaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_range_len(s : StatsdistinversegammaRange) -> Int { s.size }

pub fn stats_dist_inverse_gamma_range_get(s : StatsdistinversegammaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_range_set(s : StatsdistinversegammaRange, i : Int, v : Double) -> StatsdistinversegammaRange {
  let result = stats_dist_inverse_gamma_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_range_sum(s : StatsdistinversegammaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_inverse_gamma_range_mean(s : StatsdistinversegammaRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_inverse_gamma_range_sum(s) / s.size.to_double() }
}

pub fn stats_dist_inverse_gamma_range_scale(s : StatsdistinversegammaRange, f : Double) -> StatsdistinversegammaRange {
  let result = stats_dist_inverse_gamma_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_inverse_gamma_range_add(a : StatsdistinversegammaRange, b : StatsdistinversegammaRange) -> StatsdistinversegammaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_inverse_gamma_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_range_copy(s : StatsdistinversegammaRange) -> StatsdistinversegammaRange {
  let result = stats_dist_inverse_gamma_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_range_fill(s : StatsdistinversegammaRange, v : Double) -> StatsdistinversegammaRange {
  let result = stats_dist_inverse_gamma_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_range_min(s : StatsdistinversegammaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_range_max(s : StatsdistinversegammaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_range_to_string(s : StatsdistinversegammaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdistinversegammaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_dist_inverse_gamma_slice_make(size : Int) -> StatsdistinversegammaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_dist_inverse_gamma_slice_len(s : StatsdistinversegammaSlice) -> Int { s.size }

pub fn stats_dist_inverse_gamma_slice_get(s : StatsdistinversegammaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_dist_inverse_gamma_slice_set(s : StatsdistinversegammaSlice, i : Int, v : Double) -> StatsdistinversegammaSlice {
  let result = stats_dist_inverse_gamma_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_slice_sum(s : StatsdistinversegammaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_dist_inverse_gamma_slice_mean(s : StatsdistinversegammaSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_dist_inverse_gamma_slice_sum(s) / s.size.to_double() }
}

pub fn stats_dist_inverse_gamma_slice_scale(s : StatsdistinversegammaSlice, f : Double) -> StatsdistinversegammaSlice {
  let result = stats_dist_inverse_gamma_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_dist_inverse_gamma_slice_add(a : StatsdistinversegammaSlice, b : StatsdistinversegammaSlice) -> StatsdistinversegammaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_dist_inverse_gamma_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_slice_copy(s : StatsdistinversegammaSlice) -> StatsdistinversegammaSlice {
  let result = stats_dist_inverse_gamma_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_dist_inverse_gamma_slice_fill(s : StatsdistinversegammaSlice, v : Double) -> StatsdistinversegammaSlice {
  let result = stats_dist_inverse_gamma_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_dist_inverse_gamma_slice_min(s : StatsdistinversegammaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_slice_max(s : StatsdistinversegammaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_dist_inverse_gamma_slice_to_string(s : StatsdistinversegammaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

