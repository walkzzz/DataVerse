///===
/// extcore/math_linear_algebra

pub(all) struct MathlinearalgebraPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_linear_algebra_make_point(x : Double, y : Double) -> MathlinearalgebraPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_linear_algebra_make_point3(x : Double, y : Double, z : Double) -> MathlinearalgebraPoint {
  { x, y, z, label: 0 }
}

pub fn math_linear_algebra_point_x(pt : MathlinearalgebraPoint) -> Double { pt.x }

pub fn math_linear_algebra_point_y(pt : MathlinearalgebraPoint) -> Double { pt.y }

pub fn math_linear_algebra_point_z(pt : MathlinearalgebraPoint) -> Double { pt.z }

pub fn math_linear_algebra_point_label(pt : MathlinearalgebraPoint) -> Int { pt.label }

pub fn math_linear_algebra_point_dist(a : MathlinearalgebraPoint, b : MathlinearalgebraPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_linear_algebra_point_add(a : MathlinearalgebraPoint, b : MathlinearalgebraPoint) -> MathlinearalgebraPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_linear_algebra_point_sub(a : MathlinearalgebraPoint, b : MathlinearalgebraPoint) -> MathlinearalgebraPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_linear_algebra_point_scale(pt : MathlinearalgebraPoint, s : Double) -> MathlinearalgebraPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_linear_algebra_point_dot(a : MathlinearalgebraPoint, b : MathlinearalgebraPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_linear_algebra_point_cross(a : MathlinearalgebraPoint, b : MathlinearalgebraPoint) -> MathlinearalgebraPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_linear_algebra_point_norm(pt : MathlinearalgebraPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_linear_algebra_point_normalize(pt : MathlinearalgebraPoint) -> MathlinearalgebraPoint {
  let n = math_linear_algebra_point_norm(pt)
  if n < 0.0000001 { pt } else { math_linear_algebra_point_scale(pt, 1.0 / n) }
}

pub fn math_linear_algebra_point_negate(pt : MathlinearalgebraPoint) -> MathlinearalgebraPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_linear_algebra_point_mid(a : MathlinearalgebraPoint, b : MathlinearalgebraPoint) -> MathlinearalgebraPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_linear_algebra_point_lerp(a : MathlinearalgebraPoint, b : MathlinearalgebraPoint, t : Double) -> MathlinearalgebraPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_linear_algebra_point_to_string(pt : MathlinearalgebraPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathlinearalgebraSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_linear_algebra_make_series(vals : Array[Double], name : String) -> MathlinearalgebraSeries {
  { vals, name, meta: 0 }
}

pub fn math_linear_algebra_series_len(s : MathlinearalgebraSeries) -> Int { s.vals.length() }

pub fn math_linear_algebra_series_sum(s : MathlinearalgebraSeries) -> Double { @_common.sum(s.vals) }

pub fn math_linear_algebra_series_mean(s : MathlinearalgebraSeries) -> Double { @_common.mean(s.vals) }

pub fn math_linear_algebra_series_min(s : MathlinearalgebraSeries) -> Double { @_common.min(s.vals) }

pub fn math_linear_algebra_series_max(s : MathlinearalgebraSeries) -> Double { @_common.max(s.vals) }

pub fn math_linear_algebra_series_range(s : MathlinearalgebraSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_linear_algebra_series_var(s : MathlinearalgebraSeries) -> Double { @_common.variance(s.vals) }

pub fn math_linear_algebra_series_std(s : MathlinearalgebraSeries) -> Double { @_common.std(s.vals) }

pub fn math_linear_algebra_series_median(s : MathlinearalgebraSeries) -> Double { @_common.median(s.vals) }

pub fn math_linear_algebra_series_scale(s : MathlinearalgebraSeries, f : Double) -> MathlinearalgebraSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_linear_algebra_series_add(a : MathlinearalgebraSeries, b : MathlinearalgebraSeries) -> MathlinearalgebraSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_linear_algebra_series_sub(a : MathlinearalgebraSeries, b : MathlinearalgebraSeries) -> MathlinearalgebraSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_linear_algebra_series_normalize(s : MathlinearalgebraSeries) -> MathlinearalgebraSeries {
  let mn = math_linear_algebra_series_min(s)
  let mx = math_linear_algebra_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_linear_algebra_series_cumsum(s : MathlinearalgebraSeries) -> MathlinearalgebraSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_linear_algebra_series_to_string(s : MathlinearalgebraSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathlinearalgebraMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_linear_algebra_make_matrix(rows : Int, cols : Int, val : Double) -> MathlinearalgebraMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_linear_algebra_matrix_identity(n : Int) -> MathlinearalgebraMatrix {
  let m = math_linear_algebra_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_linear_algebra_matrix_get(m : MathlinearalgebraMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_linear_algebra_matrix_transpose(m : MathlinearalgebraMatrix) -> MathlinearalgebraMatrix {
  let result = math_linear_algebra_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_linear_algebra_matrix_add(a : MathlinearalgebraMatrix, b : MathlinearalgebraMatrix) -> MathlinearalgebraMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_linear_algebra_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_linear_algebra_matrix_scale(m : MathlinearalgebraMatrix, s : Double) -> MathlinearalgebraMatrix {
  let result = math_linear_algebra_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_linear_algebra_matrix_multiply(a : MathlinearalgebraMatrix, b : MathlinearalgebraMatrix) -> MathlinearalgebraMatrix {
  if a.cols != b.rows { return math_linear_algebra_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_linear_algebra_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_linear_algebra_matrix_trace(m : MathlinearalgebraMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_linear_algebra_matrix_det(m : MathlinearalgebraMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_linear_algebra_matrix_norm(m : MathlinearalgebraMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_linear_algebra_matrix_to_string(m : MathlinearalgebraMatrix) -> String {
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

pub(all) struct MathlinearalgebraVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_linear_algebra_make_vector(comps : Array[Double]) -> MathlinearalgebraVector {
  { comps, dim: comps.length() }
}

pub fn math_linear_algebra_vector_zero(dim : Int) -> MathlinearalgebraVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_linear_algebra_vector_add(a : MathlinearalgebraVector, b : MathlinearalgebraVector) -> MathlinearalgebraVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_linear_algebra_vector_sub(a : MathlinearalgebraVector, b : MathlinearalgebraVector) -> MathlinearalgebraVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_linear_algebra_vector_scale(v : MathlinearalgebraVector, s : Double) -> MathlinearalgebraVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_linear_algebra_vector_dot(a : MathlinearalgebraVector, b : MathlinearalgebraVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_linear_algebra_vector_norm(v : MathlinearalgebraVector) -> Double { @_common.sqrt(math_linear_algebra_vector_dot(v, v)) }

pub fn math_linear_algebra_vector_normalize(v : MathlinearalgebraVector) -> MathlinearalgebraVector {
  let n = math_linear_algebra_vector_norm(v)
  if n < 0.0000001 { v } else { math_linear_algebra_vector_scale(v, 1.0 / n) }
}

pub fn math_linear_algebra_vector_dist(a : MathlinearalgebraVector, b : MathlinearalgebraVector) -> Double {
  math_linear_algebra_vector_norm(math_linear_algebra_vector_sub(a, b))
}

pub fn math_linear_algebra_vector_to_string(v : MathlinearalgebraVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_linear_algebra_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_linear_algebra_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_linear_algebra_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_linear_algebra_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_linear_algebra_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_linear_algebra_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_linear_algebra_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_linear_algebra_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_linear_algebra_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_linear_algebra_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_linear_algebra_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_linear_algebra_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_linear_algebra_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_linear_algebra_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_linear_algebra_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_linear_algebra_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_linear_algebra_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_linear_algebra_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_linear_algebra_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_linear_algebra_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_linear_algebra_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_linear_algebra_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_linear_algebra_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_linear_algebra_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_linear_algebra_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_linear_algebra_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_linear_algebra_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_linear_algebra_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_linear_algebra_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathlinearalgebraFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_frame_make(size : Int) -> MathlinearalgebraFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_frame_len(s : MathlinearalgebraFrame) -> Int { s.size }

pub fn math_linear_algebra_frame_get(s : MathlinearalgebraFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_frame_set(s : MathlinearalgebraFrame, i : Int, v : Double) -> MathlinearalgebraFrame {
  let result = math_linear_algebra_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_algebra_frame_sum(s : MathlinearalgebraFrame) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_frame_mean(s : MathlinearalgebraFrame) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_frame_scale(s : MathlinearalgebraFrame, f : Double) -> MathlinearalgebraFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_frame_add(a : MathlinearalgebraFrame, b : MathlinearalgebraFrame) -> MathlinearalgebraFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_frame_copy(s : MathlinearalgebraFrame) -> MathlinearalgebraFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_frame_fill(s : MathlinearalgebraFrame, v : Double) -> MathlinearalgebraFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_frame_min(s : MathlinearalgebraFrame) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_frame_max(s : MathlinearalgebraFrame) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_frame_to_string(s : MathlinearalgebraFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_table_make(size : Int) -> MathlinearalgebraTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_table_len(s : MathlinearalgebraTable) -> Int { s.size }

pub fn math_linear_algebra_table_get(s : MathlinearalgebraTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_table_set(s : MathlinearalgebraTable, i : Int, v : Double) -> MathlinearalgebraTable {
  let result = math_linear_algebra_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_algebra_table_sum(s : MathlinearalgebraTable) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_table_mean(s : MathlinearalgebraTable) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_table_scale(s : MathlinearalgebraTable, f : Double) -> MathlinearalgebraTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_table_add(a : MathlinearalgebraTable, b : MathlinearalgebraTable) -> MathlinearalgebraTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_table_copy(s : MathlinearalgebraTable) -> MathlinearalgebraTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_table_fill(s : MathlinearalgebraTable, v : Double) -> MathlinearalgebraTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_table_min(s : MathlinearalgebraTable) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_table_max(s : MathlinearalgebraTable) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_table_to_string(s : MathlinearalgebraTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_graphn_make(size : Int) -> MathlinearalgebraGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_graphn_len(s : MathlinearalgebraGraphN) -> Int { s.size }

pub fn math_linear_algebra_graphn_get(s : MathlinearalgebraGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_graphn_set(s : MathlinearalgebraGraphN, i : Int, v : Double) -> MathlinearalgebraGraphN {
  let result = math_linear_algebra_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_algebra_graphn_sum(s : MathlinearalgebraGraphN) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_graphn_mean(s : MathlinearalgebraGraphN) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_graphn_scale(s : MathlinearalgebraGraphN, f : Double) -> MathlinearalgebraGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_graphn_add(a : MathlinearalgebraGraphN, b : MathlinearalgebraGraphN) -> MathlinearalgebraGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_graphn_copy(s : MathlinearalgebraGraphN) -> MathlinearalgebraGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_graphn_fill(s : MathlinearalgebraGraphN, v : Double) -> MathlinearalgebraGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_graphn_min(s : MathlinearalgebraGraphN) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_graphn_max(s : MathlinearalgebraGraphN) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_graphn_to_string(s : MathlinearalgebraGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_node_make(size : Int) -> MathlinearalgebraNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_node_len(s : MathlinearalgebraNode) -> Int { s.size }

pub fn math_linear_algebra_node_get(s : MathlinearalgebraNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_node_set(s : MathlinearalgebraNode, i : Int, v : Double) -> MathlinearalgebraNode {
  let result = math_linear_algebra_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_algebra_node_sum(s : MathlinearalgebraNode) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_node_mean(s : MathlinearalgebraNode) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_node_scale(s : MathlinearalgebraNode, f : Double) -> MathlinearalgebraNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_node_add(a : MathlinearalgebraNode, b : MathlinearalgebraNode) -> MathlinearalgebraNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_node_copy(s : MathlinearalgebraNode) -> MathlinearalgebraNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_node_fill(s : MathlinearalgebraNode, v : Double) -> MathlinearalgebraNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_node_min(s : MathlinearalgebraNode) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_node_max(s : MathlinearalgebraNode) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_node_to_string(s : MathlinearalgebraNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_edge_make(size : Int) -> MathlinearalgebraEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_edge_len(s : MathlinearalgebraEdge) -> Int { s.size }

pub fn math_linear_algebra_edge_get(s : MathlinearalgebraEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_edge_set(s : MathlinearalgebraEdge, i : Int, v : Double) -> MathlinearalgebraEdge {
  let result = math_linear_algebra_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_algebra_edge_sum(s : MathlinearalgebraEdge) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_edge_mean(s : MathlinearalgebraEdge) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_edge_scale(s : MathlinearalgebraEdge, f : Double) -> MathlinearalgebraEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_edge_add(a : MathlinearalgebraEdge, b : MathlinearalgebraEdge) -> MathlinearalgebraEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_edge_copy(s : MathlinearalgebraEdge) -> MathlinearalgebraEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_edge_fill(s : MathlinearalgebraEdge, v : Double) -> MathlinearalgebraEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_edge_min(s : MathlinearalgebraEdge) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_edge_max(s : MathlinearalgebraEdge) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_edge_to_string(s : MathlinearalgebraEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_path_make(size : Int) -> MathlinearalgebraPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_path_len(s : MathlinearalgebraPath) -> Int { s.size }

pub fn math_linear_algebra_path_get(s : MathlinearalgebraPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_path_set(s : MathlinearalgebraPath, i : Int, v : Double) -> MathlinearalgebraPath {
  let result = math_linear_algebra_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_algebra_path_sum(s : MathlinearalgebraPath) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_path_mean(s : MathlinearalgebraPath) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_path_scale(s : MathlinearalgebraPath, f : Double) -> MathlinearalgebraPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_path_add(a : MathlinearalgebraPath, b : MathlinearalgebraPath) -> MathlinearalgebraPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_path_copy(s : MathlinearalgebraPath) -> MathlinearalgebraPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_path_fill(s : MathlinearalgebraPath, v : Double) -> MathlinearalgebraPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_path_min(s : MathlinearalgebraPath) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_path_max(s : MathlinearalgebraPath) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_path_to_string(s : MathlinearalgebraPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_cluster_make(size : Int) -> MathlinearalgebraCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_cluster_len(s : MathlinearalgebraCluster) -> Int { s.size }

pub fn math_linear_algebra_cluster_get(s : MathlinearalgebraCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_cluster_set(s : MathlinearalgebraCluster, i : Int, v : Double) -> MathlinearalgebraCluster {
  let result = math_linear_algebra_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_algebra_cluster_sum(s : MathlinearalgebraCluster) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_cluster_mean(s : MathlinearalgebraCluster) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_cluster_scale(s : MathlinearalgebraCluster, f : Double) -> MathlinearalgebraCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_cluster_add(a : MathlinearalgebraCluster, b : MathlinearalgebraCluster) -> MathlinearalgebraCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_cluster_copy(s : MathlinearalgebraCluster) -> MathlinearalgebraCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_cluster_fill(s : MathlinearalgebraCluster, v : Double) -> MathlinearalgebraCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_cluster_min(s : MathlinearalgebraCluster) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_cluster_max(s : MathlinearalgebraCluster) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_cluster_to_string(s : MathlinearalgebraCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_model_make(size : Int) -> MathlinearalgebraModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_model_len(s : MathlinearalgebraModel) -> Int { s.size }

pub fn math_linear_algebra_model_get(s : MathlinearalgebraModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_model_set(s : MathlinearalgebraModel, i : Int, v : Double) -> MathlinearalgebraModel {
  let result = math_linear_algebra_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_algebra_model_sum(s : MathlinearalgebraModel) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_model_mean(s : MathlinearalgebraModel) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_model_scale(s : MathlinearalgebraModel, f : Double) -> MathlinearalgebraModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_model_add(a : MathlinearalgebraModel, b : MathlinearalgebraModel) -> MathlinearalgebraModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_model_copy(s : MathlinearalgebraModel) -> MathlinearalgebraModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_model_fill(s : MathlinearalgebraModel, v : Double) -> MathlinearalgebraModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_model_min(s : MathlinearalgebraModel) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_model_max(s : MathlinearalgebraModel) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_model_to_string(s : MathlinearalgebraModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_layer_make(size : Int) -> MathlinearalgebraLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_layer_len(s : MathlinearalgebraLayer) -> Int { s.size }

pub fn math_linear_algebra_layer_get(s : MathlinearalgebraLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_layer_set(s : MathlinearalgebraLayer, i : Int, v : Double) -> MathlinearalgebraLayer {
  let result = math_linear_algebra_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_algebra_layer_sum(s : MathlinearalgebraLayer) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_layer_mean(s : MathlinearalgebraLayer) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_layer_scale(s : MathlinearalgebraLayer, f : Double) -> MathlinearalgebraLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_layer_add(a : MathlinearalgebraLayer, b : MathlinearalgebraLayer) -> MathlinearalgebraLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_layer_copy(s : MathlinearalgebraLayer) -> MathlinearalgebraLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_layer_fill(s : MathlinearalgebraLayer, v : Double) -> MathlinearalgebraLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_layer_min(s : MathlinearalgebraLayer) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_layer_max(s : MathlinearalgebraLayer) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_layer_to_string(s : MathlinearalgebraLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_buffer_make(size : Int) -> MathlinearalgebraBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_buffer_len(s : MathlinearalgebraBuffer) -> Int { s.size }

pub fn math_linear_algebra_buffer_get(s : MathlinearalgebraBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_buffer_set(s : MathlinearalgebraBuffer, i : Int, v : Double) -> MathlinearalgebraBuffer {
  let result = math_linear_algebra_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_algebra_buffer_sum(s : MathlinearalgebraBuffer) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_buffer_mean(s : MathlinearalgebraBuffer) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_buffer_scale(s : MathlinearalgebraBuffer, f : Double) -> MathlinearalgebraBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_buffer_add(a : MathlinearalgebraBuffer, b : MathlinearalgebraBuffer) -> MathlinearalgebraBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_buffer_copy(s : MathlinearalgebraBuffer) -> MathlinearalgebraBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_buffer_fill(s : MathlinearalgebraBuffer, v : Double) -> MathlinearalgebraBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_buffer_min(s : MathlinearalgebraBuffer) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_buffer_max(s : MathlinearalgebraBuffer) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_buffer_to_string(s : MathlinearalgebraBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_cursor_make(size : Int) -> MathlinearalgebraCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_cursor_len(s : MathlinearalgebraCursor) -> Int { s.size }

pub fn math_linear_algebra_cursor_get(s : MathlinearalgebraCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_cursor_set(s : MathlinearalgebraCursor, i : Int, v : Double) -> MathlinearalgebraCursor {
  let result = math_linear_algebra_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_algebra_cursor_sum(s : MathlinearalgebraCursor) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_cursor_mean(s : MathlinearalgebraCursor) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_cursor_scale(s : MathlinearalgebraCursor, f : Double) -> MathlinearalgebraCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_cursor_add(a : MathlinearalgebraCursor, b : MathlinearalgebraCursor) -> MathlinearalgebraCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_cursor_copy(s : MathlinearalgebraCursor) -> MathlinearalgebraCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_cursor_fill(s : MathlinearalgebraCursor, v : Double) -> MathlinearalgebraCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_cursor_min(s : MathlinearalgebraCursor) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_cursor_max(s : MathlinearalgebraCursor) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_cursor_to_string(s : MathlinearalgebraCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_view_make(size : Int) -> MathlinearalgebraView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_view_len(s : MathlinearalgebraView) -> Int { s.size }

pub fn math_linear_algebra_view_get(s : MathlinearalgebraView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_view_set(s : MathlinearalgebraView, i : Int, v : Double) -> MathlinearalgebraView {
  let result = math_linear_algebra_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_algebra_view_sum(s : MathlinearalgebraView) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_view_mean(s : MathlinearalgebraView) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_view_scale(s : MathlinearalgebraView, f : Double) -> MathlinearalgebraView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_view_add(a : MathlinearalgebraView, b : MathlinearalgebraView) -> MathlinearalgebraView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_view_copy(s : MathlinearalgebraView) -> MathlinearalgebraView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_view_fill(s : MathlinearalgebraView, v : Double) -> MathlinearalgebraView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_view_min(s : MathlinearalgebraView) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_view_max(s : MathlinearalgebraView) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_view_to_string(s : MathlinearalgebraView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_range_make(size : Int) -> MathlinearalgebraRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_range_len(s : MathlinearalgebraRange) -> Int { s.size }

pub fn math_linear_algebra_range_get(s : MathlinearalgebraRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_range_set(s : MathlinearalgebraRange, i : Int, v : Double) -> MathlinearalgebraRange {
  let result = math_linear_algebra_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_algebra_range_sum(s : MathlinearalgebraRange) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_range_mean(s : MathlinearalgebraRange) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_range_scale(s : MathlinearalgebraRange, f : Double) -> MathlinearalgebraRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_range_add(a : MathlinearalgebraRange, b : MathlinearalgebraRange) -> MathlinearalgebraRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_range_copy(s : MathlinearalgebraRange) -> MathlinearalgebraRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_range_fill(s : MathlinearalgebraRange, v : Double) -> MathlinearalgebraRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_range_min(s : MathlinearalgebraRange) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_range_max(s : MathlinearalgebraRange) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_range_to_string(s : MathlinearalgebraRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearalgebraSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_algebra_slice_make(size : Int) -> MathlinearalgebraSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_algebra_slice_len(s : MathlinearalgebraSlice) -> Int { s.size }

pub fn math_linear_algebra_slice_get(s : MathlinearalgebraSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_algebra_slice_set(s : MathlinearalgebraSlice, i : Int, v : Double) -> MathlinearalgebraSlice {
  let result = math_linear_algebra_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_linear_algebra_slice_sum(s : MathlinearalgebraSlice) -> Double { @_common.sum(s.data) }

pub fn math_linear_algebra_slice_mean(s : MathlinearalgebraSlice) -> Double { @_common.mean(s.data) }

pub fn math_linear_algebra_slice_scale(s : MathlinearalgebraSlice, f : Double) -> MathlinearalgebraSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_slice_add(a : MathlinearalgebraSlice, b : MathlinearalgebraSlice) -> MathlinearalgebraSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_algebra_slice_copy(s : MathlinearalgebraSlice) -> MathlinearalgebraSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_slice_fill(s : MathlinearalgebraSlice, v : Double) -> MathlinearalgebraSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_algebra_slice_min(s : MathlinearalgebraSlice) -> Double { @_common.min(s.data) }

pub fn math_linear_algebra_slice_max(s : MathlinearalgebraSlice) -> Double { @_common.max(s.data) }

pub fn math_linear_algebra_slice_to_string(s : MathlinearalgebraSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

