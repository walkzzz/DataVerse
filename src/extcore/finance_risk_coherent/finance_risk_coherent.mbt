///===
/// extcore/finance_risk_coherent

pub(all) struct FinanceriskcoherentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_coherent_make_point(x : Double, y : Double) -> FinanceriskcoherentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_coherent_make_point3(x : Double, y : Double, z : Double) -> FinanceriskcoherentPoint {
  { x, y, z, label: 0 }
}

pub fn finance_risk_coherent_point_x(pt : FinanceriskcoherentPoint) -> Double { pt.x }

pub fn finance_risk_coherent_point_y(pt : FinanceriskcoherentPoint) -> Double { pt.y }

pub fn finance_risk_coherent_point_z(pt : FinanceriskcoherentPoint) -> Double { pt.z }

pub fn finance_risk_coherent_point_label(pt : FinanceriskcoherentPoint) -> Int { pt.label }

pub fn finance_risk_coherent_point_dist(a : FinanceriskcoherentPoint, b : FinanceriskcoherentPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_risk_coherent_point_add(a : FinanceriskcoherentPoint, b : FinanceriskcoherentPoint) -> FinanceriskcoherentPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_risk_coherent_point_sub(a : FinanceriskcoherentPoint, b : FinanceriskcoherentPoint) -> FinanceriskcoherentPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_risk_coherent_point_scale(pt : FinanceriskcoherentPoint, s : Double) -> FinanceriskcoherentPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_risk_coherent_point_dot(a : FinanceriskcoherentPoint, b : FinanceriskcoherentPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_risk_coherent_point_cross(a : FinanceriskcoherentPoint, b : FinanceriskcoherentPoint) -> FinanceriskcoherentPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_risk_coherent_point_norm(pt : FinanceriskcoherentPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_risk_coherent_point_normalize(pt : FinanceriskcoherentPoint) -> FinanceriskcoherentPoint {
  let n = finance_risk_coherent_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_risk_coherent_point_scale(pt, 1.0 / n) }
}

pub fn finance_risk_coherent_point_negate(pt : FinanceriskcoherentPoint) -> FinanceriskcoherentPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_risk_coherent_point_mid(a : FinanceriskcoherentPoint, b : FinanceriskcoherentPoint) -> FinanceriskcoherentPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_risk_coherent_point_lerp(a : FinanceriskcoherentPoint, b : FinanceriskcoherentPoint, t : Double) -> FinanceriskcoherentPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_risk_coherent_point_to_string(pt : FinanceriskcoherentPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceriskcoherentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_coherent_make_series(vals : Array[Double], name : String) -> FinanceriskcoherentSeries {
  { vals, name, meta: 0 }
}

pub fn finance_risk_coherent_series_len(s : FinanceriskcoherentSeries) -> Int { s.vals.length() }

pub fn finance_risk_coherent_series_sum(s : FinanceriskcoherentSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_risk_coherent_series_mean(s : FinanceriskcoherentSeries) -> Double {
  let n = finance_risk_coherent_series_len(s)
  if n == 0 { 0.0 } else { finance_risk_coherent_series_sum(s) / n.to_double() }
}

pub fn finance_risk_coherent_series_min(s : FinanceriskcoherentSeries) -> Double {
  let n = finance_risk_coherent_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_risk_coherent_series_max(s : FinanceriskcoherentSeries) -> Double {
  let n = finance_risk_coherent_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_risk_coherent_series_range(s : FinanceriskcoherentSeries) -> Double {
  finance_risk_coherent_series_max(s) - finance_risk_coherent_series_min(s)
}

pub fn finance_risk_coherent_series_var(s : FinanceriskcoherentSeries) -> Double {
  let n = finance_risk_coherent_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_risk_coherent_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_risk_coherent_series_std(s : FinanceriskcoherentSeries) -> Double { @_common.sqrt(finance_risk_coherent_series_var(s)) }

pub fn finance_risk_coherent_series_median(s : FinanceriskcoherentSeries) -> Double {
  let n = finance_risk_coherent_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_risk_coherent_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_risk_coherent_series_scale(s : FinanceriskcoherentSeries, f : Double) -> FinanceriskcoherentSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_risk_coherent_series_add(a : FinanceriskcoherentSeries, b : FinanceriskcoherentSeries) -> FinanceriskcoherentSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_risk_coherent_series_sub(a : FinanceriskcoherentSeries, b : FinanceriskcoherentSeries) -> FinanceriskcoherentSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_risk_coherent_series_normalize(s : FinanceriskcoherentSeries) -> FinanceriskcoherentSeries {
  let mn = finance_risk_coherent_series_min(s)
  let mx = finance_risk_coherent_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_risk_coherent_series_cumsum(s : FinanceriskcoherentSeries) -> FinanceriskcoherentSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_risk_coherent_series_to_string(s : FinanceriskcoherentSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskcoherentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_coherent_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskcoherentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_coherent_matrix_identity(n : Int) -> FinanceriskcoherentMatrix {
  let m = finance_risk_coherent_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_risk_coherent_matrix_get(m : FinanceriskcoherentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_risk_coherent_matrix_transpose(m : FinanceriskcoherentMatrix) -> FinanceriskcoherentMatrix {
  let result = finance_risk_coherent_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_risk_coherent_matrix_add(a : FinanceriskcoherentMatrix, b : FinanceriskcoherentMatrix) -> FinanceriskcoherentMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_risk_coherent_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_risk_coherent_matrix_scale(m : FinanceriskcoherentMatrix, s : Double) -> FinanceriskcoherentMatrix {
  let result = finance_risk_coherent_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_risk_coherent_matrix_multiply(a : FinanceriskcoherentMatrix, b : FinanceriskcoherentMatrix) -> FinanceriskcoherentMatrix {
  if a.cols != b.rows { return finance_risk_coherent_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_risk_coherent_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_risk_coherent_matrix_trace(m : FinanceriskcoherentMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_risk_coherent_matrix_det(m : FinanceriskcoherentMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_risk_coherent_matrix_norm(m : FinanceriskcoherentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_risk_coherent_matrix_to_string(m : FinanceriskcoherentMatrix) -> String {
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

pub(all) struct FinanceriskcoherentVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_coherent_make_vector(comps : Array[Double]) -> FinanceriskcoherentVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_coherent_vector_zero(dim : Int) -> FinanceriskcoherentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_risk_coherent_vector_add(a : FinanceriskcoherentVector, b : FinanceriskcoherentVector) -> FinanceriskcoherentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_coherent_vector_sub(a : FinanceriskcoherentVector, b : FinanceriskcoherentVector) -> FinanceriskcoherentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_coherent_vector_scale(v : FinanceriskcoherentVector, s : Double) -> FinanceriskcoherentVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_risk_coherent_vector_dot(a : FinanceriskcoherentVector, b : FinanceriskcoherentVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_risk_coherent_vector_norm(v : FinanceriskcoherentVector) -> Double { @_common.sqrt(finance_risk_coherent_vector_dot(v, v)) }

pub fn finance_risk_coherent_vector_normalize(v : FinanceriskcoherentVector) -> FinanceriskcoherentVector {
  let n = finance_risk_coherent_vector_norm(v)
  if n < 0.0000001 { v } else { finance_risk_coherent_vector_scale(v, 1.0 / n) }
}

pub fn finance_risk_coherent_vector_dist(a : FinanceriskcoherentVector, b : FinanceriskcoherentVector) -> Double {
  finance_risk_coherent_vector_norm(finance_risk_coherent_vector_sub(a, b))
}

pub fn finance_risk_coherent_vector_to_string(v : FinanceriskcoherentVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_coherent_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_risk_coherent_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_risk_coherent_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_risk_coherent_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_risk_coherent_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_risk_coherent_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_risk_coherent_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_risk_coherent_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_risk_coherent_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_risk_coherent_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_risk_coherent_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_risk_coherent_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_risk_coherent_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_risk_coherent_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_risk_coherent_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_risk_coherent_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_risk_coherent_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_risk_coherent_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_risk_coherent_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_risk_coherent_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_risk_coherent_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_risk_coherent_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_risk_coherent_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_risk_coherent_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_risk_coherent_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_risk_coherent_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_risk_coherent_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_risk_coherent_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_risk_coherent_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceriskcoherentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_frame_make(size : Int) -> FinanceriskcoherentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_frame_len(s : FinanceriskcoherentFrame) -> Int { s.size }

pub fn finance_risk_coherent_frame_get(s : FinanceriskcoherentFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_frame_set(s : FinanceriskcoherentFrame, i : Int, v : Double) -> FinanceriskcoherentFrame {
  let result = finance_risk_coherent_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_frame_sum(s : FinanceriskcoherentFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_coherent_frame_mean(s : FinanceriskcoherentFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_coherent_frame_sum(s) / s.size.to_double() }
}

pub fn finance_risk_coherent_frame_scale(s : FinanceriskcoherentFrame, f : Double) -> FinanceriskcoherentFrame {
  let result = finance_risk_coherent_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_coherent_frame_add(a : FinanceriskcoherentFrame, b : FinanceriskcoherentFrame) -> FinanceriskcoherentFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_coherent_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_coherent_frame_copy(s : FinanceriskcoherentFrame) -> FinanceriskcoherentFrame {
  let result = finance_risk_coherent_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_coherent_frame_fill(s : FinanceriskcoherentFrame, v : Double) -> FinanceriskcoherentFrame {
  let result = finance_risk_coherent_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_frame_min(s : FinanceriskcoherentFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_frame_max(s : FinanceriskcoherentFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_frame_to_string(s : FinanceriskcoherentFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_table_make(size : Int) -> FinanceriskcoherentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_table_len(s : FinanceriskcoherentTable) -> Int { s.size }

pub fn finance_risk_coherent_table_get(s : FinanceriskcoherentTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_table_set(s : FinanceriskcoherentTable, i : Int, v : Double) -> FinanceriskcoherentTable {
  let result = finance_risk_coherent_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_table_sum(s : FinanceriskcoherentTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_coherent_table_mean(s : FinanceriskcoherentTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_coherent_table_sum(s) / s.size.to_double() }
}

pub fn finance_risk_coherent_table_scale(s : FinanceriskcoherentTable, f : Double) -> FinanceriskcoherentTable {
  let result = finance_risk_coherent_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_coherent_table_add(a : FinanceriskcoherentTable, b : FinanceriskcoherentTable) -> FinanceriskcoherentTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_coherent_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_coherent_table_copy(s : FinanceriskcoherentTable) -> FinanceriskcoherentTable {
  let result = finance_risk_coherent_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_coherent_table_fill(s : FinanceriskcoherentTable, v : Double) -> FinanceriskcoherentTable {
  let result = finance_risk_coherent_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_table_min(s : FinanceriskcoherentTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_table_max(s : FinanceriskcoherentTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_table_to_string(s : FinanceriskcoherentTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_graphn_make(size : Int) -> FinanceriskcoherentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_graphn_len(s : FinanceriskcoherentGraphN) -> Int { s.size }

pub fn finance_risk_coherent_graphn_get(s : FinanceriskcoherentGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_graphn_set(s : FinanceriskcoherentGraphN, i : Int, v : Double) -> FinanceriskcoherentGraphN {
  let result = finance_risk_coherent_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_graphn_sum(s : FinanceriskcoherentGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_coherent_graphn_mean(s : FinanceriskcoherentGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_coherent_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_risk_coherent_graphn_scale(s : FinanceriskcoherentGraphN, f : Double) -> FinanceriskcoherentGraphN {
  let result = finance_risk_coherent_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_coherent_graphn_add(a : FinanceriskcoherentGraphN, b : FinanceriskcoherentGraphN) -> FinanceriskcoherentGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_coherent_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_coherent_graphn_copy(s : FinanceriskcoherentGraphN) -> FinanceriskcoherentGraphN {
  let result = finance_risk_coherent_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_coherent_graphn_fill(s : FinanceriskcoherentGraphN, v : Double) -> FinanceriskcoherentGraphN {
  let result = finance_risk_coherent_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_graphn_min(s : FinanceriskcoherentGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_graphn_max(s : FinanceriskcoherentGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_graphn_to_string(s : FinanceriskcoherentGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_node_make(size : Int) -> FinanceriskcoherentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_node_len(s : FinanceriskcoherentNode) -> Int { s.size }

pub fn finance_risk_coherent_node_get(s : FinanceriskcoherentNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_node_set(s : FinanceriskcoherentNode, i : Int, v : Double) -> FinanceriskcoherentNode {
  let result = finance_risk_coherent_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_node_sum(s : FinanceriskcoherentNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_coherent_node_mean(s : FinanceriskcoherentNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_coherent_node_sum(s) / s.size.to_double() }
}

pub fn finance_risk_coherent_node_scale(s : FinanceriskcoherentNode, f : Double) -> FinanceriskcoherentNode {
  let result = finance_risk_coherent_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_coherent_node_add(a : FinanceriskcoherentNode, b : FinanceriskcoherentNode) -> FinanceriskcoherentNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_coherent_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_coherent_node_copy(s : FinanceriskcoherentNode) -> FinanceriskcoherentNode {
  let result = finance_risk_coherent_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_coherent_node_fill(s : FinanceriskcoherentNode, v : Double) -> FinanceriskcoherentNode {
  let result = finance_risk_coherent_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_node_min(s : FinanceriskcoherentNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_node_max(s : FinanceriskcoherentNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_node_to_string(s : FinanceriskcoherentNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_edge_make(size : Int) -> FinanceriskcoherentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_edge_len(s : FinanceriskcoherentEdge) -> Int { s.size }

pub fn finance_risk_coherent_edge_get(s : FinanceriskcoherentEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_edge_set(s : FinanceriskcoherentEdge, i : Int, v : Double) -> FinanceriskcoherentEdge {
  let result = finance_risk_coherent_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_edge_sum(s : FinanceriskcoherentEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_coherent_edge_mean(s : FinanceriskcoherentEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_coherent_edge_sum(s) / s.size.to_double() }
}

pub fn finance_risk_coherent_edge_scale(s : FinanceriskcoherentEdge, f : Double) -> FinanceriskcoherentEdge {
  let result = finance_risk_coherent_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_coherent_edge_add(a : FinanceriskcoherentEdge, b : FinanceriskcoherentEdge) -> FinanceriskcoherentEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_coherent_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_coherent_edge_copy(s : FinanceriskcoherentEdge) -> FinanceriskcoherentEdge {
  let result = finance_risk_coherent_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_coherent_edge_fill(s : FinanceriskcoherentEdge, v : Double) -> FinanceriskcoherentEdge {
  let result = finance_risk_coherent_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_edge_min(s : FinanceriskcoherentEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_edge_max(s : FinanceriskcoherentEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_edge_to_string(s : FinanceriskcoherentEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_path_make(size : Int) -> FinanceriskcoherentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_path_len(s : FinanceriskcoherentPath) -> Int { s.size }

pub fn finance_risk_coherent_path_get(s : FinanceriskcoherentPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_path_set(s : FinanceriskcoherentPath, i : Int, v : Double) -> FinanceriskcoherentPath {
  let result = finance_risk_coherent_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_path_sum(s : FinanceriskcoherentPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_coherent_path_mean(s : FinanceriskcoherentPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_coherent_path_sum(s) / s.size.to_double() }
}

pub fn finance_risk_coherent_path_scale(s : FinanceriskcoherentPath, f : Double) -> FinanceriskcoherentPath {
  let result = finance_risk_coherent_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_coherent_path_add(a : FinanceriskcoherentPath, b : FinanceriskcoherentPath) -> FinanceriskcoherentPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_coherent_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_coherent_path_copy(s : FinanceriskcoherentPath) -> FinanceriskcoherentPath {
  let result = finance_risk_coherent_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_coherent_path_fill(s : FinanceriskcoherentPath, v : Double) -> FinanceriskcoherentPath {
  let result = finance_risk_coherent_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_path_min(s : FinanceriskcoherentPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_path_max(s : FinanceriskcoherentPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_path_to_string(s : FinanceriskcoherentPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_cluster_make(size : Int) -> FinanceriskcoherentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_cluster_len(s : FinanceriskcoherentCluster) -> Int { s.size }

pub fn finance_risk_coherent_cluster_get(s : FinanceriskcoherentCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_cluster_set(s : FinanceriskcoherentCluster, i : Int, v : Double) -> FinanceriskcoherentCluster {
  let result = finance_risk_coherent_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_cluster_sum(s : FinanceriskcoherentCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_coherent_cluster_mean(s : FinanceriskcoherentCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_coherent_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_risk_coherent_cluster_scale(s : FinanceriskcoherentCluster, f : Double) -> FinanceriskcoherentCluster {
  let result = finance_risk_coherent_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_coherent_cluster_add(a : FinanceriskcoherentCluster, b : FinanceriskcoherentCluster) -> FinanceriskcoherentCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_coherent_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_coherent_cluster_copy(s : FinanceriskcoherentCluster) -> FinanceriskcoherentCluster {
  let result = finance_risk_coherent_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_coherent_cluster_fill(s : FinanceriskcoherentCluster, v : Double) -> FinanceriskcoherentCluster {
  let result = finance_risk_coherent_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_cluster_min(s : FinanceriskcoherentCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_cluster_max(s : FinanceriskcoherentCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_cluster_to_string(s : FinanceriskcoherentCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_model_make(size : Int) -> FinanceriskcoherentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_model_len(s : FinanceriskcoherentModel) -> Int { s.size }

pub fn finance_risk_coherent_model_get(s : FinanceriskcoherentModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_model_set(s : FinanceriskcoherentModel, i : Int, v : Double) -> FinanceriskcoherentModel {
  let result = finance_risk_coherent_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_model_sum(s : FinanceriskcoherentModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_coherent_model_mean(s : FinanceriskcoherentModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_coherent_model_sum(s) / s.size.to_double() }
}

pub fn finance_risk_coherent_model_scale(s : FinanceriskcoherentModel, f : Double) -> FinanceriskcoherentModel {
  let result = finance_risk_coherent_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_coherent_model_add(a : FinanceriskcoherentModel, b : FinanceriskcoherentModel) -> FinanceriskcoherentModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_coherent_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_coherent_model_copy(s : FinanceriskcoherentModel) -> FinanceriskcoherentModel {
  let result = finance_risk_coherent_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_coherent_model_fill(s : FinanceriskcoherentModel, v : Double) -> FinanceriskcoherentModel {
  let result = finance_risk_coherent_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_model_min(s : FinanceriskcoherentModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_model_max(s : FinanceriskcoherentModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_model_to_string(s : FinanceriskcoherentModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_layer_make(size : Int) -> FinanceriskcoherentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_layer_len(s : FinanceriskcoherentLayer) -> Int { s.size }

pub fn finance_risk_coherent_layer_get(s : FinanceriskcoherentLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_layer_set(s : FinanceriskcoherentLayer, i : Int, v : Double) -> FinanceriskcoherentLayer {
  let result = finance_risk_coherent_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_layer_sum(s : FinanceriskcoherentLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_coherent_layer_mean(s : FinanceriskcoherentLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_coherent_layer_sum(s) / s.size.to_double() }
}

pub fn finance_risk_coherent_layer_scale(s : FinanceriskcoherentLayer, f : Double) -> FinanceriskcoherentLayer {
  let result = finance_risk_coherent_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_coherent_layer_add(a : FinanceriskcoherentLayer, b : FinanceriskcoherentLayer) -> FinanceriskcoherentLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_coherent_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_coherent_layer_copy(s : FinanceriskcoherentLayer) -> FinanceriskcoherentLayer {
  let result = finance_risk_coherent_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_coherent_layer_fill(s : FinanceriskcoherentLayer, v : Double) -> FinanceriskcoherentLayer {
  let result = finance_risk_coherent_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_layer_min(s : FinanceriskcoherentLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_layer_max(s : FinanceriskcoherentLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_layer_to_string(s : FinanceriskcoherentLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_buffer_make(size : Int) -> FinanceriskcoherentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_buffer_len(s : FinanceriskcoherentBuffer) -> Int { s.size }

pub fn finance_risk_coherent_buffer_get(s : FinanceriskcoherentBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_buffer_set(s : FinanceriskcoherentBuffer, i : Int, v : Double) -> FinanceriskcoherentBuffer {
  let result = finance_risk_coherent_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_buffer_sum(s : FinanceriskcoherentBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_coherent_buffer_mean(s : FinanceriskcoherentBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_coherent_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_risk_coherent_buffer_scale(s : FinanceriskcoherentBuffer, f : Double) -> FinanceriskcoherentBuffer {
  let result = finance_risk_coherent_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_coherent_buffer_add(a : FinanceriskcoherentBuffer, b : FinanceriskcoherentBuffer) -> FinanceriskcoherentBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_coherent_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_coherent_buffer_copy(s : FinanceriskcoherentBuffer) -> FinanceriskcoherentBuffer {
  let result = finance_risk_coherent_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_coherent_buffer_fill(s : FinanceriskcoherentBuffer, v : Double) -> FinanceriskcoherentBuffer {
  let result = finance_risk_coherent_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_buffer_min(s : FinanceriskcoherentBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_buffer_max(s : FinanceriskcoherentBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_buffer_to_string(s : FinanceriskcoherentBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_cursor_make(size : Int) -> FinanceriskcoherentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_cursor_len(s : FinanceriskcoherentCursor) -> Int { s.size }

pub fn finance_risk_coherent_cursor_get(s : FinanceriskcoherentCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_cursor_set(s : FinanceriskcoherentCursor, i : Int, v : Double) -> FinanceriskcoherentCursor {
  let result = finance_risk_coherent_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_cursor_sum(s : FinanceriskcoherentCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_coherent_cursor_mean(s : FinanceriskcoherentCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_coherent_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_risk_coherent_cursor_scale(s : FinanceriskcoherentCursor, f : Double) -> FinanceriskcoherentCursor {
  let result = finance_risk_coherent_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_coherent_cursor_add(a : FinanceriskcoherentCursor, b : FinanceriskcoherentCursor) -> FinanceriskcoherentCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_coherent_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_coherent_cursor_copy(s : FinanceriskcoherentCursor) -> FinanceriskcoherentCursor {
  let result = finance_risk_coherent_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_coherent_cursor_fill(s : FinanceriskcoherentCursor, v : Double) -> FinanceriskcoherentCursor {
  let result = finance_risk_coherent_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_cursor_min(s : FinanceriskcoherentCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_cursor_max(s : FinanceriskcoherentCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_cursor_to_string(s : FinanceriskcoherentCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_view_make(size : Int) -> FinanceriskcoherentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_view_len(s : FinanceriskcoherentView) -> Int { s.size }

pub fn finance_risk_coherent_view_get(s : FinanceriskcoherentView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_view_set(s : FinanceriskcoherentView, i : Int, v : Double) -> FinanceriskcoherentView {
  let result = finance_risk_coherent_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_view_sum(s : FinanceriskcoherentView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_coherent_view_mean(s : FinanceriskcoherentView) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_coherent_view_sum(s) / s.size.to_double() }
}

pub fn finance_risk_coherent_view_scale(s : FinanceriskcoherentView, f : Double) -> FinanceriskcoherentView {
  let result = finance_risk_coherent_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_coherent_view_add(a : FinanceriskcoherentView, b : FinanceriskcoherentView) -> FinanceriskcoherentView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_coherent_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_coherent_view_copy(s : FinanceriskcoherentView) -> FinanceriskcoherentView {
  let result = finance_risk_coherent_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_coherent_view_fill(s : FinanceriskcoherentView, v : Double) -> FinanceriskcoherentView {
  let result = finance_risk_coherent_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_view_min(s : FinanceriskcoherentView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_view_max(s : FinanceriskcoherentView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_view_to_string(s : FinanceriskcoherentView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_range_make(size : Int) -> FinanceriskcoherentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_range_len(s : FinanceriskcoherentRange) -> Int { s.size }

pub fn finance_risk_coherent_range_get(s : FinanceriskcoherentRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_range_set(s : FinanceriskcoherentRange, i : Int, v : Double) -> FinanceriskcoherentRange {
  let result = finance_risk_coherent_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_range_sum(s : FinanceriskcoherentRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_coherent_range_mean(s : FinanceriskcoherentRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_coherent_range_sum(s) / s.size.to_double() }
}

pub fn finance_risk_coherent_range_scale(s : FinanceriskcoherentRange, f : Double) -> FinanceriskcoherentRange {
  let result = finance_risk_coherent_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_coherent_range_add(a : FinanceriskcoherentRange, b : FinanceriskcoherentRange) -> FinanceriskcoherentRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_coherent_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_coherent_range_copy(s : FinanceriskcoherentRange) -> FinanceriskcoherentRange {
  let result = finance_risk_coherent_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_coherent_range_fill(s : FinanceriskcoherentRange, v : Double) -> FinanceriskcoherentRange {
  let result = finance_risk_coherent_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_range_min(s : FinanceriskcoherentRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_range_max(s : FinanceriskcoherentRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_range_to_string(s : FinanceriskcoherentRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcoherentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_coherent_slice_make(size : Int) -> FinanceriskcoherentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_coherent_slice_len(s : FinanceriskcoherentSlice) -> Int { s.size }

pub fn finance_risk_coherent_slice_get(s : FinanceriskcoherentSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_coherent_slice_set(s : FinanceriskcoherentSlice, i : Int, v : Double) -> FinanceriskcoherentSlice {
  let result = finance_risk_coherent_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_slice_sum(s : FinanceriskcoherentSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_coherent_slice_mean(s : FinanceriskcoherentSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_coherent_slice_sum(s) / s.size.to_double() }
}

pub fn finance_risk_coherent_slice_scale(s : FinanceriskcoherentSlice, f : Double) -> FinanceriskcoherentSlice {
  let result = finance_risk_coherent_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_coherent_slice_add(a : FinanceriskcoherentSlice, b : FinanceriskcoherentSlice) -> FinanceriskcoherentSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_coherent_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_coherent_slice_copy(s : FinanceriskcoherentSlice) -> FinanceriskcoherentSlice {
  let result = finance_risk_coherent_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_coherent_slice_fill(s : FinanceriskcoherentSlice, v : Double) -> FinanceriskcoherentSlice {
  let result = finance_risk_coherent_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_coherent_slice_min(s : FinanceriskcoherentSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_slice_max(s : FinanceriskcoherentSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_coherent_slice_to_string(s : FinanceriskcoherentSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

