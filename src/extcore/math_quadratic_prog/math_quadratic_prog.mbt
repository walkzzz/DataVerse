///===
/// extcore/math_quadratic_prog

pub(all) struct MathquadraticprogPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_quadratic_prog_make_point(x : Double, y : Double) -> MathquadraticprogPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_quadratic_prog_make_point3(x : Double, y : Double, z : Double) -> MathquadraticprogPoint {
  { x, y, z, label: 0 }
}

pub fn math_quadratic_prog_point_x(pt : MathquadraticprogPoint) -> Double { pt.x }

pub fn math_quadratic_prog_point_y(pt : MathquadraticprogPoint) -> Double { pt.y }

pub fn math_quadratic_prog_point_z(pt : MathquadraticprogPoint) -> Double { pt.z }

pub fn math_quadratic_prog_point_label(pt : MathquadraticprogPoint) -> Int { pt.label }

pub fn math_quadratic_prog_point_dist(a : MathquadraticprogPoint, b : MathquadraticprogPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_quadratic_prog_point_add(a : MathquadraticprogPoint, b : MathquadraticprogPoint) -> MathquadraticprogPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_quadratic_prog_point_sub(a : MathquadraticprogPoint, b : MathquadraticprogPoint) -> MathquadraticprogPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_quadratic_prog_point_scale(pt : MathquadraticprogPoint, s : Double) -> MathquadraticprogPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_quadratic_prog_point_dot(a : MathquadraticprogPoint, b : MathquadraticprogPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_quadratic_prog_point_cross(a : MathquadraticprogPoint, b : MathquadraticprogPoint) -> MathquadraticprogPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_quadratic_prog_point_norm(pt : MathquadraticprogPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_quadratic_prog_point_normalize(pt : MathquadraticprogPoint) -> MathquadraticprogPoint {
  let n = math_quadratic_prog_point_norm(pt)
  if n < 0.0000001 { pt } else { math_quadratic_prog_point_scale(pt, 1.0 / n) }
}

pub fn math_quadratic_prog_point_negate(pt : MathquadraticprogPoint) -> MathquadraticprogPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_quadratic_prog_point_mid(a : MathquadraticprogPoint, b : MathquadraticprogPoint) -> MathquadraticprogPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_quadratic_prog_point_lerp(a : MathquadraticprogPoint, b : MathquadraticprogPoint, t : Double) -> MathquadraticprogPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_quadratic_prog_point_to_string(pt : MathquadraticprogPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathquadraticprogSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_quadratic_prog_make_series(vals : Array[Double], name : String) -> MathquadraticprogSeries {
  { vals, name, meta: 0 }
}

pub fn math_quadratic_prog_series_len(s : MathquadraticprogSeries) -> Int { s.vals.length() }

pub fn math_quadratic_prog_series_sum(s : MathquadraticprogSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_quadratic_prog_series_mean(s : MathquadraticprogSeries) -> Double {
  let n = math_quadratic_prog_series_len(s)
  if n == 0 { 0.0 } else { math_quadratic_prog_series_sum(s) / n.to_double() }
}

pub fn math_quadratic_prog_series_min(s : MathquadraticprogSeries) -> Double {
  let n = math_quadratic_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_quadratic_prog_series_max(s : MathquadraticprogSeries) -> Double {
  let n = math_quadratic_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_quadratic_prog_series_range(s : MathquadraticprogSeries) -> Double {
  math_quadratic_prog_series_max(s) - math_quadratic_prog_series_min(s)
}

pub fn math_quadratic_prog_series_var(s : MathquadraticprogSeries) -> Double {
  let n = math_quadratic_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_quadratic_prog_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_quadratic_prog_series_std(s : MathquadraticprogSeries) -> Double { @_common.sqrt(math_quadratic_prog_series_var(s)) }

pub fn math_quadratic_prog_series_median(s : MathquadraticprogSeries) -> Double {
  let n = math_quadratic_prog_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_quadratic_prog_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_quadratic_prog_series_scale(s : MathquadraticprogSeries, f : Double) -> MathquadraticprogSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_quadratic_prog_series_add(a : MathquadraticprogSeries, b : MathquadraticprogSeries) -> MathquadraticprogSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_quadratic_prog_series_sub(a : MathquadraticprogSeries, b : MathquadraticprogSeries) -> MathquadraticprogSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_quadratic_prog_series_normalize(s : MathquadraticprogSeries) -> MathquadraticprogSeries {
  let mn = math_quadratic_prog_series_min(s)
  let mx = math_quadratic_prog_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_quadratic_prog_series_cumsum(s : MathquadraticprogSeries) -> MathquadraticprogSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_quadratic_prog_series_to_string(s : MathquadraticprogSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathquadraticprogMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_quadratic_prog_make_matrix(rows : Int, cols : Int, val : Double) -> MathquadraticprogMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_quadratic_prog_matrix_identity(n : Int) -> MathquadraticprogMatrix {
  let m = math_quadratic_prog_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_quadratic_prog_matrix_get(m : MathquadraticprogMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_quadratic_prog_matrix_transpose(m : MathquadraticprogMatrix) -> MathquadraticprogMatrix {
  let result = math_quadratic_prog_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_quadratic_prog_matrix_add(a : MathquadraticprogMatrix, b : MathquadraticprogMatrix) -> MathquadraticprogMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_quadratic_prog_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_quadratic_prog_matrix_scale(m : MathquadraticprogMatrix, s : Double) -> MathquadraticprogMatrix {
  let result = math_quadratic_prog_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_quadratic_prog_matrix_multiply(a : MathquadraticprogMatrix, b : MathquadraticprogMatrix) -> MathquadraticprogMatrix {
  if a.cols != b.rows { return math_quadratic_prog_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_quadratic_prog_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_quadratic_prog_matrix_trace(m : MathquadraticprogMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_quadratic_prog_matrix_det(m : MathquadraticprogMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_quadratic_prog_matrix_norm(m : MathquadraticprogMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_quadratic_prog_matrix_to_string(m : MathquadraticprogMatrix) -> String {
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

pub(all) struct MathquadraticprogVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_quadratic_prog_make_vector(comps : Array[Double]) -> MathquadraticprogVector {
  { comps, dim: comps.length() }
}

pub fn math_quadratic_prog_vector_zero(dim : Int) -> MathquadraticprogVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_quadratic_prog_vector_add(a : MathquadraticprogVector, b : MathquadraticprogVector) -> MathquadraticprogVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_quadratic_prog_vector_sub(a : MathquadraticprogVector, b : MathquadraticprogVector) -> MathquadraticprogVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_quadratic_prog_vector_scale(v : MathquadraticprogVector, s : Double) -> MathquadraticprogVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_quadratic_prog_vector_dot(a : MathquadraticprogVector, b : MathquadraticprogVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_quadratic_prog_vector_norm(v : MathquadraticprogVector) -> Double { @_common.sqrt(math_quadratic_prog_vector_dot(v, v)) }

pub fn math_quadratic_prog_vector_normalize(v : MathquadraticprogVector) -> MathquadraticprogVector {
  let n = math_quadratic_prog_vector_norm(v)
  if n < 0.0000001 { v } else { math_quadratic_prog_vector_scale(v, 1.0 / n) }
}

pub fn math_quadratic_prog_vector_dist(a : MathquadraticprogVector, b : MathquadraticprogVector) -> Double {
  math_quadratic_prog_vector_norm(math_quadratic_prog_vector_sub(a, b))
}

pub fn math_quadratic_prog_vector_to_string(v : MathquadraticprogVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_quadratic_prog_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_quadratic_prog_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_quadratic_prog_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_quadratic_prog_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_quadratic_prog_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_quadratic_prog_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_quadratic_prog_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_quadratic_prog_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_quadratic_prog_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_quadratic_prog_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_quadratic_prog_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_quadratic_prog_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_quadratic_prog_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_quadratic_prog_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_quadratic_prog_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_quadratic_prog_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_quadratic_prog_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_quadratic_prog_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_quadratic_prog_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_quadratic_prog_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_quadratic_prog_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_quadratic_prog_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_quadratic_prog_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_quadratic_prog_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_quadratic_prog_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_quadratic_prog_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_quadratic_prog_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_quadratic_prog_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_quadratic_prog_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathquadraticprogFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_frame_make(size : Int) -> MathquadraticprogFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_frame_len(s : MathquadraticprogFrame) -> Int { s.size }

pub fn math_quadratic_prog_frame_get(s : MathquadraticprogFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_frame_set(s : MathquadraticprogFrame, i : Int, v : Double) -> MathquadraticprogFrame {
  let result = math_quadratic_prog_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_frame_sum(s : MathquadraticprogFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quadratic_prog_frame_mean(s : MathquadraticprogFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_quadratic_prog_frame_sum(s) / s.size.to_double() }
}

pub fn math_quadratic_prog_frame_scale(s : MathquadraticprogFrame, f : Double) -> MathquadraticprogFrame {
  let result = math_quadratic_prog_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quadratic_prog_frame_add(a : MathquadraticprogFrame, b : MathquadraticprogFrame) -> MathquadraticprogFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quadratic_prog_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quadratic_prog_frame_copy(s : MathquadraticprogFrame) -> MathquadraticprogFrame {
  let result = math_quadratic_prog_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quadratic_prog_frame_fill(s : MathquadraticprogFrame, v : Double) -> MathquadraticprogFrame {
  let result = math_quadratic_prog_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_frame_min(s : MathquadraticprogFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_frame_max(s : MathquadraticprogFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_frame_to_string(s : MathquadraticprogFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_table_make(size : Int) -> MathquadraticprogTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_table_len(s : MathquadraticprogTable) -> Int { s.size }

pub fn math_quadratic_prog_table_get(s : MathquadraticprogTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_table_set(s : MathquadraticprogTable, i : Int, v : Double) -> MathquadraticprogTable {
  let result = math_quadratic_prog_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_table_sum(s : MathquadraticprogTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quadratic_prog_table_mean(s : MathquadraticprogTable) -> Double {
  if s.size == 0 { 0.0 } else { math_quadratic_prog_table_sum(s) / s.size.to_double() }
}

pub fn math_quadratic_prog_table_scale(s : MathquadraticprogTable, f : Double) -> MathquadraticprogTable {
  let result = math_quadratic_prog_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quadratic_prog_table_add(a : MathquadraticprogTable, b : MathquadraticprogTable) -> MathquadraticprogTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quadratic_prog_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quadratic_prog_table_copy(s : MathquadraticprogTable) -> MathquadraticprogTable {
  let result = math_quadratic_prog_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quadratic_prog_table_fill(s : MathquadraticprogTable, v : Double) -> MathquadraticprogTable {
  let result = math_quadratic_prog_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_table_min(s : MathquadraticprogTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_table_max(s : MathquadraticprogTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_table_to_string(s : MathquadraticprogTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_graphn_make(size : Int) -> MathquadraticprogGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_graphn_len(s : MathquadraticprogGraphN) -> Int { s.size }

pub fn math_quadratic_prog_graphn_get(s : MathquadraticprogGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_graphn_set(s : MathquadraticprogGraphN, i : Int, v : Double) -> MathquadraticprogGraphN {
  let result = math_quadratic_prog_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_graphn_sum(s : MathquadraticprogGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quadratic_prog_graphn_mean(s : MathquadraticprogGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_quadratic_prog_graphn_sum(s) / s.size.to_double() }
}

pub fn math_quadratic_prog_graphn_scale(s : MathquadraticprogGraphN, f : Double) -> MathquadraticprogGraphN {
  let result = math_quadratic_prog_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quadratic_prog_graphn_add(a : MathquadraticprogGraphN, b : MathquadraticprogGraphN) -> MathquadraticprogGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quadratic_prog_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quadratic_prog_graphn_copy(s : MathquadraticprogGraphN) -> MathquadraticprogGraphN {
  let result = math_quadratic_prog_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quadratic_prog_graphn_fill(s : MathquadraticprogGraphN, v : Double) -> MathquadraticprogGraphN {
  let result = math_quadratic_prog_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_graphn_min(s : MathquadraticprogGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_graphn_max(s : MathquadraticprogGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_graphn_to_string(s : MathquadraticprogGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_node_make(size : Int) -> MathquadraticprogNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_node_len(s : MathquadraticprogNode) -> Int { s.size }

pub fn math_quadratic_prog_node_get(s : MathquadraticprogNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_node_set(s : MathquadraticprogNode, i : Int, v : Double) -> MathquadraticprogNode {
  let result = math_quadratic_prog_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_node_sum(s : MathquadraticprogNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quadratic_prog_node_mean(s : MathquadraticprogNode) -> Double {
  if s.size == 0 { 0.0 } else { math_quadratic_prog_node_sum(s) / s.size.to_double() }
}

pub fn math_quadratic_prog_node_scale(s : MathquadraticprogNode, f : Double) -> MathquadraticprogNode {
  let result = math_quadratic_prog_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quadratic_prog_node_add(a : MathquadraticprogNode, b : MathquadraticprogNode) -> MathquadraticprogNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quadratic_prog_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quadratic_prog_node_copy(s : MathquadraticprogNode) -> MathquadraticprogNode {
  let result = math_quadratic_prog_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quadratic_prog_node_fill(s : MathquadraticprogNode, v : Double) -> MathquadraticprogNode {
  let result = math_quadratic_prog_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_node_min(s : MathquadraticprogNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_node_max(s : MathquadraticprogNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_node_to_string(s : MathquadraticprogNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_edge_make(size : Int) -> MathquadraticprogEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_edge_len(s : MathquadraticprogEdge) -> Int { s.size }

pub fn math_quadratic_prog_edge_get(s : MathquadraticprogEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_edge_set(s : MathquadraticprogEdge, i : Int, v : Double) -> MathquadraticprogEdge {
  let result = math_quadratic_prog_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_edge_sum(s : MathquadraticprogEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quadratic_prog_edge_mean(s : MathquadraticprogEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_quadratic_prog_edge_sum(s) / s.size.to_double() }
}

pub fn math_quadratic_prog_edge_scale(s : MathquadraticprogEdge, f : Double) -> MathquadraticprogEdge {
  let result = math_quadratic_prog_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quadratic_prog_edge_add(a : MathquadraticprogEdge, b : MathquadraticprogEdge) -> MathquadraticprogEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quadratic_prog_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quadratic_prog_edge_copy(s : MathquadraticprogEdge) -> MathquadraticprogEdge {
  let result = math_quadratic_prog_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quadratic_prog_edge_fill(s : MathquadraticprogEdge, v : Double) -> MathquadraticprogEdge {
  let result = math_quadratic_prog_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_edge_min(s : MathquadraticprogEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_edge_max(s : MathquadraticprogEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_edge_to_string(s : MathquadraticprogEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_path_make(size : Int) -> MathquadraticprogPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_path_len(s : MathquadraticprogPath) -> Int { s.size }

pub fn math_quadratic_prog_path_get(s : MathquadraticprogPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_path_set(s : MathquadraticprogPath, i : Int, v : Double) -> MathquadraticprogPath {
  let result = math_quadratic_prog_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_path_sum(s : MathquadraticprogPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quadratic_prog_path_mean(s : MathquadraticprogPath) -> Double {
  if s.size == 0 { 0.0 } else { math_quadratic_prog_path_sum(s) / s.size.to_double() }
}

pub fn math_quadratic_prog_path_scale(s : MathquadraticprogPath, f : Double) -> MathquadraticprogPath {
  let result = math_quadratic_prog_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quadratic_prog_path_add(a : MathquadraticprogPath, b : MathquadraticprogPath) -> MathquadraticprogPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quadratic_prog_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quadratic_prog_path_copy(s : MathquadraticprogPath) -> MathquadraticprogPath {
  let result = math_quadratic_prog_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quadratic_prog_path_fill(s : MathquadraticprogPath, v : Double) -> MathquadraticprogPath {
  let result = math_quadratic_prog_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_path_min(s : MathquadraticprogPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_path_max(s : MathquadraticprogPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_path_to_string(s : MathquadraticprogPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_cluster_make(size : Int) -> MathquadraticprogCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_cluster_len(s : MathquadraticprogCluster) -> Int { s.size }

pub fn math_quadratic_prog_cluster_get(s : MathquadraticprogCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_cluster_set(s : MathquadraticprogCluster, i : Int, v : Double) -> MathquadraticprogCluster {
  let result = math_quadratic_prog_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_cluster_sum(s : MathquadraticprogCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quadratic_prog_cluster_mean(s : MathquadraticprogCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_quadratic_prog_cluster_sum(s) / s.size.to_double() }
}

pub fn math_quadratic_prog_cluster_scale(s : MathquadraticprogCluster, f : Double) -> MathquadraticprogCluster {
  let result = math_quadratic_prog_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quadratic_prog_cluster_add(a : MathquadraticprogCluster, b : MathquadraticprogCluster) -> MathquadraticprogCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quadratic_prog_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quadratic_prog_cluster_copy(s : MathquadraticprogCluster) -> MathquadraticprogCluster {
  let result = math_quadratic_prog_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quadratic_prog_cluster_fill(s : MathquadraticprogCluster, v : Double) -> MathquadraticprogCluster {
  let result = math_quadratic_prog_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_cluster_min(s : MathquadraticprogCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_cluster_max(s : MathquadraticprogCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_cluster_to_string(s : MathquadraticprogCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_model_make(size : Int) -> MathquadraticprogModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_model_len(s : MathquadraticprogModel) -> Int { s.size }

pub fn math_quadratic_prog_model_get(s : MathquadraticprogModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_model_set(s : MathquadraticprogModel, i : Int, v : Double) -> MathquadraticprogModel {
  let result = math_quadratic_prog_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_model_sum(s : MathquadraticprogModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quadratic_prog_model_mean(s : MathquadraticprogModel) -> Double {
  if s.size == 0 { 0.0 } else { math_quadratic_prog_model_sum(s) / s.size.to_double() }
}

pub fn math_quadratic_prog_model_scale(s : MathquadraticprogModel, f : Double) -> MathquadraticprogModel {
  let result = math_quadratic_prog_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quadratic_prog_model_add(a : MathquadraticprogModel, b : MathquadraticprogModel) -> MathquadraticprogModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quadratic_prog_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quadratic_prog_model_copy(s : MathquadraticprogModel) -> MathquadraticprogModel {
  let result = math_quadratic_prog_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quadratic_prog_model_fill(s : MathquadraticprogModel, v : Double) -> MathquadraticprogModel {
  let result = math_quadratic_prog_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_model_min(s : MathquadraticprogModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_model_max(s : MathquadraticprogModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_model_to_string(s : MathquadraticprogModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_layer_make(size : Int) -> MathquadraticprogLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_layer_len(s : MathquadraticprogLayer) -> Int { s.size }

pub fn math_quadratic_prog_layer_get(s : MathquadraticprogLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_layer_set(s : MathquadraticprogLayer, i : Int, v : Double) -> MathquadraticprogLayer {
  let result = math_quadratic_prog_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_layer_sum(s : MathquadraticprogLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quadratic_prog_layer_mean(s : MathquadraticprogLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_quadratic_prog_layer_sum(s) / s.size.to_double() }
}

pub fn math_quadratic_prog_layer_scale(s : MathquadraticprogLayer, f : Double) -> MathquadraticprogLayer {
  let result = math_quadratic_prog_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quadratic_prog_layer_add(a : MathquadraticprogLayer, b : MathquadraticprogLayer) -> MathquadraticprogLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quadratic_prog_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quadratic_prog_layer_copy(s : MathquadraticprogLayer) -> MathquadraticprogLayer {
  let result = math_quadratic_prog_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quadratic_prog_layer_fill(s : MathquadraticprogLayer, v : Double) -> MathquadraticprogLayer {
  let result = math_quadratic_prog_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_layer_min(s : MathquadraticprogLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_layer_max(s : MathquadraticprogLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_layer_to_string(s : MathquadraticprogLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_buffer_make(size : Int) -> MathquadraticprogBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_buffer_len(s : MathquadraticprogBuffer) -> Int { s.size }

pub fn math_quadratic_prog_buffer_get(s : MathquadraticprogBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_buffer_set(s : MathquadraticprogBuffer, i : Int, v : Double) -> MathquadraticprogBuffer {
  let result = math_quadratic_prog_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_buffer_sum(s : MathquadraticprogBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quadratic_prog_buffer_mean(s : MathquadraticprogBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_quadratic_prog_buffer_sum(s) / s.size.to_double() }
}

pub fn math_quadratic_prog_buffer_scale(s : MathquadraticprogBuffer, f : Double) -> MathquadraticprogBuffer {
  let result = math_quadratic_prog_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quadratic_prog_buffer_add(a : MathquadraticprogBuffer, b : MathquadraticprogBuffer) -> MathquadraticprogBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quadratic_prog_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quadratic_prog_buffer_copy(s : MathquadraticprogBuffer) -> MathquadraticprogBuffer {
  let result = math_quadratic_prog_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quadratic_prog_buffer_fill(s : MathquadraticprogBuffer, v : Double) -> MathquadraticprogBuffer {
  let result = math_quadratic_prog_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_buffer_min(s : MathquadraticprogBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_buffer_max(s : MathquadraticprogBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_buffer_to_string(s : MathquadraticprogBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_cursor_make(size : Int) -> MathquadraticprogCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_cursor_len(s : MathquadraticprogCursor) -> Int { s.size }

pub fn math_quadratic_prog_cursor_get(s : MathquadraticprogCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_cursor_set(s : MathquadraticprogCursor, i : Int, v : Double) -> MathquadraticprogCursor {
  let result = math_quadratic_prog_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_cursor_sum(s : MathquadraticprogCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quadratic_prog_cursor_mean(s : MathquadraticprogCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_quadratic_prog_cursor_sum(s) / s.size.to_double() }
}

pub fn math_quadratic_prog_cursor_scale(s : MathquadraticprogCursor, f : Double) -> MathquadraticprogCursor {
  let result = math_quadratic_prog_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quadratic_prog_cursor_add(a : MathquadraticprogCursor, b : MathquadraticprogCursor) -> MathquadraticprogCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quadratic_prog_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quadratic_prog_cursor_copy(s : MathquadraticprogCursor) -> MathquadraticprogCursor {
  let result = math_quadratic_prog_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quadratic_prog_cursor_fill(s : MathquadraticprogCursor, v : Double) -> MathquadraticprogCursor {
  let result = math_quadratic_prog_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_cursor_min(s : MathquadraticprogCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_cursor_max(s : MathquadraticprogCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_cursor_to_string(s : MathquadraticprogCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_view_make(size : Int) -> MathquadraticprogView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_view_len(s : MathquadraticprogView) -> Int { s.size }

pub fn math_quadratic_prog_view_get(s : MathquadraticprogView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_view_set(s : MathquadraticprogView, i : Int, v : Double) -> MathquadraticprogView {
  let result = math_quadratic_prog_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_view_sum(s : MathquadraticprogView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quadratic_prog_view_mean(s : MathquadraticprogView) -> Double {
  if s.size == 0 { 0.0 } else { math_quadratic_prog_view_sum(s) / s.size.to_double() }
}

pub fn math_quadratic_prog_view_scale(s : MathquadraticprogView, f : Double) -> MathquadraticprogView {
  let result = math_quadratic_prog_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quadratic_prog_view_add(a : MathquadraticprogView, b : MathquadraticprogView) -> MathquadraticprogView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quadratic_prog_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quadratic_prog_view_copy(s : MathquadraticprogView) -> MathquadraticprogView {
  let result = math_quadratic_prog_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quadratic_prog_view_fill(s : MathquadraticprogView, v : Double) -> MathquadraticprogView {
  let result = math_quadratic_prog_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_view_min(s : MathquadraticprogView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_view_max(s : MathquadraticprogView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_view_to_string(s : MathquadraticprogView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_range_make(size : Int) -> MathquadraticprogRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_range_len(s : MathquadraticprogRange) -> Int { s.size }

pub fn math_quadratic_prog_range_get(s : MathquadraticprogRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_range_set(s : MathquadraticprogRange, i : Int, v : Double) -> MathquadraticprogRange {
  let result = math_quadratic_prog_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_range_sum(s : MathquadraticprogRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quadratic_prog_range_mean(s : MathquadraticprogRange) -> Double {
  if s.size == 0 { 0.0 } else { math_quadratic_prog_range_sum(s) / s.size.to_double() }
}

pub fn math_quadratic_prog_range_scale(s : MathquadraticprogRange, f : Double) -> MathquadraticprogRange {
  let result = math_quadratic_prog_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quadratic_prog_range_add(a : MathquadraticprogRange, b : MathquadraticprogRange) -> MathquadraticprogRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quadratic_prog_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quadratic_prog_range_copy(s : MathquadraticprogRange) -> MathquadraticprogRange {
  let result = math_quadratic_prog_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quadratic_prog_range_fill(s : MathquadraticprogRange, v : Double) -> MathquadraticprogRange {
  let result = math_quadratic_prog_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_range_min(s : MathquadraticprogRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_range_max(s : MathquadraticprogRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_range_to_string(s : MathquadraticprogRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathquadraticprogSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_quadratic_prog_slice_make(size : Int) -> MathquadraticprogSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_quadratic_prog_slice_len(s : MathquadraticprogSlice) -> Int { s.size }

pub fn math_quadratic_prog_slice_get(s : MathquadraticprogSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_quadratic_prog_slice_set(s : MathquadraticprogSlice, i : Int, v : Double) -> MathquadraticprogSlice {
  let result = math_quadratic_prog_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_slice_sum(s : MathquadraticprogSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_quadratic_prog_slice_mean(s : MathquadraticprogSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_quadratic_prog_slice_sum(s) / s.size.to_double() }
}

pub fn math_quadratic_prog_slice_scale(s : MathquadraticprogSlice, f : Double) -> MathquadraticprogSlice {
  let result = math_quadratic_prog_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_quadratic_prog_slice_add(a : MathquadraticprogSlice, b : MathquadraticprogSlice) -> MathquadraticprogSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_quadratic_prog_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_quadratic_prog_slice_copy(s : MathquadraticprogSlice) -> MathquadraticprogSlice {
  let result = math_quadratic_prog_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_quadratic_prog_slice_fill(s : MathquadraticprogSlice, v : Double) -> MathquadraticprogSlice {
  let result = math_quadratic_prog_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_quadratic_prog_slice_min(s : MathquadraticprogSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_slice_max(s : MathquadraticprogSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_quadratic_prog_slice_to_string(s : MathquadraticprogSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

