///===
/// extcore/math_simplex

pub(all) struct MathsimplexPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_simplex_make_point(x : Double, y : Double) -> MathsimplexPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_simplex_make_point3(x : Double, y : Double, z : Double) -> MathsimplexPoint {
  { x, y, z, label: 0 }
}

pub fn math_simplex_point_x(pt : MathsimplexPoint) -> Double { pt.x }

pub fn math_simplex_point_y(pt : MathsimplexPoint) -> Double { pt.y }

pub fn math_simplex_point_z(pt : MathsimplexPoint) -> Double { pt.z }

pub fn math_simplex_point_label(pt : MathsimplexPoint) -> Int { pt.label }

pub fn math_simplex_point_dist(a : MathsimplexPoint, b : MathsimplexPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_simplex_point_add(a : MathsimplexPoint, b : MathsimplexPoint) -> MathsimplexPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_simplex_point_sub(a : MathsimplexPoint, b : MathsimplexPoint) -> MathsimplexPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_simplex_point_scale(pt : MathsimplexPoint, s : Double) -> MathsimplexPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_simplex_point_dot(a : MathsimplexPoint, b : MathsimplexPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_simplex_point_cross(a : MathsimplexPoint, b : MathsimplexPoint) -> MathsimplexPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_simplex_point_norm(pt : MathsimplexPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_simplex_point_normalize(pt : MathsimplexPoint) -> MathsimplexPoint {
  let n = math_simplex_point_norm(pt)
  if n < 0.0000001 { pt } else { math_simplex_point_scale(pt, 1.0 / n) }
}

pub fn math_simplex_point_negate(pt : MathsimplexPoint) -> MathsimplexPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_simplex_point_mid(a : MathsimplexPoint, b : MathsimplexPoint) -> MathsimplexPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_simplex_point_lerp(a : MathsimplexPoint, b : MathsimplexPoint, t : Double) -> MathsimplexPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_simplex_point_to_string(pt : MathsimplexPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathsimplexSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_simplex_make_series(vals : Array[Double], name : String) -> MathsimplexSeries {
  { vals, name, meta: 0 }
}

pub fn math_simplex_series_len(s : MathsimplexSeries) -> Int { s.vals.length() }

pub fn math_simplex_series_sum(s : MathsimplexSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_simplex_series_mean(s : MathsimplexSeries) -> Double {
  let n = math_simplex_series_len(s)
  if n == 0 { 0.0 } else { math_simplex_series_sum(s) / n.to_double() }
}

pub fn math_simplex_series_min(s : MathsimplexSeries) -> Double {
  let n = math_simplex_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_simplex_series_max(s : MathsimplexSeries) -> Double {
  let n = math_simplex_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_simplex_series_range(s : MathsimplexSeries) -> Double {
  math_simplex_series_max(s) - math_simplex_series_min(s)
}

pub fn math_simplex_series_var(s : MathsimplexSeries) -> Double {
  let n = math_simplex_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_simplex_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_simplex_series_std(s : MathsimplexSeries) -> Double { @_common.sqrt(math_simplex_series_var(s)) }

pub fn math_simplex_series_median(s : MathsimplexSeries) -> Double {
  let n = math_simplex_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_simplex_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_simplex_series_scale(s : MathsimplexSeries, f : Double) -> MathsimplexSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_simplex_series_add(a : MathsimplexSeries, b : MathsimplexSeries) -> MathsimplexSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_simplex_series_sub(a : MathsimplexSeries, b : MathsimplexSeries) -> MathsimplexSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_simplex_series_normalize(s : MathsimplexSeries) -> MathsimplexSeries {
  let mn = math_simplex_series_min(s)
  let mx = math_simplex_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_simplex_series_cumsum(s : MathsimplexSeries) -> MathsimplexSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_simplex_series_to_string(s : MathsimplexSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathsimplexMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_simplex_make_matrix(rows : Int, cols : Int, val : Double) -> MathsimplexMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_simplex_matrix_identity(n : Int) -> MathsimplexMatrix {
  let m = math_simplex_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_simplex_matrix_get(m : MathsimplexMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_simplex_matrix_transpose(m : MathsimplexMatrix) -> MathsimplexMatrix {
  let result = math_simplex_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_simplex_matrix_add(a : MathsimplexMatrix, b : MathsimplexMatrix) -> MathsimplexMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_simplex_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_simplex_matrix_scale(m : MathsimplexMatrix, s : Double) -> MathsimplexMatrix {
  let result = math_simplex_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_simplex_matrix_multiply(a : MathsimplexMatrix, b : MathsimplexMatrix) -> MathsimplexMatrix {
  if a.cols != b.rows { return math_simplex_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_simplex_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_simplex_matrix_trace(m : MathsimplexMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_simplex_matrix_det(m : MathsimplexMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_simplex_matrix_norm(m : MathsimplexMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_simplex_matrix_to_string(m : MathsimplexMatrix) -> String {
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

pub(all) struct MathsimplexVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_simplex_make_vector(comps : Array[Double]) -> MathsimplexVector {
  { comps, dim: comps.length() }
}

pub fn math_simplex_vector_zero(dim : Int) -> MathsimplexVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_simplex_vector_add(a : MathsimplexVector, b : MathsimplexVector) -> MathsimplexVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_simplex_vector_sub(a : MathsimplexVector, b : MathsimplexVector) -> MathsimplexVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_simplex_vector_scale(v : MathsimplexVector, s : Double) -> MathsimplexVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_simplex_vector_dot(a : MathsimplexVector, b : MathsimplexVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_simplex_vector_norm(v : MathsimplexVector) -> Double { @_common.sqrt(math_simplex_vector_dot(v, v)) }

pub fn math_simplex_vector_normalize(v : MathsimplexVector) -> MathsimplexVector {
  let n = math_simplex_vector_norm(v)
  if n < 0.0000001 { v } else { math_simplex_vector_scale(v, 1.0 / n) }
}

pub fn math_simplex_vector_dist(a : MathsimplexVector, b : MathsimplexVector) -> Double {
  math_simplex_vector_norm(math_simplex_vector_sub(a, b))
}

pub fn math_simplex_vector_to_string(v : MathsimplexVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_simplex_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_simplex_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_simplex_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_simplex_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_simplex_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_simplex_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_simplex_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_simplex_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_simplex_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_simplex_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_simplex_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_simplex_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_simplex_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_simplex_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_simplex_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_simplex_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_simplex_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_simplex_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_simplex_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_simplex_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_simplex_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_simplex_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_simplex_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_simplex_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_simplex_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_simplex_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_simplex_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_simplex_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_simplex_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathsimplexFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_simplex_frame_make(size : Int) -> MathsimplexFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_simplex_frame_len(s : MathsimplexFrame) -> Int { s.size }

pub fn math_simplex_frame_get(s : MathsimplexFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_simplex_frame_set(s : MathsimplexFrame, i : Int, v : Double) -> MathsimplexFrame {
  let result = math_simplex_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_simplex_frame_sum(s : MathsimplexFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_simplex_frame_mean(s : MathsimplexFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_simplex_frame_sum(s) / s.size.to_double() }
}

pub fn math_simplex_frame_scale(s : MathsimplexFrame, f : Double) -> MathsimplexFrame {
  let result = math_simplex_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_simplex_frame_add(a : MathsimplexFrame, b : MathsimplexFrame) -> MathsimplexFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_simplex_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_simplex_frame_copy(s : MathsimplexFrame) -> MathsimplexFrame {
  let result = math_simplex_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_simplex_frame_fill(s : MathsimplexFrame, v : Double) -> MathsimplexFrame {
  let result = math_simplex_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_simplex_frame_min(s : MathsimplexFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_frame_max(s : MathsimplexFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_frame_to_string(s : MathsimplexFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsimplexTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_simplex_table_make(size : Int) -> MathsimplexTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_simplex_table_len(s : MathsimplexTable) -> Int { s.size }

pub fn math_simplex_table_get(s : MathsimplexTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_simplex_table_set(s : MathsimplexTable, i : Int, v : Double) -> MathsimplexTable {
  let result = math_simplex_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_simplex_table_sum(s : MathsimplexTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_simplex_table_mean(s : MathsimplexTable) -> Double {
  if s.size == 0 { 0.0 } else { math_simplex_table_sum(s) / s.size.to_double() }
}

pub fn math_simplex_table_scale(s : MathsimplexTable, f : Double) -> MathsimplexTable {
  let result = math_simplex_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_simplex_table_add(a : MathsimplexTable, b : MathsimplexTable) -> MathsimplexTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_simplex_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_simplex_table_copy(s : MathsimplexTable) -> MathsimplexTable {
  let result = math_simplex_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_simplex_table_fill(s : MathsimplexTable, v : Double) -> MathsimplexTable {
  let result = math_simplex_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_simplex_table_min(s : MathsimplexTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_table_max(s : MathsimplexTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_table_to_string(s : MathsimplexTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsimplexGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_simplex_graphn_make(size : Int) -> MathsimplexGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_simplex_graphn_len(s : MathsimplexGraphN) -> Int { s.size }

pub fn math_simplex_graphn_get(s : MathsimplexGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_simplex_graphn_set(s : MathsimplexGraphN, i : Int, v : Double) -> MathsimplexGraphN {
  let result = math_simplex_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_simplex_graphn_sum(s : MathsimplexGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_simplex_graphn_mean(s : MathsimplexGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_simplex_graphn_sum(s) / s.size.to_double() }
}

pub fn math_simplex_graphn_scale(s : MathsimplexGraphN, f : Double) -> MathsimplexGraphN {
  let result = math_simplex_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_simplex_graphn_add(a : MathsimplexGraphN, b : MathsimplexGraphN) -> MathsimplexGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_simplex_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_simplex_graphn_copy(s : MathsimplexGraphN) -> MathsimplexGraphN {
  let result = math_simplex_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_simplex_graphn_fill(s : MathsimplexGraphN, v : Double) -> MathsimplexGraphN {
  let result = math_simplex_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_simplex_graphn_min(s : MathsimplexGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_graphn_max(s : MathsimplexGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_graphn_to_string(s : MathsimplexGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsimplexNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_simplex_node_make(size : Int) -> MathsimplexNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_simplex_node_len(s : MathsimplexNode) -> Int { s.size }

pub fn math_simplex_node_get(s : MathsimplexNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_simplex_node_set(s : MathsimplexNode, i : Int, v : Double) -> MathsimplexNode {
  let result = math_simplex_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_simplex_node_sum(s : MathsimplexNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_simplex_node_mean(s : MathsimplexNode) -> Double {
  if s.size == 0 { 0.0 } else { math_simplex_node_sum(s) / s.size.to_double() }
}

pub fn math_simplex_node_scale(s : MathsimplexNode, f : Double) -> MathsimplexNode {
  let result = math_simplex_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_simplex_node_add(a : MathsimplexNode, b : MathsimplexNode) -> MathsimplexNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_simplex_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_simplex_node_copy(s : MathsimplexNode) -> MathsimplexNode {
  let result = math_simplex_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_simplex_node_fill(s : MathsimplexNode, v : Double) -> MathsimplexNode {
  let result = math_simplex_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_simplex_node_min(s : MathsimplexNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_node_max(s : MathsimplexNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_node_to_string(s : MathsimplexNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsimplexEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_simplex_edge_make(size : Int) -> MathsimplexEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_simplex_edge_len(s : MathsimplexEdge) -> Int { s.size }

pub fn math_simplex_edge_get(s : MathsimplexEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_simplex_edge_set(s : MathsimplexEdge, i : Int, v : Double) -> MathsimplexEdge {
  let result = math_simplex_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_simplex_edge_sum(s : MathsimplexEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_simplex_edge_mean(s : MathsimplexEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_simplex_edge_sum(s) / s.size.to_double() }
}

pub fn math_simplex_edge_scale(s : MathsimplexEdge, f : Double) -> MathsimplexEdge {
  let result = math_simplex_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_simplex_edge_add(a : MathsimplexEdge, b : MathsimplexEdge) -> MathsimplexEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_simplex_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_simplex_edge_copy(s : MathsimplexEdge) -> MathsimplexEdge {
  let result = math_simplex_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_simplex_edge_fill(s : MathsimplexEdge, v : Double) -> MathsimplexEdge {
  let result = math_simplex_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_simplex_edge_min(s : MathsimplexEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_edge_max(s : MathsimplexEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_edge_to_string(s : MathsimplexEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsimplexPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_simplex_path_make(size : Int) -> MathsimplexPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_simplex_path_len(s : MathsimplexPath) -> Int { s.size }

pub fn math_simplex_path_get(s : MathsimplexPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_simplex_path_set(s : MathsimplexPath, i : Int, v : Double) -> MathsimplexPath {
  let result = math_simplex_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_simplex_path_sum(s : MathsimplexPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_simplex_path_mean(s : MathsimplexPath) -> Double {
  if s.size == 0 { 0.0 } else { math_simplex_path_sum(s) / s.size.to_double() }
}

pub fn math_simplex_path_scale(s : MathsimplexPath, f : Double) -> MathsimplexPath {
  let result = math_simplex_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_simplex_path_add(a : MathsimplexPath, b : MathsimplexPath) -> MathsimplexPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_simplex_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_simplex_path_copy(s : MathsimplexPath) -> MathsimplexPath {
  let result = math_simplex_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_simplex_path_fill(s : MathsimplexPath, v : Double) -> MathsimplexPath {
  let result = math_simplex_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_simplex_path_min(s : MathsimplexPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_path_max(s : MathsimplexPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_path_to_string(s : MathsimplexPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsimplexCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_simplex_cluster_make(size : Int) -> MathsimplexCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_simplex_cluster_len(s : MathsimplexCluster) -> Int { s.size }

pub fn math_simplex_cluster_get(s : MathsimplexCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_simplex_cluster_set(s : MathsimplexCluster, i : Int, v : Double) -> MathsimplexCluster {
  let result = math_simplex_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_simplex_cluster_sum(s : MathsimplexCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_simplex_cluster_mean(s : MathsimplexCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_simplex_cluster_sum(s) / s.size.to_double() }
}

pub fn math_simplex_cluster_scale(s : MathsimplexCluster, f : Double) -> MathsimplexCluster {
  let result = math_simplex_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_simplex_cluster_add(a : MathsimplexCluster, b : MathsimplexCluster) -> MathsimplexCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_simplex_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_simplex_cluster_copy(s : MathsimplexCluster) -> MathsimplexCluster {
  let result = math_simplex_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_simplex_cluster_fill(s : MathsimplexCluster, v : Double) -> MathsimplexCluster {
  let result = math_simplex_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_simplex_cluster_min(s : MathsimplexCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_cluster_max(s : MathsimplexCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_cluster_to_string(s : MathsimplexCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsimplexModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_simplex_model_make(size : Int) -> MathsimplexModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_simplex_model_len(s : MathsimplexModel) -> Int { s.size }

pub fn math_simplex_model_get(s : MathsimplexModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_simplex_model_set(s : MathsimplexModel, i : Int, v : Double) -> MathsimplexModel {
  let result = math_simplex_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_simplex_model_sum(s : MathsimplexModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_simplex_model_mean(s : MathsimplexModel) -> Double {
  if s.size == 0 { 0.0 } else { math_simplex_model_sum(s) / s.size.to_double() }
}

pub fn math_simplex_model_scale(s : MathsimplexModel, f : Double) -> MathsimplexModel {
  let result = math_simplex_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_simplex_model_add(a : MathsimplexModel, b : MathsimplexModel) -> MathsimplexModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_simplex_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_simplex_model_copy(s : MathsimplexModel) -> MathsimplexModel {
  let result = math_simplex_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_simplex_model_fill(s : MathsimplexModel, v : Double) -> MathsimplexModel {
  let result = math_simplex_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_simplex_model_min(s : MathsimplexModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_model_max(s : MathsimplexModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_model_to_string(s : MathsimplexModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsimplexLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_simplex_layer_make(size : Int) -> MathsimplexLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_simplex_layer_len(s : MathsimplexLayer) -> Int { s.size }

pub fn math_simplex_layer_get(s : MathsimplexLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_simplex_layer_set(s : MathsimplexLayer, i : Int, v : Double) -> MathsimplexLayer {
  let result = math_simplex_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_simplex_layer_sum(s : MathsimplexLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_simplex_layer_mean(s : MathsimplexLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_simplex_layer_sum(s) / s.size.to_double() }
}

pub fn math_simplex_layer_scale(s : MathsimplexLayer, f : Double) -> MathsimplexLayer {
  let result = math_simplex_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_simplex_layer_add(a : MathsimplexLayer, b : MathsimplexLayer) -> MathsimplexLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_simplex_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_simplex_layer_copy(s : MathsimplexLayer) -> MathsimplexLayer {
  let result = math_simplex_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_simplex_layer_fill(s : MathsimplexLayer, v : Double) -> MathsimplexLayer {
  let result = math_simplex_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_simplex_layer_min(s : MathsimplexLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_layer_max(s : MathsimplexLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_layer_to_string(s : MathsimplexLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsimplexBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_simplex_buffer_make(size : Int) -> MathsimplexBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_simplex_buffer_len(s : MathsimplexBuffer) -> Int { s.size }

pub fn math_simplex_buffer_get(s : MathsimplexBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_simplex_buffer_set(s : MathsimplexBuffer, i : Int, v : Double) -> MathsimplexBuffer {
  let result = math_simplex_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_simplex_buffer_sum(s : MathsimplexBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_simplex_buffer_mean(s : MathsimplexBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_simplex_buffer_sum(s) / s.size.to_double() }
}

pub fn math_simplex_buffer_scale(s : MathsimplexBuffer, f : Double) -> MathsimplexBuffer {
  let result = math_simplex_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_simplex_buffer_add(a : MathsimplexBuffer, b : MathsimplexBuffer) -> MathsimplexBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_simplex_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_simplex_buffer_copy(s : MathsimplexBuffer) -> MathsimplexBuffer {
  let result = math_simplex_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_simplex_buffer_fill(s : MathsimplexBuffer, v : Double) -> MathsimplexBuffer {
  let result = math_simplex_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_simplex_buffer_min(s : MathsimplexBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_buffer_max(s : MathsimplexBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_buffer_to_string(s : MathsimplexBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsimplexCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_simplex_cursor_make(size : Int) -> MathsimplexCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_simplex_cursor_len(s : MathsimplexCursor) -> Int { s.size }

pub fn math_simplex_cursor_get(s : MathsimplexCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_simplex_cursor_set(s : MathsimplexCursor, i : Int, v : Double) -> MathsimplexCursor {
  let result = math_simplex_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_simplex_cursor_sum(s : MathsimplexCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_simplex_cursor_mean(s : MathsimplexCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_simplex_cursor_sum(s) / s.size.to_double() }
}

pub fn math_simplex_cursor_scale(s : MathsimplexCursor, f : Double) -> MathsimplexCursor {
  let result = math_simplex_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_simplex_cursor_add(a : MathsimplexCursor, b : MathsimplexCursor) -> MathsimplexCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_simplex_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_simplex_cursor_copy(s : MathsimplexCursor) -> MathsimplexCursor {
  let result = math_simplex_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_simplex_cursor_fill(s : MathsimplexCursor, v : Double) -> MathsimplexCursor {
  let result = math_simplex_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_simplex_cursor_min(s : MathsimplexCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_cursor_max(s : MathsimplexCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_cursor_to_string(s : MathsimplexCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsimplexView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_simplex_view_make(size : Int) -> MathsimplexView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_simplex_view_len(s : MathsimplexView) -> Int { s.size }

pub fn math_simplex_view_get(s : MathsimplexView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_simplex_view_set(s : MathsimplexView, i : Int, v : Double) -> MathsimplexView {
  let result = math_simplex_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_simplex_view_sum(s : MathsimplexView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_simplex_view_mean(s : MathsimplexView) -> Double {
  if s.size == 0 { 0.0 } else { math_simplex_view_sum(s) / s.size.to_double() }
}

pub fn math_simplex_view_scale(s : MathsimplexView, f : Double) -> MathsimplexView {
  let result = math_simplex_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_simplex_view_add(a : MathsimplexView, b : MathsimplexView) -> MathsimplexView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_simplex_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_simplex_view_copy(s : MathsimplexView) -> MathsimplexView {
  let result = math_simplex_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_simplex_view_fill(s : MathsimplexView, v : Double) -> MathsimplexView {
  let result = math_simplex_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_simplex_view_min(s : MathsimplexView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_view_max(s : MathsimplexView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_view_to_string(s : MathsimplexView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsimplexRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_simplex_range_make(size : Int) -> MathsimplexRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_simplex_range_len(s : MathsimplexRange) -> Int { s.size }

pub fn math_simplex_range_get(s : MathsimplexRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_simplex_range_set(s : MathsimplexRange, i : Int, v : Double) -> MathsimplexRange {
  let result = math_simplex_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_simplex_range_sum(s : MathsimplexRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_simplex_range_mean(s : MathsimplexRange) -> Double {
  if s.size == 0 { 0.0 } else { math_simplex_range_sum(s) / s.size.to_double() }
}

pub fn math_simplex_range_scale(s : MathsimplexRange, f : Double) -> MathsimplexRange {
  let result = math_simplex_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_simplex_range_add(a : MathsimplexRange, b : MathsimplexRange) -> MathsimplexRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_simplex_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_simplex_range_copy(s : MathsimplexRange) -> MathsimplexRange {
  let result = math_simplex_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_simplex_range_fill(s : MathsimplexRange, v : Double) -> MathsimplexRange {
  let result = math_simplex_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_simplex_range_min(s : MathsimplexRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_range_max(s : MathsimplexRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_range_to_string(s : MathsimplexRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsimplexSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_simplex_slice_make(size : Int) -> MathsimplexSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_simplex_slice_len(s : MathsimplexSlice) -> Int { s.size }

pub fn math_simplex_slice_get(s : MathsimplexSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_simplex_slice_set(s : MathsimplexSlice, i : Int, v : Double) -> MathsimplexSlice {
  let result = math_simplex_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_simplex_slice_sum(s : MathsimplexSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_simplex_slice_mean(s : MathsimplexSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_simplex_slice_sum(s) / s.size.to_double() }
}

pub fn math_simplex_slice_scale(s : MathsimplexSlice, f : Double) -> MathsimplexSlice {
  let result = math_simplex_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_simplex_slice_add(a : MathsimplexSlice, b : MathsimplexSlice) -> MathsimplexSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_simplex_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_simplex_slice_copy(s : MathsimplexSlice) -> MathsimplexSlice {
  let result = math_simplex_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_simplex_slice_fill(s : MathsimplexSlice, v : Double) -> MathsimplexSlice {
  let result = math_simplex_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_simplex_slice_min(s : MathsimplexSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_slice_max(s : MathsimplexSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_simplex_slice_to_string(s : MathsimplexSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

