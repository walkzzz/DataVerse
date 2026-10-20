///===
/// extcore/math_special_chebyshev

pub(all) struct MathspecialchebyshevPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_chebyshev_make_point(x : Double, y : Double) -> MathspecialchebyshevPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_chebyshev_make_point3(x : Double, y : Double, z : Double) -> MathspecialchebyshevPoint {
  { x, y, z, label: 0 }
}

pub fn math_special_chebyshev_point_x(pt : MathspecialchebyshevPoint) -> Double { pt.x }

pub fn math_special_chebyshev_point_y(pt : MathspecialchebyshevPoint) -> Double { pt.y }

pub fn math_special_chebyshev_point_z(pt : MathspecialchebyshevPoint) -> Double { pt.z }

pub fn math_special_chebyshev_point_label(pt : MathspecialchebyshevPoint) -> Int { pt.label }

pub fn math_special_chebyshev_point_dist(a : MathspecialchebyshevPoint, b : MathspecialchebyshevPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_special_chebyshev_point_add(a : MathspecialchebyshevPoint, b : MathspecialchebyshevPoint) -> MathspecialchebyshevPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_special_chebyshev_point_sub(a : MathspecialchebyshevPoint, b : MathspecialchebyshevPoint) -> MathspecialchebyshevPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_special_chebyshev_point_scale(pt : MathspecialchebyshevPoint, s : Double) -> MathspecialchebyshevPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_special_chebyshev_point_dot(a : MathspecialchebyshevPoint, b : MathspecialchebyshevPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_special_chebyshev_point_cross(a : MathspecialchebyshevPoint, b : MathspecialchebyshevPoint) -> MathspecialchebyshevPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_special_chebyshev_point_norm(pt : MathspecialchebyshevPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_special_chebyshev_point_normalize(pt : MathspecialchebyshevPoint) -> MathspecialchebyshevPoint {
  let n = math_special_chebyshev_point_norm(pt)
  if n < 0.0000001 { pt } else { math_special_chebyshev_point_scale(pt, 1.0 / n) }
}

pub fn math_special_chebyshev_point_negate(pt : MathspecialchebyshevPoint) -> MathspecialchebyshevPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_special_chebyshev_point_mid(a : MathspecialchebyshevPoint, b : MathspecialchebyshevPoint) -> MathspecialchebyshevPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_special_chebyshev_point_lerp(a : MathspecialchebyshevPoint, b : MathspecialchebyshevPoint, t : Double) -> MathspecialchebyshevPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_special_chebyshev_point_to_string(pt : MathspecialchebyshevPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathspecialchebyshevSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_chebyshev_make_series(vals : Array[Double], name : String) -> MathspecialchebyshevSeries {
  { vals, name, meta: 0 }
}

pub fn math_special_chebyshev_series_len(s : MathspecialchebyshevSeries) -> Int { s.vals.length() }

pub fn math_special_chebyshev_series_sum(s : MathspecialchebyshevSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_special_chebyshev_series_mean(s : MathspecialchebyshevSeries) -> Double { @_common.mean(s.vals) }

pub fn math_special_chebyshev_series_min(s : MathspecialchebyshevSeries) -> Double { @_common.min(s.vals) }

pub fn math_special_chebyshev_series_max(s : MathspecialchebyshevSeries) -> Double { @_common.max(s.vals) }

pub fn math_special_chebyshev_series_range(s : MathspecialchebyshevSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_special_chebyshev_series_var(s : MathspecialchebyshevSeries) -> Double { @_common.variance(s.vals) }

pub fn math_special_chebyshev_series_std(s : MathspecialchebyshevSeries) -> Double { @_common.std(s.vals) }

pub fn math_special_chebyshev_series_median(s : MathspecialchebyshevSeries) -> Double { @_common.median(s.vals) }

pub fn math_special_chebyshev_series_scale(s : MathspecialchebyshevSeries, f : Double) -> MathspecialchebyshevSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_special_chebyshev_series_add(a : MathspecialchebyshevSeries, b : MathspecialchebyshevSeries) -> MathspecialchebyshevSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_special_chebyshev_series_sub(a : MathspecialchebyshevSeries, b : MathspecialchebyshevSeries) -> MathspecialchebyshevSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_special_chebyshev_series_normalize(s : MathspecialchebyshevSeries) -> MathspecialchebyshevSeries {
  let mn = math_special_chebyshev_series_min(s)
  let mx = math_special_chebyshev_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_special_chebyshev_series_cumsum(s : MathspecialchebyshevSeries) -> MathspecialchebyshevSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_special_chebyshev_series_to_string(s : MathspecialchebyshevSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialchebyshevMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_chebyshev_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialchebyshevMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_chebyshev_matrix_identity(n : Int) -> MathspecialchebyshevMatrix {
  let m = math_special_chebyshev_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_special_chebyshev_matrix_get(m : MathspecialchebyshevMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_special_chebyshev_matrix_transpose(m : MathspecialchebyshevMatrix) -> MathspecialchebyshevMatrix {
  let result = math_special_chebyshev_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_special_chebyshev_matrix_add(a : MathspecialchebyshevMatrix, b : MathspecialchebyshevMatrix) -> MathspecialchebyshevMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_special_chebyshev_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_special_chebyshev_matrix_scale(m : MathspecialchebyshevMatrix, s : Double) -> MathspecialchebyshevMatrix {
  let result = math_special_chebyshev_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_special_chebyshev_matrix_multiply(a : MathspecialchebyshevMatrix, b : MathspecialchebyshevMatrix) -> MathspecialchebyshevMatrix {
  if a.cols != b.rows { return math_special_chebyshev_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_special_chebyshev_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_special_chebyshev_matrix_trace(m : MathspecialchebyshevMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_special_chebyshev_matrix_det(m : MathspecialchebyshevMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_special_chebyshev_matrix_norm(m : MathspecialchebyshevMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_special_chebyshev_matrix_to_string(m : MathspecialchebyshevMatrix) -> String {
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

pub(all) struct MathspecialchebyshevVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_chebyshev_make_vector(comps : Array[Double]) -> MathspecialchebyshevVector {
  { comps, dim: comps.length() }
}

pub fn math_special_chebyshev_vector_zero(dim : Int) -> MathspecialchebyshevVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_special_chebyshev_vector_add(a : MathspecialchebyshevVector, b : MathspecialchebyshevVector) -> MathspecialchebyshevVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_chebyshev_vector_sub(a : MathspecialchebyshevVector, b : MathspecialchebyshevVector) -> MathspecialchebyshevVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_chebyshev_vector_scale(v : MathspecialchebyshevVector, s : Double) -> MathspecialchebyshevVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_special_chebyshev_vector_dot(a : MathspecialchebyshevVector, b : MathspecialchebyshevVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_special_chebyshev_vector_norm(v : MathspecialchebyshevVector) -> Double { @_common.sqrt(math_special_chebyshev_vector_dot(v, v)) }

pub fn math_special_chebyshev_vector_normalize(v : MathspecialchebyshevVector) -> MathspecialchebyshevVector {
  let n = math_special_chebyshev_vector_norm(v)
  if n < 0.0000001 { v } else { math_special_chebyshev_vector_scale(v, 1.0 / n) }
}

pub fn math_special_chebyshev_vector_dist(a : MathspecialchebyshevVector, b : MathspecialchebyshevVector) -> Double {
  math_special_chebyshev_vector_norm(math_special_chebyshev_vector_sub(a, b))
}

pub fn math_special_chebyshev_vector_to_string(v : MathspecialchebyshevVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_chebyshev_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_chebyshev_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_chebyshev_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_chebyshev_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_chebyshev_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_chebyshev_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_chebyshev_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_chebyshev_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_chebyshev_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_chebyshev_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_chebyshev_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_chebyshev_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_chebyshev_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_chebyshev_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_chebyshev_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_chebyshev_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_chebyshev_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_chebyshev_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_chebyshev_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_chebyshev_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_chebyshev_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_chebyshev_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_chebyshev_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_chebyshev_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_chebyshev_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_chebyshev_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_chebyshev_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_chebyshev_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_chebyshev_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspecialchebyshevFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_frame_make(size : Int) -> MathspecialchebyshevFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_frame_len(s : MathspecialchebyshevFrame) -> Int { s.size }

pub fn math_special_chebyshev_frame_get(s : MathspecialchebyshevFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_frame_set(s : MathspecialchebyshevFrame, i : Int, v : Double) -> MathspecialchebyshevFrame {
  let result = math_special_chebyshev_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_frame_sum(s : MathspecialchebyshevFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_chebyshev_frame_mean(s : MathspecialchebyshevFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_special_chebyshev_frame_sum(s) / s.size.to_double() }
}

pub fn math_special_chebyshev_frame_scale(s : MathspecialchebyshevFrame, f : Double) -> MathspecialchebyshevFrame {
  let result = math_special_chebyshev_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_chebyshev_frame_add(a : MathspecialchebyshevFrame, b : MathspecialchebyshevFrame) -> MathspecialchebyshevFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_chebyshev_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_chebyshev_frame_copy(s : MathspecialchebyshevFrame) -> MathspecialchebyshevFrame {
  let result = math_special_chebyshev_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_chebyshev_frame_fill(s : MathspecialchebyshevFrame, v : Double) -> MathspecialchebyshevFrame {
  let result = math_special_chebyshev_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_frame_min(s : MathspecialchebyshevFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_frame_max(s : MathspecialchebyshevFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_frame_to_string(s : MathspecialchebyshevFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_table_make(size : Int) -> MathspecialchebyshevTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_table_len(s : MathspecialchebyshevTable) -> Int { s.size }

pub fn math_special_chebyshev_table_get(s : MathspecialchebyshevTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_table_set(s : MathspecialchebyshevTable, i : Int, v : Double) -> MathspecialchebyshevTable {
  let result = math_special_chebyshev_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_table_sum(s : MathspecialchebyshevTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_chebyshev_table_mean(s : MathspecialchebyshevTable) -> Double {
  if s.size == 0 { 0.0 } else { math_special_chebyshev_table_sum(s) / s.size.to_double() }
}

pub fn math_special_chebyshev_table_scale(s : MathspecialchebyshevTable, f : Double) -> MathspecialchebyshevTable {
  let result = math_special_chebyshev_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_chebyshev_table_add(a : MathspecialchebyshevTable, b : MathspecialchebyshevTable) -> MathspecialchebyshevTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_chebyshev_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_chebyshev_table_copy(s : MathspecialchebyshevTable) -> MathspecialchebyshevTable {
  let result = math_special_chebyshev_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_chebyshev_table_fill(s : MathspecialchebyshevTable, v : Double) -> MathspecialchebyshevTable {
  let result = math_special_chebyshev_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_table_min(s : MathspecialchebyshevTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_table_max(s : MathspecialchebyshevTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_table_to_string(s : MathspecialchebyshevTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_graphn_make(size : Int) -> MathspecialchebyshevGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_graphn_len(s : MathspecialchebyshevGraphN) -> Int { s.size }

pub fn math_special_chebyshev_graphn_get(s : MathspecialchebyshevGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_graphn_set(s : MathspecialchebyshevGraphN, i : Int, v : Double) -> MathspecialchebyshevGraphN {
  let result = math_special_chebyshev_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_graphn_sum(s : MathspecialchebyshevGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_chebyshev_graphn_mean(s : MathspecialchebyshevGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_special_chebyshev_graphn_sum(s) / s.size.to_double() }
}

pub fn math_special_chebyshev_graphn_scale(s : MathspecialchebyshevGraphN, f : Double) -> MathspecialchebyshevGraphN {
  let result = math_special_chebyshev_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_chebyshev_graphn_add(a : MathspecialchebyshevGraphN, b : MathspecialchebyshevGraphN) -> MathspecialchebyshevGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_chebyshev_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_chebyshev_graphn_copy(s : MathspecialchebyshevGraphN) -> MathspecialchebyshevGraphN {
  let result = math_special_chebyshev_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_chebyshev_graphn_fill(s : MathspecialchebyshevGraphN, v : Double) -> MathspecialchebyshevGraphN {
  let result = math_special_chebyshev_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_graphn_min(s : MathspecialchebyshevGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_graphn_max(s : MathspecialchebyshevGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_graphn_to_string(s : MathspecialchebyshevGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_node_make(size : Int) -> MathspecialchebyshevNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_node_len(s : MathspecialchebyshevNode) -> Int { s.size }

pub fn math_special_chebyshev_node_get(s : MathspecialchebyshevNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_node_set(s : MathspecialchebyshevNode, i : Int, v : Double) -> MathspecialchebyshevNode {
  let result = math_special_chebyshev_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_node_sum(s : MathspecialchebyshevNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_chebyshev_node_mean(s : MathspecialchebyshevNode) -> Double {
  if s.size == 0 { 0.0 } else { math_special_chebyshev_node_sum(s) / s.size.to_double() }
}

pub fn math_special_chebyshev_node_scale(s : MathspecialchebyshevNode, f : Double) -> MathspecialchebyshevNode {
  let result = math_special_chebyshev_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_chebyshev_node_add(a : MathspecialchebyshevNode, b : MathspecialchebyshevNode) -> MathspecialchebyshevNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_chebyshev_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_chebyshev_node_copy(s : MathspecialchebyshevNode) -> MathspecialchebyshevNode {
  let result = math_special_chebyshev_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_chebyshev_node_fill(s : MathspecialchebyshevNode, v : Double) -> MathspecialchebyshevNode {
  let result = math_special_chebyshev_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_node_min(s : MathspecialchebyshevNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_node_max(s : MathspecialchebyshevNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_node_to_string(s : MathspecialchebyshevNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_edge_make(size : Int) -> MathspecialchebyshevEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_edge_len(s : MathspecialchebyshevEdge) -> Int { s.size }

pub fn math_special_chebyshev_edge_get(s : MathspecialchebyshevEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_edge_set(s : MathspecialchebyshevEdge, i : Int, v : Double) -> MathspecialchebyshevEdge {
  let result = math_special_chebyshev_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_edge_sum(s : MathspecialchebyshevEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_chebyshev_edge_mean(s : MathspecialchebyshevEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_special_chebyshev_edge_sum(s) / s.size.to_double() }
}

pub fn math_special_chebyshev_edge_scale(s : MathspecialchebyshevEdge, f : Double) -> MathspecialchebyshevEdge {
  let result = math_special_chebyshev_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_chebyshev_edge_add(a : MathspecialchebyshevEdge, b : MathspecialchebyshevEdge) -> MathspecialchebyshevEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_chebyshev_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_chebyshev_edge_copy(s : MathspecialchebyshevEdge) -> MathspecialchebyshevEdge {
  let result = math_special_chebyshev_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_chebyshev_edge_fill(s : MathspecialchebyshevEdge, v : Double) -> MathspecialchebyshevEdge {
  let result = math_special_chebyshev_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_edge_min(s : MathspecialchebyshevEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_edge_max(s : MathspecialchebyshevEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_edge_to_string(s : MathspecialchebyshevEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_path_make(size : Int) -> MathspecialchebyshevPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_path_len(s : MathspecialchebyshevPath) -> Int { s.size }

pub fn math_special_chebyshev_path_get(s : MathspecialchebyshevPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_path_set(s : MathspecialchebyshevPath, i : Int, v : Double) -> MathspecialchebyshevPath {
  let result = math_special_chebyshev_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_path_sum(s : MathspecialchebyshevPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_chebyshev_path_mean(s : MathspecialchebyshevPath) -> Double {
  if s.size == 0 { 0.0 } else { math_special_chebyshev_path_sum(s) / s.size.to_double() }
}

pub fn math_special_chebyshev_path_scale(s : MathspecialchebyshevPath, f : Double) -> MathspecialchebyshevPath {
  let result = math_special_chebyshev_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_chebyshev_path_add(a : MathspecialchebyshevPath, b : MathspecialchebyshevPath) -> MathspecialchebyshevPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_chebyshev_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_chebyshev_path_copy(s : MathspecialchebyshevPath) -> MathspecialchebyshevPath {
  let result = math_special_chebyshev_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_chebyshev_path_fill(s : MathspecialchebyshevPath, v : Double) -> MathspecialchebyshevPath {
  let result = math_special_chebyshev_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_path_min(s : MathspecialchebyshevPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_path_max(s : MathspecialchebyshevPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_path_to_string(s : MathspecialchebyshevPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_cluster_make(size : Int) -> MathspecialchebyshevCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_cluster_len(s : MathspecialchebyshevCluster) -> Int { s.size }

pub fn math_special_chebyshev_cluster_get(s : MathspecialchebyshevCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_cluster_set(s : MathspecialchebyshevCluster, i : Int, v : Double) -> MathspecialchebyshevCluster {
  let result = math_special_chebyshev_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_cluster_sum(s : MathspecialchebyshevCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_chebyshev_cluster_mean(s : MathspecialchebyshevCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_special_chebyshev_cluster_sum(s) / s.size.to_double() }
}

pub fn math_special_chebyshev_cluster_scale(s : MathspecialchebyshevCluster, f : Double) -> MathspecialchebyshevCluster {
  let result = math_special_chebyshev_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_chebyshev_cluster_add(a : MathspecialchebyshevCluster, b : MathspecialchebyshevCluster) -> MathspecialchebyshevCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_chebyshev_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_chebyshev_cluster_copy(s : MathspecialchebyshevCluster) -> MathspecialchebyshevCluster {
  let result = math_special_chebyshev_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_chebyshev_cluster_fill(s : MathspecialchebyshevCluster, v : Double) -> MathspecialchebyshevCluster {
  let result = math_special_chebyshev_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_cluster_min(s : MathspecialchebyshevCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_cluster_max(s : MathspecialchebyshevCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_cluster_to_string(s : MathspecialchebyshevCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_model_make(size : Int) -> MathspecialchebyshevModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_model_len(s : MathspecialchebyshevModel) -> Int { s.size }

pub fn math_special_chebyshev_model_get(s : MathspecialchebyshevModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_model_set(s : MathspecialchebyshevModel, i : Int, v : Double) -> MathspecialchebyshevModel {
  let result = math_special_chebyshev_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_model_sum(s : MathspecialchebyshevModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_chebyshev_model_mean(s : MathspecialchebyshevModel) -> Double {
  if s.size == 0 { 0.0 } else { math_special_chebyshev_model_sum(s) / s.size.to_double() }
}

pub fn math_special_chebyshev_model_scale(s : MathspecialchebyshevModel, f : Double) -> MathspecialchebyshevModel {
  let result = math_special_chebyshev_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_chebyshev_model_add(a : MathspecialchebyshevModel, b : MathspecialchebyshevModel) -> MathspecialchebyshevModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_chebyshev_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_chebyshev_model_copy(s : MathspecialchebyshevModel) -> MathspecialchebyshevModel {
  let result = math_special_chebyshev_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_chebyshev_model_fill(s : MathspecialchebyshevModel, v : Double) -> MathspecialchebyshevModel {
  let result = math_special_chebyshev_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_model_min(s : MathspecialchebyshevModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_model_max(s : MathspecialchebyshevModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_model_to_string(s : MathspecialchebyshevModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_layer_make(size : Int) -> MathspecialchebyshevLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_layer_len(s : MathspecialchebyshevLayer) -> Int { s.size }

pub fn math_special_chebyshev_layer_get(s : MathspecialchebyshevLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_layer_set(s : MathspecialchebyshevLayer, i : Int, v : Double) -> MathspecialchebyshevLayer {
  let result = math_special_chebyshev_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_layer_sum(s : MathspecialchebyshevLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_chebyshev_layer_mean(s : MathspecialchebyshevLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_special_chebyshev_layer_sum(s) / s.size.to_double() }
}

pub fn math_special_chebyshev_layer_scale(s : MathspecialchebyshevLayer, f : Double) -> MathspecialchebyshevLayer {
  let result = math_special_chebyshev_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_chebyshev_layer_add(a : MathspecialchebyshevLayer, b : MathspecialchebyshevLayer) -> MathspecialchebyshevLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_chebyshev_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_chebyshev_layer_copy(s : MathspecialchebyshevLayer) -> MathspecialchebyshevLayer {
  let result = math_special_chebyshev_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_chebyshev_layer_fill(s : MathspecialchebyshevLayer, v : Double) -> MathspecialchebyshevLayer {
  let result = math_special_chebyshev_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_layer_min(s : MathspecialchebyshevLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_layer_max(s : MathspecialchebyshevLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_layer_to_string(s : MathspecialchebyshevLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_buffer_make(size : Int) -> MathspecialchebyshevBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_buffer_len(s : MathspecialchebyshevBuffer) -> Int { s.size }

pub fn math_special_chebyshev_buffer_get(s : MathspecialchebyshevBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_buffer_set(s : MathspecialchebyshevBuffer, i : Int, v : Double) -> MathspecialchebyshevBuffer {
  let result = math_special_chebyshev_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_buffer_sum(s : MathspecialchebyshevBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_chebyshev_buffer_mean(s : MathspecialchebyshevBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_special_chebyshev_buffer_sum(s) / s.size.to_double() }
}

pub fn math_special_chebyshev_buffer_scale(s : MathspecialchebyshevBuffer, f : Double) -> MathspecialchebyshevBuffer {
  let result = math_special_chebyshev_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_chebyshev_buffer_add(a : MathspecialchebyshevBuffer, b : MathspecialchebyshevBuffer) -> MathspecialchebyshevBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_chebyshev_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_chebyshev_buffer_copy(s : MathspecialchebyshevBuffer) -> MathspecialchebyshevBuffer {
  let result = math_special_chebyshev_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_chebyshev_buffer_fill(s : MathspecialchebyshevBuffer, v : Double) -> MathspecialchebyshevBuffer {
  let result = math_special_chebyshev_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_buffer_min(s : MathspecialchebyshevBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_buffer_max(s : MathspecialchebyshevBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_buffer_to_string(s : MathspecialchebyshevBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_cursor_make(size : Int) -> MathspecialchebyshevCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_cursor_len(s : MathspecialchebyshevCursor) -> Int { s.size }

pub fn math_special_chebyshev_cursor_get(s : MathspecialchebyshevCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_cursor_set(s : MathspecialchebyshevCursor, i : Int, v : Double) -> MathspecialchebyshevCursor {
  let result = math_special_chebyshev_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_cursor_sum(s : MathspecialchebyshevCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_chebyshev_cursor_mean(s : MathspecialchebyshevCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_special_chebyshev_cursor_sum(s) / s.size.to_double() }
}

pub fn math_special_chebyshev_cursor_scale(s : MathspecialchebyshevCursor, f : Double) -> MathspecialchebyshevCursor {
  let result = math_special_chebyshev_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_chebyshev_cursor_add(a : MathspecialchebyshevCursor, b : MathspecialchebyshevCursor) -> MathspecialchebyshevCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_chebyshev_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_chebyshev_cursor_copy(s : MathspecialchebyshevCursor) -> MathspecialchebyshevCursor {
  let result = math_special_chebyshev_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_chebyshev_cursor_fill(s : MathspecialchebyshevCursor, v : Double) -> MathspecialchebyshevCursor {
  let result = math_special_chebyshev_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_cursor_min(s : MathspecialchebyshevCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_cursor_max(s : MathspecialchebyshevCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_cursor_to_string(s : MathspecialchebyshevCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_view_make(size : Int) -> MathspecialchebyshevView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_view_len(s : MathspecialchebyshevView) -> Int { s.size }

pub fn math_special_chebyshev_view_get(s : MathspecialchebyshevView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_view_set(s : MathspecialchebyshevView, i : Int, v : Double) -> MathspecialchebyshevView {
  let result = math_special_chebyshev_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_view_sum(s : MathspecialchebyshevView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_chebyshev_view_mean(s : MathspecialchebyshevView) -> Double {
  if s.size == 0 { 0.0 } else { math_special_chebyshev_view_sum(s) / s.size.to_double() }
}

pub fn math_special_chebyshev_view_scale(s : MathspecialchebyshevView, f : Double) -> MathspecialchebyshevView {
  let result = math_special_chebyshev_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_chebyshev_view_add(a : MathspecialchebyshevView, b : MathspecialchebyshevView) -> MathspecialchebyshevView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_chebyshev_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_chebyshev_view_copy(s : MathspecialchebyshevView) -> MathspecialchebyshevView {
  let result = math_special_chebyshev_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_chebyshev_view_fill(s : MathspecialchebyshevView, v : Double) -> MathspecialchebyshevView {
  let result = math_special_chebyshev_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_view_min(s : MathspecialchebyshevView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_view_max(s : MathspecialchebyshevView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_view_to_string(s : MathspecialchebyshevView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_range_make(size : Int) -> MathspecialchebyshevRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_range_len(s : MathspecialchebyshevRange) -> Int { s.size }

pub fn math_special_chebyshev_range_get(s : MathspecialchebyshevRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_range_set(s : MathspecialchebyshevRange, i : Int, v : Double) -> MathspecialchebyshevRange {
  let result = math_special_chebyshev_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_range_sum(s : MathspecialchebyshevRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_chebyshev_range_mean(s : MathspecialchebyshevRange) -> Double {
  if s.size == 0 { 0.0 } else { math_special_chebyshev_range_sum(s) / s.size.to_double() }
}

pub fn math_special_chebyshev_range_scale(s : MathspecialchebyshevRange, f : Double) -> MathspecialchebyshevRange {
  let result = math_special_chebyshev_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_chebyshev_range_add(a : MathspecialchebyshevRange, b : MathspecialchebyshevRange) -> MathspecialchebyshevRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_chebyshev_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_chebyshev_range_copy(s : MathspecialchebyshevRange) -> MathspecialchebyshevRange {
  let result = math_special_chebyshev_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_chebyshev_range_fill(s : MathspecialchebyshevRange, v : Double) -> MathspecialchebyshevRange {
  let result = math_special_chebyshev_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_range_min(s : MathspecialchebyshevRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_range_max(s : MathspecialchebyshevRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_range_to_string(s : MathspecialchebyshevRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialchebyshevSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_chebyshev_slice_make(size : Int) -> MathspecialchebyshevSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_chebyshev_slice_len(s : MathspecialchebyshevSlice) -> Int { s.size }

pub fn math_special_chebyshev_slice_get(s : MathspecialchebyshevSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_chebyshev_slice_set(s : MathspecialchebyshevSlice, i : Int, v : Double) -> MathspecialchebyshevSlice {
  let result = math_special_chebyshev_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_slice_sum(s : MathspecialchebyshevSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_chebyshev_slice_mean(s : MathspecialchebyshevSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_special_chebyshev_slice_sum(s) / s.size.to_double() }
}

pub fn math_special_chebyshev_slice_scale(s : MathspecialchebyshevSlice, f : Double) -> MathspecialchebyshevSlice {
  let result = math_special_chebyshev_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_chebyshev_slice_add(a : MathspecialchebyshevSlice, b : MathspecialchebyshevSlice) -> MathspecialchebyshevSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_chebyshev_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_chebyshev_slice_copy(s : MathspecialchebyshevSlice) -> MathspecialchebyshevSlice {
  let result = math_special_chebyshev_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_chebyshev_slice_fill(s : MathspecialchebyshevSlice, v : Double) -> MathspecialchebyshevSlice {
  let result = math_special_chebyshev_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_chebyshev_slice_min(s : MathspecialchebyshevSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_slice_max(s : MathspecialchebyshevSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_chebyshev_slice_to_string(s : MathspecialchebyshevSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

