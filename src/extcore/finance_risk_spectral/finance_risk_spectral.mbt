///===
/// extcore/finance_risk_spectral

pub(all) struct FinanceriskspectralPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_spectral_make_point(x : Double, y : Double) -> FinanceriskspectralPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_spectral_make_point3(x : Double, y : Double, z : Double) -> FinanceriskspectralPoint {
  { x, y, z, label: 0 }
}

pub fn finance_risk_spectral_point_x(pt : FinanceriskspectralPoint) -> Double { pt.x }

pub fn finance_risk_spectral_point_y(pt : FinanceriskspectralPoint) -> Double { pt.y }

pub fn finance_risk_spectral_point_z(pt : FinanceriskspectralPoint) -> Double { pt.z }

pub fn finance_risk_spectral_point_label(pt : FinanceriskspectralPoint) -> Int { pt.label }

pub fn finance_risk_spectral_point_dist(a : FinanceriskspectralPoint, b : FinanceriskspectralPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_risk_spectral_point_add(a : FinanceriskspectralPoint, b : FinanceriskspectralPoint) -> FinanceriskspectralPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_risk_spectral_point_sub(a : FinanceriskspectralPoint, b : FinanceriskspectralPoint) -> FinanceriskspectralPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_risk_spectral_point_scale(pt : FinanceriskspectralPoint, s : Double) -> FinanceriskspectralPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_risk_spectral_point_dot(a : FinanceriskspectralPoint, b : FinanceriskspectralPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_risk_spectral_point_cross(a : FinanceriskspectralPoint, b : FinanceriskspectralPoint) -> FinanceriskspectralPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_risk_spectral_point_norm(pt : FinanceriskspectralPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_risk_spectral_point_normalize(pt : FinanceriskspectralPoint) -> FinanceriskspectralPoint {
  let n = finance_risk_spectral_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_risk_spectral_point_scale(pt, 1.0 / n) }
}

pub fn finance_risk_spectral_point_negate(pt : FinanceriskspectralPoint) -> FinanceriskspectralPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_risk_spectral_point_mid(a : FinanceriskspectralPoint, b : FinanceriskspectralPoint) -> FinanceriskspectralPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_risk_spectral_point_lerp(a : FinanceriskspectralPoint, b : FinanceriskspectralPoint, t : Double) -> FinanceriskspectralPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_risk_spectral_point_to_string(pt : FinanceriskspectralPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceriskspectralSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_spectral_make_series(vals : Array[Double], name : String) -> FinanceriskspectralSeries {
  { vals, name, meta: 0 }
}

pub fn finance_risk_spectral_series_len(s : FinanceriskspectralSeries) -> Int { s.vals.length() }

pub fn finance_risk_spectral_series_sum(s : FinanceriskspectralSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_risk_spectral_series_mean(s : FinanceriskspectralSeries) -> Double { @_common.mean(s.vals) }

pub fn finance_risk_spectral_series_min(s : FinanceriskspectralSeries) -> Double { @_common.min(s.vals) }

pub fn finance_risk_spectral_series_max(s : FinanceriskspectralSeries) -> Double { @_common.max(s.vals) }

pub fn finance_risk_spectral_series_range(s : FinanceriskspectralSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn finance_risk_spectral_series_var(s : FinanceriskspectralSeries) -> Double { @_common.variance(s.vals) }

pub fn finance_risk_spectral_series_std(s : FinanceriskspectralSeries) -> Double { @_common.std(s.vals) }

pub fn finance_risk_spectral_series_median(s : FinanceriskspectralSeries) -> Double { @_common.median(s.vals) }

pub fn finance_risk_spectral_series_scale(s : FinanceriskspectralSeries, f : Double) -> FinanceriskspectralSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_risk_spectral_series_add(a : FinanceriskspectralSeries, b : FinanceriskspectralSeries) -> FinanceriskspectralSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_risk_spectral_series_sub(a : FinanceriskspectralSeries, b : FinanceriskspectralSeries) -> FinanceriskspectralSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_risk_spectral_series_normalize(s : FinanceriskspectralSeries) -> FinanceriskspectralSeries {
  let mn = finance_risk_spectral_series_min(s)
  let mx = finance_risk_spectral_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_risk_spectral_series_cumsum(s : FinanceriskspectralSeries) -> FinanceriskspectralSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_risk_spectral_series_to_string(s : FinanceriskspectralSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskspectralMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_spectral_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskspectralMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_spectral_matrix_identity(n : Int) -> FinanceriskspectralMatrix {
  let m = finance_risk_spectral_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_risk_spectral_matrix_get(m : FinanceriskspectralMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_risk_spectral_matrix_transpose(m : FinanceriskspectralMatrix) -> FinanceriskspectralMatrix {
  let result = finance_risk_spectral_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_risk_spectral_matrix_add(a : FinanceriskspectralMatrix, b : FinanceriskspectralMatrix) -> FinanceriskspectralMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_risk_spectral_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_risk_spectral_matrix_scale(m : FinanceriskspectralMatrix, s : Double) -> FinanceriskspectralMatrix {
  let result = finance_risk_spectral_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_risk_spectral_matrix_multiply(a : FinanceriskspectralMatrix, b : FinanceriskspectralMatrix) -> FinanceriskspectralMatrix {
  if a.cols != b.rows { return finance_risk_spectral_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_risk_spectral_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_risk_spectral_matrix_trace(m : FinanceriskspectralMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_risk_spectral_matrix_det(m : FinanceriskspectralMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_risk_spectral_matrix_norm(m : FinanceriskspectralMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_risk_spectral_matrix_to_string(m : FinanceriskspectralMatrix) -> String {
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

pub(all) struct FinanceriskspectralVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_spectral_make_vector(comps : Array[Double]) -> FinanceriskspectralVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_spectral_vector_zero(dim : Int) -> FinanceriskspectralVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_risk_spectral_vector_add(a : FinanceriskspectralVector, b : FinanceriskspectralVector) -> FinanceriskspectralVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_spectral_vector_sub(a : FinanceriskspectralVector, b : FinanceriskspectralVector) -> FinanceriskspectralVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_spectral_vector_scale(v : FinanceriskspectralVector, s : Double) -> FinanceriskspectralVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_risk_spectral_vector_dot(a : FinanceriskspectralVector, b : FinanceriskspectralVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_risk_spectral_vector_norm(v : FinanceriskspectralVector) -> Double { @_common.sqrt(finance_risk_spectral_vector_dot(v, v)) }

pub fn finance_risk_spectral_vector_normalize(v : FinanceriskspectralVector) -> FinanceriskspectralVector {
  let n = finance_risk_spectral_vector_norm(v)
  if n < 0.0000001 { v } else { finance_risk_spectral_vector_scale(v, 1.0 / n) }
}

pub fn finance_risk_spectral_vector_dist(a : FinanceriskspectralVector, b : FinanceriskspectralVector) -> Double {
  finance_risk_spectral_vector_norm(finance_risk_spectral_vector_sub(a, b))
}

pub fn finance_risk_spectral_vector_to_string(v : FinanceriskspectralVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_spectral_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_risk_spectral_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_risk_spectral_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_risk_spectral_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_risk_spectral_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_risk_spectral_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_risk_spectral_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_risk_spectral_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_risk_spectral_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_risk_spectral_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_risk_spectral_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_risk_spectral_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_risk_spectral_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_risk_spectral_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_risk_spectral_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_risk_spectral_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_risk_spectral_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_risk_spectral_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_risk_spectral_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_risk_spectral_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_risk_spectral_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_risk_spectral_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_risk_spectral_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_risk_spectral_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_risk_spectral_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_risk_spectral_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_risk_spectral_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_risk_spectral_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_risk_spectral_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceriskspectralFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_frame_make(size : Int) -> FinanceriskspectralFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_frame_len(s : FinanceriskspectralFrame) -> Int { s.size }

pub fn finance_risk_spectral_frame_get(s : FinanceriskspectralFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_frame_set(s : FinanceriskspectralFrame, i : Int, v : Double) -> FinanceriskspectralFrame {
  let result = finance_risk_spectral_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_frame_sum(s : FinanceriskspectralFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_frame_mean(s : FinanceriskspectralFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_frame_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_frame_scale(s : FinanceriskspectralFrame, f : Double) -> FinanceriskspectralFrame {
  let result = finance_risk_spectral_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_frame_add(a : FinanceriskspectralFrame, b : FinanceriskspectralFrame) -> FinanceriskspectralFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_frame_copy(s : FinanceriskspectralFrame) -> FinanceriskspectralFrame {
  let result = finance_risk_spectral_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_frame_fill(s : FinanceriskspectralFrame, v : Double) -> FinanceriskspectralFrame {
  let result = finance_risk_spectral_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_frame_min(s : FinanceriskspectralFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_frame_max(s : FinanceriskspectralFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_frame_to_string(s : FinanceriskspectralFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_table_make(size : Int) -> FinanceriskspectralTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_table_len(s : FinanceriskspectralTable) -> Int { s.size }

pub fn finance_risk_spectral_table_get(s : FinanceriskspectralTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_table_set(s : FinanceriskspectralTable, i : Int, v : Double) -> FinanceriskspectralTable {
  let result = finance_risk_spectral_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_table_sum(s : FinanceriskspectralTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_table_mean(s : FinanceriskspectralTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_table_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_table_scale(s : FinanceriskspectralTable, f : Double) -> FinanceriskspectralTable {
  let result = finance_risk_spectral_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_table_add(a : FinanceriskspectralTable, b : FinanceriskspectralTable) -> FinanceriskspectralTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_table_copy(s : FinanceriskspectralTable) -> FinanceriskspectralTable {
  let result = finance_risk_spectral_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_table_fill(s : FinanceriskspectralTable, v : Double) -> FinanceriskspectralTable {
  let result = finance_risk_spectral_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_table_min(s : FinanceriskspectralTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_table_max(s : FinanceriskspectralTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_table_to_string(s : FinanceriskspectralTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_graphn_make(size : Int) -> FinanceriskspectralGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_graphn_len(s : FinanceriskspectralGraphN) -> Int { s.size }

pub fn finance_risk_spectral_graphn_get(s : FinanceriskspectralGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_graphn_set(s : FinanceriskspectralGraphN, i : Int, v : Double) -> FinanceriskspectralGraphN {
  let result = finance_risk_spectral_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_graphn_sum(s : FinanceriskspectralGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_graphn_mean(s : FinanceriskspectralGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_graphn_scale(s : FinanceriskspectralGraphN, f : Double) -> FinanceriskspectralGraphN {
  let result = finance_risk_spectral_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_graphn_add(a : FinanceriskspectralGraphN, b : FinanceriskspectralGraphN) -> FinanceriskspectralGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_graphn_copy(s : FinanceriskspectralGraphN) -> FinanceriskspectralGraphN {
  let result = finance_risk_spectral_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_graphn_fill(s : FinanceriskspectralGraphN, v : Double) -> FinanceriskspectralGraphN {
  let result = finance_risk_spectral_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_graphn_min(s : FinanceriskspectralGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_graphn_max(s : FinanceriskspectralGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_graphn_to_string(s : FinanceriskspectralGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_node_make(size : Int) -> FinanceriskspectralNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_node_len(s : FinanceriskspectralNode) -> Int { s.size }

pub fn finance_risk_spectral_node_get(s : FinanceriskspectralNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_node_set(s : FinanceriskspectralNode, i : Int, v : Double) -> FinanceriskspectralNode {
  let result = finance_risk_spectral_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_node_sum(s : FinanceriskspectralNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_node_mean(s : FinanceriskspectralNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_node_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_node_scale(s : FinanceriskspectralNode, f : Double) -> FinanceriskspectralNode {
  let result = finance_risk_spectral_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_node_add(a : FinanceriskspectralNode, b : FinanceriskspectralNode) -> FinanceriskspectralNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_node_copy(s : FinanceriskspectralNode) -> FinanceriskspectralNode {
  let result = finance_risk_spectral_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_node_fill(s : FinanceriskspectralNode, v : Double) -> FinanceriskspectralNode {
  let result = finance_risk_spectral_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_node_min(s : FinanceriskspectralNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_node_max(s : FinanceriskspectralNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_node_to_string(s : FinanceriskspectralNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_edge_make(size : Int) -> FinanceriskspectralEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_edge_len(s : FinanceriskspectralEdge) -> Int { s.size }

pub fn finance_risk_spectral_edge_get(s : FinanceriskspectralEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_edge_set(s : FinanceriskspectralEdge, i : Int, v : Double) -> FinanceriskspectralEdge {
  let result = finance_risk_spectral_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_edge_sum(s : FinanceriskspectralEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_edge_mean(s : FinanceriskspectralEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_edge_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_edge_scale(s : FinanceriskspectralEdge, f : Double) -> FinanceriskspectralEdge {
  let result = finance_risk_spectral_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_edge_add(a : FinanceriskspectralEdge, b : FinanceriskspectralEdge) -> FinanceriskspectralEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_edge_copy(s : FinanceriskspectralEdge) -> FinanceriskspectralEdge {
  let result = finance_risk_spectral_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_edge_fill(s : FinanceriskspectralEdge, v : Double) -> FinanceriskspectralEdge {
  let result = finance_risk_spectral_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_edge_min(s : FinanceriskspectralEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_edge_max(s : FinanceriskspectralEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_edge_to_string(s : FinanceriskspectralEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_path_make(size : Int) -> FinanceriskspectralPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_path_len(s : FinanceriskspectralPath) -> Int { s.size }

pub fn finance_risk_spectral_path_get(s : FinanceriskspectralPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_path_set(s : FinanceriskspectralPath, i : Int, v : Double) -> FinanceriskspectralPath {
  let result = finance_risk_spectral_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_path_sum(s : FinanceriskspectralPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_path_mean(s : FinanceriskspectralPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_path_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_path_scale(s : FinanceriskspectralPath, f : Double) -> FinanceriskspectralPath {
  let result = finance_risk_spectral_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_path_add(a : FinanceriskspectralPath, b : FinanceriskspectralPath) -> FinanceriskspectralPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_path_copy(s : FinanceriskspectralPath) -> FinanceriskspectralPath {
  let result = finance_risk_spectral_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_path_fill(s : FinanceriskspectralPath, v : Double) -> FinanceriskspectralPath {
  let result = finance_risk_spectral_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_path_min(s : FinanceriskspectralPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_path_max(s : FinanceriskspectralPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_path_to_string(s : FinanceriskspectralPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_cluster_make(size : Int) -> FinanceriskspectralCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_cluster_len(s : FinanceriskspectralCluster) -> Int { s.size }

pub fn finance_risk_spectral_cluster_get(s : FinanceriskspectralCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_cluster_set(s : FinanceriskspectralCluster, i : Int, v : Double) -> FinanceriskspectralCluster {
  let result = finance_risk_spectral_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_cluster_sum(s : FinanceriskspectralCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_cluster_mean(s : FinanceriskspectralCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_cluster_scale(s : FinanceriskspectralCluster, f : Double) -> FinanceriskspectralCluster {
  let result = finance_risk_spectral_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_cluster_add(a : FinanceriskspectralCluster, b : FinanceriskspectralCluster) -> FinanceriskspectralCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_cluster_copy(s : FinanceriskspectralCluster) -> FinanceriskspectralCluster {
  let result = finance_risk_spectral_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_cluster_fill(s : FinanceriskspectralCluster, v : Double) -> FinanceriskspectralCluster {
  let result = finance_risk_spectral_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_cluster_min(s : FinanceriskspectralCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_cluster_max(s : FinanceriskspectralCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_cluster_to_string(s : FinanceriskspectralCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_model_make(size : Int) -> FinanceriskspectralModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_model_len(s : FinanceriskspectralModel) -> Int { s.size }

pub fn finance_risk_spectral_model_get(s : FinanceriskspectralModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_model_set(s : FinanceriskspectralModel, i : Int, v : Double) -> FinanceriskspectralModel {
  let result = finance_risk_spectral_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_model_sum(s : FinanceriskspectralModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_model_mean(s : FinanceriskspectralModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_model_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_model_scale(s : FinanceriskspectralModel, f : Double) -> FinanceriskspectralModel {
  let result = finance_risk_spectral_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_model_add(a : FinanceriskspectralModel, b : FinanceriskspectralModel) -> FinanceriskspectralModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_model_copy(s : FinanceriskspectralModel) -> FinanceriskspectralModel {
  let result = finance_risk_spectral_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_model_fill(s : FinanceriskspectralModel, v : Double) -> FinanceriskspectralModel {
  let result = finance_risk_spectral_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_model_min(s : FinanceriskspectralModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_model_max(s : FinanceriskspectralModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_model_to_string(s : FinanceriskspectralModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_layer_make(size : Int) -> FinanceriskspectralLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_layer_len(s : FinanceriskspectralLayer) -> Int { s.size }

pub fn finance_risk_spectral_layer_get(s : FinanceriskspectralLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_layer_set(s : FinanceriskspectralLayer, i : Int, v : Double) -> FinanceriskspectralLayer {
  let result = finance_risk_spectral_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_layer_sum(s : FinanceriskspectralLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_layer_mean(s : FinanceriskspectralLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_layer_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_layer_scale(s : FinanceriskspectralLayer, f : Double) -> FinanceriskspectralLayer {
  let result = finance_risk_spectral_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_layer_add(a : FinanceriskspectralLayer, b : FinanceriskspectralLayer) -> FinanceriskspectralLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_layer_copy(s : FinanceriskspectralLayer) -> FinanceriskspectralLayer {
  let result = finance_risk_spectral_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_layer_fill(s : FinanceriskspectralLayer, v : Double) -> FinanceriskspectralLayer {
  let result = finance_risk_spectral_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_layer_min(s : FinanceriskspectralLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_layer_max(s : FinanceriskspectralLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_layer_to_string(s : FinanceriskspectralLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_buffer_make(size : Int) -> FinanceriskspectralBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_buffer_len(s : FinanceriskspectralBuffer) -> Int { s.size }

pub fn finance_risk_spectral_buffer_get(s : FinanceriskspectralBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_buffer_set(s : FinanceriskspectralBuffer, i : Int, v : Double) -> FinanceriskspectralBuffer {
  let result = finance_risk_spectral_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_buffer_sum(s : FinanceriskspectralBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_buffer_mean(s : FinanceriskspectralBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_buffer_scale(s : FinanceriskspectralBuffer, f : Double) -> FinanceriskspectralBuffer {
  let result = finance_risk_spectral_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_buffer_add(a : FinanceriskspectralBuffer, b : FinanceriskspectralBuffer) -> FinanceriskspectralBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_buffer_copy(s : FinanceriskspectralBuffer) -> FinanceriskspectralBuffer {
  let result = finance_risk_spectral_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_buffer_fill(s : FinanceriskspectralBuffer, v : Double) -> FinanceriskspectralBuffer {
  let result = finance_risk_spectral_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_buffer_min(s : FinanceriskspectralBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_buffer_max(s : FinanceriskspectralBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_buffer_to_string(s : FinanceriskspectralBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_cursor_make(size : Int) -> FinanceriskspectralCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_cursor_len(s : FinanceriskspectralCursor) -> Int { s.size }

pub fn finance_risk_spectral_cursor_get(s : FinanceriskspectralCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_cursor_set(s : FinanceriskspectralCursor, i : Int, v : Double) -> FinanceriskspectralCursor {
  let result = finance_risk_spectral_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_cursor_sum(s : FinanceriskspectralCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_cursor_mean(s : FinanceriskspectralCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_cursor_scale(s : FinanceriskspectralCursor, f : Double) -> FinanceriskspectralCursor {
  let result = finance_risk_spectral_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_cursor_add(a : FinanceriskspectralCursor, b : FinanceriskspectralCursor) -> FinanceriskspectralCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_cursor_copy(s : FinanceriskspectralCursor) -> FinanceriskspectralCursor {
  let result = finance_risk_spectral_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_cursor_fill(s : FinanceriskspectralCursor, v : Double) -> FinanceriskspectralCursor {
  let result = finance_risk_spectral_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_cursor_min(s : FinanceriskspectralCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_cursor_max(s : FinanceriskspectralCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_cursor_to_string(s : FinanceriskspectralCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_view_make(size : Int) -> FinanceriskspectralView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_view_len(s : FinanceriskspectralView) -> Int { s.size }

pub fn finance_risk_spectral_view_get(s : FinanceriskspectralView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_view_set(s : FinanceriskspectralView, i : Int, v : Double) -> FinanceriskspectralView {
  let result = finance_risk_spectral_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_view_sum(s : FinanceriskspectralView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_view_mean(s : FinanceriskspectralView) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_view_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_view_scale(s : FinanceriskspectralView, f : Double) -> FinanceriskspectralView {
  let result = finance_risk_spectral_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_view_add(a : FinanceriskspectralView, b : FinanceriskspectralView) -> FinanceriskspectralView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_view_copy(s : FinanceriskspectralView) -> FinanceriskspectralView {
  let result = finance_risk_spectral_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_view_fill(s : FinanceriskspectralView, v : Double) -> FinanceriskspectralView {
  let result = finance_risk_spectral_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_view_min(s : FinanceriskspectralView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_view_max(s : FinanceriskspectralView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_view_to_string(s : FinanceriskspectralView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_range_make(size : Int) -> FinanceriskspectralRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_range_len(s : FinanceriskspectralRange) -> Int { s.size }

pub fn finance_risk_spectral_range_get(s : FinanceriskspectralRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_range_set(s : FinanceriskspectralRange, i : Int, v : Double) -> FinanceriskspectralRange {
  let result = finance_risk_spectral_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_range_sum(s : FinanceriskspectralRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_range_mean(s : FinanceriskspectralRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_range_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_range_scale(s : FinanceriskspectralRange, f : Double) -> FinanceriskspectralRange {
  let result = finance_risk_spectral_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_range_add(a : FinanceriskspectralRange, b : FinanceriskspectralRange) -> FinanceriskspectralRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_range_copy(s : FinanceriskspectralRange) -> FinanceriskspectralRange {
  let result = finance_risk_spectral_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_range_fill(s : FinanceriskspectralRange, v : Double) -> FinanceriskspectralRange {
  let result = finance_risk_spectral_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_range_min(s : FinanceriskspectralRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_range_max(s : FinanceriskspectralRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_range_to_string(s : FinanceriskspectralRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskspectralSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_spectral_slice_make(size : Int) -> FinanceriskspectralSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_spectral_slice_len(s : FinanceriskspectralSlice) -> Int { s.size }

pub fn finance_risk_spectral_slice_get(s : FinanceriskspectralSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_spectral_slice_set(s : FinanceriskspectralSlice, i : Int, v : Double) -> FinanceriskspectralSlice {
  let result = finance_risk_spectral_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_slice_sum(s : FinanceriskspectralSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_spectral_slice_mean(s : FinanceriskspectralSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_spectral_slice_sum(s) / s.size.to_double() }
}

pub fn finance_risk_spectral_slice_scale(s : FinanceriskspectralSlice, f : Double) -> FinanceriskspectralSlice {
  let result = finance_risk_spectral_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_spectral_slice_add(a : FinanceriskspectralSlice, b : FinanceriskspectralSlice) -> FinanceriskspectralSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_spectral_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_spectral_slice_copy(s : FinanceriskspectralSlice) -> FinanceriskspectralSlice {
  let result = finance_risk_spectral_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_spectral_slice_fill(s : FinanceriskspectralSlice, v : Double) -> FinanceriskspectralSlice {
  let result = finance_risk_spectral_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_spectral_slice_min(s : FinanceriskspectralSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_slice_max(s : FinanceriskspectralSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_spectral_slice_to_string(s : FinanceriskspectralSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

