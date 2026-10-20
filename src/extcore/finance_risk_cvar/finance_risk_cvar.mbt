///===
/// extcore/finance_risk_cvar

pub(all) struct FinanceriskcvarPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_cvar_make_point(x : Double, y : Double) -> FinanceriskcvarPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_cvar_make_point3(x : Double, y : Double, z : Double) -> FinanceriskcvarPoint {
  { x, y, z, label: 0 }
}

pub fn finance_risk_cvar_point_x(pt : FinanceriskcvarPoint) -> Double { pt.x }

pub fn finance_risk_cvar_point_y(pt : FinanceriskcvarPoint) -> Double { pt.y }

pub fn finance_risk_cvar_point_z(pt : FinanceriskcvarPoint) -> Double { pt.z }

pub fn finance_risk_cvar_point_label(pt : FinanceriskcvarPoint) -> Int { pt.label }

pub fn finance_risk_cvar_point_dist(a : FinanceriskcvarPoint, b : FinanceriskcvarPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_risk_cvar_point_add(a : FinanceriskcvarPoint, b : FinanceriskcvarPoint) -> FinanceriskcvarPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_risk_cvar_point_sub(a : FinanceriskcvarPoint, b : FinanceriskcvarPoint) -> FinanceriskcvarPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_risk_cvar_point_scale(pt : FinanceriskcvarPoint, s : Double) -> FinanceriskcvarPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_risk_cvar_point_dot(a : FinanceriskcvarPoint, b : FinanceriskcvarPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_risk_cvar_point_cross(a : FinanceriskcvarPoint, b : FinanceriskcvarPoint) -> FinanceriskcvarPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_risk_cvar_point_norm(pt : FinanceriskcvarPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_risk_cvar_point_normalize(pt : FinanceriskcvarPoint) -> FinanceriskcvarPoint {
  let n = finance_risk_cvar_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_risk_cvar_point_scale(pt, 1.0 / n) }
}

pub fn finance_risk_cvar_point_negate(pt : FinanceriskcvarPoint) -> FinanceriskcvarPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_risk_cvar_point_mid(a : FinanceriskcvarPoint, b : FinanceriskcvarPoint) -> FinanceriskcvarPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_risk_cvar_point_lerp(a : FinanceriskcvarPoint, b : FinanceriskcvarPoint, t : Double) -> FinanceriskcvarPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_risk_cvar_point_to_string(pt : FinanceriskcvarPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceriskcvarSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_cvar_make_series(vals : Array[Double], name : String) -> FinanceriskcvarSeries {
  { vals, name, meta: 0 }
}

pub fn finance_risk_cvar_series_len(s : FinanceriskcvarSeries) -> Int { s.vals.length() }

pub fn finance_risk_cvar_series_sum(s : FinanceriskcvarSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_risk_cvar_series_mean(s : FinanceriskcvarSeries) -> Double { @_common.mean(s.vals) }

pub fn finance_risk_cvar_series_min(s : FinanceriskcvarSeries) -> Double { @_common.min(s.vals) }

pub fn finance_risk_cvar_series_max(s : FinanceriskcvarSeries) -> Double { @_common.max(s.vals) }

pub fn finance_risk_cvar_series_range(s : FinanceriskcvarSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn finance_risk_cvar_series_var(s : FinanceriskcvarSeries) -> Double { @_common.variance(s.vals) }

pub fn finance_risk_cvar_series_std(s : FinanceriskcvarSeries) -> Double { @_common.std(s.vals) }

pub fn finance_risk_cvar_series_median(s : FinanceriskcvarSeries) -> Double { @_common.median(s.vals) }

pub fn finance_risk_cvar_series_scale(s : FinanceriskcvarSeries, f : Double) -> FinanceriskcvarSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_risk_cvar_series_add(a : FinanceriskcvarSeries, b : FinanceriskcvarSeries) -> FinanceriskcvarSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_risk_cvar_series_sub(a : FinanceriskcvarSeries, b : FinanceriskcvarSeries) -> FinanceriskcvarSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_risk_cvar_series_normalize(s : FinanceriskcvarSeries) -> FinanceriskcvarSeries {
  let mn = finance_risk_cvar_series_min(s)
  let mx = finance_risk_cvar_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_risk_cvar_series_cumsum(s : FinanceriskcvarSeries) -> FinanceriskcvarSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_risk_cvar_series_to_string(s : FinanceriskcvarSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskcvarMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_cvar_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskcvarMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_cvar_matrix_identity(n : Int) -> FinanceriskcvarMatrix {
  let m = finance_risk_cvar_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_risk_cvar_matrix_get(m : FinanceriskcvarMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_risk_cvar_matrix_transpose(m : FinanceriskcvarMatrix) -> FinanceriskcvarMatrix {
  let result = finance_risk_cvar_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_risk_cvar_matrix_add(a : FinanceriskcvarMatrix, b : FinanceriskcvarMatrix) -> FinanceriskcvarMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_risk_cvar_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_risk_cvar_matrix_scale(m : FinanceriskcvarMatrix, s : Double) -> FinanceriskcvarMatrix {
  let result = finance_risk_cvar_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_risk_cvar_matrix_multiply(a : FinanceriskcvarMatrix, b : FinanceriskcvarMatrix) -> FinanceriskcvarMatrix {
  if a.cols != b.rows { return finance_risk_cvar_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_risk_cvar_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_risk_cvar_matrix_trace(m : FinanceriskcvarMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_risk_cvar_matrix_det(m : FinanceriskcvarMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_risk_cvar_matrix_norm(m : FinanceriskcvarMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_risk_cvar_matrix_to_string(m : FinanceriskcvarMatrix) -> String {
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

pub(all) struct FinanceriskcvarVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_cvar_make_vector(comps : Array[Double]) -> FinanceriskcvarVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_cvar_vector_zero(dim : Int) -> FinanceriskcvarVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_risk_cvar_vector_add(a : FinanceriskcvarVector, b : FinanceriskcvarVector) -> FinanceriskcvarVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_cvar_vector_sub(a : FinanceriskcvarVector, b : FinanceriskcvarVector) -> FinanceriskcvarVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_cvar_vector_scale(v : FinanceriskcvarVector, s : Double) -> FinanceriskcvarVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_risk_cvar_vector_dot(a : FinanceriskcvarVector, b : FinanceriskcvarVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_risk_cvar_vector_norm(v : FinanceriskcvarVector) -> Double { @_common.sqrt(finance_risk_cvar_vector_dot(v, v)) }

pub fn finance_risk_cvar_vector_normalize(v : FinanceriskcvarVector) -> FinanceriskcvarVector {
  let n = finance_risk_cvar_vector_norm(v)
  if n < 0.0000001 { v } else { finance_risk_cvar_vector_scale(v, 1.0 / n) }
}

pub fn finance_risk_cvar_vector_dist(a : FinanceriskcvarVector, b : FinanceriskcvarVector) -> Double {
  finance_risk_cvar_vector_norm(finance_risk_cvar_vector_sub(a, b))
}

pub fn finance_risk_cvar_vector_to_string(v : FinanceriskcvarVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_cvar_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_risk_cvar_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_risk_cvar_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_risk_cvar_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_risk_cvar_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_risk_cvar_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_risk_cvar_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_risk_cvar_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_risk_cvar_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_risk_cvar_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_risk_cvar_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_risk_cvar_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_risk_cvar_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_risk_cvar_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_risk_cvar_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_risk_cvar_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_risk_cvar_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_risk_cvar_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_risk_cvar_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_risk_cvar_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_risk_cvar_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_risk_cvar_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_risk_cvar_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_risk_cvar_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_risk_cvar_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_risk_cvar_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_risk_cvar_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_risk_cvar_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_risk_cvar_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceriskcvarFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_frame_make(size : Int) -> FinanceriskcvarFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_frame_len(s : FinanceriskcvarFrame) -> Int { s.size }

pub fn finance_risk_cvar_frame_get(s : FinanceriskcvarFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_frame_set(s : FinanceriskcvarFrame, i : Int, v : Double) -> FinanceriskcvarFrame {
  let result = finance_risk_cvar_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_frame_sum(s : FinanceriskcvarFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_cvar_frame_mean(s : FinanceriskcvarFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_cvar_frame_sum(s) / s.size.to_double() }
}

pub fn finance_risk_cvar_frame_scale(s : FinanceriskcvarFrame, f : Double) -> FinanceriskcvarFrame {
  let result = finance_risk_cvar_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_cvar_frame_add(a : FinanceriskcvarFrame, b : FinanceriskcvarFrame) -> FinanceriskcvarFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_cvar_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_cvar_frame_copy(s : FinanceriskcvarFrame) -> FinanceriskcvarFrame {
  let result = finance_risk_cvar_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_cvar_frame_fill(s : FinanceriskcvarFrame, v : Double) -> FinanceriskcvarFrame {
  let result = finance_risk_cvar_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_frame_min(s : FinanceriskcvarFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_frame_max(s : FinanceriskcvarFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_frame_to_string(s : FinanceriskcvarFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_table_make(size : Int) -> FinanceriskcvarTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_table_len(s : FinanceriskcvarTable) -> Int { s.size }

pub fn finance_risk_cvar_table_get(s : FinanceriskcvarTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_table_set(s : FinanceriskcvarTable, i : Int, v : Double) -> FinanceriskcvarTable {
  let result = finance_risk_cvar_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_table_sum(s : FinanceriskcvarTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_cvar_table_mean(s : FinanceriskcvarTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_cvar_table_sum(s) / s.size.to_double() }
}

pub fn finance_risk_cvar_table_scale(s : FinanceriskcvarTable, f : Double) -> FinanceriskcvarTable {
  let result = finance_risk_cvar_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_cvar_table_add(a : FinanceriskcvarTable, b : FinanceriskcvarTable) -> FinanceriskcvarTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_cvar_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_cvar_table_copy(s : FinanceriskcvarTable) -> FinanceriskcvarTable {
  let result = finance_risk_cvar_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_cvar_table_fill(s : FinanceriskcvarTable, v : Double) -> FinanceriskcvarTable {
  let result = finance_risk_cvar_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_table_min(s : FinanceriskcvarTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_table_max(s : FinanceriskcvarTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_table_to_string(s : FinanceriskcvarTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_graphn_make(size : Int) -> FinanceriskcvarGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_graphn_len(s : FinanceriskcvarGraphN) -> Int { s.size }

pub fn finance_risk_cvar_graphn_get(s : FinanceriskcvarGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_graphn_set(s : FinanceriskcvarGraphN, i : Int, v : Double) -> FinanceriskcvarGraphN {
  let result = finance_risk_cvar_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_graphn_sum(s : FinanceriskcvarGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_cvar_graphn_mean(s : FinanceriskcvarGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_cvar_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_risk_cvar_graphn_scale(s : FinanceriskcvarGraphN, f : Double) -> FinanceriskcvarGraphN {
  let result = finance_risk_cvar_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_cvar_graphn_add(a : FinanceriskcvarGraphN, b : FinanceriskcvarGraphN) -> FinanceriskcvarGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_cvar_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_cvar_graphn_copy(s : FinanceriskcvarGraphN) -> FinanceriskcvarGraphN {
  let result = finance_risk_cvar_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_cvar_graphn_fill(s : FinanceriskcvarGraphN, v : Double) -> FinanceriskcvarGraphN {
  let result = finance_risk_cvar_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_graphn_min(s : FinanceriskcvarGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_graphn_max(s : FinanceriskcvarGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_graphn_to_string(s : FinanceriskcvarGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_node_make(size : Int) -> FinanceriskcvarNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_node_len(s : FinanceriskcvarNode) -> Int { s.size }

pub fn finance_risk_cvar_node_get(s : FinanceriskcvarNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_node_set(s : FinanceriskcvarNode, i : Int, v : Double) -> FinanceriskcvarNode {
  let result = finance_risk_cvar_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_node_sum(s : FinanceriskcvarNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_cvar_node_mean(s : FinanceriskcvarNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_cvar_node_sum(s) / s.size.to_double() }
}

pub fn finance_risk_cvar_node_scale(s : FinanceriskcvarNode, f : Double) -> FinanceriskcvarNode {
  let result = finance_risk_cvar_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_cvar_node_add(a : FinanceriskcvarNode, b : FinanceriskcvarNode) -> FinanceriskcvarNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_cvar_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_cvar_node_copy(s : FinanceriskcvarNode) -> FinanceriskcvarNode {
  let result = finance_risk_cvar_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_cvar_node_fill(s : FinanceriskcvarNode, v : Double) -> FinanceriskcvarNode {
  let result = finance_risk_cvar_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_node_min(s : FinanceriskcvarNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_node_max(s : FinanceriskcvarNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_node_to_string(s : FinanceriskcvarNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_edge_make(size : Int) -> FinanceriskcvarEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_edge_len(s : FinanceriskcvarEdge) -> Int { s.size }

pub fn finance_risk_cvar_edge_get(s : FinanceriskcvarEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_edge_set(s : FinanceriskcvarEdge, i : Int, v : Double) -> FinanceriskcvarEdge {
  let result = finance_risk_cvar_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_edge_sum(s : FinanceriskcvarEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_cvar_edge_mean(s : FinanceriskcvarEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_cvar_edge_sum(s) / s.size.to_double() }
}

pub fn finance_risk_cvar_edge_scale(s : FinanceriskcvarEdge, f : Double) -> FinanceriskcvarEdge {
  let result = finance_risk_cvar_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_cvar_edge_add(a : FinanceriskcvarEdge, b : FinanceriskcvarEdge) -> FinanceriskcvarEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_cvar_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_cvar_edge_copy(s : FinanceriskcvarEdge) -> FinanceriskcvarEdge {
  let result = finance_risk_cvar_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_cvar_edge_fill(s : FinanceriskcvarEdge, v : Double) -> FinanceriskcvarEdge {
  let result = finance_risk_cvar_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_edge_min(s : FinanceriskcvarEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_edge_max(s : FinanceriskcvarEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_edge_to_string(s : FinanceriskcvarEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_path_make(size : Int) -> FinanceriskcvarPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_path_len(s : FinanceriskcvarPath) -> Int { s.size }

pub fn finance_risk_cvar_path_get(s : FinanceriskcvarPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_path_set(s : FinanceriskcvarPath, i : Int, v : Double) -> FinanceriskcvarPath {
  let result = finance_risk_cvar_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_path_sum(s : FinanceriskcvarPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_cvar_path_mean(s : FinanceriskcvarPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_cvar_path_sum(s) / s.size.to_double() }
}

pub fn finance_risk_cvar_path_scale(s : FinanceriskcvarPath, f : Double) -> FinanceriskcvarPath {
  let result = finance_risk_cvar_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_cvar_path_add(a : FinanceriskcvarPath, b : FinanceriskcvarPath) -> FinanceriskcvarPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_cvar_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_cvar_path_copy(s : FinanceriskcvarPath) -> FinanceriskcvarPath {
  let result = finance_risk_cvar_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_cvar_path_fill(s : FinanceriskcvarPath, v : Double) -> FinanceriskcvarPath {
  let result = finance_risk_cvar_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_path_min(s : FinanceriskcvarPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_path_max(s : FinanceriskcvarPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_path_to_string(s : FinanceriskcvarPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_cluster_make(size : Int) -> FinanceriskcvarCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_cluster_len(s : FinanceriskcvarCluster) -> Int { s.size }

pub fn finance_risk_cvar_cluster_get(s : FinanceriskcvarCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_cluster_set(s : FinanceriskcvarCluster, i : Int, v : Double) -> FinanceriskcvarCluster {
  let result = finance_risk_cvar_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_cluster_sum(s : FinanceriskcvarCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_cvar_cluster_mean(s : FinanceriskcvarCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_cvar_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_risk_cvar_cluster_scale(s : FinanceriskcvarCluster, f : Double) -> FinanceriskcvarCluster {
  let result = finance_risk_cvar_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_cvar_cluster_add(a : FinanceriskcvarCluster, b : FinanceriskcvarCluster) -> FinanceriskcvarCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_cvar_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_cvar_cluster_copy(s : FinanceriskcvarCluster) -> FinanceriskcvarCluster {
  let result = finance_risk_cvar_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_cvar_cluster_fill(s : FinanceriskcvarCluster, v : Double) -> FinanceriskcvarCluster {
  let result = finance_risk_cvar_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_cluster_min(s : FinanceriskcvarCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_cluster_max(s : FinanceriskcvarCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_cluster_to_string(s : FinanceriskcvarCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_model_make(size : Int) -> FinanceriskcvarModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_model_len(s : FinanceriskcvarModel) -> Int { s.size }

pub fn finance_risk_cvar_model_get(s : FinanceriskcvarModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_model_set(s : FinanceriskcvarModel, i : Int, v : Double) -> FinanceriskcvarModel {
  let result = finance_risk_cvar_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_model_sum(s : FinanceriskcvarModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_cvar_model_mean(s : FinanceriskcvarModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_cvar_model_sum(s) / s.size.to_double() }
}

pub fn finance_risk_cvar_model_scale(s : FinanceriskcvarModel, f : Double) -> FinanceriskcvarModel {
  let result = finance_risk_cvar_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_cvar_model_add(a : FinanceriskcvarModel, b : FinanceriskcvarModel) -> FinanceriskcvarModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_cvar_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_cvar_model_copy(s : FinanceriskcvarModel) -> FinanceriskcvarModel {
  let result = finance_risk_cvar_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_cvar_model_fill(s : FinanceriskcvarModel, v : Double) -> FinanceriskcvarModel {
  let result = finance_risk_cvar_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_model_min(s : FinanceriskcvarModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_model_max(s : FinanceriskcvarModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_model_to_string(s : FinanceriskcvarModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_layer_make(size : Int) -> FinanceriskcvarLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_layer_len(s : FinanceriskcvarLayer) -> Int { s.size }

pub fn finance_risk_cvar_layer_get(s : FinanceriskcvarLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_layer_set(s : FinanceriskcvarLayer, i : Int, v : Double) -> FinanceriskcvarLayer {
  let result = finance_risk_cvar_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_layer_sum(s : FinanceriskcvarLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_cvar_layer_mean(s : FinanceriskcvarLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_cvar_layer_sum(s) / s.size.to_double() }
}

pub fn finance_risk_cvar_layer_scale(s : FinanceriskcvarLayer, f : Double) -> FinanceriskcvarLayer {
  let result = finance_risk_cvar_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_cvar_layer_add(a : FinanceriskcvarLayer, b : FinanceriskcvarLayer) -> FinanceriskcvarLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_cvar_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_cvar_layer_copy(s : FinanceriskcvarLayer) -> FinanceriskcvarLayer {
  let result = finance_risk_cvar_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_cvar_layer_fill(s : FinanceriskcvarLayer, v : Double) -> FinanceriskcvarLayer {
  let result = finance_risk_cvar_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_layer_min(s : FinanceriskcvarLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_layer_max(s : FinanceriskcvarLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_layer_to_string(s : FinanceriskcvarLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_buffer_make(size : Int) -> FinanceriskcvarBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_buffer_len(s : FinanceriskcvarBuffer) -> Int { s.size }

pub fn finance_risk_cvar_buffer_get(s : FinanceriskcvarBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_buffer_set(s : FinanceriskcvarBuffer, i : Int, v : Double) -> FinanceriskcvarBuffer {
  let result = finance_risk_cvar_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_buffer_sum(s : FinanceriskcvarBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_cvar_buffer_mean(s : FinanceriskcvarBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_cvar_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_risk_cvar_buffer_scale(s : FinanceriskcvarBuffer, f : Double) -> FinanceriskcvarBuffer {
  let result = finance_risk_cvar_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_cvar_buffer_add(a : FinanceriskcvarBuffer, b : FinanceriskcvarBuffer) -> FinanceriskcvarBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_cvar_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_cvar_buffer_copy(s : FinanceriskcvarBuffer) -> FinanceriskcvarBuffer {
  let result = finance_risk_cvar_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_cvar_buffer_fill(s : FinanceriskcvarBuffer, v : Double) -> FinanceriskcvarBuffer {
  let result = finance_risk_cvar_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_buffer_min(s : FinanceriskcvarBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_buffer_max(s : FinanceriskcvarBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_buffer_to_string(s : FinanceriskcvarBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_cursor_make(size : Int) -> FinanceriskcvarCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_cursor_len(s : FinanceriskcvarCursor) -> Int { s.size }

pub fn finance_risk_cvar_cursor_get(s : FinanceriskcvarCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_cursor_set(s : FinanceriskcvarCursor, i : Int, v : Double) -> FinanceriskcvarCursor {
  let result = finance_risk_cvar_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_cursor_sum(s : FinanceriskcvarCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_cvar_cursor_mean(s : FinanceriskcvarCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_cvar_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_risk_cvar_cursor_scale(s : FinanceriskcvarCursor, f : Double) -> FinanceriskcvarCursor {
  let result = finance_risk_cvar_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_cvar_cursor_add(a : FinanceriskcvarCursor, b : FinanceriskcvarCursor) -> FinanceriskcvarCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_cvar_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_cvar_cursor_copy(s : FinanceriskcvarCursor) -> FinanceriskcvarCursor {
  let result = finance_risk_cvar_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_cvar_cursor_fill(s : FinanceriskcvarCursor, v : Double) -> FinanceriskcvarCursor {
  let result = finance_risk_cvar_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_cursor_min(s : FinanceriskcvarCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_cursor_max(s : FinanceriskcvarCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_cursor_to_string(s : FinanceriskcvarCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_view_make(size : Int) -> FinanceriskcvarView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_view_len(s : FinanceriskcvarView) -> Int { s.size }

pub fn finance_risk_cvar_view_get(s : FinanceriskcvarView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_view_set(s : FinanceriskcvarView, i : Int, v : Double) -> FinanceriskcvarView {
  let result = finance_risk_cvar_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_view_sum(s : FinanceriskcvarView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_cvar_view_mean(s : FinanceriskcvarView) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_cvar_view_sum(s) / s.size.to_double() }
}

pub fn finance_risk_cvar_view_scale(s : FinanceriskcvarView, f : Double) -> FinanceriskcvarView {
  let result = finance_risk_cvar_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_cvar_view_add(a : FinanceriskcvarView, b : FinanceriskcvarView) -> FinanceriskcvarView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_cvar_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_cvar_view_copy(s : FinanceriskcvarView) -> FinanceriskcvarView {
  let result = finance_risk_cvar_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_cvar_view_fill(s : FinanceriskcvarView, v : Double) -> FinanceriskcvarView {
  let result = finance_risk_cvar_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_view_min(s : FinanceriskcvarView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_view_max(s : FinanceriskcvarView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_view_to_string(s : FinanceriskcvarView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_range_make(size : Int) -> FinanceriskcvarRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_range_len(s : FinanceriskcvarRange) -> Int { s.size }

pub fn finance_risk_cvar_range_get(s : FinanceriskcvarRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_range_set(s : FinanceriskcvarRange, i : Int, v : Double) -> FinanceriskcvarRange {
  let result = finance_risk_cvar_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_range_sum(s : FinanceriskcvarRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_cvar_range_mean(s : FinanceriskcvarRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_cvar_range_sum(s) / s.size.to_double() }
}

pub fn finance_risk_cvar_range_scale(s : FinanceriskcvarRange, f : Double) -> FinanceriskcvarRange {
  let result = finance_risk_cvar_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_cvar_range_add(a : FinanceriskcvarRange, b : FinanceriskcvarRange) -> FinanceriskcvarRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_cvar_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_cvar_range_copy(s : FinanceriskcvarRange) -> FinanceriskcvarRange {
  let result = finance_risk_cvar_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_cvar_range_fill(s : FinanceriskcvarRange, v : Double) -> FinanceriskcvarRange {
  let result = finance_risk_cvar_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_range_min(s : FinanceriskcvarRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_range_max(s : FinanceriskcvarRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_range_to_string(s : FinanceriskcvarRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskcvarSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_cvar_slice_make(size : Int) -> FinanceriskcvarSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_cvar_slice_len(s : FinanceriskcvarSlice) -> Int { s.size }

pub fn finance_risk_cvar_slice_get(s : FinanceriskcvarSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_cvar_slice_set(s : FinanceriskcvarSlice, i : Int, v : Double) -> FinanceriskcvarSlice {
  let result = finance_risk_cvar_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_slice_sum(s : FinanceriskcvarSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_cvar_slice_mean(s : FinanceriskcvarSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_cvar_slice_sum(s) / s.size.to_double() }
}

pub fn finance_risk_cvar_slice_scale(s : FinanceriskcvarSlice, f : Double) -> FinanceriskcvarSlice {
  let result = finance_risk_cvar_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_cvar_slice_add(a : FinanceriskcvarSlice, b : FinanceriskcvarSlice) -> FinanceriskcvarSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_cvar_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_cvar_slice_copy(s : FinanceriskcvarSlice) -> FinanceriskcvarSlice {
  let result = finance_risk_cvar_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_cvar_slice_fill(s : FinanceriskcvarSlice, v : Double) -> FinanceriskcvarSlice {
  let result = finance_risk_cvar_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_cvar_slice_min(s : FinanceriskcvarSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_slice_max(s : FinanceriskcvarSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_cvar_slice_to_string(s : FinanceriskcvarSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

