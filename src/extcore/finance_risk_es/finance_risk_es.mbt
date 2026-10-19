///===
/// extcore/finance_risk_es

pub(all) struct FinanceriskesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_risk_es_make_point(x : Double, y : Double) -> FinanceriskesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_risk_es_make_point3(x : Double, y : Double, z : Double) -> FinanceriskesPoint {
  { x, y, z, label: 0 }
}

pub fn finance_risk_es_point_x(pt : FinanceriskesPoint) -> Double { pt.x }

pub fn finance_risk_es_point_y(pt : FinanceriskesPoint) -> Double { pt.y }

pub fn finance_risk_es_point_z(pt : FinanceriskesPoint) -> Double { pt.z }

pub fn finance_risk_es_point_label(pt : FinanceriskesPoint) -> Int { pt.label }

pub fn finance_risk_es_point_dist(a : FinanceriskesPoint, b : FinanceriskesPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_risk_es_point_add(a : FinanceriskesPoint, b : FinanceriskesPoint) -> FinanceriskesPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_risk_es_point_sub(a : FinanceriskesPoint, b : FinanceriskesPoint) -> FinanceriskesPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_risk_es_point_scale(pt : FinanceriskesPoint, s : Double) -> FinanceriskesPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_risk_es_point_dot(a : FinanceriskesPoint, b : FinanceriskesPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_risk_es_point_cross(a : FinanceriskesPoint, b : FinanceriskesPoint) -> FinanceriskesPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_risk_es_point_norm(pt : FinanceriskesPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_risk_es_point_normalize(pt : FinanceriskesPoint) -> FinanceriskesPoint {
  let n = finance_risk_es_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_risk_es_point_scale(pt, 1.0 / n) }
}

pub fn finance_risk_es_point_negate(pt : FinanceriskesPoint) -> FinanceriskesPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_risk_es_point_mid(a : FinanceriskesPoint, b : FinanceriskesPoint) -> FinanceriskesPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_risk_es_point_lerp(a : FinanceriskesPoint, b : FinanceriskesPoint, t : Double) -> FinanceriskesPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_risk_es_point_to_string(pt : FinanceriskesPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinanceriskesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_risk_es_make_series(vals : Array[Double], name : String) -> FinanceriskesSeries {
  { vals, name, meta: 0 }
}

pub fn finance_risk_es_series_len(s : FinanceriskesSeries) -> Int { s.vals.length() }

pub fn finance_risk_es_series_sum(s : FinanceriskesSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_risk_es_series_mean(s : FinanceriskesSeries) -> Double {
  let n = finance_risk_es_series_len(s)
  if n == 0 { 0.0 } else { finance_risk_es_series_sum(s) / n.to_double() }
}

pub fn finance_risk_es_series_min(s : FinanceriskesSeries) -> Double {
  let n = finance_risk_es_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_risk_es_series_max(s : FinanceriskesSeries) -> Double {
  let n = finance_risk_es_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_risk_es_series_range(s : FinanceriskesSeries) -> Double {
  finance_risk_es_series_max(s) - finance_risk_es_series_min(s)
}

pub fn finance_risk_es_series_var(s : FinanceriskesSeries) -> Double {
  let n = finance_risk_es_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_risk_es_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_risk_es_series_std(s : FinanceriskesSeries) -> Double { @_common.sqrt(finance_risk_es_series_var(s)) }

pub fn finance_risk_es_series_median(s : FinanceriskesSeries) -> Double {
  let n = finance_risk_es_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_risk_es_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_risk_es_series_scale(s : FinanceriskesSeries, f : Double) -> FinanceriskesSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_risk_es_series_add(a : FinanceriskesSeries, b : FinanceriskesSeries) -> FinanceriskesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_risk_es_series_sub(a : FinanceriskesSeries, b : FinanceriskesSeries) -> FinanceriskesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_risk_es_series_normalize(s : FinanceriskesSeries) -> FinanceriskesSeries {
  let mn = finance_risk_es_series_min(s)
  let mx = finance_risk_es_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_risk_es_series_cumsum(s : FinanceriskesSeries) -> FinanceriskesSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_risk_es_series_to_string(s : FinanceriskesSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinanceriskesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_risk_es_make_matrix(rows : Int, cols : Int, val : Double) -> FinanceriskesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_risk_es_matrix_identity(n : Int) -> FinanceriskesMatrix {
  let m = finance_risk_es_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_risk_es_matrix_get(m : FinanceriskesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_risk_es_matrix_transpose(m : FinanceriskesMatrix) -> FinanceriskesMatrix {
  let result = finance_risk_es_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_risk_es_matrix_add(a : FinanceriskesMatrix, b : FinanceriskesMatrix) -> FinanceriskesMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_risk_es_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_risk_es_matrix_scale(m : FinanceriskesMatrix, s : Double) -> FinanceriskesMatrix {
  let result = finance_risk_es_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_risk_es_matrix_multiply(a : FinanceriskesMatrix, b : FinanceriskesMatrix) -> FinanceriskesMatrix {
  if a.cols != b.rows { return finance_risk_es_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_risk_es_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_risk_es_matrix_trace(m : FinanceriskesMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_risk_es_matrix_det(m : FinanceriskesMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_risk_es_matrix_norm(m : FinanceriskesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_risk_es_matrix_to_string(m : FinanceriskesMatrix) -> String {
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

pub(all) struct FinanceriskesVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_risk_es_make_vector(comps : Array[Double]) -> FinanceriskesVector {
  { comps, dim: comps.length() }
}

pub fn finance_risk_es_vector_zero(dim : Int) -> FinanceriskesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_risk_es_vector_add(a : FinanceriskesVector, b : FinanceriskesVector) -> FinanceriskesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_es_vector_sub(a : FinanceriskesVector, b : FinanceriskesVector) -> FinanceriskesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_risk_es_vector_scale(v : FinanceriskesVector, s : Double) -> FinanceriskesVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_risk_es_vector_dot(a : FinanceriskesVector, b : FinanceriskesVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_risk_es_vector_norm(v : FinanceriskesVector) -> Double { @_common.sqrt(finance_risk_es_vector_dot(v, v)) }

pub fn finance_risk_es_vector_normalize(v : FinanceriskesVector) -> FinanceriskesVector {
  let n = finance_risk_es_vector_norm(v)
  if n < 0.0000001 { v } else { finance_risk_es_vector_scale(v, 1.0 / n) }
}

pub fn finance_risk_es_vector_dist(a : FinanceriskesVector, b : FinanceriskesVector) -> Double {
  finance_risk_es_vector_norm(finance_risk_es_vector_sub(a, b))
}

pub fn finance_risk_es_vector_to_string(v : FinanceriskesVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_risk_es_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_risk_es_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_risk_es_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_risk_es_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_risk_es_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_risk_es_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_risk_es_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_risk_es_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_risk_es_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_risk_es_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_risk_es_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_risk_es_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_risk_es_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_risk_es_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_risk_es_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_risk_es_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_risk_es_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_risk_es_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_risk_es_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_risk_es_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_risk_es_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_risk_es_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_risk_es_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_risk_es_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_risk_es_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_risk_es_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_risk_es_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_risk_es_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_risk_es_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinanceriskesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_frame_make(size : Int) -> FinanceriskesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_es_frame_len(s : FinanceriskesFrame) -> Int { s.size }

pub fn finance_risk_es_frame_get(s : FinanceriskesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_es_frame_set(s : FinanceriskesFrame, i : Int, v : Double) -> FinanceriskesFrame {
  let result = finance_risk_es_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_frame_sum(s : FinanceriskesFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_es_frame_mean(s : FinanceriskesFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_es_frame_sum(s) / s.size.to_double() }
}

pub fn finance_risk_es_frame_scale(s : FinanceriskesFrame, f : Double) -> FinanceriskesFrame {
  let result = finance_risk_es_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_es_frame_add(a : FinanceriskesFrame, b : FinanceriskesFrame) -> FinanceriskesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_es_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_es_frame_copy(s : FinanceriskesFrame) -> FinanceriskesFrame {
  let result = finance_risk_es_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_es_frame_fill(s : FinanceriskesFrame, v : Double) -> FinanceriskesFrame {
  let result = finance_risk_es_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_frame_min(s : FinanceriskesFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_frame_max(s : FinanceriskesFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_frame_to_string(s : FinanceriskesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_table_make(size : Int) -> FinanceriskesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_es_table_len(s : FinanceriskesTable) -> Int { s.size }

pub fn finance_risk_es_table_get(s : FinanceriskesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_es_table_set(s : FinanceriskesTable, i : Int, v : Double) -> FinanceriskesTable {
  let result = finance_risk_es_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_table_sum(s : FinanceriskesTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_es_table_mean(s : FinanceriskesTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_es_table_sum(s) / s.size.to_double() }
}

pub fn finance_risk_es_table_scale(s : FinanceriskesTable, f : Double) -> FinanceriskesTable {
  let result = finance_risk_es_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_es_table_add(a : FinanceriskesTable, b : FinanceriskesTable) -> FinanceriskesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_es_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_es_table_copy(s : FinanceriskesTable) -> FinanceriskesTable {
  let result = finance_risk_es_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_es_table_fill(s : FinanceriskesTable, v : Double) -> FinanceriskesTable {
  let result = finance_risk_es_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_table_min(s : FinanceriskesTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_table_max(s : FinanceriskesTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_table_to_string(s : FinanceriskesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_graphn_make(size : Int) -> FinanceriskesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_es_graphn_len(s : FinanceriskesGraphN) -> Int { s.size }

pub fn finance_risk_es_graphn_get(s : FinanceriskesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_es_graphn_set(s : FinanceriskesGraphN, i : Int, v : Double) -> FinanceriskesGraphN {
  let result = finance_risk_es_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_graphn_sum(s : FinanceriskesGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_es_graphn_mean(s : FinanceriskesGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_es_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_risk_es_graphn_scale(s : FinanceriskesGraphN, f : Double) -> FinanceriskesGraphN {
  let result = finance_risk_es_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_es_graphn_add(a : FinanceriskesGraphN, b : FinanceriskesGraphN) -> FinanceriskesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_es_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_es_graphn_copy(s : FinanceriskesGraphN) -> FinanceriskesGraphN {
  let result = finance_risk_es_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_es_graphn_fill(s : FinanceriskesGraphN, v : Double) -> FinanceriskesGraphN {
  let result = finance_risk_es_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_graphn_min(s : FinanceriskesGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_graphn_max(s : FinanceriskesGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_graphn_to_string(s : FinanceriskesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_node_make(size : Int) -> FinanceriskesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_es_node_len(s : FinanceriskesNode) -> Int { s.size }

pub fn finance_risk_es_node_get(s : FinanceriskesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_es_node_set(s : FinanceriskesNode, i : Int, v : Double) -> FinanceriskesNode {
  let result = finance_risk_es_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_node_sum(s : FinanceriskesNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_es_node_mean(s : FinanceriskesNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_es_node_sum(s) / s.size.to_double() }
}

pub fn finance_risk_es_node_scale(s : FinanceriskesNode, f : Double) -> FinanceriskesNode {
  let result = finance_risk_es_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_es_node_add(a : FinanceriskesNode, b : FinanceriskesNode) -> FinanceriskesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_es_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_es_node_copy(s : FinanceriskesNode) -> FinanceriskesNode {
  let result = finance_risk_es_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_es_node_fill(s : FinanceriskesNode, v : Double) -> FinanceriskesNode {
  let result = finance_risk_es_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_node_min(s : FinanceriskesNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_node_max(s : FinanceriskesNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_node_to_string(s : FinanceriskesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_edge_make(size : Int) -> FinanceriskesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_es_edge_len(s : FinanceriskesEdge) -> Int { s.size }

pub fn finance_risk_es_edge_get(s : FinanceriskesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_es_edge_set(s : FinanceriskesEdge, i : Int, v : Double) -> FinanceriskesEdge {
  let result = finance_risk_es_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_edge_sum(s : FinanceriskesEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_es_edge_mean(s : FinanceriskesEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_es_edge_sum(s) / s.size.to_double() }
}

pub fn finance_risk_es_edge_scale(s : FinanceriskesEdge, f : Double) -> FinanceriskesEdge {
  let result = finance_risk_es_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_es_edge_add(a : FinanceriskesEdge, b : FinanceriskesEdge) -> FinanceriskesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_es_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_es_edge_copy(s : FinanceriskesEdge) -> FinanceriskesEdge {
  let result = finance_risk_es_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_es_edge_fill(s : FinanceriskesEdge, v : Double) -> FinanceriskesEdge {
  let result = finance_risk_es_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_edge_min(s : FinanceriskesEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_edge_max(s : FinanceriskesEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_edge_to_string(s : FinanceriskesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_path_make(size : Int) -> FinanceriskesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_es_path_len(s : FinanceriskesPath) -> Int { s.size }

pub fn finance_risk_es_path_get(s : FinanceriskesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_es_path_set(s : FinanceriskesPath, i : Int, v : Double) -> FinanceriskesPath {
  let result = finance_risk_es_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_path_sum(s : FinanceriskesPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_es_path_mean(s : FinanceriskesPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_es_path_sum(s) / s.size.to_double() }
}

pub fn finance_risk_es_path_scale(s : FinanceriskesPath, f : Double) -> FinanceriskesPath {
  let result = finance_risk_es_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_es_path_add(a : FinanceriskesPath, b : FinanceriskesPath) -> FinanceriskesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_es_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_es_path_copy(s : FinanceriskesPath) -> FinanceriskesPath {
  let result = finance_risk_es_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_es_path_fill(s : FinanceriskesPath, v : Double) -> FinanceriskesPath {
  let result = finance_risk_es_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_path_min(s : FinanceriskesPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_path_max(s : FinanceriskesPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_path_to_string(s : FinanceriskesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_cluster_make(size : Int) -> FinanceriskesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_es_cluster_len(s : FinanceriskesCluster) -> Int { s.size }

pub fn finance_risk_es_cluster_get(s : FinanceriskesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_es_cluster_set(s : FinanceriskesCluster, i : Int, v : Double) -> FinanceriskesCluster {
  let result = finance_risk_es_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_cluster_sum(s : FinanceriskesCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_es_cluster_mean(s : FinanceriskesCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_es_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_risk_es_cluster_scale(s : FinanceriskesCluster, f : Double) -> FinanceriskesCluster {
  let result = finance_risk_es_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_es_cluster_add(a : FinanceriskesCluster, b : FinanceriskesCluster) -> FinanceriskesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_es_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_es_cluster_copy(s : FinanceriskesCluster) -> FinanceriskesCluster {
  let result = finance_risk_es_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_es_cluster_fill(s : FinanceriskesCluster, v : Double) -> FinanceriskesCluster {
  let result = finance_risk_es_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_cluster_min(s : FinanceriskesCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_cluster_max(s : FinanceriskesCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_cluster_to_string(s : FinanceriskesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_model_make(size : Int) -> FinanceriskesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_es_model_len(s : FinanceriskesModel) -> Int { s.size }

pub fn finance_risk_es_model_get(s : FinanceriskesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_es_model_set(s : FinanceriskesModel, i : Int, v : Double) -> FinanceriskesModel {
  let result = finance_risk_es_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_model_sum(s : FinanceriskesModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_es_model_mean(s : FinanceriskesModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_es_model_sum(s) / s.size.to_double() }
}

pub fn finance_risk_es_model_scale(s : FinanceriskesModel, f : Double) -> FinanceriskesModel {
  let result = finance_risk_es_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_es_model_add(a : FinanceriskesModel, b : FinanceriskesModel) -> FinanceriskesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_es_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_es_model_copy(s : FinanceriskesModel) -> FinanceriskesModel {
  let result = finance_risk_es_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_es_model_fill(s : FinanceriskesModel, v : Double) -> FinanceriskesModel {
  let result = finance_risk_es_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_model_min(s : FinanceriskesModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_model_max(s : FinanceriskesModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_model_to_string(s : FinanceriskesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_layer_make(size : Int) -> FinanceriskesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_es_layer_len(s : FinanceriskesLayer) -> Int { s.size }

pub fn finance_risk_es_layer_get(s : FinanceriskesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_es_layer_set(s : FinanceriskesLayer, i : Int, v : Double) -> FinanceriskesLayer {
  let result = finance_risk_es_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_layer_sum(s : FinanceriskesLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_es_layer_mean(s : FinanceriskesLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_es_layer_sum(s) / s.size.to_double() }
}

pub fn finance_risk_es_layer_scale(s : FinanceriskesLayer, f : Double) -> FinanceriskesLayer {
  let result = finance_risk_es_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_es_layer_add(a : FinanceriskesLayer, b : FinanceriskesLayer) -> FinanceriskesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_es_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_es_layer_copy(s : FinanceriskesLayer) -> FinanceriskesLayer {
  let result = finance_risk_es_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_es_layer_fill(s : FinanceriskesLayer, v : Double) -> FinanceriskesLayer {
  let result = finance_risk_es_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_layer_min(s : FinanceriskesLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_layer_max(s : FinanceriskesLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_layer_to_string(s : FinanceriskesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_buffer_make(size : Int) -> FinanceriskesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_es_buffer_len(s : FinanceriskesBuffer) -> Int { s.size }

pub fn finance_risk_es_buffer_get(s : FinanceriskesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_es_buffer_set(s : FinanceriskesBuffer, i : Int, v : Double) -> FinanceriskesBuffer {
  let result = finance_risk_es_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_buffer_sum(s : FinanceriskesBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_es_buffer_mean(s : FinanceriskesBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_es_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_risk_es_buffer_scale(s : FinanceriskesBuffer, f : Double) -> FinanceriskesBuffer {
  let result = finance_risk_es_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_es_buffer_add(a : FinanceriskesBuffer, b : FinanceriskesBuffer) -> FinanceriskesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_es_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_es_buffer_copy(s : FinanceriskesBuffer) -> FinanceriskesBuffer {
  let result = finance_risk_es_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_es_buffer_fill(s : FinanceriskesBuffer, v : Double) -> FinanceriskesBuffer {
  let result = finance_risk_es_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_buffer_min(s : FinanceriskesBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_buffer_max(s : FinanceriskesBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_buffer_to_string(s : FinanceriskesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_cursor_make(size : Int) -> FinanceriskesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_es_cursor_len(s : FinanceriskesCursor) -> Int { s.size }

pub fn finance_risk_es_cursor_get(s : FinanceriskesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_es_cursor_set(s : FinanceriskesCursor, i : Int, v : Double) -> FinanceriskesCursor {
  let result = finance_risk_es_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_cursor_sum(s : FinanceriskesCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_es_cursor_mean(s : FinanceriskesCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_es_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_risk_es_cursor_scale(s : FinanceriskesCursor, f : Double) -> FinanceriskesCursor {
  let result = finance_risk_es_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_es_cursor_add(a : FinanceriskesCursor, b : FinanceriskesCursor) -> FinanceriskesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_es_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_es_cursor_copy(s : FinanceriskesCursor) -> FinanceriskesCursor {
  let result = finance_risk_es_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_es_cursor_fill(s : FinanceriskesCursor, v : Double) -> FinanceriskesCursor {
  let result = finance_risk_es_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_cursor_min(s : FinanceriskesCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_cursor_max(s : FinanceriskesCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_cursor_to_string(s : FinanceriskesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_view_make(size : Int) -> FinanceriskesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_es_view_len(s : FinanceriskesView) -> Int { s.size }

pub fn finance_risk_es_view_get(s : FinanceriskesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_es_view_set(s : FinanceriskesView, i : Int, v : Double) -> FinanceriskesView {
  let result = finance_risk_es_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_view_sum(s : FinanceriskesView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_es_view_mean(s : FinanceriskesView) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_es_view_sum(s) / s.size.to_double() }
}

pub fn finance_risk_es_view_scale(s : FinanceriskesView, f : Double) -> FinanceriskesView {
  let result = finance_risk_es_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_es_view_add(a : FinanceriskesView, b : FinanceriskesView) -> FinanceriskesView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_es_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_es_view_copy(s : FinanceriskesView) -> FinanceriskesView {
  let result = finance_risk_es_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_es_view_fill(s : FinanceriskesView, v : Double) -> FinanceriskesView {
  let result = finance_risk_es_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_view_min(s : FinanceriskesView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_view_max(s : FinanceriskesView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_view_to_string(s : FinanceriskesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_range_make(size : Int) -> FinanceriskesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_es_range_len(s : FinanceriskesRange) -> Int { s.size }

pub fn finance_risk_es_range_get(s : FinanceriskesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_es_range_set(s : FinanceriskesRange, i : Int, v : Double) -> FinanceriskesRange {
  let result = finance_risk_es_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_range_sum(s : FinanceriskesRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_es_range_mean(s : FinanceriskesRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_es_range_sum(s) / s.size.to_double() }
}

pub fn finance_risk_es_range_scale(s : FinanceriskesRange, f : Double) -> FinanceriskesRange {
  let result = finance_risk_es_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_es_range_add(a : FinanceriskesRange, b : FinanceriskesRange) -> FinanceriskesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_es_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_es_range_copy(s : FinanceriskesRange) -> FinanceriskesRange {
  let result = finance_risk_es_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_es_range_fill(s : FinanceriskesRange, v : Double) -> FinanceriskesRange {
  let result = finance_risk_es_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_range_min(s : FinanceriskesRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_range_max(s : FinanceriskesRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_range_to_string(s : FinanceriskesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinanceriskesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_risk_es_slice_make(size : Int) -> FinanceriskesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_risk_es_slice_len(s : FinanceriskesSlice) -> Int { s.size }

pub fn finance_risk_es_slice_get(s : FinanceriskesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_risk_es_slice_set(s : FinanceriskesSlice, i : Int, v : Double) -> FinanceriskesSlice {
  let result = finance_risk_es_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_slice_sum(s : FinanceriskesSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_risk_es_slice_mean(s : FinanceriskesSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_risk_es_slice_sum(s) / s.size.to_double() }
}

pub fn finance_risk_es_slice_scale(s : FinanceriskesSlice, f : Double) -> FinanceriskesSlice {
  let result = finance_risk_es_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_risk_es_slice_add(a : FinanceriskesSlice, b : FinanceriskesSlice) -> FinanceriskesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_risk_es_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_risk_es_slice_copy(s : FinanceriskesSlice) -> FinanceriskesSlice {
  let result = finance_risk_es_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_risk_es_slice_fill(s : FinanceriskesSlice, v : Double) -> FinanceriskesSlice {
  let result = finance_risk_es_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_risk_es_slice_min(s : FinanceriskesSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_slice_max(s : FinanceriskesSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_risk_es_slice_to_string(s : FinanceriskesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

