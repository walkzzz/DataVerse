///===
/// extcore/stats_desc_multivariate

pub(all) struct StatsdescmultivariatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_desc_multivariate_make_point(x : Double, y : Double) -> StatsdescmultivariatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_desc_multivariate_make_point3(x : Double, y : Double, z : Double) -> StatsdescmultivariatePoint {
  { x, y, z, label: 0 }
}

pub fn stats_desc_multivariate_point_x(pt : StatsdescmultivariatePoint) -> Double { pt.x }

pub fn stats_desc_multivariate_point_y(pt : StatsdescmultivariatePoint) -> Double { pt.y }

pub fn stats_desc_multivariate_point_z(pt : StatsdescmultivariatePoint) -> Double { pt.z }

pub fn stats_desc_multivariate_point_label(pt : StatsdescmultivariatePoint) -> Int { pt.label }

pub fn stats_desc_multivariate_point_dist(a : StatsdescmultivariatePoint, b : StatsdescmultivariatePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_desc_multivariate_point_add(a : StatsdescmultivariatePoint, b : StatsdescmultivariatePoint) -> StatsdescmultivariatePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_desc_multivariate_point_sub(a : StatsdescmultivariatePoint, b : StatsdescmultivariatePoint) -> StatsdescmultivariatePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_desc_multivariate_point_scale(pt : StatsdescmultivariatePoint, s : Double) -> StatsdescmultivariatePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_desc_multivariate_point_dot(a : StatsdescmultivariatePoint, b : StatsdescmultivariatePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_desc_multivariate_point_cross(a : StatsdescmultivariatePoint, b : StatsdescmultivariatePoint) -> StatsdescmultivariatePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_desc_multivariate_point_norm(pt : StatsdescmultivariatePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_desc_multivariate_point_normalize(pt : StatsdescmultivariatePoint) -> StatsdescmultivariatePoint {
  let n = stats_desc_multivariate_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_desc_multivariate_point_scale(pt, 1.0 / n) }
}

pub fn stats_desc_multivariate_point_negate(pt : StatsdescmultivariatePoint) -> StatsdescmultivariatePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_desc_multivariate_point_mid(a : StatsdescmultivariatePoint, b : StatsdescmultivariatePoint) -> StatsdescmultivariatePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_desc_multivariate_point_lerp(a : StatsdescmultivariatePoint, b : StatsdescmultivariatePoint, t : Double) -> StatsdescmultivariatePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_desc_multivariate_point_to_string(pt : StatsdescmultivariatePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdescmultivariateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_desc_multivariate_make_series(vals : Array[Double], name : String) -> StatsdescmultivariateSeries {
  { vals, name, meta: 0 }
}

pub fn stats_desc_multivariate_series_len(s : StatsdescmultivariateSeries) -> Int { s.vals.length() }

pub fn stats_desc_multivariate_series_sum(s : StatsdescmultivariateSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_desc_multivariate_series_mean(s : StatsdescmultivariateSeries) -> Double {
  let n = stats_desc_multivariate_series_len(s)
  if n == 0 { 0.0 } else { stats_desc_multivariate_series_sum(s) / n.to_double() }
}

pub fn stats_desc_multivariate_series_min(s : StatsdescmultivariateSeries) -> Double {
  let n = stats_desc_multivariate_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_desc_multivariate_series_max(s : StatsdescmultivariateSeries) -> Double {
  let n = stats_desc_multivariate_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_desc_multivariate_series_range(s : StatsdescmultivariateSeries) -> Double {
  stats_desc_multivariate_series_max(s) - stats_desc_multivariate_series_min(s)
}

pub fn stats_desc_multivariate_series_var(s : StatsdescmultivariateSeries) -> Double {
  let n = stats_desc_multivariate_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_desc_multivariate_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_desc_multivariate_series_std(s : StatsdescmultivariateSeries) -> Double { @_common.sqrt(stats_desc_multivariate_series_var(s)) }

pub fn stats_desc_multivariate_series_median(s : StatsdescmultivariateSeries) -> Double {
  let n = stats_desc_multivariate_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_desc_multivariate_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_desc_multivariate_series_scale(s : StatsdescmultivariateSeries, f : Double) -> StatsdescmultivariateSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_desc_multivariate_series_add(a : StatsdescmultivariateSeries, b : StatsdescmultivariateSeries) -> StatsdescmultivariateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_desc_multivariate_series_sub(a : StatsdescmultivariateSeries, b : StatsdescmultivariateSeries) -> StatsdescmultivariateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_desc_multivariate_series_normalize(s : StatsdescmultivariateSeries) -> StatsdescmultivariateSeries {
  let mn = stats_desc_multivariate_series_min(s)
  let mx = stats_desc_multivariate_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_desc_multivariate_series_cumsum(s : StatsdescmultivariateSeries) -> StatsdescmultivariateSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_desc_multivariate_series_to_string(s : StatsdescmultivariateSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdescmultivariateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_desc_multivariate_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdescmultivariateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_desc_multivariate_matrix_identity(n : Int) -> StatsdescmultivariateMatrix {
  let m = stats_desc_multivariate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_desc_multivariate_matrix_get(m : StatsdescmultivariateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_desc_multivariate_matrix_transpose(m : StatsdescmultivariateMatrix) -> StatsdescmultivariateMatrix {
  let result = stats_desc_multivariate_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_desc_multivariate_matrix_add(a : StatsdescmultivariateMatrix, b : StatsdescmultivariateMatrix) -> StatsdescmultivariateMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_desc_multivariate_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_desc_multivariate_matrix_scale(m : StatsdescmultivariateMatrix, s : Double) -> StatsdescmultivariateMatrix {
  let result = stats_desc_multivariate_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_desc_multivariate_matrix_multiply(a : StatsdescmultivariateMatrix, b : StatsdescmultivariateMatrix) -> StatsdescmultivariateMatrix {
  if a.cols != b.rows { return stats_desc_multivariate_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_desc_multivariate_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_desc_multivariate_matrix_trace(m : StatsdescmultivariateMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_desc_multivariate_matrix_det(m : StatsdescmultivariateMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_desc_multivariate_matrix_norm(m : StatsdescmultivariateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_desc_multivariate_matrix_to_string(m : StatsdescmultivariateMatrix) -> String {
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

pub(all) struct StatsdescmultivariateVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_desc_multivariate_make_vector(comps : Array[Double]) -> StatsdescmultivariateVector {
  { comps, dim: comps.length() }
}

pub fn stats_desc_multivariate_vector_zero(dim : Int) -> StatsdescmultivariateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_desc_multivariate_vector_add(a : StatsdescmultivariateVector, b : StatsdescmultivariateVector) -> StatsdescmultivariateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_desc_multivariate_vector_sub(a : StatsdescmultivariateVector, b : StatsdescmultivariateVector) -> StatsdescmultivariateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_desc_multivariate_vector_scale(v : StatsdescmultivariateVector, s : Double) -> StatsdescmultivariateVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_desc_multivariate_vector_dot(a : StatsdescmultivariateVector, b : StatsdescmultivariateVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_desc_multivariate_vector_norm(v : StatsdescmultivariateVector) -> Double { @_common.sqrt(stats_desc_multivariate_vector_dot(v, v)) }

pub fn stats_desc_multivariate_vector_normalize(v : StatsdescmultivariateVector) -> StatsdescmultivariateVector {
  let n = stats_desc_multivariate_vector_norm(v)
  if n < 0.0000001 { v } else { stats_desc_multivariate_vector_scale(v, 1.0 / n) }
}

pub fn stats_desc_multivariate_vector_dist(a : StatsdescmultivariateVector, b : StatsdescmultivariateVector) -> Double {
  stats_desc_multivariate_vector_norm(stats_desc_multivariate_vector_sub(a, b))
}

pub fn stats_desc_multivariate_vector_to_string(v : StatsdescmultivariateVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_desc_multivariate_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_desc_multivariate_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_desc_multivariate_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_desc_multivariate_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_desc_multivariate_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_desc_multivariate_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_desc_multivariate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_desc_multivariate_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_desc_multivariate_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_desc_multivariate_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_desc_multivariate_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_desc_multivariate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_desc_multivariate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_desc_multivariate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_desc_multivariate_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_desc_multivariate_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_desc_multivariate_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_desc_multivariate_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_desc_multivariate_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_desc_multivariate_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_desc_multivariate_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_desc_multivariate_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_desc_multivariate_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_desc_multivariate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_desc_multivariate_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_desc_multivariate_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_desc_multivariate_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_desc_multivariate_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_desc_multivariate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdescmultivariateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_frame_make(size : Int) -> StatsdescmultivariateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_frame_len(s : StatsdescmultivariateFrame) -> Int { s.size }

pub fn stats_desc_multivariate_frame_get(s : StatsdescmultivariateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_frame_set(s : StatsdescmultivariateFrame, i : Int, v : Double) -> StatsdescmultivariateFrame {
  let result = stats_desc_multivariate_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_frame_sum(s : StatsdescmultivariateFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_multivariate_frame_mean(s : StatsdescmultivariateFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_multivariate_frame_sum(s) / s.size.to_double() }
}

pub fn stats_desc_multivariate_frame_scale(s : StatsdescmultivariateFrame, f : Double) -> StatsdescmultivariateFrame {
  let result = stats_desc_multivariate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_multivariate_frame_add(a : StatsdescmultivariateFrame, b : StatsdescmultivariateFrame) -> StatsdescmultivariateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_multivariate_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_multivariate_frame_copy(s : StatsdescmultivariateFrame) -> StatsdescmultivariateFrame {
  let result = stats_desc_multivariate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_multivariate_frame_fill(s : StatsdescmultivariateFrame, v : Double) -> StatsdescmultivariateFrame {
  let result = stats_desc_multivariate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_frame_min(s : StatsdescmultivariateFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_frame_max(s : StatsdescmultivariateFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_frame_to_string(s : StatsdescmultivariateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_table_make(size : Int) -> StatsdescmultivariateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_table_len(s : StatsdescmultivariateTable) -> Int { s.size }

pub fn stats_desc_multivariate_table_get(s : StatsdescmultivariateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_table_set(s : StatsdescmultivariateTable, i : Int, v : Double) -> StatsdescmultivariateTable {
  let result = stats_desc_multivariate_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_table_sum(s : StatsdescmultivariateTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_multivariate_table_mean(s : StatsdescmultivariateTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_multivariate_table_sum(s) / s.size.to_double() }
}

pub fn stats_desc_multivariate_table_scale(s : StatsdescmultivariateTable, f : Double) -> StatsdescmultivariateTable {
  let result = stats_desc_multivariate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_multivariate_table_add(a : StatsdescmultivariateTable, b : StatsdescmultivariateTable) -> StatsdescmultivariateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_multivariate_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_multivariate_table_copy(s : StatsdescmultivariateTable) -> StatsdescmultivariateTable {
  let result = stats_desc_multivariate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_multivariate_table_fill(s : StatsdescmultivariateTable, v : Double) -> StatsdescmultivariateTable {
  let result = stats_desc_multivariate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_table_min(s : StatsdescmultivariateTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_table_max(s : StatsdescmultivariateTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_table_to_string(s : StatsdescmultivariateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_graphn_make(size : Int) -> StatsdescmultivariateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_graphn_len(s : StatsdescmultivariateGraphN) -> Int { s.size }

pub fn stats_desc_multivariate_graphn_get(s : StatsdescmultivariateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_graphn_set(s : StatsdescmultivariateGraphN, i : Int, v : Double) -> StatsdescmultivariateGraphN {
  let result = stats_desc_multivariate_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_graphn_sum(s : StatsdescmultivariateGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_multivariate_graphn_mean(s : StatsdescmultivariateGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_multivariate_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_desc_multivariate_graphn_scale(s : StatsdescmultivariateGraphN, f : Double) -> StatsdescmultivariateGraphN {
  let result = stats_desc_multivariate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_multivariate_graphn_add(a : StatsdescmultivariateGraphN, b : StatsdescmultivariateGraphN) -> StatsdescmultivariateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_multivariate_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_multivariate_graphn_copy(s : StatsdescmultivariateGraphN) -> StatsdescmultivariateGraphN {
  let result = stats_desc_multivariate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_multivariate_graphn_fill(s : StatsdescmultivariateGraphN, v : Double) -> StatsdescmultivariateGraphN {
  let result = stats_desc_multivariate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_graphn_min(s : StatsdescmultivariateGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_graphn_max(s : StatsdescmultivariateGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_graphn_to_string(s : StatsdescmultivariateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_node_make(size : Int) -> StatsdescmultivariateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_node_len(s : StatsdescmultivariateNode) -> Int { s.size }

pub fn stats_desc_multivariate_node_get(s : StatsdescmultivariateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_node_set(s : StatsdescmultivariateNode, i : Int, v : Double) -> StatsdescmultivariateNode {
  let result = stats_desc_multivariate_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_node_sum(s : StatsdescmultivariateNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_multivariate_node_mean(s : StatsdescmultivariateNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_multivariate_node_sum(s) / s.size.to_double() }
}

pub fn stats_desc_multivariate_node_scale(s : StatsdescmultivariateNode, f : Double) -> StatsdescmultivariateNode {
  let result = stats_desc_multivariate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_multivariate_node_add(a : StatsdescmultivariateNode, b : StatsdescmultivariateNode) -> StatsdescmultivariateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_multivariate_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_multivariate_node_copy(s : StatsdescmultivariateNode) -> StatsdescmultivariateNode {
  let result = stats_desc_multivariate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_multivariate_node_fill(s : StatsdescmultivariateNode, v : Double) -> StatsdescmultivariateNode {
  let result = stats_desc_multivariate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_node_min(s : StatsdescmultivariateNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_node_max(s : StatsdescmultivariateNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_node_to_string(s : StatsdescmultivariateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_edge_make(size : Int) -> StatsdescmultivariateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_edge_len(s : StatsdescmultivariateEdge) -> Int { s.size }

pub fn stats_desc_multivariate_edge_get(s : StatsdescmultivariateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_edge_set(s : StatsdescmultivariateEdge, i : Int, v : Double) -> StatsdescmultivariateEdge {
  let result = stats_desc_multivariate_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_edge_sum(s : StatsdescmultivariateEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_multivariate_edge_mean(s : StatsdescmultivariateEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_multivariate_edge_sum(s) / s.size.to_double() }
}

pub fn stats_desc_multivariate_edge_scale(s : StatsdescmultivariateEdge, f : Double) -> StatsdescmultivariateEdge {
  let result = stats_desc_multivariate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_multivariate_edge_add(a : StatsdescmultivariateEdge, b : StatsdescmultivariateEdge) -> StatsdescmultivariateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_multivariate_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_multivariate_edge_copy(s : StatsdescmultivariateEdge) -> StatsdescmultivariateEdge {
  let result = stats_desc_multivariate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_multivariate_edge_fill(s : StatsdescmultivariateEdge, v : Double) -> StatsdescmultivariateEdge {
  let result = stats_desc_multivariate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_edge_min(s : StatsdescmultivariateEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_edge_max(s : StatsdescmultivariateEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_edge_to_string(s : StatsdescmultivariateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_path_make(size : Int) -> StatsdescmultivariatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_path_len(s : StatsdescmultivariatePath) -> Int { s.size }

pub fn stats_desc_multivariate_path_get(s : StatsdescmultivariatePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_path_set(s : StatsdescmultivariatePath, i : Int, v : Double) -> StatsdescmultivariatePath {
  let result = stats_desc_multivariate_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_path_sum(s : StatsdescmultivariatePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_multivariate_path_mean(s : StatsdescmultivariatePath) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_multivariate_path_sum(s) / s.size.to_double() }
}

pub fn stats_desc_multivariate_path_scale(s : StatsdescmultivariatePath, f : Double) -> StatsdescmultivariatePath {
  let result = stats_desc_multivariate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_multivariate_path_add(a : StatsdescmultivariatePath, b : StatsdescmultivariatePath) -> StatsdescmultivariatePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_multivariate_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_multivariate_path_copy(s : StatsdescmultivariatePath) -> StatsdescmultivariatePath {
  let result = stats_desc_multivariate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_multivariate_path_fill(s : StatsdescmultivariatePath, v : Double) -> StatsdescmultivariatePath {
  let result = stats_desc_multivariate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_path_min(s : StatsdescmultivariatePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_path_max(s : StatsdescmultivariatePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_path_to_string(s : StatsdescmultivariatePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_cluster_make(size : Int) -> StatsdescmultivariateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_cluster_len(s : StatsdescmultivariateCluster) -> Int { s.size }

pub fn stats_desc_multivariate_cluster_get(s : StatsdescmultivariateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_cluster_set(s : StatsdescmultivariateCluster, i : Int, v : Double) -> StatsdescmultivariateCluster {
  let result = stats_desc_multivariate_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_cluster_sum(s : StatsdescmultivariateCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_multivariate_cluster_mean(s : StatsdescmultivariateCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_multivariate_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_desc_multivariate_cluster_scale(s : StatsdescmultivariateCluster, f : Double) -> StatsdescmultivariateCluster {
  let result = stats_desc_multivariate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_multivariate_cluster_add(a : StatsdescmultivariateCluster, b : StatsdescmultivariateCluster) -> StatsdescmultivariateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_multivariate_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_multivariate_cluster_copy(s : StatsdescmultivariateCluster) -> StatsdescmultivariateCluster {
  let result = stats_desc_multivariate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_multivariate_cluster_fill(s : StatsdescmultivariateCluster, v : Double) -> StatsdescmultivariateCluster {
  let result = stats_desc_multivariate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_cluster_min(s : StatsdescmultivariateCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_cluster_max(s : StatsdescmultivariateCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_cluster_to_string(s : StatsdescmultivariateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_model_make(size : Int) -> StatsdescmultivariateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_model_len(s : StatsdescmultivariateModel) -> Int { s.size }

pub fn stats_desc_multivariate_model_get(s : StatsdescmultivariateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_model_set(s : StatsdescmultivariateModel, i : Int, v : Double) -> StatsdescmultivariateModel {
  let result = stats_desc_multivariate_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_model_sum(s : StatsdescmultivariateModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_multivariate_model_mean(s : StatsdescmultivariateModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_multivariate_model_sum(s) / s.size.to_double() }
}

pub fn stats_desc_multivariate_model_scale(s : StatsdescmultivariateModel, f : Double) -> StatsdescmultivariateModel {
  let result = stats_desc_multivariate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_multivariate_model_add(a : StatsdescmultivariateModel, b : StatsdescmultivariateModel) -> StatsdescmultivariateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_multivariate_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_multivariate_model_copy(s : StatsdescmultivariateModel) -> StatsdescmultivariateModel {
  let result = stats_desc_multivariate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_multivariate_model_fill(s : StatsdescmultivariateModel, v : Double) -> StatsdescmultivariateModel {
  let result = stats_desc_multivariate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_model_min(s : StatsdescmultivariateModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_model_max(s : StatsdescmultivariateModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_model_to_string(s : StatsdescmultivariateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_layer_make(size : Int) -> StatsdescmultivariateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_layer_len(s : StatsdescmultivariateLayer) -> Int { s.size }

pub fn stats_desc_multivariate_layer_get(s : StatsdescmultivariateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_layer_set(s : StatsdescmultivariateLayer, i : Int, v : Double) -> StatsdescmultivariateLayer {
  let result = stats_desc_multivariate_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_layer_sum(s : StatsdescmultivariateLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_multivariate_layer_mean(s : StatsdescmultivariateLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_multivariate_layer_sum(s) / s.size.to_double() }
}

pub fn stats_desc_multivariate_layer_scale(s : StatsdescmultivariateLayer, f : Double) -> StatsdescmultivariateLayer {
  let result = stats_desc_multivariate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_multivariate_layer_add(a : StatsdescmultivariateLayer, b : StatsdescmultivariateLayer) -> StatsdescmultivariateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_multivariate_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_multivariate_layer_copy(s : StatsdescmultivariateLayer) -> StatsdescmultivariateLayer {
  let result = stats_desc_multivariate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_multivariate_layer_fill(s : StatsdescmultivariateLayer, v : Double) -> StatsdescmultivariateLayer {
  let result = stats_desc_multivariate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_layer_min(s : StatsdescmultivariateLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_layer_max(s : StatsdescmultivariateLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_layer_to_string(s : StatsdescmultivariateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_buffer_make(size : Int) -> StatsdescmultivariateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_buffer_len(s : StatsdescmultivariateBuffer) -> Int { s.size }

pub fn stats_desc_multivariate_buffer_get(s : StatsdescmultivariateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_buffer_set(s : StatsdescmultivariateBuffer, i : Int, v : Double) -> StatsdescmultivariateBuffer {
  let result = stats_desc_multivariate_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_buffer_sum(s : StatsdescmultivariateBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_multivariate_buffer_mean(s : StatsdescmultivariateBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_multivariate_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_desc_multivariate_buffer_scale(s : StatsdescmultivariateBuffer, f : Double) -> StatsdescmultivariateBuffer {
  let result = stats_desc_multivariate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_multivariate_buffer_add(a : StatsdescmultivariateBuffer, b : StatsdescmultivariateBuffer) -> StatsdescmultivariateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_multivariate_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_multivariate_buffer_copy(s : StatsdescmultivariateBuffer) -> StatsdescmultivariateBuffer {
  let result = stats_desc_multivariate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_multivariate_buffer_fill(s : StatsdescmultivariateBuffer, v : Double) -> StatsdescmultivariateBuffer {
  let result = stats_desc_multivariate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_buffer_min(s : StatsdescmultivariateBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_buffer_max(s : StatsdescmultivariateBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_buffer_to_string(s : StatsdescmultivariateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_cursor_make(size : Int) -> StatsdescmultivariateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_cursor_len(s : StatsdescmultivariateCursor) -> Int { s.size }

pub fn stats_desc_multivariate_cursor_get(s : StatsdescmultivariateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_cursor_set(s : StatsdescmultivariateCursor, i : Int, v : Double) -> StatsdescmultivariateCursor {
  let result = stats_desc_multivariate_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_cursor_sum(s : StatsdescmultivariateCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_multivariate_cursor_mean(s : StatsdescmultivariateCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_multivariate_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_desc_multivariate_cursor_scale(s : StatsdescmultivariateCursor, f : Double) -> StatsdescmultivariateCursor {
  let result = stats_desc_multivariate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_multivariate_cursor_add(a : StatsdescmultivariateCursor, b : StatsdescmultivariateCursor) -> StatsdescmultivariateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_multivariate_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_multivariate_cursor_copy(s : StatsdescmultivariateCursor) -> StatsdescmultivariateCursor {
  let result = stats_desc_multivariate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_multivariate_cursor_fill(s : StatsdescmultivariateCursor, v : Double) -> StatsdescmultivariateCursor {
  let result = stats_desc_multivariate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_cursor_min(s : StatsdescmultivariateCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_cursor_max(s : StatsdescmultivariateCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_cursor_to_string(s : StatsdescmultivariateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_view_make(size : Int) -> StatsdescmultivariateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_view_len(s : StatsdescmultivariateView) -> Int { s.size }

pub fn stats_desc_multivariate_view_get(s : StatsdescmultivariateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_view_set(s : StatsdescmultivariateView, i : Int, v : Double) -> StatsdescmultivariateView {
  let result = stats_desc_multivariate_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_view_sum(s : StatsdescmultivariateView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_multivariate_view_mean(s : StatsdescmultivariateView) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_multivariate_view_sum(s) / s.size.to_double() }
}

pub fn stats_desc_multivariate_view_scale(s : StatsdescmultivariateView, f : Double) -> StatsdescmultivariateView {
  let result = stats_desc_multivariate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_multivariate_view_add(a : StatsdescmultivariateView, b : StatsdescmultivariateView) -> StatsdescmultivariateView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_multivariate_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_multivariate_view_copy(s : StatsdescmultivariateView) -> StatsdescmultivariateView {
  let result = stats_desc_multivariate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_multivariate_view_fill(s : StatsdescmultivariateView, v : Double) -> StatsdescmultivariateView {
  let result = stats_desc_multivariate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_view_min(s : StatsdescmultivariateView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_view_max(s : StatsdescmultivariateView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_view_to_string(s : StatsdescmultivariateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_range_make(size : Int) -> StatsdescmultivariateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_range_len(s : StatsdescmultivariateRange) -> Int { s.size }

pub fn stats_desc_multivariate_range_get(s : StatsdescmultivariateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_range_set(s : StatsdescmultivariateRange, i : Int, v : Double) -> StatsdescmultivariateRange {
  let result = stats_desc_multivariate_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_range_sum(s : StatsdescmultivariateRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_multivariate_range_mean(s : StatsdescmultivariateRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_multivariate_range_sum(s) / s.size.to_double() }
}

pub fn stats_desc_multivariate_range_scale(s : StatsdescmultivariateRange, f : Double) -> StatsdescmultivariateRange {
  let result = stats_desc_multivariate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_multivariate_range_add(a : StatsdescmultivariateRange, b : StatsdescmultivariateRange) -> StatsdescmultivariateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_multivariate_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_multivariate_range_copy(s : StatsdescmultivariateRange) -> StatsdescmultivariateRange {
  let result = stats_desc_multivariate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_multivariate_range_fill(s : StatsdescmultivariateRange, v : Double) -> StatsdescmultivariateRange {
  let result = stats_desc_multivariate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_range_min(s : StatsdescmultivariateRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_range_max(s : StatsdescmultivariateRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_range_to_string(s : StatsdescmultivariateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescmultivariateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_multivariate_slice_make(size : Int) -> StatsdescmultivariateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_multivariate_slice_len(s : StatsdescmultivariateSlice) -> Int { s.size }

pub fn stats_desc_multivariate_slice_get(s : StatsdescmultivariateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_multivariate_slice_set(s : StatsdescmultivariateSlice, i : Int, v : Double) -> StatsdescmultivariateSlice {
  let result = stats_desc_multivariate_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_slice_sum(s : StatsdescmultivariateSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_multivariate_slice_mean(s : StatsdescmultivariateSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_multivariate_slice_sum(s) / s.size.to_double() }
}

pub fn stats_desc_multivariate_slice_scale(s : StatsdescmultivariateSlice, f : Double) -> StatsdescmultivariateSlice {
  let result = stats_desc_multivariate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_multivariate_slice_add(a : StatsdescmultivariateSlice, b : StatsdescmultivariateSlice) -> StatsdescmultivariateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_multivariate_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_multivariate_slice_copy(s : StatsdescmultivariateSlice) -> StatsdescmultivariateSlice {
  let result = stats_desc_multivariate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_multivariate_slice_fill(s : StatsdescmultivariateSlice, v : Double) -> StatsdescmultivariateSlice {
  let result = stats_desc_multivariate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_multivariate_slice_min(s : StatsdescmultivariateSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_slice_max(s : StatsdescmultivariateSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_multivariate_slice_to_string(s : StatsdescmultivariateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

