///===
/// extcore/math_approx_fourier

pub(all) struct MathapproxfourierPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_fourier_make_point(x : Double, y : Double) -> MathapproxfourierPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_fourier_make_point3(x : Double, y : Double, z : Double) -> MathapproxfourierPoint {
  { x, y, z, label: 0 }
}

pub fn math_approx_fourier_point_x(pt : MathapproxfourierPoint) -> Double { pt.x }

pub fn math_approx_fourier_point_y(pt : MathapproxfourierPoint) -> Double { pt.y }

pub fn math_approx_fourier_point_z(pt : MathapproxfourierPoint) -> Double { pt.z }

pub fn math_approx_fourier_point_label(pt : MathapproxfourierPoint) -> Int { pt.label }

pub fn math_approx_fourier_point_dist(a : MathapproxfourierPoint, b : MathapproxfourierPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_approx_fourier_point_add(a : MathapproxfourierPoint, b : MathapproxfourierPoint) -> MathapproxfourierPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_approx_fourier_point_sub(a : MathapproxfourierPoint, b : MathapproxfourierPoint) -> MathapproxfourierPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_approx_fourier_point_scale(pt : MathapproxfourierPoint, s : Double) -> MathapproxfourierPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_approx_fourier_point_dot(a : MathapproxfourierPoint, b : MathapproxfourierPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_approx_fourier_point_cross(a : MathapproxfourierPoint, b : MathapproxfourierPoint) -> MathapproxfourierPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_approx_fourier_point_norm(pt : MathapproxfourierPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_approx_fourier_point_normalize(pt : MathapproxfourierPoint) -> MathapproxfourierPoint {
  let n = math_approx_fourier_point_norm(pt)
  if n < 0.0000001 { pt } else { math_approx_fourier_point_scale(pt, 1.0 / n) }
}

pub fn math_approx_fourier_point_negate(pt : MathapproxfourierPoint) -> MathapproxfourierPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_approx_fourier_point_mid(a : MathapproxfourierPoint, b : MathapproxfourierPoint) -> MathapproxfourierPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_approx_fourier_point_lerp(a : MathapproxfourierPoint, b : MathapproxfourierPoint, t : Double) -> MathapproxfourierPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_approx_fourier_point_to_string(pt : MathapproxfourierPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathapproxfourierSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_fourier_make_series(vals : Array[Double], name : String) -> MathapproxfourierSeries {
  { vals, name, meta: 0 }
}

pub fn math_approx_fourier_series_len(s : MathapproxfourierSeries) -> Int { s.vals.length() }

pub fn math_approx_fourier_series_sum(s : MathapproxfourierSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_approx_fourier_series_mean(s : MathapproxfourierSeries) -> Double {
  let n = math_approx_fourier_series_len(s)
  if n == 0 { 0.0 } else { math_approx_fourier_series_sum(s) / n.to_double() }
}

pub fn math_approx_fourier_series_min(s : MathapproxfourierSeries) -> Double {
  let n = math_approx_fourier_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn math_approx_fourier_series_max(s : MathapproxfourierSeries) -> Double {
  let n = math_approx_fourier_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn math_approx_fourier_series_range(s : MathapproxfourierSeries) -> Double {
  math_approx_fourier_series_max(s) - math_approx_fourier_series_min(s)
}

pub fn math_approx_fourier_series_var(s : MathapproxfourierSeries) -> Double {
  let n = math_approx_fourier_series_len(s)
  if n == 0 { 0.0 } else {
    let m = math_approx_fourier_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn math_approx_fourier_series_std(s : MathapproxfourierSeries) -> Double { @_common.sqrt(math_approx_fourier_series_var(s)) }

pub fn math_approx_fourier_series_median(s : MathapproxfourierSeries) -> Double {
  let n = math_approx_fourier_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = math_approx_fourier_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn math_approx_fourier_series_scale(s : MathapproxfourierSeries, f : Double) -> MathapproxfourierSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_approx_fourier_series_add(a : MathapproxfourierSeries, b : MathapproxfourierSeries) -> MathapproxfourierSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_approx_fourier_series_sub(a : MathapproxfourierSeries, b : MathapproxfourierSeries) -> MathapproxfourierSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_approx_fourier_series_normalize(s : MathapproxfourierSeries) -> MathapproxfourierSeries {
  let mn = math_approx_fourier_series_min(s)
  let mx = math_approx_fourier_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_approx_fourier_series_cumsum(s : MathapproxfourierSeries) -> MathapproxfourierSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_approx_fourier_series_to_string(s : MathapproxfourierSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxfourierMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_fourier_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxfourierMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_fourier_matrix_identity(n : Int) -> MathapproxfourierMatrix {
  let m = math_approx_fourier_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_approx_fourier_matrix_get(m : MathapproxfourierMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_approx_fourier_matrix_transpose(m : MathapproxfourierMatrix) -> MathapproxfourierMatrix {
  let result = math_approx_fourier_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_approx_fourier_matrix_add(a : MathapproxfourierMatrix, b : MathapproxfourierMatrix) -> MathapproxfourierMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_approx_fourier_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_approx_fourier_matrix_scale(m : MathapproxfourierMatrix, s : Double) -> MathapproxfourierMatrix {
  let result = math_approx_fourier_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_approx_fourier_matrix_multiply(a : MathapproxfourierMatrix, b : MathapproxfourierMatrix) -> MathapproxfourierMatrix {
  if a.cols != b.rows { return math_approx_fourier_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_approx_fourier_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_approx_fourier_matrix_trace(m : MathapproxfourierMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_approx_fourier_matrix_det(m : MathapproxfourierMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_approx_fourier_matrix_norm(m : MathapproxfourierMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_approx_fourier_matrix_to_string(m : MathapproxfourierMatrix) -> String {
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

pub(all) struct MathapproxfourierVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_fourier_make_vector(comps : Array[Double]) -> MathapproxfourierVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_fourier_vector_zero(dim : Int) -> MathapproxfourierVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_approx_fourier_vector_add(a : MathapproxfourierVector, b : MathapproxfourierVector) -> MathapproxfourierVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_fourier_vector_sub(a : MathapproxfourierVector, b : MathapproxfourierVector) -> MathapproxfourierVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_approx_fourier_vector_scale(v : MathapproxfourierVector, s : Double) -> MathapproxfourierVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_approx_fourier_vector_dot(a : MathapproxfourierVector, b : MathapproxfourierVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_approx_fourier_vector_norm(v : MathapproxfourierVector) -> Double { @_common.sqrt(math_approx_fourier_vector_dot(v, v)) }

pub fn math_approx_fourier_vector_normalize(v : MathapproxfourierVector) -> MathapproxfourierVector {
  let n = math_approx_fourier_vector_norm(v)
  if n < 0.0000001 { v } else { math_approx_fourier_vector_scale(v, 1.0 / n) }
}

pub fn math_approx_fourier_vector_dist(a : MathapproxfourierVector, b : MathapproxfourierVector) -> Double {
  math_approx_fourier_vector_norm(math_approx_fourier_vector_sub(a, b))
}

pub fn math_approx_fourier_vector_to_string(v : MathapproxfourierVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_fourier_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_approx_fourier_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_approx_fourier_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_approx_fourier_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_approx_fourier_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_approx_fourier_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_approx_fourier_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_approx_fourier_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_approx_fourier_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_approx_fourier_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_approx_fourier_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_approx_fourier_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_approx_fourier_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_approx_fourier_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_approx_fourier_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_approx_fourier_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_approx_fourier_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_approx_fourier_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_approx_fourier_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_approx_fourier_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_approx_fourier_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_approx_fourier_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_approx_fourier_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_approx_fourier_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_approx_fourier_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_approx_fourier_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_approx_fourier_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_approx_fourier_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_approx_fourier_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathapproxfourierFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_frame_make(size : Int) -> MathapproxfourierFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_frame_len(s : MathapproxfourierFrame) -> Int { s.size }

pub fn math_approx_fourier_frame_get(s : MathapproxfourierFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_frame_set(s : MathapproxfourierFrame, i : Int, v : Double) -> MathapproxfourierFrame {
  let result = math_approx_fourier_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_frame_sum(s : MathapproxfourierFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_fourier_frame_mean(s : MathapproxfourierFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_fourier_frame_sum(s) / s.size.to_double() }
}

pub fn math_approx_fourier_frame_scale(s : MathapproxfourierFrame, f : Double) -> MathapproxfourierFrame {
  let result = math_approx_fourier_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_fourier_frame_add(a : MathapproxfourierFrame, b : MathapproxfourierFrame) -> MathapproxfourierFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_fourier_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_fourier_frame_copy(s : MathapproxfourierFrame) -> MathapproxfourierFrame {
  let result = math_approx_fourier_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_fourier_frame_fill(s : MathapproxfourierFrame, v : Double) -> MathapproxfourierFrame {
  let result = math_approx_fourier_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_frame_min(s : MathapproxfourierFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_frame_max(s : MathapproxfourierFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_frame_to_string(s : MathapproxfourierFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_table_make(size : Int) -> MathapproxfourierTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_table_len(s : MathapproxfourierTable) -> Int { s.size }

pub fn math_approx_fourier_table_get(s : MathapproxfourierTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_table_set(s : MathapproxfourierTable, i : Int, v : Double) -> MathapproxfourierTable {
  let result = math_approx_fourier_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_table_sum(s : MathapproxfourierTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_fourier_table_mean(s : MathapproxfourierTable) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_fourier_table_sum(s) / s.size.to_double() }
}

pub fn math_approx_fourier_table_scale(s : MathapproxfourierTable, f : Double) -> MathapproxfourierTable {
  let result = math_approx_fourier_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_fourier_table_add(a : MathapproxfourierTable, b : MathapproxfourierTable) -> MathapproxfourierTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_fourier_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_fourier_table_copy(s : MathapproxfourierTable) -> MathapproxfourierTable {
  let result = math_approx_fourier_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_fourier_table_fill(s : MathapproxfourierTable, v : Double) -> MathapproxfourierTable {
  let result = math_approx_fourier_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_table_min(s : MathapproxfourierTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_table_max(s : MathapproxfourierTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_table_to_string(s : MathapproxfourierTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_graphn_make(size : Int) -> MathapproxfourierGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_graphn_len(s : MathapproxfourierGraphN) -> Int { s.size }

pub fn math_approx_fourier_graphn_get(s : MathapproxfourierGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_graphn_set(s : MathapproxfourierGraphN, i : Int, v : Double) -> MathapproxfourierGraphN {
  let result = math_approx_fourier_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_graphn_sum(s : MathapproxfourierGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_fourier_graphn_mean(s : MathapproxfourierGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_fourier_graphn_sum(s) / s.size.to_double() }
}

pub fn math_approx_fourier_graphn_scale(s : MathapproxfourierGraphN, f : Double) -> MathapproxfourierGraphN {
  let result = math_approx_fourier_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_fourier_graphn_add(a : MathapproxfourierGraphN, b : MathapproxfourierGraphN) -> MathapproxfourierGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_fourier_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_fourier_graphn_copy(s : MathapproxfourierGraphN) -> MathapproxfourierGraphN {
  let result = math_approx_fourier_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_fourier_graphn_fill(s : MathapproxfourierGraphN, v : Double) -> MathapproxfourierGraphN {
  let result = math_approx_fourier_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_graphn_min(s : MathapproxfourierGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_graphn_max(s : MathapproxfourierGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_graphn_to_string(s : MathapproxfourierGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_node_make(size : Int) -> MathapproxfourierNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_node_len(s : MathapproxfourierNode) -> Int { s.size }

pub fn math_approx_fourier_node_get(s : MathapproxfourierNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_node_set(s : MathapproxfourierNode, i : Int, v : Double) -> MathapproxfourierNode {
  let result = math_approx_fourier_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_node_sum(s : MathapproxfourierNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_fourier_node_mean(s : MathapproxfourierNode) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_fourier_node_sum(s) / s.size.to_double() }
}

pub fn math_approx_fourier_node_scale(s : MathapproxfourierNode, f : Double) -> MathapproxfourierNode {
  let result = math_approx_fourier_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_fourier_node_add(a : MathapproxfourierNode, b : MathapproxfourierNode) -> MathapproxfourierNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_fourier_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_fourier_node_copy(s : MathapproxfourierNode) -> MathapproxfourierNode {
  let result = math_approx_fourier_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_fourier_node_fill(s : MathapproxfourierNode, v : Double) -> MathapproxfourierNode {
  let result = math_approx_fourier_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_node_min(s : MathapproxfourierNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_node_max(s : MathapproxfourierNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_node_to_string(s : MathapproxfourierNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_edge_make(size : Int) -> MathapproxfourierEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_edge_len(s : MathapproxfourierEdge) -> Int { s.size }

pub fn math_approx_fourier_edge_get(s : MathapproxfourierEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_edge_set(s : MathapproxfourierEdge, i : Int, v : Double) -> MathapproxfourierEdge {
  let result = math_approx_fourier_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_edge_sum(s : MathapproxfourierEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_fourier_edge_mean(s : MathapproxfourierEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_fourier_edge_sum(s) / s.size.to_double() }
}

pub fn math_approx_fourier_edge_scale(s : MathapproxfourierEdge, f : Double) -> MathapproxfourierEdge {
  let result = math_approx_fourier_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_fourier_edge_add(a : MathapproxfourierEdge, b : MathapproxfourierEdge) -> MathapproxfourierEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_fourier_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_fourier_edge_copy(s : MathapproxfourierEdge) -> MathapproxfourierEdge {
  let result = math_approx_fourier_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_fourier_edge_fill(s : MathapproxfourierEdge, v : Double) -> MathapproxfourierEdge {
  let result = math_approx_fourier_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_edge_min(s : MathapproxfourierEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_edge_max(s : MathapproxfourierEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_edge_to_string(s : MathapproxfourierEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_path_make(size : Int) -> MathapproxfourierPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_path_len(s : MathapproxfourierPath) -> Int { s.size }

pub fn math_approx_fourier_path_get(s : MathapproxfourierPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_path_set(s : MathapproxfourierPath, i : Int, v : Double) -> MathapproxfourierPath {
  let result = math_approx_fourier_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_path_sum(s : MathapproxfourierPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_fourier_path_mean(s : MathapproxfourierPath) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_fourier_path_sum(s) / s.size.to_double() }
}

pub fn math_approx_fourier_path_scale(s : MathapproxfourierPath, f : Double) -> MathapproxfourierPath {
  let result = math_approx_fourier_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_fourier_path_add(a : MathapproxfourierPath, b : MathapproxfourierPath) -> MathapproxfourierPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_fourier_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_fourier_path_copy(s : MathapproxfourierPath) -> MathapproxfourierPath {
  let result = math_approx_fourier_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_fourier_path_fill(s : MathapproxfourierPath, v : Double) -> MathapproxfourierPath {
  let result = math_approx_fourier_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_path_min(s : MathapproxfourierPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_path_max(s : MathapproxfourierPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_path_to_string(s : MathapproxfourierPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_cluster_make(size : Int) -> MathapproxfourierCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_cluster_len(s : MathapproxfourierCluster) -> Int { s.size }

pub fn math_approx_fourier_cluster_get(s : MathapproxfourierCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_cluster_set(s : MathapproxfourierCluster, i : Int, v : Double) -> MathapproxfourierCluster {
  let result = math_approx_fourier_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_cluster_sum(s : MathapproxfourierCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_fourier_cluster_mean(s : MathapproxfourierCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_fourier_cluster_sum(s) / s.size.to_double() }
}

pub fn math_approx_fourier_cluster_scale(s : MathapproxfourierCluster, f : Double) -> MathapproxfourierCluster {
  let result = math_approx_fourier_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_fourier_cluster_add(a : MathapproxfourierCluster, b : MathapproxfourierCluster) -> MathapproxfourierCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_fourier_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_fourier_cluster_copy(s : MathapproxfourierCluster) -> MathapproxfourierCluster {
  let result = math_approx_fourier_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_fourier_cluster_fill(s : MathapproxfourierCluster, v : Double) -> MathapproxfourierCluster {
  let result = math_approx_fourier_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_cluster_min(s : MathapproxfourierCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_cluster_max(s : MathapproxfourierCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_cluster_to_string(s : MathapproxfourierCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_model_make(size : Int) -> MathapproxfourierModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_model_len(s : MathapproxfourierModel) -> Int { s.size }

pub fn math_approx_fourier_model_get(s : MathapproxfourierModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_model_set(s : MathapproxfourierModel, i : Int, v : Double) -> MathapproxfourierModel {
  let result = math_approx_fourier_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_model_sum(s : MathapproxfourierModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_fourier_model_mean(s : MathapproxfourierModel) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_fourier_model_sum(s) / s.size.to_double() }
}

pub fn math_approx_fourier_model_scale(s : MathapproxfourierModel, f : Double) -> MathapproxfourierModel {
  let result = math_approx_fourier_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_fourier_model_add(a : MathapproxfourierModel, b : MathapproxfourierModel) -> MathapproxfourierModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_fourier_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_fourier_model_copy(s : MathapproxfourierModel) -> MathapproxfourierModel {
  let result = math_approx_fourier_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_fourier_model_fill(s : MathapproxfourierModel, v : Double) -> MathapproxfourierModel {
  let result = math_approx_fourier_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_model_min(s : MathapproxfourierModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_model_max(s : MathapproxfourierModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_model_to_string(s : MathapproxfourierModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_layer_make(size : Int) -> MathapproxfourierLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_layer_len(s : MathapproxfourierLayer) -> Int { s.size }

pub fn math_approx_fourier_layer_get(s : MathapproxfourierLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_layer_set(s : MathapproxfourierLayer, i : Int, v : Double) -> MathapproxfourierLayer {
  let result = math_approx_fourier_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_layer_sum(s : MathapproxfourierLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_fourier_layer_mean(s : MathapproxfourierLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_fourier_layer_sum(s) / s.size.to_double() }
}

pub fn math_approx_fourier_layer_scale(s : MathapproxfourierLayer, f : Double) -> MathapproxfourierLayer {
  let result = math_approx_fourier_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_fourier_layer_add(a : MathapproxfourierLayer, b : MathapproxfourierLayer) -> MathapproxfourierLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_fourier_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_fourier_layer_copy(s : MathapproxfourierLayer) -> MathapproxfourierLayer {
  let result = math_approx_fourier_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_fourier_layer_fill(s : MathapproxfourierLayer, v : Double) -> MathapproxfourierLayer {
  let result = math_approx_fourier_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_layer_min(s : MathapproxfourierLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_layer_max(s : MathapproxfourierLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_layer_to_string(s : MathapproxfourierLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_buffer_make(size : Int) -> MathapproxfourierBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_buffer_len(s : MathapproxfourierBuffer) -> Int { s.size }

pub fn math_approx_fourier_buffer_get(s : MathapproxfourierBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_buffer_set(s : MathapproxfourierBuffer, i : Int, v : Double) -> MathapproxfourierBuffer {
  let result = math_approx_fourier_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_buffer_sum(s : MathapproxfourierBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_fourier_buffer_mean(s : MathapproxfourierBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_fourier_buffer_sum(s) / s.size.to_double() }
}

pub fn math_approx_fourier_buffer_scale(s : MathapproxfourierBuffer, f : Double) -> MathapproxfourierBuffer {
  let result = math_approx_fourier_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_fourier_buffer_add(a : MathapproxfourierBuffer, b : MathapproxfourierBuffer) -> MathapproxfourierBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_fourier_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_fourier_buffer_copy(s : MathapproxfourierBuffer) -> MathapproxfourierBuffer {
  let result = math_approx_fourier_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_fourier_buffer_fill(s : MathapproxfourierBuffer, v : Double) -> MathapproxfourierBuffer {
  let result = math_approx_fourier_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_buffer_min(s : MathapproxfourierBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_buffer_max(s : MathapproxfourierBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_buffer_to_string(s : MathapproxfourierBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_cursor_make(size : Int) -> MathapproxfourierCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_cursor_len(s : MathapproxfourierCursor) -> Int { s.size }

pub fn math_approx_fourier_cursor_get(s : MathapproxfourierCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_cursor_set(s : MathapproxfourierCursor, i : Int, v : Double) -> MathapproxfourierCursor {
  let result = math_approx_fourier_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_cursor_sum(s : MathapproxfourierCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_fourier_cursor_mean(s : MathapproxfourierCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_fourier_cursor_sum(s) / s.size.to_double() }
}

pub fn math_approx_fourier_cursor_scale(s : MathapproxfourierCursor, f : Double) -> MathapproxfourierCursor {
  let result = math_approx_fourier_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_fourier_cursor_add(a : MathapproxfourierCursor, b : MathapproxfourierCursor) -> MathapproxfourierCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_fourier_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_fourier_cursor_copy(s : MathapproxfourierCursor) -> MathapproxfourierCursor {
  let result = math_approx_fourier_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_fourier_cursor_fill(s : MathapproxfourierCursor, v : Double) -> MathapproxfourierCursor {
  let result = math_approx_fourier_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_cursor_min(s : MathapproxfourierCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_cursor_max(s : MathapproxfourierCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_cursor_to_string(s : MathapproxfourierCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_view_make(size : Int) -> MathapproxfourierView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_view_len(s : MathapproxfourierView) -> Int { s.size }

pub fn math_approx_fourier_view_get(s : MathapproxfourierView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_view_set(s : MathapproxfourierView, i : Int, v : Double) -> MathapproxfourierView {
  let result = math_approx_fourier_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_view_sum(s : MathapproxfourierView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_fourier_view_mean(s : MathapproxfourierView) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_fourier_view_sum(s) / s.size.to_double() }
}

pub fn math_approx_fourier_view_scale(s : MathapproxfourierView, f : Double) -> MathapproxfourierView {
  let result = math_approx_fourier_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_fourier_view_add(a : MathapproxfourierView, b : MathapproxfourierView) -> MathapproxfourierView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_fourier_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_fourier_view_copy(s : MathapproxfourierView) -> MathapproxfourierView {
  let result = math_approx_fourier_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_fourier_view_fill(s : MathapproxfourierView, v : Double) -> MathapproxfourierView {
  let result = math_approx_fourier_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_view_min(s : MathapproxfourierView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_view_max(s : MathapproxfourierView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_view_to_string(s : MathapproxfourierView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_range_make(size : Int) -> MathapproxfourierRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_range_len(s : MathapproxfourierRange) -> Int { s.size }

pub fn math_approx_fourier_range_get(s : MathapproxfourierRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_range_set(s : MathapproxfourierRange, i : Int, v : Double) -> MathapproxfourierRange {
  let result = math_approx_fourier_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_range_sum(s : MathapproxfourierRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_fourier_range_mean(s : MathapproxfourierRange) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_fourier_range_sum(s) / s.size.to_double() }
}

pub fn math_approx_fourier_range_scale(s : MathapproxfourierRange, f : Double) -> MathapproxfourierRange {
  let result = math_approx_fourier_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_fourier_range_add(a : MathapproxfourierRange, b : MathapproxfourierRange) -> MathapproxfourierRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_fourier_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_fourier_range_copy(s : MathapproxfourierRange) -> MathapproxfourierRange {
  let result = math_approx_fourier_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_fourier_range_fill(s : MathapproxfourierRange, v : Double) -> MathapproxfourierRange {
  let result = math_approx_fourier_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_range_min(s : MathapproxfourierRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_range_max(s : MathapproxfourierRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_range_to_string(s : MathapproxfourierRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxfourierSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_fourier_slice_make(size : Int) -> MathapproxfourierSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_fourier_slice_len(s : MathapproxfourierSlice) -> Int { s.size }

pub fn math_approx_fourier_slice_get(s : MathapproxfourierSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_fourier_slice_set(s : MathapproxfourierSlice, i : Int, v : Double) -> MathapproxfourierSlice {
  let result = math_approx_fourier_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_slice_sum(s : MathapproxfourierSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_approx_fourier_slice_mean(s : MathapproxfourierSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_approx_fourier_slice_sum(s) / s.size.to_double() }
}

pub fn math_approx_fourier_slice_scale(s : MathapproxfourierSlice, f : Double) -> MathapproxfourierSlice {
  let result = math_approx_fourier_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_approx_fourier_slice_add(a : MathapproxfourierSlice, b : MathapproxfourierSlice) -> MathapproxfourierSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_approx_fourier_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_approx_fourier_slice_copy(s : MathapproxfourierSlice) -> MathapproxfourierSlice {
  let result = math_approx_fourier_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_approx_fourier_slice_fill(s : MathapproxfourierSlice, v : Double) -> MathapproxfourierSlice {
  let result = math_approx_fourier_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_approx_fourier_slice_min(s : MathapproxfourierSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_slice_max(s : MathapproxfourierSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_approx_fourier_slice_to_string(s : MathapproxfourierSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

