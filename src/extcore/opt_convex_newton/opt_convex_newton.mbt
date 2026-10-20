///===
/// extcore/opt_convex_newton

pub(all) struct OptconvexnewtonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_newton_make_point(x : Double, y : Double) -> OptconvexnewtonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_newton_make_point3(x : Double, y : Double, z : Double) -> OptconvexnewtonPoint {
  { x, y, z, label: 0 }
}

pub fn opt_convex_newton_point_x(pt : OptconvexnewtonPoint) -> Double { pt.x }

pub fn opt_convex_newton_point_y(pt : OptconvexnewtonPoint) -> Double { pt.y }

pub fn opt_convex_newton_point_z(pt : OptconvexnewtonPoint) -> Double { pt.z }

pub fn opt_convex_newton_point_label(pt : OptconvexnewtonPoint) -> Int { pt.label }

pub fn opt_convex_newton_point_dist(a : OptconvexnewtonPoint, b : OptconvexnewtonPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_convex_newton_point_add(a : OptconvexnewtonPoint, b : OptconvexnewtonPoint) -> OptconvexnewtonPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_convex_newton_point_sub(a : OptconvexnewtonPoint, b : OptconvexnewtonPoint) -> OptconvexnewtonPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_convex_newton_point_scale(pt : OptconvexnewtonPoint, s : Double) -> OptconvexnewtonPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_convex_newton_point_dot(a : OptconvexnewtonPoint, b : OptconvexnewtonPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_convex_newton_point_cross(a : OptconvexnewtonPoint, b : OptconvexnewtonPoint) -> OptconvexnewtonPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_convex_newton_point_norm(pt : OptconvexnewtonPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_convex_newton_point_normalize(pt : OptconvexnewtonPoint) -> OptconvexnewtonPoint {
  let n = opt_convex_newton_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_convex_newton_point_scale(pt, 1.0 / n) }
}

pub fn opt_convex_newton_point_negate(pt : OptconvexnewtonPoint) -> OptconvexnewtonPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_convex_newton_point_mid(a : OptconvexnewtonPoint, b : OptconvexnewtonPoint) -> OptconvexnewtonPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_convex_newton_point_lerp(a : OptconvexnewtonPoint, b : OptconvexnewtonPoint, t : Double) -> OptconvexnewtonPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_convex_newton_point_to_string(pt : OptconvexnewtonPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptconvexnewtonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_newton_make_series(vals : Array[Double], name : String) -> OptconvexnewtonSeries {
  { vals, name, meta: 0 }
}

pub fn opt_convex_newton_series_len(s : OptconvexnewtonSeries) -> Int { s.vals.length() }

pub fn opt_convex_newton_series_sum(s : OptconvexnewtonSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_convex_newton_series_mean(s : OptconvexnewtonSeries) -> Double { @_common.mean(s.vals) }

pub fn opt_convex_newton_series_min(s : OptconvexnewtonSeries) -> Double { @_common.min(s.vals) }

pub fn opt_convex_newton_series_max(s : OptconvexnewtonSeries) -> Double { @_common.max(s.vals) }

pub fn opt_convex_newton_series_range(s : OptconvexnewtonSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn opt_convex_newton_series_var(s : OptconvexnewtonSeries) -> Double { @_common.variance(s.vals) }

pub fn opt_convex_newton_series_std(s : OptconvexnewtonSeries) -> Double { @_common.std(s.vals) }

pub fn opt_convex_newton_series_median(s : OptconvexnewtonSeries) -> Double { @_common.median(s.vals) }

pub fn opt_convex_newton_series_scale(s : OptconvexnewtonSeries, f : Double) -> OptconvexnewtonSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_convex_newton_series_add(a : OptconvexnewtonSeries, b : OptconvexnewtonSeries) -> OptconvexnewtonSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_convex_newton_series_sub(a : OptconvexnewtonSeries, b : OptconvexnewtonSeries) -> OptconvexnewtonSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_convex_newton_series_normalize(s : OptconvexnewtonSeries) -> OptconvexnewtonSeries {
  let mn = opt_convex_newton_series_min(s)
  let mx = opt_convex_newton_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_convex_newton_series_cumsum(s : OptconvexnewtonSeries) -> OptconvexnewtonSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_convex_newton_series_to_string(s : OptconvexnewtonSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexnewtonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_newton_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexnewtonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_newton_matrix_identity(n : Int) -> OptconvexnewtonMatrix {
  let m = opt_convex_newton_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_convex_newton_matrix_get(m : OptconvexnewtonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_convex_newton_matrix_transpose(m : OptconvexnewtonMatrix) -> OptconvexnewtonMatrix {
  let result = opt_convex_newton_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_convex_newton_matrix_add(a : OptconvexnewtonMatrix, b : OptconvexnewtonMatrix) -> OptconvexnewtonMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_convex_newton_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_convex_newton_matrix_scale(m : OptconvexnewtonMatrix, s : Double) -> OptconvexnewtonMatrix {
  let result = opt_convex_newton_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_convex_newton_matrix_multiply(a : OptconvexnewtonMatrix, b : OptconvexnewtonMatrix) -> OptconvexnewtonMatrix {
  if a.cols != b.rows { return opt_convex_newton_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_convex_newton_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_convex_newton_matrix_trace(m : OptconvexnewtonMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_convex_newton_matrix_det(m : OptconvexnewtonMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_convex_newton_matrix_norm(m : OptconvexnewtonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_convex_newton_matrix_to_string(m : OptconvexnewtonMatrix) -> String {
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

pub(all) struct OptconvexnewtonVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_newton_make_vector(comps : Array[Double]) -> OptconvexnewtonVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_newton_vector_zero(dim : Int) -> OptconvexnewtonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_convex_newton_vector_add(a : OptconvexnewtonVector, b : OptconvexnewtonVector) -> OptconvexnewtonVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_newton_vector_sub(a : OptconvexnewtonVector, b : OptconvexnewtonVector) -> OptconvexnewtonVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_newton_vector_scale(v : OptconvexnewtonVector, s : Double) -> OptconvexnewtonVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_convex_newton_vector_dot(a : OptconvexnewtonVector, b : OptconvexnewtonVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_convex_newton_vector_norm(v : OptconvexnewtonVector) -> Double { @_common.sqrt(opt_convex_newton_vector_dot(v, v)) }

pub fn opt_convex_newton_vector_normalize(v : OptconvexnewtonVector) -> OptconvexnewtonVector {
  let n = opt_convex_newton_vector_norm(v)
  if n < 0.0000001 { v } else { opt_convex_newton_vector_scale(v, 1.0 / n) }
}

pub fn opt_convex_newton_vector_dist(a : OptconvexnewtonVector, b : OptconvexnewtonVector) -> Double {
  opt_convex_newton_vector_norm(opt_convex_newton_vector_sub(a, b))
}

pub fn opt_convex_newton_vector_to_string(v : OptconvexnewtonVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_newton_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_convex_newton_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_convex_newton_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_convex_newton_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_convex_newton_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_convex_newton_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_convex_newton_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_convex_newton_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_convex_newton_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_convex_newton_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_convex_newton_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_convex_newton_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_convex_newton_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_convex_newton_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_convex_newton_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_convex_newton_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_convex_newton_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_convex_newton_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_convex_newton_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_convex_newton_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_convex_newton_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_convex_newton_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_convex_newton_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_convex_newton_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_convex_newton_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_convex_newton_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_convex_newton_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_convex_newton_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_convex_newton_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptconvexnewtonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_frame_make(size : Int) -> OptconvexnewtonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_frame_len(s : OptconvexnewtonFrame) -> Int { s.size }

pub fn opt_convex_newton_frame_get(s : OptconvexnewtonFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_frame_set(s : OptconvexnewtonFrame, i : Int, v : Double) -> OptconvexnewtonFrame {
  let result = opt_convex_newton_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_frame_sum(s : OptconvexnewtonFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_newton_frame_mean(s : OptconvexnewtonFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_newton_frame_sum(s) / s.size.to_double() }
}

pub fn opt_convex_newton_frame_scale(s : OptconvexnewtonFrame, f : Double) -> OptconvexnewtonFrame {
  let result = opt_convex_newton_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_newton_frame_add(a : OptconvexnewtonFrame, b : OptconvexnewtonFrame) -> OptconvexnewtonFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_newton_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_newton_frame_copy(s : OptconvexnewtonFrame) -> OptconvexnewtonFrame {
  let result = opt_convex_newton_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_newton_frame_fill(s : OptconvexnewtonFrame, v : Double) -> OptconvexnewtonFrame {
  let result = opt_convex_newton_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_frame_min(s : OptconvexnewtonFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_frame_max(s : OptconvexnewtonFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_frame_to_string(s : OptconvexnewtonFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_table_make(size : Int) -> OptconvexnewtonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_table_len(s : OptconvexnewtonTable) -> Int { s.size }

pub fn opt_convex_newton_table_get(s : OptconvexnewtonTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_table_set(s : OptconvexnewtonTable, i : Int, v : Double) -> OptconvexnewtonTable {
  let result = opt_convex_newton_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_table_sum(s : OptconvexnewtonTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_newton_table_mean(s : OptconvexnewtonTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_newton_table_sum(s) / s.size.to_double() }
}

pub fn opt_convex_newton_table_scale(s : OptconvexnewtonTable, f : Double) -> OptconvexnewtonTable {
  let result = opt_convex_newton_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_newton_table_add(a : OptconvexnewtonTable, b : OptconvexnewtonTable) -> OptconvexnewtonTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_newton_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_newton_table_copy(s : OptconvexnewtonTable) -> OptconvexnewtonTable {
  let result = opt_convex_newton_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_newton_table_fill(s : OptconvexnewtonTable, v : Double) -> OptconvexnewtonTable {
  let result = opt_convex_newton_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_table_min(s : OptconvexnewtonTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_table_max(s : OptconvexnewtonTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_table_to_string(s : OptconvexnewtonTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_graphn_make(size : Int) -> OptconvexnewtonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_graphn_len(s : OptconvexnewtonGraphN) -> Int { s.size }

pub fn opt_convex_newton_graphn_get(s : OptconvexnewtonGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_graphn_set(s : OptconvexnewtonGraphN, i : Int, v : Double) -> OptconvexnewtonGraphN {
  let result = opt_convex_newton_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_graphn_sum(s : OptconvexnewtonGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_newton_graphn_mean(s : OptconvexnewtonGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_newton_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_convex_newton_graphn_scale(s : OptconvexnewtonGraphN, f : Double) -> OptconvexnewtonGraphN {
  let result = opt_convex_newton_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_newton_graphn_add(a : OptconvexnewtonGraphN, b : OptconvexnewtonGraphN) -> OptconvexnewtonGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_newton_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_newton_graphn_copy(s : OptconvexnewtonGraphN) -> OptconvexnewtonGraphN {
  let result = opt_convex_newton_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_newton_graphn_fill(s : OptconvexnewtonGraphN, v : Double) -> OptconvexnewtonGraphN {
  let result = opt_convex_newton_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_graphn_min(s : OptconvexnewtonGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_graphn_max(s : OptconvexnewtonGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_graphn_to_string(s : OptconvexnewtonGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_node_make(size : Int) -> OptconvexnewtonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_node_len(s : OptconvexnewtonNode) -> Int { s.size }

pub fn opt_convex_newton_node_get(s : OptconvexnewtonNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_node_set(s : OptconvexnewtonNode, i : Int, v : Double) -> OptconvexnewtonNode {
  let result = opt_convex_newton_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_node_sum(s : OptconvexnewtonNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_newton_node_mean(s : OptconvexnewtonNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_newton_node_sum(s) / s.size.to_double() }
}

pub fn opt_convex_newton_node_scale(s : OptconvexnewtonNode, f : Double) -> OptconvexnewtonNode {
  let result = opt_convex_newton_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_newton_node_add(a : OptconvexnewtonNode, b : OptconvexnewtonNode) -> OptconvexnewtonNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_newton_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_newton_node_copy(s : OptconvexnewtonNode) -> OptconvexnewtonNode {
  let result = opt_convex_newton_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_newton_node_fill(s : OptconvexnewtonNode, v : Double) -> OptconvexnewtonNode {
  let result = opt_convex_newton_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_node_min(s : OptconvexnewtonNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_node_max(s : OptconvexnewtonNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_node_to_string(s : OptconvexnewtonNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_edge_make(size : Int) -> OptconvexnewtonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_edge_len(s : OptconvexnewtonEdge) -> Int { s.size }

pub fn opt_convex_newton_edge_get(s : OptconvexnewtonEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_edge_set(s : OptconvexnewtonEdge, i : Int, v : Double) -> OptconvexnewtonEdge {
  let result = opt_convex_newton_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_edge_sum(s : OptconvexnewtonEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_newton_edge_mean(s : OptconvexnewtonEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_newton_edge_sum(s) / s.size.to_double() }
}

pub fn opt_convex_newton_edge_scale(s : OptconvexnewtonEdge, f : Double) -> OptconvexnewtonEdge {
  let result = opt_convex_newton_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_newton_edge_add(a : OptconvexnewtonEdge, b : OptconvexnewtonEdge) -> OptconvexnewtonEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_newton_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_newton_edge_copy(s : OptconvexnewtonEdge) -> OptconvexnewtonEdge {
  let result = opt_convex_newton_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_newton_edge_fill(s : OptconvexnewtonEdge, v : Double) -> OptconvexnewtonEdge {
  let result = opt_convex_newton_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_edge_min(s : OptconvexnewtonEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_edge_max(s : OptconvexnewtonEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_edge_to_string(s : OptconvexnewtonEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_path_make(size : Int) -> OptconvexnewtonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_path_len(s : OptconvexnewtonPath) -> Int { s.size }

pub fn opt_convex_newton_path_get(s : OptconvexnewtonPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_path_set(s : OptconvexnewtonPath, i : Int, v : Double) -> OptconvexnewtonPath {
  let result = opt_convex_newton_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_path_sum(s : OptconvexnewtonPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_newton_path_mean(s : OptconvexnewtonPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_newton_path_sum(s) / s.size.to_double() }
}

pub fn opt_convex_newton_path_scale(s : OptconvexnewtonPath, f : Double) -> OptconvexnewtonPath {
  let result = opt_convex_newton_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_newton_path_add(a : OptconvexnewtonPath, b : OptconvexnewtonPath) -> OptconvexnewtonPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_newton_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_newton_path_copy(s : OptconvexnewtonPath) -> OptconvexnewtonPath {
  let result = opt_convex_newton_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_newton_path_fill(s : OptconvexnewtonPath, v : Double) -> OptconvexnewtonPath {
  let result = opt_convex_newton_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_path_min(s : OptconvexnewtonPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_path_max(s : OptconvexnewtonPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_path_to_string(s : OptconvexnewtonPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_cluster_make(size : Int) -> OptconvexnewtonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_cluster_len(s : OptconvexnewtonCluster) -> Int { s.size }

pub fn opt_convex_newton_cluster_get(s : OptconvexnewtonCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_cluster_set(s : OptconvexnewtonCluster, i : Int, v : Double) -> OptconvexnewtonCluster {
  let result = opt_convex_newton_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_cluster_sum(s : OptconvexnewtonCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_newton_cluster_mean(s : OptconvexnewtonCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_newton_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_convex_newton_cluster_scale(s : OptconvexnewtonCluster, f : Double) -> OptconvexnewtonCluster {
  let result = opt_convex_newton_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_newton_cluster_add(a : OptconvexnewtonCluster, b : OptconvexnewtonCluster) -> OptconvexnewtonCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_newton_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_newton_cluster_copy(s : OptconvexnewtonCluster) -> OptconvexnewtonCluster {
  let result = opt_convex_newton_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_newton_cluster_fill(s : OptconvexnewtonCluster, v : Double) -> OptconvexnewtonCluster {
  let result = opt_convex_newton_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_cluster_min(s : OptconvexnewtonCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_cluster_max(s : OptconvexnewtonCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_cluster_to_string(s : OptconvexnewtonCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_model_make(size : Int) -> OptconvexnewtonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_model_len(s : OptconvexnewtonModel) -> Int { s.size }

pub fn opt_convex_newton_model_get(s : OptconvexnewtonModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_model_set(s : OptconvexnewtonModel, i : Int, v : Double) -> OptconvexnewtonModel {
  let result = opt_convex_newton_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_model_sum(s : OptconvexnewtonModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_newton_model_mean(s : OptconvexnewtonModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_newton_model_sum(s) / s.size.to_double() }
}

pub fn opt_convex_newton_model_scale(s : OptconvexnewtonModel, f : Double) -> OptconvexnewtonModel {
  let result = opt_convex_newton_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_newton_model_add(a : OptconvexnewtonModel, b : OptconvexnewtonModel) -> OptconvexnewtonModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_newton_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_newton_model_copy(s : OptconvexnewtonModel) -> OptconvexnewtonModel {
  let result = opt_convex_newton_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_newton_model_fill(s : OptconvexnewtonModel, v : Double) -> OptconvexnewtonModel {
  let result = opt_convex_newton_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_model_min(s : OptconvexnewtonModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_model_max(s : OptconvexnewtonModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_model_to_string(s : OptconvexnewtonModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_layer_make(size : Int) -> OptconvexnewtonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_layer_len(s : OptconvexnewtonLayer) -> Int { s.size }

pub fn opt_convex_newton_layer_get(s : OptconvexnewtonLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_layer_set(s : OptconvexnewtonLayer, i : Int, v : Double) -> OptconvexnewtonLayer {
  let result = opt_convex_newton_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_layer_sum(s : OptconvexnewtonLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_newton_layer_mean(s : OptconvexnewtonLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_newton_layer_sum(s) / s.size.to_double() }
}

pub fn opt_convex_newton_layer_scale(s : OptconvexnewtonLayer, f : Double) -> OptconvexnewtonLayer {
  let result = opt_convex_newton_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_newton_layer_add(a : OptconvexnewtonLayer, b : OptconvexnewtonLayer) -> OptconvexnewtonLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_newton_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_newton_layer_copy(s : OptconvexnewtonLayer) -> OptconvexnewtonLayer {
  let result = opt_convex_newton_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_newton_layer_fill(s : OptconvexnewtonLayer, v : Double) -> OptconvexnewtonLayer {
  let result = opt_convex_newton_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_layer_min(s : OptconvexnewtonLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_layer_max(s : OptconvexnewtonLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_layer_to_string(s : OptconvexnewtonLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_buffer_make(size : Int) -> OptconvexnewtonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_buffer_len(s : OptconvexnewtonBuffer) -> Int { s.size }

pub fn opt_convex_newton_buffer_get(s : OptconvexnewtonBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_buffer_set(s : OptconvexnewtonBuffer, i : Int, v : Double) -> OptconvexnewtonBuffer {
  let result = opt_convex_newton_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_buffer_sum(s : OptconvexnewtonBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_newton_buffer_mean(s : OptconvexnewtonBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_newton_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_convex_newton_buffer_scale(s : OptconvexnewtonBuffer, f : Double) -> OptconvexnewtonBuffer {
  let result = opt_convex_newton_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_newton_buffer_add(a : OptconvexnewtonBuffer, b : OptconvexnewtonBuffer) -> OptconvexnewtonBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_newton_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_newton_buffer_copy(s : OptconvexnewtonBuffer) -> OptconvexnewtonBuffer {
  let result = opt_convex_newton_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_newton_buffer_fill(s : OptconvexnewtonBuffer, v : Double) -> OptconvexnewtonBuffer {
  let result = opt_convex_newton_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_buffer_min(s : OptconvexnewtonBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_buffer_max(s : OptconvexnewtonBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_buffer_to_string(s : OptconvexnewtonBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_cursor_make(size : Int) -> OptconvexnewtonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_cursor_len(s : OptconvexnewtonCursor) -> Int { s.size }

pub fn opt_convex_newton_cursor_get(s : OptconvexnewtonCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_cursor_set(s : OptconvexnewtonCursor, i : Int, v : Double) -> OptconvexnewtonCursor {
  let result = opt_convex_newton_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_cursor_sum(s : OptconvexnewtonCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_newton_cursor_mean(s : OptconvexnewtonCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_newton_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_convex_newton_cursor_scale(s : OptconvexnewtonCursor, f : Double) -> OptconvexnewtonCursor {
  let result = opt_convex_newton_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_newton_cursor_add(a : OptconvexnewtonCursor, b : OptconvexnewtonCursor) -> OptconvexnewtonCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_newton_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_newton_cursor_copy(s : OptconvexnewtonCursor) -> OptconvexnewtonCursor {
  let result = opt_convex_newton_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_newton_cursor_fill(s : OptconvexnewtonCursor, v : Double) -> OptconvexnewtonCursor {
  let result = opt_convex_newton_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_cursor_min(s : OptconvexnewtonCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_cursor_max(s : OptconvexnewtonCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_cursor_to_string(s : OptconvexnewtonCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_view_make(size : Int) -> OptconvexnewtonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_view_len(s : OptconvexnewtonView) -> Int { s.size }

pub fn opt_convex_newton_view_get(s : OptconvexnewtonView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_view_set(s : OptconvexnewtonView, i : Int, v : Double) -> OptconvexnewtonView {
  let result = opt_convex_newton_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_view_sum(s : OptconvexnewtonView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_newton_view_mean(s : OptconvexnewtonView) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_newton_view_sum(s) / s.size.to_double() }
}

pub fn opt_convex_newton_view_scale(s : OptconvexnewtonView, f : Double) -> OptconvexnewtonView {
  let result = opt_convex_newton_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_newton_view_add(a : OptconvexnewtonView, b : OptconvexnewtonView) -> OptconvexnewtonView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_newton_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_newton_view_copy(s : OptconvexnewtonView) -> OptconvexnewtonView {
  let result = opt_convex_newton_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_newton_view_fill(s : OptconvexnewtonView, v : Double) -> OptconvexnewtonView {
  let result = opt_convex_newton_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_view_min(s : OptconvexnewtonView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_view_max(s : OptconvexnewtonView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_view_to_string(s : OptconvexnewtonView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_range_make(size : Int) -> OptconvexnewtonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_range_len(s : OptconvexnewtonRange) -> Int { s.size }

pub fn opt_convex_newton_range_get(s : OptconvexnewtonRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_range_set(s : OptconvexnewtonRange, i : Int, v : Double) -> OptconvexnewtonRange {
  let result = opt_convex_newton_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_range_sum(s : OptconvexnewtonRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_newton_range_mean(s : OptconvexnewtonRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_newton_range_sum(s) / s.size.to_double() }
}

pub fn opt_convex_newton_range_scale(s : OptconvexnewtonRange, f : Double) -> OptconvexnewtonRange {
  let result = opt_convex_newton_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_newton_range_add(a : OptconvexnewtonRange, b : OptconvexnewtonRange) -> OptconvexnewtonRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_newton_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_newton_range_copy(s : OptconvexnewtonRange) -> OptconvexnewtonRange {
  let result = opt_convex_newton_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_newton_range_fill(s : OptconvexnewtonRange, v : Double) -> OptconvexnewtonRange {
  let result = opt_convex_newton_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_range_min(s : OptconvexnewtonRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_range_max(s : OptconvexnewtonRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_range_to_string(s : OptconvexnewtonRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexnewtonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_newton_slice_make(size : Int) -> OptconvexnewtonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_newton_slice_len(s : OptconvexnewtonSlice) -> Int { s.size }

pub fn opt_convex_newton_slice_get(s : OptconvexnewtonSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_newton_slice_set(s : OptconvexnewtonSlice, i : Int, v : Double) -> OptconvexnewtonSlice {
  let result = opt_convex_newton_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_slice_sum(s : OptconvexnewtonSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_newton_slice_mean(s : OptconvexnewtonSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_newton_slice_sum(s) / s.size.to_double() }
}

pub fn opt_convex_newton_slice_scale(s : OptconvexnewtonSlice, f : Double) -> OptconvexnewtonSlice {
  let result = opt_convex_newton_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_newton_slice_add(a : OptconvexnewtonSlice, b : OptconvexnewtonSlice) -> OptconvexnewtonSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_newton_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_newton_slice_copy(s : OptconvexnewtonSlice) -> OptconvexnewtonSlice {
  let result = opt_convex_newton_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_newton_slice_fill(s : OptconvexnewtonSlice, v : Double) -> OptconvexnewtonSlice {
  let result = opt_convex_newton_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_newton_slice_min(s : OptconvexnewtonSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_slice_max(s : OptconvexnewtonSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_newton_slice_to_string(s : OptconvexnewtonSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

