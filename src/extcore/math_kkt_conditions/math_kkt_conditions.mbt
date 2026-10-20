///===
/// extcore/math_kkt_conditions

pub(all) struct MathkktconditionsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_kkt_conditions_make_point(x : Double, y : Double) -> MathkktconditionsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_kkt_conditions_make_point3(x : Double, y : Double, z : Double) -> MathkktconditionsPoint {
  { x, y, z, label: 0 }
}

pub fn math_kkt_conditions_point_x(pt : MathkktconditionsPoint) -> Double { pt.x }

pub fn math_kkt_conditions_point_y(pt : MathkktconditionsPoint) -> Double { pt.y }

pub fn math_kkt_conditions_point_z(pt : MathkktconditionsPoint) -> Double { pt.z }

pub fn math_kkt_conditions_point_label(pt : MathkktconditionsPoint) -> Int { pt.label }

pub fn math_kkt_conditions_point_dist(a : MathkktconditionsPoint, b : MathkktconditionsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_kkt_conditions_point_add(a : MathkktconditionsPoint, b : MathkktconditionsPoint) -> MathkktconditionsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_kkt_conditions_point_sub(a : MathkktconditionsPoint, b : MathkktconditionsPoint) -> MathkktconditionsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_kkt_conditions_point_scale(pt : MathkktconditionsPoint, s : Double) -> MathkktconditionsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_kkt_conditions_point_dot(a : MathkktconditionsPoint, b : MathkktconditionsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_kkt_conditions_point_cross(a : MathkktconditionsPoint, b : MathkktconditionsPoint) -> MathkktconditionsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_kkt_conditions_point_norm(pt : MathkktconditionsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_kkt_conditions_point_normalize(pt : MathkktconditionsPoint) -> MathkktconditionsPoint {
  let n = math_kkt_conditions_point_norm(pt)
  if n < 0.0000001 { pt } else { math_kkt_conditions_point_scale(pt, 1.0 / n) }
}

pub fn math_kkt_conditions_point_negate(pt : MathkktconditionsPoint) -> MathkktconditionsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_kkt_conditions_point_mid(a : MathkktconditionsPoint, b : MathkktconditionsPoint) -> MathkktconditionsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_kkt_conditions_point_lerp(a : MathkktconditionsPoint, b : MathkktconditionsPoint, t : Double) -> MathkktconditionsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_kkt_conditions_point_to_string(pt : MathkktconditionsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathkktconditionsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_kkt_conditions_make_series(vals : Array[Double], name : String) -> MathkktconditionsSeries {
  { vals, name, meta: 0 }
}

pub fn math_kkt_conditions_series_len(s : MathkktconditionsSeries) -> Int { s.vals.length() }

pub fn math_kkt_conditions_series_sum(s : MathkktconditionsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_kkt_conditions_series_mean(s : MathkktconditionsSeries) -> Double { @_common.mean(s.vals) }

pub fn math_kkt_conditions_series_min(s : MathkktconditionsSeries) -> Double { @_common.min(s.vals) }

pub fn math_kkt_conditions_series_max(s : MathkktconditionsSeries) -> Double { @_common.max(s.vals) }

pub fn math_kkt_conditions_series_range(s : MathkktconditionsSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_kkt_conditions_series_var(s : MathkktconditionsSeries) -> Double { @_common.variance(s.vals) }

pub fn math_kkt_conditions_series_std(s : MathkktconditionsSeries) -> Double { @_common.std(s.vals) }

pub fn math_kkt_conditions_series_median(s : MathkktconditionsSeries) -> Double { @_common.median(s.vals) }

pub fn math_kkt_conditions_series_scale(s : MathkktconditionsSeries, f : Double) -> MathkktconditionsSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_kkt_conditions_series_add(a : MathkktconditionsSeries, b : MathkktconditionsSeries) -> MathkktconditionsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_kkt_conditions_series_sub(a : MathkktconditionsSeries, b : MathkktconditionsSeries) -> MathkktconditionsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_kkt_conditions_series_normalize(s : MathkktconditionsSeries) -> MathkktconditionsSeries {
  let mn = math_kkt_conditions_series_min(s)
  let mx = math_kkt_conditions_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_kkt_conditions_series_cumsum(s : MathkktconditionsSeries) -> MathkktconditionsSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_kkt_conditions_series_to_string(s : MathkktconditionsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathkktconditionsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_kkt_conditions_make_matrix(rows : Int, cols : Int, val : Double) -> MathkktconditionsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_kkt_conditions_matrix_identity(n : Int) -> MathkktconditionsMatrix {
  let m = math_kkt_conditions_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_kkt_conditions_matrix_get(m : MathkktconditionsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_kkt_conditions_matrix_transpose(m : MathkktconditionsMatrix) -> MathkktconditionsMatrix {
  let result = math_kkt_conditions_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_kkt_conditions_matrix_add(a : MathkktconditionsMatrix, b : MathkktconditionsMatrix) -> MathkktconditionsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_kkt_conditions_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_kkt_conditions_matrix_scale(m : MathkktconditionsMatrix, s : Double) -> MathkktconditionsMatrix {
  let result = math_kkt_conditions_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_kkt_conditions_matrix_multiply(a : MathkktconditionsMatrix, b : MathkktconditionsMatrix) -> MathkktconditionsMatrix {
  if a.cols != b.rows { return math_kkt_conditions_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_kkt_conditions_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_kkt_conditions_matrix_trace(m : MathkktconditionsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_kkt_conditions_matrix_det(m : MathkktconditionsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_kkt_conditions_matrix_norm(m : MathkktconditionsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_kkt_conditions_matrix_to_string(m : MathkktconditionsMatrix) -> String {
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

pub(all) struct MathkktconditionsVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_kkt_conditions_make_vector(comps : Array[Double]) -> MathkktconditionsVector {
  { comps, dim: comps.length() }
}

pub fn math_kkt_conditions_vector_zero(dim : Int) -> MathkktconditionsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_kkt_conditions_vector_add(a : MathkktconditionsVector, b : MathkktconditionsVector) -> MathkktconditionsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_kkt_conditions_vector_sub(a : MathkktconditionsVector, b : MathkktconditionsVector) -> MathkktconditionsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_kkt_conditions_vector_scale(v : MathkktconditionsVector, s : Double) -> MathkktconditionsVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_kkt_conditions_vector_dot(a : MathkktconditionsVector, b : MathkktconditionsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_kkt_conditions_vector_norm(v : MathkktconditionsVector) -> Double { @_common.sqrt(math_kkt_conditions_vector_dot(v, v)) }

pub fn math_kkt_conditions_vector_normalize(v : MathkktconditionsVector) -> MathkktconditionsVector {
  let n = math_kkt_conditions_vector_norm(v)
  if n < 0.0000001 { v } else { math_kkt_conditions_vector_scale(v, 1.0 / n) }
}

pub fn math_kkt_conditions_vector_dist(a : MathkktconditionsVector, b : MathkktconditionsVector) -> Double {
  math_kkt_conditions_vector_norm(math_kkt_conditions_vector_sub(a, b))
}

pub fn math_kkt_conditions_vector_to_string(v : MathkktconditionsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_kkt_conditions_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_kkt_conditions_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_kkt_conditions_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_kkt_conditions_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_kkt_conditions_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_kkt_conditions_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_kkt_conditions_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_kkt_conditions_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_kkt_conditions_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_kkt_conditions_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_kkt_conditions_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_kkt_conditions_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_kkt_conditions_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_kkt_conditions_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_kkt_conditions_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_kkt_conditions_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_kkt_conditions_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_kkt_conditions_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_kkt_conditions_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_kkt_conditions_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_kkt_conditions_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_kkt_conditions_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_kkt_conditions_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_kkt_conditions_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_kkt_conditions_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_kkt_conditions_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_kkt_conditions_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_kkt_conditions_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_kkt_conditions_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathkktconditionsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_frame_make(size : Int) -> MathkktconditionsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_frame_len(s : MathkktconditionsFrame) -> Int { s.size }

pub fn math_kkt_conditions_frame_get(s : MathkktconditionsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_frame_set(s : MathkktconditionsFrame, i : Int, v : Double) -> MathkktconditionsFrame {
  let result = math_kkt_conditions_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_frame_sum(s : MathkktconditionsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_kkt_conditions_frame_mean(s : MathkktconditionsFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_kkt_conditions_frame_sum(s) / s.size.to_double() }
}

pub fn math_kkt_conditions_frame_scale(s : MathkktconditionsFrame, f : Double) -> MathkktconditionsFrame {
  let result = math_kkt_conditions_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_kkt_conditions_frame_add(a : MathkktconditionsFrame, b : MathkktconditionsFrame) -> MathkktconditionsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_kkt_conditions_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_kkt_conditions_frame_copy(s : MathkktconditionsFrame) -> MathkktconditionsFrame {
  let result = math_kkt_conditions_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_kkt_conditions_frame_fill(s : MathkktconditionsFrame, v : Double) -> MathkktconditionsFrame {
  let result = math_kkt_conditions_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_frame_min(s : MathkktconditionsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_frame_max(s : MathkktconditionsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_frame_to_string(s : MathkktconditionsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_table_make(size : Int) -> MathkktconditionsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_table_len(s : MathkktconditionsTable) -> Int { s.size }

pub fn math_kkt_conditions_table_get(s : MathkktconditionsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_table_set(s : MathkktconditionsTable, i : Int, v : Double) -> MathkktconditionsTable {
  let result = math_kkt_conditions_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_table_sum(s : MathkktconditionsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_kkt_conditions_table_mean(s : MathkktconditionsTable) -> Double {
  if s.size == 0 { 0.0 } else { math_kkt_conditions_table_sum(s) / s.size.to_double() }
}

pub fn math_kkt_conditions_table_scale(s : MathkktconditionsTable, f : Double) -> MathkktconditionsTable {
  let result = math_kkt_conditions_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_kkt_conditions_table_add(a : MathkktconditionsTable, b : MathkktconditionsTable) -> MathkktconditionsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_kkt_conditions_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_kkt_conditions_table_copy(s : MathkktconditionsTable) -> MathkktconditionsTable {
  let result = math_kkt_conditions_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_kkt_conditions_table_fill(s : MathkktconditionsTable, v : Double) -> MathkktconditionsTable {
  let result = math_kkt_conditions_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_table_min(s : MathkktconditionsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_table_max(s : MathkktconditionsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_table_to_string(s : MathkktconditionsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_graphn_make(size : Int) -> MathkktconditionsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_graphn_len(s : MathkktconditionsGraphN) -> Int { s.size }

pub fn math_kkt_conditions_graphn_get(s : MathkktconditionsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_graphn_set(s : MathkktconditionsGraphN, i : Int, v : Double) -> MathkktconditionsGraphN {
  let result = math_kkt_conditions_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_graphn_sum(s : MathkktconditionsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_kkt_conditions_graphn_mean(s : MathkktconditionsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_kkt_conditions_graphn_sum(s) / s.size.to_double() }
}

pub fn math_kkt_conditions_graphn_scale(s : MathkktconditionsGraphN, f : Double) -> MathkktconditionsGraphN {
  let result = math_kkt_conditions_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_kkt_conditions_graphn_add(a : MathkktconditionsGraphN, b : MathkktconditionsGraphN) -> MathkktconditionsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_kkt_conditions_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_kkt_conditions_graphn_copy(s : MathkktconditionsGraphN) -> MathkktconditionsGraphN {
  let result = math_kkt_conditions_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_kkt_conditions_graphn_fill(s : MathkktconditionsGraphN, v : Double) -> MathkktconditionsGraphN {
  let result = math_kkt_conditions_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_graphn_min(s : MathkktconditionsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_graphn_max(s : MathkktconditionsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_graphn_to_string(s : MathkktconditionsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_node_make(size : Int) -> MathkktconditionsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_node_len(s : MathkktconditionsNode) -> Int { s.size }

pub fn math_kkt_conditions_node_get(s : MathkktconditionsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_node_set(s : MathkktconditionsNode, i : Int, v : Double) -> MathkktconditionsNode {
  let result = math_kkt_conditions_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_node_sum(s : MathkktconditionsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_kkt_conditions_node_mean(s : MathkktconditionsNode) -> Double {
  if s.size == 0 { 0.0 } else { math_kkt_conditions_node_sum(s) / s.size.to_double() }
}

pub fn math_kkt_conditions_node_scale(s : MathkktconditionsNode, f : Double) -> MathkktconditionsNode {
  let result = math_kkt_conditions_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_kkt_conditions_node_add(a : MathkktconditionsNode, b : MathkktconditionsNode) -> MathkktconditionsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_kkt_conditions_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_kkt_conditions_node_copy(s : MathkktconditionsNode) -> MathkktconditionsNode {
  let result = math_kkt_conditions_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_kkt_conditions_node_fill(s : MathkktconditionsNode, v : Double) -> MathkktconditionsNode {
  let result = math_kkt_conditions_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_node_min(s : MathkktconditionsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_node_max(s : MathkktconditionsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_node_to_string(s : MathkktconditionsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_edge_make(size : Int) -> MathkktconditionsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_edge_len(s : MathkktconditionsEdge) -> Int { s.size }

pub fn math_kkt_conditions_edge_get(s : MathkktconditionsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_edge_set(s : MathkktconditionsEdge, i : Int, v : Double) -> MathkktconditionsEdge {
  let result = math_kkt_conditions_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_edge_sum(s : MathkktconditionsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_kkt_conditions_edge_mean(s : MathkktconditionsEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_kkt_conditions_edge_sum(s) / s.size.to_double() }
}

pub fn math_kkt_conditions_edge_scale(s : MathkktconditionsEdge, f : Double) -> MathkktconditionsEdge {
  let result = math_kkt_conditions_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_kkt_conditions_edge_add(a : MathkktconditionsEdge, b : MathkktconditionsEdge) -> MathkktconditionsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_kkt_conditions_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_kkt_conditions_edge_copy(s : MathkktconditionsEdge) -> MathkktconditionsEdge {
  let result = math_kkt_conditions_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_kkt_conditions_edge_fill(s : MathkktconditionsEdge, v : Double) -> MathkktconditionsEdge {
  let result = math_kkt_conditions_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_edge_min(s : MathkktconditionsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_edge_max(s : MathkktconditionsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_edge_to_string(s : MathkktconditionsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_path_make(size : Int) -> MathkktconditionsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_path_len(s : MathkktconditionsPath) -> Int { s.size }

pub fn math_kkt_conditions_path_get(s : MathkktconditionsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_path_set(s : MathkktconditionsPath, i : Int, v : Double) -> MathkktconditionsPath {
  let result = math_kkt_conditions_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_path_sum(s : MathkktconditionsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_kkt_conditions_path_mean(s : MathkktconditionsPath) -> Double {
  if s.size == 0 { 0.0 } else { math_kkt_conditions_path_sum(s) / s.size.to_double() }
}

pub fn math_kkt_conditions_path_scale(s : MathkktconditionsPath, f : Double) -> MathkktconditionsPath {
  let result = math_kkt_conditions_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_kkt_conditions_path_add(a : MathkktconditionsPath, b : MathkktconditionsPath) -> MathkktconditionsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_kkt_conditions_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_kkt_conditions_path_copy(s : MathkktconditionsPath) -> MathkktconditionsPath {
  let result = math_kkt_conditions_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_kkt_conditions_path_fill(s : MathkktconditionsPath, v : Double) -> MathkktconditionsPath {
  let result = math_kkt_conditions_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_path_min(s : MathkktconditionsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_path_max(s : MathkktconditionsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_path_to_string(s : MathkktconditionsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_cluster_make(size : Int) -> MathkktconditionsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_cluster_len(s : MathkktconditionsCluster) -> Int { s.size }

pub fn math_kkt_conditions_cluster_get(s : MathkktconditionsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_cluster_set(s : MathkktconditionsCluster, i : Int, v : Double) -> MathkktconditionsCluster {
  let result = math_kkt_conditions_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_cluster_sum(s : MathkktconditionsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_kkt_conditions_cluster_mean(s : MathkktconditionsCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_kkt_conditions_cluster_sum(s) / s.size.to_double() }
}

pub fn math_kkt_conditions_cluster_scale(s : MathkktconditionsCluster, f : Double) -> MathkktconditionsCluster {
  let result = math_kkt_conditions_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_kkt_conditions_cluster_add(a : MathkktconditionsCluster, b : MathkktconditionsCluster) -> MathkktconditionsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_kkt_conditions_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_kkt_conditions_cluster_copy(s : MathkktconditionsCluster) -> MathkktconditionsCluster {
  let result = math_kkt_conditions_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_kkt_conditions_cluster_fill(s : MathkktconditionsCluster, v : Double) -> MathkktconditionsCluster {
  let result = math_kkt_conditions_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_cluster_min(s : MathkktconditionsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_cluster_max(s : MathkktconditionsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_cluster_to_string(s : MathkktconditionsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_model_make(size : Int) -> MathkktconditionsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_model_len(s : MathkktconditionsModel) -> Int { s.size }

pub fn math_kkt_conditions_model_get(s : MathkktconditionsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_model_set(s : MathkktconditionsModel, i : Int, v : Double) -> MathkktconditionsModel {
  let result = math_kkt_conditions_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_model_sum(s : MathkktconditionsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_kkt_conditions_model_mean(s : MathkktconditionsModel) -> Double {
  if s.size == 0 { 0.0 } else { math_kkt_conditions_model_sum(s) / s.size.to_double() }
}

pub fn math_kkt_conditions_model_scale(s : MathkktconditionsModel, f : Double) -> MathkktconditionsModel {
  let result = math_kkt_conditions_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_kkt_conditions_model_add(a : MathkktconditionsModel, b : MathkktconditionsModel) -> MathkktconditionsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_kkt_conditions_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_kkt_conditions_model_copy(s : MathkktconditionsModel) -> MathkktconditionsModel {
  let result = math_kkt_conditions_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_kkt_conditions_model_fill(s : MathkktconditionsModel, v : Double) -> MathkktconditionsModel {
  let result = math_kkt_conditions_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_model_min(s : MathkktconditionsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_model_max(s : MathkktconditionsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_model_to_string(s : MathkktconditionsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_layer_make(size : Int) -> MathkktconditionsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_layer_len(s : MathkktconditionsLayer) -> Int { s.size }

pub fn math_kkt_conditions_layer_get(s : MathkktconditionsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_layer_set(s : MathkktconditionsLayer, i : Int, v : Double) -> MathkktconditionsLayer {
  let result = math_kkt_conditions_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_layer_sum(s : MathkktconditionsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_kkt_conditions_layer_mean(s : MathkktconditionsLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_kkt_conditions_layer_sum(s) / s.size.to_double() }
}

pub fn math_kkt_conditions_layer_scale(s : MathkktconditionsLayer, f : Double) -> MathkktconditionsLayer {
  let result = math_kkt_conditions_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_kkt_conditions_layer_add(a : MathkktconditionsLayer, b : MathkktconditionsLayer) -> MathkktconditionsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_kkt_conditions_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_kkt_conditions_layer_copy(s : MathkktconditionsLayer) -> MathkktconditionsLayer {
  let result = math_kkt_conditions_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_kkt_conditions_layer_fill(s : MathkktconditionsLayer, v : Double) -> MathkktconditionsLayer {
  let result = math_kkt_conditions_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_layer_min(s : MathkktconditionsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_layer_max(s : MathkktconditionsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_layer_to_string(s : MathkktconditionsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_buffer_make(size : Int) -> MathkktconditionsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_buffer_len(s : MathkktconditionsBuffer) -> Int { s.size }

pub fn math_kkt_conditions_buffer_get(s : MathkktconditionsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_buffer_set(s : MathkktconditionsBuffer, i : Int, v : Double) -> MathkktconditionsBuffer {
  let result = math_kkt_conditions_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_buffer_sum(s : MathkktconditionsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_kkt_conditions_buffer_mean(s : MathkktconditionsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_kkt_conditions_buffer_sum(s) / s.size.to_double() }
}

pub fn math_kkt_conditions_buffer_scale(s : MathkktconditionsBuffer, f : Double) -> MathkktconditionsBuffer {
  let result = math_kkt_conditions_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_kkt_conditions_buffer_add(a : MathkktconditionsBuffer, b : MathkktconditionsBuffer) -> MathkktconditionsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_kkt_conditions_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_kkt_conditions_buffer_copy(s : MathkktconditionsBuffer) -> MathkktconditionsBuffer {
  let result = math_kkt_conditions_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_kkt_conditions_buffer_fill(s : MathkktconditionsBuffer, v : Double) -> MathkktconditionsBuffer {
  let result = math_kkt_conditions_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_buffer_min(s : MathkktconditionsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_buffer_max(s : MathkktconditionsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_buffer_to_string(s : MathkktconditionsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_cursor_make(size : Int) -> MathkktconditionsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_cursor_len(s : MathkktconditionsCursor) -> Int { s.size }

pub fn math_kkt_conditions_cursor_get(s : MathkktconditionsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_cursor_set(s : MathkktconditionsCursor, i : Int, v : Double) -> MathkktconditionsCursor {
  let result = math_kkt_conditions_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_cursor_sum(s : MathkktconditionsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_kkt_conditions_cursor_mean(s : MathkktconditionsCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_kkt_conditions_cursor_sum(s) / s.size.to_double() }
}

pub fn math_kkt_conditions_cursor_scale(s : MathkktconditionsCursor, f : Double) -> MathkktconditionsCursor {
  let result = math_kkt_conditions_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_kkt_conditions_cursor_add(a : MathkktconditionsCursor, b : MathkktconditionsCursor) -> MathkktconditionsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_kkt_conditions_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_kkt_conditions_cursor_copy(s : MathkktconditionsCursor) -> MathkktconditionsCursor {
  let result = math_kkt_conditions_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_kkt_conditions_cursor_fill(s : MathkktconditionsCursor, v : Double) -> MathkktconditionsCursor {
  let result = math_kkt_conditions_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_cursor_min(s : MathkktconditionsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_cursor_max(s : MathkktconditionsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_cursor_to_string(s : MathkktconditionsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_view_make(size : Int) -> MathkktconditionsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_view_len(s : MathkktconditionsView) -> Int { s.size }

pub fn math_kkt_conditions_view_get(s : MathkktconditionsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_view_set(s : MathkktconditionsView, i : Int, v : Double) -> MathkktconditionsView {
  let result = math_kkt_conditions_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_view_sum(s : MathkktconditionsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_kkt_conditions_view_mean(s : MathkktconditionsView) -> Double {
  if s.size == 0 { 0.0 } else { math_kkt_conditions_view_sum(s) / s.size.to_double() }
}

pub fn math_kkt_conditions_view_scale(s : MathkktconditionsView, f : Double) -> MathkktconditionsView {
  let result = math_kkt_conditions_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_kkt_conditions_view_add(a : MathkktconditionsView, b : MathkktconditionsView) -> MathkktconditionsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_kkt_conditions_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_kkt_conditions_view_copy(s : MathkktconditionsView) -> MathkktconditionsView {
  let result = math_kkt_conditions_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_kkt_conditions_view_fill(s : MathkktconditionsView, v : Double) -> MathkktconditionsView {
  let result = math_kkt_conditions_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_view_min(s : MathkktconditionsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_view_max(s : MathkktconditionsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_view_to_string(s : MathkktconditionsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_range_make(size : Int) -> MathkktconditionsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_range_len(s : MathkktconditionsRange) -> Int { s.size }

pub fn math_kkt_conditions_range_get(s : MathkktconditionsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_range_set(s : MathkktconditionsRange, i : Int, v : Double) -> MathkktconditionsRange {
  let result = math_kkt_conditions_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_range_sum(s : MathkktconditionsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_kkt_conditions_range_mean(s : MathkktconditionsRange) -> Double {
  if s.size == 0 { 0.0 } else { math_kkt_conditions_range_sum(s) / s.size.to_double() }
}

pub fn math_kkt_conditions_range_scale(s : MathkktconditionsRange, f : Double) -> MathkktconditionsRange {
  let result = math_kkt_conditions_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_kkt_conditions_range_add(a : MathkktconditionsRange, b : MathkktconditionsRange) -> MathkktconditionsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_kkt_conditions_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_kkt_conditions_range_copy(s : MathkktconditionsRange) -> MathkktconditionsRange {
  let result = math_kkt_conditions_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_kkt_conditions_range_fill(s : MathkktconditionsRange, v : Double) -> MathkktconditionsRange {
  let result = math_kkt_conditions_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_range_min(s : MathkktconditionsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_range_max(s : MathkktconditionsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_range_to_string(s : MathkktconditionsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathkktconditionsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_kkt_conditions_slice_make(size : Int) -> MathkktconditionsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_kkt_conditions_slice_len(s : MathkktconditionsSlice) -> Int { s.size }

pub fn math_kkt_conditions_slice_get(s : MathkktconditionsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_kkt_conditions_slice_set(s : MathkktconditionsSlice, i : Int, v : Double) -> MathkktconditionsSlice {
  let result = math_kkt_conditions_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_slice_sum(s : MathkktconditionsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_kkt_conditions_slice_mean(s : MathkktconditionsSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_kkt_conditions_slice_sum(s) / s.size.to_double() }
}

pub fn math_kkt_conditions_slice_scale(s : MathkktconditionsSlice, f : Double) -> MathkktconditionsSlice {
  let result = math_kkt_conditions_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_kkt_conditions_slice_add(a : MathkktconditionsSlice, b : MathkktconditionsSlice) -> MathkktconditionsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_kkt_conditions_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_kkt_conditions_slice_copy(s : MathkktconditionsSlice) -> MathkktconditionsSlice {
  let result = math_kkt_conditions_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_kkt_conditions_slice_fill(s : MathkktconditionsSlice, v : Double) -> MathkktconditionsSlice {
  let result = math_kkt_conditions_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_kkt_conditions_slice_min(s : MathkktconditionsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_slice_max(s : MathkktconditionsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_kkt_conditions_slice_to_string(s : MathkktconditionsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

