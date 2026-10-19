///===
/// extcore/finance_pricing_binomial

pub(all) struct FinancepricingbinomialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_pricing_binomial_make_point(x : Double, y : Double) -> FinancepricingbinomialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_pricing_binomial_make_point3(x : Double, y : Double, z : Double) -> FinancepricingbinomialPoint {
  { x, y, z, label: 0 }
}

pub fn finance_pricing_binomial_point_x(pt : FinancepricingbinomialPoint) -> Double { pt.x }

pub fn finance_pricing_binomial_point_y(pt : FinancepricingbinomialPoint) -> Double { pt.y }

pub fn finance_pricing_binomial_point_z(pt : FinancepricingbinomialPoint) -> Double { pt.z }

pub fn finance_pricing_binomial_point_label(pt : FinancepricingbinomialPoint) -> Int { pt.label }

pub fn finance_pricing_binomial_point_dist(a : FinancepricingbinomialPoint, b : FinancepricingbinomialPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_pricing_binomial_point_add(a : FinancepricingbinomialPoint, b : FinancepricingbinomialPoint) -> FinancepricingbinomialPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_pricing_binomial_point_sub(a : FinancepricingbinomialPoint, b : FinancepricingbinomialPoint) -> FinancepricingbinomialPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_pricing_binomial_point_scale(pt : FinancepricingbinomialPoint, s : Double) -> FinancepricingbinomialPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_pricing_binomial_point_dot(a : FinancepricingbinomialPoint, b : FinancepricingbinomialPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_pricing_binomial_point_cross(a : FinancepricingbinomialPoint, b : FinancepricingbinomialPoint) -> FinancepricingbinomialPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_pricing_binomial_point_norm(pt : FinancepricingbinomialPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_pricing_binomial_point_normalize(pt : FinancepricingbinomialPoint) -> FinancepricingbinomialPoint {
  let n = finance_pricing_binomial_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_pricing_binomial_point_scale(pt, 1.0 / n) }
}

pub fn finance_pricing_binomial_point_negate(pt : FinancepricingbinomialPoint) -> FinancepricingbinomialPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_pricing_binomial_point_mid(a : FinancepricingbinomialPoint, b : FinancepricingbinomialPoint) -> FinancepricingbinomialPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_pricing_binomial_point_lerp(a : FinancepricingbinomialPoint, b : FinancepricingbinomialPoint, t : Double) -> FinancepricingbinomialPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_pricing_binomial_point_to_string(pt : FinancepricingbinomialPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancepricingbinomialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_pricing_binomial_make_series(vals : Array[Double], name : String) -> FinancepricingbinomialSeries {
  { vals, name, meta: 0 }
}

pub fn finance_pricing_binomial_series_len(s : FinancepricingbinomialSeries) -> Int { s.vals.length() }

pub fn finance_pricing_binomial_series_sum(s : FinancepricingbinomialSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_pricing_binomial_series_mean(s : FinancepricingbinomialSeries) -> Double {
  let n = finance_pricing_binomial_series_len(s)
  if n == 0 { 0.0 } else { finance_pricing_binomial_series_sum(s) / n.to_double() }
}

pub fn finance_pricing_binomial_series_min(s : FinancepricingbinomialSeries) -> Double {
  let n = finance_pricing_binomial_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_pricing_binomial_series_max(s : FinancepricingbinomialSeries) -> Double {
  let n = finance_pricing_binomial_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_pricing_binomial_series_range(s : FinancepricingbinomialSeries) -> Double {
  finance_pricing_binomial_series_max(s) - finance_pricing_binomial_series_min(s)
}

pub fn finance_pricing_binomial_series_var(s : FinancepricingbinomialSeries) -> Double {
  let n = finance_pricing_binomial_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_pricing_binomial_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_pricing_binomial_series_std(s : FinancepricingbinomialSeries) -> Double { @_common.sqrt(finance_pricing_binomial_series_var(s)) }

pub fn finance_pricing_binomial_series_median(s : FinancepricingbinomialSeries) -> Double {
  let n = finance_pricing_binomial_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_pricing_binomial_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_pricing_binomial_series_scale(s : FinancepricingbinomialSeries, f : Double) -> FinancepricingbinomialSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_pricing_binomial_series_add(a : FinancepricingbinomialSeries, b : FinancepricingbinomialSeries) -> FinancepricingbinomialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_pricing_binomial_series_sub(a : FinancepricingbinomialSeries, b : FinancepricingbinomialSeries) -> FinancepricingbinomialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_pricing_binomial_series_normalize(s : FinancepricingbinomialSeries) -> FinancepricingbinomialSeries {
  let mn = finance_pricing_binomial_series_min(s)
  let mx = finance_pricing_binomial_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_pricing_binomial_series_cumsum(s : FinancepricingbinomialSeries) -> FinancepricingbinomialSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_pricing_binomial_series_to_string(s : FinancepricingbinomialSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancepricingbinomialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_pricing_binomial_make_matrix(rows : Int, cols : Int, val : Double) -> FinancepricingbinomialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_pricing_binomial_matrix_identity(n : Int) -> FinancepricingbinomialMatrix {
  let m = finance_pricing_binomial_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_pricing_binomial_matrix_get(m : FinancepricingbinomialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_pricing_binomial_matrix_transpose(m : FinancepricingbinomialMatrix) -> FinancepricingbinomialMatrix {
  let result = finance_pricing_binomial_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_pricing_binomial_matrix_add(a : FinancepricingbinomialMatrix, b : FinancepricingbinomialMatrix) -> FinancepricingbinomialMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_pricing_binomial_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_pricing_binomial_matrix_scale(m : FinancepricingbinomialMatrix, s : Double) -> FinancepricingbinomialMatrix {
  let result = finance_pricing_binomial_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_pricing_binomial_matrix_multiply(a : FinancepricingbinomialMatrix, b : FinancepricingbinomialMatrix) -> FinancepricingbinomialMatrix {
  if a.cols != b.rows { return finance_pricing_binomial_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_pricing_binomial_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_pricing_binomial_matrix_trace(m : FinancepricingbinomialMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_pricing_binomial_matrix_det(m : FinancepricingbinomialMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_pricing_binomial_matrix_norm(m : FinancepricingbinomialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_pricing_binomial_matrix_to_string(m : FinancepricingbinomialMatrix) -> String {
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

pub(all) struct FinancepricingbinomialVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_pricing_binomial_make_vector(comps : Array[Double]) -> FinancepricingbinomialVector {
  { comps, dim: comps.length() }
}

pub fn finance_pricing_binomial_vector_zero(dim : Int) -> FinancepricingbinomialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_pricing_binomial_vector_add(a : FinancepricingbinomialVector, b : FinancepricingbinomialVector) -> FinancepricingbinomialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_pricing_binomial_vector_sub(a : FinancepricingbinomialVector, b : FinancepricingbinomialVector) -> FinancepricingbinomialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_pricing_binomial_vector_scale(v : FinancepricingbinomialVector, s : Double) -> FinancepricingbinomialVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_pricing_binomial_vector_dot(a : FinancepricingbinomialVector, b : FinancepricingbinomialVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_pricing_binomial_vector_norm(v : FinancepricingbinomialVector) -> Double { @_common.sqrt(finance_pricing_binomial_vector_dot(v, v)) }

pub fn finance_pricing_binomial_vector_normalize(v : FinancepricingbinomialVector) -> FinancepricingbinomialVector {
  let n = finance_pricing_binomial_vector_norm(v)
  if n < 0.0000001 { v } else { finance_pricing_binomial_vector_scale(v, 1.0 / n) }
}

pub fn finance_pricing_binomial_vector_dist(a : FinancepricingbinomialVector, b : FinancepricingbinomialVector) -> Double {
  finance_pricing_binomial_vector_norm(finance_pricing_binomial_vector_sub(a, b))
}

pub fn finance_pricing_binomial_vector_to_string(v : FinancepricingbinomialVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_pricing_binomial_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_pricing_binomial_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_pricing_binomial_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_pricing_binomial_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_pricing_binomial_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_pricing_binomial_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_pricing_binomial_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_pricing_binomial_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_pricing_binomial_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_pricing_binomial_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_pricing_binomial_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_pricing_binomial_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_pricing_binomial_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_pricing_binomial_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_pricing_binomial_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_pricing_binomial_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_pricing_binomial_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_pricing_binomial_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_pricing_binomial_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_pricing_binomial_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_pricing_binomial_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_pricing_binomial_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_pricing_binomial_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_pricing_binomial_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_pricing_binomial_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_pricing_binomial_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_pricing_binomial_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_pricing_binomial_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_pricing_binomial_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancepricingbinomialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_frame_make(size : Int) -> FinancepricingbinomialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_frame_len(s : FinancepricingbinomialFrame) -> Int { s.size }

pub fn finance_pricing_binomial_frame_get(s : FinancepricingbinomialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_frame_set(s : FinancepricingbinomialFrame, i : Int, v : Double) -> FinancepricingbinomialFrame {
  let result = finance_pricing_binomial_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_frame_sum(s : FinancepricingbinomialFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_binomial_frame_mean(s : FinancepricingbinomialFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_binomial_frame_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_binomial_frame_scale(s : FinancepricingbinomialFrame, f : Double) -> FinancepricingbinomialFrame {
  let result = finance_pricing_binomial_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_binomial_frame_add(a : FinancepricingbinomialFrame, b : FinancepricingbinomialFrame) -> FinancepricingbinomialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_binomial_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_binomial_frame_copy(s : FinancepricingbinomialFrame) -> FinancepricingbinomialFrame {
  let result = finance_pricing_binomial_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_binomial_frame_fill(s : FinancepricingbinomialFrame, v : Double) -> FinancepricingbinomialFrame {
  let result = finance_pricing_binomial_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_frame_min(s : FinancepricingbinomialFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_frame_max(s : FinancepricingbinomialFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_frame_to_string(s : FinancepricingbinomialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_table_make(size : Int) -> FinancepricingbinomialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_table_len(s : FinancepricingbinomialTable) -> Int { s.size }

pub fn finance_pricing_binomial_table_get(s : FinancepricingbinomialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_table_set(s : FinancepricingbinomialTable, i : Int, v : Double) -> FinancepricingbinomialTable {
  let result = finance_pricing_binomial_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_table_sum(s : FinancepricingbinomialTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_binomial_table_mean(s : FinancepricingbinomialTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_binomial_table_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_binomial_table_scale(s : FinancepricingbinomialTable, f : Double) -> FinancepricingbinomialTable {
  let result = finance_pricing_binomial_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_binomial_table_add(a : FinancepricingbinomialTable, b : FinancepricingbinomialTable) -> FinancepricingbinomialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_binomial_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_binomial_table_copy(s : FinancepricingbinomialTable) -> FinancepricingbinomialTable {
  let result = finance_pricing_binomial_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_binomial_table_fill(s : FinancepricingbinomialTable, v : Double) -> FinancepricingbinomialTable {
  let result = finance_pricing_binomial_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_table_min(s : FinancepricingbinomialTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_table_max(s : FinancepricingbinomialTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_table_to_string(s : FinancepricingbinomialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_graphn_make(size : Int) -> FinancepricingbinomialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_graphn_len(s : FinancepricingbinomialGraphN) -> Int { s.size }

pub fn finance_pricing_binomial_graphn_get(s : FinancepricingbinomialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_graphn_set(s : FinancepricingbinomialGraphN, i : Int, v : Double) -> FinancepricingbinomialGraphN {
  let result = finance_pricing_binomial_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_graphn_sum(s : FinancepricingbinomialGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_binomial_graphn_mean(s : FinancepricingbinomialGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_binomial_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_binomial_graphn_scale(s : FinancepricingbinomialGraphN, f : Double) -> FinancepricingbinomialGraphN {
  let result = finance_pricing_binomial_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_binomial_graphn_add(a : FinancepricingbinomialGraphN, b : FinancepricingbinomialGraphN) -> FinancepricingbinomialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_binomial_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_binomial_graphn_copy(s : FinancepricingbinomialGraphN) -> FinancepricingbinomialGraphN {
  let result = finance_pricing_binomial_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_binomial_graphn_fill(s : FinancepricingbinomialGraphN, v : Double) -> FinancepricingbinomialGraphN {
  let result = finance_pricing_binomial_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_graphn_min(s : FinancepricingbinomialGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_graphn_max(s : FinancepricingbinomialGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_graphn_to_string(s : FinancepricingbinomialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_node_make(size : Int) -> FinancepricingbinomialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_node_len(s : FinancepricingbinomialNode) -> Int { s.size }

pub fn finance_pricing_binomial_node_get(s : FinancepricingbinomialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_node_set(s : FinancepricingbinomialNode, i : Int, v : Double) -> FinancepricingbinomialNode {
  let result = finance_pricing_binomial_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_node_sum(s : FinancepricingbinomialNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_binomial_node_mean(s : FinancepricingbinomialNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_binomial_node_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_binomial_node_scale(s : FinancepricingbinomialNode, f : Double) -> FinancepricingbinomialNode {
  let result = finance_pricing_binomial_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_binomial_node_add(a : FinancepricingbinomialNode, b : FinancepricingbinomialNode) -> FinancepricingbinomialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_binomial_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_binomial_node_copy(s : FinancepricingbinomialNode) -> FinancepricingbinomialNode {
  let result = finance_pricing_binomial_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_binomial_node_fill(s : FinancepricingbinomialNode, v : Double) -> FinancepricingbinomialNode {
  let result = finance_pricing_binomial_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_node_min(s : FinancepricingbinomialNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_node_max(s : FinancepricingbinomialNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_node_to_string(s : FinancepricingbinomialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_edge_make(size : Int) -> FinancepricingbinomialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_edge_len(s : FinancepricingbinomialEdge) -> Int { s.size }

pub fn finance_pricing_binomial_edge_get(s : FinancepricingbinomialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_edge_set(s : FinancepricingbinomialEdge, i : Int, v : Double) -> FinancepricingbinomialEdge {
  let result = finance_pricing_binomial_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_edge_sum(s : FinancepricingbinomialEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_binomial_edge_mean(s : FinancepricingbinomialEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_binomial_edge_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_binomial_edge_scale(s : FinancepricingbinomialEdge, f : Double) -> FinancepricingbinomialEdge {
  let result = finance_pricing_binomial_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_binomial_edge_add(a : FinancepricingbinomialEdge, b : FinancepricingbinomialEdge) -> FinancepricingbinomialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_binomial_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_binomial_edge_copy(s : FinancepricingbinomialEdge) -> FinancepricingbinomialEdge {
  let result = finance_pricing_binomial_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_binomial_edge_fill(s : FinancepricingbinomialEdge, v : Double) -> FinancepricingbinomialEdge {
  let result = finance_pricing_binomial_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_edge_min(s : FinancepricingbinomialEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_edge_max(s : FinancepricingbinomialEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_edge_to_string(s : FinancepricingbinomialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_path_make(size : Int) -> FinancepricingbinomialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_path_len(s : FinancepricingbinomialPath) -> Int { s.size }

pub fn finance_pricing_binomial_path_get(s : FinancepricingbinomialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_path_set(s : FinancepricingbinomialPath, i : Int, v : Double) -> FinancepricingbinomialPath {
  let result = finance_pricing_binomial_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_path_sum(s : FinancepricingbinomialPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_binomial_path_mean(s : FinancepricingbinomialPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_binomial_path_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_binomial_path_scale(s : FinancepricingbinomialPath, f : Double) -> FinancepricingbinomialPath {
  let result = finance_pricing_binomial_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_binomial_path_add(a : FinancepricingbinomialPath, b : FinancepricingbinomialPath) -> FinancepricingbinomialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_binomial_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_binomial_path_copy(s : FinancepricingbinomialPath) -> FinancepricingbinomialPath {
  let result = finance_pricing_binomial_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_binomial_path_fill(s : FinancepricingbinomialPath, v : Double) -> FinancepricingbinomialPath {
  let result = finance_pricing_binomial_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_path_min(s : FinancepricingbinomialPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_path_max(s : FinancepricingbinomialPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_path_to_string(s : FinancepricingbinomialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_cluster_make(size : Int) -> FinancepricingbinomialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_cluster_len(s : FinancepricingbinomialCluster) -> Int { s.size }

pub fn finance_pricing_binomial_cluster_get(s : FinancepricingbinomialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_cluster_set(s : FinancepricingbinomialCluster, i : Int, v : Double) -> FinancepricingbinomialCluster {
  let result = finance_pricing_binomial_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_cluster_sum(s : FinancepricingbinomialCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_binomial_cluster_mean(s : FinancepricingbinomialCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_binomial_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_binomial_cluster_scale(s : FinancepricingbinomialCluster, f : Double) -> FinancepricingbinomialCluster {
  let result = finance_pricing_binomial_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_binomial_cluster_add(a : FinancepricingbinomialCluster, b : FinancepricingbinomialCluster) -> FinancepricingbinomialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_binomial_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_binomial_cluster_copy(s : FinancepricingbinomialCluster) -> FinancepricingbinomialCluster {
  let result = finance_pricing_binomial_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_binomial_cluster_fill(s : FinancepricingbinomialCluster, v : Double) -> FinancepricingbinomialCluster {
  let result = finance_pricing_binomial_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_cluster_min(s : FinancepricingbinomialCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_cluster_max(s : FinancepricingbinomialCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_cluster_to_string(s : FinancepricingbinomialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_model_make(size : Int) -> FinancepricingbinomialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_model_len(s : FinancepricingbinomialModel) -> Int { s.size }

pub fn finance_pricing_binomial_model_get(s : FinancepricingbinomialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_model_set(s : FinancepricingbinomialModel, i : Int, v : Double) -> FinancepricingbinomialModel {
  let result = finance_pricing_binomial_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_model_sum(s : FinancepricingbinomialModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_binomial_model_mean(s : FinancepricingbinomialModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_binomial_model_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_binomial_model_scale(s : FinancepricingbinomialModel, f : Double) -> FinancepricingbinomialModel {
  let result = finance_pricing_binomial_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_binomial_model_add(a : FinancepricingbinomialModel, b : FinancepricingbinomialModel) -> FinancepricingbinomialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_binomial_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_binomial_model_copy(s : FinancepricingbinomialModel) -> FinancepricingbinomialModel {
  let result = finance_pricing_binomial_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_binomial_model_fill(s : FinancepricingbinomialModel, v : Double) -> FinancepricingbinomialModel {
  let result = finance_pricing_binomial_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_model_min(s : FinancepricingbinomialModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_model_max(s : FinancepricingbinomialModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_model_to_string(s : FinancepricingbinomialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_layer_make(size : Int) -> FinancepricingbinomialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_layer_len(s : FinancepricingbinomialLayer) -> Int { s.size }

pub fn finance_pricing_binomial_layer_get(s : FinancepricingbinomialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_layer_set(s : FinancepricingbinomialLayer, i : Int, v : Double) -> FinancepricingbinomialLayer {
  let result = finance_pricing_binomial_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_layer_sum(s : FinancepricingbinomialLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_binomial_layer_mean(s : FinancepricingbinomialLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_binomial_layer_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_binomial_layer_scale(s : FinancepricingbinomialLayer, f : Double) -> FinancepricingbinomialLayer {
  let result = finance_pricing_binomial_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_binomial_layer_add(a : FinancepricingbinomialLayer, b : FinancepricingbinomialLayer) -> FinancepricingbinomialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_binomial_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_binomial_layer_copy(s : FinancepricingbinomialLayer) -> FinancepricingbinomialLayer {
  let result = finance_pricing_binomial_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_binomial_layer_fill(s : FinancepricingbinomialLayer, v : Double) -> FinancepricingbinomialLayer {
  let result = finance_pricing_binomial_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_layer_min(s : FinancepricingbinomialLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_layer_max(s : FinancepricingbinomialLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_layer_to_string(s : FinancepricingbinomialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_buffer_make(size : Int) -> FinancepricingbinomialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_buffer_len(s : FinancepricingbinomialBuffer) -> Int { s.size }

pub fn finance_pricing_binomial_buffer_get(s : FinancepricingbinomialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_buffer_set(s : FinancepricingbinomialBuffer, i : Int, v : Double) -> FinancepricingbinomialBuffer {
  let result = finance_pricing_binomial_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_buffer_sum(s : FinancepricingbinomialBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_binomial_buffer_mean(s : FinancepricingbinomialBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_binomial_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_binomial_buffer_scale(s : FinancepricingbinomialBuffer, f : Double) -> FinancepricingbinomialBuffer {
  let result = finance_pricing_binomial_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_binomial_buffer_add(a : FinancepricingbinomialBuffer, b : FinancepricingbinomialBuffer) -> FinancepricingbinomialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_binomial_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_binomial_buffer_copy(s : FinancepricingbinomialBuffer) -> FinancepricingbinomialBuffer {
  let result = finance_pricing_binomial_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_binomial_buffer_fill(s : FinancepricingbinomialBuffer, v : Double) -> FinancepricingbinomialBuffer {
  let result = finance_pricing_binomial_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_buffer_min(s : FinancepricingbinomialBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_buffer_max(s : FinancepricingbinomialBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_buffer_to_string(s : FinancepricingbinomialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_cursor_make(size : Int) -> FinancepricingbinomialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_cursor_len(s : FinancepricingbinomialCursor) -> Int { s.size }

pub fn finance_pricing_binomial_cursor_get(s : FinancepricingbinomialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_cursor_set(s : FinancepricingbinomialCursor, i : Int, v : Double) -> FinancepricingbinomialCursor {
  let result = finance_pricing_binomial_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_cursor_sum(s : FinancepricingbinomialCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_binomial_cursor_mean(s : FinancepricingbinomialCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_binomial_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_binomial_cursor_scale(s : FinancepricingbinomialCursor, f : Double) -> FinancepricingbinomialCursor {
  let result = finance_pricing_binomial_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_binomial_cursor_add(a : FinancepricingbinomialCursor, b : FinancepricingbinomialCursor) -> FinancepricingbinomialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_binomial_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_binomial_cursor_copy(s : FinancepricingbinomialCursor) -> FinancepricingbinomialCursor {
  let result = finance_pricing_binomial_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_binomial_cursor_fill(s : FinancepricingbinomialCursor, v : Double) -> FinancepricingbinomialCursor {
  let result = finance_pricing_binomial_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_cursor_min(s : FinancepricingbinomialCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_cursor_max(s : FinancepricingbinomialCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_cursor_to_string(s : FinancepricingbinomialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_view_make(size : Int) -> FinancepricingbinomialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_view_len(s : FinancepricingbinomialView) -> Int { s.size }

pub fn finance_pricing_binomial_view_get(s : FinancepricingbinomialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_view_set(s : FinancepricingbinomialView, i : Int, v : Double) -> FinancepricingbinomialView {
  let result = finance_pricing_binomial_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_view_sum(s : FinancepricingbinomialView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_binomial_view_mean(s : FinancepricingbinomialView) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_binomial_view_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_binomial_view_scale(s : FinancepricingbinomialView, f : Double) -> FinancepricingbinomialView {
  let result = finance_pricing_binomial_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_binomial_view_add(a : FinancepricingbinomialView, b : FinancepricingbinomialView) -> FinancepricingbinomialView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_binomial_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_binomial_view_copy(s : FinancepricingbinomialView) -> FinancepricingbinomialView {
  let result = finance_pricing_binomial_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_binomial_view_fill(s : FinancepricingbinomialView, v : Double) -> FinancepricingbinomialView {
  let result = finance_pricing_binomial_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_view_min(s : FinancepricingbinomialView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_view_max(s : FinancepricingbinomialView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_view_to_string(s : FinancepricingbinomialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_range_make(size : Int) -> FinancepricingbinomialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_range_len(s : FinancepricingbinomialRange) -> Int { s.size }

pub fn finance_pricing_binomial_range_get(s : FinancepricingbinomialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_range_set(s : FinancepricingbinomialRange, i : Int, v : Double) -> FinancepricingbinomialRange {
  let result = finance_pricing_binomial_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_range_sum(s : FinancepricingbinomialRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_binomial_range_mean(s : FinancepricingbinomialRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_binomial_range_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_binomial_range_scale(s : FinancepricingbinomialRange, f : Double) -> FinancepricingbinomialRange {
  let result = finance_pricing_binomial_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_binomial_range_add(a : FinancepricingbinomialRange, b : FinancepricingbinomialRange) -> FinancepricingbinomialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_binomial_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_binomial_range_copy(s : FinancepricingbinomialRange) -> FinancepricingbinomialRange {
  let result = finance_pricing_binomial_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_binomial_range_fill(s : FinancepricingbinomialRange, v : Double) -> FinancepricingbinomialRange {
  let result = finance_pricing_binomial_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_range_min(s : FinancepricingbinomialRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_range_max(s : FinancepricingbinomialRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_range_to_string(s : FinancepricingbinomialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancepricingbinomialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_pricing_binomial_slice_make(size : Int) -> FinancepricingbinomialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_pricing_binomial_slice_len(s : FinancepricingbinomialSlice) -> Int { s.size }

pub fn finance_pricing_binomial_slice_get(s : FinancepricingbinomialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_pricing_binomial_slice_set(s : FinancepricingbinomialSlice, i : Int, v : Double) -> FinancepricingbinomialSlice {
  let result = finance_pricing_binomial_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_slice_sum(s : FinancepricingbinomialSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_pricing_binomial_slice_mean(s : FinancepricingbinomialSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_pricing_binomial_slice_sum(s) / s.size.to_double() }
}

pub fn finance_pricing_binomial_slice_scale(s : FinancepricingbinomialSlice, f : Double) -> FinancepricingbinomialSlice {
  let result = finance_pricing_binomial_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_pricing_binomial_slice_add(a : FinancepricingbinomialSlice, b : FinancepricingbinomialSlice) -> FinancepricingbinomialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_pricing_binomial_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_pricing_binomial_slice_copy(s : FinancepricingbinomialSlice) -> FinancepricingbinomialSlice {
  let result = finance_pricing_binomial_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_pricing_binomial_slice_fill(s : FinancepricingbinomialSlice, v : Double) -> FinancepricingbinomialSlice {
  let result = finance_pricing_binomial_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_pricing_binomial_slice_min(s : FinancepricingbinomialSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_slice_max(s : FinancepricingbinomialSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_pricing_binomial_slice_to_string(s : FinancepricingbinomialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

