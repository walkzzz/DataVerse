///===
/// extcore/math_approx_spline

pub(all) struct MathapproxsplinePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_spline_make_point(x : Double, y : Double) -> MathapproxsplinePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_spline_make_point3(x : Double, y : Double, z : Double) -> MathapproxsplinePoint {
  { x, y, z, label: 0 }
}

pub fn math_approx_spline_point_x(pt : MathapproxsplinePoint) -> Double { pt.x }

pub fn math_approx_spline_point_y(pt : MathapproxsplinePoint) -> Double { pt.y }

pub fn math_approx_spline_point_z(pt : MathapproxsplinePoint) -> Double { pt.z }

pub fn math_approx_spline_point_label(pt : MathapproxsplinePoint) -> Int { pt.label }

pub fn math_approx_spline_point_dist(a : MathapproxsplinePoint, b : MathapproxsplinePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_approx_spline_point_add(a : MathapproxsplinePoint, b : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_approx_spline_point_sub(a : MathapproxsplinePoint, b : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_approx_spline_point_scale(pt : MathapproxsplinePoint, s : Double) -> MathapproxsplinePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_approx_spline_point_dot(a : MathapproxsplinePoint, b : MathapproxsplinePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_approx_spline_point_cross(a : MathapproxsplinePoint, b : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_approx_spline_point_norm(pt : MathapproxsplinePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_approx_spline_point_normalize(pt : MathapproxsplinePoint) -> MathapproxsplinePoint {
  let n = math_approx_spline_point_norm(pt)
  if n < 0.0000001 { pt } else { math_approx_spline_point_scale(pt, 1.0 / n) }
}

pub fn math_approx_spline_point_negate(pt : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_approx_spline_point_mid(a : MathapproxsplinePoint, b : MathapproxsplinePoint) -> MathapproxsplinePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_approx_spline_point_lerp(a : MathapproxsplinePoint, b : MathapproxsplinePoint, t : Double) -> MathapproxsplinePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_approx_spline_point_to_string(pt : MathapproxsplinePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathapproxsplineSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_spline_make_series(vals : Array[Double], name : String) -> MathapproxsplineSeries {
  { vals, name, meta: 0 }
}

pub fn math_approx_spline_series_len(s : MathapproxsplineSeries) -> Int { s.vals.length() }

pub fn math_approx_spline_series_sum(s : MathapproxsplineSeries) -> Double { @_common.sum(s.vals) }

pub fn math_approx_spline_series_mean(s : MathapproxsplineSeries) -> Double { @_common.mean(s.vals) }

pub fn math_approx_spline_series_min(s : MathapproxsplineSeries) -> Double { @_common.min(s.vals) }

pub fn math_approx_spline_series_max(s : MathapproxsplineSeries) -> Double { @_common.max(s.vals) }

pub fn math_approx_spline_series_range(s : MathapproxsplineSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_approx_spline_series_var(s : MathapproxsplineSeries) -> Double { @_common.variance(s.vals) }

pub fn math_approx_spline_series_std(s : MathapproxsplineSeries) -> Double { @_common.std(s.vals) }

pub fn math_approx_spline_series_median(s : MathapproxsplineSeries) -> Double { @_common.median(s.vals) }

pub fn math_approx_spline_series_scale(s : MathapproxsplineSeries, f : Double) -> MathapproxsplineSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn math_approx_spline_series_add(a : MathapproxsplineSeries, b : MathapproxsplineSeries) -> MathapproxsplineSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_approx_spline_series_sub(a : MathapproxsplineSeries, b : MathapproxsplineSeries) -> MathapproxsplineSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_approx_spline_series_normalize(s : MathapproxsplineSeries) -> MathapproxsplineSeries {
  let mn = math_approx_spline_series_min(s)
  let mx = math_approx_spline_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_approx_spline_series_cumsum(s : MathapproxsplineSeries) -> MathapproxsplineSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_approx_spline_series_to_string(s : MathapproxsplineSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxsplineMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_spline_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxsplineMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_spline_matrix_identity(n : Int) -> MathapproxsplineMatrix {
  let m = math_approx_spline_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_approx_spline_matrix_get(m : MathapproxsplineMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_approx_spline_matrix_transpose(m : MathapproxsplineMatrix) -> MathapproxsplineMatrix {
  let result = math_approx_spline_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_approx_spline_matrix_add(a : MathapproxsplineMatrix, b : MathapproxsplineMatrix) -> MathapproxsplineMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_approx_spline_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_approx_spline_matrix_scale(m : MathapproxsplineMatrix, s : Double) -> MathapproxsplineMatrix {
  let result = math_approx_spline_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_approx_spline_matrix_multiply(a : MathapproxsplineMatrix, b : MathapproxsplineMatrix) -> MathapproxsplineMatrix {
  if a.cols != b.rows { return math_approx_spline_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_approx_spline_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_approx_spline_matrix_trace(m : MathapproxsplineMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_approx_spline_matrix_det(m : MathapproxsplineMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_approx_spline_matrix_norm(m : MathapproxsplineMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_approx_spline_matrix_to_string(m : MathapproxsplineMatrix) -> String {
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

pub(all) struct MathapproxsplineVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_spline_make_vector(comps : Array[Double]) -> MathapproxsplineVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_spline_vector_zero(dim : Int) -> MathapproxsplineVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_approx_spline_vector_add(a : MathapproxsplineVector, b : MathapproxsplineVector) -> MathapproxsplineVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn math_approx_spline_vector_sub(a : MathapproxsplineVector, b : MathapproxsplineVector) -> MathapproxsplineVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn math_approx_spline_vector_scale(v : MathapproxsplineVector, s : Double) -> MathapproxsplineVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn math_approx_spline_vector_dot(a : MathapproxsplineVector, b : MathapproxsplineVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_approx_spline_vector_norm(v : MathapproxsplineVector) -> Double { @_common.sqrt(math_approx_spline_vector_dot(v, v)) }

pub fn math_approx_spline_vector_normalize(v : MathapproxsplineVector) -> MathapproxsplineVector {
  let n = math_approx_spline_vector_norm(v)
  if n < 0.0000001 { v } else { math_approx_spline_vector_scale(v, 1.0 / n) }
}

pub fn math_approx_spline_vector_dist(a : MathapproxsplineVector, b : MathapproxsplineVector) -> Double {
  math_approx_spline_vector_norm(math_approx_spline_vector_sub(a, b))
}

pub fn math_approx_spline_vector_to_string(v : MathapproxsplineVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_spline_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_approx_spline_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_approx_spline_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_approx_spline_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_approx_spline_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_approx_spline_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_approx_spline_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_approx_spline_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_approx_spline_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_approx_spline_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_approx_spline_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_approx_spline_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_approx_spline_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_approx_spline_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_approx_spline_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_approx_spline_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_approx_spline_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_approx_spline_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_approx_spline_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_approx_spline_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_approx_spline_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_approx_spline_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_approx_spline_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_approx_spline_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_approx_spline_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_approx_spline_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_approx_spline_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_approx_spline_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_approx_spline_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathapproxsplineFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_frame_make(size : Int) -> MathapproxsplineFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_frame_len(s : MathapproxsplineFrame) -> Int { s.size }

pub fn math_approx_spline_frame_get(s : MathapproxsplineFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_frame_set(s : MathapproxsplineFrame, i : Int, v : Double) -> MathapproxsplineFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_frame_sum(s : MathapproxsplineFrame) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_frame_mean(s : MathapproxsplineFrame) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_frame_scale(s : MathapproxsplineFrame, f : Double) -> MathapproxsplineFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_frame_add(a : MathapproxsplineFrame, b : MathapproxsplineFrame) -> MathapproxsplineFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_frame_copy(s : MathapproxsplineFrame) -> MathapproxsplineFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_frame_fill(s : MathapproxsplineFrame, v : Double) -> MathapproxsplineFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_frame_min(s : MathapproxsplineFrame) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_frame_max(s : MathapproxsplineFrame) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_frame_to_string(s : MathapproxsplineFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_table_make(size : Int) -> MathapproxsplineTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_table_len(s : MathapproxsplineTable) -> Int { s.size }

pub fn math_approx_spline_table_get(s : MathapproxsplineTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_table_set(s : MathapproxsplineTable, i : Int, v : Double) -> MathapproxsplineTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_table_sum(s : MathapproxsplineTable) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_table_mean(s : MathapproxsplineTable) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_table_scale(s : MathapproxsplineTable, f : Double) -> MathapproxsplineTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_table_add(a : MathapproxsplineTable, b : MathapproxsplineTable) -> MathapproxsplineTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_table_copy(s : MathapproxsplineTable) -> MathapproxsplineTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_table_fill(s : MathapproxsplineTable, v : Double) -> MathapproxsplineTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_table_min(s : MathapproxsplineTable) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_table_max(s : MathapproxsplineTable) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_table_to_string(s : MathapproxsplineTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_graphn_make(size : Int) -> MathapproxsplineGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_graphn_len(s : MathapproxsplineGraphN) -> Int { s.size }

pub fn math_approx_spline_graphn_get(s : MathapproxsplineGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_graphn_set(s : MathapproxsplineGraphN, i : Int, v : Double) -> MathapproxsplineGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_graphn_sum(s : MathapproxsplineGraphN) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_graphn_mean(s : MathapproxsplineGraphN) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_graphn_scale(s : MathapproxsplineGraphN, f : Double) -> MathapproxsplineGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_graphn_add(a : MathapproxsplineGraphN, b : MathapproxsplineGraphN) -> MathapproxsplineGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_graphn_copy(s : MathapproxsplineGraphN) -> MathapproxsplineGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_graphn_fill(s : MathapproxsplineGraphN, v : Double) -> MathapproxsplineGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_graphn_min(s : MathapproxsplineGraphN) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_graphn_max(s : MathapproxsplineGraphN) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_graphn_to_string(s : MathapproxsplineGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_node_make(size : Int) -> MathapproxsplineNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_node_len(s : MathapproxsplineNode) -> Int { s.size }

pub fn math_approx_spline_node_get(s : MathapproxsplineNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_node_set(s : MathapproxsplineNode, i : Int, v : Double) -> MathapproxsplineNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_node_sum(s : MathapproxsplineNode) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_node_mean(s : MathapproxsplineNode) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_node_scale(s : MathapproxsplineNode, f : Double) -> MathapproxsplineNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_node_add(a : MathapproxsplineNode, b : MathapproxsplineNode) -> MathapproxsplineNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_node_copy(s : MathapproxsplineNode) -> MathapproxsplineNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_node_fill(s : MathapproxsplineNode, v : Double) -> MathapproxsplineNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_node_min(s : MathapproxsplineNode) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_node_max(s : MathapproxsplineNode) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_node_to_string(s : MathapproxsplineNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_edge_make(size : Int) -> MathapproxsplineEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_edge_len(s : MathapproxsplineEdge) -> Int { s.size }

pub fn math_approx_spline_edge_get(s : MathapproxsplineEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_edge_set(s : MathapproxsplineEdge, i : Int, v : Double) -> MathapproxsplineEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_edge_sum(s : MathapproxsplineEdge) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_edge_mean(s : MathapproxsplineEdge) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_edge_scale(s : MathapproxsplineEdge, f : Double) -> MathapproxsplineEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_edge_add(a : MathapproxsplineEdge, b : MathapproxsplineEdge) -> MathapproxsplineEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_edge_copy(s : MathapproxsplineEdge) -> MathapproxsplineEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_edge_fill(s : MathapproxsplineEdge, v : Double) -> MathapproxsplineEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_edge_min(s : MathapproxsplineEdge) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_edge_max(s : MathapproxsplineEdge) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_edge_to_string(s : MathapproxsplineEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplinePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_path_make(size : Int) -> MathapproxsplinePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_path_len(s : MathapproxsplinePath) -> Int { s.size }

pub fn math_approx_spline_path_get(s : MathapproxsplinePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_path_set(s : MathapproxsplinePath, i : Int, v : Double) -> MathapproxsplinePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_path_sum(s : MathapproxsplinePath) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_path_mean(s : MathapproxsplinePath) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_path_scale(s : MathapproxsplinePath, f : Double) -> MathapproxsplinePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_path_add(a : MathapproxsplinePath, b : MathapproxsplinePath) -> MathapproxsplinePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_path_copy(s : MathapproxsplinePath) -> MathapproxsplinePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_path_fill(s : MathapproxsplinePath, v : Double) -> MathapproxsplinePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_path_min(s : MathapproxsplinePath) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_path_max(s : MathapproxsplinePath) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_path_to_string(s : MathapproxsplinePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_cluster_make(size : Int) -> MathapproxsplineCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_cluster_len(s : MathapproxsplineCluster) -> Int { s.size }

pub fn math_approx_spline_cluster_get(s : MathapproxsplineCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_cluster_set(s : MathapproxsplineCluster, i : Int, v : Double) -> MathapproxsplineCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_cluster_sum(s : MathapproxsplineCluster) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_cluster_mean(s : MathapproxsplineCluster) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_cluster_scale(s : MathapproxsplineCluster, f : Double) -> MathapproxsplineCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_cluster_add(a : MathapproxsplineCluster, b : MathapproxsplineCluster) -> MathapproxsplineCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_cluster_copy(s : MathapproxsplineCluster) -> MathapproxsplineCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_cluster_fill(s : MathapproxsplineCluster, v : Double) -> MathapproxsplineCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_cluster_min(s : MathapproxsplineCluster) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_cluster_max(s : MathapproxsplineCluster) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_cluster_to_string(s : MathapproxsplineCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_model_make(size : Int) -> MathapproxsplineModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_model_len(s : MathapproxsplineModel) -> Int { s.size }

pub fn math_approx_spline_model_get(s : MathapproxsplineModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_model_set(s : MathapproxsplineModel, i : Int, v : Double) -> MathapproxsplineModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_model_sum(s : MathapproxsplineModel) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_model_mean(s : MathapproxsplineModel) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_model_scale(s : MathapproxsplineModel, f : Double) -> MathapproxsplineModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_model_add(a : MathapproxsplineModel, b : MathapproxsplineModel) -> MathapproxsplineModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_model_copy(s : MathapproxsplineModel) -> MathapproxsplineModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_model_fill(s : MathapproxsplineModel, v : Double) -> MathapproxsplineModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_model_min(s : MathapproxsplineModel) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_model_max(s : MathapproxsplineModel) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_model_to_string(s : MathapproxsplineModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_layer_make(size : Int) -> MathapproxsplineLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_layer_len(s : MathapproxsplineLayer) -> Int { s.size }

pub fn math_approx_spline_layer_get(s : MathapproxsplineLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_layer_set(s : MathapproxsplineLayer, i : Int, v : Double) -> MathapproxsplineLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_layer_sum(s : MathapproxsplineLayer) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_layer_mean(s : MathapproxsplineLayer) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_layer_scale(s : MathapproxsplineLayer, f : Double) -> MathapproxsplineLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_layer_add(a : MathapproxsplineLayer, b : MathapproxsplineLayer) -> MathapproxsplineLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_layer_copy(s : MathapproxsplineLayer) -> MathapproxsplineLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_layer_fill(s : MathapproxsplineLayer, v : Double) -> MathapproxsplineLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_layer_min(s : MathapproxsplineLayer) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_layer_max(s : MathapproxsplineLayer) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_layer_to_string(s : MathapproxsplineLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_buffer_make(size : Int) -> MathapproxsplineBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_buffer_len(s : MathapproxsplineBuffer) -> Int { s.size }

pub fn math_approx_spline_buffer_get(s : MathapproxsplineBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_buffer_set(s : MathapproxsplineBuffer, i : Int, v : Double) -> MathapproxsplineBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_buffer_sum(s : MathapproxsplineBuffer) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_buffer_mean(s : MathapproxsplineBuffer) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_buffer_scale(s : MathapproxsplineBuffer, f : Double) -> MathapproxsplineBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_buffer_add(a : MathapproxsplineBuffer, b : MathapproxsplineBuffer) -> MathapproxsplineBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_buffer_copy(s : MathapproxsplineBuffer) -> MathapproxsplineBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_buffer_fill(s : MathapproxsplineBuffer, v : Double) -> MathapproxsplineBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_buffer_min(s : MathapproxsplineBuffer) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_buffer_max(s : MathapproxsplineBuffer) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_buffer_to_string(s : MathapproxsplineBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_cursor_make(size : Int) -> MathapproxsplineCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_cursor_len(s : MathapproxsplineCursor) -> Int { s.size }

pub fn math_approx_spline_cursor_get(s : MathapproxsplineCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_cursor_set(s : MathapproxsplineCursor, i : Int, v : Double) -> MathapproxsplineCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_cursor_sum(s : MathapproxsplineCursor) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_cursor_mean(s : MathapproxsplineCursor) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_cursor_scale(s : MathapproxsplineCursor, f : Double) -> MathapproxsplineCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_cursor_add(a : MathapproxsplineCursor, b : MathapproxsplineCursor) -> MathapproxsplineCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_cursor_copy(s : MathapproxsplineCursor) -> MathapproxsplineCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_cursor_fill(s : MathapproxsplineCursor, v : Double) -> MathapproxsplineCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_cursor_min(s : MathapproxsplineCursor) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_cursor_max(s : MathapproxsplineCursor) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_cursor_to_string(s : MathapproxsplineCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_view_make(size : Int) -> MathapproxsplineView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_view_len(s : MathapproxsplineView) -> Int { s.size }

pub fn math_approx_spline_view_get(s : MathapproxsplineView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_view_set(s : MathapproxsplineView, i : Int, v : Double) -> MathapproxsplineView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_view_sum(s : MathapproxsplineView) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_view_mean(s : MathapproxsplineView) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_view_scale(s : MathapproxsplineView, f : Double) -> MathapproxsplineView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_view_add(a : MathapproxsplineView, b : MathapproxsplineView) -> MathapproxsplineView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_view_copy(s : MathapproxsplineView) -> MathapproxsplineView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_view_fill(s : MathapproxsplineView, v : Double) -> MathapproxsplineView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_view_min(s : MathapproxsplineView) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_view_max(s : MathapproxsplineView) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_view_to_string(s : MathapproxsplineView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_range_make(size : Int) -> MathapproxsplineRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_range_len(s : MathapproxsplineRange) -> Int { s.size }

pub fn math_approx_spline_range_get(s : MathapproxsplineRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_range_set(s : MathapproxsplineRange, i : Int, v : Double) -> MathapproxsplineRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_range_sum(s : MathapproxsplineRange) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_range_mean(s : MathapproxsplineRange) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_range_scale(s : MathapproxsplineRange, f : Double) -> MathapproxsplineRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_range_add(a : MathapproxsplineRange, b : MathapproxsplineRange) -> MathapproxsplineRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_range_copy(s : MathapproxsplineRange) -> MathapproxsplineRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_range_fill(s : MathapproxsplineRange, v : Double) -> MathapproxsplineRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_range_min(s : MathapproxsplineRange) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_range_max(s : MathapproxsplineRange) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_range_to_string(s : MathapproxsplineRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathapproxsplineSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_spline_slice_make(size : Int) -> MathapproxsplineSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_approx_spline_slice_len(s : MathapproxsplineSlice) -> Int { s.size }

pub fn math_approx_spline_slice_get(s : MathapproxsplineSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_approx_spline_slice_set(s : MathapproxsplineSlice, i : Int, v : Double) -> MathapproxsplineSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_approx_spline_slice_sum(s : MathapproxsplineSlice) -> Double { @_common.sum(s.data) }

pub fn math_approx_spline_slice_mean(s : MathapproxsplineSlice) -> Double { @_common.mean(s.data) }

pub fn math_approx_spline_slice_scale(s : MathapproxsplineSlice, f : Double) -> MathapproxsplineSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_slice_add(a : MathapproxsplineSlice, b : MathapproxsplineSlice) -> MathapproxsplineSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_approx_spline_slice_copy(s : MathapproxsplineSlice) -> MathapproxsplineSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_slice_fill(s : MathapproxsplineSlice, v : Double) -> MathapproxsplineSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_approx_spline_slice_min(s : MathapproxsplineSlice) -> Double { @_common.min(s.data) }

pub fn math_approx_spline_slice_max(s : MathapproxsplineSlice) -> Double { @_common.max(s.data) }

pub fn math_approx_spline_slice_to_string(s : MathapproxsplineSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

