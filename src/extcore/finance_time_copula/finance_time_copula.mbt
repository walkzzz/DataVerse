///===
/// extcore/finance_time_copula

pub(all) struct FinancetimecopulaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_copula_make_point(x : Double, y : Double) -> FinancetimecopulaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_copula_make_point3(x : Double, y : Double, z : Double) -> FinancetimecopulaPoint {
  { x, y, z, label: 0 }
}

pub fn finance_time_copula_point_x(pt : FinancetimecopulaPoint) -> Double { pt.x }

pub fn finance_time_copula_point_y(pt : FinancetimecopulaPoint) -> Double { pt.y }

pub fn finance_time_copula_point_z(pt : FinancetimecopulaPoint) -> Double { pt.z }

pub fn finance_time_copula_point_label(pt : FinancetimecopulaPoint) -> Int { pt.label }

pub fn finance_time_copula_point_dist(a : FinancetimecopulaPoint, b : FinancetimecopulaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_time_copula_point_add(a : FinancetimecopulaPoint, b : FinancetimecopulaPoint) -> FinancetimecopulaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_time_copula_point_sub(a : FinancetimecopulaPoint, b : FinancetimecopulaPoint) -> FinancetimecopulaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_time_copula_point_scale(pt : FinancetimecopulaPoint, s : Double) -> FinancetimecopulaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_time_copula_point_dot(a : FinancetimecopulaPoint, b : FinancetimecopulaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_time_copula_point_cross(a : FinancetimecopulaPoint, b : FinancetimecopulaPoint) -> FinancetimecopulaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_time_copula_point_norm(pt : FinancetimecopulaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_time_copula_point_normalize(pt : FinancetimecopulaPoint) -> FinancetimecopulaPoint {
  let n = finance_time_copula_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_time_copula_point_scale(pt, 1.0 / n) }
}

pub fn finance_time_copula_point_negate(pt : FinancetimecopulaPoint) -> FinancetimecopulaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_time_copula_point_mid(a : FinancetimecopulaPoint, b : FinancetimecopulaPoint) -> FinancetimecopulaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_time_copula_point_lerp(a : FinancetimecopulaPoint, b : FinancetimecopulaPoint, t : Double) -> FinancetimecopulaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_time_copula_point_to_string(pt : FinancetimecopulaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancetimecopulaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_copula_make_series(vals : Array[Double], name : String) -> FinancetimecopulaSeries {
  { vals, name, meta: 0 }
}

pub fn finance_time_copula_series_len(s : FinancetimecopulaSeries) -> Int { s.vals.length() }

pub fn finance_time_copula_series_sum(s : FinancetimecopulaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_time_copula_series_mean(s : FinancetimecopulaSeries) -> Double { @_common.mean(s.vals) }

pub fn finance_time_copula_series_min(s : FinancetimecopulaSeries) -> Double { @_common.min(s.vals) }

pub fn finance_time_copula_series_max(s : FinancetimecopulaSeries) -> Double { @_common.max(s.vals) }

pub fn finance_time_copula_series_range(s : FinancetimecopulaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn finance_time_copula_series_var(s : FinancetimecopulaSeries) -> Double { @_common.variance(s.vals) }

pub fn finance_time_copula_series_std(s : FinancetimecopulaSeries) -> Double { @_common.std(s.vals) }

pub fn finance_time_copula_series_median(s : FinancetimecopulaSeries) -> Double { @_common.median(s.vals) }

pub fn finance_time_copula_series_scale(s : FinancetimecopulaSeries, f : Double) -> FinancetimecopulaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_time_copula_series_add(a : FinancetimecopulaSeries, b : FinancetimecopulaSeries) -> FinancetimecopulaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_time_copula_series_sub(a : FinancetimecopulaSeries, b : FinancetimecopulaSeries) -> FinancetimecopulaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_time_copula_series_normalize(s : FinancetimecopulaSeries) -> FinancetimecopulaSeries {
  let mn = finance_time_copula_series_min(s)
  let mx = finance_time_copula_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_time_copula_series_cumsum(s : FinancetimecopulaSeries) -> FinancetimecopulaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_time_copula_series_to_string(s : FinancetimecopulaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimecopulaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_copula_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimecopulaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_copula_matrix_identity(n : Int) -> FinancetimecopulaMatrix {
  let m = finance_time_copula_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_time_copula_matrix_get(m : FinancetimecopulaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_time_copula_matrix_transpose(m : FinancetimecopulaMatrix) -> FinancetimecopulaMatrix {
  let result = finance_time_copula_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_time_copula_matrix_add(a : FinancetimecopulaMatrix, b : FinancetimecopulaMatrix) -> FinancetimecopulaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_time_copula_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_time_copula_matrix_scale(m : FinancetimecopulaMatrix, s : Double) -> FinancetimecopulaMatrix {
  let result = finance_time_copula_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_time_copula_matrix_multiply(a : FinancetimecopulaMatrix, b : FinancetimecopulaMatrix) -> FinancetimecopulaMatrix {
  if a.cols != b.rows { return finance_time_copula_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_time_copula_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_time_copula_matrix_trace(m : FinancetimecopulaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_time_copula_matrix_det(m : FinancetimecopulaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_time_copula_matrix_norm(m : FinancetimecopulaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_time_copula_matrix_to_string(m : FinancetimecopulaMatrix) -> String {
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

pub(all) struct FinancetimecopulaVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_copula_make_vector(comps : Array[Double]) -> FinancetimecopulaVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_copula_vector_zero(dim : Int) -> FinancetimecopulaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_time_copula_vector_add(a : FinancetimecopulaVector, b : FinancetimecopulaVector) -> FinancetimecopulaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_copula_vector_sub(a : FinancetimecopulaVector, b : FinancetimecopulaVector) -> FinancetimecopulaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_copula_vector_scale(v : FinancetimecopulaVector, s : Double) -> FinancetimecopulaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_time_copula_vector_dot(a : FinancetimecopulaVector, b : FinancetimecopulaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_time_copula_vector_norm(v : FinancetimecopulaVector) -> Double { @_common.sqrt(finance_time_copula_vector_dot(v, v)) }

pub fn finance_time_copula_vector_normalize(v : FinancetimecopulaVector) -> FinancetimecopulaVector {
  let n = finance_time_copula_vector_norm(v)
  if n < 0.0000001 { v } else { finance_time_copula_vector_scale(v, 1.0 / n) }
}

pub fn finance_time_copula_vector_dist(a : FinancetimecopulaVector, b : FinancetimecopulaVector) -> Double {
  finance_time_copula_vector_norm(finance_time_copula_vector_sub(a, b))
}

pub fn finance_time_copula_vector_to_string(v : FinancetimecopulaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_copula_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_time_copula_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_time_copula_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_time_copula_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_time_copula_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_time_copula_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_time_copula_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_time_copula_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_time_copula_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_time_copula_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_time_copula_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_time_copula_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_time_copula_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_time_copula_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_time_copula_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_time_copula_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_time_copula_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_time_copula_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_time_copula_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_time_copula_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_time_copula_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_time_copula_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_time_copula_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_time_copula_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_time_copula_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_time_copula_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_time_copula_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_time_copula_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_time_copula_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancetimecopulaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_frame_make(size : Int) -> FinancetimecopulaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_frame_len(s : FinancetimecopulaFrame) -> Int { s.size }

pub fn finance_time_copula_frame_get(s : FinancetimecopulaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_frame_set(s : FinancetimecopulaFrame, i : Int, v : Double) -> FinancetimecopulaFrame {
  let result = finance_time_copula_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_frame_sum(s : FinancetimecopulaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_frame_mean(s : FinancetimecopulaFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_frame_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_frame_scale(s : FinancetimecopulaFrame, f : Double) -> FinancetimecopulaFrame {
  let result = finance_time_copula_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_frame_add(a : FinancetimecopulaFrame, b : FinancetimecopulaFrame) -> FinancetimecopulaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_frame_copy(s : FinancetimecopulaFrame) -> FinancetimecopulaFrame {
  let result = finance_time_copula_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_frame_fill(s : FinancetimecopulaFrame, v : Double) -> FinancetimecopulaFrame {
  let result = finance_time_copula_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_frame_min(s : FinancetimecopulaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_frame_max(s : FinancetimecopulaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_frame_to_string(s : FinancetimecopulaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_table_make(size : Int) -> FinancetimecopulaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_table_len(s : FinancetimecopulaTable) -> Int { s.size }

pub fn finance_time_copula_table_get(s : FinancetimecopulaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_table_set(s : FinancetimecopulaTable, i : Int, v : Double) -> FinancetimecopulaTable {
  let result = finance_time_copula_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_table_sum(s : FinancetimecopulaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_table_mean(s : FinancetimecopulaTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_table_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_table_scale(s : FinancetimecopulaTable, f : Double) -> FinancetimecopulaTable {
  let result = finance_time_copula_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_table_add(a : FinancetimecopulaTable, b : FinancetimecopulaTable) -> FinancetimecopulaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_table_copy(s : FinancetimecopulaTable) -> FinancetimecopulaTable {
  let result = finance_time_copula_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_table_fill(s : FinancetimecopulaTable, v : Double) -> FinancetimecopulaTable {
  let result = finance_time_copula_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_table_min(s : FinancetimecopulaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_table_max(s : FinancetimecopulaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_table_to_string(s : FinancetimecopulaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_graphn_make(size : Int) -> FinancetimecopulaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_graphn_len(s : FinancetimecopulaGraphN) -> Int { s.size }

pub fn finance_time_copula_graphn_get(s : FinancetimecopulaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_graphn_set(s : FinancetimecopulaGraphN, i : Int, v : Double) -> FinancetimecopulaGraphN {
  let result = finance_time_copula_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_graphn_sum(s : FinancetimecopulaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_graphn_mean(s : FinancetimecopulaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_graphn_scale(s : FinancetimecopulaGraphN, f : Double) -> FinancetimecopulaGraphN {
  let result = finance_time_copula_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_graphn_add(a : FinancetimecopulaGraphN, b : FinancetimecopulaGraphN) -> FinancetimecopulaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_graphn_copy(s : FinancetimecopulaGraphN) -> FinancetimecopulaGraphN {
  let result = finance_time_copula_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_graphn_fill(s : FinancetimecopulaGraphN, v : Double) -> FinancetimecopulaGraphN {
  let result = finance_time_copula_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_graphn_min(s : FinancetimecopulaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_graphn_max(s : FinancetimecopulaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_graphn_to_string(s : FinancetimecopulaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_node_make(size : Int) -> FinancetimecopulaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_node_len(s : FinancetimecopulaNode) -> Int { s.size }

pub fn finance_time_copula_node_get(s : FinancetimecopulaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_node_set(s : FinancetimecopulaNode, i : Int, v : Double) -> FinancetimecopulaNode {
  let result = finance_time_copula_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_node_sum(s : FinancetimecopulaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_node_mean(s : FinancetimecopulaNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_node_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_node_scale(s : FinancetimecopulaNode, f : Double) -> FinancetimecopulaNode {
  let result = finance_time_copula_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_node_add(a : FinancetimecopulaNode, b : FinancetimecopulaNode) -> FinancetimecopulaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_node_copy(s : FinancetimecopulaNode) -> FinancetimecopulaNode {
  let result = finance_time_copula_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_node_fill(s : FinancetimecopulaNode, v : Double) -> FinancetimecopulaNode {
  let result = finance_time_copula_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_node_min(s : FinancetimecopulaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_node_max(s : FinancetimecopulaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_node_to_string(s : FinancetimecopulaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_edge_make(size : Int) -> FinancetimecopulaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_edge_len(s : FinancetimecopulaEdge) -> Int { s.size }

pub fn finance_time_copula_edge_get(s : FinancetimecopulaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_edge_set(s : FinancetimecopulaEdge, i : Int, v : Double) -> FinancetimecopulaEdge {
  let result = finance_time_copula_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_edge_sum(s : FinancetimecopulaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_edge_mean(s : FinancetimecopulaEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_edge_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_edge_scale(s : FinancetimecopulaEdge, f : Double) -> FinancetimecopulaEdge {
  let result = finance_time_copula_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_edge_add(a : FinancetimecopulaEdge, b : FinancetimecopulaEdge) -> FinancetimecopulaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_edge_copy(s : FinancetimecopulaEdge) -> FinancetimecopulaEdge {
  let result = finance_time_copula_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_edge_fill(s : FinancetimecopulaEdge, v : Double) -> FinancetimecopulaEdge {
  let result = finance_time_copula_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_edge_min(s : FinancetimecopulaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_edge_max(s : FinancetimecopulaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_edge_to_string(s : FinancetimecopulaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_path_make(size : Int) -> FinancetimecopulaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_path_len(s : FinancetimecopulaPath) -> Int { s.size }

pub fn finance_time_copula_path_get(s : FinancetimecopulaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_path_set(s : FinancetimecopulaPath, i : Int, v : Double) -> FinancetimecopulaPath {
  let result = finance_time_copula_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_path_sum(s : FinancetimecopulaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_path_mean(s : FinancetimecopulaPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_path_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_path_scale(s : FinancetimecopulaPath, f : Double) -> FinancetimecopulaPath {
  let result = finance_time_copula_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_path_add(a : FinancetimecopulaPath, b : FinancetimecopulaPath) -> FinancetimecopulaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_path_copy(s : FinancetimecopulaPath) -> FinancetimecopulaPath {
  let result = finance_time_copula_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_path_fill(s : FinancetimecopulaPath, v : Double) -> FinancetimecopulaPath {
  let result = finance_time_copula_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_path_min(s : FinancetimecopulaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_path_max(s : FinancetimecopulaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_path_to_string(s : FinancetimecopulaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_cluster_make(size : Int) -> FinancetimecopulaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_cluster_len(s : FinancetimecopulaCluster) -> Int { s.size }

pub fn finance_time_copula_cluster_get(s : FinancetimecopulaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_cluster_set(s : FinancetimecopulaCluster, i : Int, v : Double) -> FinancetimecopulaCluster {
  let result = finance_time_copula_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_cluster_sum(s : FinancetimecopulaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_cluster_mean(s : FinancetimecopulaCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_cluster_scale(s : FinancetimecopulaCluster, f : Double) -> FinancetimecopulaCluster {
  let result = finance_time_copula_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_cluster_add(a : FinancetimecopulaCluster, b : FinancetimecopulaCluster) -> FinancetimecopulaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_cluster_copy(s : FinancetimecopulaCluster) -> FinancetimecopulaCluster {
  let result = finance_time_copula_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_cluster_fill(s : FinancetimecopulaCluster, v : Double) -> FinancetimecopulaCluster {
  let result = finance_time_copula_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_cluster_min(s : FinancetimecopulaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_cluster_max(s : FinancetimecopulaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_cluster_to_string(s : FinancetimecopulaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_model_make(size : Int) -> FinancetimecopulaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_model_len(s : FinancetimecopulaModel) -> Int { s.size }

pub fn finance_time_copula_model_get(s : FinancetimecopulaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_model_set(s : FinancetimecopulaModel, i : Int, v : Double) -> FinancetimecopulaModel {
  let result = finance_time_copula_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_model_sum(s : FinancetimecopulaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_model_mean(s : FinancetimecopulaModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_model_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_model_scale(s : FinancetimecopulaModel, f : Double) -> FinancetimecopulaModel {
  let result = finance_time_copula_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_model_add(a : FinancetimecopulaModel, b : FinancetimecopulaModel) -> FinancetimecopulaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_model_copy(s : FinancetimecopulaModel) -> FinancetimecopulaModel {
  let result = finance_time_copula_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_model_fill(s : FinancetimecopulaModel, v : Double) -> FinancetimecopulaModel {
  let result = finance_time_copula_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_model_min(s : FinancetimecopulaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_model_max(s : FinancetimecopulaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_model_to_string(s : FinancetimecopulaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_layer_make(size : Int) -> FinancetimecopulaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_layer_len(s : FinancetimecopulaLayer) -> Int { s.size }

pub fn finance_time_copula_layer_get(s : FinancetimecopulaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_layer_set(s : FinancetimecopulaLayer, i : Int, v : Double) -> FinancetimecopulaLayer {
  let result = finance_time_copula_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_layer_sum(s : FinancetimecopulaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_layer_mean(s : FinancetimecopulaLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_layer_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_layer_scale(s : FinancetimecopulaLayer, f : Double) -> FinancetimecopulaLayer {
  let result = finance_time_copula_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_layer_add(a : FinancetimecopulaLayer, b : FinancetimecopulaLayer) -> FinancetimecopulaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_layer_copy(s : FinancetimecopulaLayer) -> FinancetimecopulaLayer {
  let result = finance_time_copula_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_layer_fill(s : FinancetimecopulaLayer, v : Double) -> FinancetimecopulaLayer {
  let result = finance_time_copula_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_layer_min(s : FinancetimecopulaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_layer_max(s : FinancetimecopulaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_layer_to_string(s : FinancetimecopulaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_buffer_make(size : Int) -> FinancetimecopulaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_buffer_len(s : FinancetimecopulaBuffer) -> Int { s.size }

pub fn finance_time_copula_buffer_get(s : FinancetimecopulaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_buffer_set(s : FinancetimecopulaBuffer, i : Int, v : Double) -> FinancetimecopulaBuffer {
  let result = finance_time_copula_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_buffer_sum(s : FinancetimecopulaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_buffer_mean(s : FinancetimecopulaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_buffer_scale(s : FinancetimecopulaBuffer, f : Double) -> FinancetimecopulaBuffer {
  let result = finance_time_copula_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_buffer_add(a : FinancetimecopulaBuffer, b : FinancetimecopulaBuffer) -> FinancetimecopulaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_buffer_copy(s : FinancetimecopulaBuffer) -> FinancetimecopulaBuffer {
  let result = finance_time_copula_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_buffer_fill(s : FinancetimecopulaBuffer, v : Double) -> FinancetimecopulaBuffer {
  let result = finance_time_copula_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_buffer_min(s : FinancetimecopulaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_buffer_max(s : FinancetimecopulaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_buffer_to_string(s : FinancetimecopulaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_cursor_make(size : Int) -> FinancetimecopulaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_cursor_len(s : FinancetimecopulaCursor) -> Int { s.size }

pub fn finance_time_copula_cursor_get(s : FinancetimecopulaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_cursor_set(s : FinancetimecopulaCursor, i : Int, v : Double) -> FinancetimecopulaCursor {
  let result = finance_time_copula_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_cursor_sum(s : FinancetimecopulaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_cursor_mean(s : FinancetimecopulaCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_cursor_scale(s : FinancetimecopulaCursor, f : Double) -> FinancetimecopulaCursor {
  let result = finance_time_copula_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_cursor_add(a : FinancetimecopulaCursor, b : FinancetimecopulaCursor) -> FinancetimecopulaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_cursor_copy(s : FinancetimecopulaCursor) -> FinancetimecopulaCursor {
  let result = finance_time_copula_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_cursor_fill(s : FinancetimecopulaCursor, v : Double) -> FinancetimecopulaCursor {
  let result = finance_time_copula_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_cursor_min(s : FinancetimecopulaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_cursor_max(s : FinancetimecopulaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_cursor_to_string(s : FinancetimecopulaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_view_make(size : Int) -> FinancetimecopulaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_view_len(s : FinancetimecopulaView) -> Int { s.size }

pub fn finance_time_copula_view_get(s : FinancetimecopulaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_view_set(s : FinancetimecopulaView, i : Int, v : Double) -> FinancetimecopulaView {
  let result = finance_time_copula_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_view_sum(s : FinancetimecopulaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_view_mean(s : FinancetimecopulaView) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_view_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_view_scale(s : FinancetimecopulaView, f : Double) -> FinancetimecopulaView {
  let result = finance_time_copula_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_view_add(a : FinancetimecopulaView, b : FinancetimecopulaView) -> FinancetimecopulaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_view_copy(s : FinancetimecopulaView) -> FinancetimecopulaView {
  let result = finance_time_copula_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_view_fill(s : FinancetimecopulaView, v : Double) -> FinancetimecopulaView {
  let result = finance_time_copula_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_view_min(s : FinancetimecopulaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_view_max(s : FinancetimecopulaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_view_to_string(s : FinancetimecopulaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_range_make(size : Int) -> FinancetimecopulaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_range_len(s : FinancetimecopulaRange) -> Int { s.size }

pub fn finance_time_copula_range_get(s : FinancetimecopulaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_range_set(s : FinancetimecopulaRange, i : Int, v : Double) -> FinancetimecopulaRange {
  let result = finance_time_copula_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_range_sum(s : FinancetimecopulaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_range_mean(s : FinancetimecopulaRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_range_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_range_scale(s : FinancetimecopulaRange, f : Double) -> FinancetimecopulaRange {
  let result = finance_time_copula_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_range_add(a : FinancetimecopulaRange, b : FinancetimecopulaRange) -> FinancetimecopulaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_range_copy(s : FinancetimecopulaRange) -> FinancetimecopulaRange {
  let result = finance_time_copula_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_range_fill(s : FinancetimecopulaRange, v : Double) -> FinancetimecopulaRange {
  let result = finance_time_copula_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_range_min(s : FinancetimecopulaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_range_max(s : FinancetimecopulaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_range_to_string(s : FinancetimecopulaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecopulaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_copula_slice_make(size : Int) -> FinancetimecopulaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_copula_slice_len(s : FinancetimecopulaSlice) -> Int { s.size }

pub fn finance_time_copula_slice_get(s : FinancetimecopulaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_copula_slice_set(s : FinancetimecopulaSlice, i : Int, v : Double) -> FinancetimecopulaSlice {
  let result = finance_time_copula_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_slice_sum(s : FinancetimecopulaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_copula_slice_mean(s : FinancetimecopulaSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_copula_slice_sum(s) / s.size.to_double() }
}

pub fn finance_time_copula_slice_scale(s : FinancetimecopulaSlice, f : Double) -> FinancetimecopulaSlice {
  let result = finance_time_copula_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_copula_slice_add(a : FinancetimecopulaSlice, b : FinancetimecopulaSlice) -> FinancetimecopulaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_copula_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_copula_slice_copy(s : FinancetimecopulaSlice) -> FinancetimecopulaSlice {
  let result = finance_time_copula_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_copula_slice_fill(s : FinancetimecopulaSlice, v : Double) -> FinancetimecopulaSlice {
  let result = finance_time_copula_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_copula_slice_min(s : FinancetimecopulaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_slice_max(s : FinancetimecopulaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_copula_slice_to_string(s : FinancetimecopulaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

