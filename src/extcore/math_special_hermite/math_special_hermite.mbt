///===
/// extcore/math_special_hermite

pub(all) struct MathspecialhermitePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_hermite_make_point(x : Double, y : Double) -> MathspecialhermitePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_hermite_make_point3(x : Double, y : Double, z : Double) -> MathspecialhermitePoint {
  { x, y, z, label: 0 }
}

pub fn math_special_hermite_point_x(pt : MathspecialhermitePoint) -> Double { pt.x }

pub fn math_special_hermite_point_y(pt : MathspecialhermitePoint) -> Double { pt.y }

pub fn math_special_hermite_point_z(pt : MathspecialhermitePoint) -> Double { pt.z }

pub fn math_special_hermite_point_label(pt : MathspecialhermitePoint) -> Int { pt.label }

pub fn math_special_hermite_point_dist(a : MathspecialhermitePoint, b : MathspecialhermitePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_special_hermite_point_add(a : MathspecialhermitePoint, b : MathspecialhermitePoint) -> MathspecialhermitePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_special_hermite_point_sub(a : MathspecialhermitePoint, b : MathspecialhermitePoint) -> MathspecialhermitePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_special_hermite_point_scale(pt : MathspecialhermitePoint, s : Double) -> MathspecialhermitePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_special_hermite_point_dot(a : MathspecialhermitePoint, b : MathspecialhermitePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_special_hermite_point_cross(a : MathspecialhermitePoint, b : MathspecialhermitePoint) -> MathspecialhermitePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_special_hermite_point_norm(pt : MathspecialhermitePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_special_hermite_point_normalize(pt : MathspecialhermitePoint) -> MathspecialhermitePoint {
  let n = math_special_hermite_point_norm(pt)
  if n < 0.0000001 { pt } else { math_special_hermite_point_scale(pt, 1.0 / n) }
}

pub fn math_special_hermite_point_negate(pt : MathspecialhermitePoint) -> MathspecialhermitePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_special_hermite_point_mid(a : MathspecialhermitePoint, b : MathspecialhermitePoint) -> MathspecialhermitePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_special_hermite_point_lerp(a : MathspecialhermitePoint, b : MathspecialhermitePoint, t : Double) -> MathspecialhermitePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_special_hermite_point_to_string(pt : MathspecialhermitePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathspecialhermiteSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_hermite_make_series(vals : Array[Double], name : String) -> MathspecialhermiteSeries {
  { vals, name, meta: 0 }
}

pub fn math_special_hermite_series_len(s : MathspecialhermiteSeries) -> Int { s.vals.length() }

pub fn math_special_hermite_series_sum(s : MathspecialhermiteSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_special_hermite_series_mean(s : MathspecialhermiteSeries) -> Double {
  let n = math_special_hermite_series_len(s)
  if n == 0 { 0.0 } else { math_special_hermite_series_sum(s) / n.to_double() }
}

pub fn math_special_hermite_series_min(s : MathspecialhermiteSeries) -> Double {
  let n = math_special_hermite_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_special_hermite_series_max(s : MathspecialhermiteSeries) -> Double {
  let n = math_special_hermite_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_special_hermite_series_range(s : MathspecialhermiteSeries) -> Double {
  math_special_hermite_series_max(s) - math_special_hermite_series_min(s)
}

pub fn math_special_hermite_series_var(s : MathspecialhermiteSeries) -> Double {
  let n = math_special_hermite_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_special_hermite_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_special_hermite_series_std(s : MathspecialhermiteSeries) -> Double { @_common.sqrt(math_special_hermite_series_var(s)) }

pub fn math_special_hermite_series_median(s : MathspecialhermiteSeries) -> Double {
  let n = math_special_hermite_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_special_hermite_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_special_hermite_series_scale(s : MathspecialhermiteSeries, f : Double) -> MathspecialhermiteSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_special_hermite_series_add(a : MathspecialhermiteSeries, b : MathspecialhermiteSeries) -> MathspecialhermiteSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_special_hermite_series_sub(a : MathspecialhermiteSeries, b : MathspecialhermiteSeries) -> MathspecialhermiteSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_special_hermite_series_normalize(s : MathspecialhermiteSeries) -> MathspecialhermiteSeries {
  let mn = math_special_hermite_series_min(s)
  let mx = math_special_hermite_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_special_hermite_series_cumsum(s : MathspecialhermiteSeries) -> MathspecialhermiteSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_special_hermite_series_to_string(s : MathspecialhermiteSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialhermiteMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_hermite_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialhermiteMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_hermite_matrix_identity(n : Int) -> MathspecialhermiteMatrix {
  let m = math_special_hermite_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_special_hermite_matrix_get(m : MathspecialhermiteMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_special_hermite_matrix_transpose(m : MathspecialhermiteMatrix) -> MathspecialhermiteMatrix {
  let result = math_special_hermite_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_special_hermite_matrix_add(a : MathspecialhermiteMatrix, b : MathspecialhermiteMatrix) -> MathspecialhermiteMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_special_hermite_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_special_hermite_matrix_scale(m : MathspecialhermiteMatrix, s : Double) -> MathspecialhermiteMatrix {
  let result = math_special_hermite_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_special_hermite_matrix_multiply(a : MathspecialhermiteMatrix, b : MathspecialhermiteMatrix) -> MathspecialhermiteMatrix {
  if a.cols != b.rows { return math_special_hermite_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_special_hermite_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_special_hermite_matrix_trace(m : MathspecialhermiteMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_special_hermite_matrix_det(m : MathspecialhermiteMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_special_hermite_matrix_norm(m : MathspecialhermiteMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_special_hermite_matrix_to_string(m : MathspecialhermiteMatrix) -> String {
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

pub(all) struct MathspecialhermiteVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_hermite_make_vector(comps : Array[Double]) -> MathspecialhermiteVector {
  { comps, dim: comps.length() }
}

pub fn math_special_hermite_vector_zero(dim : Int) -> MathspecialhermiteVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_special_hermite_vector_add(a : MathspecialhermiteVector, b : MathspecialhermiteVector) -> MathspecialhermiteVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_hermite_vector_sub(a : MathspecialhermiteVector, b : MathspecialhermiteVector) -> MathspecialhermiteVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_hermite_vector_scale(v : MathspecialhermiteVector, s : Double) -> MathspecialhermiteVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_special_hermite_vector_dot(a : MathspecialhermiteVector, b : MathspecialhermiteVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_special_hermite_vector_norm(v : MathspecialhermiteVector) -> Double { @_common.sqrt(math_special_hermite_vector_dot(v, v)) }

pub fn math_special_hermite_vector_normalize(v : MathspecialhermiteVector) -> MathspecialhermiteVector {
  let n = math_special_hermite_vector_norm(v)
  if n < 0.0000001 { v } else { math_special_hermite_vector_scale(v, 1.0 / n) }
}

pub fn math_special_hermite_vector_dist(a : MathspecialhermiteVector, b : MathspecialhermiteVector) -> Double {
  math_special_hermite_vector_norm(math_special_hermite_vector_sub(a, b))
}

pub fn math_special_hermite_vector_to_string(v : MathspecialhermiteVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_hermite_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_hermite_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_hermite_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_hermite_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_hermite_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_hermite_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_hermite_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_hermite_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_hermite_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_hermite_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_hermite_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_hermite_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_hermite_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_hermite_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_hermite_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_hermite_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_hermite_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_hermite_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_hermite_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_hermite_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_hermite_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_hermite_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_hermite_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_hermite_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_hermite_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_hermite_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_hermite_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_hermite_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_hermite_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspecialhermiteFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_frame_make(size : Int) -> MathspecialhermiteFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_frame_len(s : MathspecialhermiteFrame) -> Int { s.size }

pub fn math_special_hermite_frame_get(s : MathspecialhermiteFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_frame_set(s : MathspecialhermiteFrame, i : Int, v : Double) -> MathspecialhermiteFrame {
  let result = math_special_hermite_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_frame_sum(s : MathspecialhermiteFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hermite_frame_mean(s : MathspecialhermiteFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hermite_frame_sum(s) / s.size.to_double() }
}

pub fn math_special_hermite_frame_scale(s : MathspecialhermiteFrame, f : Double) -> MathspecialhermiteFrame {
  let result = math_special_hermite_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hermite_frame_add(a : MathspecialhermiteFrame, b : MathspecialhermiteFrame) -> MathspecialhermiteFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hermite_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hermite_frame_copy(s : MathspecialhermiteFrame) -> MathspecialhermiteFrame {
  let result = math_special_hermite_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hermite_frame_fill(s : MathspecialhermiteFrame, v : Double) -> MathspecialhermiteFrame {
  let result = math_special_hermite_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_frame_min(s : MathspecialhermiteFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_frame_max(s : MathspecialhermiteFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_frame_to_string(s : MathspecialhermiteFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_table_make(size : Int) -> MathspecialhermiteTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_table_len(s : MathspecialhermiteTable) -> Int { s.size }

pub fn math_special_hermite_table_get(s : MathspecialhermiteTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_table_set(s : MathspecialhermiteTable, i : Int, v : Double) -> MathspecialhermiteTable {
  let result = math_special_hermite_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_table_sum(s : MathspecialhermiteTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hermite_table_mean(s : MathspecialhermiteTable) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hermite_table_sum(s) / s.size.to_double() }
}

pub fn math_special_hermite_table_scale(s : MathspecialhermiteTable, f : Double) -> MathspecialhermiteTable {
  let result = math_special_hermite_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hermite_table_add(a : MathspecialhermiteTable, b : MathspecialhermiteTable) -> MathspecialhermiteTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hermite_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hermite_table_copy(s : MathspecialhermiteTable) -> MathspecialhermiteTable {
  let result = math_special_hermite_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hermite_table_fill(s : MathspecialhermiteTable, v : Double) -> MathspecialhermiteTable {
  let result = math_special_hermite_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_table_min(s : MathspecialhermiteTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_table_max(s : MathspecialhermiteTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_table_to_string(s : MathspecialhermiteTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_graphn_make(size : Int) -> MathspecialhermiteGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_graphn_len(s : MathspecialhermiteGraphN) -> Int { s.size }

pub fn math_special_hermite_graphn_get(s : MathspecialhermiteGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_graphn_set(s : MathspecialhermiteGraphN, i : Int, v : Double) -> MathspecialhermiteGraphN {
  let result = math_special_hermite_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_graphn_sum(s : MathspecialhermiteGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hermite_graphn_mean(s : MathspecialhermiteGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hermite_graphn_sum(s) / s.size.to_double() }
}

pub fn math_special_hermite_graphn_scale(s : MathspecialhermiteGraphN, f : Double) -> MathspecialhermiteGraphN {
  let result = math_special_hermite_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hermite_graphn_add(a : MathspecialhermiteGraphN, b : MathspecialhermiteGraphN) -> MathspecialhermiteGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hermite_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hermite_graphn_copy(s : MathspecialhermiteGraphN) -> MathspecialhermiteGraphN {
  let result = math_special_hermite_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hermite_graphn_fill(s : MathspecialhermiteGraphN, v : Double) -> MathspecialhermiteGraphN {
  let result = math_special_hermite_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_graphn_min(s : MathspecialhermiteGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_graphn_max(s : MathspecialhermiteGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_graphn_to_string(s : MathspecialhermiteGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_node_make(size : Int) -> MathspecialhermiteNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_node_len(s : MathspecialhermiteNode) -> Int { s.size }

pub fn math_special_hermite_node_get(s : MathspecialhermiteNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_node_set(s : MathspecialhermiteNode, i : Int, v : Double) -> MathspecialhermiteNode {
  let result = math_special_hermite_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_node_sum(s : MathspecialhermiteNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hermite_node_mean(s : MathspecialhermiteNode) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hermite_node_sum(s) / s.size.to_double() }
}

pub fn math_special_hermite_node_scale(s : MathspecialhermiteNode, f : Double) -> MathspecialhermiteNode {
  let result = math_special_hermite_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hermite_node_add(a : MathspecialhermiteNode, b : MathspecialhermiteNode) -> MathspecialhermiteNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hermite_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hermite_node_copy(s : MathspecialhermiteNode) -> MathspecialhermiteNode {
  let result = math_special_hermite_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hermite_node_fill(s : MathspecialhermiteNode, v : Double) -> MathspecialhermiteNode {
  let result = math_special_hermite_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_node_min(s : MathspecialhermiteNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_node_max(s : MathspecialhermiteNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_node_to_string(s : MathspecialhermiteNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_edge_make(size : Int) -> MathspecialhermiteEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_edge_len(s : MathspecialhermiteEdge) -> Int { s.size }

pub fn math_special_hermite_edge_get(s : MathspecialhermiteEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_edge_set(s : MathspecialhermiteEdge, i : Int, v : Double) -> MathspecialhermiteEdge {
  let result = math_special_hermite_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_edge_sum(s : MathspecialhermiteEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hermite_edge_mean(s : MathspecialhermiteEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hermite_edge_sum(s) / s.size.to_double() }
}

pub fn math_special_hermite_edge_scale(s : MathspecialhermiteEdge, f : Double) -> MathspecialhermiteEdge {
  let result = math_special_hermite_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hermite_edge_add(a : MathspecialhermiteEdge, b : MathspecialhermiteEdge) -> MathspecialhermiteEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hermite_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hermite_edge_copy(s : MathspecialhermiteEdge) -> MathspecialhermiteEdge {
  let result = math_special_hermite_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hermite_edge_fill(s : MathspecialhermiteEdge, v : Double) -> MathspecialhermiteEdge {
  let result = math_special_hermite_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_edge_min(s : MathspecialhermiteEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_edge_max(s : MathspecialhermiteEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_edge_to_string(s : MathspecialhermiteEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermitePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_path_make(size : Int) -> MathspecialhermitePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_path_len(s : MathspecialhermitePath) -> Int { s.size }

pub fn math_special_hermite_path_get(s : MathspecialhermitePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_path_set(s : MathspecialhermitePath, i : Int, v : Double) -> MathspecialhermitePath {
  let result = math_special_hermite_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_path_sum(s : MathspecialhermitePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hermite_path_mean(s : MathspecialhermitePath) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hermite_path_sum(s) / s.size.to_double() }
}

pub fn math_special_hermite_path_scale(s : MathspecialhermitePath, f : Double) -> MathspecialhermitePath {
  let result = math_special_hermite_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hermite_path_add(a : MathspecialhermitePath, b : MathspecialhermitePath) -> MathspecialhermitePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hermite_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hermite_path_copy(s : MathspecialhermitePath) -> MathspecialhermitePath {
  let result = math_special_hermite_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hermite_path_fill(s : MathspecialhermitePath, v : Double) -> MathspecialhermitePath {
  let result = math_special_hermite_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_path_min(s : MathspecialhermitePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_path_max(s : MathspecialhermitePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_path_to_string(s : MathspecialhermitePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_cluster_make(size : Int) -> MathspecialhermiteCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_cluster_len(s : MathspecialhermiteCluster) -> Int { s.size }

pub fn math_special_hermite_cluster_get(s : MathspecialhermiteCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_cluster_set(s : MathspecialhermiteCluster, i : Int, v : Double) -> MathspecialhermiteCluster {
  let result = math_special_hermite_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_cluster_sum(s : MathspecialhermiteCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hermite_cluster_mean(s : MathspecialhermiteCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hermite_cluster_sum(s) / s.size.to_double() }
}

pub fn math_special_hermite_cluster_scale(s : MathspecialhermiteCluster, f : Double) -> MathspecialhermiteCluster {
  let result = math_special_hermite_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hermite_cluster_add(a : MathspecialhermiteCluster, b : MathspecialhermiteCluster) -> MathspecialhermiteCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hermite_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hermite_cluster_copy(s : MathspecialhermiteCluster) -> MathspecialhermiteCluster {
  let result = math_special_hermite_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hermite_cluster_fill(s : MathspecialhermiteCluster, v : Double) -> MathspecialhermiteCluster {
  let result = math_special_hermite_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_cluster_min(s : MathspecialhermiteCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_cluster_max(s : MathspecialhermiteCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_cluster_to_string(s : MathspecialhermiteCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_model_make(size : Int) -> MathspecialhermiteModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_model_len(s : MathspecialhermiteModel) -> Int { s.size }

pub fn math_special_hermite_model_get(s : MathspecialhermiteModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_model_set(s : MathspecialhermiteModel, i : Int, v : Double) -> MathspecialhermiteModel {
  let result = math_special_hermite_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_model_sum(s : MathspecialhermiteModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hermite_model_mean(s : MathspecialhermiteModel) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hermite_model_sum(s) / s.size.to_double() }
}

pub fn math_special_hermite_model_scale(s : MathspecialhermiteModel, f : Double) -> MathspecialhermiteModel {
  let result = math_special_hermite_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hermite_model_add(a : MathspecialhermiteModel, b : MathspecialhermiteModel) -> MathspecialhermiteModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hermite_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hermite_model_copy(s : MathspecialhermiteModel) -> MathspecialhermiteModel {
  let result = math_special_hermite_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hermite_model_fill(s : MathspecialhermiteModel, v : Double) -> MathspecialhermiteModel {
  let result = math_special_hermite_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_model_min(s : MathspecialhermiteModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_model_max(s : MathspecialhermiteModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_model_to_string(s : MathspecialhermiteModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_layer_make(size : Int) -> MathspecialhermiteLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_layer_len(s : MathspecialhermiteLayer) -> Int { s.size }

pub fn math_special_hermite_layer_get(s : MathspecialhermiteLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_layer_set(s : MathspecialhermiteLayer, i : Int, v : Double) -> MathspecialhermiteLayer {
  let result = math_special_hermite_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_layer_sum(s : MathspecialhermiteLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hermite_layer_mean(s : MathspecialhermiteLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hermite_layer_sum(s) / s.size.to_double() }
}

pub fn math_special_hermite_layer_scale(s : MathspecialhermiteLayer, f : Double) -> MathspecialhermiteLayer {
  let result = math_special_hermite_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hermite_layer_add(a : MathspecialhermiteLayer, b : MathspecialhermiteLayer) -> MathspecialhermiteLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hermite_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hermite_layer_copy(s : MathspecialhermiteLayer) -> MathspecialhermiteLayer {
  let result = math_special_hermite_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hermite_layer_fill(s : MathspecialhermiteLayer, v : Double) -> MathspecialhermiteLayer {
  let result = math_special_hermite_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_layer_min(s : MathspecialhermiteLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_layer_max(s : MathspecialhermiteLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_layer_to_string(s : MathspecialhermiteLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_buffer_make(size : Int) -> MathspecialhermiteBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_buffer_len(s : MathspecialhermiteBuffer) -> Int { s.size }

pub fn math_special_hermite_buffer_get(s : MathspecialhermiteBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_buffer_set(s : MathspecialhermiteBuffer, i : Int, v : Double) -> MathspecialhermiteBuffer {
  let result = math_special_hermite_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_buffer_sum(s : MathspecialhermiteBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hermite_buffer_mean(s : MathspecialhermiteBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hermite_buffer_sum(s) / s.size.to_double() }
}

pub fn math_special_hermite_buffer_scale(s : MathspecialhermiteBuffer, f : Double) -> MathspecialhermiteBuffer {
  let result = math_special_hermite_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hermite_buffer_add(a : MathspecialhermiteBuffer, b : MathspecialhermiteBuffer) -> MathspecialhermiteBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hermite_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hermite_buffer_copy(s : MathspecialhermiteBuffer) -> MathspecialhermiteBuffer {
  let result = math_special_hermite_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hermite_buffer_fill(s : MathspecialhermiteBuffer, v : Double) -> MathspecialhermiteBuffer {
  let result = math_special_hermite_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_buffer_min(s : MathspecialhermiteBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_buffer_max(s : MathspecialhermiteBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_buffer_to_string(s : MathspecialhermiteBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_cursor_make(size : Int) -> MathspecialhermiteCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_cursor_len(s : MathspecialhermiteCursor) -> Int { s.size }

pub fn math_special_hermite_cursor_get(s : MathspecialhermiteCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_cursor_set(s : MathspecialhermiteCursor, i : Int, v : Double) -> MathspecialhermiteCursor {
  let result = math_special_hermite_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_cursor_sum(s : MathspecialhermiteCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hermite_cursor_mean(s : MathspecialhermiteCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hermite_cursor_sum(s) / s.size.to_double() }
}

pub fn math_special_hermite_cursor_scale(s : MathspecialhermiteCursor, f : Double) -> MathspecialhermiteCursor {
  let result = math_special_hermite_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hermite_cursor_add(a : MathspecialhermiteCursor, b : MathspecialhermiteCursor) -> MathspecialhermiteCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hermite_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hermite_cursor_copy(s : MathspecialhermiteCursor) -> MathspecialhermiteCursor {
  let result = math_special_hermite_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hermite_cursor_fill(s : MathspecialhermiteCursor, v : Double) -> MathspecialhermiteCursor {
  let result = math_special_hermite_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_cursor_min(s : MathspecialhermiteCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_cursor_max(s : MathspecialhermiteCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_cursor_to_string(s : MathspecialhermiteCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_view_make(size : Int) -> MathspecialhermiteView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_view_len(s : MathspecialhermiteView) -> Int { s.size }

pub fn math_special_hermite_view_get(s : MathspecialhermiteView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_view_set(s : MathspecialhermiteView, i : Int, v : Double) -> MathspecialhermiteView {
  let result = math_special_hermite_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_view_sum(s : MathspecialhermiteView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hermite_view_mean(s : MathspecialhermiteView) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hermite_view_sum(s) / s.size.to_double() }
}

pub fn math_special_hermite_view_scale(s : MathspecialhermiteView, f : Double) -> MathspecialhermiteView {
  let result = math_special_hermite_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hermite_view_add(a : MathspecialhermiteView, b : MathspecialhermiteView) -> MathspecialhermiteView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hermite_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hermite_view_copy(s : MathspecialhermiteView) -> MathspecialhermiteView {
  let result = math_special_hermite_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hermite_view_fill(s : MathspecialhermiteView, v : Double) -> MathspecialhermiteView {
  let result = math_special_hermite_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_view_min(s : MathspecialhermiteView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_view_max(s : MathspecialhermiteView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_view_to_string(s : MathspecialhermiteView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_range_make(size : Int) -> MathspecialhermiteRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_range_len(s : MathspecialhermiteRange) -> Int { s.size }

pub fn math_special_hermite_range_get(s : MathspecialhermiteRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_range_set(s : MathspecialhermiteRange, i : Int, v : Double) -> MathspecialhermiteRange {
  let result = math_special_hermite_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_range_sum(s : MathspecialhermiteRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hermite_range_mean(s : MathspecialhermiteRange) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hermite_range_sum(s) / s.size.to_double() }
}

pub fn math_special_hermite_range_scale(s : MathspecialhermiteRange, f : Double) -> MathspecialhermiteRange {
  let result = math_special_hermite_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hermite_range_add(a : MathspecialhermiteRange, b : MathspecialhermiteRange) -> MathspecialhermiteRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hermite_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hermite_range_copy(s : MathspecialhermiteRange) -> MathspecialhermiteRange {
  let result = math_special_hermite_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hermite_range_fill(s : MathspecialhermiteRange, v : Double) -> MathspecialhermiteRange {
  let result = math_special_hermite_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_range_min(s : MathspecialhermiteRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_range_max(s : MathspecialhermiteRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_range_to_string(s : MathspecialhermiteRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_slice_make(size : Int) -> MathspecialhermiteSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hermite_slice_len(s : MathspecialhermiteSlice) -> Int { s.size }

pub fn math_special_hermite_slice_get(s : MathspecialhermiteSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hermite_slice_set(s : MathspecialhermiteSlice, i : Int, v : Double) -> MathspecialhermiteSlice {
  let result = math_special_hermite_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_slice_sum(s : MathspecialhermiteSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_hermite_slice_mean(s : MathspecialhermiteSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_special_hermite_slice_sum(s) / s.size.to_double() }
}

pub fn math_special_hermite_slice_scale(s : MathspecialhermiteSlice, f : Double) -> MathspecialhermiteSlice {
  let result = math_special_hermite_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_hermite_slice_add(a : MathspecialhermiteSlice, b : MathspecialhermiteSlice) -> MathspecialhermiteSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_hermite_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_hermite_slice_copy(s : MathspecialhermiteSlice) -> MathspecialhermiteSlice {
  let result = math_special_hermite_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_hermite_slice_fill(s : MathspecialhermiteSlice, v : Double) -> MathspecialhermiteSlice {
  let result = math_special_hermite_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_hermite_slice_min(s : MathspecialhermiteSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_slice_max(s : MathspecialhermiteSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_hermite_slice_to_string(s : MathspecialhermiteSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

