///===
/// extcore/math_linear_prog

pub(all) struct MathlinearprogPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_linear_prog_make_point(x : Double, y : Double) -> MathlinearprogPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_linear_prog_make_point3(x : Double, y : Double, z : Double) -> MathlinearprogPoint {
  { x, y, z, label: 0 }
}

pub fn math_linear_prog_point_x(pt : MathlinearprogPoint) -> Double { pt.x }

pub fn math_linear_prog_point_y(pt : MathlinearprogPoint) -> Double { pt.y }

pub fn math_linear_prog_point_z(pt : MathlinearprogPoint) -> Double { pt.z }

pub fn math_linear_prog_point_label(pt : MathlinearprogPoint) -> Int { pt.label }

pub fn math_linear_prog_point_dist(a : MathlinearprogPoint, b : MathlinearprogPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_linear_prog_point_add(a : MathlinearprogPoint, b : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_linear_prog_point_sub(a : MathlinearprogPoint, b : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_linear_prog_point_scale(pt : MathlinearprogPoint, s : Double) -> MathlinearprogPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_linear_prog_point_dot(a : MathlinearprogPoint, b : MathlinearprogPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_linear_prog_point_cross(a : MathlinearprogPoint, b : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_linear_prog_point_norm(pt : MathlinearprogPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_linear_prog_point_normalize(pt : MathlinearprogPoint) -> MathlinearprogPoint {
  let n = math_linear_prog_point_norm(pt)
  if n < 0.0000001 { pt } else { math_linear_prog_point_scale(pt, 1.0 / n) }
}

pub fn math_linear_prog_point_negate(pt : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_linear_prog_point_mid(a : MathlinearprogPoint, b : MathlinearprogPoint) -> MathlinearprogPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_linear_prog_point_lerp(a : MathlinearprogPoint, b : MathlinearprogPoint, t : Double) -> MathlinearprogPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_linear_prog_point_to_string(pt : MathlinearprogPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathlinearprogSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_linear_prog_make_series(vals : Array[Double], name : String) -> MathlinearprogSeries {
  { vals, name, meta: 0 }
}

pub fn math_linear_prog_series_len(s : MathlinearprogSeries) -> Int { s.vals.length() }

pub fn math_linear_prog_series_sum(s : MathlinearprogSeries) -> Double { @_common.sum(s.vals) }

pub fn math_linear_prog_series_mean(s : MathlinearprogSeries) -> Double { @_common.mean(s.vals) }

pub fn math_linear_prog_series_min(s : MathlinearprogSeries) -> Double { @_common.min(s.vals) }

pub fn math_linear_prog_series_max(s : MathlinearprogSeries) -> Double { @_common.max(s.vals) }

pub fn math_linear_prog_series_range(s : MathlinearprogSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_linear_prog_series_var(s : MathlinearprogSeries) -> Double { @_common.variance(s.vals) }

pub fn math_linear_prog_series_std(s : MathlinearprogSeries) -> Double { @_common.std(s.vals) }

pub fn math_linear_prog_series_median(s : MathlinearprogSeries) -> Double { @_common.median(s.vals) }

pub fn math_linear_prog_series_scale(s : MathlinearprogSeries, f : Double) -> MathlinearprogSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn math_linear_prog_series_add(a : MathlinearprogSeries, b : MathlinearprogSeries) -> MathlinearprogSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_linear_prog_series_sub(a : MathlinearprogSeries, b : MathlinearprogSeries) -> MathlinearprogSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_linear_prog_series_normalize(s : MathlinearprogSeries) -> MathlinearprogSeries {
  let mn = math_linear_prog_series_min(s)
  let mx = math_linear_prog_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_linear_prog_series_cumsum(s : MathlinearprogSeries) -> MathlinearprogSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_linear_prog_series_to_string(s : MathlinearprogSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathlinearprogMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_linear_prog_make_matrix(rows : Int, cols : Int, val : Double) -> MathlinearprogMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_linear_prog_matrix_identity(n : Int) -> MathlinearprogMatrix {
  let m = math_linear_prog_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_linear_prog_matrix_get(m : MathlinearprogMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_linear_prog_matrix_transpose(m : MathlinearprogMatrix) -> MathlinearprogMatrix {
  let result = math_linear_prog_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_linear_prog_matrix_add(a : MathlinearprogMatrix, b : MathlinearprogMatrix) -> MathlinearprogMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_linear_prog_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_linear_prog_matrix_scale(m : MathlinearprogMatrix, s : Double) -> MathlinearprogMatrix {
  let result = math_linear_prog_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_linear_prog_matrix_multiply(a : MathlinearprogMatrix, b : MathlinearprogMatrix) -> MathlinearprogMatrix {
  if a.cols != b.rows { return math_linear_prog_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_linear_prog_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_linear_prog_matrix_trace(m : MathlinearprogMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_linear_prog_matrix_det(m : MathlinearprogMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_linear_prog_matrix_norm(m : MathlinearprogMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_linear_prog_matrix_to_string(m : MathlinearprogMatrix) -> String {
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

pub(all) struct MathlinearprogVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_linear_prog_make_vector(comps : Array[Double]) -> MathlinearprogVector {
  { comps, dim: comps.length() }
}

pub fn math_linear_prog_vector_zero(dim : Int) -> MathlinearprogVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_linear_prog_vector_add(a : MathlinearprogVector, b : MathlinearprogVector) -> MathlinearprogVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn math_linear_prog_vector_sub(a : MathlinearprogVector, b : MathlinearprogVector) -> MathlinearprogVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn math_linear_prog_vector_scale(v : MathlinearprogVector, s : Double) -> MathlinearprogVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn math_linear_prog_vector_dot(a : MathlinearprogVector, b : MathlinearprogVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_linear_prog_vector_norm(v : MathlinearprogVector) -> Double { @_common.sqrt(math_linear_prog_vector_dot(v, v)) }

pub fn math_linear_prog_vector_normalize(v : MathlinearprogVector) -> MathlinearprogVector {
  let n = math_linear_prog_vector_norm(v)
  if n < 0.0000001 { v } else { math_linear_prog_vector_scale(v, 1.0 / n) }
}

pub fn math_linear_prog_vector_dist(a : MathlinearprogVector, b : MathlinearprogVector) -> Double {
  math_linear_prog_vector_norm(math_linear_prog_vector_sub(a, b))
}

pub fn math_linear_prog_vector_to_string(v : MathlinearprogVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_linear_prog_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_linear_prog_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_linear_prog_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_linear_prog_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_linear_prog_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_linear_prog_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_linear_prog_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_linear_prog_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_linear_prog_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_linear_prog_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_linear_prog_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_linear_prog_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_linear_prog_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_linear_prog_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_linear_prog_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_linear_prog_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_linear_prog_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_linear_prog_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_linear_prog_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_linear_prog_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_linear_prog_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_linear_prog_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_linear_prog_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_linear_prog_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_linear_prog_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_linear_prog_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_linear_prog_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_linear_prog_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_linear_prog_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathlinearprogFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_frame_make(size : Int) -> MathlinearprogFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_frame_len(s : MathlinearprogFrame) -> Int { s.size }

pub fn math_linear_prog_frame_get(s : MathlinearprogFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_frame_set(s : MathlinearprogFrame, i : Int, v : Double) -> MathlinearprogFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_frame_sum(s : MathlinearprogFrame) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_frame_mean(s : MathlinearprogFrame) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_frame_scale(s : MathlinearprogFrame, f : Double) -> MathlinearprogFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_frame_add(a : MathlinearprogFrame, b : MathlinearprogFrame) -> MathlinearprogFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_frame_copy(s : MathlinearprogFrame) -> MathlinearprogFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_frame_fill(s : MathlinearprogFrame, v : Double) -> MathlinearprogFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_frame_min(s : MathlinearprogFrame) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_frame_max(s : MathlinearprogFrame) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_frame_to_string(s : MathlinearprogFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_table_make(size : Int) -> MathlinearprogTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_table_len(s : MathlinearprogTable) -> Int { s.size }

pub fn math_linear_prog_table_get(s : MathlinearprogTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_table_set(s : MathlinearprogTable, i : Int, v : Double) -> MathlinearprogTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_table_sum(s : MathlinearprogTable) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_table_mean(s : MathlinearprogTable) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_table_scale(s : MathlinearprogTable, f : Double) -> MathlinearprogTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_table_add(a : MathlinearprogTable, b : MathlinearprogTable) -> MathlinearprogTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_table_copy(s : MathlinearprogTable) -> MathlinearprogTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_table_fill(s : MathlinearprogTable, v : Double) -> MathlinearprogTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_table_min(s : MathlinearprogTable) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_table_max(s : MathlinearprogTable) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_table_to_string(s : MathlinearprogTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_graphn_make(size : Int) -> MathlinearprogGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_graphn_len(s : MathlinearprogGraphN) -> Int { s.size }

pub fn math_linear_prog_graphn_get(s : MathlinearprogGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_graphn_set(s : MathlinearprogGraphN, i : Int, v : Double) -> MathlinearprogGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_graphn_sum(s : MathlinearprogGraphN) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_graphn_mean(s : MathlinearprogGraphN) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_graphn_scale(s : MathlinearprogGraphN, f : Double) -> MathlinearprogGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_graphn_add(a : MathlinearprogGraphN, b : MathlinearprogGraphN) -> MathlinearprogGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_graphn_copy(s : MathlinearprogGraphN) -> MathlinearprogGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_graphn_fill(s : MathlinearprogGraphN, v : Double) -> MathlinearprogGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_graphn_min(s : MathlinearprogGraphN) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_graphn_max(s : MathlinearprogGraphN) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_graphn_to_string(s : MathlinearprogGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_node_make(size : Int) -> MathlinearprogNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_node_len(s : MathlinearprogNode) -> Int { s.size }

pub fn math_linear_prog_node_get(s : MathlinearprogNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_node_set(s : MathlinearprogNode, i : Int, v : Double) -> MathlinearprogNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_node_sum(s : MathlinearprogNode) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_node_mean(s : MathlinearprogNode) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_node_scale(s : MathlinearprogNode, f : Double) -> MathlinearprogNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_node_add(a : MathlinearprogNode, b : MathlinearprogNode) -> MathlinearprogNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_node_copy(s : MathlinearprogNode) -> MathlinearprogNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_node_fill(s : MathlinearprogNode, v : Double) -> MathlinearprogNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_node_min(s : MathlinearprogNode) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_node_max(s : MathlinearprogNode) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_node_to_string(s : MathlinearprogNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_edge_make(size : Int) -> MathlinearprogEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_edge_len(s : MathlinearprogEdge) -> Int { s.size }

pub fn math_linear_prog_edge_get(s : MathlinearprogEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_edge_set(s : MathlinearprogEdge, i : Int, v : Double) -> MathlinearprogEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_edge_sum(s : MathlinearprogEdge) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_edge_mean(s : MathlinearprogEdge) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_edge_scale(s : MathlinearprogEdge, f : Double) -> MathlinearprogEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_edge_add(a : MathlinearprogEdge, b : MathlinearprogEdge) -> MathlinearprogEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_edge_copy(s : MathlinearprogEdge) -> MathlinearprogEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_edge_fill(s : MathlinearprogEdge, v : Double) -> MathlinearprogEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_edge_min(s : MathlinearprogEdge) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_edge_max(s : MathlinearprogEdge) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_edge_to_string(s : MathlinearprogEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_path_make(size : Int) -> MathlinearprogPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_path_len(s : MathlinearprogPath) -> Int { s.size }

pub fn math_linear_prog_path_get(s : MathlinearprogPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_path_set(s : MathlinearprogPath, i : Int, v : Double) -> MathlinearprogPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_path_sum(s : MathlinearprogPath) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_path_mean(s : MathlinearprogPath) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_path_scale(s : MathlinearprogPath, f : Double) -> MathlinearprogPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_path_add(a : MathlinearprogPath, b : MathlinearprogPath) -> MathlinearprogPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_path_copy(s : MathlinearprogPath) -> MathlinearprogPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_path_fill(s : MathlinearprogPath, v : Double) -> MathlinearprogPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_path_min(s : MathlinearprogPath) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_path_max(s : MathlinearprogPath) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_path_to_string(s : MathlinearprogPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_cluster_make(size : Int) -> MathlinearprogCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_cluster_len(s : MathlinearprogCluster) -> Int { s.size }

pub fn math_linear_prog_cluster_get(s : MathlinearprogCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_cluster_set(s : MathlinearprogCluster, i : Int, v : Double) -> MathlinearprogCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_cluster_sum(s : MathlinearprogCluster) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_cluster_mean(s : MathlinearprogCluster) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_cluster_scale(s : MathlinearprogCluster, f : Double) -> MathlinearprogCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_cluster_add(a : MathlinearprogCluster, b : MathlinearprogCluster) -> MathlinearprogCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_cluster_copy(s : MathlinearprogCluster) -> MathlinearprogCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_cluster_fill(s : MathlinearprogCluster, v : Double) -> MathlinearprogCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_cluster_min(s : MathlinearprogCluster) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_cluster_max(s : MathlinearprogCluster) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_cluster_to_string(s : MathlinearprogCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_model_make(size : Int) -> MathlinearprogModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_model_len(s : MathlinearprogModel) -> Int { s.size }

pub fn math_linear_prog_model_get(s : MathlinearprogModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_model_set(s : MathlinearprogModel, i : Int, v : Double) -> MathlinearprogModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_model_sum(s : MathlinearprogModel) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_model_mean(s : MathlinearprogModel) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_model_scale(s : MathlinearprogModel, f : Double) -> MathlinearprogModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_model_add(a : MathlinearprogModel, b : MathlinearprogModel) -> MathlinearprogModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_model_copy(s : MathlinearprogModel) -> MathlinearprogModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_model_fill(s : MathlinearprogModel, v : Double) -> MathlinearprogModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_model_min(s : MathlinearprogModel) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_model_max(s : MathlinearprogModel) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_model_to_string(s : MathlinearprogModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_layer_make(size : Int) -> MathlinearprogLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_layer_len(s : MathlinearprogLayer) -> Int { s.size }

pub fn math_linear_prog_layer_get(s : MathlinearprogLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_layer_set(s : MathlinearprogLayer, i : Int, v : Double) -> MathlinearprogLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_layer_sum(s : MathlinearprogLayer) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_layer_mean(s : MathlinearprogLayer) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_layer_scale(s : MathlinearprogLayer, f : Double) -> MathlinearprogLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_layer_add(a : MathlinearprogLayer, b : MathlinearprogLayer) -> MathlinearprogLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_layer_copy(s : MathlinearprogLayer) -> MathlinearprogLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_layer_fill(s : MathlinearprogLayer, v : Double) -> MathlinearprogLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_layer_min(s : MathlinearprogLayer) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_layer_max(s : MathlinearprogLayer) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_layer_to_string(s : MathlinearprogLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_buffer_make(size : Int) -> MathlinearprogBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_buffer_len(s : MathlinearprogBuffer) -> Int { s.size }

pub fn math_linear_prog_buffer_get(s : MathlinearprogBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_buffer_set(s : MathlinearprogBuffer, i : Int, v : Double) -> MathlinearprogBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_buffer_sum(s : MathlinearprogBuffer) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_buffer_mean(s : MathlinearprogBuffer) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_buffer_scale(s : MathlinearprogBuffer, f : Double) -> MathlinearprogBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_buffer_add(a : MathlinearprogBuffer, b : MathlinearprogBuffer) -> MathlinearprogBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_buffer_copy(s : MathlinearprogBuffer) -> MathlinearprogBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_buffer_fill(s : MathlinearprogBuffer, v : Double) -> MathlinearprogBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_buffer_min(s : MathlinearprogBuffer) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_buffer_max(s : MathlinearprogBuffer) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_buffer_to_string(s : MathlinearprogBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_cursor_make(size : Int) -> MathlinearprogCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_cursor_len(s : MathlinearprogCursor) -> Int { s.size }

pub fn math_linear_prog_cursor_get(s : MathlinearprogCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_cursor_set(s : MathlinearprogCursor, i : Int, v : Double) -> MathlinearprogCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_cursor_sum(s : MathlinearprogCursor) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_cursor_mean(s : MathlinearprogCursor) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_cursor_scale(s : MathlinearprogCursor, f : Double) -> MathlinearprogCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_cursor_add(a : MathlinearprogCursor, b : MathlinearprogCursor) -> MathlinearprogCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_cursor_copy(s : MathlinearprogCursor) -> MathlinearprogCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_cursor_fill(s : MathlinearprogCursor, v : Double) -> MathlinearprogCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_cursor_min(s : MathlinearprogCursor) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_cursor_max(s : MathlinearprogCursor) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_cursor_to_string(s : MathlinearprogCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_view_make(size : Int) -> MathlinearprogView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_view_len(s : MathlinearprogView) -> Int { s.size }

pub fn math_linear_prog_view_get(s : MathlinearprogView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_view_set(s : MathlinearprogView, i : Int, v : Double) -> MathlinearprogView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_view_sum(s : MathlinearprogView) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_view_mean(s : MathlinearprogView) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_view_scale(s : MathlinearprogView, f : Double) -> MathlinearprogView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_view_add(a : MathlinearprogView, b : MathlinearprogView) -> MathlinearprogView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_view_copy(s : MathlinearprogView) -> MathlinearprogView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_view_fill(s : MathlinearprogView, v : Double) -> MathlinearprogView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_view_min(s : MathlinearprogView) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_view_max(s : MathlinearprogView) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_view_to_string(s : MathlinearprogView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_range_make(size : Int) -> MathlinearprogRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_range_len(s : MathlinearprogRange) -> Int { s.size }

pub fn math_linear_prog_range_get(s : MathlinearprogRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_range_set(s : MathlinearprogRange, i : Int, v : Double) -> MathlinearprogRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_range_sum(s : MathlinearprogRange) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_range_mean(s : MathlinearprogRange) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_range_scale(s : MathlinearprogRange, f : Double) -> MathlinearprogRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_range_add(a : MathlinearprogRange, b : MathlinearprogRange) -> MathlinearprogRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_range_copy(s : MathlinearprogRange) -> MathlinearprogRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_range_fill(s : MathlinearprogRange, v : Double) -> MathlinearprogRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_range_min(s : MathlinearprogRange) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_range_max(s : MathlinearprogRange) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_range_to_string(s : MathlinearprogRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathlinearprogSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_linear_prog_slice_make(size : Int) -> MathlinearprogSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_linear_prog_slice_len(s : MathlinearprogSlice) -> Int { s.size }

pub fn math_linear_prog_slice_get(s : MathlinearprogSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_linear_prog_slice_set(s : MathlinearprogSlice, i : Int, v : Double) -> MathlinearprogSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_linear_prog_slice_sum(s : MathlinearprogSlice) -> Double { @_common.sum(s.data) }

pub fn math_linear_prog_slice_mean(s : MathlinearprogSlice) -> Double { @_common.mean(s.data) }

pub fn math_linear_prog_slice_scale(s : MathlinearprogSlice, f : Double) -> MathlinearprogSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_slice_add(a : MathlinearprogSlice, b : MathlinearprogSlice) -> MathlinearprogSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_linear_prog_slice_copy(s : MathlinearprogSlice) -> MathlinearprogSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_slice_fill(s : MathlinearprogSlice, v : Double) -> MathlinearprogSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_linear_prog_slice_min(s : MathlinearprogSlice) -> Double { @_common.min(s.data) }

pub fn math_linear_prog_slice_max(s : MathlinearprogSlice) -> Double { @_common.max(s.data) }

pub fn math_linear_prog_slice_to_string(s : MathlinearprogSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

