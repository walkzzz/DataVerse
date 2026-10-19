///===
/// extcore/finance_risk_marginal

pub(all) struct FinanceriskmarginalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_marginal_make_point(x : Double, y : Double) -> FinanceriskmarginalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_marginal_make_point3(x : Double, y : Double, z : Double) -> FinanceriskmarginalPoint {
  { x, y, z, label: 0 }
}

pub fn finance_risk_marginal_point_x(pt : FinanceriskmarginalPoint) -> Double { pt.x }

pub fn finance_risk_marginal_point_y(pt : FinanceriskmarginalPoint) -> Double { pt.y }

pub fn finance_risk_marginal_point_z(pt : FinanceriskmarginalPoint) -> Double { pt.z }

pub fn finance_risk_marginal_point_label(pt : FinanceriskmarginalPoint) -> Int { pt.label }

pub fn finance_risk_marginal_point_dist(a : FinanceriskmarginalPoint, b : FinanceriskmarginalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_risk_marginal_point_add(a : FinanceriskmarginalPoint, b : FinanceriskmarginalPoint) -> FinanceriskmarginalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_risk_marginal_point_sub(a : FinanceriskmarginalPoint, b : FinanceriskmarginalPoint) -> FinanceriskmarginalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_risk_marginal_point_scale(pt : FinanceriskmarginalPoint, s : Double) -> FinanceriskmarginalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_risk_marginal_point_dot(a : FinanceriskmarginalPoint, b : FinanceriskmarginalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_risk_marginal_point_cross(a : FinanceriskmarginalPoint, b : FinanceriskmarginalPoint) -> FinanceriskmarginalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_risk_marginal_point_norm(pt : FinanceriskmarginalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_risk_marginal_point_normalize(pt : FinanceriskmarginalPoint) -> FinanceriskmarginalPoint {
  let n = finance_risk_marginal_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_risk_marginal_point_scale(pt, 1.0 / n) }
}

pub fn finance_risk_marginal_point_negate(pt : FinanceriskmarginalPoint) -> FinanceriskmarginalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_risk_marginal_point_mid(a : FinanceriskmarginalPoint, b : FinanceriskmarginalPoint) -> FinanceriskmarginalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_risk_marginal_point_lerp(a : FinanceriskmarginalPoint, b : FinanceriskmarginalPoint, t : Double) -> FinanceriskmarginalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_risk_marginal_point_to_string(pt : FinanceriskmarginalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceriskmarginalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_marginal_make_series(vals : Array[Double], name : String) -> FinanceriskmarginalSeries {
  { vals, name, meta: 0 }
}

pub fn finance_risk_marginal_series_len(s : FinanceriskmarginalSeries) -> Int { s.vals.length() }

pub fn finance_risk_marginal_series_sum(s : FinanceriskmarginalSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_risk_marginal_series_mean(s : FinanceriskmarginalSeries) -> Double {
  let n = finance_risk_marginal_series_len(s)
  if n == 0 { 0.0 } else { finance_risk_marginal_series_sum(s) / n.to_double() }
}

pub fn finance_risk_marginal_series_min(s : FinanceriskmarginalSeries) -> Double {
  let n = finance_risk_marginal_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_risk_marginal_series_max(s : FinanceriskmarginalSeries) -> Double {
  let n = finance_risk_marginal_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_risk_marginal_series_range(s : FinanceriskmarginalSeries) -> Double {
  finance_risk_marginal_series_max(s) - finance_risk_marginal_series_min(s)
}

pub fn finance_risk_marginal_series_var(s : FinanceriskmarginalSeries) -> Double {
  let n = finance_risk_marginal_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_risk_marginal_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_risk_marginal_series_std(s : FinanceriskmarginalSeries) -> Double { @_common.sqrt(finance_risk_marginal_series_var(s)) }

pub fn finance_risk_marginal_series_median(s : FinanceriskmarginalSeries) -> Double {
  let n = finance_risk_marginal_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_risk_marginal_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_risk_marginal_series_scale(s : FinanceriskmarginalSeries, f : Double) -> FinanceriskmarginalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_risk_marginal_series_add(a : FinanceriskmarginalSeries, b : FinanceriskmarginalSeries) -> FinanceriskmarginalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_risk_marginal_series_sub(a : FinanceriskmarginalSeries, b : FinanceriskmarginalSeries) -> FinanceriskmarginalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_risk_marginal_series_normalize(s : FinanceriskmarginalSeries) -> FinanceriskmarginalSeries {
  let mn = finance_risk_marginal_series_min(s)
  let mx = finance_risk_marginal_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_risk_marginal_series_cumsum(s : FinanceriskmarginalSeries) -> FinanceriskmarginalSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_risk_marginal_series_to_string(s : FinanceriskmarginalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskmarginalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_marginal_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskmarginalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_marginal_matrix_identity(n : Int) -> FinanceriskmarginalMatrix {
  let m = finance_risk_marginal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_risk_marginal_matrix_get(m : FinanceriskmarginalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_risk_marginal_matrix_transpose(m : FinanceriskmarginalMatrix) -> FinanceriskmarginalMatrix {
  let result = finance_risk_marginal_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_risk_marginal_matrix_add(a : FinanceriskmarginalMatrix, b : FinanceriskmarginalMatrix) -> FinanceriskmarginalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_risk_marginal_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_risk_marginal_matrix_scale(m : FinanceriskmarginalMatrix, s : Double) -> FinanceriskmarginalMatrix {
  let result = finance_risk_marginal_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_risk_marginal_matrix_multiply(a : FinanceriskmarginalMatrix, b : FinanceriskmarginalMatrix) -> FinanceriskmarginalMatrix {
  if a.cols != b.rows { return finance_risk_marginal_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_risk_marginal_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_risk_marginal_matrix_trace(m : FinanceriskmarginalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_risk_marginal_matrix_det(m : FinanceriskmarginalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_risk_marginal_matrix_norm(m : FinanceriskmarginalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_risk_marginal_matrix_to_string(m : FinanceriskmarginalMatrix) -> String {
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

pub(all) struct FinanceriskmarginalVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_marginal_make_vector(comps : Array[Double]) -> FinanceriskmarginalVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_marginal_vector_zero(dim : Int) -> FinanceriskmarginalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_risk_marginal_vector_add(a : FinanceriskmarginalVector, b : FinanceriskmarginalVector) -> FinanceriskmarginalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_marginal_vector_sub(a : FinanceriskmarginalVector, b : FinanceriskmarginalVector) -> FinanceriskmarginalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_marginal_vector_scale(v : FinanceriskmarginalVector, s : Double) -> FinanceriskmarginalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_risk_marginal_vector_dot(a : FinanceriskmarginalVector, b : FinanceriskmarginalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_risk_marginal_vector_norm(v : FinanceriskmarginalVector) -> Double { @_common.sqrt(finance_risk_marginal_vector_dot(v, v)) }

pub fn finance_risk_marginal_vector_normalize(v : FinanceriskmarginalVector) -> FinanceriskmarginalVector {
  let n = finance_risk_marginal_vector_norm(v)
  if n < 0.0000001 { v } else { finance_risk_marginal_vector_scale(v, 1.0 / n) }
}

pub fn finance_risk_marginal_vector_dist(a : FinanceriskmarginalVector, b : FinanceriskmarginalVector) -> Double {
  finance_risk_marginal_vector_norm(finance_risk_marginal_vector_sub(a, b))
}

pub fn finance_risk_marginal_vector_to_string(v : FinanceriskmarginalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_marginal_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_risk_marginal_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_risk_marginal_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_risk_marginal_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_risk_marginal_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_risk_marginal_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_risk_marginal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_risk_marginal_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_risk_marginal_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_risk_marginal_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_risk_marginal_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_risk_marginal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_risk_marginal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_risk_marginal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_risk_marginal_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_risk_marginal_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_risk_marginal_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_risk_marginal_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_risk_marginal_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_risk_marginal_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_risk_marginal_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_risk_marginal_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_risk_marginal_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_risk_marginal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_risk_marginal_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_risk_marginal_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_risk_marginal_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_risk_marginal_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_risk_marginal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceriskmarginalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_frame_make(size : Int) -> FinanceriskmarginalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_frame_len(s : FinanceriskmarginalFrame) -> Int { s.size }

pub fn finance_risk_marginal_frame_get(s : FinanceriskmarginalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_frame_set(s : FinanceriskmarginalFrame, i : Int, v : Double) -> FinanceriskmarginalFrame {
  let result = finance_risk_marginal_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_frame_sum(s : FinanceriskmarginalFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_marginal_frame_mean(s : FinanceriskmarginalFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_marginal_frame_sum(s) / s.size.to_double() }
}

pub fn finance_risk_marginal_frame_scale(s : FinanceriskmarginalFrame, f : Double) -> FinanceriskmarginalFrame {
  let result = finance_risk_marginal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_marginal_frame_add(a : FinanceriskmarginalFrame, b : FinanceriskmarginalFrame) -> FinanceriskmarginalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_marginal_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_marginal_frame_copy(s : FinanceriskmarginalFrame) -> FinanceriskmarginalFrame {
  let result = finance_risk_marginal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_marginal_frame_fill(s : FinanceriskmarginalFrame, v : Double) -> FinanceriskmarginalFrame {
  let result = finance_risk_marginal_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_frame_min(s : FinanceriskmarginalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_frame_max(s : FinanceriskmarginalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_frame_to_string(s : FinanceriskmarginalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_table_make(size : Int) -> FinanceriskmarginalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_table_len(s : FinanceriskmarginalTable) -> Int { s.size }

pub fn finance_risk_marginal_table_get(s : FinanceriskmarginalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_table_set(s : FinanceriskmarginalTable, i : Int, v : Double) -> FinanceriskmarginalTable {
  let result = finance_risk_marginal_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_table_sum(s : FinanceriskmarginalTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_marginal_table_mean(s : FinanceriskmarginalTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_marginal_table_sum(s) / s.size.to_double() }
}

pub fn finance_risk_marginal_table_scale(s : FinanceriskmarginalTable, f : Double) -> FinanceriskmarginalTable {
  let result = finance_risk_marginal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_marginal_table_add(a : FinanceriskmarginalTable, b : FinanceriskmarginalTable) -> FinanceriskmarginalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_marginal_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_marginal_table_copy(s : FinanceriskmarginalTable) -> FinanceriskmarginalTable {
  let result = finance_risk_marginal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_marginal_table_fill(s : FinanceriskmarginalTable, v : Double) -> FinanceriskmarginalTable {
  let result = finance_risk_marginal_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_table_min(s : FinanceriskmarginalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_table_max(s : FinanceriskmarginalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_table_to_string(s : FinanceriskmarginalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_graphn_make(size : Int) -> FinanceriskmarginalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_graphn_len(s : FinanceriskmarginalGraphN) -> Int { s.size }

pub fn finance_risk_marginal_graphn_get(s : FinanceriskmarginalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_graphn_set(s : FinanceriskmarginalGraphN, i : Int, v : Double) -> FinanceriskmarginalGraphN {
  let result = finance_risk_marginal_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_graphn_sum(s : FinanceriskmarginalGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_marginal_graphn_mean(s : FinanceriskmarginalGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_marginal_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_risk_marginal_graphn_scale(s : FinanceriskmarginalGraphN, f : Double) -> FinanceriskmarginalGraphN {
  let result = finance_risk_marginal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_marginal_graphn_add(a : FinanceriskmarginalGraphN, b : FinanceriskmarginalGraphN) -> FinanceriskmarginalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_marginal_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_marginal_graphn_copy(s : FinanceriskmarginalGraphN) -> FinanceriskmarginalGraphN {
  let result = finance_risk_marginal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_marginal_graphn_fill(s : FinanceriskmarginalGraphN, v : Double) -> FinanceriskmarginalGraphN {
  let result = finance_risk_marginal_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_graphn_min(s : FinanceriskmarginalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_graphn_max(s : FinanceriskmarginalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_graphn_to_string(s : FinanceriskmarginalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_node_make(size : Int) -> FinanceriskmarginalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_node_len(s : FinanceriskmarginalNode) -> Int { s.size }

pub fn finance_risk_marginal_node_get(s : FinanceriskmarginalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_node_set(s : FinanceriskmarginalNode, i : Int, v : Double) -> FinanceriskmarginalNode {
  let result = finance_risk_marginal_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_node_sum(s : FinanceriskmarginalNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_marginal_node_mean(s : FinanceriskmarginalNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_marginal_node_sum(s) / s.size.to_double() }
}

pub fn finance_risk_marginal_node_scale(s : FinanceriskmarginalNode, f : Double) -> FinanceriskmarginalNode {
  let result = finance_risk_marginal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_marginal_node_add(a : FinanceriskmarginalNode, b : FinanceriskmarginalNode) -> FinanceriskmarginalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_marginal_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_marginal_node_copy(s : FinanceriskmarginalNode) -> FinanceriskmarginalNode {
  let result = finance_risk_marginal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_marginal_node_fill(s : FinanceriskmarginalNode, v : Double) -> FinanceriskmarginalNode {
  let result = finance_risk_marginal_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_node_min(s : FinanceriskmarginalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_node_max(s : FinanceriskmarginalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_node_to_string(s : FinanceriskmarginalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_edge_make(size : Int) -> FinanceriskmarginalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_edge_len(s : FinanceriskmarginalEdge) -> Int { s.size }

pub fn finance_risk_marginal_edge_get(s : FinanceriskmarginalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_edge_set(s : FinanceriskmarginalEdge, i : Int, v : Double) -> FinanceriskmarginalEdge {
  let result = finance_risk_marginal_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_edge_sum(s : FinanceriskmarginalEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_marginal_edge_mean(s : FinanceriskmarginalEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_marginal_edge_sum(s) / s.size.to_double() }
}

pub fn finance_risk_marginal_edge_scale(s : FinanceriskmarginalEdge, f : Double) -> FinanceriskmarginalEdge {
  let result = finance_risk_marginal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_marginal_edge_add(a : FinanceriskmarginalEdge, b : FinanceriskmarginalEdge) -> FinanceriskmarginalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_marginal_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_marginal_edge_copy(s : FinanceriskmarginalEdge) -> FinanceriskmarginalEdge {
  let result = finance_risk_marginal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_marginal_edge_fill(s : FinanceriskmarginalEdge, v : Double) -> FinanceriskmarginalEdge {
  let result = finance_risk_marginal_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_edge_min(s : FinanceriskmarginalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_edge_max(s : FinanceriskmarginalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_edge_to_string(s : FinanceriskmarginalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_path_make(size : Int) -> FinanceriskmarginalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_path_len(s : FinanceriskmarginalPath) -> Int { s.size }

pub fn finance_risk_marginal_path_get(s : FinanceriskmarginalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_path_set(s : FinanceriskmarginalPath, i : Int, v : Double) -> FinanceriskmarginalPath {
  let result = finance_risk_marginal_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_path_sum(s : FinanceriskmarginalPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_marginal_path_mean(s : FinanceriskmarginalPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_marginal_path_sum(s) / s.size.to_double() }
}

pub fn finance_risk_marginal_path_scale(s : FinanceriskmarginalPath, f : Double) -> FinanceriskmarginalPath {
  let result = finance_risk_marginal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_marginal_path_add(a : FinanceriskmarginalPath, b : FinanceriskmarginalPath) -> FinanceriskmarginalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_marginal_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_marginal_path_copy(s : FinanceriskmarginalPath) -> FinanceriskmarginalPath {
  let result = finance_risk_marginal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_marginal_path_fill(s : FinanceriskmarginalPath, v : Double) -> FinanceriskmarginalPath {
  let result = finance_risk_marginal_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_path_min(s : FinanceriskmarginalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_path_max(s : FinanceriskmarginalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_path_to_string(s : FinanceriskmarginalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_cluster_make(size : Int) -> FinanceriskmarginalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_cluster_len(s : FinanceriskmarginalCluster) -> Int { s.size }

pub fn finance_risk_marginal_cluster_get(s : FinanceriskmarginalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_cluster_set(s : FinanceriskmarginalCluster, i : Int, v : Double) -> FinanceriskmarginalCluster {
  let result = finance_risk_marginal_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_cluster_sum(s : FinanceriskmarginalCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_marginal_cluster_mean(s : FinanceriskmarginalCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_marginal_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_risk_marginal_cluster_scale(s : FinanceriskmarginalCluster, f : Double) -> FinanceriskmarginalCluster {
  let result = finance_risk_marginal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_marginal_cluster_add(a : FinanceriskmarginalCluster, b : FinanceriskmarginalCluster) -> FinanceriskmarginalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_marginal_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_marginal_cluster_copy(s : FinanceriskmarginalCluster) -> FinanceriskmarginalCluster {
  let result = finance_risk_marginal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_marginal_cluster_fill(s : FinanceriskmarginalCluster, v : Double) -> FinanceriskmarginalCluster {
  let result = finance_risk_marginal_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_cluster_min(s : FinanceriskmarginalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_cluster_max(s : FinanceriskmarginalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_cluster_to_string(s : FinanceriskmarginalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_model_make(size : Int) -> FinanceriskmarginalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_model_len(s : FinanceriskmarginalModel) -> Int { s.size }

pub fn finance_risk_marginal_model_get(s : FinanceriskmarginalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_model_set(s : FinanceriskmarginalModel, i : Int, v : Double) -> FinanceriskmarginalModel {
  let result = finance_risk_marginal_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_model_sum(s : FinanceriskmarginalModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_marginal_model_mean(s : FinanceriskmarginalModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_marginal_model_sum(s) / s.size.to_double() }
}

pub fn finance_risk_marginal_model_scale(s : FinanceriskmarginalModel, f : Double) -> FinanceriskmarginalModel {
  let result = finance_risk_marginal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_marginal_model_add(a : FinanceriskmarginalModel, b : FinanceriskmarginalModel) -> FinanceriskmarginalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_marginal_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_marginal_model_copy(s : FinanceriskmarginalModel) -> FinanceriskmarginalModel {
  let result = finance_risk_marginal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_marginal_model_fill(s : FinanceriskmarginalModel, v : Double) -> FinanceriskmarginalModel {
  let result = finance_risk_marginal_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_model_min(s : FinanceriskmarginalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_model_max(s : FinanceriskmarginalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_model_to_string(s : FinanceriskmarginalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_layer_make(size : Int) -> FinanceriskmarginalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_layer_len(s : FinanceriskmarginalLayer) -> Int { s.size }

pub fn finance_risk_marginal_layer_get(s : FinanceriskmarginalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_layer_set(s : FinanceriskmarginalLayer, i : Int, v : Double) -> FinanceriskmarginalLayer {
  let result = finance_risk_marginal_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_layer_sum(s : FinanceriskmarginalLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_marginal_layer_mean(s : FinanceriskmarginalLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_marginal_layer_sum(s) / s.size.to_double() }
}

pub fn finance_risk_marginal_layer_scale(s : FinanceriskmarginalLayer, f : Double) -> FinanceriskmarginalLayer {
  let result = finance_risk_marginal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_marginal_layer_add(a : FinanceriskmarginalLayer, b : FinanceriskmarginalLayer) -> FinanceriskmarginalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_marginal_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_marginal_layer_copy(s : FinanceriskmarginalLayer) -> FinanceriskmarginalLayer {
  let result = finance_risk_marginal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_marginal_layer_fill(s : FinanceriskmarginalLayer, v : Double) -> FinanceriskmarginalLayer {
  let result = finance_risk_marginal_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_layer_min(s : FinanceriskmarginalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_layer_max(s : FinanceriskmarginalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_layer_to_string(s : FinanceriskmarginalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_buffer_make(size : Int) -> FinanceriskmarginalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_buffer_len(s : FinanceriskmarginalBuffer) -> Int { s.size }

pub fn finance_risk_marginal_buffer_get(s : FinanceriskmarginalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_buffer_set(s : FinanceriskmarginalBuffer, i : Int, v : Double) -> FinanceriskmarginalBuffer {
  let result = finance_risk_marginal_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_buffer_sum(s : FinanceriskmarginalBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_marginal_buffer_mean(s : FinanceriskmarginalBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_marginal_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_risk_marginal_buffer_scale(s : FinanceriskmarginalBuffer, f : Double) -> FinanceriskmarginalBuffer {
  let result = finance_risk_marginal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_marginal_buffer_add(a : FinanceriskmarginalBuffer, b : FinanceriskmarginalBuffer) -> FinanceriskmarginalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_marginal_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_marginal_buffer_copy(s : FinanceriskmarginalBuffer) -> FinanceriskmarginalBuffer {
  let result = finance_risk_marginal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_marginal_buffer_fill(s : FinanceriskmarginalBuffer, v : Double) -> FinanceriskmarginalBuffer {
  let result = finance_risk_marginal_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_buffer_min(s : FinanceriskmarginalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_buffer_max(s : FinanceriskmarginalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_buffer_to_string(s : FinanceriskmarginalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_cursor_make(size : Int) -> FinanceriskmarginalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_cursor_len(s : FinanceriskmarginalCursor) -> Int { s.size }

pub fn finance_risk_marginal_cursor_get(s : FinanceriskmarginalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_cursor_set(s : FinanceriskmarginalCursor, i : Int, v : Double) -> FinanceriskmarginalCursor {
  let result = finance_risk_marginal_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_cursor_sum(s : FinanceriskmarginalCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_marginal_cursor_mean(s : FinanceriskmarginalCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_marginal_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_risk_marginal_cursor_scale(s : FinanceriskmarginalCursor, f : Double) -> FinanceriskmarginalCursor {
  let result = finance_risk_marginal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_marginal_cursor_add(a : FinanceriskmarginalCursor, b : FinanceriskmarginalCursor) -> FinanceriskmarginalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_marginal_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_marginal_cursor_copy(s : FinanceriskmarginalCursor) -> FinanceriskmarginalCursor {
  let result = finance_risk_marginal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_marginal_cursor_fill(s : FinanceriskmarginalCursor, v : Double) -> FinanceriskmarginalCursor {
  let result = finance_risk_marginal_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_cursor_min(s : FinanceriskmarginalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_cursor_max(s : FinanceriskmarginalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_cursor_to_string(s : FinanceriskmarginalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_view_make(size : Int) -> FinanceriskmarginalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_view_len(s : FinanceriskmarginalView) -> Int { s.size }

pub fn finance_risk_marginal_view_get(s : FinanceriskmarginalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_view_set(s : FinanceriskmarginalView, i : Int, v : Double) -> FinanceriskmarginalView {
  let result = finance_risk_marginal_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_view_sum(s : FinanceriskmarginalView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_marginal_view_mean(s : FinanceriskmarginalView) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_marginal_view_sum(s) / s.size.to_double() }
}

pub fn finance_risk_marginal_view_scale(s : FinanceriskmarginalView, f : Double) -> FinanceriskmarginalView {
  let result = finance_risk_marginal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_marginal_view_add(a : FinanceriskmarginalView, b : FinanceriskmarginalView) -> FinanceriskmarginalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_marginal_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_marginal_view_copy(s : FinanceriskmarginalView) -> FinanceriskmarginalView {
  let result = finance_risk_marginal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_marginal_view_fill(s : FinanceriskmarginalView, v : Double) -> FinanceriskmarginalView {
  let result = finance_risk_marginal_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_view_min(s : FinanceriskmarginalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_view_max(s : FinanceriskmarginalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_view_to_string(s : FinanceriskmarginalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_range_make(size : Int) -> FinanceriskmarginalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_range_len(s : FinanceriskmarginalRange) -> Int { s.size }

pub fn finance_risk_marginal_range_get(s : FinanceriskmarginalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_range_set(s : FinanceriskmarginalRange, i : Int, v : Double) -> FinanceriskmarginalRange {
  let result = finance_risk_marginal_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_range_sum(s : FinanceriskmarginalRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_marginal_range_mean(s : FinanceriskmarginalRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_marginal_range_sum(s) / s.size.to_double() }
}

pub fn finance_risk_marginal_range_scale(s : FinanceriskmarginalRange, f : Double) -> FinanceriskmarginalRange {
  let result = finance_risk_marginal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_marginal_range_add(a : FinanceriskmarginalRange, b : FinanceriskmarginalRange) -> FinanceriskmarginalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_marginal_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_marginal_range_copy(s : FinanceriskmarginalRange) -> FinanceriskmarginalRange {
  let result = finance_risk_marginal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_marginal_range_fill(s : FinanceriskmarginalRange, v : Double) -> FinanceriskmarginalRange {
  let result = finance_risk_marginal_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_range_min(s : FinanceriskmarginalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_range_max(s : FinanceriskmarginalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_range_to_string(s : FinanceriskmarginalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskmarginalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_marginal_slice_make(size : Int) -> FinanceriskmarginalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_marginal_slice_len(s : FinanceriskmarginalSlice) -> Int { s.size }

pub fn finance_risk_marginal_slice_get(s : FinanceriskmarginalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_marginal_slice_set(s : FinanceriskmarginalSlice, i : Int, v : Double) -> FinanceriskmarginalSlice {
  let result = finance_risk_marginal_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_slice_sum(s : FinanceriskmarginalSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_marginal_slice_mean(s : FinanceriskmarginalSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_marginal_slice_sum(s) / s.size.to_double() }
}

pub fn finance_risk_marginal_slice_scale(s : FinanceriskmarginalSlice, f : Double) -> FinanceriskmarginalSlice {
  let result = finance_risk_marginal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_marginal_slice_add(a : FinanceriskmarginalSlice, b : FinanceriskmarginalSlice) -> FinanceriskmarginalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_marginal_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_marginal_slice_copy(s : FinanceriskmarginalSlice) -> FinanceriskmarginalSlice {
  let result = finance_risk_marginal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_marginal_slice_fill(s : FinanceriskmarginalSlice, v : Double) -> FinanceriskmarginalSlice {
  let result = finance_risk_marginal_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_marginal_slice_min(s : FinanceriskmarginalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_slice_max(s : FinanceriskmarginalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_marginal_slice_to_string(s : FinanceriskmarginalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

