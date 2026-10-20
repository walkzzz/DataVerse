///===
/// extcore/opt_convex_conjugate

pub(all) struct OptconvexconjugatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_conjugate_make_point(x : Double, y : Double) -> OptconvexconjugatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_conjugate_make_point3(x : Double, y : Double, z : Double) -> OptconvexconjugatePoint {
  { x, y, z, label: 0 }
}

pub fn opt_convex_conjugate_point_x(pt : OptconvexconjugatePoint) -> Double { pt.x }

pub fn opt_convex_conjugate_point_y(pt : OptconvexconjugatePoint) -> Double { pt.y }

pub fn opt_convex_conjugate_point_z(pt : OptconvexconjugatePoint) -> Double { pt.z }

pub fn opt_convex_conjugate_point_label(pt : OptconvexconjugatePoint) -> Int { pt.label }

pub fn opt_convex_conjugate_point_dist(a : OptconvexconjugatePoint, b : OptconvexconjugatePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_convex_conjugate_point_add(a : OptconvexconjugatePoint, b : OptconvexconjugatePoint) -> OptconvexconjugatePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_convex_conjugate_point_sub(a : OptconvexconjugatePoint, b : OptconvexconjugatePoint) -> OptconvexconjugatePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_convex_conjugate_point_scale(pt : OptconvexconjugatePoint, s : Double) -> OptconvexconjugatePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_convex_conjugate_point_dot(a : OptconvexconjugatePoint, b : OptconvexconjugatePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_convex_conjugate_point_cross(a : OptconvexconjugatePoint, b : OptconvexconjugatePoint) -> OptconvexconjugatePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_convex_conjugate_point_norm(pt : OptconvexconjugatePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_convex_conjugate_point_normalize(pt : OptconvexconjugatePoint) -> OptconvexconjugatePoint {
  let n = opt_convex_conjugate_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_convex_conjugate_point_scale(pt, 1.0 / n) }
}

pub fn opt_convex_conjugate_point_negate(pt : OptconvexconjugatePoint) -> OptconvexconjugatePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_convex_conjugate_point_mid(a : OptconvexconjugatePoint, b : OptconvexconjugatePoint) -> OptconvexconjugatePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_convex_conjugate_point_lerp(a : OptconvexconjugatePoint, b : OptconvexconjugatePoint, t : Double) -> OptconvexconjugatePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_convex_conjugate_point_to_string(pt : OptconvexconjugatePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptconvexconjugateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_conjugate_make_series(vals : Array[Double], name : String) -> OptconvexconjugateSeries {
  { vals, name, meta: 0 }
}

pub fn opt_convex_conjugate_series_len(s : OptconvexconjugateSeries) -> Int { s.vals.length() }

pub fn opt_convex_conjugate_series_sum(s : OptconvexconjugateSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_convex_conjugate_series_mean(s : OptconvexconjugateSeries) -> Double { @_common.mean(s.vals) }

pub fn opt_convex_conjugate_series_min(s : OptconvexconjugateSeries) -> Double { @_common.min(s.vals) }

pub fn opt_convex_conjugate_series_max(s : OptconvexconjugateSeries) -> Double { @_common.max(s.vals) }

pub fn opt_convex_conjugate_series_range(s : OptconvexconjugateSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn opt_convex_conjugate_series_var(s : OptconvexconjugateSeries) -> Double { @_common.variance(s.vals) }

pub fn opt_convex_conjugate_series_std(s : OptconvexconjugateSeries) -> Double { @_common.std(s.vals) }

pub fn opt_convex_conjugate_series_median(s : OptconvexconjugateSeries) -> Double { @_common.median(s.vals) }

pub fn opt_convex_conjugate_series_scale(s : OptconvexconjugateSeries, f : Double) -> OptconvexconjugateSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_convex_conjugate_series_add(a : OptconvexconjugateSeries, b : OptconvexconjugateSeries) -> OptconvexconjugateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_convex_conjugate_series_sub(a : OptconvexconjugateSeries, b : OptconvexconjugateSeries) -> OptconvexconjugateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_convex_conjugate_series_normalize(s : OptconvexconjugateSeries) -> OptconvexconjugateSeries {
  let mn = opt_convex_conjugate_series_min(s)
  let mx = opt_convex_conjugate_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_convex_conjugate_series_cumsum(s : OptconvexconjugateSeries) -> OptconvexconjugateSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_convex_conjugate_series_to_string(s : OptconvexconjugateSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexconjugateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_conjugate_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexconjugateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_conjugate_matrix_identity(n : Int) -> OptconvexconjugateMatrix {
  let m = opt_convex_conjugate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_convex_conjugate_matrix_get(m : OptconvexconjugateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_convex_conjugate_matrix_transpose(m : OptconvexconjugateMatrix) -> OptconvexconjugateMatrix {
  let result = opt_convex_conjugate_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_convex_conjugate_matrix_add(a : OptconvexconjugateMatrix, b : OptconvexconjugateMatrix) -> OptconvexconjugateMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_convex_conjugate_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_convex_conjugate_matrix_scale(m : OptconvexconjugateMatrix, s : Double) -> OptconvexconjugateMatrix {
  let result = opt_convex_conjugate_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_convex_conjugate_matrix_multiply(a : OptconvexconjugateMatrix, b : OptconvexconjugateMatrix) -> OptconvexconjugateMatrix {
  if a.cols != b.rows { return opt_convex_conjugate_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_convex_conjugate_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_convex_conjugate_matrix_trace(m : OptconvexconjugateMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_convex_conjugate_matrix_det(m : OptconvexconjugateMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_convex_conjugate_matrix_norm(m : OptconvexconjugateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_convex_conjugate_matrix_to_string(m : OptconvexconjugateMatrix) -> String {
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

pub(all) struct OptconvexconjugateVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_conjugate_make_vector(comps : Array[Double]) -> OptconvexconjugateVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_conjugate_vector_zero(dim : Int) -> OptconvexconjugateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_convex_conjugate_vector_add(a : OptconvexconjugateVector, b : OptconvexconjugateVector) -> OptconvexconjugateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_conjugate_vector_sub(a : OptconvexconjugateVector, b : OptconvexconjugateVector) -> OptconvexconjugateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_conjugate_vector_scale(v : OptconvexconjugateVector, s : Double) -> OptconvexconjugateVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_convex_conjugate_vector_dot(a : OptconvexconjugateVector, b : OptconvexconjugateVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_convex_conjugate_vector_norm(v : OptconvexconjugateVector) -> Double { @_common.sqrt(opt_convex_conjugate_vector_dot(v, v)) }

pub fn opt_convex_conjugate_vector_normalize(v : OptconvexconjugateVector) -> OptconvexconjugateVector {
  let n = opt_convex_conjugate_vector_norm(v)
  if n < 0.0000001 { v } else { opt_convex_conjugate_vector_scale(v, 1.0 / n) }
}

pub fn opt_convex_conjugate_vector_dist(a : OptconvexconjugateVector, b : OptconvexconjugateVector) -> Double {
  opt_convex_conjugate_vector_norm(opt_convex_conjugate_vector_sub(a, b))
}

pub fn opt_convex_conjugate_vector_to_string(v : OptconvexconjugateVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_conjugate_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_convex_conjugate_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_convex_conjugate_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_convex_conjugate_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_convex_conjugate_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_convex_conjugate_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_convex_conjugate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_convex_conjugate_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_convex_conjugate_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_convex_conjugate_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_convex_conjugate_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_convex_conjugate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_convex_conjugate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_convex_conjugate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_convex_conjugate_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_convex_conjugate_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_convex_conjugate_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_convex_conjugate_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_convex_conjugate_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_convex_conjugate_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_convex_conjugate_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_convex_conjugate_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_convex_conjugate_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_convex_conjugate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_convex_conjugate_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_convex_conjugate_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_convex_conjugate_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_convex_conjugate_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_convex_conjugate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptconvexconjugateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_frame_make(size : Int) -> OptconvexconjugateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_frame_len(s : OptconvexconjugateFrame) -> Int { s.size }

pub fn opt_convex_conjugate_frame_get(s : OptconvexconjugateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_frame_set(s : OptconvexconjugateFrame, i : Int, v : Double) -> OptconvexconjugateFrame {
  let result = opt_convex_conjugate_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_frame_sum(s : OptconvexconjugateFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_conjugate_frame_mean(s : OptconvexconjugateFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_conjugate_frame_sum(s) / s.size.to_double() }
}

pub fn opt_convex_conjugate_frame_scale(s : OptconvexconjugateFrame, f : Double) -> OptconvexconjugateFrame {
  let result = opt_convex_conjugate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_conjugate_frame_add(a : OptconvexconjugateFrame, b : OptconvexconjugateFrame) -> OptconvexconjugateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_conjugate_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_conjugate_frame_copy(s : OptconvexconjugateFrame) -> OptconvexconjugateFrame {
  let result = opt_convex_conjugate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_conjugate_frame_fill(s : OptconvexconjugateFrame, v : Double) -> OptconvexconjugateFrame {
  let result = opt_convex_conjugate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_frame_min(s : OptconvexconjugateFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_frame_max(s : OptconvexconjugateFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_frame_to_string(s : OptconvexconjugateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_table_make(size : Int) -> OptconvexconjugateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_table_len(s : OptconvexconjugateTable) -> Int { s.size }

pub fn opt_convex_conjugate_table_get(s : OptconvexconjugateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_table_set(s : OptconvexconjugateTable, i : Int, v : Double) -> OptconvexconjugateTable {
  let result = opt_convex_conjugate_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_table_sum(s : OptconvexconjugateTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_conjugate_table_mean(s : OptconvexconjugateTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_conjugate_table_sum(s) / s.size.to_double() }
}

pub fn opt_convex_conjugate_table_scale(s : OptconvexconjugateTable, f : Double) -> OptconvexconjugateTable {
  let result = opt_convex_conjugate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_conjugate_table_add(a : OptconvexconjugateTable, b : OptconvexconjugateTable) -> OptconvexconjugateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_conjugate_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_conjugate_table_copy(s : OptconvexconjugateTable) -> OptconvexconjugateTable {
  let result = opt_convex_conjugate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_conjugate_table_fill(s : OptconvexconjugateTable, v : Double) -> OptconvexconjugateTable {
  let result = opt_convex_conjugate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_table_min(s : OptconvexconjugateTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_table_max(s : OptconvexconjugateTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_table_to_string(s : OptconvexconjugateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_graphn_make(size : Int) -> OptconvexconjugateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_graphn_len(s : OptconvexconjugateGraphN) -> Int { s.size }

pub fn opt_convex_conjugate_graphn_get(s : OptconvexconjugateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_graphn_set(s : OptconvexconjugateGraphN, i : Int, v : Double) -> OptconvexconjugateGraphN {
  let result = opt_convex_conjugate_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_graphn_sum(s : OptconvexconjugateGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_conjugate_graphn_mean(s : OptconvexconjugateGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_conjugate_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_convex_conjugate_graphn_scale(s : OptconvexconjugateGraphN, f : Double) -> OptconvexconjugateGraphN {
  let result = opt_convex_conjugate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_conjugate_graphn_add(a : OptconvexconjugateGraphN, b : OptconvexconjugateGraphN) -> OptconvexconjugateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_conjugate_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_conjugate_graphn_copy(s : OptconvexconjugateGraphN) -> OptconvexconjugateGraphN {
  let result = opt_convex_conjugate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_conjugate_graphn_fill(s : OptconvexconjugateGraphN, v : Double) -> OptconvexconjugateGraphN {
  let result = opt_convex_conjugate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_graphn_min(s : OptconvexconjugateGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_graphn_max(s : OptconvexconjugateGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_graphn_to_string(s : OptconvexconjugateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_node_make(size : Int) -> OptconvexconjugateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_node_len(s : OptconvexconjugateNode) -> Int { s.size }

pub fn opt_convex_conjugate_node_get(s : OptconvexconjugateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_node_set(s : OptconvexconjugateNode, i : Int, v : Double) -> OptconvexconjugateNode {
  let result = opt_convex_conjugate_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_node_sum(s : OptconvexconjugateNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_conjugate_node_mean(s : OptconvexconjugateNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_conjugate_node_sum(s) / s.size.to_double() }
}

pub fn opt_convex_conjugate_node_scale(s : OptconvexconjugateNode, f : Double) -> OptconvexconjugateNode {
  let result = opt_convex_conjugate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_conjugate_node_add(a : OptconvexconjugateNode, b : OptconvexconjugateNode) -> OptconvexconjugateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_conjugate_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_conjugate_node_copy(s : OptconvexconjugateNode) -> OptconvexconjugateNode {
  let result = opt_convex_conjugate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_conjugate_node_fill(s : OptconvexconjugateNode, v : Double) -> OptconvexconjugateNode {
  let result = opt_convex_conjugate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_node_min(s : OptconvexconjugateNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_node_max(s : OptconvexconjugateNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_node_to_string(s : OptconvexconjugateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_edge_make(size : Int) -> OptconvexconjugateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_edge_len(s : OptconvexconjugateEdge) -> Int { s.size }

pub fn opt_convex_conjugate_edge_get(s : OptconvexconjugateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_edge_set(s : OptconvexconjugateEdge, i : Int, v : Double) -> OptconvexconjugateEdge {
  let result = opt_convex_conjugate_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_edge_sum(s : OptconvexconjugateEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_conjugate_edge_mean(s : OptconvexconjugateEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_conjugate_edge_sum(s) / s.size.to_double() }
}

pub fn opt_convex_conjugate_edge_scale(s : OptconvexconjugateEdge, f : Double) -> OptconvexconjugateEdge {
  let result = opt_convex_conjugate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_conjugate_edge_add(a : OptconvexconjugateEdge, b : OptconvexconjugateEdge) -> OptconvexconjugateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_conjugate_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_conjugate_edge_copy(s : OptconvexconjugateEdge) -> OptconvexconjugateEdge {
  let result = opt_convex_conjugate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_conjugate_edge_fill(s : OptconvexconjugateEdge, v : Double) -> OptconvexconjugateEdge {
  let result = opt_convex_conjugate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_edge_min(s : OptconvexconjugateEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_edge_max(s : OptconvexconjugateEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_edge_to_string(s : OptconvexconjugateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_path_make(size : Int) -> OptconvexconjugatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_path_len(s : OptconvexconjugatePath) -> Int { s.size }

pub fn opt_convex_conjugate_path_get(s : OptconvexconjugatePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_path_set(s : OptconvexconjugatePath, i : Int, v : Double) -> OptconvexconjugatePath {
  let result = opt_convex_conjugate_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_path_sum(s : OptconvexconjugatePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_conjugate_path_mean(s : OptconvexconjugatePath) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_conjugate_path_sum(s) / s.size.to_double() }
}

pub fn opt_convex_conjugate_path_scale(s : OptconvexconjugatePath, f : Double) -> OptconvexconjugatePath {
  let result = opt_convex_conjugate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_conjugate_path_add(a : OptconvexconjugatePath, b : OptconvexconjugatePath) -> OptconvexconjugatePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_conjugate_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_conjugate_path_copy(s : OptconvexconjugatePath) -> OptconvexconjugatePath {
  let result = opt_convex_conjugate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_conjugate_path_fill(s : OptconvexconjugatePath, v : Double) -> OptconvexconjugatePath {
  let result = opt_convex_conjugate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_path_min(s : OptconvexconjugatePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_path_max(s : OptconvexconjugatePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_path_to_string(s : OptconvexconjugatePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_cluster_make(size : Int) -> OptconvexconjugateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_cluster_len(s : OptconvexconjugateCluster) -> Int { s.size }

pub fn opt_convex_conjugate_cluster_get(s : OptconvexconjugateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_cluster_set(s : OptconvexconjugateCluster, i : Int, v : Double) -> OptconvexconjugateCluster {
  let result = opt_convex_conjugate_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_cluster_sum(s : OptconvexconjugateCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_conjugate_cluster_mean(s : OptconvexconjugateCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_conjugate_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_convex_conjugate_cluster_scale(s : OptconvexconjugateCluster, f : Double) -> OptconvexconjugateCluster {
  let result = opt_convex_conjugate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_conjugate_cluster_add(a : OptconvexconjugateCluster, b : OptconvexconjugateCluster) -> OptconvexconjugateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_conjugate_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_conjugate_cluster_copy(s : OptconvexconjugateCluster) -> OptconvexconjugateCluster {
  let result = opt_convex_conjugate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_conjugate_cluster_fill(s : OptconvexconjugateCluster, v : Double) -> OptconvexconjugateCluster {
  let result = opt_convex_conjugate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_cluster_min(s : OptconvexconjugateCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_cluster_max(s : OptconvexconjugateCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_cluster_to_string(s : OptconvexconjugateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_model_make(size : Int) -> OptconvexconjugateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_model_len(s : OptconvexconjugateModel) -> Int { s.size }

pub fn opt_convex_conjugate_model_get(s : OptconvexconjugateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_model_set(s : OptconvexconjugateModel, i : Int, v : Double) -> OptconvexconjugateModel {
  let result = opt_convex_conjugate_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_model_sum(s : OptconvexconjugateModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_conjugate_model_mean(s : OptconvexconjugateModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_conjugate_model_sum(s) / s.size.to_double() }
}

pub fn opt_convex_conjugate_model_scale(s : OptconvexconjugateModel, f : Double) -> OptconvexconjugateModel {
  let result = opt_convex_conjugate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_conjugate_model_add(a : OptconvexconjugateModel, b : OptconvexconjugateModel) -> OptconvexconjugateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_conjugate_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_conjugate_model_copy(s : OptconvexconjugateModel) -> OptconvexconjugateModel {
  let result = opt_convex_conjugate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_conjugate_model_fill(s : OptconvexconjugateModel, v : Double) -> OptconvexconjugateModel {
  let result = opt_convex_conjugate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_model_min(s : OptconvexconjugateModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_model_max(s : OptconvexconjugateModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_model_to_string(s : OptconvexconjugateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_layer_make(size : Int) -> OptconvexconjugateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_layer_len(s : OptconvexconjugateLayer) -> Int { s.size }

pub fn opt_convex_conjugate_layer_get(s : OptconvexconjugateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_layer_set(s : OptconvexconjugateLayer, i : Int, v : Double) -> OptconvexconjugateLayer {
  let result = opt_convex_conjugate_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_layer_sum(s : OptconvexconjugateLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_conjugate_layer_mean(s : OptconvexconjugateLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_conjugate_layer_sum(s) / s.size.to_double() }
}

pub fn opt_convex_conjugate_layer_scale(s : OptconvexconjugateLayer, f : Double) -> OptconvexconjugateLayer {
  let result = opt_convex_conjugate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_conjugate_layer_add(a : OptconvexconjugateLayer, b : OptconvexconjugateLayer) -> OptconvexconjugateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_conjugate_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_conjugate_layer_copy(s : OptconvexconjugateLayer) -> OptconvexconjugateLayer {
  let result = opt_convex_conjugate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_conjugate_layer_fill(s : OptconvexconjugateLayer, v : Double) -> OptconvexconjugateLayer {
  let result = opt_convex_conjugate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_layer_min(s : OptconvexconjugateLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_layer_max(s : OptconvexconjugateLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_layer_to_string(s : OptconvexconjugateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_buffer_make(size : Int) -> OptconvexconjugateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_buffer_len(s : OptconvexconjugateBuffer) -> Int { s.size }

pub fn opt_convex_conjugate_buffer_get(s : OptconvexconjugateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_buffer_set(s : OptconvexconjugateBuffer, i : Int, v : Double) -> OptconvexconjugateBuffer {
  let result = opt_convex_conjugate_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_buffer_sum(s : OptconvexconjugateBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_conjugate_buffer_mean(s : OptconvexconjugateBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_conjugate_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_convex_conjugate_buffer_scale(s : OptconvexconjugateBuffer, f : Double) -> OptconvexconjugateBuffer {
  let result = opt_convex_conjugate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_conjugate_buffer_add(a : OptconvexconjugateBuffer, b : OptconvexconjugateBuffer) -> OptconvexconjugateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_conjugate_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_conjugate_buffer_copy(s : OptconvexconjugateBuffer) -> OptconvexconjugateBuffer {
  let result = opt_convex_conjugate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_conjugate_buffer_fill(s : OptconvexconjugateBuffer, v : Double) -> OptconvexconjugateBuffer {
  let result = opt_convex_conjugate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_buffer_min(s : OptconvexconjugateBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_buffer_max(s : OptconvexconjugateBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_buffer_to_string(s : OptconvexconjugateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_cursor_make(size : Int) -> OptconvexconjugateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_cursor_len(s : OptconvexconjugateCursor) -> Int { s.size }

pub fn opt_convex_conjugate_cursor_get(s : OptconvexconjugateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_cursor_set(s : OptconvexconjugateCursor, i : Int, v : Double) -> OptconvexconjugateCursor {
  let result = opt_convex_conjugate_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_cursor_sum(s : OptconvexconjugateCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_conjugate_cursor_mean(s : OptconvexconjugateCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_conjugate_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_convex_conjugate_cursor_scale(s : OptconvexconjugateCursor, f : Double) -> OptconvexconjugateCursor {
  let result = opt_convex_conjugate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_conjugate_cursor_add(a : OptconvexconjugateCursor, b : OptconvexconjugateCursor) -> OptconvexconjugateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_conjugate_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_conjugate_cursor_copy(s : OptconvexconjugateCursor) -> OptconvexconjugateCursor {
  let result = opt_convex_conjugate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_conjugate_cursor_fill(s : OptconvexconjugateCursor, v : Double) -> OptconvexconjugateCursor {
  let result = opt_convex_conjugate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_cursor_min(s : OptconvexconjugateCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_cursor_max(s : OptconvexconjugateCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_cursor_to_string(s : OptconvexconjugateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_view_make(size : Int) -> OptconvexconjugateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_view_len(s : OptconvexconjugateView) -> Int { s.size }

pub fn opt_convex_conjugate_view_get(s : OptconvexconjugateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_view_set(s : OptconvexconjugateView, i : Int, v : Double) -> OptconvexconjugateView {
  let result = opt_convex_conjugate_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_view_sum(s : OptconvexconjugateView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_conjugate_view_mean(s : OptconvexconjugateView) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_conjugate_view_sum(s) / s.size.to_double() }
}

pub fn opt_convex_conjugate_view_scale(s : OptconvexconjugateView, f : Double) -> OptconvexconjugateView {
  let result = opt_convex_conjugate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_conjugate_view_add(a : OptconvexconjugateView, b : OptconvexconjugateView) -> OptconvexconjugateView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_conjugate_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_conjugate_view_copy(s : OptconvexconjugateView) -> OptconvexconjugateView {
  let result = opt_convex_conjugate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_conjugate_view_fill(s : OptconvexconjugateView, v : Double) -> OptconvexconjugateView {
  let result = opt_convex_conjugate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_view_min(s : OptconvexconjugateView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_view_max(s : OptconvexconjugateView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_view_to_string(s : OptconvexconjugateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_range_make(size : Int) -> OptconvexconjugateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_range_len(s : OptconvexconjugateRange) -> Int { s.size }

pub fn opt_convex_conjugate_range_get(s : OptconvexconjugateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_range_set(s : OptconvexconjugateRange, i : Int, v : Double) -> OptconvexconjugateRange {
  let result = opt_convex_conjugate_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_range_sum(s : OptconvexconjugateRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_conjugate_range_mean(s : OptconvexconjugateRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_conjugate_range_sum(s) / s.size.to_double() }
}

pub fn opt_convex_conjugate_range_scale(s : OptconvexconjugateRange, f : Double) -> OptconvexconjugateRange {
  let result = opt_convex_conjugate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_conjugate_range_add(a : OptconvexconjugateRange, b : OptconvexconjugateRange) -> OptconvexconjugateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_conjugate_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_conjugate_range_copy(s : OptconvexconjugateRange) -> OptconvexconjugateRange {
  let result = opt_convex_conjugate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_conjugate_range_fill(s : OptconvexconjugateRange, v : Double) -> OptconvexconjugateRange {
  let result = opt_convex_conjugate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_range_min(s : OptconvexconjugateRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_range_max(s : OptconvexconjugateRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_range_to_string(s : OptconvexconjugateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexconjugateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_conjugate_slice_make(size : Int) -> OptconvexconjugateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_conjugate_slice_len(s : OptconvexconjugateSlice) -> Int { s.size }

pub fn opt_convex_conjugate_slice_get(s : OptconvexconjugateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_conjugate_slice_set(s : OptconvexconjugateSlice, i : Int, v : Double) -> OptconvexconjugateSlice {
  let result = opt_convex_conjugate_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_slice_sum(s : OptconvexconjugateSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_conjugate_slice_mean(s : OptconvexconjugateSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_conjugate_slice_sum(s) / s.size.to_double() }
}

pub fn opt_convex_conjugate_slice_scale(s : OptconvexconjugateSlice, f : Double) -> OptconvexconjugateSlice {
  let result = opt_convex_conjugate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_conjugate_slice_add(a : OptconvexconjugateSlice, b : OptconvexconjugateSlice) -> OptconvexconjugateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_conjugate_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_conjugate_slice_copy(s : OptconvexconjugateSlice) -> OptconvexconjugateSlice {
  let result = opt_convex_conjugate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_conjugate_slice_fill(s : OptconvexconjugateSlice, v : Double) -> OptconvexconjugateSlice {
  let result = opt_convex_conjugate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_conjugate_slice_min(s : OptconvexconjugateSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_slice_max(s : OptconvexconjugateSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_conjugate_slice_to_string(s : OptconvexconjugateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

