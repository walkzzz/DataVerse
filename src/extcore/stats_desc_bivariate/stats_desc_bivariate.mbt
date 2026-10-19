///===
/// extcore/stats_desc_bivariate

pub(all) struct StatsdescbivariatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_desc_bivariate_make_point(x : Double, y : Double) -> StatsdescbivariatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_desc_bivariate_make_point3(x : Double, y : Double, z : Double) -> StatsdescbivariatePoint {
  { x, y, z, label: 0 }
}

pub fn stats_desc_bivariate_point_x(pt : StatsdescbivariatePoint) -> Double { pt.x }

pub fn stats_desc_bivariate_point_y(pt : StatsdescbivariatePoint) -> Double { pt.y }

pub fn stats_desc_bivariate_point_z(pt : StatsdescbivariatePoint) -> Double { pt.z }

pub fn stats_desc_bivariate_point_label(pt : StatsdescbivariatePoint) -> Int { pt.label }

pub fn stats_desc_bivariate_point_dist(a : StatsdescbivariatePoint, b : StatsdescbivariatePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn stats_desc_bivariate_point_add(a : StatsdescbivariatePoint, b : StatsdescbivariatePoint) -> StatsdescbivariatePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn stats_desc_bivariate_point_sub(a : StatsdescbivariatePoint, b : StatsdescbivariatePoint) -> StatsdescbivariatePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn stats_desc_bivariate_point_scale(pt : StatsdescbivariatePoint, s : Double) -> StatsdescbivariatePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn stats_desc_bivariate_point_dot(a : StatsdescbivariatePoint, b : StatsdescbivariatePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn stats_desc_bivariate_point_cross(a : StatsdescbivariatePoint, b : StatsdescbivariatePoint) -> StatsdescbivariatePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn stats_desc_bivariate_point_norm(pt : StatsdescbivariatePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn stats_desc_bivariate_point_normalize(pt : StatsdescbivariatePoint) -> StatsdescbivariatePoint {
  let n = stats_desc_bivariate_point_norm(pt)
  if n < 0.0000001 { pt } else { stats_desc_bivariate_point_scale(pt, 1.0 / n) }
}

pub fn stats_desc_bivariate_point_negate(pt : StatsdescbivariatePoint) -> StatsdescbivariatePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn stats_desc_bivariate_point_mid(a : StatsdescbivariatePoint, b : StatsdescbivariatePoint) -> StatsdescbivariatePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn stats_desc_bivariate_point_lerp(a : StatsdescbivariatePoint, b : StatsdescbivariatePoint, t : Double) -> StatsdescbivariatePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn stats_desc_bivariate_point_to_string(pt : StatsdescbivariatePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct StatsdescbivariateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_desc_bivariate_make_series(vals : Array[Double], name : String) -> StatsdescbivariateSeries {
  { vals, name, meta: 0 }
}

pub fn stats_desc_bivariate_series_len(s : StatsdescbivariateSeries) -> Int { s.vals.length() }

pub fn stats_desc_bivariate_series_sum(s : StatsdescbivariateSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn stats_desc_bivariate_series_mean(s : StatsdescbivariateSeries) -> Double {
  let n = stats_desc_bivariate_series_len(s)
  if n == 0 { 0.0 } else { stats_desc_bivariate_series_sum(s) / n.to_double() }
}

pub fn stats_desc_bivariate_series_min(s : StatsdescbivariateSeries) -> Double {
  let n = stats_desc_bivariate_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn stats_desc_bivariate_series_max(s : StatsdescbivariateSeries) -> Double {
  let n = stats_desc_bivariate_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn stats_desc_bivariate_series_range(s : StatsdescbivariateSeries) -> Double {
  stats_desc_bivariate_series_max(s) - stats_desc_bivariate_series_min(s)
}

pub fn stats_desc_bivariate_series_var(s : StatsdescbivariateSeries) -> Double {
  let n = stats_desc_bivariate_series_len(s)
  if n == 0 { 0.0 } else {
    let m = stats_desc_bivariate_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn stats_desc_bivariate_series_std(s : StatsdescbivariateSeries) -> Double { @_common.sqrt(stats_desc_bivariate_series_var(s)) }

pub fn stats_desc_bivariate_series_median(s : StatsdescbivariateSeries) -> Double {
  let n = stats_desc_bivariate_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = stats_desc_bivariate_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn stats_desc_bivariate_series_scale(s : StatsdescbivariateSeries, f : Double) -> StatsdescbivariateSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn stats_desc_bivariate_series_add(a : StatsdescbivariateSeries, b : StatsdescbivariateSeries) -> StatsdescbivariateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn stats_desc_bivariate_series_sub(a : StatsdescbivariateSeries, b : StatsdescbivariateSeries) -> StatsdescbivariateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn stats_desc_bivariate_series_normalize(s : StatsdescbivariateSeries) -> StatsdescbivariateSeries {
  let mn = stats_desc_bivariate_series_min(s)
  let mx = stats_desc_bivariate_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn stats_desc_bivariate_series_cumsum(s : StatsdescbivariateSeries) -> StatsdescbivariateSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn stats_desc_bivariate_series_to_string(s : StatsdescbivariateSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsdescbivariateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_desc_bivariate_make_matrix(rows : Int, cols : Int, val : Double) -> StatsdescbivariateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_desc_bivariate_matrix_identity(n : Int) -> StatsdescbivariateMatrix {
  let m = stats_desc_bivariate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn stats_desc_bivariate_matrix_get(m : StatsdescbivariateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn stats_desc_bivariate_matrix_transpose(m : StatsdescbivariateMatrix) -> StatsdescbivariateMatrix {
  let result = stats_desc_bivariate_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn stats_desc_bivariate_matrix_add(a : StatsdescbivariateMatrix, b : StatsdescbivariateMatrix) -> StatsdescbivariateMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = stats_desc_bivariate_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn stats_desc_bivariate_matrix_scale(m : StatsdescbivariateMatrix, s : Double) -> StatsdescbivariateMatrix {
  let result = stats_desc_bivariate_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn stats_desc_bivariate_matrix_multiply(a : StatsdescbivariateMatrix, b : StatsdescbivariateMatrix) -> StatsdescbivariateMatrix {
  if a.cols != b.rows { return stats_desc_bivariate_make_matrix(a.rows, b.cols, 0.0) }
  let result = stats_desc_bivariate_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn stats_desc_bivariate_matrix_trace(m : StatsdescbivariateMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn stats_desc_bivariate_matrix_det(m : StatsdescbivariateMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn stats_desc_bivariate_matrix_norm(m : StatsdescbivariateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn stats_desc_bivariate_matrix_to_string(m : StatsdescbivariateMatrix) -> String {
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

pub(all) struct StatsdescbivariateVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_desc_bivariate_make_vector(comps : Array[Double]) -> StatsdescbivariateVector {
  { comps, dim: comps.length() }
}

pub fn stats_desc_bivariate_vector_zero(dim : Int) -> StatsdescbivariateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn stats_desc_bivariate_vector_add(a : StatsdescbivariateVector, b : StatsdescbivariateVector) -> StatsdescbivariateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_desc_bivariate_vector_sub(a : StatsdescbivariateVector, b : StatsdescbivariateVector) -> StatsdescbivariateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn stats_desc_bivariate_vector_scale(v : StatsdescbivariateVector, s : Double) -> StatsdescbivariateVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn stats_desc_bivariate_vector_dot(a : StatsdescbivariateVector, b : StatsdescbivariateVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn stats_desc_bivariate_vector_norm(v : StatsdescbivariateVector) -> Double { @_common.sqrt(stats_desc_bivariate_vector_dot(v, v)) }

pub fn stats_desc_bivariate_vector_normalize(v : StatsdescbivariateVector) -> StatsdescbivariateVector {
  let n = stats_desc_bivariate_vector_norm(v)
  if n < 0.0000001 { v } else { stats_desc_bivariate_vector_scale(v, 1.0 / n) }
}

pub fn stats_desc_bivariate_vector_dist(a : StatsdescbivariateVector, b : StatsdescbivariateVector) -> Double {
  stats_desc_bivariate_vector_norm(stats_desc_bivariate_vector_sub(a, b))
}

pub fn stats_desc_bivariate_vector_to_string(v : StatsdescbivariateVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_desc_bivariate_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_desc_bivariate_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_desc_bivariate_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_desc_bivariate_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_desc_bivariate_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_desc_bivariate_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_desc_bivariate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_desc_bivariate_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_desc_bivariate_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_desc_bivariate_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_desc_bivariate_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_desc_bivariate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_desc_bivariate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_desc_bivariate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_desc_bivariate_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_desc_bivariate_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_desc_bivariate_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_desc_bivariate_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_desc_bivariate_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_desc_bivariate_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_desc_bivariate_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_desc_bivariate_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_desc_bivariate_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_desc_bivariate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_desc_bivariate_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_desc_bivariate_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_desc_bivariate_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_desc_bivariate_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_desc_bivariate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsdescbivariateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_frame_make(size : Int) -> StatsdescbivariateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_frame_len(s : StatsdescbivariateFrame) -> Int { s.size }

pub fn stats_desc_bivariate_frame_get(s : StatsdescbivariateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_frame_set(s : StatsdescbivariateFrame, i : Int, v : Double) -> StatsdescbivariateFrame {
  let result = stats_desc_bivariate_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_frame_sum(s : StatsdescbivariateFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_bivariate_frame_mean(s : StatsdescbivariateFrame) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_bivariate_frame_sum(s) / s.size.to_double() }
}

pub fn stats_desc_bivariate_frame_scale(s : StatsdescbivariateFrame, f : Double) -> StatsdescbivariateFrame {
  let result = stats_desc_bivariate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_bivariate_frame_add(a : StatsdescbivariateFrame, b : StatsdescbivariateFrame) -> StatsdescbivariateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_bivariate_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_bivariate_frame_copy(s : StatsdescbivariateFrame) -> StatsdescbivariateFrame {
  let result = stats_desc_bivariate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_bivariate_frame_fill(s : StatsdescbivariateFrame, v : Double) -> StatsdescbivariateFrame {
  let result = stats_desc_bivariate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_frame_min(s : StatsdescbivariateFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_frame_max(s : StatsdescbivariateFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_frame_to_string(s : StatsdescbivariateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_table_make(size : Int) -> StatsdescbivariateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_table_len(s : StatsdescbivariateTable) -> Int { s.size }

pub fn stats_desc_bivariate_table_get(s : StatsdescbivariateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_table_set(s : StatsdescbivariateTable, i : Int, v : Double) -> StatsdescbivariateTable {
  let result = stats_desc_bivariate_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_table_sum(s : StatsdescbivariateTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_bivariate_table_mean(s : StatsdescbivariateTable) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_bivariate_table_sum(s) / s.size.to_double() }
}

pub fn stats_desc_bivariate_table_scale(s : StatsdescbivariateTable, f : Double) -> StatsdescbivariateTable {
  let result = stats_desc_bivariate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_bivariate_table_add(a : StatsdescbivariateTable, b : StatsdescbivariateTable) -> StatsdescbivariateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_bivariate_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_bivariate_table_copy(s : StatsdescbivariateTable) -> StatsdescbivariateTable {
  let result = stats_desc_bivariate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_bivariate_table_fill(s : StatsdescbivariateTable, v : Double) -> StatsdescbivariateTable {
  let result = stats_desc_bivariate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_table_min(s : StatsdescbivariateTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_table_max(s : StatsdescbivariateTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_table_to_string(s : StatsdescbivariateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_graphn_make(size : Int) -> StatsdescbivariateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_graphn_len(s : StatsdescbivariateGraphN) -> Int { s.size }

pub fn stats_desc_bivariate_graphn_get(s : StatsdescbivariateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_graphn_set(s : StatsdescbivariateGraphN, i : Int, v : Double) -> StatsdescbivariateGraphN {
  let result = stats_desc_bivariate_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_graphn_sum(s : StatsdescbivariateGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_bivariate_graphn_mean(s : StatsdescbivariateGraphN) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_bivariate_graphn_sum(s) / s.size.to_double() }
}

pub fn stats_desc_bivariate_graphn_scale(s : StatsdescbivariateGraphN, f : Double) -> StatsdescbivariateGraphN {
  let result = stats_desc_bivariate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_bivariate_graphn_add(a : StatsdescbivariateGraphN, b : StatsdescbivariateGraphN) -> StatsdescbivariateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_bivariate_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_bivariate_graphn_copy(s : StatsdescbivariateGraphN) -> StatsdescbivariateGraphN {
  let result = stats_desc_bivariate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_bivariate_graphn_fill(s : StatsdescbivariateGraphN, v : Double) -> StatsdescbivariateGraphN {
  let result = stats_desc_bivariate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_graphn_min(s : StatsdescbivariateGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_graphn_max(s : StatsdescbivariateGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_graphn_to_string(s : StatsdescbivariateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_node_make(size : Int) -> StatsdescbivariateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_node_len(s : StatsdescbivariateNode) -> Int { s.size }

pub fn stats_desc_bivariate_node_get(s : StatsdescbivariateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_node_set(s : StatsdescbivariateNode, i : Int, v : Double) -> StatsdescbivariateNode {
  let result = stats_desc_bivariate_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_node_sum(s : StatsdescbivariateNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_bivariate_node_mean(s : StatsdescbivariateNode) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_bivariate_node_sum(s) / s.size.to_double() }
}

pub fn stats_desc_bivariate_node_scale(s : StatsdescbivariateNode, f : Double) -> StatsdescbivariateNode {
  let result = stats_desc_bivariate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_bivariate_node_add(a : StatsdescbivariateNode, b : StatsdescbivariateNode) -> StatsdescbivariateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_bivariate_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_bivariate_node_copy(s : StatsdescbivariateNode) -> StatsdescbivariateNode {
  let result = stats_desc_bivariate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_bivariate_node_fill(s : StatsdescbivariateNode, v : Double) -> StatsdescbivariateNode {
  let result = stats_desc_bivariate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_node_min(s : StatsdescbivariateNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_node_max(s : StatsdescbivariateNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_node_to_string(s : StatsdescbivariateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_edge_make(size : Int) -> StatsdescbivariateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_edge_len(s : StatsdescbivariateEdge) -> Int { s.size }

pub fn stats_desc_bivariate_edge_get(s : StatsdescbivariateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_edge_set(s : StatsdescbivariateEdge, i : Int, v : Double) -> StatsdescbivariateEdge {
  let result = stats_desc_bivariate_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_edge_sum(s : StatsdescbivariateEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_bivariate_edge_mean(s : StatsdescbivariateEdge) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_bivariate_edge_sum(s) / s.size.to_double() }
}

pub fn stats_desc_bivariate_edge_scale(s : StatsdescbivariateEdge, f : Double) -> StatsdescbivariateEdge {
  let result = stats_desc_bivariate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_bivariate_edge_add(a : StatsdescbivariateEdge, b : StatsdescbivariateEdge) -> StatsdescbivariateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_bivariate_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_bivariate_edge_copy(s : StatsdescbivariateEdge) -> StatsdescbivariateEdge {
  let result = stats_desc_bivariate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_bivariate_edge_fill(s : StatsdescbivariateEdge, v : Double) -> StatsdescbivariateEdge {
  let result = stats_desc_bivariate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_edge_min(s : StatsdescbivariateEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_edge_max(s : StatsdescbivariateEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_edge_to_string(s : StatsdescbivariateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_path_make(size : Int) -> StatsdescbivariatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_path_len(s : StatsdescbivariatePath) -> Int { s.size }

pub fn stats_desc_bivariate_path_get(s : StatsdescbivariatePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_path_set(s : StatsdescbivariatePath, i : Int, v : Double) -> StatsdescbivariatePath {
  let result = stats_desc_bivariate_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_path_sum(s : StatsdescbivariatePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_bivariate_path_mean(s : StatsdescbivariatePath) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_bivariate_path_sum(s) / s.size.to_double() }
}

pub fn stats_desc_bivariate_path_scale(s : StatsdescbivariatePath, f : Double) -> StatsdescbivariatePath {
  let result = stats_desc_bivariate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_bivariate_path_add(a : StatsdescbivariatePath, b : StatsdescbivariatePath) -> StatsdescbivariatePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_bivariate_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_bivariate_path_copy(s : StatsdescbivariatePath) -> StatsdescbivariatePath {
  let result = stats_desc_bivariate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_bivariate_path_fill(s : StatsdescbivariatePath, v : Double) -> StatsdescbivariatePath {
  let result = stats_desc_bivariate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_path_min(s : StatsdescbivariatePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_path_max(s : StatsdescbivariatePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_path_to_string(s : StatsdescbivariatePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_cluster_make(size : Int) -> StatsdescbivariateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_cluster_len(s : StatsdescbivariateCluster) -> Int { s.size }

pub fn stats_desc_bivariate_cluster_get(s : StatsdescbivariateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_cluster_set(s : StatsdescbivariateCluster, i : Int, v : Double) -> StatsdescbivariateCluster {
  let result = stats_desc_bivariate_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_cluster_sum(s : StatsdescbivariateCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_bivariate_cluster_mean(s : StatsdescbivariateCluster) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_bivariate_cluster_sum(s) / s.size.to_double() }
}

pub fn stats_desc_bivariate_cluster_scale(s : StatsdescbivariateCluster, f : Double) -> StatsdescbivariateCluster {
  let result = stats_desc_bivariate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_bivariate_cluster_add(a : StatsdescbivariateCluster, b : StatsdescbivariateCluster) -> StatsdescbivariateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_bivariate_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_bivariate_cluster_copy(s : StatsdescbivariateCluster) -> StatsdescbivariateCluster {
  let result = stats_desc_bivariate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_bivariate_cluster_fill(s : StatsdescbivariateCluster, v : Double) -> StatsdescbivariateCluster {
  let result = stats_desc_bivariate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_cluster_min(s : StatsdescbivariateCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_cluster_max(s : StatsdescbivariateCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_cluster_to_string(s : StatsdescbivariateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_model_make(size : Int) -> StatsdescbivariateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_model_len(s : StatsdescbivariateModel) -> Int { s.size }

pub fn stats_desc_bivariate_model_get(s : StatsdescbivariateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_model_set(s : StatsdescbivariateModel, i : Int, v : Double) -> StatsdescbivariateModel {
  let result = stats_desc_bivariate_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_model_sum(s : StatsdescbivariateModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_bivariate_model_mean(s : StatsdescbivariateModel) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_bivariate_model_sum(s) / s.size.to_double() }
}

pub fn stats_desc_bivariate_model_scale(s : StatsdescbivariateModel, f : Double) -> StatsdescbivariateModel {
  let result = stats_desc_bivariate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_bivariate_model_add(a : StatsdescbivariateModel, b : StatsdescbivariateModel) -> StatsdescbivariateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_bivariate_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_bivariate_model_copy(s : StatsdescbivariateModel) -> StatsdescbivariateModel {
  let result = stats_desc_bivariate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_bivariate_model_fill(s : StatsdescbivariateModel, v : Double) -> StatsdescbivariateModel {
  let result = stats_desc_bivariate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_model_min(s : StatsdescbivariateModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_model_max(s : StatsdescbivariateModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_model_to_string(s : StatsdescbivariateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_layer_make(size : Int) -> StatsdescbivariateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_layer_len(s : StatsdescbivariateLayer) -> Int { s.size }

pub fn stats_desc_bivariate_layer_get(s : StatsdescbivariateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_layer_set(s : StatsdescbivariateLayer, i : Int, v : Double) -> StatsdescbivariateLayer {
  let result = stats_desc_bivariate_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_layer_sum(s : StatsdescbivariateLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_bivariate_layer_mean(s : StatsdescbivariateLayer) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_bivariate_layer_sum(s) / s.size.to_double() }
}

pub fn stats_desc_bivariate_layer_scale(s : StatsdescbivariateLayer, f : Double) -> StatsdescbivariateLayer {
  let result = stats_desc_bivariate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_bivariate_layer_add(a : StatsdescbivariateLayer, b : StatsdescbivariateLayer) -> StatsdescbivariateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_bivariate_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_bivariate_layer_copy(s : StatsdescbivariateLayer) -> StatsdescbivariateLayer {
  let result = stats_desc_bivariate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_bivariate_layer_fill(s : StatsdescbivariateLayer, v : Double) -> StatsdescbivariateLayer {
  let result = stats_desc_bivariate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_layer_min(s : StatsdescbivariateLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_layer_max(s : StatsdescbivariateLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_layer_to_string(s : StatsdescbivariateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_buffer_make(size : Int) -> StatsdescbivariateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_buffer_len(s : StatsdescbivariateBuffer) -> Int { s.size }

pub fn stats_desc_bivariate_buffer_get(s : StatsdescbivariateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_buffer_set(s : StatsdescbivariateBuffer, i : Int, v : Double) -> StatsdescbivariateBuffer {
  let result = stats_desc_bivariate_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_buffer_sum(s : StatsdescbivariateBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_bivariate_buffer_mean(s : StatsdescbivariateBuffer) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_bivariate_buffer_sum(s) / s.size.to_double() }
}

pub fn stats_desc_bivariate_buffer_scale(s : StatsdescbivariateBuffer, f : Double) -> StatsdescbivariateBuffer {
  let result = stats_desc_bivariate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_bivariate_buffer_add(a : StatsdescbivariateBuffer, b : StatsdescbivariateBuffer) -> StatsdescbivariateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_bivariate_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_bivariate_buffer_copy(s : StatsdescbivariateBuffer) -> StatsdescbivariateBuffer {
  let result = stats_desc_bivariate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_bivariate_buffer_fill(s : StatsdescbivariateBuffer, v : Double) -> StatsdescbivariateBuffer {
  let result = stats_desc_bivariate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_buffer_min(s : StatsdescbivariateBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_buffer_max(s : StatsdescbivariateBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_buffer_to_string(s : StatsdescbivariateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_cursor_make(size : Int) -> StatsdescbivariateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_cursor_len(s : StatsdescbivariateCursor) -> Int { s.size }

pub fn stats_desc_bivariate_cursor_get(s : StatsdescbivariateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_cursor_set(s : StatsdescbivariateCursor, i : Int, v : Double) -> StatsdescbivariateCursor {
  let result = stats_desc_bivariate_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_cursor_sum(s : StatsdescbivariateCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_bivariate_cursor_mean(s : StatsdescbivariateCursor) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_bivariate_cursor_sum(s) / s.size.to_double() }
}

pub fn stats_desc_bivariate_cursor_scale(s : StatsdescbivariateCursor, f : Double) -> StatsdescbivariateCursor {
  let result = stats_desc_bivariate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_bivariate_cursor_add(a : StatsdescbivariateCursor, b : StatsdescbivariateCursor) -> StatsdescbivariateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_bivariate_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_bivariate_cursor_copy(s : StatsdescbivariateCursor) -> StatsdescbivariateCursor {
  let result = stats_desc_bivariate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_bivariate_cursor_fill(s : StatsdescbivariateCursor, v : Double) -> StatsdescbivariateCursor {
  let result = stats_desc_bivariate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_cursor_min(s : StatsdescbivariateCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_cursor_max(s : StatsdescbivariateCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_cursor_to_string(s : StatsdescbivariateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_view_make(size : Int) -> StatsdescbivariateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_view_len(s : StatsdescbivariateView) -> Int { s.size }

pub fn stats_desc_bivariate_view_get(s : StatsdescbivariateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_view_set(s : StatsdescbivariateView, i : Int, v : Double) -> StatsdescbivariateView {
  let result = stats_desc_bivariate_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_view_sum(s : StatsdescbivariateView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_bivariate_view_mean(s : StatsdescbivariateView) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_bivariate_view_sum(s) / s.size.to_double() }
}

pub fn stats_desc_bivariate_view_scale(s : StatsdescbivariateView, f : Double) -> StatsdescbivariateView {
  let result = stats_desc_bivariate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_bivariate_view_add(a : StatsdescbivariateView, b : StatsdescbivariateView) -> StatsdescbivariateView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_bivariate_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_bivariate_view_copy(s : StatsdescbivariateView) -> StatsdescbivariateView {
  let result = stats_desc_bivariate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_bivariate_view_fill(s : StatsdescbivariateView, v : Double) -> StatsdescbivariateView {
  let result = stats_desc_bivariate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_view_min(s : StatsdescbivariateView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_view_max(s : StatsdescbivariateView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_view_to_string(s : StatsdescbivariateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_range_make(size : Int) -> StatsdescbivariateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_range_len(s : StatsdescbivariateRange) -> Int { s.size }

pub fn stats_desc_bivariate_range_get(s : StatsdescbivariateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_range_set(s : StatsdescbivariateRange, i : Int, v : Double) -> StatsdescbivariateRange {
  let result = stats_desc_bivariate_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_range_sum(s : StatsdescbivariateRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_bivariate_range_mean(s : StatsdescbivariateRange) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_bivariate_range_sum(s) / s.size.to_double() }
}

pub fn stats_desc_bivariate_range_scale(s : StatsdescbivariateRange, f : Double) -> StatsdescbivariateRange {
  let result = stats_desc_bivariate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_bivariate_range_add(a : StatsdescbivariateRange, b : StatsdescbivariateRange) -> StatsdescbivariateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_bivariate_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_bivariate_range_copy(s : StatsdescbivariateRange) -> StatsdescbivariateRange {
  let result = stats_desc_bivariate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_bivariate_range_fill(s : StatsdescbivariateRange, v : Double) -> StatsdescbivariateRange {
  let result = stats_desc_bivariate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_range_min(s : StatsdescbivariateRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_range_max(s : StatsdescbivariateRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_range_to_string(s : StatsdescbivariateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsdescbivariateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_desc_bivariate_slice_make(size : Int) -> StatsdescbivariateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_desc_bivariate_slice_len(s : StatsdescbivariateSlice) -> Int { s.size }

pub fn stats_desc_bivariate_slice_get(s : StatsdescbivariateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_desc_bivariate_slice_set(s : StatsdescbivariateSlice, i : Int, v : Double) -> StatsdescbivariateSlice {
  let result = stats_desc_bivariate_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_slice_sum(s : StatsdescbivariateSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn stats_desc_bivariate_slice_mean(s : StatsdescbivariateSlice) -> Double {
  if s.size == 0 { 0.0 } else { stats_desc_bivariate_slice_sum(s) / s.size.to_double() }
}

pub fn stats_desc_bivariate_slice_scale(s : StatsdescbivariateSlice, f : Double) -> StatsdescbivariateSlice {
  let result = stats_desc_bivariate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn stats_desc_bivariate_slice_add(a : StatsdescbivariateSlice, b : StatsdescbivariateSlice) -> StatsdescbivariateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = stats_desc_bivariate_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn stats_desc_bivariate_slice_copy(s : StatsdescbivariateSlice) -> StatsdescbivariateSlice {
  let result = stats_desc_bivariate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn stats_desc_bivariate_slice_fill(s : StatsdescbivariateSlice, v : Double) -> StatsdescbivariateSlice {
  let result = stats_desc_bivariate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn stats_desc_bivariate_slice_min(s : StatsdescbivariateSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_slice_max(s : StatsdescbivariateSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn stats_desc_bivariate_slice_to_string(s : StatsdescbivariateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

