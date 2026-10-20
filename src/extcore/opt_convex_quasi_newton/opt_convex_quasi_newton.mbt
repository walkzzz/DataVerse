///===
/// extcore/opt_convex_quasi_newton

pub(all) struct OptconvexquasinewtonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_quasi_newton_make_point(x : Double, y : Double) -> OptconvexquasinewtonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_quasi_newton_make_point3(x : Double, y : Double, z : Double) -> OptconvexquasinewtonPoint {
  { x, y, z, label: 0 }
}

pub fn opt_convex_quasi_newton_point_x(pt : OptconvexquasinewtonPoint) -> Double { pt.x }

pub fn opt_convex_quasi_newton_point_y(pt : OptconvexquasinewtonPoint) -> Double { pt.y }

pub fn opt_convex_quasi_newton_point_z(pt : OptconvexquasinewtonPoint) -> Double { pt.z }

pub fn opt_convex_quasi_newton_point_label(pt : OptconvexquasinewtonPoint) -> Int { pt.label }

pub fn opt_convex_quasi_newton_point_dist(a : OptconvexquasinewtonPoint, b : OptconvexquasinewtonPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_convex_quasi_newton_point_add(a : OptconvexquasinewtonPoint, b : OptconvexquasinewtonPoint) -> OptconvexquasinewtonPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_convex_quasi_newton_point_sub(a : OptconvexquasinewtonPoint, b : OptconvexquasinewtonPoint) -> OptconvexquasinewtonPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_convex_quasi_newton_point_scale(pt : OptconvexquasinewtonPoint, s : Double) -> OptconvexquasinewtonPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_convex_quasi_newton_point_dot(a : OptconvexquasinewtonPoint, b : OptconvexquasinewtonPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_convex_quasi_newton_point_cross(a : OptconvexquasinewtonPoint, b : OptconvexquasinewtonPoint) -> OptconvexquasinewtonPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_convex_quasi_newton_point_norm(pt : OptconvexquasinewtonPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_convex_quasi_newton_point_normalize(pt : OptconvexquasinewtonPoint) -> OptconvexquasinewtonPoint {
  let n = opt_convex_quasi_newton_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_convex_quasi_newton_point_scale(pt, 1.0 / n) }
}

pub fn opt_convex_quasi_newton_point_negate(pt : OptconvexquasinewtonPoint) -> OptconvexquasinewtonPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_convex_quasi_newton_point_mid(a : OptconvexquasinewtonPoint, b : OptconvexquasinewtonPoint) -> OptconvexquasinewtonPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_convex_quasi_newton_point_lerp(a : OptconvexquasinewtonPoint, b : OptconvexquasinewtonPoint, t : Double) -> OptconvexquasinewtonPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_convex_quasi_newton_point_to_string(pt : OptconvexquasinewtonPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_quasi_newton_make_series(vals : Array[Double], name : String) -> OptconvexquasinewtonSeries {
  { vals, name, meta: 0 }
}

pub fn opt_convex_quasi_newton_series_len(s : OptconvexquasinewtonSeries) -> Int { s.vals.length() }

pub fn opt_convex_quasi_newton_series_sum(s : OptconvexquasinewtonSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_convex_quasi_newton_series_mean(s : OptconvexquasinewtonSeries) -> Double { @_common.mean(s.vals) }

pub fn opt_convex_quasi_newton_series_min(s : OptconvexquasinewtonSeries) -> Double { @_common.min(s.vals) }

pub fn opt_convex_quasi_newton_series_max(s : OptconvexquasinewtonSeries) -> Double { @_common.max(s.vals) }

pub fn opt_convex_quasi_newton_series_range(s : OptconvexquasinewtonSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn opt_convex_quasi_newton_series_var(s : OptconvexquasinewtonSeries) -> Double { @_common.variance(s.vals) }

pub fn opt_convex_quasi_newton_series_std(s : OptconvexquasinewtonSeries) -> Double { @_common.std(s.vals) }

pub fn opt_convex_quasi_newton_series_median(s : OptconvexquasinewtonSeries) -> Double { @_common.median(s.vals) }

pub fn opt_convex_quasi_newton_series_scale(s : OptconvexquasinewtonSeries, f : Double) -> OptconvexquasinewtonSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_convex_quasi_newton_series_add(a : OptconvexquasinewtonSeries, b : OptconvexquasinewtonSeries) -> OptconvexquasinewtonSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_convex_quasi_newton_series_sub(a : OptconvexquasinewtonSeries, b : OptconvexquasinewtonSeries) -> OptconvexquasinewtonSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_convex_quasi_newton_series_normalize(s : OptconvexquasinewtonSeries) -> OptconvexquasinewtonSeries {
  let mn = opt_convex_quasi_newton_series_min(s)
  let mx = opt_convex_quasi_newton_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_convex_quasi_newton_series_cumsum(s : OptconvexquasinewtonSeries) -> OptconvexquasinewtonSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_convex_quasi_newton_series_to_string(s : OptconvexquasinewtonSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexquasinewtonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_quasi_newton_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexquasinewtonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_quasi_newton_matrix_identity(n : Int) -> OptconvexquasinewtonMatrix {
  let m = opt_convex_quasi_newton_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_convex_quasi_newton_matrix_get(m : OptconvexquasinewtonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_convex_quasi_newton_matrix_transpose(m : OptconvexquasinewtonMatrix) -> OptconvexquasinewtonMatrix {
  let result = opt_convex_quasi_newton_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_convex_quasi_newton_matrix_add(a : OptconvexquasinewtonMatrix, b : OptconvexquasinewtonMatrix) -> OptconvexquasinewtonMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_convex_quasi_newton_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_convex_quasi_newton_matrix_scale(m : OptconvexquasinewtonMatrix, s : Double) -> OptconvexquasinewtonMatrix {
  let result = opt_convex_quasi_newton_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_convex_quasi_newton_matrix_multiply(a : OptconvexquasinewtonMatrix, b : OptconvexquasinewtonMatrix) -> OptconvexquasinewtonMatrix {
  if a.cols != b.rows { return opt_convex_quasi_newton_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_convex_quasi_newton_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_convex_quasi_newton_matrix_trace(m : OptconvexquasinewtonMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_convex_quasi_newton_matrix_det(m : OptconvexquasinewtonMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_convex_quasi_newton_matrix_norm(m : OptconvexquasinewtonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_convex_quasi_newton_matrix_to_string(m : OptconvexquasinewtonMatrix) -> String {
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

pub(all) struct OptconvexquasinewtonVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_quasi_newton_make_vector(comps : Array[Double]) -> OptconvexquasinewtonVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_quasi_newton_vector_zero(dim : Int) -> OptconvexquasinewtonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_convex_quasi_newton_vector_add(a : OptconvexquasinewtonVector, b : OptconvexquasinewtonVector) -> OptconvexquasinewtonVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_quasi_newton_vector_sub(a : OptconvexquasinewtonVector, b : OptconvexquasinewtonVector) -> OptconvexquasinewtonVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_quasi_newton_vector_scale(v : OptconvexquasinewtonVector, s : Double) -> OptconvexquasinewtonVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_convex_quasi_newton_vector_dot(a : OptconvexquasinewtonVector, b : OptconvexquasinewtonVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_convex_quasi_newton_vector_norm(v : OptconvexquasinewtonVector) -> Double { @_common.sqrt(opt_convex_quasi_newton_vector_dot(v, v)) }

pub fn opt_convex_quasi_newton_vector_normalize(v : OptconvexquasinewtonVector) -> OptconvexquasinewtonVector {
  let n = opt_convex_quasi_newton_vector_norm(v)
  if n < 0.0000001 { v } else { opt_convex_quasi_newton_vector_scale(v, 1.0 / n) }
}

pub fn opt_convex_quasi_newton_vector_dist(a : OptconvexquasinewtonVector, b : OptconvexquasinewtonVector) -> Double {
  opt_convex_quasi_newton_vector_norm(opt_convex_quasi_newton_vector_sub(a, b))
}

pub fn opt_convex_quasi_newton_vector_to_string(v : OptconvexquasinewtonVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_quasi_newton_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_convex_quasi_newton_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_convex_quasi_newton_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_convex_quasi_newton_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_convex_quasi_newton_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_convex_quasi_newton_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_convex_quasi_newton_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_convex_quasi_newton_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_convex_quasi_newton_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_convex_quasi_newton_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_convex_quasi_newton_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_convex_quasi_newton_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_convex_quasi_newton_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_convex_quasi_newton_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_convex_quasi_newton_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_convex_quasi_newton_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_convex_quasi_newton_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_convex_quasi_newton_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_convex_quasi_newton_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_convex_quasi_newton_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_convex_quasi_newton_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_convex_quasi_newton_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_convex_quasi_newton_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_convex_quasi_newton_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_convex_quasi_newton_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_convex_quasi_newton_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_convex_quasi_newton_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_convex_quasi_newton_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_convex_quasi_newton_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptconvexquasinewtonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_frame_make(size : Int) -> OptconvexquasinewtonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_frame_len(s : OptconvexquasinewtonFrame) -> Int { s.size }

pub fn opt_convex_quasi_newton_frame_get(s : OptconvexquasinewtonFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_frame_set(s : OptconvexquasinewtonFrame, i : Int, v : Double) -> OptconvexquasinewtonFrame {
  let result = opt_convex_quasi_newton_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_frame_sum(s : OptconvexquasinewtonFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_quasi_newton_frame_mean(s : OptconvexquasinewtonFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_quasi_newton_frame_sum(s) / s.size.to_double() }
}

pub fn opt_convex_quasi_newton_frame_scale(s : OptconvexquasinewtonFrame, f : Double) -> OptconvexquasinewtonFrame {
  let result = opt_convex_quasi_newton_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_quasi_newton_frame_add(a : OptconvexquasinewtonFrame, b : OptconvexquasinewtonFrame) -> OptconvexquasinewtonFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_quasi_newton_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_quasi_newton_frame_copy(s : OptconvexquasinewtonFrame) -> OptconvexquasinewtonFrame {
  let result = opt_convex_quasi_newton_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_quasi_newton_frame_fill(s : OptconvexquasinewtonFrame, v : Double) -> OptconvexquasinewtonFrame {
  let result = opt_convex_quasi_newton_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_frame_min(s : OptconvexquasinewtonFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_frame_max(s : OptconvexquasinewtonFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_frame_to_string(s : OptconvexquasinewtonFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_table_make(size : Int) -> OptconvexquasinewtonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_table_len(s : OptconvexquasinewtonTable) -> Int { s.size }

pub fn opt_convex_quasi_newton_table_get(s : OptconvexquasinewtonTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_table_set(s : OptconvexquasinewtonTable, i : Int, v : Double) -> OptconvexquasinewtonTable {
  let result = opt_convex_quasi_newton_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_table_sum(s : OptconvexquasinewtonTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_quasi_newton_table_mean(s : OptconvexquasinewtonTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_quasi_newton_table_sum(s) / s.size.to_double() }
}

pub fn opt_convex_quasi_newton_table_scale(s : OptconvexquasinewtonTable, f : Double) -> OptconvexquasinewtonTable {
  let result = opt_convex_quasi_newton_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_quasi_newton_table_add(a : OptconvexquasinewtonTable, b : OptconvexquasinewtonTable) -> OptconvexquasinewtonTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_quasi_newton_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_quasi_newton_table_copy(s : OptconvexquasinewtonTable) -> OptconvexquasinewtonTable {
  let result = opt_convex_quasi_newton_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_quasi_newton_table_fill(s : OptconvexquasinewtonTable, v : Double) -> OptconvexquasinewtonTable {
  let result = opt_convex_quasi_newton_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_table_min(s : OptconvexquasinewtonTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_table_max(s : OptconvexquasinewtonTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_table_to_string(s : OptconvexquasinewtonTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_graphn_make(size : Int) -> OptconvexquasinewtonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_graphn_len(s : OptconvexquasinewtonGraphN) -> Int { s.size }

pub fn opt_convex_quasi_newton_graphn_get(s : OptconvexquasinewtonGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_graphn_set(s : OptconvexquasinewtonGraphN, i : Int, v : Double) -> OptconvexquasinewtonGraphN {
  let result = opt_convex_quasi_newton_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_graphn_sum(s : OptconvexquasinewtonGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_quasi_newton_graphn_mean(s : OptconvexquasinewtonGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_quasi_newton_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_convex_quasi_newton_graphn_scale(s : OptconvexquasinewtonGraphN, f : Double) -> OptconvexquasinewtonGraphN {
  let result = opt_convex_quasi_newton_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_quasi_newton_graphn_add(a : OptconvexquasinewtonGraphN, b : OptconvexquasinewtonGraphN) -> OptconvexquasinewtonGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_quasi_newton_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_quasi_newton_graphn_copy(s : OptconvexquasinewtonGraphN) -> OptconvexquasinewtonGraphN {
  let result = opt_convex_quasi_newton_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_quasi_newton_graphn_fill(s : OptconvexquasinewtonGraphN, v : Double) -> OptconvexquasinewtonGraphN {
  let result = opt_convex_quasi_newton_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_graphn_min(s : OptconvexquasinewtonGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_graphn_max(s : OptconvexquasinewtonGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_graphn_to_string(s : OptconvexquasinewtonGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_node_make(size : Int) -> OptconvexquasinewtonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_node_len(s : OptconvexquasinewtonNode) -> Int { s.size }

pub fn opt_convex_quasi_newton_node_get(s : OptconvexquasinewtonNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_node_set(s : OptconvexquasinewtonNode, i : Int, v : Double) -> OptconvexquasinewtonNode {
  let result = opt_convex_quasi_newton_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_node_sum(s : OptconvexquasinewtonNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_quasi_newton_node_mean(s : OptconvexquasinewtonNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_quasi_newton_node_sum(s) / s.size.to_double() }
}

pub fn opt_convex_quasi_newton_node_scale(s : OptconvexquasinewtonNode, f : Double) -> OptconvexquasinewtonNode {
  let result = opt_convex_quasi_newton_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_quasi_newton_node_add(a : OptconvexquasinewtonNode, b : OptconvexquasinewtonNode) -> OptconvexquasinewtonNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_quasi_newton_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_quasi_newton_node_copy(s : OptconvexquasinewtonNode) -> OptconvexquasinewtonNode {
  let result = opt_convex_quasi_newton_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_quasi_newton_node_fill(s : OptconvexquasinewtonNode, v : Double) -> OptconvexquasinewtonNode {
  let result = opt_convex_quasi_newton_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_node_min(s : OptconvexquasinewtonNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_node_max(s : OptconvexquasinewtonNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_node_to_string(s : OptconvexquasinewtonNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_edge_make(size : Int) -> OptconvexquasinewtonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_edge_len(s : OptconvexquasinewtonEdge) -> Int { s.size }

pub fn opt_convex_quasi_newton_edge_get(s : OptconvexquasinewtonEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_edge_set(s : OptconvexquasinewtonEdge, i : Int, v : Double) -> OptconvexquasinewtonEdge {
  let result = opt_convex_quasi_newton_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_edge_sum(s : OptconvexquasinewtonEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_quasi_newton_edge_mean(s : OptconvexquasinewtonEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_quasi_newton_edge_sum(s) / s.size.to_double() }
}

pub fn opt_convex_quasi_newton_edge_scale(s : OptconvexquasinewtonEdge, f : Double) -> OptconvexquasinewtonEdge {
  let result = opt_convex_quasi_newton_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_quasi_newton_edge_add(a : OptconvexquasinewtonEdge, b : OptconvexquasinewtonEdge) -> OptconvexquasinewtonEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_quasi_newton_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_quasi_newton_edge_copy(s : OptconvexquasinewtonEdge) -> OptconvexquasinewtonEdge {
  let result = opt_convex_quasi_newton_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_quasi_newton_edge_fill(s : OptconvexquasinewtonEdge, v : Double) -> OptconvexquasinewtonEdge {
  let result = opt_convex_quasi_newton_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_edge_min(s : OptconvexquasinewtonEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_edge_max(s : OptconvexquasinewtonEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_edge_to_string(s : OptconvexquasinewtonEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_path_make(size : Int) -> OptconvexquasinewtonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_path_len(s : OptconvexquasinewtonPath) -> Int { s.size }

pub fn opt_convex_quasi_newton_path_get(s : OptconvexquasinewtonPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_path_set(s : OptconvexquasinewtonPath, i : Int, v : Double) -> OptconvexquasinewtonPath {
  let result = opt_convex_quasi_newton_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_path_sum(s : OptconvexquasinewtonPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_quasi_newton_path_mean(s : OptconvexquasinewtonPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_quasi_newton_path_sum(s) / s.size.to_double() }
}

pub fn opt_convex_quasi_newton_path_scale(s : OptconvexquasinewtonPath, f : Double) -> OptconvexquasinewtonPath {
  let result = opt_convex_quasi_newton_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_quasi_newton_path_add(a : OptconvexquasinewtonPath, b : OptconvexquasinewtonPath) -> OptconvexquasinewtonPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_quasi_newton_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_quasi_newton_path_copy(s : OptconvexquasinewtonPath) -> OptconvexquasinewtonPath {
  let result = opt_convex_quasi_newton_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_quasi_newton_path_fill(s : OptconvexquasinewtonPath, v : Double) -> OptconvexquasinewtonPath {
  let result = opt_convex_quasi_newton_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_path_min(s : OptconvexquasinewtonPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_path_max(s : OptconvexquasinewtonPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_path_to_string(s : OptconvexquasinewtonPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_cluster_make(size : Int) -> OptconvexquasinewtonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_cluster_len(s : OptconvexquasinewtonCluster) -> Int { s.size }

pub fn opt_convex_quasi_newton_cluster_get(s : OptconvexquasinewtonCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_cluster_set(s : OptconvexquasinewtonCluster, i : Int, v : Double) -> OptconvexquasinewtonCluster {
  let result = opt_convex_quasi_newton_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_cluster_sum(s : OptconvexquasinewtonCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_quasi_newton_cluster_mean(s : OptconvexquasinewtonCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_quasi_newton_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_convex_quasi_newton_cluster_scale(s : OptconvexquasinewtonCluster, f : Double) -> OptconvexquasinewtonCluster {
  let result = opt_convex_quasi_newton_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_quasi_newton_cluster_add(a : OptconvexquasinewtonCluster, b : OptconvexquasinewtonCluster) -> OptconvexquasinewtonCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_quasi_newton_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_quasi_newton_cluster_copy(s : OptconvexquasinewtonCluster) -> OptconvexquasinewtonCluster {
  let result = opt_convex_quasi_newton_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_quasi_newton_cluster_fill(s : OptconvexquasinewtonCluster, v : Double) -> OptconvexquasinewtonCluster {
  let result = opt_convex_quasi_newton_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_cluster_min(s : OptconvexquasinewtonCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_cluster_max(s : OptconvexquasinewtonCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_cluster_to_string(s : OptconvexquasinewtonCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_model_make(size : Int) -> OptconvexquasinewtonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_model_len(s : OptconvexquasinewtonModel) -> Int { s.size }

pub fn opt_convex_quasi_newton_model_get(s : OptconvexquasinewtonModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_model_set(s : OptconvexquasinewtonModel, i : Int, v : Double) -> OptconvexquasinewtonModel {
  let result = opt_convex_quasi_newton_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_model_sum(s : OptconvexquasinewtonModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_quasi_newton_model_mean(s : OptconvexquasinewtonModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_quasi_newton_model_sum(s) / s.size.to_double() }
}

pub fn opt_convex_quasi_newton_model_scale(s : OptconvexquasinewtonModel, f : Double) -> OptconvexquasinewtonModel {
  let result = opt_convex_quasi_newton_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_quasi_newton_model_add(a : OptconvexquasinewtonModel, b : OptconvexquasinewtonModel) -> OptconvexquasinewtonModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_quasi_newton_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_quasi_newton_model_copy(s : OptconvexquasinewtonModel) -> OptconvexquasinewtonModel {
  let result = opt_convex_quasi_newton_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_quasi_newton_model_fill(s : OptconvexquasinewtonModel, v : Double) -> OptconvexquasinewtonModel {
  let result = opt_convex_quasi_newton_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_model_min(s : OptconvexquasinewtonModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_model_max(s : OptconvexquasinewtonModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_model_to_string(s : OptconvexquasinewtonModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_layer_make(size : Int) -> OptconvexquasinewtonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_layer_len(s : OptconvexquasinewtonLayer) -> Int { s.size }

pub fn opt_convex_quasi_newton_layer_get(s : OptconvexquasinewtonLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_layer_set(s : OptconvexquasinewtonLayer, i : Int, v : Double) -> OptconvexquasinewtonLayer {
  let result = opt_convex_quasi_newton_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_layer_sum(s : OptconvexquasinewtonLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_quasi_newton_layer_mean(s : OptconvexquasinewtonLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_quasi_newton_layer_sum(s) / s.size.to_double() }
}

pub fn opt_convex_quasi_newton_layer_scale(s : OptconvexquasinewtonLayer, f : Double) -> OptconvexquasinewtonLayer {
  let result = opt_convex_quasi_newton_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_quasi_newton_layer_add(a : OptconvexquasinewtonLayer, b : OptconvexquasinewtonLayer) -> OptconvexquasinewtonLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_quasi_newton_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_quasi_newton_layer_copy(s : OptconvexquasinewtonLayer) -> OptconvexquasinewtonLayer {
  let result = opt_convex_quasi_newton_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_quasi_newton_layer_fill(s : OptconvexquasinewtonLayer, v : Double) -> OptconvexquasinewtonLayer {
  let result = opt_convex_quasi_newton_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_layer_min(s : OptconvexquasinewtonLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_layer_max(s : OptconvexquasinewtonLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_layer_to_string(s : OptconvexquasinewtonLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_buffer_make(size : Int) -> OptconvexquasinewtonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_buffer_len(s : OptconvexquasinewtonBuffer) -> Int { s.size }

pub fn opt_convex_quasi_newton_buffer_get(s : OptconvexquasinewtonBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_buffer_set(s : OptconvexquasinewtonBuffer, i : Int, v : Double) -> OptconvexquasinewtonBuffer {
  let result = opt_convex_quasi_newton_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_buffer_sum(s : OptconvexquasinewtonBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_quasi_newton_buffer_mean(s : OptconvexquasinewtonBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_quasi_newton_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_convex_quasi_newton_buffer_scale(s : OptconvexquasinewtonBuffer, f : Double) -> OptconvexquasinewtonBuffer {
  let result = opt_convex_quasi_newton_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_quasi_newton_buffer_add(a : OptconvexquasinewtonBuffer, b : OptconvexquasinewtonBuffer) -> OptconvexquasinewtonBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_quasi_newton_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_quasi_newton_buffer_copy(s : OptconvexquasinewtonBuffer) -> OptconvexquasinewtonBuffer {
  let result = opt_convex_quasi_newton_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_quasi_newton_buffer_fill(s : OptconvexquasinewtonBuffer, v : Double) -> OptconvexquasinewtonBuffer {
  let result = opt_convex_quasi_newton_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_buffer_min(s : OptconvexquasinewtonBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_buffer_max(s : OptconvexquasinewtonBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_buffer_to_string(s : OptconvexquasinewtonBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_cursor_make(size : Int) -> OptconvexquasinewtonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_cursor_len(s : OptconvexquasinewtonCursor) -> Int { s.size }

pub fn opt_convex_quasi_newton_cursor_get(s : OptconvexquasinewtonCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_cursor_set(s : OptconvexquasinewtonCursor, i : Int, v : Double) -> OptconvexquasinewtonCursor {
  let result = opt_convex_quasi_newton_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_cursor_sum(s : OptconvexquasinewtonCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_quasi_newton_cursor_mean(s : OptconvexquasinewtonCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_quasi_newton_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_convex_quasi_newton_cursor_scale(s : OptconvexquasinewtonCursor, f : Double) -> OptconvexquasinewtonCursor {
  let result = opt_convex_quasi_newton_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_quasi_newton_cursor_add(a : OptconvexquasinewtonCursor, b : OptconvexquasinewtonCursor) -> OptconvexquasinewtonCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_quasi_newton_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_quasi_newton_cursor_copy(s : OptconvexquasinewtonCursor) -> OptconvexquasinewtonCursor {
  let result = opt_convex_quasi_newton_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_quasi_newton_cursor_fill(s : OptconvexquasinewtonCursor, v : Double) -> OptconvexquasinewtonCursor {
  let result = opt_convex_quasi_newton_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_cursor_min(s : OptconvexquasinewtonCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_cursor_max(s : OptconvexquasinewtonCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_cursor_to_string(s : OptconvexquasinewtonCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_view_make(size : Int) -> OptconvexquasinewtonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_view_len(s : OptconvexquasinewtonView) -> Int { s.size }

pub fn opt_convex_quasi_newton_view_get(s : OptconvexquasinewtonView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_view_set(s : OptconvexquasinewtonView, i : Int, v : Double) -> OptconvexquasinewtonView {
  let result = opt_convex_quasi_newton_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_view_sum(s : OptconvexquasinewtonView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_quasi_newton_view_mean(s : OptconvexquasinewtonView) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_quasi_newton_view_sum(s) / s.size.to_double() }
}

pub fn opt_convex_quasi_newton_view_scale(s : OptconvexquasinewtonView, f : Double) -> OptconvexquasinewtonView {
  let result = opt_convex_quasi_newton_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_quasi_newton_view_add(a : OptconvexquasinewtonView, b : OptconvexquasinewtonView) -> OptconvexquasinewtonView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_quasi_newton_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_quasi_newton_view_copy(s : OptconvexquasinewtonView) -> OptconvexquasinewtonView {
  let result = opt_convex_quasi_newton_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_quasi_newton_view_fill(s : OptconvexquasinewtonView, v : Double) -> OptconvexquasinewtonView {
  let result = opt_convex_quasi_newton_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_view_min(s : OptconvexquasinewtonView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_view_max(s : OptconvexquasinewtonView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_view_to_string(s : OptconvexquasinewtonView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_range_make(size : Int) -> OptconvexquasinewtonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_range_len(s : OptconvexquasinewtonRange) -> Int { s.size }

pub fn opt_convex_quasi_newton_range_get(s : OptconvexquasinewtonRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_range_set(s : OptconvexquasinewtonRange, i : Int, v : Double) -> OptconvexquasinewtonRange {
  let result = opt_convex_quasi_newton_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_range_sum(s : OptconvexquasinewtonRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_quasi_newton_range_mean(s : OptconvexquasinewtonRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_quasi_newton_range_sum(s) / s.size.to_double() }
}

pub fn opt_convex_quasi_newton_range_scale(s : OptconvexquasinewtonRange, f : Double) -> OptconvexquasinewtonRange {
  let result = opt_convex_quasi_newton_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_quasi_newton_range_add(a : OptconvexquasinewtonRange, b : OptconvexquasinewtonRange) -> OptconvexquasinewtonRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_quasi_newton_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_quasi_newton_range_copy(s : OptconvexquasinewtonRange) -> OptconvexquasinewtonRange {
  let result = opt_convex_quasi_newton_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_quasi_newton_range_fill(s : OptconvexquasinewtonRange, v : Double) -> OptconvexquasinewtonRange {
  let result = opt_convex_quasi_newton_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_range_min(s : OptconvexquasinewtonRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_range_max(s : OptconvexquasinewtonRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_range_to_string(s : OptconvexquasinewtonRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexquasinewtonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_quasi_newton_slice_make(size : Int) -> OptconvexquasinewtonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_quasi_newton_slice_len(s : OptconvexquasinewtonSlice) -> Int { s.size }

pub fn opt_convex_quasi_newton_slice_get(s : OptconvexquasinewtonSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_quasi_newton_slice_set(s : OptconvexquasinewtonSlice, i : Int, v : Double) -> OptconvexquasinewtonSlice {
  let result = opt_convex_quasi_newton_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_slice_sum(s : OptconvexquasinewtonSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_quasi_newton_slice_mean(s : OptconvexquasinewtonSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_quasi_newton_slice_sum(s) / s.size.to_double() }
}

pub fn opt_convex_quasi_newton_slice_scale(s : OptconvexquasinewtonSlice, f : Double) -> OptconvexquasinewtonSlice {
  let result = opt_convex_quasi_newton_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_quasi_newton_slice_add(a : OptconvexquasinewtonSlice, b : OptconvexquasinewtonSlice) -> OptconvexquasinewtonSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_quasi_newton_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_quasi_newton_slice_copy(s : OptconvexquasinewtonSlice) -> OptconvexquasinewtonSlice {
  let result = opt_convex_quasi_newton_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_quasi_newton_slice_fill(s : OptconvexquasinewtonSlice, v : Double) -> OptconvexquasinewtonSlice {
  let result = opt_convex_quasi_newton_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_quasi_newton_slice_min(s : OptconvexquasinewtonSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_slice_max(s : OptconvexquasinewtonSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_quasi_newton_slice_to_string(s : OptconvexquasinewtonSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

