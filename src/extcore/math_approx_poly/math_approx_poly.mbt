///===
/// extcore/math_approx_poly

pub(all) struct MathapproxpolyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_poly_make_point(x : Double, y : Double) -> MathapproxpolyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_poly_make_point3(x : Double, y : Double, z : Double) -> MathapproxpolyPoint {
  { x, y, z, label: 0 }
}

pub fn math_approx_poly_point_x(pt : MathapproxpolyPoint) -> Double { pt.x }

pub fn math_approx_poly_point_y(pt : MathapproxpolyPoint) -> Double { pt.y }

pub fn math_approx_poly_point_z(pt : MathapproxpolyPoint) -> Double { pt.z }

pub fn math_approx_poly_point_label(pt : MathapproxpolyPoint) -> Int { pt.label }

pub fn math_approx_poly_point_dist(a : MathapproxpolyPoint, b : MathapproxpolyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_approx_poly_point_add(a : MathapproxpolyPoint, b : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_approx_poly_point_sub(a : MathapproxpolyPoint, b : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_approx_poly_point_scale(pt : MathapproxpolyPoint, s : Double) -> MathapproxpolyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_approx_poly_point_dot(a : MathapproxpolyPoint, b : MathapproxpolyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_approx_poly_point_cross(a : MathapproxpolyPoint, b : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_approx_poly_point_norm(pt : MathapproxpolyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_approx_poly_point_normalize(pt : MathapproxpolyPoint) -> MathapproxpolyPoint {
  let n = math_approx_poly_point_norm(pt)
  if n < 0.0000001 { pt } else { math_approx_poly_point_scale(pt, 1.0 / n) }
}

pub fn math_approx_poly_point_negate(pt : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_approx_poly_point_mid(a : MathapproxpolyPoint, b : MathapproxpolyPoint) -> MathapproxpolyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_approx_poly_point_lerp(a : MathapproxpolyPoint, b : MathapproxpolyPoint, t : Double) -> MathapproxpolyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_approx_poly_point_to_string(pt : MathapproxpolyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathapproxpolySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_poly_make_series(vals : Array[Double], name : String) -> MathapproxpolySeries {
  { vals, name, meta: 0 }
}

pub fn math_approx_poly_series_len(s : MathapproxpolySeries) -> Int { s.vals.length() }

pub fn math_approx_poly_series_sum(s : MathapproxpolySeries) -> Double { @_common.sum(s.vals) }

pub fn math_approx_poly_series_mean(s : MathapproxpolySeries) -> Double { @_common.mean(s.vals) }

pub fn math_approx_poly_series_min(s : MathapproxpolySeries) -> Double { @_common.min(s.vals) }

pub fn math_approx_poly_series_max(s : MathapproxpolySeries) -> Double { @_common.max(s.vals) }

pub fn math_approx_poly_series_range(s : MathapproxpolySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_approx_poly_series_var(s : MathapproxpolySeries) -> Double { @_common.variance(s.vals) }

pub fn math_approx_poly_series_std(s : MathapproxpolySeries) -> Double { @_common.std(s.vals) }

pub fn math_approx_poly_series_median(s : MathapproxpolySeries) -> Double { @_common.median(s.vals) }

pub fn math_approx_poly_series_scale(s : MathapproxpolySeries, f : Double) -> MathapproxpolySeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn math_approx_poly_series_add(a : MathapproxpolySeries, b : MathapproxpolySeries) -> MathapproxpolySeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_approx_poly_series_sub(a : MathapproxpolySeries, b : MathapproxpolySeries) -> MathapproxpolySeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_approx_poly_series_normalize(s : MathapproxpolySeries) -> MathapproxpolySeries {
  let mn = math_approx_poly_series_min(s)
  let mx = math_approx_poly_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_approx_poly_series_cumsum(s : MathapproxpolySeries) -> MathapproxpolySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_approx_poly_series_to_string(s : MathapproxpolySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxpolyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_poly_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxpolyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_poly_matrix_identity(n : Int) -> MathapproxpolyMatrix {
  let m = math_approx_poly_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_approx_poly_matrix_get(m : MathapproxpolyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_approx_poly_matrix_transpose(m : MathapproxpolyMatrix) -> MathapproxpolyMatrix {
  let result = math_approx_poly_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_approx_poly_matrix_add(a : MathapproxpolyMatrix, b : MathapproxpolyMatrix) -> MathapproxpolyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_approx_poly_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_approx_poly_matrix_scale(m : MathapproxpolyMatrix, s : Double) -> MathapproxpolyMatrix {
  let result = math_approx_poly_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_approx_poly_matrix_multiply(a : MathapproxpolyMatrix, b : MathapproxpolyMatrix) -> MathapproxpolyMatrix {
  if a.cols != b.rows { return math_approx_poly_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_approx_poly_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_approx_poly_matrix_trace(m : MathapproxpolyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_approx_poly_matrix_det(m : MathapproxpolyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_approx_poly_matrix_norm(m : MathapproxpolyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_approx_poly_matrix_to_string(m : MathapproxpolyMatrix) -> String {
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

pub(all) struct MathapproxpolyVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_poly_make_vector(comps : Array[Double]) -> MathapproxpolyVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_poly_vector_zero(dim : Int) -> MathapproxpolyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_approx_poly_vector_add(a : MathapproxpolyVector, b : MathapproxpolyVector) -> MathapproxpolyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn math_approx_poly_vector_sub(a : MathapproxpolyVector, b : MathapproxpolyVector) -> MathapproxpolyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn math_approx_poly_vector_scale(v : MathapproxpolyVector, s : Double) -> MathapproxpolyVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn math_approx_poly_vector_dot(a : MathapproxpolyVector, b : MathapproxpolyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_approx_poly_vector_norm(v : MathapproxpolyVector) -> Double { @_common.sqrt(math_approx_poly_vector_dot(v, v)) }

pub fn math_approx_poly_vector_normalize(v : MathapproxpolyVector) -> MathapproxpolyVector {
  let n = math_approx_poly_vector_norm(v)
  if n < 0.0000001 { v } else { math_approx_poly_vector_scale(v, 1.0 / n) }
}

pub fn math_approx_poly_vector_dist(a : MathapproxpolyVector, b : MathapproxpolyVector) -> Double {
  math_approx_poly_vector_norm(math_approx_poly_vector_sub(a, b))
}

pub fn math_approx_poly_vector_to_string(v : MathapproxpolyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_poly_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_approx_poly_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_approx_poly_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_approx_poly_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_approx_poly_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_approx_poly_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_approx_poly_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_approx_poly_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_approx_poly_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_approx_poly_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_approx_poly_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_approx_poly_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_approx_poly_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_approx_poly_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_approx_poly_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_approx_poly_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_approx_poly_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_approx_poly_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_approx_poly_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_approx_poly_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_approx_poly_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_approx_poly_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_approx_poly_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_approx_poly_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_approx_poly_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_approx_poly_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_approx_poly_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_approx_poly_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_approx_poly_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathapproxpolyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_frame_make(size : Int) -> MathapproxpolyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_frame_len(s : MathapproxpolyFrame) -> Int { s.size }

pub fn math_approx_poly_frame_get(s : MathapproxpolyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_frame_set(s : MathapproxpolyFrame, i : Int, v : Double) -> MathapproxpolyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_frame_sum(s : MathapproxpolyFrame) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_frame_mean(s : MathapproxpolyFrame) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_frame_scale(s : MathapproxpolyFrame, f : Double) -> MathapproxpolyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_frame_add(a : MathapproxpolyFrame, b : MathapproxpolyFrame) -> MathapproxpolyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_frame_copy(s : MathapproxpolyFrame) -> MathapproxpolyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_frame_fill(s : MathapproxpolyFrame, v : Double) -> MathapproxpolyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_frame_min(s : MathapproxpolyFrame) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_frame_max(s : MathapproxpolyFrame) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_frame_to_string(s : MathapproxpolyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_table_make(size : Int) -> MathapproxpolyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_table_len(s : MathapproxpolyTable) -> Int { s.size }

pub fn math_approx_poly_table_get(s : MathapproxpolyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_table_set(s : MathapproxpolyTable, i : Int, v : Double) -> MathapproxpolyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_table_sum(s : MathapproxpolyTable) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_table_mean(s : MathapproxpolyTable) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_table_scale(s : MathapproxpolyTable, f : Double) -> MathapproxpolyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_table_add(a : MathapproxpolyTable, b : MathapproxpolyTable) -> MathapproxpolyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_table_copy(s : MathapproxpolyTable) -> MathapproxpolyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_table_fill(s : MathapproxpolyTable, v : Double) -> MathapproxpolyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_table_min(s : MathapproxpolyTable) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_table_max(s : MathapproxpolyTable) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_table_to_string(s : MathapproxpolyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_graphn_make(size : Int) -> MathapproxpolyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_graphn_len(s : MathapproxpolyGraphN) -> Int { s.size }

pub fn math_approx_poly_graphn_get(s : MathapproxpolyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_graphn_set(s : MathapproxpolyGraphN, i : Int, v : Double) -> MathapproxpolyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_graphn_sum(s : MathapproxpolyGraphN) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_graphn_mean(s : MathapproxpolyGraphN) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_graphn_scale(s : MathapproxpolyGraphN, f : Double) -> MathapproxpolyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_graphn_add(a : MathapproxpolyGraphN, b : MathapproxpolyGraphN) -> MathapproxpolyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_graphn_copy(s : MathapproxpolyGraphN) -> MathapproxpolyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_graphn_fill(s : MathapproxpolyGraphN, v : Double) -> MathapproxpolyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_graphn_min(s : MathapproxpolyGraphN) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_graphn_max(s : MathapproxpolyGraphN) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_graphn_to_string(s : MathapproxpolyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_node_make(size : Int) -> MathapproxpolyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_node_len(s : MathapproxpolyNode) -> Int { s.size }

pub fn math_approx_poly_node_get(s : MathapproxpolyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_node_set(s : MathapproxpolyNode, i : Int, v : Double) -> MathapproxpolyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_node_sum(s : MathapproxpolyNode) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_node_mean(s : MathapproxpolyNode) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_node_scale(s : MathapproxpolyNode, f : Double) -> MathapproxpolyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_node_add(a : MathapproxpolyNode, b : MathapproxpolyNode) -> MathapproxpolyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_node_copy(s : MathapproxpolyNode) -> MathapproxpolyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_node_fill(s : MathapproxpolyNode, v : Double) -> MathapproxpolyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_node_min(s : MathapproxpolyNode) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_node_max(s : MathapproxpolyNode) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_node_to_string(s : MathapproxpolyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_edge_make(size : Int) -> MathapproxpolyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_edge_len(s : MathapproxpolyEdge) -> Int { s.size }

pub fn math_approx_poly_edge_get(s : MathapproxpolyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_edge_set(s : MathapproxpolyEdge, i : Int, v : Double) -> MathapproxpolyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_edge_sum(s : MathapproxpolyEdge) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_edge_mean(s : MathapproxpolyEdge) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_edge_scale(s : MathapproxpolyEdge, f : Double) -> MathapproxpolyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_edge_add(a : MathapproxpolyEdge, b : MathapproxpolyEdge) -> MathapproxpolyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_edge_copy(s : MathapproxpolyEdge) -> MathapproxpolyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_edge_fill(s : MathapproxpolyEdge, v : Double) -> MathapproxpolyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_edge_min(s : MathapproxpolyEdge) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_edge_max(s : MathapproxpolyEdge) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_edge_to_string(s : MathapproxpolyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_path_make(size : Int) -> MathapproxpolyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_path_len(s : MathapproxpolyPath) -> Int { s.size }

pub fn math_approx_poly_path_get(s : MathapproxpolyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_path_set(s : MathapproxpolyPath, i : Int, v : Double) -> MathapproxpolyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_path_sum(s : MathapproxpolyPath) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_path_mean(s : MathapproxpolyPath) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_path_scale(s : MathapproxpolyPath, f : Double) -> MathapproxpolyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_path_add(a : MathapproxpolyPath, b : MathapproxpolyPath) -> MathapproxpolyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_path_copy(s : MathapproxpolyPath) -> MathapproxpolyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_path_fill(s : MathapproxpolyPath, v : Double) -> MathapproxpolyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_path_min(s : MathapproxpolyPath) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_path_max(s : MathapproxpolyPath) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_path_to_string(s : MathapproxpolyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_cluster_make(size : Int) -> MathapproxpolyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_cluster_len(s : MathapproxpolyCluster) -> Int { s.size }

pub fn math_approx_poly_cluster_get(s : MathapproxpolyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_cluster_set(s : MathapproxpolyCluster, i : Int, v : Double) -> MathapproxpolyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_cluster_sum(s : MathapproxpolyCluster) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_cluster_mean(s : MathapproxpolyCluster) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_cluster_scale(s : MathapproxpolyCluster, f : Double) -> MathapproxpolyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_cluster_add(a : MathapproxpolyCluster, b : MathapproxpolyCluster) -> MathapproxpolyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_cluster_copy(s : MathapproxpolyCluster) -> MathapproxpolyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_cluster_fill(s : MathapproxpolyCluster, v : Double) -> MathapproxpolyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_cluster_min(s : MathapproxpolyCluster) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_cluster_max(s : MathapproxpolyCluster) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_cluster_to_string(s : MathapproxpolyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_model_make(size : Int) -> MathapproxpolyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_model_len(s : MathapproxpolyModel) -> Int { s.size }

pub fn math_approx_poly_model_get(s : MathapproxpolyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_model_set(s : MathapproxpolyModel, i : Int, v : Double) -> MathapproxpolyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_model_sum(s : MathapproxpolyModel) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_model_mean(s : MathapproxpolyModel) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_model_scale(s : MathapproxpolyModel, f : Double) -> MathapproxpolyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_model_add(a : MathapproxpolyModel, b : MathapproxpolyModel) -> MathapproxpolyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_model_copy(s : MathapproxpolyModel) -> MathapproxpolyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_model_fill(s : MathapproxpolyModel, v : Double) -> MathapproxpolyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_model_min(s : MathapproxpolyModel) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_model_max(s : MathapproxpolyModel) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_model_to_string(s : MathapproxpolyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_layer_make(size : Int) -> MathapproxpolyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_layer_len(s : MathapproxpolyLayer) -> Int { s.size }

pub fn math_approx_poly_layer_get(s : MathapproxpolyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_layer_set(s : MathapproxpolyLayer, i : Int, v : Double) -> MathapproxpolyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_layer_sum(s : MathapproxpolyLayer) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_layer_mean(s : MathapproxpolyLayer) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_layer_scale(s : MathapproxpolyLayer, f : Double) -> MathapproxpolyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_layer_add(a : MathapproxpolyLayer, b : MathapproxpolyLayer) -> MathapproxpolyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_layer_copy(s : MathapproxpolyLayer) -> MathapproxpolyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_layer_fill(s : MathapproxpolyLayer, v : Double) -> MathapproxpolyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_layer_min(s : MathapproxpolyLayer) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_layer_max(s : MathapproxpolyLayer) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_layer_to_string(s : MathapproxpolyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_buffer_make(size : Int) -> MathapproxpolyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_buffer_len(s : MathapproxpolyBuffer) -> Int { s.size }

pub fn math_approx_poly_buffer_get(s : MathapproxpolyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_buffer_set(s : MathapproxpolyBuffer, i : Int, v : Double) -> MathapproxpolyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_buffer_sum(s : MathapproxpolyBuffer) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_buffer_mean(s : MathapproxpolyBuffer) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_buffer_scale(s : MathapproxpolyBuffer, f : Double) -> MathapproxpolyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_buffer_add(a : MathapproxpolyBuffer, b : MathapproxpolyBuffer) -> MathapproxpolyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_buffer_copy(s : MathapproxpolyBuffer) -> MathapproxpolyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_buffer_fill(s : MathapproxpolyBuffer, v : Double) -> MathapproxpolyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_buffer_min(s : MathapproxpolyBuffer) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_buffer_max(s : MathapproxpolyBuffer) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_buffer_to_string(s : MathapproxpolyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_cursor_make(size : Int) -> MathapproxpolyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_cursor_len(s : MathapproxpolyCursor) -> Int { s.size }

pub fn math_approx_poly_cursor_get(s : MathapproxpolyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_cursor_set(s : MathapproxpolyCursor, i : Int, v : Double) -> MathapproxpolyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_cursor_sum(s : MathapproxpolyCursor) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_cursor_mean(s : MathapproxpolyCursor) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_cursor_scale(s : MathapproxpolyCursor, f : Double) -> MathapproxpolyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_cursor_add(a : MathapproxpolyCursor, b : MathapproxpolyCursor) -> MathapproxpolyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_cursor_copy(s : MathapproxpolyCursor) -> MathapproxpolyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_cursor_fill(s : MathapproxpolyCursor, v : Double) -> MathapproxpolyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_cursor_min(s : MathapproxpolyCursor) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_cursor_max(s : MathapproxpolyCursor) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_cursor_to_string(s : MathapproxpolyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_view_make(size : Int) -> MathapproxpolyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_view_len(s : MathapproxpolyView) -> Int { s.size }

pub fn math_approx_poly_view_get(s : MathapproxpolyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_view_set(s : MathapproxpolyView, i : Int, v : Double) -> MathapproxpolyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_view_sum(s : MathapproxpolyView) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_view_mean(s : MathapproxpolyView) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_view_scale(s : MathapproxpolyView, f : Double) -> MathapproxpolyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_view_add(a : MathapproxpolyView, b : MathapproxpolyView) -> MathapproxpolyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_view_copy(s : MathapproxpolyView) -> MathapproxpolyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_view_fill(s : MathapproxpolyView, v : Double) -> MathapproxpolyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_view_min(s : MathapproxpolyView) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_view_max(s : MathapproxpolyView) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_view_to_string(s : MathapproxpolyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_range_make(size : Int) -> MathapproxpolyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_range_len(s : MathapproxpolyRange) -> Int { s.size }

pub fn math_approx_poly_range_get(s : MathapproxpolyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_range_set(s : MathapproxpolyRange, i : Int, v : Double) -> MathapproxpolyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_range_sum(s : MathapproxpolyRange) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_range_mean(s : MathapproxpolyRange) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_range_scale(s : MathapproxpolyRange, f : Double) -> MathapproxpolyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_range_add(a : MathapproxpolyRange, b : MathapproxpolyRange) -> MathapproxpolyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_range_copy(s : MathapproxpolyRange) -> MathapproxpolyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_range_fill(s : MathapproxpolyRange, v : Double) -> MathapproxpolyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_range_min(s : MathapproxpolyRange) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_range_max(s : MathapproxpolyRange) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_range_to_string(s : MathapproxpolyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxpolySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_poly_slice_make(size : Int) -> MathapproxpolySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_poly_slice_len(s : MathapproxpolySlice) -> Int { s.size }

pub fn math_approx_poly_slice_get(s : MathapproxpolySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_poly_slice_set(s : MathapproxpolySlice, i : Int, v : Double) -> MathapproxpolySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_poly_slice_sum(s : MathapproxpolySlice) -> Double { @_common.sum(s.data) }

pub fn math_approx_poly_slice_mean(s : MathapproxpolySlice) -> Double { @_common.mean(s.data) }

pub fn math_approx_poly_slice_scale(s : MathapproxpolySlice, f : Double) -> MathapproxpolySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_slice_add(a : MathapproxpolySlice, b : MathapproxpolySlice) -> MathapproxpolySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_poly_slice_copy(s : MathapproxpolySlice) -> MathapproxpolySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_slice_fill(s : MathapproxpolySlice, v : Double) -> MathapproxpolySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_poly_slice_min(s : MathapproxpolySlice) -> Double { @_common.min(s.data) }

pub fn math_approx_poly_slice_max(s : MathapproxpolySlice) -> Double { @_common.max(s.data) }

pub fn math_approx_poly_slice_to_string(s : MathapproxpolySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

