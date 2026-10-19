///===
/// extcore/finance_time_crisis

pub(all) struct FinancetimecrisisPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn finance_time_crisis_make_point(x : Double, y : Double) -> FinancetimecrisisPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn finance_time_crisis_make_point3(x : Double, y : Double, z : Double) -> FinancetimecrisisPoint {
  { x, y, z, label: 0 }
}

pub fn finance_time_crisis_point_x(pt : FinancetimecrisisPoint) -> Double { pt.x }

pub fn finance_time_crisis_point_y(pt : FinancetimecrisisPoint) -> Double { pt.y }

pub fn finance_time_crisis_point_z(pt : FinancetimecrisisPoint) -> Double { pt.z }

pub fn finance_time_crisis_point_label(pt : FinancetimecrisisPoint) -> Int { pt.label }

pub fn finance_time_crisis_point_dist(a : FinancetimecrisisPoint, b : FinancetimecrisisPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn finance_time_crisis_point_add(a : FinancetimecrisisPoint, b : FinancetimecrisisPoint) -> FinancetimecrisisPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn finance_time_crisis_point_sub(a : FinancetimecrisisPoint, b : FinancetimecrisisPoint) -> FinancetimecrisisPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn finance_time_crisis_point_scale(pt : FinancetimecrisisPoint, s : Double) -> FinancetimecrisisPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn finance_time_crisis_point_dot(a : FinancetimecrisisPoint, b : FinancetimecrisisPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn finance_time_crisis_point_cross(a : FinancetimecrisisPoint, b : FinancetimecrisisPoint) -> FinancetimecrisisPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn finance_time_crisis_point_norm(pt : FinancetimecrisisPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn finance_time_crisis_point_normalize(pt : FinancetimecrisisPoint) -> FinancetimecrisisPoint {
  let n = finance_time_crisis_point_norm(pt)
  if n < 0.0000001 { pt } else { finance_time_crisis_point_scale(pt, 1.0 / n) }
}

pub fn finance_time_crisis_point_negate(pt : FinancetimecrisisPoint) -> FinancetimecrisisPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn finance_time_crisis_point_mid(a : FinancetimecrisisPoint, b : FinancetimecrisisPoint) -> FinancetimecrisisPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn finance_time_crisis_point_lerp(a : FinancetimecrisisPoint, b : FinancetimecrisisPoint, t : Double) -> FinancetimecrisisPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn finance_time_crisis_point_to_string(pt : FinancetimecrisisPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct FinancetimecrisisSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn finance_time_crisis_make_series(vals : Array[Double], name : String) -> FinancetimecrisisSeries {
  { vals, name, meta: 0 }
}

pub fn finance_time_crisis_series_len(s : FinancetimecrisisSeries) -> Int { s.vals.length() }

pub fn finance_time_crisis_series_sum(s : FinancetimecrisisSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn finance_time_crisis_series_mean(s : FinancetimecrisisSeries) -> Double {
  let n = finance_time_crisis_series_len(s)
  if n == 0 { 0.0 } else { finance_time_crisis_series_sum(s) / n.to_double() }
}

pub fn finance_time_crisis_series_min(s : FinancetimecrisisSeries) -> Double {
  let n = finance_time_crisis_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn finance_time_crisis_series_max(s : FinancetimecrisisSeries) -> Double {
  let n = finance_time_crisis_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn finance_time_crisis_series_range(s : FinancetimecrisisSeries) -> Double {
  finance_time_crisis_series_max(s) - finance_time_crisis_series_min(s)
}

pub fn finance_time_crisis_series_var(s : FinancetimecrisisSeries) -> Double {
  let n = finance_time_crisis_series_len(s)
  if n == 0 { 0.0 } else {
    let m = finance_time_crisis_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn finance_time_crisis_series_std(s : FinancetimecrisisSeries) -> Double { @_common.sqrt(finance_time_crisis_series_var(s)) }

pub fn finance_time_crisis_series_median(s : FinancetimecrisisSeries) -> Double {
  let n = finance_time_crisis_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = finance_time_crisis_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn finance_time_crisis_series_scale(s : FinancetimecrisisSeries, f : Double) -> FinancetimecrisisSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn finance_time_crisis_series_add(a : FinancetimecrisisSeries, b : FinancetimecrisisSeries) -> FinancetimecrisisSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn finance_time_crisis_series_sub(a : FinancetimecrisisSeries, b : FinancetimecrisisSeries) -> FinancetimecrisisSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn finance_time_crisis_series_normalize(s : FinancetimecrisisSeries) -> FinancetimecrisisSeries {
  let mn = finance_time_crisis_series_min(s)
  let mx = finance_time_crisis_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn finance_time_crisis_series_cumsum(s : FinancetimecrisisSeries) -> FinancetimecrisisSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn finance_time_crisis_series_to_string(s : FinancetimecrisisSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct FinancetimecrisisMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn finance_time_crisis_make_matrix(rows : Int, cols : Int, val : Double) -> FinancetimecrisisMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn finance_time_crisis_matrix_identity(n : Int) -> FinancetimecrisisMatrix {
  let m = finance_time_crisis_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn finance_time_crisis_matrix_get(m : FinancetimecrisisMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn finance_time_crisis_matrix_transpose(m : FinancetimecrisisMatrix) -> FinancetimecrisisMatrix {
  let result = finance_time_crisis_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn finance_time_crisis_matrix_add(a : FinancetimecrisisMatrix, b : FinancetimecrisisMatrix) -> FinancetimecrisisMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = finance_time_crisis_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn finance_time_crisis_matrix_scale(m : FinancetimecrisisMatrix, s : Double) -> FinancetimecrisisMatrix {
  let result = finance_time_crisis_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn finance_time_crisis_matrix_multiply(a : FinancetimecrisisMatrix, b : FinancetimecrisisMatrix) -> FinancetimecrisisMatrix {
  if a.cols != b.rows { return finance_time_crisis_make_matrix(a.rows, b.cols, 0.0) }
  let result = finance_time_crisis_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn finance_time_crisis_matrix_trace(m : FinancetimecrisisMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn finance_time_crisis_matrix_det(m : FinancetimecrisisMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn finance_time_crisis_matrix_norm(m : FinancetimecrisisMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn finance_time_crisis_matrix_to_string(m : FinancetimecrisisMatrix) -> String {
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

pub(all) struct FinancetimecrisisVector {
  comps : Array[Double]
  dim : Int
}

pub fn finance_time_crisis_make_vector(comps : Array[Double]) -> FinancetimecrisisVector {
  { comps, dim: comps.length() }
}

pub fn finance_time_crisis_vector_zero(dim : Int) -> FinancetimecrisisVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn finance_time_crisis_vector_add(a : FinancetimecrisisVector, b : FinancetimecrisisVector) -> FinancetimecrisisVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_crisis_vector_sub(a : FinancetimecrisisVector, b : FinancetimecrisisVector) -> FinancetimecrisisVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn finance_time_crisis_vector_scale(v : FinancetimecrisisVector, s : Double) -> FinancetimecrisisVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn finance_time_crisis_vector_dot(a : FinancetimecrisisVector, b : FinancetimecrisisVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn finance_time_crisis_vector_norm(v : FinancetimecrisisVector) -> Double { @_common.sqrt(finance_time_crisis_vector_dot(v, v)) }

pub fn finance_time_crisis_vector_normalize(v : FinancetimecrisisVector) -> FinancetimecrisisVector {
  let n = finance_time_crisis_vector_norm(v)
  if n < 0.0000001 { v } else { finance_time_crisis_vector_scale(v, 1.0 / n) }
}

pub fn finance_time_crisis_vector_dist(a : FinancetimecrisisVector, b : FinancetimecrisisVector) -> Double {
  finance_time_crisis_vector_norm(finance_time_crisis_vector_sub(a, b))
}

pub fn finance_time_crisis_vector_to_string(v : FinancetimecrisisVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn finance_time_crisis_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn finance_time_crisis_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn finance_time_crisis_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn finance_time_crisis_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn finance_time_crisis_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn finance_time_crisis_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn finance_time_crisis_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn finance_time_crisis_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn finance_time_crisis_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn finance_time_crisis_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn finance_time_crisis_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn finance_time_crisis_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn finance_time_crisis_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn finance_time_crisis_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn finance_time_crisis_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn finance_time_crisis_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn finance_time_crisis_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn finance_time_crisis_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn finance_time_crisis_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn finance_time_crisis_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn finance_time_crisis_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn finance_time_crisis_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn finance_time_crisis_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn finance_time_crisis_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn finance_time_crisis_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn finance_time_crisis_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn finance_time_crisis_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn finance_time_crisis_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn finance_time_crisis_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct FinancetimecrisisFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_frame_make(size : Int) -> FinancetimecrisisFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_frame_len(s : FinancetimecrisisFrame) -> Int { s.size }

pub fn finance_time_crisis_frame_get(s : FinancetimecrisisFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_frame_set(s : FinancetimecrisisFrame, i : Int, v : Double) -> FinancetimecrisisFrame {
  let result = finance_time_crisis_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_frame_sum(s : FinancetimecrisisFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_crisis_frame_mean(s : FinancetimecrisisFrame) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_crisis_frame_sum(s) / s.size.to_double() }
}

pub fn finance_time_crisis_frame_scale(s : FinancetimecrisisFrame, f : Double) -> FinancetimecrisisFrame {
  let result = finance_time_crisis_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_crisis_frame_add(a : FinancetimecrisisFrame, b : FinancetimecrisisFrame) -> FinancetimecrisisFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_crisis_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_crisis_frame_copy(s : FinancetimecrisisFrame) -> FinancetimecrisisFrame {
  let result = finance_time_crisis_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_crisis_frame_fill(s : FinancetimecrisisFrame, v : Double) -> FinancetimecrisisFrame {
  let result = finance_time_crisis_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_frame_min(s : FinancetimecrisisFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_frame_max(s : FinancetimecrisisFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_frame_to_string(s : FinancetimecrisisFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_table_make(size : Int) -> FinancetimecrisisTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_table_len(s : FinancetimecrisisTable) -> Int { s.size }

pub fn finance_time_crisis_table_get(s : FinancetimecrisisTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_table_set(s : FinancetimecrisisTable, i : Int, v : Double) -> FinancetimecrisisTable {
  let result = finance_time_crisis_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_table_sum(s : FinancetimecrisisTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_crisis_table_mean(s : FinancetimecrisisTable) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_crisis_table_sum(s) / s.size.to_double() }
}

pub fn finance_time_crisis_table_scale(s : FinancetimecrisisTable, f : Double) -> FinancetimecrisisTable {
  let result = finance_time_crisis_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_crisis_table_add(a : FinancetimecrisisTable, b : FinancetimecrisisTable) -> FinancetimecrisisTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_crisis_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_crisis_table_copy(s : FinancetimecrisisTable) -> FinancetimecrisisTable {
  let result = finance_time_crisis_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_crisis_table_fill(s : FinancetimecrisisTable, v : Double) -> FinancetimecrisisTable {
  let result = finance_time_crisis_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_table_min(s : FinancetimecrisisTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_table_max(s : FinancetimecrisisTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_table_to_string(s : FinancetimecrisisTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_graphn_make(size : Int) -> FinancetimecrisisGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_graphn_len(s : FinancetimecrisisGraphN) -> Int { s.size }

pub fn finance_time_crisis_graphn_get(s : FinancetimecrisisGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_graphn_set(s : FinancetimecrisisGraphN, i : Int, v : Double) -> FinancetimecrisisGraphN {
  let result = finance_time_crisis_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_graphn_sum(s : FinancetimecrisisGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_crisis_graphn_mean(s : FinancetimecrisisGraphN) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_crisis_graphn_sum(s) / s.size.to_double() }
}

pub fn finance_time_crisis_graphn_scale(s : FinancetimecrisisGraphN, f : Double) -> FinancetimecrisisGraphN {
  let result = finance_time_crisis_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_crisis_graphn_add(a : FinancetimecrisisGraphN, b : FinancetimecrisisGraphN) -> FinancetimecrisisGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_crisis_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_crisis_graphn_copy(s : FinancetimecrisisGraphN) -> FinancetimecrisisGraphN {
  let result = finance_time_crisis_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_crisis_graphn_fill(s : FinancetimecrisisGraphN, v : Double) -> FinancetimecrisisGraphN {
  let result = finance_time_crisis_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_graphn_min(s : FinancetimecrisisGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_graphn_max(s : FinancetimecrisisGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_graphn_to_string(s : FinancetimecrisisGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_node_make(size : Int) -> FinancetimecrisisNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_node_len(s : FinancetimecrisisNode) -> Int { s.size }

pub fn finance_time_crisis_node_get(s : FinancetimecrisisNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_node_set(s : FinancetimecrisisNode, i : Int, v : Double) -> FinancetimecrisisNode {
  let result = finance_time_crisis_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_node_sum(s : FinancetimecrisisNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_crisis_node_mean(s : FinancetimecrisisNode) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_crisis_node_sum(s) / s.size.to_double() }
}

pub fn finance_time_crisis_node_scale(s : FinancetimecrisisNode, f : Double) -> FinancetimecrisisNode {
  let result = finance_time_crisis_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_crisis_node_add(a : FinancetimecrisisNode, b : FinancetimecrisisNode) -> FinancetimecrisisNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_crisis_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_crisis_node_copy(s : FinancetimecrisisNode) -> FinancetimecrisisNode {
  let result = finance_time_crisis_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_crisis_node_fill(s : FinancetimecrisisNode, v : Double) -> FinancetimecrisisNode {
  let result = finance_time_crisis_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_node_min(s : FinancetimecrisisNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_node_max(s : FinancetimecrisisNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_node_to_string(s : FinancetimecrisisNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_edge_make(size : Int) -> FinancetimecrisisEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_edge_len(s : FinancetimecrisisEdge) -> Int { s.size }

pub fn finance_time_crisis_edge_get(s : FinancetimecrisisEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_edge_set(s : FinancetimecrisisEdge, i : Int, v : Double) -> FinancetimecrisisEdge {
  let result = finance_time_crisis_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_edge_sum(s : FinancetimecrisisEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_crisis_edge_mean(s : FinancetimecrisisEdge) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_crisis_edge_sum(s) / s.size.to_double() }
}

pub fn finance_time_crisis_edge_scale(s : FinancetimecrisisEdge, f : Double) -> FinancetimecrisisEdge {
  let result = finance_time_crisis_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_crisis_edge_add(a : FinancetimecrisisEdge, b : FinancetimecrisisEdge) -> FinancetimecrisisEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_crisis_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_crisis_edge_copy(s : FinancetimecrisisEdge) -> FinancetimecrisisEdge {
  let result = finance_time_crisis_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_crisis_edge_fill(s : FinancetimecrisisEdge, v : Double) -> FinancetimecrisisEdge {
  let result = finance_time_crisis_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_edge_min(s : FinancetimecrisisEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_edge_max(s : FinancetimecrisisEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_edge_to_string(s : FinancetimecrisisEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_path_make(size : Int) -> FinancetimecrisisPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_path_len(s : FinancetimecrisisPath) -> Int { s.size }

pub fn finance_time_crisis_path_get(s : FinancetimecrisisPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_path_set(s : FinancetimecrisisPath, i : Int, v : Double) -> FinancetimecrisisPath {
  let result = finance_time_crisis_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_path_sum(s : FinancetimecrisisPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_crisis_path_mean(s : FinancetimecrisisPath) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_crisis_path_sum(s) / s.size.to_double() }
}

pub fn finance_time_crisis_path_scale(s : FinancetimecrisisPath, f : Double) -> FinancetimecrisisPath {
  let result = finance_time_crisis_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_crisis_path_add(a : FinancetimecrisisPath, b : FinancetimecrisisPath) -> FinancetimecrisisPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_crisis_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_crisis_path_copy(s : FinancetimecrisisPath) -> FinancetimecrisisPath {
  let result = finance_time_crisis_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_crisis_path_fill(s : FinancetimecrisisPath, v : Double) -> FinancetimecrisisPath {
  let result = finance_time_crisis_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_path_min(s : FinancetimecrisisPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_path_max(s : FinancetimecrisisPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_path_to_string(s : FinancetimecrisisPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_cluster_make(size : Int) -> FinancetimecrisisCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_cluster_len(s : FinancetimecrisisCluster) -> Int { s.size }

pub fn finance_time_crisis_cluster_get(s : FinancetimecrisisCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_cluster_set(s : FinancetimecrisisCluster, i : Int, v : Double) -> FinancetimecrisisCluster {
  let result = finance_time_crisis_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_cluster_sum(s : FinancetimecrisisCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_crisis_cluster_mean(s : FinancetimecrisisCluster) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_crisis_cluster_sum(s) / s.size.to_double() }
}

pub fn finance_time_crisis_cluster_scale(s : FinancetimecrisisCluster, f : Double) -> FinancetimecrisisCluster {
  let result = finance_time_crisis_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_crisis_cluster_add(a : FinancetimecrisisCluster, b : FinancetimecrisisCluster) -> FinancetimecrisisCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_crisis_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_crisis_cluster_copy(s : FinancetimecrisisCluster) -> FinancetimecrisisCluster {
  let result = finance_time_crisis_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_crisis_cluster_fill(s : FinancetimecrisisCluster, v : Double) -> FinancetimecrisisCluster {
  let result = finance_time_crisis_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_cluster_min(s : FinancetimecrisisCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_cluster_max(s : FinancetimecrisisCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_cluster_to_string(s : FinancetimecrisisCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_model_make(size : Int) -> FinancetimecrisisModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_model_len(s : FinancetimecrisisModel) -> Int { s.size }

pub fn finance_time_crisis_model_get(s : FinancetimecrisisModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_model_set(s : FinancetimecrisisModel, i : Int, v : Double) -> FinancetimecrisisModel {
  let result = finance_time_crisis_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_model_sum(s : FinancetimecrisisModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_crisis_model_mean(s : FinancetimecrisisModel) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_crisis_model_sum(s) / s.size.to_double() }
}

pub fn finance_time_crisis_model_scale(s : FinancetimecrisisModel, f : Double) -> FinancetimecrisisModel {
  let result = finance_time_crisis_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_crisis_model_add(a : FinancetimecrisisModel, b : FinancetimecrisisModel) -> FinancetimecrisisModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_crisis_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_crisis_model_copy(s : FinancetimecrisisModel) -> FinancetimecrisisModel {
  let result = finance_time_crisis_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_crisis_model_fill(s : FinancetimecrisisModel, v : Double) -> FinancetimecrisisModel {
  let result = finance_time_crisis_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_model_min(s : FinancetimecrisisModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_model_max(s : FinancetimecrisisModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_model_to_string(s : FinancetimecrisisModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_layer_make(size : Int) -> FinancetimecrisisLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_layer_len(s : FinancetimecrisisLayer) -> Int { s.size }

pub fn finance_time_crisis_layer_get(s : FinancetimecrisisLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_layer_set(s : FinancetimecrisisLayer, i : Int, v : Double) -> FinancetimecrisisLayer {
  let result = finance_time_crisis_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_layer_sum(s : FinancetimecrisisLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_crisis_layer_mean(s : FinancetimecrisisLayer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_crisis_layer_sum(s) / s.size.to_double() }
}

pub fn finance_time_crisis_layer_scale(s : FinancetimecrisisLayer, f : Double) -> FinancetimecrisisLayer {
  let result = finance_time_crisis_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_crisis_layer_add(a : FinancetimecrisisLayer, b : FinancetimecrisisLayer) -> FinancetimecrisisLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_crisis_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_crisis_layer_copy(s : FinancetimecrisisLayer) -> FinancetimecrisisLayer {
  let result = finance_time_crisis_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_crisis_layer_fill(s : FinancetimecrisisLayer, v : Double) -> FinancetimecrisisLayer {
  let result = finance_time_crisis_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_layer_min(s : FinancetimecrisisLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_layer_max(s : FinancetimecrisisLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_layer_to_string(s : FinancetimecrisisLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_buffer_make(size : Int) -> FinancetimecrisisBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_buffer_len(s : FinancetimecrisisBuffer) -> Int { s.size }

pub fn finance_time_crisis_buffer_get(s : FinancetimecrisisBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_buffer_set(s : FinancetimecrisisBuffer, i : Int, v : Double) -> FinancetimecrisisBuffer {
  let result = finance_time_crisis_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_buffer_sum(s : FinancetimecrisisBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_crisis_buffer_mean(s : FinancetimecrisisBuffer) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_crisis_buffer_sum(s) / s.size.to_double() }
}

pub fn finance_time_crisis_buffer_scale(s : FinancetimecrisisBuffer, f : Double) -> FinancetimecrisisBuffer {
  let result = finance_time_crisis_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_crisis_buffer_add(a : FinancetimecrisisBuffer, b : FinancetimecrisisBuffer) -> FinancetimecrisisBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_crisis_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_crisis_buffer_copy(s : FinancetimecrisisBuffer) -> FinancetimecrisisBuffer {
  let result = finance_time_crisis_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_crisis_buffer_fill(s : FinancetimecrisisBuffer, v : Double) -> FinancetimecrisisBuffer {
  let result = finance_time_crisis_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_buffer_min(s : FinancetimecrisisBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_buffer_max(s : FinancetimecrisisBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_buffer_to_string(s : FinancetimecrisisBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_cursor_make(size : Int) -> FinancetimecrisisCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_cursor_len(s : FinancetimecrisisCursor) -> Int { s.size }

pub fn finance_time_crisis_cursor_get(s : FinancetimecrisisCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_cursor_set(s : FinancetimecrisisCursor, i : Int, v : Double) -> FinancetimecrisisCursor {
  let result = finance_time_crisis_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_cursor_sum(s : FinancetimecrisisCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_crisis_cursor_mean(s : FinancetimecrisisCursor) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_crisis_cursor_sum(s) / s.size.to_double() }
}

pub fn finance_time_crisis_cursor_scale(s : FinancetimecrisisCursor, f : Double) -> FinancetimecrisisCursor {
  let result = finance_time_crisis_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_crisis_cursor_add(a : FinancetimecrisisCursor, b : FinancetimecrisisCursor) -> FinancetimecrisisCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_crisis_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_crisis_cursor_copy(s : FinancetimecrisisCursor) -> FinancetimecrisisCursor {
  let result = finance_time_crisis_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_crisis_cursor_fill(s : FinancetimecrisisCursor, v : Double) -> FinancetimecrisisCursor {
  let result = finance_time_crisis_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_cursor_min(s : FinancetimecrisisCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_cursor_max(s : FinancetimecrisisCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_cursor_to_string(s : FinancetimecrisisCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_view_make(size : Int) -> FinancetimecrisisView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_view_len(s : FinancetimecrisisView) -> Int { s.size }

pub fn finance_time_crisis_view_get(s : FinancetimecrisisView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_view_set(s : FinancetimecrisisView, i : Int, v : Double) -> FinancetimecrisisView {
  let result = finance_time_crisis_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_view_sum(s : FinancetimecrisisView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_crisis_view_mean(s : FinancetimecrisisView) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_crisis_view_sum(s) / s.size.to_double() }
}

pub fn finance_time_crisis_view_scale(s : FinancetimecrisisView, f : Double) -> FinancetimecrisisView {
  let result = finance_time_crisis_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_crisis_view_add(a : FinancetimecrisisView, b : FinancetimecrisisView) -> FinancetimecrisisView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_crisis_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_crisis_view_copy(s : FinancetimecrisisView) -> FinancetimecrisisView {
  let result = finance_time_crisis_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_crisis_view_fill(s : FinancetimecrisisView, v : Double) -> FinancetimecrisisView {
  let result = finance_time_crisis_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_view_min(s : FinancetimecrisisView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_view_max(s : FinancetimecrisisView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_view_to_string(s : FinancetimecrisisView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_range_make(size : Int) -> FinancetimecrisisRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_range_len(s : FinancetimecrisisRange) -> Int { s.size }

pub fn finance_time_crisis_range_get(s : FinancetimecrisisRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_range_set(s : FinancetimecrisisRange, i : Int, v : Double) -> FinancetimecrisisRange {
  let result = finance_time_crisis_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_range_sum(s : FinancetimecrisisRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_crisis_range_mean(s : FinancetimecrisisRange) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_crisis_range_sum(s) / s.size.to_double() }
}

pub fn finance_time_crisis_range_scale(s : FinancetimecrisisRange, f : Double) -> FinancetimecrisisRange {
  let result = finance_time_crisis_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_crisis_range_add(a : FinancetimecrisisRange, b : FinancetimecrisisRange) -> FinancetimecrisisRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_crisis_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_crisis_range_copy(s : FinancetimecrisisRange) -> FinancetimecrisisRange {
  let result = finance_time_crisis_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_crisis_range_fill(s : FinancetimecrisisRange, v : Double) -> FinancetimecrisisRange {
  let result = finance_time_crisis_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_range_min(s : FinancetimecrisisRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_range_max(s : FinancetimecrisisRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_range_to_string(s : FinancetimecrisisRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct FinancetimecrisisSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn finance_time_crisis_slice_make(size : Int) -> FinancetimecrisisSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn finance_time_crisis_slice_len(s : FinancetimecrisisSlice) -> Int { s.size }

pub fn finance_time_crisis_slice_get(s : FinancetimecrisisSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn finance_time_crisis_slice_set(s : FinancetimecrisisSlice, i : Int, v : Double) -> FinancetimecrisisSlice {
  let result = finance_time_crisis_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_slice_sum(s : FinancetimecrisisSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn finance_time_crisis_slice_mean(s : FinancetimecrisisSlice) -> Double {
  if s.size == 0 { 0.0 } else { finance_time_crisis_slice_sum(s) / s.size.to_double() }
}

pub fn finance_time_crisis_slice_scale(s : FinancetimecrisisSlice, f : Double) -> FinancetimecrisisSlice {
  let result = finance_time_crisis_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn finance_time_crisis_slice_add(a : FinancetimecrisisSlice, b : FinancetimecrisisSlice) -> FinancetimecrisisSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = finance_time_crisis_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn finance_time_crisis_slice_copy(s : FinancetimecrisisSlice) -> FinancetimecrisisSlice {
  let result = finance_time_crisis_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn finance_time_crisis_slice_fill(s : FinancetimecrisisSlice, v : Double) -> FinancetimecrisisSlice {
  let result = finance_time_crisis_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn finance_time_crisis_slice_min(s : FinancetimecrisisSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_slice_max(s : FinancetimecrisisSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn finance_time_crisis_slice_to_string(s : FinancetimecrisisSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

