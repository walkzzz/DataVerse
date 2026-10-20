///===
/// extcore/math_special_zeta

pub(all) struct MathspecialzetaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_zeta_make_point(x : Double, y : Double) -> MathspecialzetaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_zeta_make_point3(x : Double, y : Double, z : Double) -> MathspecialzetaPoint {
  { x, y, z, label: 0 }
}

pub fn math_special_zeta_point_x(pt : MathspecialzetaPoint) -> Double { pt.x }

pub fn math_special_zeta_point_y(pt : MathspecialzetaPoint) -> Double { pt.y }

pub fn math_special_zeta_point_z(pt : MathspecialzetaPoint) -> Double { pt.z }

pub fn math_special_zeta_point_label(pt : MathspecialzetaPoint) -> Int { pt.label }

pub fn math_special_zeta_point_dist(a : MathspecialzetaPoint, b : MathspecialzetaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_special_zeta_point_add(a : MathspecialzetaPoint, b : MathspecialzetaPoint) -> MathspecialzetaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_special_zeta_point_sub(a : MathspecialzetaPoint, b : MathspecialzetaPoint) -> MathspecialzetaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_special_zeta_point_scale(pt : MathspecialzetaPoint, s : Double) -> MathspecialzetaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_special_zeta_point_dot(a : MathspecialzetaPoint, b : MathspecialzetaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_special_zeta_point_cross(a : MathspecialzetaPoint, b : MathspecialzetaPoint) -> MathspecialzetaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_special_zeta_point_norm(pt : MathspecialzetaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_special_zeta_point_normalize(pt : MathspecialzetaPoint) -> MathspecialzetaPoint {
  let n = math_special_zeta_point_norm(pt)
  if n < 0.0000001 { pt } else { math_special_zeta_point_scale(pt, 1.0 / n) }
}

pub fn math_special_zeta_point_negate(pt : MathspecialzetaPoint) -> MathspecialzetaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_special_zeta_point_mid(a : MathspecialzetaPoint, b : MathspecialzetaPoint) -> MathspecialzetaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_special_zeta_point_lerp(a : MathspecialzetaPoint, b : MathspecialzetaPoint, t : Double) -> MathspecialzetaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_special_zeta_point_to_string(pt : MathspecialzetaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathspecialzetaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_zeta_make_series(vals : Array[Double], name : String) -> MathspecialzetaSeries {
  { vals, name, meta: 0 }
}

pub fn math_special_zeta_series_len(s : MathspecialzetaSeries) -> Int { s.vals.length() }

pub fn math_special_zeta_series_sum(s : MathspecialzetaSeries) -> Double { @_common.sum(s.vals) }

pub fn math_special_zeta_series_mean(s : MathspecialzetaSeries) -> Double { @_common.mean(s.vals) }

pub fn math_special_zeta_series_min(s : MathspecialzetaSeries) -> Double { @_common.min(s.vals) }

pub fn math_special_zeta_series_max(s : MathspecialzetaSeries) -> Double { @_common.max(s.vals) }

pub fn math_special_zeta_series_range(s : MathspecialzetaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_special_zeta_series_var(s : MathspecialzetaSeries) -> Double { @_common.variance(s.vals) }

pub fn math_special_zeta_series_std(s : MathspecialzetaSeries) -> Double { @_common.std(s.vals) }

pub fn math_special_zeta_series_median(s : MathspecialzetaSeries) -> Double { @_common.median(s.vals) }

pub fn math_special_zeta_series_scale(s : MathspecialzetaSeries, f : Double) -> MathspecialzetaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_special_zeta_series_add(a : MathspecialzetaSeries, b : MathspecialzetaSeries) -> MathspecialzetaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_special_zeta_series_sub(a : MathspecialzetaSeries, b : MathspecialzetaSeries) -> MathspecialzetaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_special_zeta_series_normalize(s : MathspecialzetaSeries) -> MathspecialzetaSeries {
  let mn = math_special_zeta_series_min(s)
  let mx = math_special_zeta_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_special_zeta_series_cumsum(s : MathspecialzetaSeries) -> MathspecialzetaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_special_zeta_series_to_string(s : MathspecialzetaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialzetaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_zeta_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialzetaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_zeta_matrix_identity(n : Int) -> MathspecialzetaMatrix {
  let m = math_special_zeta_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_special_zeta_matrix_get(m : MathspecialzetaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_special_zeta_matrix_transpose(m : MathspecialzetaMatrix) -> MathspecialzetaMatrix {
  let result = math_special_zeta_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_special_zeta_matrix_add(a : MathspecialzetaMatrix, b : MathspecialzetaMatrix) -> MathspecialzetaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_special_zeta_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_special_zeta_matrix_scale(m : MathspecialzetaMatrix, s : Double) -> MathspecialzetaMatrix {
  let result = math_special_zeta_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_special_zeta_matrix_multiply(a : MathspecialzetaMatrix, b : MathspecialzetaMatrix) -> MathspecialzetaMatrix {
  if a.cols != b.rows { return math_special_zeta_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_special_zeta_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_special_zeta_matrix_trace(m : MathspecialzetaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_special_zeta_matrix_det(m : MathspecialzetaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_special_zeta_matrix_norm(m : MathspecialzetaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_special_zeta_matrix_to_string(m : MathspecialzetaMatrix) -> String {
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

pub(all) struct MathspecialzetaVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_zeta_make_vector(comps : Array[Double]) -> MathspecialzetaVector {
  { comps, dim: comps.length() }
}

pub fn math_special_zeta_vector_zero(dim : Int) -> MathspecialzetaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_special_zeta_vector_add(a : MathspecialzetaVector, b : MathspecialzetaVector) -> MathspecialzetaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_zeta_vector_sub(a : MathspecialzetaVector, b : MathspecialzetaVector) -> MathspecialzetaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_zeta_vector_scale(v : MathspecialzetaVector, s : Double) -> MathspecialzetaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_special_zeta_vector_dot(a : MathspecialzetaVector, b : MathspecialzetaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_special_zeta_vector_norm(v : MathspecialzetaVector) -> Double { @_common.sqrt(math_special_zeta_vector_dot(v, v)) }

pub fn math_special_zeta_vector_normalize(v : MathspecialzetaVector) -> MathspecialzetaVector {
  let n = math_special_zeta_vector_norm(v)
  if n < 0.0000001 { v } else { math_special_zeta_vector_scale(v, 1.0 / n) }
}

pub fn math_special_zeta_vector_dist(a : MathspecialzetaVector, b : MathspecialzetaVector) -> Double {
  math_special_zeta_vector_norm(math_special_zeta_vector_sub(a, b))
}

pub fn math_special_zeta_vector_to_string(v : MathspecialzetaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_zeta_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_zeta_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_zeta_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_zeta_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_zeta_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_zeta_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_zeta_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_zeta_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_zeta_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_zeta_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_zeta_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_zeta_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_zeta_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_zeta_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_zeta_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_zeta_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_zeta_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_zeta_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_zeta_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_zeta_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_zeta_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_zeta_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_zeta_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_zeta_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_zeta_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_zeta_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_zeta_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_zeta_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_zeta_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspecialzetaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_frame_make(size : Int) -> MathspecialzetaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_frame_len(s : MathspecialzetaFrame) -> Int { s.size }

pub fn math_special_zeta_frame_get(s : MathspecialzetaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_frame_set(s : MathspecialzetaFrame, i : Int, v : Double) -> MathspecialzetaFrame {
  let result = math_special_zeta_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_frame_sum(s : MathspecialzetaFrame) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_frame_mean(s : MathspecialzetaFrame) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_frame_scale(s : MathspecialzetaFrame, f : Double) -> MathspecialzetaFrame {
  let result = math_special_zeta_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_zeta_frame_add(a : MathspecialzetaFrame, b : MathspecialzetaFrame) -> MathspecialzetaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_zeta_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_zeta_frame_copy(s : MathspecialzetaFrame) -> MathspecialzetaFrame {
  let result = math_special_zeta_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_zeta_frame_fill(s : MathspecialzetaFrame, v : Double) -> MathspecialzetaFrame {
  let result = math_special_zeta_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_frame_min(s : MathspecialzetaFrame) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_frame_max(s : MathspecialzetaFrame) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_frame_to_string(s : MathspecialzetaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_table_make(size : Int) -> MathspecialzetaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_table_len(s : MathspecialzetaTable) -> Int { s.size }

pub fn math_special_zeta_table_get(s : MathspecialzetaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_table_set(s : MathspecialzetaTable, i : Int, v : Double) -> MathspecialzetaTable {
  let result = math_special_zeta_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_table_sum(s : MathspecialzetaTable) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_table_mean(s : MathspecialzetaTable) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_table_scale(s : MathspecialzetaTable, f : Double) -> MathspecialzetaTable {
  let result = math_special_zeta_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_zeta_table_add(a : MathspecialzetaTable, b : MathspecialzetaTable) -> MathspecialzetaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_zeta_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_zeta_table_copy(s : MathspecialzetaTable) -> MathspecialzetaTable {
  let result = math_special_zeta_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_zeta_table_fill(s : MathspecialzetaTable, v : Double) -> MathspecialzetaTable {
  let result = math_special_zeta_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_table_min(s : MathspecialzetaTable) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_table_max(s : MathspecialzetaTable) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_table_to_string(s : MathspecialzetaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_graphn_make(size : Int) -> MathspecialzetaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_graphn_len(s : MathspecialzetaGraphN) -> Int { s.size }

pub fn math_special_zeta_graphn_get(s : MathspecialzetaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_graphn_set(s : MathspecialzetaGraphN, i : Int, v : Double) -> MathspecialzetaGraphN {
  let result = math_special_zeta_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_graphn_sum(s : MathspecialzetaGraphN) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_graphn_mean(s : MathspecialzetaGraphN) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_graphn_scale(s : MathspecialzetaGraphN, f : Double) -> MathspecialzetaGraphN {
  let result = math_special_zeta_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_zeta_graphn_add(a : MathspecialzetaGraphN, b : MathspecialzetaGraphN) -> MathspecialzetaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_zeta_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_zeta_graphn_copy(s : MathspecialzetaGraphN) -> MathspecialzetaGraphN {
  let result = math_special_zeta_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_zeta_graphn_fill(s : MathspecialzetaGraphN, v : Double) -> MathspecialzetaGraphN {
  let result = math_special_zeta_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_graphn_min(s : MathspecialzetaGraphN) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_graphn_max(s : MathspecialzetaGraphN) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_graphn_to_string(s : MathspecialzetaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_node_make(size : Int) -> MathspecialzetaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_node_len(s : MathspecialzetaNode) -> Int { s.size }

pub fn math_special_zeta_node_get(s : MathspecialzetaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_node_set(s : MathspecialzetaNode, i : Int, v : Double) -> MathspecialzetaNode {
  let result = math_special_zeta_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_node_sum(s : MathspecialzetaNode) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_node_mean(s : MathspecialzetaNode) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_node_scale(s : MathspecialzetaNode, f : Double) -> MathspecialzetaNode {
  let result = math_special_zeta_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_zeta_node_add(a : MathspecialzetaNode, b : MathspecialzetaNode) -> MathspecialzetaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_zeta_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_zeta_node_copy(s : MathspecialzetaNode) -> MathspecialzetaNode {
  let result = math_special_zeta_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_zeta_node_fill(s : MathspecialzetaNode, v : Double) -> MathspecialzetaNode {
  let result = math_special_zeta_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_node_min(s : MathspecialzetaNode) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_node_max(s : MathspecialzetaNode) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_node_to_string(s : MathspecialzetaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_edge_make(size : Int) -> MathspecialzetaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_edge_len(s : MathspecialzetaEdge) -> Int { s.size }

pub fn math_special_zeta_edge_get(s : MathspecialzetaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_edge_set(s : MathspecialzetaEdge, i : Int, v : Double) -> MathspecialzetaEdge {
  let result = math_special_zeta_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_edge_sum(s : MathspecialzetaEdge) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_edge_mean(s : MathspecialzetaEdge) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_edge_scale(s : MathspecialzetaEdge, f : Double) -> MathspecialzetaEdge {
  let result = math_special_zeta_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_zeta_edge_add(a : MathspecialzetaEdge, b : MathspecialzetaEdge) -> MathspecialzetaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_zeta_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_zeta_edge_copy(s : MathspecialzetaEdge) -> MathspecialzetaEdge {
  let result = math_special_zeta_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_zeta_edge_fill(s : MathspecialzetaEdge, v : Double) -> MathspecialzetaEdge {
  let result = math_special_zeta_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_edge_min(s : MathspecialzetaEdge) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_edge_max(s : MathspecialzetaEdge) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_edge_to_string(s : MathspecialzetaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_path_make(size : Int) -> MathspecialzetaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_path_len(s : MathspecialzetaPath) -> Int { s.size }

pub fn math_special_zeta_path_get(s : MathspecialzetaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_path_set(s : MathspecialzetaPath, i : Int, v : Double) -> MathspecialzetaPath {
  let result = math_special_zeta_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_path_sum(s : MathspecialzetaPath) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_path_mean(s : MathspecialzetaPath) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_path_scale(s : MathspecialzetaPath, f : Double) -> MathspecialzetaPath {
  let result = math_special_zeta_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_zeta_path_add(a : MathspecialzetaPath, b : MathspecialzetaPath) -> MathspecialzetaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_zeta_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_zeta_path_copy(s : MathspecialzetaPath) -> MathspecialzetaPath {
  let result = math_special_zeta_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_zeta_path_fill(s : MathspecialzetaPath, v : Double) -> MathspecialzetaPath {
  let result = math_special_zeta_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_path_min(s : MathspecialzetaPath) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_path_max(s : MathspecialzetaPath) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_path_to_string(s : MathspecialzetaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_cluster_make(size : Int) -> MathspecialzetaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_cluster_len(s : MathspecialzetaCluster) -> Int { s.size }

pub fn math_special_zeta_cluster_get(s : MathspecialzetaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_cluster_set(s : MathspecialzetaCluster, i : Int, v : Double) -> MathspecialzetaCluster {
  let result = math_special_zeta_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_cluster_sum(s : MathspecialzetaCluster) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_cluster_mean(s : MathspecialzetaCluster) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_cluster_scale(s : MathspecialzetaCluster, f : Double) -> MathspecialzetaCluster {
  let result = math_special_zeta_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_zeta_cluster_add(a : MathspecialzetaCluster, b : MathspecialzetaCluster) -> MathspecialzetaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_zeta_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_zeta_cluster_copy(s : MathspecialzetaCluster) -> MathspecialzetaCluster {
  let result = math_special_zeta_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_zeta_cluster_fill(s : MathspecialzetaCluster, v : Double) -> MathspecialzetaCluster {
  let result = math_special_zeta_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_cluster_min(s : MathspecialzetaCluster) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_cluster_max(s : MathspecialzetaCluster) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_cluster_to_string(s : MathspecialzetaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_model_make(size : Int) -> MathspecialzetaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_model_len(s : MathspecialzetaModel) -> Int { s.size }

pub fn math_special_zeta_model_get(s : MathspecialzetaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_model_set(s : MathspecialzetaModel, i : Int, v : Double) -> MathspecialzetaModel {
  let result = math_special_zeta_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_model_sum(s : MathspecialzetaModel) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_model_mean(s : MathspecialzetaModel) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_model_scale(s : MathspecialzetaModel, f : Double) -> MathspecialzetaModel {
  let result = math_special_zeta_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_zeta_model_add(a : MathspecialzetaModel, b : MathspecialzetaModel) -> MathspecialzetaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_zeta_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_zeta_model_copy(s : MathspecialzetaModel) -> MathspecialzetaModel {
  let result = math_special_zeta_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_zeta_model_fill(s : MathspecialzetaModel, v : Double) -> MathspecialzetaModel {
  let result = math_special_zeta_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_model_min(s : MathspecialzetaModel) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_model_max(s : MathspecialzetaModel) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_model_to_string(s : MathspecialzetaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_layer_make(size : Int) -> MathspecialzetaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_layer_len(s : MathspecialzetaLayer) -> Int { s.size }

pub fn math_special_zeta_layer_get(s : MathspecialzetaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_layer_set(s : MathspecialzetaLayer, i : Int, v : Double) -> MathspecialzetaLayer {
  let result = math_special_zeta_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_layer_sum(s : MathspecialzetaLayer) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_layer_mean(s : MathspecialzetaLayer) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_layer_scale(s : MathspecialzetaLayer, f : Double) -> MathspecialzetaLayer {
  let result = math_special_zeta_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_zeta_layer_add(a : MathspecialzetaLayer, b : MathspecialzetaLayer) -> MathspecialzetaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_zeta_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_zeta_layer_copy(s : MathspecialzetaLayer) -> MathspecialzetaLayer {
  let result = math_special_zeta_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_zeta_layer_fill(s : MathspecialzetaLayer, v : Double) -> MathspecialzetaLayer {
  let result = math_special_zeta_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_layer_min(s : MathspecialzetaLayer) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_layer_max(s : MathspecialzetaLayer) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_layer_to_string(s : MathspecialzetaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_buffer_make(size : Int) -> MathspecialzetaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_buffer_len(s : MathspecialzetaBuffer) -> Int { s.size }

pub fn math_special_zeta_buffer_get(s : MathspecialzetaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_buffer_set(s : MathspecialzetaBuffer, i : Int, v : Double) -> MathspecialzetaBuffer {
  let result = math_special_zeta_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_buffer_sum(s : MathspecialzetaBuffer) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_buffer_mean(s : MathspecialzetaBuffer) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_buffer_scale(s : MathspecialzetaBuffer, f : Double) -> MathspecialzetaBuffer {
  let result = math_special_zeta_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_zeta_buffer_add(a : MathspecialzetaBuffer, b : MathspecialzetaBuffer) -> MathspecialzetaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_zeta_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_zeta_buffer_copy(s : MathspecialzetaBuffer) -> MathspecialzetaBuffer {
  let result = math_special_zeta_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_zeta_buffer_fill(s : MathspecialzetaBuffer, v : Double) -> MathspecialzetaBuffer {
  let result = math_special_zeta_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_buffer_min(s : MathspecialzetaBuffer) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_buffer_max(s : MathspecialzetaBuffer) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_buffer_to_string(s : MathspecialzetaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_cursor_make(size : Int) -> MathspecialzetaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_cursor_len(s : MathspecialzetaCursor) -> Int { s.size }

pub fn math_special_zeta_cursor_get(s : MathspecialzetaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_cursor_set(s : MathspecialzetaCursor, i : Int, v : Double) -> MathspecialzetaCursor {
  let result = math_special_zeta_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_cursor_sum(s : MathspecialzetaCursor) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_cursor_mean(s : MathspecialzetaCursor) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_cursor_scale(s : MathspecialzetaCursor, f : Double) -> MathspecialzetaCursor {
  let result = math_special_zeta_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_zeta_cursor_add(a : MathspecialzetaCursor, b : MathspecialzetaCursor) -> MathspecialzetaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_zeta_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_zeta_cursor_copy(s : MathspecialzetaCursor) -> MathspecialzetaCursor {
  let result = math_special_zeta_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_zeta_cursor_fill(s : MathspecialzetaCursor, v : Double) -> MathspecialzetaCursor {
  let result = math_special_zeta_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_cursor_min(s : MathspecialzetaCursor) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_cursor_max(s : MathspecialzetaCursor) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_cursor_to_string(s : MathspecialzetaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_view_make(size : Int) -> MathspecialzetaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_view_len(s : MathspecialzetaView) -> Int { s.size }

pub fn math_special_zeta_view_get(s : MathspecialzetaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_view_set(s : MathspecialzetaView, i : Int, v : Double) -> MathspecialzetaView {
  let result = math_special_zeta_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_view_sum(s : MathspecialzetaView) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_view_mean(s : MathspecialzetaView) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_view_scale(s : MathspecialzetaView, f : Double) -> MathspecialzetaView {
  let result = math_special_zeta_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_zeta_view_add(a : MathspecialzetaView, b : MathspecialzetaView) -> MathspecialzetaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_zeta_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_zeta_view_copy(s : MathspecialzetaView) -> MathspecialzetaView {
  let result = math_special_zeta_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_zeta_view_fill(s : MathspecialzetaView, v : Double) -> MathspecialzetaView {
  let result = math_special_zeta_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_view_min(s : MathspecialzetaView) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_view_max(s : MathspecialzetaView) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_view_to_string(s : MathspecialzetaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_range_make(size : Int) -> MathspecialzetaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_range_len(s : MathspecialzetaRange) -> Int { s.size }

pub fn math_special_zeta_range_get(s : MathspecialzetaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_range_set(s : MathspecialzetaRange, i : Int, v : Double) -> MathspecialzetaRange {
  let result = math_special_zeta_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_range_sum(s : MathspecialzetaRange) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_range_mean(s : MathspecialzetaRange) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_range_scale(s : MathspecialzetaRange, f : Double) -> MathspecialzetaRange {
  let result = math_special_zeta_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_zeta_range_add(a : MathspecialzetaRange, b : MathspecialzetaRange) -> MathspecialzetaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_zeta_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_zeta_range_copy(s : MathspecialzetaRange) -> MathspecialzetaRange {
  let result = math_special_zeta_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_zeta_range_fill(s : MathspecialzetaRange, v : Double) -> MathspecialzetaRange {
  let result = math_special_zeta_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_range_min(s : MathspecialzetaRange) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_range_max(s : MathspecialzetaRange) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_range_to_string(s : MathspecialzetaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialzetaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_zeta_slice_make(size : Int) -> MathspecialzetaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_zeta_slice_len(s : MathspecialzetaSlice) -> Int { s.size }

pub fn math_special_zeta_slice_get(s : MathspecialzetaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_zeta_slice_set(s : MathspecialzetaSlice, i : Int, v : Double) -> MathspecialzetaSlice {
  let result = math_special_zeta_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_slice_sum(s : MathspecialzetaSlice) -> Double { @_common.sum(s.data) }

pub fn math_special_zeta_slice_mean(s : MathspecialzetaSlice) -> Double { @_common.mean(s.data) }

pub fn math_special_zeta_slice_scale(s : MathspecialzetaSlice, f : Double) -> MathspecialzetaSlice {
  let result = math_special_zeta_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_zeta_slice_add(a : MathspecialzetaSlice, b : MathspecialzetaSlice) -> MathspecialzetaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_zeta_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_zeta_slice_copy(s : MathspecialzetaSlice) -> MathspecialzetaSlice {
  let result = math_special_zeta_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_zeta_slice_fill(s : MathspecialzetaSlice, v : Double) -> MathspecialzetaSlice {
  let result = math_special_zeta_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_zeta_slice_min(s : MathspecialzetaSlice) -> Double { @_common.min(s.data) }

pub fn math_special_zeta_slice_max(s : MathspecialzetaSlice) -> Double { @_common.max(s.data) }

pub fn math_special_zeta_slice_to_string(s : MathspecialzetaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

