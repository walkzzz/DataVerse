///===
/// extcore/math_approx_rational

pub(all) struct MathapproxrationalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_rational_make_point(x : Double, y : Double) -> MathapproxrationalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_rational_make_point3(x : Double, y : Double, z : Double) -> MathapproxrationalPoint {
  { x, y, z, label: 0 }
}

pub fn math_approx_rational_point_x(pt : MathapproxrationalPoint) -> Double { pt.x }

pub fn math_approx_rational_point_y(pt : MathapproxrationalPoint) -> Double { pt.y }

pub fn math_approx_rational_point_z(pt : MathapproxrationalPoint) -> Double { pt.z }

pub fn math_approx_rational_point_label(pt : MathapproxrationalPoint) -> Int { pt.label }

pub fn math_approx_rational_point_dist(a : MathapproxrationalPoint, b : MathapproxrationalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_approx_rational_point_add(a : MathapproxrationalPoint, b : MathapproxrationalPoint) -> MathapproxrationalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_approx_rational_point_sub(a : MathapproxrationalPoint, b : MathapproxrationalPoint) -> MathapproxrationalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_approx_rational_point_scale(pt : MathapproxrationalPoint, s : Double) -> MathapproxrationalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_approx_rational_point_dot(a : MathapproxrationalPoint, b : MathapproxrationalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_approx_rational_point_cross(a : MathapproxrationalPoint, b : MathapproxrationalPoint) -> MathapproxrationalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_approx_rational_point_norm(pt : MathapproxrationalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_approx_rational_point_normalize(pt : MathapproxrationalPoint) -> MathapproxrationalPoint {
  let n = math_approx_rational_point_norm(pt)
  if n < 0.0000001 { pt } else { math_approx_rational_point_scale(pt, 1.0 / n) }
}

pub fn math_approx_rational_point_negate(pt : MathapproxrationalPoint) -> MathapproxrationalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_approx_rational_point_mid(a : MathapproxrationalPoint, b : MathapproxrationalPoint) -> MathapproxrationalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_approx_rational_point_lerp(a : MathapproxrationalPoint, b : MathapproxrationalPoint, t : Double) -> MathapproxrationalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_approx_rational_point_to_string(pt : MathapproxrationalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathapproxrationalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_rational_make_series(vals : Array[Double], name : String) -> MathapproxrationalSeries {
  { vals, name, meta: 0 }
}

pub fn math_approx_rational_series_len(s : MathapproxrationalSeries) -> Int { s.vals.length() }

pub fn math_approx_rational_series_sum(s : MathapproxrationalSeries) -> Double { @_common.sum(s.vals) }

pub fn math_approx_rational_series_mean(s : MathapproxrationalSeries) -> Double { @_common.mean(s.vals) }

pub fn math_approx_rational_series_min(s : MathapproxrationalSeries) -> Double { @_common.min(s.vals) }

pub fn math_approx_rational_series_max(s : MathapproxrationalSeries) -> Double { @_common.max(s.vals) }

pub fn math_approx_rational_series_range(s : MathapproxrationalSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_approx_rational_series_var(s : MathapproxrationalSeries) -> Double { @_common.variance(s.vals) }

pub fn math_approx_rational_series_std(s : MathapproxrationalSeries) -> Double { @_common.std(s.vals) }

pub fn math_approx_rational_series_median(s : MathapproxrationalSeries) -> Double { @_common.median(s.vals) }

pub fn math_approx_rational_series_scale(s : MathapproxrationalSeries, f : Double) -> MathapproxrationalSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn math_approx_rational_series_add(a : MathapproxrationalSeries, b : MathapproxrationalSeries) -> MathapproxrationalSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_approx_rational_series_sub(a : MathapproxrationalSeries, b : MathapproxrationalSeries) -> MathapproxrationalSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_approx_rational_series_normalize(s : MathapproxrationalSeries) -> MathapproxrationalSeries {
  let mn = math_approx_rational_series_min(s)
  let mx = math_approx_rational_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_approx_rational_series_cumsum(s : MathapproxrationalSeries) -> MathapproxrationalSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_approx_rational_series_to_string(s : MathapproxrationalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxrationalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_rational_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxrationalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_rational_matrix_identity(n : Int) -> MathapproxrationalMatrix {
  let m = math_approx_rational_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_approx_rational_matrix_get(m : MathapproxrationalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_approx_rational_matrix_transpose(m : MathapproxrationalMatrix) -> MathapproxrationalMatrix {
  let result = math_approx_rational_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_approx_rational_matrix_add(a : MathapproxrationalMatrix, b : MathapproxrationalMatrix) -> MathapproxrationalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_approx_rational_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_approx_rational_matrix_scale(m : MathapproxrationalMatrix, s : Double) -> MathapproxrationalMatrix {
  let result = math_approx_rational_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_approx_rational_matrix_multiply(a : MathapproxrationalMatrix, b : MathapproxrationalMatrix) -> MathapproxrationalMatrix {
  if a.cols != b.rows { return math_approx_rational_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_approx_rational_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_approx_rational_matrix_trace(m : MathapproxrationalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_approx_rational_matrix_det(m : MathapproxrationalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_approx_rational_matrix_norm(m : MathapproxrationalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_approx_rational_matrix_to_string(m : MathapproxrationalMatrix) -> String {
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

pub(all) struct MathapproxrationalVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_rational_make_vector(comps : Array[Double]) -> MathapproxrationalVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_rational_vector_zero(dim : Int) -> MathapproxrationalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_approx_rational_vector_add(a : MathapproxrationalVector, b : MathapproxrationalVector) -> MathapproxrationalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn math_approx_rational_vector_sub(a : MathapproxrationalVector, b : MathapproxrationalVector) -> MathapproxrationalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn math_approx_rational_vector_scale(v : MathapproxrationalVector, s : Double) -> MathapproxrationalVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn math_approx_rational_vector_dot(a : MathapproxrationalVector, b : MathapproxrationalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_approx_rational_vector_norm(v : MathapproxrationalVector) -> Double { @_common.sqrt(math_approx_rational_vector_dot(v, v)) }

pub fn math_approx_rational_vector_normalize(v : MathapproxrationalVector) -> MathapproxrationalVector {
  let n = math_approx_rational_vector_norm(v)
  if n < 0.0000001 { v } else { math_approx_rational_vector_scale(v, 1.0 / n) }
}

pub fn math_approx_rational_vector_dist(a : MathapproxrationalVector, b : MathapproxrationalVector) -> Double {
  math_approx_rational_vector_norm(math_approx_rational_vector_sub(a, b))
}

pub fn math_approx_rational_vector_to_string(v : MathapproxrationalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_rational_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_approx_rational_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_approx_rational_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_approx_rational_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_approx_rational_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_approx_rational_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_approx_rational_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_approx_rational_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_approx_rational_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_approx_rational_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_approx_rational_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_approx_rational_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_approx_rational_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_approx_rational_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_approx_rational_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_approx_rational_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_approx_rational_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_approx_rational_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_approx_rational_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_approx_rational_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_approx_rational_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_approx_rational_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_approx_rational_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_approx_rational_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_approx_rational_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_approx_rational_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_approx_rational_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_approx_rational_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_approx_rational_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathapproxrationalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_frame_make(size : Int) -> MathapproxrationalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_frame_len(s : MathapproxrationalFrame) -> Int { s.size }

pub fn math_approx_rational_frame_get(s : MathapproxrationalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_frame_set(s : MathapproxrationalFrame, i : Int, v : Double) -> MathapproxrationalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_frame_sum(s : MathapproxrationalFrame) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_frame_mean(s : MathapproxrationalFrame) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_frame_scale(s : MathapproxrationalFrame, f : Double) -> MathapproxrationalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_frame_add(a : MathapproxrationalFrame, b : MathapproxrationalFrame) -> MathapproxrationalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_frame_copy(s : MathapproxrationalFrame) -> MathapproxrationalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_frame_fill(s : MathapproxrationalFrame, v : Double) -> MathapproxrationalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_frame_min(s : MathapproxrationalFrame) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_frame_max(s : MathapproxrationalFrame) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_frame_to_string(s : MathapproxrationalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_table_make(size : Int) -> MathapproxrationalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_table_len(s : MathapproxrationalTable) -> Int { s.size }

pub fn math_approx_rational_table_get(s : MathapproxrationalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_table_set(s : MathapproxrationalTable, i : Int, v : Double) -> MathapproxrationalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_table_sum(s : MathapproxrationalTable) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_table_mean(s : MathapproxrationalTable) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_table_scale(s : MathapproxrationalTable, f : Double) -> MathapproxrationalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_table_add(a : MathapproxrationalTable, b : MathapproxrationalTable) -> MathapproxrationalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_table_copy(s : MathapproxrationalTable) -> MathapproxrationalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_table_fill(s : MathapproxrationalTable, v : Double) -> MathapproxrationalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_table_min(s : MathapproxrationalTable) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_table_max(s : MathapproxrationalTable) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_table_to_string(s : MathapproxrationalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_graphn_make(size : Int) -> MathapproxrationalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_graphn_len(s : MathapproxrationalGraphN) -> Int { s.size }

pub fn math_approx_rational_graphn_get(s : MathapproxrationalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_graphn_set(s : MathapproxrationalGraphN, i : Int, v : Double) -> MathapproxrationalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_graphn_sum(s : MathapproxrationalGraphN) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_graphn_mean(s : MathapproxrationalGraphN) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_graphn_scale(s : MathapproxrationalGraphN, f : Double) -> MathapproxrationalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_graphn_add(a : MathapproxrationalGraphN, b : MathapproxrationalGraphN) -> MathapproxrationalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_graphn_copy(s : MathapproxrationalGraphN) -> MathapproxrationalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_graphn_fill(s : MathapproxrationalGraphN, v : Double) -> MathapproxrationalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_graphn_min(s : MathapproxrationalGraphN) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_graphn_max(s : MathapproxrationalGraphN) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_graphn_to_string(s : MathapproxrationalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_node_make(size : Int) -> MathapproxrationalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_node_len(s : MathapproxrationalNode) -> Int { s.size }

pub fn math_approx_rational_node_get(s : MathapproxrationalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_node_set(s : MathapproxrationalNode, i : Int, v : Double) -> MathapproxrationalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_node_sum(s : MathapproxrationalNode) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_node_mean(s : MathapproxrationalNode) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_node_scale(s : MathapproxrationalNode, f : Double) -> MathapproxrationalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_node_add(a : MathapproxrationalNode, b : MathapproxrationalNode) -> MathapproxrationalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_node_copy(s : MathapproxrationalNode) -> MathapproxrationalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_node_fill(s : MathapproxrationalNode, v : Double) -> MathapproxrationalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_node_min(s : MathapproxrationalNode) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_node_max(s : MathapproxrationalNode) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_node_to_string(s : MathapproxrationalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_edge_make(size : Int) -> MathapproxrationalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_edge_len(s : MathapproxrationalEdge) -> Int { s.size }

pub fn math_approx_rational_edge_get(s : MathapproxrationalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_edge_set(s : MathapproxrationalEdge, i : Int, v : Double) -> MathapproxrationalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_edge_sum(s : MathapproxrationalEdge) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_edge_mean(s : MathapproxrationalEdge) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_edge_scale(s : MathapproxrationalEdge, f : Double) -> MathapproxrationalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_edge_add(a : MathapproxrationalEdge, b : MathapproxrationalEdge) -> MathapproxrationalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_edge_copy(s : MathapproxrationalEdge) -> MathapproxrationalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_edge_fill(s : MathapproxrationalEdge, v : Double) -> MathapproxrationalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_edge_min(s : MathapproxrationalEdge) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_edge_max(s : MathapproxrationalEdge) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_edge_to_string(s : MathapproxrationalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_path_make(size : Int) -> MathapproxrationalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_path_len(s : MathapproxrationalPath) -> Int { s.size }

pub fn math_approx_rational_path_get(s : MathapproxrationalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_path_set(s : MathapproxrationalPath, i : Int, v : Double) -> MathapproxrationalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_path_sum(s : MathapproxrationalPath) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_path_mean(s : MathapproxrationalPath) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_path_scale(s : MathapproxrationalPath, f : Double) -> MathapproxrationalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_path_add(a : MathapproxrationalPath, b : MathapproxrationalPath) -> MathapproxrationalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_path_copy(s : MathapproxrationalPath) -> MathapproxrationalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_path_fill(s : MathapproxrationalPath, v : Double) -> MathapproxrationalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_path_min(s : MathapproxrationalPath) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_path_max(s : MathapproxrationalPath) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_path_to_string(s : MathapproxrationalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_cluster_make(size : Int) -> MathapproxrationalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_cluster_len(s : MathapproxrationalCluster) -> Int { s.size }

pub fn math_approx_rational_cluster_get(s : MathapproxrationalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_cluster_set(s : MathapproxrationalCluster, i : Int, v : Double) -> MathapproxrationalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_cluster_sum(s : MathapproxrationalCluster) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_cluster_mean(s : MathapproxrationalCluster) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_cluster_scale(s : MathapproxrationalCluster, f : Double) -> MathapproxrationalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_cluster_add(a : MathapproxrationalCluster, b : MathapproxrationalCluster) -> MathapproxrationalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_cluster_copy(s : MathapproxrationalCluster) -> MathapproxrationalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_cluster_fill(s : MathapproxrationalCluster, v : Double) -> MathapproxrationalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_cluster_min(s : MathapproxrationalCluster) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_cluster_max(s : MathapproxrationalCluster) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_cluster_to_string(s : MathapproxrationalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_model_make(size : Int) -> MathapproxrationalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_model_len(s : MathapproxrationalModel) -> Int { s.size }

pub fn math_approx_rational_model_get(s : MathapproxrationalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_model_set(s : MathapproxrationalModel, i : Int, v : Double) -> MathapproxrationalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_model_sum(s : MathapproxrationalModel) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_model_mean(s : MathapproxrationalModel) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_model_scale(s : MathapproxrationalModel, f : Double) -> MathapproxrationalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_model_add(a : MathapproxrationalModel, b : MathapproxrationalModel) -> MathapproxrationalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_model_copy(s : MathapproxrationalModel) -> MathapproxrationalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_model_fill(s : MathapproxrationalModel, v : Double) -> MathapproxrationalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_model_min(s : MathapproxrationalModel) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_model_max(s : MathapproxrationalModel) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_model_to_string(s : MathapproxrationalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_layer_make(size : Int) -> MathapproxrationalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_layer_len(s : MathapproxrationalLayer) -> Int { s.size }

pub fn math_approx_rational_layer_get(s : MathapproxrationalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_layer_set(s : MathapproxrationalLayer, i : Int, v : Double) -> MathapproxrationalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_layer_sum(s : MathapproxrationalLayer) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_layer_mean(s : MathapproxrationalLayer) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_layer_scale(s : MathapproxrationalLayer, f : Double) -> MathapproxrationalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_layer_add(a : MathapproxrationalLayer, b : MathapproxrationalLayer) -> MathapproxrationalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_layer_copy(s : MathapproxrationalLayer) -> MathapproxrationalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_layer_fill(s : MathapproxrationalLayer, v : Double) -> MathapproxrationalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_layer_min(s : MathapproxrationalLayer) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_layer_max(s : MathapproxrationalLayer) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_layer_to_string(s : MathapproxrationalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_buffer_make(size : Int) -> MathapproxrationalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_buffer_len(s : MathapproxrationalBuffer) -> Int { s.size }

pub fn math_approx_rational_buffer_get(s : MathapproxrationalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_buffer_set(s : MathapproxrationalBuffer, i : Int, v : Double) -> MathapproxrationalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_buffer_sum(s : MathapproxrationalBuffer) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_buffer_mean(s : MathapproxrationalBuffer) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_buffer_scale(s : MathapproxrationalBuffer, f : Double) -> MathapproxrationalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_buffer_add(a : MathapproxrationalBuffer, b : MathapproxrationalBuffer) -> MathapproxrationalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_buffer_copy(s : MathapproxrationalBuffer) -> MathapproxrationalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_buffer_fill(s : MathapproxrationalBuffer, v : Double) -> MathapproxrationalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_buffer_min(s : MathapproxrationalBuffer) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_buffer_max(s : MathapproxrationalBuffer) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_buffer_to_string(s : MathapproxrationalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_cursor_make(size : Int) -> MathapproxrationalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_cursor_len(s : MathapproxrationalCursor) -> Int { s.size }

pub fn math_approx_rational_cursor_get(s : MathapproxrationalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_cursor_set(s : MathapproxrationalCursor, i : Int, v : Double) -> MathapproxrationalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_cursor_sum(s : MathapproxrationalCursor) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_cursor_mean(s : MathapproxrationalCursor) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_cursor_scale(s : MathapproxrationalCursor, f : Double) -> MathapproxrationalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_cursor_add(a : MathapproxrationalCursor, b : MathapproxrationalCursor) -> MathapproxrationalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_cursor_copy(s : MathapproxrationalCursor) -> MathapproxrationalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_cursor_fill(s : MathapproxrationalCursor, v : Double) -> MathapproxrationalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_cursor_min(s : MathapproxrationalCursor) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_cursor_max(s : MathapproxrationalCursor) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_cursor_to_string(s : MathapproxrationalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_view_make(size : Int) -> MathapproxrationalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_view_len(s : MathapproxrationalView) -> Int { s.size }

pub fn math_approx_rational_view_get(s : MathapproxrationalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_view_set(s : MathapproxrationalView, i : Int, v : Double) -> MathapproxrationalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_view_sum(s : MathapproxrationalView) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_view_mean(s : MathapproxrationalView) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_view_scale(s : MathapproxrationalView, f : Double) -> MathapproxrationalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_view_add(a : MathapproxrationalView, b : MathapproxrationalView) -> MathapproxrationalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_view_copy(s : MathapproxrationalView) -> MathapproxrationalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_view_fill(s : MathapproxrationalView, v : Double) -> MathapproxrationalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_view_min(s : MathapproxrationalView) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_view_max(s : MathapproxrationalView) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_view_to_string(s : MathapproxrationalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_range_make(size : Int) -> MathapproxrationalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_range_len(s : MathapproxrationalRange) -> Int { s.size }

pub fn math_approx_rational_range_get(s : MathapproxrationalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_range_set(s : MathapproxrationalRange, i : Int, v : Double) -> MathapproxrationalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_range_sum(s : MathapproxrationalRange) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_range_mean(s : MathapproxrationalRange) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_range_scale(s : MathapproxrationalRange, f : Double) -> MathapproxrationalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_range_add(a : MathapproxrationalRange, b : MathapproxrationalRange) -> MathapproxrationalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_range_copy(s : MathapproxrationalRange) -> MathapproxrationalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_range_fill(s : MathapproxrationalRange, v : Double) -> MathapproxrationalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_range_min(s : MathapproxrationalRange) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_range_max(s : MathapproxrationalRange) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_range_to_string(s : MathapproxrationalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_slice_make(size : Int) -> MathapproxrationalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_rational_slice_len(s : MathapproxrationalSlice) -> Int { s.size }

pub fn math_approx_rational_slice_get(s : MathapproxrationalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_rational_slice_set(s : MathapproxrationalSlice, i : Int, v : Double) -> MathapproxrationalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_rational_slice_sum(s : MathapproxrationalSlice) -> Double { @_common.sum(s.data) }

pub fn math_approx_rational_slice_mean(s : MathapproxrationalSlice) -> Double { @_common.mean(s.data) }

pub fn math_approx_rational_slice_scale(s : MathapproxrationalSlice, f : Double) -> MathapproxrationalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_slice_add(a : MathapproxrationalSlice, b : MathapproxrationalSlice) -> MathapproxrationalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_rational_slice_copy(s : MathapproxrationalSlice) -> MathapproxrationalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_slice_fill(s : MathapproxrationalSlice, v : Double) -> MathapproxrationalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_rational_slice_min(s : MathapproxrationalSlice) -> Double { @_common.min(s.data) }

pub fn math_approx_rational_slice_max(s : MathapproxrationalSlice) -> Double { @_common.max(s.data) }

pub fn math_approx_rational_slice_to_string(s : MathapproxrationalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

