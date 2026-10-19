///===
/// extcore/math_quaternion

pub(all) struct MathquaternionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_quaternion_make_point(x : Double, y : Double) -> MathquaternionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_quaternion_make_point3(x : Double, y : Double, z : Double) -> MathquaternionPoint {
  { x, y, z, label: 0 }
}

pub fn math_quaternion_point_x(pt : MathquaternionPoint) -> Double { pt.x }

pub fn math_quaternion_point_y(pt : MathquaternionPoint) -> Double { pt.y }

pub fn math_quaternion_point_z(pt : MathquaternionPoint) -> Double { pt.z }

pub fn math_quaternion_point_label(pt : MathquaternionPoint) -> Int { pt.label }

pub fn math_quaternion_point_dist(a : MathquaternionPoint, b : MathquaternionPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_quaternion_point_add(a : MathquaternionPoint, b : MathquaternionPoint) -> MathquaternionPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_quaternion_point_sub(a : MathquaternionPoint, b : MathquaternionPoint) -> MathquaternionPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_quaternion_point_scale(pt : MathquaternionPoint, s : Double) -> MathquaternionPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_quaternion_point_dot(a : MathquaternionPoint, b : MathquaternionPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_quaternion_point_cross(a : MathquaternionPoint, b : MathquaternionPoint) -> MathquaternionPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_quaternion_point_norm(pt : MathquaternionPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_quaternion_point_normalize(pt : MathquaternionPoint) -> MathquaternionPoint {
  let n = math_quaternion_point_norm(pt)
  if n < 0.0000001 { pt } else { math_quaternion_point_scale(pt, 1.0 / n) }
}

pub fn math_quaternion_point_negate(pt : MathquaternionPoint) -> MathquaternionPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_quaternion_point_mid(a : MathquaternionPoint, b : MathquaternionPoint) -> MathquaternionPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_quaternion_point_lerp(a : MathquaternionPoint, b : MathquaternionPoint, t : Double) -> MathquaternionPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_quaternion_point_to_string(pt : MathquaternionPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathquaternionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_quaternion_make_series(vals : Array[Double], name : String) -> MathquaternionSeries {
  { vals, name, meta: 0 }
}

pub fn math_quaternion_series_len(s : MathquaternionSeries) -> Int { s.vals.length() }

pub fn math_quaternion_series_sum(s : MathquaternionSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_quaternion_series_mean(s : MathquaternionSeries) -> Double {
  let n = math_quaternion_series_len(s)
  if n == 0 { 0.0 } else { math_quaternion_series_sum(s) / n.to_double() }
}

pub fn math_quaternion_series_min(s : MathquaternionSeries) -> Double {
  let n = math_quaternion_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_quaternion_series_max(s : MathquaternionSeries) -> Double {
  let n = math_quaternion_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_quaternion_series_range(s : MathquaternionSeries) -> Double {
  math_quaternion_series_max(s) - math_quaternion_series_min(s)
}

pub fn math_quaternion_series_var(s : MathquaternionSeries) -> Double {
  let n = math_quaternion_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_quaternion_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_quaternion_series_std(s : MathquaternionSeries) -> Double { @_common.sqrt(math_quaternion_series_var(s)) }

pub fn math_quaternion_series_median(s : MathquaternionSeries) -> Double {
  let n = math_quaternion_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_quaternion_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_quaternion_series_scale(s : MathquaternionSeries, f : Double) -> MathquaternionSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_quaternion_series_add(a : MathquaternionSeries, b : MathquaternionSeries) -> MathquaternionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_quaternion_series_sub(a : MathquaternionSeries, b : MathquaternionSeries) -> MathquaternionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_quaternion_series_normalize(s : MathquaternionSeries) -> MathquaternionSeries {
  let mn = math_quaternion_series_min(s)
  let mx = math_quaternion_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_quaternion_series_cumsum(s : MathquaternionSeries) -> MathquaternionSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_quaternion_series_to_string(s : MathquaternionSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathquaternionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_quaternion_make_matrix(rows : Int, cols : Int, val : Double) -> MathquaternionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_quaternion_matrix_identity(n : Int) -> MathquaternionMatrix {
  let m = math_quaternion_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_quaternion_matrix_get(m : MathquaternionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_quaternion_matrix_transpose(m : MathquaternionMatrix) -> MathquaternionMatrix {
  let result = math_quaternion_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_quaternion_matrix_add(a : MathquaternionMatrix, b : MathquaternionMatrix) -> MathquaternionMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_quaternion_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_quaternion_matrix_scale(m : MathquaternionMatrix, s : Double) -> MathquaternionMatrix {
  let result = math_quaternion_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_quaternion_matrix_multiply(a : MathquaternionMatrix, b : MathquaternionMatrix) -> MathquaternionMatrix {
  if a.cols != b.rows { return math_quaternion_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_quaternion_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_quaternion_matrix_trace(m : MathquaternionMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_quaternion_matrix_det(m : MathquaternionMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_quaternion_matrix_norm(m : MathquaternionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_quaternion_matrix_to_string(m : MathquaternionMatrix) -> String {
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

pub(all) struct MathquaternionVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_quaternion_make_vector(comps : Array[Double]) -> MathquaternionVector {
  { comps, dim: comps.length() }
}

pub fn math_quaternion_vector_zero(dim : Int) -> MathquaternionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_quaternion_vector_add(a : MathquaternionVector, b : MathquaternionVector) -> MathquaternionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_quaternion_vector_sub(a : MathquaternionVector, b : MathquaternionVector) -> MathquaternionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_quaternion_vector_scale(v : MathquaternionVector, s : Double) -> MathquaternionVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_quaternion_vector_dot(a : MathquaternionVector, b : MathquaternionVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_quaternion_vector_norm(v : MathquaternionVector) -> Double { @_common.sqrt(math_quaternion_vector_dot(v, v)) }

pub fn math_quaternion_vector_normalize(v : MathquaternionVector) -> MathquaternionVector {
  let n = math_quaternion_vector_norm(v)
  if n < 0.0000001 { v } else { math_quaternion_vector_scale(v, 1.0 / n) }
}

pub fn math_quaternion_vector_dist(a : MathquaternionVector, b : MathquaternionVector) -> Double {
  math_quaternion_vector_norm(math_quaternion_vector_sub(a, b))
}

pub fn math_quaternion_vector_to_string(v : MathquaternionVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_quaternion_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_quaternion_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_quaternion_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_quaternion_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_quaternion_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_quaternion_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_quaternion_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_quaternion_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_quaternion_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_quaternion_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_quaternion_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_quaternion_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_quaternion_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_quaternion_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_quaternion_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_quaternion_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_quaternion_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_quaternion_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_quaternion_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_quaternion_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_quaternion_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_quaternion_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_quaternion_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_quaternion_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_quaternion_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_quaternion_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_quaternion_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_quaternion_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_quaternion_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathquaternionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_frame_make(size : Int) -> MathquaternionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_frame_len(s : MathquaternionFrame) -> Int { s.size }

pub fn math_quaternion_frame_get(s : MathquaternionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_frame_set(s : MathquaternionFrame, i : Int, v : Double) -> MathquaternionFrame {
  let result = math_quaternion_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_frame_sum(s : MathquaternionFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quaternion_frame_mean(s : MathquaternionFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_quaternion_frame_sum(s) / s.size.to_double() }
}

pub fn math_quaternion_frame_scale(s : MathquaternionFrame, f : Double) -> MathquaternionFrame {
  let result = math_quaternion_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quaternion_frame_add(a : MathquaternionFrame, b : MathquaternionFrame) -> MathquaternionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quaternion_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quaternion_frame_copy(s : MathquaternionFrame) -> MathquaternionFrame {
  let result = math_quaternion_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quaternion_frame_fill(s : MathquaternionFrame, v : Double) -> MathquaternionFrame {
  let result = math_quaternion_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_frame_min(s : MathquaternionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_frame_max(s : MathquaternionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_frame_to_string(s : MathquaternionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_table_make(size : Int) -> MathquaternionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_table_len(s : MathquaternionTable) -> Int { s.size }

pub fn math_quaternion_table_get(s : MathquaternionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_table_set(s : MathquaternionTable, i : Int, v : Double) -> MathquaternionTable {
  let result = math_quaternion_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_table_sum(s : MathquaternionTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quaternion_table_mean(s : MathquaternionTable) -> Double {
  if s.size == 0 { 0.0 } else { math_quaternion_table_sum(s) / s.size.to_double() }
}

pub fn math_quaternion_table_scale(s : MathquaternionTable, f : Double) -> MathquaternionTable {
  let result = math_quaternion_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quaternion_table_add(a : MathquaternionTable, b : MathquaternionTable) -> MathquaternionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quaternion_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quaternion_table_copy(s : MathquaternionTable) -> MathquaternionTable {
  let result = math_quaternion_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quaternion_table_fill(s : MathquaternionTable, v : Double) -> MathquaternionTable {
  let result = math_quaternion_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_table_min(s : MathquaternionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_table_max(s : MathquaternionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_table_to_string(s : MathquaternionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_graphn_make(size : Int) -> MathquaternionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_graphn_len(s : MathquaternionGraphN) -> Int { s.size }

pub fn math_quaternion_graphn_get(s : MathquaternionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_graphn_set(s : MathquaternionGraphN, i : Int, v : Double) -> MathquaternionGraphN {
  let result = math_quaternion_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_graphn_sum(s : MathquaternionGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quaternion_graphn_mean(s : MathquaternionGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_quaternion_graphn_sum(s) / s.size.to_double() }
}

pub fn math_quaternion_graphn_scale(s : MathquaternionGraphN, f : Double) -> MathquaternionGraphN {
  let result = math_quaternion_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quaternion_graphn_add(a : MathquaternionGraphN, b : MathquaternionGraphN) -> MathquaternionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quaternion_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quaternion_graphn_copy(s : MathquaternionGraphN) -> MathquaternionGraphN {
  let result = math_quaternion_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quaternion_graphn_fill(s : MathquaternionGraphN, v : Double) -> MathquaternionGraphN {
  let result = math_quaternion_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_graphn_min(s : MathquaternionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_graphn_max(s : MathquaternionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_graphn_to_string(s : MathquaternionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_node_make(size : Int) -> MathquaternionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_node_len(s : MathquaternionNode) -> Int { s.size }

pub fn math_quaternion_node_get(s : MathquaternionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_node_set(s : MathquaternionNode, i : Int, v : Double) -> MathquaternionNode {
  let result = math_quaternion_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_node_sum(s : MathquaternionNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quaternion_node_mean(s : MathquaternionNode) -> Double {
  if s.size == 0 { 0.0 } else { math_quaternion_node_sum(s) / s.size.to_double() }
}

pub fn math_quaternion_node_scale(s : MathquaternionNode, f : Double) -> MathquaternionNode {
  let result = math_quaternion_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quaternion_node_add(a : MathquaternionNode, b : MathquaternionNode) -> MathquaternionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quaternion_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quaternion_node_copy(s : MathquaternionNode) -> MathquaternionNode {
  let result = math_quaternion_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quaternion_node_fill(s : MathquaternionNode, v : Double) -> MathquaternionNode {
  let result = math_quaternion_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_node_min(s : MathquaternionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_node_max(s : MathquaternionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_node_to_string(s : MathquaternionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_edge_make(size : Int) -> MathquaternionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_edge_len(s : MathquaternionEdge) -> Int { s.size }

pub fn math_quaternion_edge_get(s : MathquaternionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_edge_set(s : MathquaternionEdge, i : Int, v : Double) -> MathquaternionEdge {
  let result = math_quaternion_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_edge_sum(s : MathquaternionEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quaternion_edge_mean(s : MathquaternionEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_quaternion_edge_sum(s) / s.size.to_double() }
}

pub fn math_quaternion_edge_scale(s : MathquaternionEdge, f : Double) -> MathquaternionEdge {
  let result = math_quaternion_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quaternion_edge_add(a : MathquaternionEdge, b : MathquaternionEdge) -> MathquaternionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quaternion_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quaternion_edge_copy(s : MathquaternionEdge) -> MathquaternionEdge {
  let result = math_quaternion_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quaternion_edge_fill(s : MathquaternionEdge, v : Double) -> MathquaternionEdge {
  let result = math_quaternion_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_edge_min(s : MathquaternionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_edge_max(s : MathquaternionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_edge_to_string(s : MathquaternionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_path_make(size : Int) -> MathquaternionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_path_len(s : MathquaternionPath) -> Int { s.size }

pub fn math_quaternion_path_get(s : MathquaternionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_path_set(s : MathquaternionPath, i : Int, v : Double) -> MathquaternionPath {
  let result = math_quaternion_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_path_sum(s : MathquaternionPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quaternion_path_mean(s : MathquaternionPath) -> Double {
  if s.size == 0 { 0.0 } else { math_quaternion_path_sum(s) / s.size.to_double() }
}

pub fn math_quaternion_path_scale(s : MathquaternionPath, f : Double) -> MathquaternionPath {
  let result = math_quaternion_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quaternion_path_add(a : MathquaternionPath, b : MathquaternionPath) -> MathquaternionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quaternion_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quaternion_path_copy(s : MathquaternionPath) -> MathquaternionPath {
  let result = math_quaternion_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quaternion_path_fill(s : MathquaternionPath, v : Double) -> MathquaternionPath {
  let result = math_quaternion_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_path_min(s : MathquaternionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_path_max(s : MathquaternionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_path_to_string(s : MathquaternionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_cluster_make(size : Int) -> MathquaternionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_cluster_len(s : MathquaternionCluster) -> Int { s.size }

pub fn math_quaternion_cluster_get(s : MathquaternionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_cluster_set(s : MathquaternionCluster, i : Int, v : Double) -> MathquaternionCluster {
  let result = math_quaternion_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_cluster_sum(s : MathquaternionCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quaternion_cluster_mean(s : MathquaternionCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_quaternion_cluster_sum(s) / s.size.to_double() }
}

pub fn math_quaternion_cluster_scale(s : MathquaternionCluster, f : Double) -> MathquaternionCluster {
  let result = math_quaternion_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quaternion_cluster_add(a : MathquaternionCluster, b : MathquaternionCluster) -> MathquaternionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quaternion_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quaternion_cluster_copy(s : MathquaternionCluster) -> MathquaternionCluster {
  let result = math_quaternion_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quaternion_cluster_fill(s : MathquaternionCluster, v : Double) -> MathquaternionCluster {
  let result = math_quaternion_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_cluster_min(s : MathquaternionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_cluster_max(s : MathquaternionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_cluster_to_string(s : MathquaternionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_model_make(size : Int) -> MathquaternionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_model_len(s : MathquaternionModel) -> Int { s.size }

pub fn math_quaternion_model_get(s : MathquaternionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_model_set(s : MathquaternionModel, i : Int, v : Double) -> MathquaternionModel {
  let result = math_quaternion_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_model_sum(s : MathquaternionModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quaternion_model_mean(s : MathquaternionModel) -> Double {
  if s.size == 0 { 0.0 } else { math_quaternion_model_sum(s) / s.size.to_double() }
}

pub fn math_quaternion_model_scale(s : MathquaternionModel, f : Double) -> MathquaternionModel {
  let result = math_quaternion_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quaternion_model_add(a : MathquaternionModel, b : MathquaternionModel) -> MathquaternionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quaternion_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quaternion_model_copy(s : MathquaternionModel) -> MathquaternionModel {
  let result = math_quaternion_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quaternion_model_fill(s : MathquaternionModel, v : Double) -> MathquaternionModel {
  let result = math_quaternion_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_model_min(s : MathquaternionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_model_max(s : MathquaternionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_model_to_string(s : MathquaternionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_layer_make(size : Int) -> MathquaternionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_layer_len(s : MathquaternionLayer) -> Int { s.size }

pub fn math_quaternion_layer_get(s : MathquaternionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_layer_set(s : MathquaternionLayer, i : Int, v : Double) -> MathquaternionLayer {
  let result = math_quaternion_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_layer_sum(s : MathquaternionLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quaternion_layer_mean(s : MathquaternionLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_quaternion_layer_sum(s) / s.size.to_double() }
}

pub fn math_quaternion_layer_scale(s : MathquaternionLayer, f : Double) -> MathquaternionLayer {
  let result = math_quaternion_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quaternion_layer_add(a : MathquaternionLayer, b : MathquaternionLayer) -> MathquaternionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quaternion_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quaternion_layer_copy(s : MathquaternionLayer) -> MathquaternionLayer {
  let result = math_quaternion_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quaternion_layer_fill(s : MathquaternionLayer, v : Double) -> MathquaternionLayer {
  let result = math_quaternion_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_layer_min(s : MathquaternionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_layer_max(s : MathquaternionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_layer_to_string(s : MathquaternionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_buffer_make(size : Int) -> MathquaternionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_buffer_len(s : MathquaternionBuffer) -> Int { s.size }

pub fn math_quaternion_buffer_get(s : MathquaternionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_buffer_set(s : MathquaternionBuffer, i : Int, v : Double) -> MathquaternionBuffer {
  let result = math_quaternion_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_buffer_sum(s : MathquaternionBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quaternion_buffer_mean(s : MathquaternionBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_quaternion_buffer_sum(s) / s.size.to_double() }
}

pub fn math_quaternion_buffer_scale(s : MathquaternionBuffer, f : Double) -> MathquaternionBuffer {
  let result = math_quaternion_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quaternion_buffer_add(a : MathquaternionBuffer, b : MathquaternionBuffer) -> MathquaternionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quaternion_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quaternion_buffer_copy(s : MathquaternionBuffer) -> MathquaternionBuffer {
  let result = math_quaternion_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quaternion_buffer_fill(s : MathquaternionBuffer, v : Double) -> MathquaternionBuffer {
  let result = math_quaternion_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_buffer_min(s : MathquaternionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_buffer_max(s : MathquaternionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_buffer_to_string(s : MathquaternionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_cursor_make(size : Int) -> MathquaternionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_cursor_len(s : MathquaternionCursor) -> Int { s.size }

pub fn math_quaternion_cursor_get(s : MathquaternionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_cursor_set(s : MathquaternionCursor, i : Int, v : Double) -> MathquaternionCursor {
  let result = math_quaternion_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_cursor_sum(s : MathquaternionCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quaternion_cursor_mean(s : MathquaternionCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_quaternion_cursor_sum(s) / s.size.to_double() }
}

pub fn math_quaternion_cursor_scale(s : MathquaternionCursor, f : Double) -> MathquaternionCursor {
  let result = math_quaternion_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quaternion_cursor_add(a : MathquaternionCursor, b : MathquaternionCursor) -> MathquaternionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quaternion_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quaternion_cursor_copy(s : MathquaternionCursor) -> MathquaternionCursor {
  let result = math_quaternion_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quaternion_cursor_fill(s : MathquaternionCursor, v : Double) -> MathquaternionCursor {
  let result = math_quaternion_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_cursor_min(s : MathquaternionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_cursor_max(s : MathquaternionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_cursor_to_string(s : MathquaternionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_view_make(size : Int) -> MathquaternionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_view_len(s : MathquaternionView) -> Int { s.size }

pub fn math_quaternion_view_get(s : MathquaternionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_view_set(s : MathquaternionView, i : Int, v : Double) -> MathquaternionView {
  let result = math_quaternion_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_view_sum(s : MathquaternionView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quaternion_view_mean(s : MathquaternionView) -> Double {
  if s.size == 0 { 0.0 } else { math_quaternion_view_sum(s) / s.size.to_double() }
}

pub fn math_quaternion_view_scale(s : MathquaternionView, f : Double) -> MathquaternionView {
  let result = math_quaternion_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quaternion_view_add(a : MathquaternionView, b : MathquaternionView) -> MathquaternionView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quaternion_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quaternion_view_copy(s : MathquaternionView) -> MathquaternionView {
  let result = math_quaternion_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quaternion_view_fill(s : MathquaternionView, v : Double) -> MathquaternionView {
  let result = math_quaternion_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_view_min(s : MathquaternionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_view_max(s : MathquaternionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_view_to_string(s : MathquaternionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_range_make(size : Int) -> MathquaternionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_range_len(s : MathquaternionRange) -> Int { s.size }

pub fn math_quaternion_range_get(s : MathquaternionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_range_set(s : MathquaternionRange, i : Int, v : Double) -> MathquaternionRange {
  let result = math_quaternion_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_range_sum(s : MathquaternionRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quaternion_range_mean(s : MathquaternionRange) -> Double {
  if s.size == 0 { 0.0 } else { math_quaternion_range_sum(s) / s.size.to_double() }
}

pub fn math_quaternion_range_scale(s : MathquaternionRange, f : Double) -> MathquaternionRange {
  let result = math_quaternion_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quaternion_range_add(a : MathquaternionRange, b : MathquaternionRange) -> MathquaternionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quaternion_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quaternion_range_copy(s : MathquaternionRange) -> MathquaternionRange {
  let result = math_quaternion_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quaternion_range_fill(s : MathquaternionRange, v : Double) -> MathquaternionRange {
  let result = math_quaternion_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_range_min(s : MathquaternionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_range_max(s : MathquaternionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_range_to_string(s : MathquaternionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquaternionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quaternion_slice_make(size : Int) -> MathquaternionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quaternion_slice_len(s : MathquaternionSlice) -> Int { s.size }

pub fn math_quaternion_slice_get(s : MathquaternionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quaternion_slice_set(s : MathquaternionSlice, i : Int, v : Double) -> MathquaternionSlice {
  let result = math_quaternion_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_slice_sum(s : MathquaternionSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quaternion_slice_mean(s : MathquaternionSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_quaternion_slice_sum(s) / s.size.to_double() }
}

pub fn math_quaternion_slice_scale(s : MathquaternionSlice, f : Double) -> MathquaternionSlice {
  let result = math_quaternion_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quaternion_slice_add(a : MathquaternionSlice, b : MathquaternionSlice) -> MathquaternionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quaternion_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quaternion_slice_copy(s : MathquaternionSlice) -> MathquaternionSlice {
  let result = math_quaternion_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quaternion_slice_fill(s : MathquaternionSlice, v : Double) -> MathquaternionSlice {
  let result = math_quaternion_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quaternion_slice_min(s : MathquaternionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_slice_max(s : MathquaternionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quaternion_slice_to_string(s : MathquaternionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

