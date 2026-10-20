///===
/// extcore/opt_convex_l_bfgs

pub(all) struct OptconvexlbfgsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_l_bfgs_make_point(x : Double, y : Double) -> OptconvexlbfgsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_l_bfgs_make_point3(x : Double, y : Double, z : Double) -> OptconvexlbfgsPoint {
  { x, y, z, label: 0 }
}

pub fn opt_convex_l_bfgs_point_x(pt : OptconvexlbfgsPoint) -> Double { pt.x }

pub fn opt_convex_l_bfgs_point_y(pt : OptconvexlbfgsPoint) -> Double { pt.y }

pub fn opt_convex_l_bfgs_point_z(pt : OptconvexlbfgsPoint) -> Double { pt.z }

pub fn opt_convex_l_bfgs_point_label(pt : OptconvexlbfgsPoint) -> Int { pt.label }

pub fn opt_convex_l_bfgs_point_dist(a : OptconvexlbfgsPoint, b : OptconvexlbfgsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_convex_l_bfgs_point_add(a : OptconvexlbfgsPoint, b : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_convex_l_bfgs_point_sub(a : OptconvexlbfgsPoint, b : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_convex_l_bfgs_point_scale(pt : OptconvexlbfgsPoint, s : Double) -> OptconvexlbfgsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_convex_l_bfgs_point_dot(a : OptconvexlbfgsPoint, b : OptconvexlbfgsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_convex_l_bfgs_point_cross(a : OptconvexlbfgsPoint, b : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_convex_l_bfgs_point_norm(pt : OptconvexlbfgsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_convex_l_bfgs_point_normalize(pt : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  let n = opt_convex_l_bfgs_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_convex_l_bfgs_point_scale(pt, 1.0 / n) }
}

pub fn opt_convex_l_bfgs_point_negate(pt : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_convex_l_bfgs_point_mid(a : OptconvexlbfgsPoint, b : OptconvexlbfgsPoint) -> OptconvexlbfgsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_convex_l_bfgs_point_lerp(a : OptconvexlbfgsPoint, b : OptconvexlbfgsPoint, t : Double) -> OptconvexlbfgsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_convex_l_bfgs_point_to_string(pt : OptconvexlbfgsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptconvexlbfgsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_l_bfgs_make_series(vals : Array[Double], name : String) -> OptconvexlbfgsSeries {
  { vals, name, meta: 0 }
}

pub fn opt_convex_l_bfgs_series_len(s : OptconvexlbfgsSeries) -> Int { s.vals.length() }

pub fn opt_convex_l_bfgs_series_sum(s : OptconvexlbfgsSeries) -> Double { @_common.sum(s.vals) }

pub fn opt_convex_l_bfgs_series_mean(s : OptconvexlbfgsSeries) -> Double { @_common.mean(s.vals) }

pub fn opt_convex_l_bfgs_series_min(s : OptconvexlbfgsSeries) -> Double { @_common.min(s.vals) }

pub fn opt_convex_l_bfgs_series_max(s : OptconvexlbfgsSeries) -> Double { @_common.max(s.vals) }

pub fn opt_convex_l_bfgs_series_range(s : OptconvexlbfgsSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn opt_convex_l_bfgs_series_var(s : OptconvexlbfgsSeries) -> Double { @_common.variance(s.vals) }

pub fn opt_convex_l_bfgs_series_std(s : OptconvexlbfgsSeries) -> Double { @_common.std(s.vals) }

pub fn opt_convex_l_bfgs_series_median(s : OptconvexlbfgsSeries) -> Double { @_common.median(s.vals) }

pub fn opt_convex_l_bfgs_series_scale(s : OptconvexlbfgsSeries, f : Double) -> OptconvexlbfgsSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_convex_l_bfgs_series_add(a : OptconvexlbfgsSeries, b : OptconvexlbfgsSeries) -> OptconvexlbfgsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_convex_l_bfgs_series_sub(a : OptconvexlbfgsSeries, b : OptconvexlbfgsSeries) -> OptconvexlbfgsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_convex_l_bfgs_series_normalize(s : OptconvexlbfgsSeries) -> OptconvexlbfgsSeries {
  let mn = opt_convex_l_bfgs_series_min(s)
  let mx = opt_convex_l_bfgs_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_convex_l_bfgs_series_cumsum(s : OptconvexlbfgsSeries) -> OptconvexlbfgsSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_convex_l_bfgs_series_to_string(s : OptconvexlbfgsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexlbfgsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_l_bfgs_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexlbfgsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_l_bfgs_matrix_identity(n : Int) -> OptconvexlbfgsMatrix {
  let m = opt_convex_l_bfgs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_convex_l_bfgs_matrix_get(m : OptconvexlbfgsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_convex_l_bfgs_matrix_transpose(m : OptconvexlbfgsMatrix) -> OptconvexlbfgsMatrix {
  let result = opt_convex_l_bfgs_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_convex_l_bfgs_matrix_add(a : OptconvexlbfgsMatrix, b : OptconvexlbfgsMatrix) -> OptconvexlbfgsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_convex_l_bfgs_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_convex_l_bfgs_matrix_scale(m : OptconvexlbfgsMatrix, s : Double) -> OptconvexlbfgsMatrix {
  let result = opt_convex_l_bfgs_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_convex_l_bfgs_matrix_multiply(a : OptconvexlbfgsMatrix, b : OptconvexlbfgsMatrix) -> OptconvexlbfgsMatrix {
  if a.cols != b.rows { return opt_convex_l_bfgs_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_convex_l_bfgs_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_convex_l_bfgs_matrix_trace(m : OptconvexlbfgsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_convex_l_bfgs_matrix_det(m : OptconvexlbfgsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_convex_l_bfgs_matrix_norm(m : OptconvexlbfgsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_convex_l_bfgs_matrix_to_string(m : OptconvexlbfgsMatrix) -> String {
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

pub(all) struct OptconvexlbfgsVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_l_bfgs_make_vector(comps : Array[Double]) -> OptconvexlbfgsVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_l_bfgs_vector_zero(dim : Int) -> OptconvexlbfgsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_convex_l_bfgs_vector_add(a : OptconvexlbfgsVector, b : OptconvexlbfgsVector) -> OptconvexlbfgsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_l_bfgs_vector_sub(a : OptconvexlbfgsVector, b : OptconvexlbfgsVector) -> OptconvexlbfgsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_l_bfgs_vector_scale(v : OptconvexlbfgsVector, s : Double) -> OptconvexlbfgsVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_convex_l_bfgs_vector_dot(a : OptconvexlbfgsVector, b : OptconvexlbfgsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_convex_l_bfgs_vector_norm(v : OptconvexlbfgsVector) -> Double { @_common.sqrt(opt_convex_l_bfgs_vector_dot(v, v)) }

pub fn opt_convex_l_bfgs_vector_normalize(v : OptconvexlbfgsVector) -> OptconvexlbfgsVector {
  let n = opt_convex_l_bfgs_vector_norm(v)
  if n < 0.0000001 { v } else { opt_convex_l_bfgs_vector_scale(v, 1.0 / n) }
}

pub fn opt_convex_l_bfgs_vector_dist(a : OptconvexlbfgsVector, b : OptconvexlbfgsVector) -> Double {
  opt_convex_l_bfgs_vector_norm(opt_convex_l_bfgs_vector_sub(a, b))
}

pub fn opt_convex_l_bfgs_vector_to_string(v : OptconvexlbfgsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_l_bfgs_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_convex_l_bfgs_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_convex_l_bfgs_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_convex_l_bfgs_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_convex_l_bfgs_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_convex_l_bfgs_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_convex_l_bfgs_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_convex_l_bfgs_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_convex_l_bfgs_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_convex_l_bfgs_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_convex_l_bfgs_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_convex_l_bfgs_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_convex_l_bfgs_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_convex_l_bfgs_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_convex_l_bfgs_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_convex_l_bfgs_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_convex_l_bfgs_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_convex_l_bfgs_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_convex_l_bfgs_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_convex_l_bfgs_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_convex_l_bfgs_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_convex_l_bfgs_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_convex_l_bfgs_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_convex_l_bfgs_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_convex_l_bfgs_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_convex_l_bfgs_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_convex_l_bfgs_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_convex_l_bfgs_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_convex_l_bfgs_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptconvexlbfgsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_frame_make(size : Int) -> OptconvexlbfgsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_frame_len(s : OptconvexlbfgsFrame) -> Int { s.size }

pub fn opt_convex_l_bfgs_frame_get(s : OptconvexlbfgsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_frame_set(s : OptconvexlbfgsFrame, i : Int, v : Double) -> OptconvexlbfgsFrame {
  let result = opt_convex_l_bfgs_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_frame_sum(s : OptconvexlbfgsFrame) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_frame_mean(s : OptconvexlbfgsFrame) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_frame_scale(s : OptconvexlbfgsFrame, f : Double) -> OptconvexlbfgsFrame {
  let result = opt_convex_l_bfgs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_frame_add(a : OptconvexlbfgsFrame, b : OptconvexlbfgsFrame) -> OptconvexlbfgsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_frame_copy(s : OptconvexlbfgsFrame) -> OptconvexlbfgsFrame {
  let result = opt_convex_l_bfgs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_frame_fill(s : OptconvexlbfgsFrame, v : Double) -> OptconvexlbfgsFrame {
  let result = opt_convex_l_bfgs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_frame_min(s : OptconvexlbfgsFrame) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_frame_max(s : OptconvexlbfgsFrame) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_frame_to_string(s : OptconvexlbfgsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_table_make(size : Int) -> OptconvexlbfgsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_table_len(s : OptconvexlbfgsTable) -> Int { s.size }

pub fn opt_convex_l_bfgs_table_get(s : OptconvexlbfgsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_table_set(s : OptconvexlbfgsTable, i : Int, v : Double) -> OptconvexlbfgsTable {
  let result = opt_convex_l_bfgs_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_table_sum(s : OptconvexlbfgsTable) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_table_mean(s : OptconvexlbfgsTable) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_table_scale(s : OptconvexlbfgsTable, f : Double) -> OptconvexlbfgsTable {
  let result = opt_convex_l_bfgs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_table_add(a : OptconvexlbfgsTable, b : OptconvexlbfgsTable) -> OptconvexlbfgsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_table_copy(s : OptconvexlbfgsTable) -> OptconvexlbfgsTable {
  let result = opt_convex_l_bfgs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_table_fill(s : OptconvexlbfgsTable, v : Double) -> OptconvexlbfgsTable {
  let result = opt_convex_l_bfgs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_table_min(s : OptconvexlbfgsTable) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_table_max(s : OptconvexlbfgsTable) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_table_to_string(s : OptconvexlbfgsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_graphn_make(size : Int) -> OptconvexlbfgsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_graphn_len(s : OptconvexlbfgsGraphN) -> Int { s.size }

pub fn opt_convex_l_bfgs_graphn_get(s : OptconvexlbfgsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_graphn_set(s : OptconvexlbfgsGraphN, i : Int, v : Double) -> OptconvexlbfgsGraphN {
  let result = opt_convex_l_bfgs_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_graphn_sum(s : OptconvexlbfgsGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_graphn_mean(s : OptconvexlbfgsGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_graphn_scale(s : OptconvexlbfgsGraphN, f : Double) -> OptconvexlbfgsGraphN {
  let result = opt_convex_l_bfgs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_graphn_add(a : OptconvexlbfgsGraphN, b : OptconvexlbfgsGraphN) -> OptconvexlbfgsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_graphn_copy(s : OptconvexlbfgsGraphN) -> OptconvexlbfgsGraphN {
  let result = opt_convex_l_bfgs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_graphn_fill(s : OptconvexlbfgsGraphN, v : Double) -> OptconvexlbfgsGraphN {
  let result = opt_convex_l_bfgs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_graphn_min(s : OptconvexlbfgsGraphN) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_graphn_max(s : OptconvexlbfgsGraphN) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_graphn_to_string(s : OptconvexlbfgsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_node_make(size : Int) -> OptconvexlbfgsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_node_len(s : OptconvexlbfgsNode) -> Int { s.size }

pub fn opt_convex_l_bfgs_node_get(s : OptconvexlbfgsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_node_set(s : OptconvexlbfgsNode, i : Int, v : Double) -> OptconvexlbfgsNode {
  let result = opt_convex_l_bfgs_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_node_sum(s : OptconvexlbfgsNode) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_node_mean(s : OptconvexlbfgsNode) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_node_scale(s : OptconvexlbfgsNode, f : Double) -> OptconvexlbfgsNode {
  let result = opt_convex_l_bfgs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_node_add(a : OptconvexlbfgsNode, b : OptconvexlbfgsNode) -> OptconvexlbfgsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_node_copy(s : OptconvexlbfgsNode) -> OptconvexlbfgsNode {
  let result = opt_convex_l_bfgs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_node_fill(s : OptconvexlbfgsNode, v : Double) -> OptconvexlbfgsNode {
  let result = opt_convex_l_bfgs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_node_min(s : OptconvexlbfgsNode) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_node_max(s : OptconvexlbfgsNode) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_node_to_string(s : OptconvexlbfgsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_edge_make(size : Int) -> OptconvexlbfgsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_edge_len(s : OptconvexlbfgsEdge) -> Int { s.size }

pub fn opt_convex_l_bfgs_edge_get(s : OptconvexlbfgsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_edge_set(s : OptconvexlbfgsEdge, i : Int, v : Double) -> OptconvexlbfgsEdge {
  let result = opt_convex_l_bfgs_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_edge_sum(s : OptconvexlbfgsEdge) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_edge_mean(s : OptconvexlbfgsEdge) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_edge_scale(s : OptconvexlbfgsEdge, f : Double) -> OptconvexlbfgsEdge {
  let result = opt_convex_l_bfgs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_edge_add(a : OptconvexlbfgsEdge, b : OptconvexlbfgsEdge) -> OptconvexlbfgsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_edge_copy(s : OptconvexlbfgsEdge) -> OptconvexlbfgsEdge {
  let result = opt_convex_l_bfgs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_edge_fill(s : OptconvexlbfgsEdge, v : Double) -> OptconvexlbfgsEdge {
  let result = opt_convex_l_bfgs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_edge_min(s : OptconvexlbfgsEdge) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_edge_max(s : OptconvexlbfgsEdge) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_edge_to_string(s : OptconvexlbfgsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_path_make(size : Int) -> OptconvexlbfgsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_path_len(s : OptconvexlbfgsPath) -> Int { s.size }

pub fn opt_convex_l_bfgs_path_get(s : OptconvexlbfgsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_path_set(s : OptconvexlbfgsPath, i : Int, v : Double) -> OptconvexlbfgsPath {
  let result = opt_convex_l_bfgs_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_path_sum(s : OptconvexlbfgsPath) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_path_mean(s : OptconvexlbfgsPath) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_path_scale(s : OptconvexlbfgsPath, f : Double) -> OptconvexlbfgsPath {
  let result = opt_convex_l_bfgs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_path_add(a : OptconvexlbfgsPath, b : OptconvexlbfgsPath) -> OptconvexlbfgsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_path_copy(s : OptconvexlbfgsPath) -> OptconvexlbfgsPath {
  let result = opt_convex_l_bfgs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_path_fill(s : OptconvexlbfgsPath, v : Double) -> OptconvexlbfgsPath {
  let result = opt_convex_l_bfgs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_path_min(s : OptconvexlbfgsPath) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_path_max(s : OptconvexlbfgsPath) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_path_to_string(s : OptconvexlbfgsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_cluster_make(size : Int) -> OptconvexlbfgsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_cluster_len(s : OptconvexlbfgsCluster) -> Int { s.size }

pub fn opt_convex_l_bfgs_cluster_get(s : OptconvexlbfgsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_cluster_set(s : OptconvexlbfgsCluster, i : Int, v : Double) -> OptconvexlbfgsCluster {
  let result = opt_convex_l_bfgs_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_cluster_sum(s : OptconvexlbfgsCluster) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_cluster_mean(s : OptconvexlbfgsCluster) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_cluster_scale(s : OptconvexlbfgsCluster, f : Double) -> OptconvexlbfgsCluster {
  let result = opt_convex_l_bfgs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_cluster_add(a : OptconvexlbfgsCluster, b : OptconvexlbfgsCluster) -> OptconvexlbfgsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_cluster_copy(s : OptconvexlbfgsCluster) -> OptconvexlbfgsCluster {
  let result = opt_convex_l_bfgs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_cluster_fill(s : OptconvexlbfgsCluster, v : Double) -> OptconvexlbfgsCluster {
  let result = opt_convex_l_bfgs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_cluster_min(s : OptconvexlbfgsCluster) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_cluster_max(s : OptconvexlbfgsCluster) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_cluster_to_string(s : OptconvexlbfgsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_model_make(size : Int) -> OptconvexlbfgsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_model_len(s : OptconvexlbfgsModel) -> Int { s.size }

pub fn opt_convex_l_bfgs_model_get(s : OptconvexlbfgsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_model_set(s : OptconvexlbfgsModel, i : Int, v : Double) -> OptconvexlbfgsModel {
  let result = opt_convex_l_bfgs_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_model_sum(s : OptconvexlbfgsModel) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_model_mean(s : OptconvexlbfgsModel) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_model_scale(s : OptconvexlbfgsModel, f : Double) -> OptconvexlbfgsModel {
  let result = opt_convex_l_bfgs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_model_add(a : OptconvexlbfgsModel, b : OptconvexlbfgsModel) -> OptconvexlbfgsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_model_copy(s : OptconvexlbfgsModel) -> OptconvexlbfgsModel {
  let result = opt_convex_l_bfgs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_model_fill(s : OptconvexlbfgsModel, v : Double) -> OptconvexlbfgsModel {
  let result = opt_convex_l_bfgs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_model_min(s : OptconvexlbfgsModel) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_model_max(s : OptconvexlbfgsModel) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_model_to_string(s : OptconvexlbfgsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_layer_make(size : Int) -> OptconvexlbfgsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_layer_len(s : OptconvexlbfgsLayer) -> Int { s.size }

pub fn opt_convex_l_bfgs_layer_get(s : OptconvexlbfgsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_layer_set(s : OptconvexlbfgsLayer, i : Int, v : Double) -> OptconvexlbfgsLayer {
  let result = opt_convex_l_bfgs_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_layer_sum(s : OptconvexlbfgsLayer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_layer_mean(s : OptconvexlbfgsLayer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_layer_scale(s : OptconvexlbfgsLayer, f : Double) -> OptconvexlbfgsLayer {
  let result = opt_convex_l_bfgs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_layer_add(a : OptconvexlbfgsLayer, b : OptconvexlbfgsLayer) -> OptconvexlbfgsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_layer_copy(s : OptconvexlbfgsLayer) -> OptconvexlbfgsLayer {
  let result = opt_convex_l_bfgs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_layer_fill(s : OptconvexlbfgsLayer, v : Double) -> OptconvexlbfgsLayer {
  let result = opt_convex_l_bfgs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_layer_min(s : OptconvexlbfgsLayer) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_layer_max(s : OptconvexlbfgsLayer) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_layer_to_string(s : OptconvexlbfgsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_buffer_make(size : Int) -> OptconvexlbfgsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_buffer_len(s : OptconvexlbfgsBuffer) -> Int { s.size }

pub fn opt_convex_l_bfgs_buffer_get(s : OptconvexlbfgsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_buffer_set(s : OptconvexlbfgsBuffer, i : Int, v : Double) -> OptconvexlbfgsBuffer {
  let result = opt_convex_l_bfgs_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_buffer_sum(s : OptconvexlbfgsBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_buffer_mean(s : OptconvexlbfgsBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_buffer_scale(s : OptconvexlbfgsBuffer, f : Double) -> OptconvexlbfgsBuffer {
  let result = opt_convex_l_bfgs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_buffer_add(a : OptconvexlbfgsBuffer, b : OptconvexlbfgsBuffer) -> OptconvexlbfgsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_buffer_copy(s : OptconvexlbfgsBuffer) -> OptconvexlbfgsBuffer {
  let result = opt_convex_l_bfgs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_buffer_fill(s : OptconvexlbfgsBuffer, v : Double) -> OptconvexlbfgsBuffer {
  let result = opt_convex_l_bfgs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_buffer_min(s : OptconvexlbfgsBuffer) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_buffer_max(s : OptconvexlbfgsBuffer) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_buffer_to_string(s : OptconvexlbfgsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_cursor_make(size : Int) -> OptconvexlbfgsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_cursor_len(s : OptconvexlbfgsCursor) -> Int { s.size }

pub fn opt_convex_l_bfgs_cursor_get(s : OptconvexlbfgsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_cursor_set(s : OptconvexlbfgsCursor, i : Int, v : Double) -> OptconvexlbfgsCursor {
  let result = opt_convex_l_bfgs_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_cursor_sum(s : OptconvexlbfgsCursor) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_cursor_mean(s : OptconvexlbfgsCursor) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_cursor_scale(s : OptconvexlbfgsCursor, f : Double) -> OptconvexlbfgsCursor {
  let result = opt_convex_l_bfgs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_cursor_add(a : OptconvexlbfgsCursor, b : OptconvexlbfgsCursor) -> OptconvexlbfgsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_cursor_copy(s : OptconvexlbfgsCursor) -> OptconvexlbfgsCursor {
  let result = opt_convex_l_bfgs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_cursor_fill(s : OptconvexlbfgsCursor, v : Double) -> OptconvexlbfgsCursor {
  let result = opt_convex_l_bfgs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_cursor_min(s : OptconvexlbfgsCursor) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_cursor_max(s : OptconvexlbfgsCursor) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_cursor_to_string(s : OptconvexlbfgsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_view_make(size : Int) -> OptconvexlbfgsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_view_len(s : OptconvexlbfgsView) -> Int { s.size }

pub fn opt_convex_l_bfgs_view_get(s : OptconvexlbfgsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_view_set(s : OptconvexlbfgsView, i : Int, v : Double) -> OptconvexlbfgsView {
  let result = opt_convex_l_bfgs_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_view_sum(s : OptconvexlbfgsView) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_view_mean(s : OptconvexlbfgsView) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_view_scale(s : OptconvexlbfgsView, f : Double) -> OptconvexlbfgsView {
  let result = opt_convex_l_bfgs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_view_add(a : OptconvexlbfgsView, b : OptconvexlbfgsView) -> OptconvexlbfgsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_view_copy(s : OptconvexlbfgsView) -> OptconvexlbfgsView {
  let result = opt_convex_l_bfgs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_view_fill(s : OptconvexlbfgsView, v : Double) -> OptconvexlbfgsView {
  let result = opt_convex_l_bfgs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_view_min(s : OptconvexlbfgsView) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_view_max(s : OptconvexlbfgsView) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_view_to_string(s : OptconvexlbfgsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_range_make(size : Int) -> OptconvexlbfgsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_range_len(s : OptconvexlbfgsRange) -> Int { s.size }

pub fn opt_convex_l_bfgs_range_get(s : OptconvexlbfgsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_range_set(s : OptconvexlbfgsRange, i : Int, v : Double) -> OptconvexlbfgsRange {
  let result = opt_convex_l_bfgs_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_range_sum(s : OptconvexlbfgsRange) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_range_mean(s : OptconvexlbfgsRange) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_range_scale(s : OptconvexlbfgsRange, f : Double) -> OptconvexlbfgsRange {
  let result = opt_convex_l_bfgs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_range_add(a : OptconvexlbfgsRange, b : OptconvexlbfgsRange) -> OptconvexlbfgsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_range_copy(s : OptconvexlbfgsRange) -> OptconvexlbfgsRange {
  let result = opt_convex_l_bfgs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_range_fill(s : OptconvexlbfgsRange, v : Double) -> OptconvexlbfgsRange {
  let result = opt_convex_l_bfgs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_range_min(s : OptconvexlbfgsRange) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_range_max(s : OptconvexlbfgsRange) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_range_to_string(s : OptconvexlbfgsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexlbfgsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_l_bfgs_slice_make(size : Int) -> OptconvexlbfgsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_l_bfgs_slice_len(s : OptconvexlbfgsSlice) -> Int { s.size }

pub fn opt_convex_l_bfgs_slice_get(s : OptconvexlbfgsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_l_bfgs_slice_set(s : OptconvexlbfgsSlice, i : Int, v : Double) -> OptconvexlbfgsSlice {
  let result = opt_convex_l_bfgs_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_slice_sum(s : OptconvexlbfgsSlice) -> Double { @_common.sum(s.data) }

pub fn opt_convex_l_bfgs_slice_mean(s : OptconvexlbfgsSlice) -> Double { @_common.mean(s.data) }

pub fn opt_convex_l_bfgs_slice_scale(s : OptconvexlbfgsSlice, f : Double) -> OptconvexlbfgsSlice {
  let result = opt_convex_l_bfgs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_l_bfgs_slice_add(a : OptconvexlbfgsSlice, b : OptconvexlbfgsSlice) -> OptconvexlbfgsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_l_bfgs_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_l_bfgs_slice_copy(s : OptconvexlbfgsSlice) -> OptconvexlbfgsSlice {
  let result = opt_convex_l_bfgs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_l_bfgs_slice_fill(s : OptconvexlbfgsSlice, v : Double) -> OptconvexlbfgsSlice {
  let result = opt_convex_l_bfgs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_l_bfgs_slice_min(s : OptconvexlbfgsSlice) -> Double { @_common.min(s.data) }

pub fn opt_convex_l_bfgs_slice_max(s : OptconvexlbfgsSlice) -> Double { @_common.max(s.data) }

pub fn opt_convex_l_bfgs_slice_to_string(s : OptconvexlbfgsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

