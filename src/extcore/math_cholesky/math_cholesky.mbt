///===
/// extcore/math_cholesky

pub(all) struct MathcholeskyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_cholesky_make_point(x : Double, y : Double) -> MathcholeskyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_cholesky_make_point3(x : Double, y : Double, z : Double) -> MathcholeskyPoint {
  { x, y, z, label: 0 }
}

pub fn math_cholesky_point_x(pt : MathcholeskyPoint) -> Double { pt.x }

pub fn math_cholesky_point_y(pt : MathcholeskyPoint) -> Double { pt.y }

pub fn math_cholesky_point_z(pt : MathcholeskyPoint) -> Double { pt.z }

pub fn math_cholesky_point_label(pt : MathcholeskyPoint) -> Int { pt.label }

pub fn math_cholesky_point_dist(a : MathcholeskyPoint, b : MathcholeskyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_cholesky_point_add(a : MathcholeskyPoint, b : MathcholeskyPoint) -> MathcholeskyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_cholesky_point_sub(a : MathcholeskyPoint, b : MathcholeskyPoint) -> MathcholeskyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_cholesky_point_scale(pt : MathcholeskyPoint, s : Double) -> MathcholeskyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_cholesky_point_dot(a : MathcholeskyPoint, b : MathcholeskyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_cholesky_point_cross(a : MathcholeskyPoint, b : MathcholeskyPoint) -> MathcholeskyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_cholesky_point_norm(pt : MathcholeskyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_cholesky_point_normalize(pt : MathcholeskyPoint) -> MathcholeskyPoint {
  let n = math_cholesky_point_norm(pt)
  if n < 0.0000001 { pt } else { math_cholesky_point_scale(pt, 1.0 / n) }
}

pub fn math_cholesky_point_negate(pt : MathcholeskyPoint) -> MathcholeskyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_cholesky_point_mid(a : MathcholeskyPoint, b : MathcholeskyPoint) -> MathcholeskyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_cholesky_point_lerp(a : MathcholeskyPoint, b : MathcholeskyPoint, t : Double) -> MathcholeskyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_cholesky_point_to_string(pt : MathcholeskyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathcholeskySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_cholesky_make_series(vals : Array[Double], name : String) -> MathcholeskySeries {
  { vals, name, meta: 0 }
}

pub fn math_cholesky_series_len(s : MathcholeskySeries) -> Int { s.vals.length() }

pub fn math_cholesky_series_sum(s : MathcholeskySeries) -> Double { @_common.sum(s.vals) }

pub fn math_cholesky_series_mean(s : MathcholeskySeries) -> Double { @_common.mean(s.vals) }

pub fn math_cholesky_series_min(s : MathcholeskySeries) -> Double { @_common.min(s.vals) }

pub fn math_cholesky_series_max(s : MathcholeskySeries) -> Double { @_common.max(s.vals) }

pub fn math_cholesky_series_range(s : MathcholeskySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_cholesky_series_var(s : MathcholeskySeries) -> Double { @_common.variance(s.vals) }

pub fn math_cholesky_series_std(s : MathcholeskySeries) -> Double { @_common.std(s.vals) }

pub fn math_cholesky_series_median(s : MathcholeskySeries) -> Double { @_common.median(s.vals) }

pub fn math_cholesky_series_scale(s : MathcholeskySeries, f : Double) -> MathcholeskySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_cholesky_series_add(a : MathcholeskySeries, b : MathcholeskySeries) -> MathcholeskySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_cholesky_series_sub(a : MathcholeskySeries, b : MathcholeskySeries) -> MathcholeskySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_cholesky_series_normalize(s : MathcholeskySeries) -> MathcholeskySeries {
  let mn = math_cholesky_series_min(s)
  let mx = math_cholesky_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_cholesky_series_cumsum(s : MathcholeskySeries) -> MathcholeskySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_cholesky_series_to_string(s : MathcholeskySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathcholeskyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_cholesky_make_matrix(rows : Int, cols : Int, val : Double) -> MathcholeskyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_cholesky_matrix_identity(n : Int) -> MathcholeskyMatrix {
  let m = math_cholesky_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_cholesky_matrix_get(m : MathcholeskyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_cholesky_matrix_transpose(m : MathcholeskyMatrix) -> MathcholeskyMatrix {
  let result = math_cholesky_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_cholesky_matrix_add(a : MathcholeskyMatrix, b : MathcholeskyMatrix) -> MathcholeskyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_cholesky_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_cholesky_matrix_scale(m : MathcholeskyMatrix, s : Double) -> MathcholeskyMatrix {
  let result = math_cholesky_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_cholesky_matrix_multiply(a : MathcholeskyMatrix, b : MathcholeskyMatrix) -> MathcholeskyMatrix {
  if a.cols != b.rows { return math_cholesky_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_cholesky_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_cholesky_matrix_trace(m : MathcholeskyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_cholesky_matrix_det(m : MathcholeskyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_cholesky_matrix_norm(m : MathcholeskyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_cholesky_matrix_to_string(m : MathcholeskyMatrix) -> String {
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

pub(all) struct MathcholeskyVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_cholesky_make_vector(comps : Array[Double]) -> MathcholeskyVector {
  { comps, dim: comps.length() }
}

pub fn math_cholesky_vector_zero(dim : Int) -> MathcholeskyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_cholesky_vector_add(a : MathcholeskyVector, b : MathcholeskyVector) -> MathcholeskyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_cholesky_vector_sub(a : MathcholeskyVector, b : MathcholeskyVector) -> MathcholeskyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_cholesky_vector_scale(v : MathcholeskyVector, s : Double) -> MathcholeskyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_cholesky_vector_dot(a : MathcholeskyVector, b : MathcholeskyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_cholesky_vector_norm(v : MathcholeskyVector) -> Double { @_common.sqrt(math_cholesky_vector_dot(v, v)) }

pub fn math_cholesky_vector_normalize(v : MathcholeskyVector) -> MathcholeskyVector {
  let n = math_cholesky_vector_norm(v)
  if n < 0.0000001 { v } else { math_cholesky_vector_scale(v, 1.0 / n) }
}

pub fn math_cholesky_vector_dist(a : MathcholeskyVector, b : MathcholeskyVector) -> Double {
  math_cholesky_vector_norm(math_cholesky_vector_sub(a, b))
}

pub fn math_cholesky_vector_to_string(v : MathcholeskyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_cholesky_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_cholesky_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_cholesky_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_cholesky_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_cholesky_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_cholesky_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_cholesky_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_cholesky_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_cholesky_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_cholesky_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_cholesky_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_cholesky_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_cholesky_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_cholesky_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_cholesky_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_cholesky_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_cholesky_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_cholesky_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_cholesky_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_cholesky_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_cholesky_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_cholesky_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_cholesky_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_cholesky_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_cholesky_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_cholesky_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_cholesky_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_cholesky_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_cholesky_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathcholeskyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_frame_make(size : Int) -> MathcholeskyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_frame_len(s : MathcholeskyFrame) -> Int { s.size }

pub fn math_cholesky_frame_get(s : MathcholeskyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_frame_set(s : MathcholeskyFrame, i : Int, v : Double) -> MathcholeskyFrame {
  let result = math_cholesky_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_cholesky_frame_sum(s : MathcholeskyFrame) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_frame_mean(s : MathcholeskyFrame) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_frame_scale(s : MathcholeskyFrame, f : Double) -> MathcholeskyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_frame_add(a : MathcholeskyFrame, b : MathcholeskyFrame) -> MathcholeskyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_frame_copy(s : MathcholeskyFrame) -> MathcholeskyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_frame_fill(s : MathcholeskyFrame, v : Double) -> MathcholeskyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_frame_min(s : MathcholeskyFrame) -> Double { @_common.min(s.data) }

pub fn math_cholesky_frame_max(s : MathcholeskyFrame) -> Double { @_common.max(s.data) }

pub fn math_cholesky_frame_to_string(s : MathcholeskyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_table_make(size : Int) -> MathcholeskyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_table_len(s : MathcholeskyTable) -> Int { s.size }

pub fn math_cholesky_table_get(s : MathcholeskyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_table_set(s : MathcholeskyTable, i : Int, v : Double) -> MathcholeskyTable {
  let result = math_cholesky_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_cholesky_table_sum(s : MathcholeskyTable) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_table_mean(s : MathcholeskyTable) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_table_scale(s : MathcholeskyTable, f : Double) -> MathcholeskyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_table_add(a : MathcholeskyTable, b : MathcholeskyTable) -> MathcholeskyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_table_copy(s : MathcholeskyTable) -> MathcholeskyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_table_fill(s : MathcholeskyTable, v : Double) -> MathcholeskyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_table_min(s : MathcholeskyTable) -> Double { @_common.min(s.data) }

pub fn math_cholesky_table_max(s : MathcholeskyTable) -> Double { @_common.max(s.data) }

pub fn math_cholesky_table_to_string(s : MathcholeskyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_graphn_make(size : Int) -> MathcholeskyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_graphn_len(s : MathcholeskyGraphN) -> Int { s.size }

pub fn math_cholesky_graphn_get(s : MathcholeskyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_graphn_set(s : MathcholeskyGraphN, i : Int, v : Double) -> MathcholeskyGraphN {
  let result = math_cholesky_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_cholesky_graphn_sum(s : MathcholeskyGraphN) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_graphn_mean(s : MathcholeskyGraphN) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_graphn_scale(s : MathcholeskyGraphN, f : Double) -> MathcholeskyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_graphn_add(a : MathcholeskyGraphN, b : MathcholeskyGraphN) -> MathcholeskyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_graphn_copy(s : MathcholeskyGraphN) -> MathcholeskyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_graphn_fill(s : MathcholeskyGraphN, v : Double) -> MathcholeskyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_graphn_min(s : MathcholeskyGraphN) -> Double { @_common.min(s.data) }

pub fn math_cholesky_graphn_max(s : MathcholeskyGraphN) -> Double { @_common.max(s.data) }

pub fn math_cholesky_graphn_to_string(s : MathcholeskyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_node_make(size : Int) -> MathcholeskyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_node_len(s : MathcholeskyNode) -> Int { s.size }

pub fn math_cholesky_node_get(s : MathcholeskyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_node_set(s : MathcholeskyNode, i : Int, v : Double) -> MathcholeskyNode {
  let result = math_cholesky_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_cholesky_node_sum(s : MathcholeskyNode) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_node_mean(s : MathcholeskyNode) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_node_scale(s : MathcholeskyNode, f : Double) -> MathcholeskyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_node_add(a : MathcholeskyNode, b : MathcholeskyNode) -> MathcholeskyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_node_copy(s : MathcholeskyNode) -> MathcholeskyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_node_fill(s : MathcholeskyNode, v : Double) -> MathcholeskyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_node_min(s : MathcholeskyNode) -> Double { @_common.min(s.data) }

pub fn math_cholesky_node_max(s : MathcholeskyNode) -> Double { @_common.max(s.data) }

pub fn math_cholesky_node_to_string(s : MathcholeskyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_edge_make(size : Int) -> MathcholeskyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_edge_len(s : MathcholeskyEdge) -> Int { s.size }

pub fn math_cholesky_edge_get(s : MathcholeskyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_edge_set(s : MathcholeskyEdge, i : Int, v : Double) -> MathcholeskyEdge {
  let result = math_cholesky_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_cholesky_edge_sum(s : MathcholeskyEdge) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_edge_mean(s : MathcholeskyEdge) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_edge_scale(s : MathcholeskyEdge, f : Double) -> MathcholeskyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_edge_add(a : MathcholeskyEdge, b : MathcholeskyEdge) -> MathcholeskyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_edge_copy(s : MathcholeskyEdge) -> MathcholeskyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_edge_fill(s : MathcholeskyEdge, v : Double) -> MathcholeskyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_edge_min(s : MathcholeskyEdge) -> Double { @_common.min(s.data) }

pub fn math_cholesky_edge_max(s : MathcholeskyEdge) -> Double { @_common.max(s.data) }

pub fn math_cholesky_edge_to_string(s : MathcholeskyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_path_make(size : Int) -> MathcholeskyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_path_len(s : MathcholeskyPath) -> Int { s.size }

pub fn math_cholesky_path_get(s : MathcholeskyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_path_set(s : MathcholeskyPath, i : Int, v : Double) -> MathcholeskyPath {
  let result = math_cholesky_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_cholesky_path_sum(s : MathcholeskyPath) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_path_mean(s : MathcholeskyPath) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_path_scale(s : MathcholeskyPath, f : Double) -> MathcholeskyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_path_add(a : MathcholeskyPath, b : MathcholeskyPath) -> MathcholeskyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_path_copy(s : MathcholeskyPath) -> MathcholeskyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_path_fill(s : MathcholeskyPath, v : Double) -> MathcholeskyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_path_min(s : MathcholeskyPath) -> Double { @_common.min(s.data) }

pub fn math_cholesky_path_max(s : MathcholeskyPath) -> Double { @_common.max(s.data) }

pub fn math_cholesky_path_to_string(s : MathcholeskyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_cluster_make(size : Int) -> MathcholeskyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_cluster_len(s : MathcholeskyCluster) -> Int { s.size }

pub fn math_cholesky_cluster_get(s : MathcholeskyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_cluster_set(s : MathcholeskyCluster, i : Int, v : Double) -> MathcholeskyCluster {
  let result = math_cholesky_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_cholesky_cluster_sum(s : MathcholeskyCluster) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_cluster_mean(s : MathcholeskyCluster) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_cluster_scale(s : MathcholeskyCluster, f : Double) -> MathcholeskyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_cluster_add(a : MathcholeskyCluster, b : MathcholeskyCluster) -> MathcholeskyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_cluster_copy(s : MathcholeskyCluster) -> MathcholeskyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_cluster_fill(s : MathcholeskyCluster, v : Double) -> MathcholeskyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_cluster_min(s : MathcholeskyCluster) -> Double { @_common.min(s.data) }

pub fn math_cholesky_cluster_max(s : MathcholeskyCluster) -> Double { @_common.max(s.data) }

pub fn math_cholesky_cluster_to_string(s : MathcholeskyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_model_make(size : Int) -> MathcholeskyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_model_len(s : MathcholeskyModel) -> Int { s.size }

pub fn math_cholesky_model_get(s : MathcholeskyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_model_set(s : MathcholeskyModel, i : Int, v : Double) -> MathcholeskyModel {
  let result = math_cholesky_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_cholesky_model_sum(s : MathcholeskyModel) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_model_mean(s : MathcholeskyModel) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_model_scale(s : MathcholeskyModel, f : Double) -> MathcholeskyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_model_add(a : MathcholeskyModel, b : MathcholeskyModel) -> MathcholeskyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_model_copy(s : MathcholeskyModel) -> MathcholeskyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_model_fill(s : MathcholeskyModel, v : Double) -> MathcholeskyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_model_min(s : MathcholeskyModel) -> Double { @_common.min(s.data) }

pub fn math_cholesky_model_max(s : MathcholeskyModel) -> Double { @_common.max(s.data) }

pub fn math_cholesky_model_to_string(s : MathcholeskyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_layer_make(size : Int) -> MathcholeskyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_layer_len(s : MathcholeskyLayer) -> Int { s.size }

pub fn math_cholesky_layer_get(s : MathcholeskyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_layer_set(s : MathcholeskyLayer, i : Int, v : Double) -> MathcholeskyLayer {
  let result = math_cholesky_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_cholesky_layer_sum(s : MathcholeskyLayer) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_layer_mean(s : MathcholeskyLayer) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_layer_scale(s : MathcholeskyLayer, f : Double) -> MathcholeskyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_layer_add(a : MathcholeskyLayer, b : MathcholeskyLayer) -> MathcholeskyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_layer_copy(s : MathcholeskyLayer) -> MathcholeskyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_layer_fill(s : MathcholeskyLayer, v : Double) -> MathcholeskyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_layer_min(s : MathcholeskyLayer) -> Double { @_common.min(s.data) }

pub fn math_cholesky_layer_max(s : MathcholeskyLayer) -> Double { @_common.max(s.data) }

pub fn math_cholesky_layer_to_string(s : MathcholeskyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_buffer_make(size : Int) -> MathcholeskyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_buffer_len(s : MathcholeskyBuffer) -> Int { s.size }

pub fn math_cholesky_buffer_get(s : MathcholeskyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_buffer_set(s : MathcholeskyBuffer, i : Int, v : Double) -> MathcholeskyBuffer {
  let result = math_cholesky_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_cholesky_buffer_sum(s : MathcholeskyBuffer) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_buffer_mean(s : MathcholeskyBuffer) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_buffer_scale(s : MathcholeskyBuffer, f : Double) -> MathcholeskyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_buffer_add(a : MathcholeskyBuffer, b : MathcholeskyBuffer) -> MathcholeskyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_buffer_copy(s : MathcholeskyBuffer) -> MathcholeskyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_buffer_fill(s : MathcholeskyBuffer, v : Double) -> MathcholeskyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_buffer_min(s : MathcholeskyBuffer) -> Double { @_common.min(s.data) }

pub fn math_cholesky_buffer_max(s : MathcholeskyBuffer) -> Double { @_common.max(s.data) }

pub fn math_cholesky_buffer_to_string(s : MathcholeskyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_cursor_make(size : Int) -> MathcholeskyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_cursor_len(s : MathcholeskyCursor) -> Int { s.size }

pub fn math_cholesky_cursor_get(s : MathcholeskyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_cursor_set(s : MathcholeskyCursor, i : Int, v : Double) -> MathcholeskyCursor {
  let result = math_cholesky_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_cholesky_cursor_sum(s : MathcholeskyCursor) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_cursor_mean(s : MathcholeskyCursor) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_cursor_scale(s : MathcholeskyCursor, f : Double) -> MathcholeskyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_cursor_add(a : MathcholeskyCursor, b : MathcholeskyCursor) -> MathcholeskyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_cursor_copy(s : MathcholeskyCursor) -> MathcholeskyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_cursor_fill(s : MathcholeskyCursor, v : Double) -> MathcholeskyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_cursor_min(s : MathcholeskyCursor) -> Double { @_common.min(s.data) }

pub fn math_cholesky_cursor_max(s : MathcholeskyCursor) -> Double { @_common.max(s.data) }

pub fn math_cholesky_cursor_to_string(s : MathcholeskyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_view_make(size : Int) -> MathcholeskyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_view_len(s : MathcholeskyView) -> Int { s.size }

pub fn math_cholesky_view_get(s : MathcholeskyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_view_set(s : MathcholeskyView, i : Int, v : Double) -> MathcholeskyView {
  let result = math_cholesky_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_cholesky_view_sum(s : MathcholeskyView) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_view_mean(s : MathcholeskyView) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_view_scale(s : MathcholeskyView, f : Double) -> MathcholeskyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_view_add(a : MathcholeskyView, b : MathcholeskyView) -> MathcholeskyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_view_copy(s : MathcholeskyView) -> MathcholeskyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_view_fill(s : MathcholeskyView, v : Double) -> MathcholeskyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_view_min(s : MathcholeskyView) -> Double { @_common.min(s.data) }

pub fn math_cholesky_view_max(s : MathcholeskyView) -> Double { @_common.max(s.data) }

pub fn math_cholesky_view_to_string(s : MathcholeskyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_range_make(size : Int) -> MathcholeskyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_range_len(s : MathcholeskyRange) -> Int { s.size }

pub fn math_cholesky_range_get(s : MathcholeskyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_range_set(s : MathcholeskyRange, i : Int, v : Double) -> MathcholeskyRange {
  let result = math_cholesky_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_cholesky_range_sum(s : MathcholeskyRange) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_range_mean(s : MathcholeskyRange) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_range_scale(s : MathcholeskyRange, f : Double) -> MathcholeskyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_range_add(a : MathcholeskyRange, b : MathcholeskyRange) -> MathcholeskyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_range_copy(s : MathcholeskyRange) -> MathcholeskyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_range_fill(s : MathcholeskyRange, v : Double) -> MathcholeskyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_range_min(s : MathcholeskyRange) -> Double { @_common.min(s.data) }

pub fn math_cholesky_range_max(s : MathcholeskyRange) -> Double { @_common.max(s.data) }

pub fn math_cholesky_range_to_string(s : MathcholeskyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathcholeskySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_cholesky_slice_make(size : Int) -> MathcholeskySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_cholesky_slice_len(s : MathcholeskySlice) -> Int { s.size }

pub fn math_cholesky_slice_get(s : MathcholeskySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_cholesky_slice_set(s : MathcholeskySlice, i : Int, v : Double) -> MathcholeskySlice {
  let result = math_cholesky_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_cholesky_slice_sum(s : MathcholeskySlice) -> Double { @_common.sum(s.data) }

pub fn math_cholesky_slice_mean(s : MathcholeskySlice) -> Double { @_common.mean(s.data) }

pub fn math_cholesky_slice_scale(s : MathcholeskySlice, f : Double) -> MathcholeskySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_cholesky_slice_add(a : MathcholeskySlice, b : MathcholeskySlice) -> MathcholeskySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_cholesky_slice_copy(s : MathcholeskySlice) -> MathcholeskySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_cholesky_slice_fill(s : MathcholeskySlice, v : Double) -> MathcholeskySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_cholesky_slice_min(s : MathcholeskySlice) -> Double { @_common.min(s.data) }

pub fn math_cholesky_slice_max(s : MathcholeskySlice) -> Double { @_common.max(s.data) }

pub fn math_cholesky_slice_to_string(s : MathcholeskySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

