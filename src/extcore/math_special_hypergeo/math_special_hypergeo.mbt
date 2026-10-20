///===
/// extcore/math_special_hypergeo

pub(all) struct MathspecialhypergeoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_hypergeo_make_point(x : Double, y : Double) -> MathspecialhypergeoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_hypergeo_make_point3(x : Double, y : Double, z : Double) -> MathspecialhypergeoPoint {
  { x, y, z, label: 0 }
}

pub fn math_special_hypergeo_point_x(pt : MathspecialhypergeoPoint) -> Double { pt.x }

pub fn math_special_hypergeo_point_y(pt : MathspecialhypergeoPoint) -> Double { pt.y }

pub fn math_special_hypergeo_point_z(pt : MathspecialhypergeoPoint) -> Double { pt.z }

pub fn math_special_hypergeo_point_label(pt : MathspecialhypergeoPoint) -> Int { pt.label }

pub fn math_special_hypergeo_point_dist(a : MathspecialhypergeoPoint, b : MathspecialhypergeoPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_special_hypergeo_point_add(a : MathspecialhypergeoPoint, b : MathspecialhypergeoPoint) -> MathspecialhypergeoPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_special_hypergeo_point_sub(a : MathspecialhypergeoPoint, b : MathspecialhypergeoPoint) -> MathspecialhypergeoPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_special_hypergeo_point_scale(pt : MathspecialhypergeoPoint, s : Double) -> MathspecialhypergeoPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_special_hypergeo_point_dot(a : MathspecialhypergeoPoint, b : MathspecialhypergeoPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_special_hypergeo_point_cross(a : MathspecialhypergeoPoint, b : MathspecialhypergeoPoint) -> MathspecialhypergeoPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_special_hypergeo_point_norm(pt : MathspecialhypergeoPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_special_hypergeo_point_normalize(pt : MathspecialhypergeoPoint) -> MathspecialhypergeoPoint {
  let n = math_special_hypergeo_point_norm(pt)
  if n < 0.0000001 { pt } else { math_special_hypergeo_point_scale(pt, 1.0 / n) }
}

pub fn math_special_hypergeo_point_negate(pt : MathspecialhypergeoPoint) -> MathspecialhypergeoPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_special_hypergeo_point_mid(a : MathspecialhypergeoPoint, b : MathspecialhypergeoPoint) -> MathspecialhypergeoPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_special_hypergeo_point_lerp(a : MathspecialhypergeoPoint, b : MathspecialhypergeoPoint, t : Double) -> MathspecialhypergeoPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_special_hypergeo_point_to_string(pt : MathspecialhypergeoPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathspecialhypergeoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_hypergeo_make_series(vals : Array[Double], name : String) -> MathspecialhypergeoSeries {
  { vals, name, meta: 0 }
}

pub fn math_special_hypergeo_series_len(s : MathspecialhypergeoSeries) -> Int { s.vals.length() }

pub fn math_special_hypergeo_series_sum(s : MathspecialhypergeoSeries) -> Double { @_common.sum(s.vals) }

pub fn math_special_hypergeo_series_mean(s : MathspecialhypergeoSeries) -> Double { @_common.mean(s.vals) }

pub fn math_special_hypergeo_series_min(s : MathspecialhypergeoSeries) -> Double { @_common.min(s.vals) }

pub fn math_special_hypergeo_series_max(s : MathspecialhypergeoSeries) -> Double { @_common.max(s.vals) }

pub fn math_special_hypergeo_series_range(s : MathspecialhypergeoSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_special_hypergeo_series_var(s : MathspecialhypergeoSeries) -> Double { @_common.variance(s.vals) }

pub fn math_special_hypergeo_series_std(s : MathspecialhypergeoSeries) -> Double { @_common.std(s.vals) }

pub fn math_special_hypergeo_series_median(s : MathspecialhypergeoSeries) -> Double { @_common.median(s.vals) }

pub fn math_special_hypergeo_series_scale(s : MathspecialhypergeoSeries, f : Double) -> MathspecialhypergeoSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_special_hypergeo_series_add(a : MathspecialhypergeoSeries, b : MathspecialhypergeoSeries) -> MathspecialhypergeoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_special_hypergeo_series_sub(a : MathspecialhypergeoSeries, b : MathspecialhypergeoSeries) -> MathspecialhypergeoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_special_hypergeo_series_normalize(s : MathspecialhypergeoSeries) -> MathspecialhypergeoSeries {
  let mn = math_special_hypergeo_series_min(s)
  let mx = math_special_hypergeo_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_special_hypergeo_series_cumsum(s : MathspecialhypergeoSeries) -> MathspecialhypergeoSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_special_hypergeo_series_to_string(s : MathspecialhypergeoSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialhypergeoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_hypergeo_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialhypergeoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_hypergeo_matrix_identity(n : Int) -> MathspecialhypergeoMatrix {
  let m = math_special_hypergeo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_special_hypergeo_matrix_get(m : MathspecialhypergeoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_special_hypergeo_matrix_transpose(m : MathspecialhypergeoMatrix) -> MathspecialhypergeoMatrix {
  let result = math_special_hypergeo_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_special_hypergeo_matrix_add(a : MathspecialhypergeoMatrix, b : MathspecialhypergeoMatrix) -> MathspecialhypergeoMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_special_hypergeo_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_special_hypergeo_matrix_scale(m : MathspecialhypergeoMatrix, s : Double) -> MathspecialhypergeoMatrix {
  let result = math_special_hypergeo_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_special_hypergeo_matrix_multiply(a : MathspecialhypergeoMatrix, b : MathspecialhypergeoMatrix) -> MathspecialhypergeoMatrix {
  if a.cols != b.rows { return math_special_hypergeo_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_special_hypergeo_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_special_hypergeo_matrix_trace(m : MathspecialhypergeoMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_special_hypergeo_matrix_det(m : MathspecialhypergeoMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_special_hypergeo_matrix_norm(m : MathspecialhypergeoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_special_hypergeo_matrix_to_string(m : MathspecialhypergeoMatrix) -> String {
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

pub(all) struct MathspecialhypergeoVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_hypergeo_make_vector(comps : Array[Double]) -> MathspecialhypergeoVector {
  { comps, dim: comps.length() }
}

pub fn math_special_hypergeo_vector_zero(dim : Int) -> MathspecialhypergeoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_special_hypergeo_vector_add(a : MathspecialhypergeoVector, b : MathspecialhypergeoVector) -> MathspecialhypergeoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_hypergeo_vector_sub(a : MathspecialhypergeoVector, b : MathspecialhypergeoVector) -> MathspecialhypergeoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_hypergeo_vector_scale(v : MathspecialhypergeoVector, s : Double) -> MathspecialhypergeoVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_special_hypergeo_vector_dot(a : MathspecialhypergeoVector, b : MathspecialhypergeoVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_special_hypergeo_vector_norm(v : MathspecialhypergeoVector) -> Double { @_common.sqrt(math_special_hypergeo_vector_dot(v, v)) }

pub fn math_special_hypergeo_vector_normalize(v : MathspecialhypergeoVector) -> MathspecialhypergeoVector {
  let n = math_special_hypergeo_vector_norm(v)
  if n < 0.0000001 { v } else { math_special_hypergeo_vector_scale(v, 1.0 / n) }
}

pub fn math_special_hypergeo_vector_dist(a : MathspecialhypergeoVector, b : MathspecialhypergeoVector) -> Double {
  math_special_hypergeo_vector_norm(math_special_hypergeo_vector_sub(a, b))
}

pub fn math_special_hypergeo_vector_to_string(v : MathspecialhypergeoVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_hypergeo_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_hypergeo_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_hypergeo_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_hypergeo_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_hypergeo_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_hypergeo_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_hypergeo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_hypergeo_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_hypergeo_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_hypergeo_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_hypergeo_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_hypergeo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_hypergeo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_hypergeo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_hypergeo_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_hypergeo_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_hypergeo_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_hypergeo_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_hypergeo_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_hypergeo_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_hypergeo_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_hypergeo_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_hypergeo_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_hypergeo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_hypergeo_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_hypergeo_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_hypergeo_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_hypergeo_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_hypergeo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspecialhypergeoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_frame_make(size : Int) -> MathspecialhypergeoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_frame_len(s : MathspecialhypergeoFrame) -> Int { s.size }

pub fn math_special_hypergeo_frame_get(s : MathspecialhypergeoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_frame_set(s : MathspecialhypergeoFrame, i : Int, v : Double) -> MathspecialhypergeoFrame {
  let result = math_special_hypergeo_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_frame_sum(s : MathspecialhypergeoFrame) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_frame_mean(s : MathspecialhypergeoFrame) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_frame_scale(s : MathspecialhypergeoFrame, f : Double) -> MathspecialhypergeoFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_frame_add(a : MathspecialhypergeoFrame, b : MathspecialhypergeoFrame) -> MathspecialhypergeoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_frame_copy(s : MathspecialhypergeoFrame) -> MathspecialhypergeoFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_frame_fill(s : MathspecialhypergeoFrame, v : Double) -> MathspecialhypergeoFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_frame_min(s : MathspecialhypergeoFrame) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_frame_max(s : MathspecialhypergeoFrame) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_frame_to_string(s : MathspecialhypergeoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_table_make(size : Int) -> MathspecialhypergeoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_table_len(s : MathspecialhypergeoTable) -> Int { s.size }

pub fn math_special_hypergeo_table_get(s : MathspecialhypergeoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_table_set(s : MathspecialhypergeoTable, i : Int, v : Double) -> MathspecialhypergeoTable {
  let result = math_special_hypergeo_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_table_sum(s : MathspecialhypergeoTable) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_table_mean(s : MathspecialhypergeoTable) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_table_scale(s : MathspecialhypergeoTable, f : Double) -> MathspecialhypergeoTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_table_add(a : MathspecialhypergeoTable, b : MathspecialhypergeoTable) -> MathspecialhypergeoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_table_copy(s : MathspecialhypergeoTable) -> MathspecialhypergeoTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_table_fill(s : MathspecialhypergeoTable, v : Double) -> MathspecialhypergeoTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_table_min(s : MathspecialhypergeoTable) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_table_max(s : MathspecialhypergeoTable) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_table_to_string(s : MathspecialhypergeoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_graphn_make(size : Int) -> MathspecialhypergeoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_graphn_len(s : MathspecialhypergeoGraphN) -> Int { s.size }

pub fn math_special_hypergeo_graphn_get(s : MathspecialhypergeoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_graphn_set(s : MathspecialhypergeoGraphN, i : Int, v : Double) -> MathspecialhypergeoGraphN {
  let result = math_special_hypergeo_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_graphn_sum(s : MathspecialhypergeoGraphN) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_graphn_mean(s : MathspecialhypergeoGraphN) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_graphn_scale(s : MathspecialhypergeoGraphN, f : Double) -> MathspecialhypergeoGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_graphn_add(a : MathspecialhypergeoGraphN, b : MathspecialhypergeoGraphN) -> MathspecialhypergeoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_graphn_copy(s : MathspecialhypergeoGraphN) -> MathspecialhypergeoGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_graphn_fill(s : MathspecialhypergeoGraphN, v : Double) -> MathspecialhypergeoGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_graphn_min(s : MathspecialhypergeoGraphN) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_graphn_max(s : MathspecialhypergeoGraphN) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_graphn_to_string(s : MathspecialhypergeoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_node_make(size : Int) -> MathspecialhypergeoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_node_len(s : MathspecialhypergeoNode) -> Int { s.size }

pub fn math_special_hypergeo_node_get(s : MathspecialhypergeoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_node_set(s : MathspecialhypergeoNode, i : Int, v : Double) -> MathspecialhypergeoNode {
  let result = math_special_hypergeo_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_node_sum(s : MathspecialhypergeoNode) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_node_mean(s : MathspecialhypergeoNode) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_node_scale(s : MathspecialhypergeoNode, f : Double) -> MathspecialhypergeoNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_node_add(a : MathspecialhypergeoNode, b : MathspecialhypergeoNode) -> MathspecialhypergeoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_node_copy(s : MathspecialhypergeoNode) -> MathspecialhypergeoNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_node_fill(s : MathspecialhypergeoNode, v : Double) -> MathspecialhypergeoNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_node_min(s : MathspecialhypergeoNode) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_node_max(s : MathspecialhypergeoNode) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_node_to_string(s : MathspecialhypergeoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_edge_make(size : Int) -> MathspecialhypergeoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_edge_len(s : MathspecialhypergeoEdge) -> Int { s.size }

pub fn math_special_hypergeo_edge_get(s : MathspecialhypergeoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_edge_set(s : MathspecialhypergeoEdge, i : Int, v : Double) -> MathspecialhypergeoEdge {
  let result = math_special_hypergeo_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_edge_sum(s : MathspecialhypergeoEdge) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_edge_mean(s : MathspecialhypergeoEdge) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_edge_scale(s : MathspecialhypergeoEdge, f : Double) -> MathspecialhypergeoEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_edge_add(a : MathspecialhypergeoEdge, b : MathspecialhypergeoEdge) -> MathspecialhypergeoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_edge_copy(s : MathspecialhypergeoEdge) -> MathspecialhypergeoEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_edge_fill(s : MathspecialhypergeoEdge, v : Double) -> MathspecialhypergeoEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_edge_min(s : MathspecialhypergeoEdge) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_edge_max(s : MathspecialhypergeoEdge) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_edge_to_string(s : MathspecialhypergeoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_path_make(size : Int) -> MathspecialhypergeoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_path_len(s : MathspecialhypergeoPath) -> Int { s.size }

pub fn math_special_hypergeo_path_get(s : MathspecialhypergeoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_path_set(s : MathspecialhypergeoPath, i : Int, v : Double) -> MathspecialhypergeoPath {
  let result = math_special_hypergeo_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_path_sum(s : MathspecialhypergeoPath) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_path_mean(s : MathspecialhypergeoPath) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_path_scale(s : MathspecialhypergeoPath, f : Double) -> MathspecialhypergeoPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_path_add(a : MathspecialhypergeoPath, b : MathspecialhypergeoPath) -> MathspecialhypergeoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_path_copy(s : MathspecialhypergeoPath) -> MathspecialhypergeoPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_path_fill(s : MathspecialhypergeoPath, v : Double) -> MathspecialhypergeoPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_path_min(s : MathspecialhypergeoPath) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_path_max(s : MathspecialhypergeoPath) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_path_to_string(s : MathspecialhypergeoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_cluster_make(size : Int) -> MathspecialhypergeoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_cluster_len(s : MathspecialhypergeoCluster) -> Int { s.size }

pub fn math_special_hypergeo_cluster_get(s : MathspecialhypergeoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_cluster_set(s : MathspecialhypergeoCluster, i : Int, v : Double) -> MathspecialhypergeoCluster {
  let result = math_special_hypergeo_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_cluster_sum(s : MathspecialhypergeoCluster) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_cluster_mean(s : MathspecialhypergeoCluster) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_cluster_scale(s : MathspecialhypergeoCluster, f : Double) -> MathspecialhypergeoCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_cluster_add(a : MathspecialhypergeoCluster, b : MathspecialhypergeoCluster) -> MathspecialhypergeoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_cluster_copy(s : MathspecialhypergeoCluster) -> MathspecialhypergeoCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_cluster_fill(s : MathspecialhypergeoCluster, v : Double) -> MathspecialhypergeoCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_cluster_min(s : MathspecialhypergeoCluster) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_cluster_max(s : MathspecialhypergeoCluster) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_cluster_to_string(s : MathspecialhypergeoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_model_make(size : Int) -> MathspecialhypergeoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_model_len(s : MathspecialhypergeoModel) -> Int { s.size }

pub fn math_special_hypergeo_model_get(s : MathspecialhypergeoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_model_set(s : MathspecialhypergeoModel, i : Int, v : Double) -> MathspecialhypergeoModel {
  let result = math_special_hypergeo_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_model_sum(s : MathspecialhypergeoModel) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_model_mean(s : MathspecialhypergeoModel) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_model_scale(s : MathspecialhypergeoModel, f : Double) -> MathspecialhypergeoModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_model_add(a : MathspecialhypergeoModel, b : MathspecialhypergeoModel) -> MathspecialhypergeoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_model_copy(s : MathspecialhypergeoModel) -> MathspecialhypergeoModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_model_fill(s : MathspecialhypergeoModel, v : Double) -> MathspecialhypergeoModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_model_min(s : MathspecialhypergeoModel) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_model_max(s : MathspecialhypergeoModel) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_model_to_string(s : MathspecialhypergeoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_layer_make(size : Int) -> MathspecialhypergeoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_layer_len(s : MathspecialhypergeoLayer) -> Int { s.size }

pub fn math_special_hypergeo_layer_get(s : MathspecialhypergeoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_layer_set(s : MathspecialhypergeoLayer, i : Int, v : Double) -> MathspecialhypergeoLayer {
  let result = math_special_hypergeo_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_layer_sum(s : MathspecialhypergeoLayer) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_layer_mean(s : MathspecialhypergeoLayer) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_layer_scale(s : MathspecialhypergeoLayer, f : Double) -> MathspecialhypergeoLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_layer_add(a : MathspecialhypergeoLayer, b : MathspecialhypergeoLayer) -> MathspecialhypergeoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_layer_copy(s : MathspecialhypergeoLayer) -> MathspecialhypergeoLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_layer_fill(s : MathspecialhypergeoLayer, v : Double) -> MathspecialhypergeoLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_layer_min(s : MathspecialhypergeoLayer) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_layer_max(s : MathspecialhypergeoLayer) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_layer_to_string(s : MathspecialhypergeoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_buffer_make(size : Int) -> MathspecialhypergeoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_buffer_len(s : MathspecialhypergeoBuffer) -> Int { s.size }

pub fn math_special_hypergeo_buffer_get(s : MathspecialhypergeoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_buffer_set(s : MathspecialhypergeoBuffer, i : Int, v : Double) -> MathspecialhypergeoBuffer {
  let result = math_special_hypergeo_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_buffer_sum(s : MathspecialhypergeoBuffer) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_buffer_mean(s : MathspecialhypergeoBuffer) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_buffer_scale(s : MathspecialhypergeoBuffer, f : Double) -> MathspecialhypergeoBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_buffer_add(a : MathspecialhypergeoBuffer, b : MathspecialhypergeoBuffer) -> MathspecialhypergeoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_buffer_copy(s : MathspecialhypergeoBuffer) -> MathspecialhypergeoBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_buffer_fill(s : MathspecialhypergeoBuffer, v : Double) -> MathspecialhypergeoBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_buffer_min(s : MathspecialhypergeoBuffer) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_buffer_max(s : MathspecialhypergeoBuffer) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_buffer_to_string(s : MathspecialhypergeoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_cursor_make(size : Int) -> MathspecialhypergeoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_cursor_len(s : MathspecialhypergeoCursor) -> Int { s.size }

pub fn math_special_hypergeo_cursor_get(s : MathspecialhypergeoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_cursor_set(s : MathspecialhypergeoCursor, i : Int, v : Double) -> MathspecialhypergeoCursor {
  let result = math_special_hypergeo_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_cursor_sum(s : MathspecialhypergeoCursor) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_cursor_mean(s : MathspecialhypergeoCursor) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_cursor_scale(s : MathspecialhypergeoCursor, f : Double) -> MathspecialhypergeoCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_cursor_add(a : MathspecialhypergeoCursor, b : MathspecialhypergeoCursor) -> MathspecialhypergeoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_cursor_copy(s : MathspecialhypergeoCursor) -> MathspecialhypergeoCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_cursor_fill(s : MathspecialhypergeoCursor, v : Double) -> MathspecialhypergeoCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_cursor_min(s : MathspecialhypergeoCursor) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_cursor_max(s : MathspecialhypergeoCursor) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_cursor_to_string(s : MathspecialhypergeoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_view_make(size : Int) -> MathspecialhypergeoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_view_len(s : MathspecialhypergeoView) -> Int { s.size }

pub fn math_special_hypergeo_view_get(s : MathspecialhypergeoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_view_set(s : MathspecialhypergeoView, i : Int, v : Double) -> MathspecialhypergeoView {
  let result = math_special_hypergeo_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_view_sum(s : MathspecialhypergeoView) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_view_mean(s : MathspecialhypergeoView) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_view_scale(s : MathspecialhypergeoView, f : Double) -> MathspecialhypergeoView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_view_add(a : MathspecialhypergeoView, b : MathspecialhypergeoView) -> MathspecialhypergeoView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_view_copy(s : MathspecialhypergeoView) -> MathspecialhypergeoView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_view_fill(s : MathspecialhypergeoView, v : Double) -> MathspecialhypergeoView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_view_min(s : MathspecialhypergeoView) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_view_max(s : MathspecialhypergeoView) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_view_to_string(s : MathspecialhypergeoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_range_make(size : Int) -> MathspecialhypergeoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_range_len(s : MathspecialhypergeoRange) -> Int { s.size }

pub fn math_special_hypergeo_range_get(s : MathspecialhypergeoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_range_set(s : MathspecialhypergeoRange, i : Int, v : Double) -> MathspecialhypergeoRange {
  let result = math_special_hypergeo_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_range_sum(s : MathspecialhypergeoRange) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_range_mean(s : MathspecialhypergeoRange) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_range_scale(s : MathspecialhypergeoRange, f : Double) -> MathspecialhypergeoRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_range_add(a : MathspecialhypergeoRange, b : MathspecialhypergeoRange) -> MathspecialhypergeoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_range_copy(s : MathspecialhypergeoRange) -> MathspecialhypergeoRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_range_fill(s : MathspecialhypergeoRange, v : Double) -> MathspecialhypergeoRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_range_min(s : MathspecialhypergeoRange) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_range_max(s : MathspecialhypergeoRange) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_range_to_string(s : MathspecialhypergeoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialhypergeoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hypergeo_slice_make(size : Int) -> MathspecialhypergeoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_hypergeo_slice_len(s : MathspecialhypergeoSlice) -> Int { s.size }

pub fn math_special_hypergeo_slice_get(s : MathspecialhypergeoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_hypergeo_slice_set(s : MathspecialhypergeoSlice, i : Int, v : Double) -> MathspecialhypergeoSlice {
  let result = math_special_hypergeo_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_hypergeo_slice_sum(s : MathspecialhypergeoSlice) -> Double { @_common.sum(s.data) }

pub fn math_special_hypergeo_slice_mean(s : MathspecialhypergeoSlice) -> Double { @_common.mean(s.data) }

pub fn math_special_hypergeo_slice_scale(s : MathspecialhypergeoSlice, f : Double) -> MathspecialhypergeoSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_slice_add(a : MathspecialhypergeoSlice, b : MathspecialhypergeoSlice) -> MathspecialhypergeoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_hypergeo_slice_copy(s : MathspecialhypergeoSlice) -> MathspecialhypergeoSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_slice_fill(s : MathspecialhypergeoSlice, v : Double) -> MathspecialhypergeoSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_hypergeo_slice_min(s : MathspecialhypergeoSlice) -> Double { @_common.min(s.data) }

pub fn math_special_hypergeo_slice_max(s : MathspecialhypergeoSlice) -> Double { @_common.max(s.data) }

pub fn math_special_hypergeo_slice_to_string(s : MathspecialhypergeoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

