///===
/// extcore/math_special_gamma

pub(all) struct MathspecialgammaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_gamma_make_point(x : Double, y : Double) -> MathspecialgammaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_gamma_make_point3(x : Double, y : Double, z : Double) -> MathspecialgammaPoint {
  { x, y, z, label: 0 }
}

pub fn math_special_gamma_point_x(pt : MathspecialgammaPoint) -> Double { pt.x }

pub fn math_special_gamma_point_y(pt : MathspecialgammaPoint) -> Double { pt.y }

pub fn math_special_gamma_point_z(pt : MathspecialgammaPoint) -> Double { pt.z }

pub fn math_special_gamma_point_label(pt : MathspecialgammaPoint) -> Int { pt.label }

pub fn math_special_gamma_point_dist(a : MathspecialgammaPoint, b : MathspecialgammaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_special_gamma_point_add(a : MathspecialgammaPoint, b : MathspecialgammaPoint) -> MathspecialgammaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_special_gamma_point_sub(a : MathspecialgammaPoint, b : MathspecialgammaPoint) -> MathspecialgammaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_special_gamma_point_scale(pt : MathspecialgammaPoint, s : Double) -> MathspecialgammaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_special_gamma_point_dot(a : MathspecialgammaPoint, b : MathspecialgammaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_special_gamma_point_cross(a : MathspecialgammaPoint, b : MathspecialgammaPoint) -> MathspecialgammaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_special_gamma_point_norm(pt : MathspecialgammaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_special_gamma_point_normalize(pt : MathspecialgammaPoint) -> MathspecialgammaPoint {
  let n = math_special_gamma_point_norm(pt)
  if n < 0.0000001 { pt } else { math_special_gamma_point_scale(pt, 1.0 / n) }
}

pub fn math_special_gamma_point_negate(pt : MathspecialgammaPoint) -> MathspecialgammaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_special_gamma_point_mid(a : MathspecialgammaPoint, b : MathspecialgammaPoint) -> MathspecialgammaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_special_gamma_point_lerp(a : MathspecialgammaPoint, b : MathspecialgammaPoint, t : Double) -> MathspecialgammaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_special_gamma_point_to_string(pt : MathspecialgammaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathspecialgammaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_gamma_make_series(vals : Array[Double], name : String) -> MathspecialgammaSeries {
  { vals, name, meta: 0 }
}

pub fn math_special_gamma_series_len(s : MathspecialgammaSeries) -> Int { s.vals.length() }

pub fn math_special_gamma_series_sum(s : MathspecialgammaSeries) -> Double { @_common.sum(s.vals) }

pub fn math_special_gamma_series_mean(s : MathspecialgammaSeries) -> Double { @_common.mean(s.vals) }

pub fn math_special_gamma_series_min(s : MathspecialgammaSeries) -> Double { @_common.min(s.vals) }

pub fn math_special_gamma_series_max(s : MathspecialgammaSeries) -> Double { @_common.max(s.vals) }

pub fn math_special_gamma_series_range(s : MathspecialgammaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_special_gamma_series_var(s : MathspecialgammaSeries) -> Double { @_common.variance(s.vals) }

pub fn math_special_gamma_series_std(s : MathspecialgammaSeries) -> Double { @_common.std(s.vals) }

pub fn math_special_gamma_series_median(s : MathspecialgammaSeries) -> Double { @_common.median(s.vals) }

pub fn math_special_gamma_series_scale(s : MathspecialgammaSeries, f : Double) -> MathspecialgammaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_special_gamma_series_add(a : MathspecialgammaSeries, b : MathspecialgammaSeries) -> MathspecialgammaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_special_gamma_series_sub(a : MathspecialgammaSeries, b : MathspecialgammaSeries) -> MathspecialgammaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_special_gamma_series_normalize(s : MathspecialgammaSeries) -> MathspecialgammaSeries {
  let mn = math_special_gamma_series_min(s)
  let mx = math_special_gamma_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_special_gamma_series_cumsum(s : MathspecialgammaSeries) -> MathspecialgammaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_special_gamma_series_to_string(s : MathspecialgammaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialgammaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_gamma_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialgammaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_gamma_matrix_identity(n : Int) -> MathspecialgammaMatrix {
  let m = math_special_gamma_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_special_gamma_matrix_get(m : MathspecialgammaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_special_gamma_matrix_transpose(m : MathspecialgammaMatrix) -> MathspecialgammaMatrix {
  let result = math_special_gamma_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_special_gamma_matrix_add(a : MathspecialgammaMatrix, b : MathspecialgammaMatrix) -> MathspecialgammaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_special_gamma_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_special_gamma_matrix_scale(m : MathspecialgammaMatrix, s : Double) -> MathspecialgammaMatrix {
  let result = math_special_gamma_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_special_gamma_matrix_multiply(a : MathspecialgammaMatrix, b : MathspecialgammaMatrix) -> MathspecialgammaMatrix {
  if a.cols != b.rows { return math_special_gamma_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_special_gamma_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_special_gamma_matrix_trace(m : MathspecialgammaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_special_gamma_matrix_det(m : MathspecialgammaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_special_gamma_matrix_norm(m : MathspecialgammaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_special_gamma_matrix_to_string(m : MathspecialgammaMatrix) -> String {
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

pub(all) struct MathspecialgammaVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_gamma_make_vector(comps : Array[Double]) -> MathspecialgammaVector {
  { comps, dim: comps.length() }
}

pub fn math_special_gamma_vector_zero(dim : Int) -> MathspecialgammaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_special_gamma_vector_add(a : MathspecialgammaVector, b : MathspecialgammaVector) -> MathspecialgammaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_gamma_vector_sub(a : MathspecialgammaVector, b : MathspecialgammaVector) -> MathspecialgammaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_gamma_vector_scale(v : MathspecialgammaVector, s : Double) -> MathspecialgammaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_special_gamma_vector_dot(a : MathspecialgammaVector, b : MathspecialgammaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_special_gamma_vector_norm(v : MathspecialgammaVector) -> Double { @_common.sqrt(math_special_gamma_vector_dot(v, v)) }

pub fn math_special_gamma_vector_normalize(v : MathspecialgammaVector) -> MathspecialgammaVector {
  let n = math_special_gamma_vector_norm(v)
  if n < 0.0000001 { v } else { math_special_gamma_vector_scale(v, 1.0 / n) }
}

pub fn math_special_gamma_vector_dist(a : MathspecialgammaVector, b : MathspecialgammaVector) -> Double {
  math_special_gamma_vector_norm(math_special_gamma_vector_sub(a, b))
}

pub fn math_special_gamma_vector_to_string(v : MathspecialgammaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_gamma_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_gamma_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_gamma_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_gamma_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_gamma_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_gamma_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_gamma_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_gamma_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_gamma_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_gamma_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_gamma_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_gamma_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_gamma_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_gamma_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_gamma_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_gamma_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_gamma_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_gamma_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_gamma_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_gamma_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_gamma_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_gamma_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_gamma_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_gamma_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_gamma_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_gamma_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_gamma_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_gamma_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_gamma_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspecialgammaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_frame_make(size : Int) -> MathspecialgammaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_frame_len(s : MathspecialgammaFrame) -> Int { s.size }

pub fn math_special_gamma_frame_get(s : MathspecialgammaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_frame_set(s : MathspecialgammaFrame, i : Int, v : Double) -> MathspecialgammaFrame {
  let result = math_special_gamma_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_frame_sum(s : MathspecialgammaFrame) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_frame_mean(s : MathspecialgammaFrame) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_frame_scale(s : MathspecialgammaFrame, f : Double) -> MathspecialgammaFrame {
  let result = math_special_gamma_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_gamma_frame_add(a : MathspecialgammaFrame, b : MathspecialgammaFrame) -> MathspecialgammaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_gamma_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_gamma_frame_copy(s : MathspecialgammaFrame) -> MathspecialgammaFrame {
  let result = math_special_gamma_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_gamma_frame_fill(s : MathspecialgammaFrame, v : Double) -> MathspecialgammaFrame {
  let result = math_special_gamma_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_frame_min(s : MathspecialgammaFrame) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_frame_max(s : MathspecialgammaFrame) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_frame_to_string(s : MathspecialgammaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_table_make(size : Int) -> MathspecialgammaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_table_len(s : MathspecialgammaTable) -> Int { s.size }

pub fn math_special_gamma_table_get(s : MathspecialgammaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_table_set(s : MathspecialgammaTable, i : Int, v : Double) -> MathspecialgammaTable {
  let result = math_special_gamma_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_table_sum(s : MathspecialgammaTable) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_table_mean(s : MathspecialgammaTable) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_table_scale(s : MathspecialgammaTable, f : Double) -> MathspecialgammaTable {
  let result = math_special_gamma_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_gamma_table_add(a : MathspecialgammaTable, b : MathspecialgammaTable) -> MathspecialgammaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_gamma_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_gamma_table_copy(s : MathspecialgammaTable) -> MathspecialgammaTable {
  let result = math_special_gamma_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_gamma_table_fill(s : MathspecialgammaTable, v : Double) -> MathspecialgammaTable {
  let result = math_special_gamma_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_table_min(s : MathspecialgammaTable) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_table_max(s : MathspecialgammaTable) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_table_to_string(s : MathspecialgammaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_graphn_make(size : Int) -> MathspecialgammaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_graphn_len(s : MathspecialgammaGraphN) -> Int { s.size }

pub fn math_special_gamma_graphn_get(s : MathspecialgammaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_graphn_set(s : MathspecialgammaGraphN, i : Int, v : Double) -> MathspecialgammaGraphN {
  let result = math_special_gamma_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_graphn_sum(s : MathspecialgammaGraphN) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_graphn_mean(s : MathspecialgammaGraphN) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_graphn_scale(s : MathspecialgammaGraphN, f : Double) -> MathspecialgammaGraphN {
  let result = math_special_gamma_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_gamma_graphn_add(a : MathspecialgammaGraphN, b : MathspecialgammaGraphN) -> MathspecialgammaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_gamma_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_gamma_graphn_copy(s : MathspecialgammaGraphN) -> MathspecialgammaGraphN {
  let result = math_special_gamma_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_gamma_graphn_fill(s : MathspecialgammaGraphN, v : Double) -> MathspecialgammaGraphN {
  let result = math_special_gamma_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_graphn_min(s : MathspecialgammaGraphN) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_graphn_max(s : MathspecialgammaGraphN) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_graphn_to_string(s : MathspecialgammaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_node_make(size : Int) -> MathspecialgammaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_node_len(s : MathspecialgammaNode) -> Int { s.size }

pub fn math_special_gamma_node_get(s : MathspecialgammaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_node_set(s : MathspecialgammaNode, i : Int, v : Double) -> MathspecialgammaNode {
  let result = math_special_gamma_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_node_sum(s : MathspecialgammaNode) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_node_mean(s : MathspecialgammaNode) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_node_scale(s : MathspecialgammaNode, f : Double) -> MathspecialgammaNode {
  let result = math_special_gamma_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_gamma_node_add(a : MathspecialgammaNode, b : MathspecialgammaNode) -> MathspecialgammaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_gamma_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_gamma_node_copy(s : MathspecialgammaNode) -> MathspecialgammaNode {
  let result = math_special_gamma_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_gamma_node_fill(s : MathspecialgammaNode, v : Double) -> MathspecialgammaNode {
  let result = math_special_gamma_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_node_min(s : MathspecialgammaNode) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_node_max(s : MathspecialgammaNode) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_node_to_string(s : MathspecialgammaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_edge_make(size : Int) -> MathspecialgammaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_edge_len(s : MathspecialgammaEdge) -> Int { s.size }

pub fn math_special_gamma_edge_get(s : MathspecialgammaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_edge_set(s : MathspecialgammaEdge, i : Int, v : Double) -> MathspecialgammaEdge {
  let result = math_special_gamma_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_edge_sum(s : MathspecialgammaEdge) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_edge_mean(s : MathspecialgammaEdge) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_edge_scale(s : MathspecialgammaEdge, f : Double) -> MathspecialgammaEdge {
  let result = math_special_gamma_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_gamma_edge_add(a : MathspecialgammaEdge, b : MathspecialgammaEdge) -> MathspecialgammaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_gamma_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_gamma_edge_copy(s : MathspecialgammaEdge) -> MathspecialgammaEdge {
  let result = math_special_gamma_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_gamma_edge_fill(s : MathspecialgammaEdge, v : Double) -> MathspecialgammaEdge {
  let result = math_special_gamma_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_edge_min(s : MathspecialgammaEdge) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_edge_max(s : MathspecialgammaEdge) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_edge_to_string(s : MathspecialgammaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_path_make(size : Int) -> MathspecialgammaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_path_len(s : MathspecialgammaPath) -> Int { s.size }

pub fn math_special_gamma_path_get(s : MathspecialgammaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_path_set(s : MathspecialgammaPath, i : Int, v : Double) -> MathspecialgammaPath {
  let result = math_special_gamma_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_path_sum(s : MathspecialgammaPath) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_path_mean(s : MathspecialgammaPath) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_path_scale(s : MathspecialgammaPath, f : Double) -> MathspecialgammaPath {
  let result = math_special_gamma_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_gamma_path_add(a : MathspecialgammaPath, b : MathspecialgammaPath) -> MathspecialgammaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_gamma_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_gamma_path_copy(s : MathspecialgammaPath) -> MathspecialgammaPath {
  let result = math_special_gamma_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_gamma_path_fill(s : MathspecialgammaPath, v : Double) -> MathspecialgammaPath {
  let result = math_special_gamma_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_path_min(s : MathspecialgammaPath) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_path_max(s : MathspecialgammaPath) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_path_to_string(s : MathspecialgammaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_cluster_make(size : Int) -> MathspecialgammaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_cluster_len(s : MathspecialgammaCluster) -> Int { s.size }

pub fn math_special_gamma_cluster_get(s : MathspecialgammaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_cluster_set(s : MathspecialgammaCluster, i : Int, v : Double) -> MathspecialgammaCluster {
  let result = math_special_gamma_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_cluster_sum(s : MathspecialgammaCluster) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_cluster_mean(s : MathspecialgammaCluster) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_cluster_scale(s : MathspecialgammaCluster, f : Double) -> MathspecialgammaCluster {
  let result = math_special_gamma_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_gamma_cluster_add(a : MathspecialgammaCluster, b : MathspecialgammaCluster) -> MathspecialgammaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_gamma_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_gamma_cluster_copy(s : MathspecialgammaCluster) -> MathspecialgammaCluster {
  let result = math_special_gamma_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_gamma_cluster_fill(s : MathspecialgammaCluster, v : Double) -> MathspecialgammaCluster {
  let result = math_special_gamma_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_cluster_min(s : MathspecialgammaCluster) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_cluster_max(s : MathspecialgammaCluster) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_cluster_to_string(s : MathspecialgammaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_model_make(size : Int) -> MathspecialgammaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_model_len(s : MathspecialgammaModel) -> Int { s.size }

pub fn math_special_gamma_model_get(s : MathspecialgammaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_model_set(s : MathspecialgammaModel, i : Int, v : Double) -> MathspecialgammaModel {
  let result = math_special_gamma_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_model_sum(s : MathspecialgammaModel) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_model_mean(s : MathspecialgammaModel) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_model_scale(s : MathspecialgammaModel, f : Double) -> MathspecialgammaModel {
  let result = math_special_gamma_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_gamma_model_add(a : MathspecialgammaModel, b : MathspecialgammaModel) -> MathspecialgammaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_gamma_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_gamma_model_copy(s : MathspecialgammaModel) -> MathspecialgammaModel {
  let result = math_special_gamma_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_gamma_model_fill(s : MathspecialgammaModel, v : Double) -> MathspecialgammaModel {
  let result = math_special_gamma_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_model_min(s : MathspecialgammaModel) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_model_max(s : MathspecialgammaModel) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_model_to_string(s : MathspecialgammaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_layer_make(size : Int) -> MathspecialgammaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_layer_len(s : MathspecialgammaLayer) -> Int { s.size }

pub fn math_special_gamma_layer_get(s : MathspecialgammaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_layer_set(s : MathspecialgammaLayer, i : Int, v : Double) -> MathspecialgammaLayer {
  let result = math_special_gamma_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_layer_sum(s : MathspecialgammaLayer) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_layer_mean(s : MathspecialgammaLayer) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_layer_scale(s : MathspecialgammaLayer, f : Double) -> MathspecialgammaLayer {
  let result = math_special_gamma_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_gamma_layer_add(a : MathspecialgammaLayer, b : MathspecialgammaLayer) -> MathspecialgammaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_gamma_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_gamma_layer_copy(s : MathspecialgammaLayer) -> MathspecialgammaLayer {
  let result = math_special_gamma_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_gamma_layer_fill(s : MathspecialgammaLayer, v : Double) -> MathspecialgammaLayer {
  let result = math_special_gamma_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_layer_min(s : MathspecialgammaLayer) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_layer_max(s : MathspecialgammaLayer) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_layer_to_string(s : MathspecialgammaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_buffer_make(size : Int) -> MathspecialgammaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_buffer_len(s : MathspecialgammaBuffer) -> Int { s.size }

pub fn math_special_gamma_buffer_get(s : MathspecialgammaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_buffer_set(s : MathspecialgammaBuffer, i : Int, v : Double) -> MathspecialgammaBuffer {
  let result = math_special_gamma_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_buffer_sum(s : MathspecialgammaBuffer) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_buffer_mean(s : MathspecialgammaBuffer) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_buffer_scale(s : MathspecialgammaBuffer, f : Double) -> MathspecialgammaBuffer {
  let result = math_special_gamma_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_gamma_buffer_add(a : MathspecialgammaBuffer, b : MathspecialgammaBuffer) -> MathspecialgammaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_gamma_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_gamma_buffer_copy(s : MathspecialgammaBuffer) -> MathspecialgammaBuffer {
  let result = math_special_gamma_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_gamma_buffer_fill(s : MathspecialgammaBuffer, v : Double) -> MathspecialgammaBuffer {
  let result = math_special_gamma_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_buffer_min(s : MathspecialgammaBuffer) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_buffer_max(s : MathspecialgammaBuffer) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_buffer_to_string(s : MathspecialgammaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_cursor_make(size : Int) -> MathspecialgammaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_cursor_len(s : MathspecialgammaCursor) -> Int { s.size }

pub fn math_special_gamma_cursor_get(s : MathspecialgammaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_cursor_set(s : MathspecialgammaCursor, i : Int, v : Double) -> MathspecialgammaCursor {
  let result = math_special_gamma_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_cursor_sum(s : MathspecialgammaCursor) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_cursor_mean(s : MathspecialgammaCursor) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_cursor_scale(s : MathspecialgammaCursor, f : Double) -> MathspecialgammaCursor {
  let result = math_special_gamma_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_gamma_cursor_add(a : MathspecialgammaCursor, b : MathspecialgammaCursor) -> MathspecialgammaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_gamma_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_gamma_cursor_copy(s : MathspecialgammaCursor) -> MathspecialgammaCursor {
  let result = math_special_gamma_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_gamma_cursor_fill(s : MathspecialgammaCursor, v : Double) -> MathspecialgammaCursor {
  let result = math_special_gamma_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_cursor_min(s : MathspecialgammaCursor) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_cursor_max(s : MathspecialgammaCursor) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_cursor_to_string(s : MathspecialgammaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_view_make(size : Int) -> MathspecialgammaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_view_len(s : MathspecialgammaView) -> Int { s.size }

pub fn math_special_gamma_view_get(s : MathspecialgammaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_view_set(s : MathspecialgammaView, i : Int, v : Double) -> MathspecialgammaView {
  let result = math_special_gamma_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_view_sum(s : MathspecialgammaView) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_view_mean(s : MathspecialgammaView) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_view_scale(s : MathspecialgammaView, f : Double) -> MathspecialgammaView {
  let result = math_special_gamma_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_gamma_view_add(a : MathspecialgammaView, b : MathspecialgammaView) -> MathspecialgammaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_gamma_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_gamma_view_copy(s : MathspecialgammaView) -> MathspecialgammaView {
  let result = math_special_gamma_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_gamma_view_fill(s : MathspecialgammaView, v : Double) -> MathspecialgammaView {
  let result = math_special_gamma_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_view_min(s : MathspecialgammaView) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_view_max(s : MathspecialgammaView) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_view_to_string(s : MathspecialgammaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_range_make(size : Int) -> MathspecialgammaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_range_len(s : MathspecialgammaRange) -> Int { s.size }

pub fn math_special_gamma_range_get(s : MathspecialgammaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_range_set(s : MathspecialgammaRange, i : Int, v : Double) -> MathspecialgammaRange {
  let result = math_special_gamma_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_range_sum(s : MathspecialgammaRange) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_range_mean(s : MathspecialgammaRange) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_range_scale(s : MathspecialgammaRange, f : Double) -> MathspecialgammaRange {
  let result = math_special_gamma_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_gamma_range_add(a : MathspecialgammaRange, b : MathspecialgammaRange) -> MathspecialgammaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_gamma_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_gamma_range_copy(s : MathspecialgammaRange) -> MathspecialgammaRange {
  let result = math_special_gamma_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_gamma_range_fill(s : MathspecialgammaRange, v : Double) -> MathspecialgammaRange {
  let result = math_special_gamma_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_range_min(s : MathspecialgammaRange) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_range_max(s : MathspecialgammaRange) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_range_to_string(s : MathspecialgammaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_slice_make(size : Int) -> MathspecialgammaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_gamma_slice_len(s : MathspecialgammaSlice) -> Int { s.size }

pub fn math_special_gamma_slice_get(s : MathspecialgammaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_gamma_slice_set(s : MathspecialgammaSlice, i : Int, v : Double) -> MathspecialgammaSlice {
  let result = math_special_gamma_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_slice_sum(s : MathspecialgammaSlice) -> Double { @_common.sum(s.data) }

pub fn math_special_gamma_slice_mean(s : MathspecialgammaSlice) -> Double { @_common.mean(s.data) }

pub fn math_special_gamma_slice_scale(s : MathspecialgammaSlice, f : Double) -> MathspecialgammaSlice {
  let result = math_special_gamma_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_gamma_slice_add(a : MathspecialgammaSlice, b : MathspecialgammaSlice) -> MathspecialgammaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_gamma_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_gamma_slice_copy(s : MathspecialgammaSlice) -> MathspecialgammaSlice {
  let result = math_special_gamma_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_gamma_slice_fill(s : MathspecialgammaSlice, v : Double) -> MathspecialgammaSlice {
  let result = math_special_gamma_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_gamma_slice_min(s : MathspecialgammaSlice) -> Double { @_common.min(s.data) }

pub fn math_special_gamma_slice_max(s : MathspecialgammaSlice) -> Double { @_common.max(s.data) }

pub fn math_special_gamma_slice_to_string(s : MathspecialgammaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

