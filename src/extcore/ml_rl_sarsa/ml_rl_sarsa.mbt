///===
/// extcore/ml_rl_sarsa

pub(all) struct MlrlsarsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_sarsa_make_point(x : Double, y : Double) -> MlrlsarsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_sarsa_make_point3(x : Double, y : Double, z : Double) -> MlrlsarsaPoint {
  { x, y, z, label: 0 }
}

pub fn ml_rl_sarsa_point_x(pt : MlrlsarsaPoint) -> Double { pt.x }

pub fn ml_rl_sarsa_point_y(pt : MlrlsarsaPoint) -> Double { pt.y }

pub fn ml_rl_sarsa_point_z(pt : MlrlsarsaPoint) -> Double { pt.z }

pub fn ml_rl_sarsa_point_label(pt : MlrlsarsaPoint) -> Int { pt.label }

pub fn ml_rl_sarsa_point_dist(a : MlrlsarsaPoint, b : MlrlsarsaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_rl_sarsa_point_add(a : MlrlsarsaPoint, b : MlrlsarsaPoint) -> MlrlsarsaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_rl_sarsa_point_sub(a : MlrlsarsaPoint, b : MlrlsarsaPoint) -> MlrlsarsaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_rl_sarsa_point_scale(pt : MlrlsarsaPoint, s : Double) -> MlrlsarsaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_rl_sarsa_point_dot(a : MlrlsarsaPoint, b : MlrlsarsaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_rl_sarsa_point_cross(a : MlrlsarsaPoint, b : MlrlsarsaPoint) -> MlrlsarsaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_rl_sarsa_point_norm(pt : MlrlsarsaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_rl_sarsa_point_normalize(pt : MlrlsarsaPoint) -> MlrlsarsaPoint {
  let n = ml_rl_sarsa_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_rl_sarsa_point_scale(pt, 1.0 / n) }
}

pub fn ml_rl_sarsa_point_negate(pt : MlrlsarsaPoint) -> MlrlsarsaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_rl_sarsa_point_mid(a : MlrlsarsaPoint, b : MlrlsarsaPoint) -> MlrlsarsaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_rl_sarsa_point_lerp(a : MlrlsarsaPoint, b : MlrlsarsaPoint, t : Double) -> MlrlsarsaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_rl_sarsa_point_to_string(pt : MlrlsarsaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlrlsarsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_sarsa_make_series(vals : Array[Double], name : String) -> MlrlsarsaSeries {
  { vals, name, meta: 0 }
}

pub fn ml_rl_sarsa_series_len(s : MlrlsarsaSeries) -> Int { s.vals.length() }

pub fn ml_rl_sarsa_series_sum(s : MlrlsarsaSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_rl_sarsa_series_mean(s : MlrlsarsaSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_rl_sarsa_series_min(s : MlrlsarsaSeries) -> Double { @_common.min(s.vals) }

pub fn ml_rl_sarsa_series_max(s : MlrlsarsaSeries) -> Double { @_common.max(s.vals) }

pub fn ml_rl_sarsa_series_range(s : MlrlsarsaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_rl_sarsa_series_var(s : MlrlsarsaSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_rl_sarsa_series_std(s : MlrlsarsaSeries) -> Double { @_common.std(s.vals) }

pub fn ml_rl_sarsa_series_median(s : MlrlsarsaSeries) -> Double { @_common.median(s.vals) }

pub fn ml_rl_sarsa_series_scale(s : MlrlsarsaSeries, f : Double) -> MlrlsarsaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_rl_sarsa_series_add(a : MlrlsarsaSeries, b : MlrlsarsaSeries) -> MlrlsarsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_rl_sarsa_series_sub(a : MlrlsarsaSeries, b : MlrlsarsaSeries) -> MlrlsarsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_rl_sarsa_series_normalize(s : MlrlsarsaSeries) -> MlrlsarsaSeries {
  let mn = ml_rl_sarsa_series_min(s)
  let mx = ml_rl_sarsa_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_rl_sarsa_series_cumsum(s : MlrlsarsaSeries) -> MlrlsarsaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_rl_sarsa_series_to_string(s : MlrlsarsaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlsarsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_sarsa_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlsarsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_sarsa_matrix_identity(n : Int) -> MlrlsarsaMatrix {
  let m = ml_rl_sarsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_rl_sarsa_matrix_get(m : MlrlsarsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_rl_sarsa_matrix_transpose(m : MlrlsarsaMatrix) -> MlrlsarsaMatrix {
  let result = ml_rl_sarsa_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_rl_sarsa_matrix_add(a : MlrlsarsaMatrix, b : MlrlsarsaMatrix) -> MlrlsarsaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_rl_sarsa_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_rl_sarsa_matrix_scale(m : MlrlsarsaMatrix, s : Double) -> MlrlsarsaMatrix {
  let result = ml_rl_sarsa_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_rl_sarsa_matrix_multiply(a : MlrlsarsaMatrix, b : MlrlsarsaMatrix) -> MlrlsarsaMatrix {
  if a.cols != b.rows { return ml_rl_sarsa_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_rl_sarsa_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_rl_sarsa_matrix_trace(m : MlrlsarsaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_rl_sarsa_matrix_det(m : MlrlsarsaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_rl_sarsa_matrix_norm(m : MlrlsarsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_rl_sarsa_matrix_to_string(m : MlrlsarsaMatrix) -> String {
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

pub(all) struct MlrlsarsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_sarsa_make_vector(comps : Array[Double]) -> MlrlsarsaVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_sarsa_vector_zero(dim : Int) -> MlrlsarsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_rl_sarsa_vector_add(a : MlrlsarsaVector, b : MlrlsarsaVector) -> MlrlsarsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_sarsa_vector_sub(a : MlrlsarsaVector, b : MlrlsarsaVector) -> MlrlsarsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_sarsa_vector_scale(v : MlrlsarsaVector, s : Double) -> MlrlsarsaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_rl_sarsa_vector_dot(a : MlrlsarsaVector, b : MlrlsarsaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_rl_sarsa_vector_norm(v : MlrlsarsaVector) -> Double { @_common.sqrt(ml_rl_sarsa_vector_dot(v, v)) }

pub fn ml_rl_sarsa_vector_normalize(v : MlrlsarsaVector) -> MlrlsarsaVector {
  let n = ml_rl_sarsa_vector_norm(v)
  if n < 0.0000001 { v } else { ml_rl_sarsa_vector_scale(v, 1.0 / n) }
}

pub fn ml_rl_sarsa_vector_dist(a : MlrlsarsaVector, b : MlrlsarsaVector) -> Double {
  ml_rl_sarsa_vector_norm(ml_rl_sarsa_vector_sub(a, b))
}

pub fn ml_rl_sarsa_vector_to_string(v : MlrlsarsaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_sarsa_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_rl_sarsa_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_rl_sarsa_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_rl_sarsa_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_rl_sarsa_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_rl_sarsa_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_rl_sarsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_rl_sarsa_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_rl_sarsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_rl_sarsa_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_rl_sarsa_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_rl_sarsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_rl_sarsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_rl_sarsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_rl_sarsa_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_rl_sarsa_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_rl_sarsa_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_rl_sarsa_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_rl_sarsa_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_rl_sarsa_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_rl_sarsa_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_rl_sarsa_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_rl_sarsa_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_rl_sarsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_rl_sarsa_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_rl_sarsa_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_rl_sarsa_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_rl_sarsa_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_rl_sarsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlrlsarsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_frame_make(size : Int) -> MlrlsarsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_frame_len(s : MlrlsarsaFrame) -> Int { s.size }

pub fn ml_rl_sarsa_frame_get(s : MlrlsarsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_frame_set(s : MlrlsarsaFrame, i : Int, v : Double) -> MlrlsarsaFrame {
  let result = ml_rl_sarsa_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_frame_sum(s : MlrlsarsaFrame) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sarsa_frame_mean(s : MlrlsarsaFrame) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sarsa_frame_scale(s : MlrlsarsaFrame, f : Double) -> MlrlsarsaFrame {
  let result = ml_rl_sarsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_frame_add(a : MlrlsarsaFrame, b : MlrlsarsaFrame) -> MlrlsarsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_frame_copy(s : MlrlsarsaFrame) -> MlrlsarsaFrame {
  let result = ml_rl_sarsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_frame_fill(s : MlrlsarsaFrame, v : Double) -> MlrlsarsaFrame {
  let result = ml_rl_sarsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_frame_min(s : MlrlsarsaFrame) -> Double { @_common.min(s.data) }

pub fn ml_rl_sarsa_frame_max(s : MlrlsarsaFrame) -> Double { @_common.max(s.data) }

pub fn ml_rl_sarsa_frame_to_string(s : MlrlsarsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_table_make(size : Int) -> MlrlsarsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_table_len(s : MlrlsarsaTable) -> Int { s.size }

pub fn ml_rl_sarsa_table_get(s : MlrlsarsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_table_set(s : MlrlsarsaTable, i : Int, v : Double) -> MlrlsarsaTable {
  let result = ml_rl_sarsa_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_table_sum(s : MlrlsarsaTable) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sarsa_table_mean(s : MlrlsarsaTable) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sarsa_table_scale(s : MlrlsarsaTable, f : Double) -> MlrlsarsaTable {
  let result = ml_rl_sarsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_table_add(a : MlrlsarsaTable, b : MlrlsarsaTable) -> MlrlsarsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_table_copy(s : MlrlsarsaTable) -> MlrlsarsaTable {
  let result = ml_rl_sarsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_table_fill(s : MlrlsarsaTable, v : Double) -> MlrlsarsaTable {
  let result = ml_rl_sarsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_table_min(s : MlrlsarsaTable) -> Double { @_common.min(s.data) }

pub fn ml_rl_sarsa_table_max(s : MlrlsarsaTable) -> Double { @_common.max(s.data) }

pub fn ml_rl_sarsa_table_to_string(s : MlrlsarsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_graphn_make(size : Int) -> MlrlsarsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_graphn_len(s : MlrlsarsaGraphN) -> Int { s.size }

pub fn ml_rl_sarsa_graphn_get(s : MlrlsarsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_graphn_set(s : MlrlsarsaGraphN, i : Int, v : Double) -> MlrlsarsaGraphN {
  let result = ml_rl_sarsa_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_graphn_sum(s : MlrlsarsaGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sarsa_graphn_mean(s : MlrlsarsaGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sarsa_graphn_scale(s : MlrlsarsaGraphN, f : Double) -> MlrlsarsaGraphN {
  let result = ml_rl_sarsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_graphn_add(a : MlrlsarsaGraphN, b : MlrlsarsaGraphN) -> MlrlsarsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_graphn_copy(s : MlrlsarsaGraphN) -> MlrlsarsaGraphN {
  let result = ml_rl_sarsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_graphn_fill(s : MlrlsarsaGraphN, v : Double) -> MlrlsarsaGraphN {
  let result = ml_rl_sarsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_graphn_min(s : MlrlsarsaGraphN) -> Double { @_common.min(s.data) }

pub fn ml_rl_sarsa_graphn_max(s : MlrlsarsaGraphN) -> Double { @_common.max(s.data) }

pub fn ml_rl_sarsa_graphn_to_string(s : MlrlsarsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_node_make(size : Int) -> MlrlsarsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_node_len(s : MlrlsarsaNode) -> Int { s.size }

pub fn ml_rl_sarsa_node_get(s : MlrlsarsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_node_set(s : MlrlsarsaNode, i : Int, v : Double) -> MlrlsarsaNode {
  let result = ml_rl_sarsa_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_node_sum(s : MlrlsarsaNode) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sarsa_node_mean(s : MlrlsarsaNode) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sarsa_node_scale(s : MlrlsarsaNode, f : Double) -> MlrlsarsaNode {
  let result = ml_rl_sarsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_node_add(a : MlrlsarsaNode, b : MlrlsarsaNode) -> MlrlsarsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_node_copy(s : MlrlsarsaNode) -> MlrlsarsaNode {
  let result = ml_rl_sarsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_node_fill(s : MlrlsarsaNode, v : Double) -> MlrlsarsaNode {
  let result = ml_rl_sarsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_node_min(s : MlrlsarsaNode) -> Double { @_common.min(s.data) }

pub fn ml_rl_sarsa_node_max(s : MlrlsarsaNode) -> Double { @_common.max(s.data) }

pub fn ml_rl_sarsa_node_to_string(s : MlrlsarsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_edge_make(size : Int) -> MlrlsarsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_edge_len(s : MlrlsarsaEdge) -> Int { s.size }

pub fn ml_rl_sarsa_edge_get(s : MlrlsarsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_edge_set(s : MlrlsarsaEdge, i : Int, v : Double) -> MlrlsarsaEdge {
  let result = ml_rl_sarsa_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_edge_sum(s : MlrlsarsaEdge) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sarsa_edge_mean(s : MlrlsarsaEdge) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sarsa_edge_scale(s : MlrlsarsaEdge, f : Double) -> MlrlsarsaEdge {
  let result = ml_rl_sarsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_edge_add(a : MlrlsarsaEdge, b : MlrlsarsaEdge) -> MlrlsarsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_edge_copy(s : MlrlsarsaEdge) -> MlrlsarsaEdge {
  let result = ml_rl_sarsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_edge_fill(s : MlrlsarsaEdge, v : Double) -> MlrlsarsaEdge {
  let result = ml_rl_sarsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_edge_min(s : MlrlsarsaEdge) -> Double { @_common.min(s.data) }

pub fn ml_rl_sarsa_edge_max(s : MlrlsarsaEdge) -> Double { @_common.max(s.data) }

pub fn ml_rl_sarsa_edge_to_string(s : MlrlsarsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_path_make(size : Int) -> MlrlsarsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_path_len(s : MlrlsarsaPath) -> Int { s.size }

pub fn ml_rl_sarsa_path_get(s : MlrlsarsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_path_set(s : MlrlsarsaPath, i : Int, v : Double) -> MlrlsarsaPath {
  let result = ml_rl_sarsa_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_path_sum(s : MlrlsarsaPath) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sarsa_path_mean(s : MlrlsarsaPath) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sarsa_path_scale(s : MlrlsarsaPath, f : Double) -> MlrlsarsaPath {
  let result = ml_rl_sarsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_path_add(a : MlrlsarsaPath, b : MlrlsarsaPath) -> MlrlsarsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_path_copy(s : MlrlsarsaPath) -> MlrlsarsaPath {
  let result = ml_rl_sarsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_path_fill(s : MlrlsarsaPath, v : Double) -> MlrlsarsaPath {
  let result = ml_rl_sarsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_path_min(s : MlrlsarsaPath) -> Double { @_common.min(s.data) }

pub fn ml_rl_sarsa_path_max(s : MlrlsarsaPath) -> Double { @_common.max(s.data) }

pub fn ml_rl_sarsa_path_to_string(s : MlrlsarsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_cluster_make(size : Int) -> MlrlsarsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_cluster_len(s : MlrlsarsaCluster) -> Int { s.size }

pub fn ml_rl_sarsa_cluster_get(s : MlrlsarsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_cluster_set(s : MlrlsarsaCluster, i : Int, v : Double) -> MlrlsarsaCluster {
  let result = ml_rl_sarsa_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_cluster_sum(s : MlrlsarsaCluster) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sarsa_cluster_mean(s : MlrlsarsaCluster) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sarsa_cluster_scale(s : MlrlsarsaCluster, f : Double) -> MlrlsarsaCluster {
  let result = ml_rl_sarsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_cluster_add(a : MlrlsarsaCluster, b : MlrlsarsaCluster) -> MlrlsarsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_cluster_copy(s : MlrlsarsaCluster) -> MlrlsarsaCluster {
  let result = ml_rl_sarsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_cluster_fill(s : MlrlsarsaCluster, v : Double) -> MlrlsarsaCluster {
  let result = ml_rl_sarsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_cluster_min(s : MlrlsarsaCluster) -> Double { @_common.min(s.data) }

pub fn ml_rl_sarsa_cluster_max(s : MlrlsarsaCluster) -> Double { @_common.max(s.data) }

pub fn ml_rl_sarsa_cluster_to_string(s : MlrlsarsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_model_make(size : Int) -> MlrlsarsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_model_len(s : MlrlsarsaModel) -> Int { s.size }

pub fn ml_rl_sarsa_model_get(s : MlrlsarsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_model_set(s : MlrlsarsaModel, i : Int, v : Double) -> MlrlsarsaModel {
  let result = ml_rl_sarsa_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_model_sum(s : MlrlsarsaModel) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sarsa_model_mean(s : MlrlsarsaModel) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sarsa_model_scale(s : MlrlsarsaModel, f : Double) -> MlrlsarsaModel {
  let result = ml_rl_sarsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_model_add(a : MlrlsarsaModel, b : MlrlsarsaModel) -> MlrlsarsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_model_copy(s : MlrlsarsaModel) -> MlrlsarsaModel {
  let result = ml_rl_sarsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_model_fill(s : MlrlsarsaModel, v : Double) -> MlrlsarsaModel {
  let result = ml_rl_sarsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_model_min(s : MlrlsarsaModel) -> Double { @_common.min(s.data) }

pub fn ml_rl_sarsa_model_max(s : MlrlsarsaModel) -> Double { @_common.max(s.data) }

pub fn ml_rl_sarsa_model_to_string(s : MlrlsarsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_layer_make(size : Int) -> MlrlsarsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_layer_len(s : MlrlsarsaLayer) -> Int { s.size }

pub fn ml_rl_sarsa_layer_get(s : MlrlsarsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_layer_set(s : MlrlsarsaLayer, i : Int, v : Double) -> MlrlsarsaLayer {
  let result = ml_rl_sarsa_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_layer_sum(s : MlrlsarsaLayer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sarsa_layer_mean(s : MlrlsarsaLayer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sarsa_layer_scale(s : MlrlsarsaLayer, f : Double) -> MlrlsarsaLayer {
  let result = ml_rl_sarsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_layer_add(a : MlrlsarsaLayer, b : MlrlsarsaLayer) -> MlrlsarsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_layer_copy(s : MlrlsarsaLayer) -> MlrlsarsaLayer {
  let result = ml_rl_sarsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_layer_fill(s : MlrlsarsaLayer, v : Double) -> MlrlsarsaLayer {
  let result = ml_rl_sarsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_layer_min(s : MlrlsarsaLayer) -> Double { @_common.min(s.data) }

pub fn ml_rl_sarsa_layer_max(s : MlrlsarsaLayer) -> Double { @_common.max(s.data) }

pub fn ml_rl_sarsa_layer_to_string(s : MlrlsarsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_buffer_make(size : Int) -> MlrlsarsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_buffer_len(s : MlrlsarsaBuffer) -> Int { s.size }

pub fn ml_rl_sarsa_buffer_get(s : MlrlsarsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_buffer_set(s : MlrlsarsaBuffer, i : Int, v : Double) -> MlrlsarsaBuffer {
  let result = ml_rl_sarsa_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_buffer_sum(s : MlrlsarsaBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sarsa_buffer_mean(s : MlrlsarsaBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sarsa_buffer_scale(s : MlrlsarsaBuffer, f : Double) -> MlrlsarsaBuffer {
  let result = ml_rl_sarsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_buffer_add(a : MlrlsarsaBuffer, b : MlrlsarsaBuffer) -> MlrlsarsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_buffer_copy(s : MlrlsarsaBuffer) -> MlrlsarsaBuffer {
  let result = ml_rl_sarsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_buffer_fill(s : MlrlsarsaBuffer, v : Double) -> MlrlsarsaBuffer {
  let result = ml_rl_sarsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_buffer_min(s : MlrlsarsaBuffer) -> Double { @_common.min(s.data) }

pub fn ml_rl_sarsa_buffer_max(s : MlrlsarsaBuffer) -> Double { @_common.max(s.data) }

pub fn ml_rl_sarsa_buffer_to_string(s : MlrlsarsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_cursor_make(size : Int) -> MlrlsarsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_cursor_len(s : MlrlsarsaCursor) -> Int { s.size }

pub fn ml_rl_sarsa_cursor_get(s : MlrlsarsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_cursor_set(s : MlrlsarsaCursor, i : Int, v : Double) -> MlrlsarsaCursor {
  let result = ml_rl_sarsa_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_cursor_sum(s : MlrlsarsaCursor) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sarsa_cursor_mean(s : MlrlsarsaCursor) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sarsa_cursor_scale(s : MlrlsarsaCursor, f : Double) -> MlrlsarsaCursor {
  let result = ml_rl_sarsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_cursor_add(a : MlrlsarsaCursor, b : MlrlsarsaCursor) -> MlrlsarsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_cursor_copy(s : MlrlsarsaCursor) -> MlrlsarsaCursor {
  let result = ml_rl_sarsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_cursor_fill(s : MlrlsarsaCursor, v : Double) -> MlrlsarsaCursor {
  let result = ml_rl_sarsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_cursor_min(s : MlrlsarsaCursor) -> Double { @_common.min(s.data) }

pub fn ml_rl_sarsa_cursor_max(s : MlrlsarsaCursor) -> Double { @_common.max(s.data) }

pub fn ml_rl_sarsa_cursor_to_string(s : MlrlsarsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_view_make(size : Int) -> MlrlsarsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_view_len(s : MlrlsarsaView) -> Int { s.size }

pub fn ml_rl_sarsa_view_get(s : MlrlsarsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_view_set(s : MlrlsarsaView, i : Int, v : Double) -> MlrlsarsaView {
  let result = ml_rl_sarsa_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_view_sum(s : MlrlsarsaView) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sarsa_view_mean(s : MlrlsarsaView) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sarsa_view_scale(s : MlrlsarsaView, f : Double) -> MlrlsarsaView {
  let result = ml_rl_sarsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_view_add(a : MlrlsarsaView, b : MlrlsarsaView) -> MlrlsarsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_view_copy(s : MlrlsarsaView) -> MlrlsarsaView {
  let result = ml_rl_sarsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_view_fill(s : MlrlsarsaView, v : Double) -> MlrlsarsaView {
  let result = ml_rl_sarsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_view_min(s : MlrlsarsaView) -> Double { @_common.min(s.data) }

pub fn ml_rl_sarsa_view_max(s : MlrlsarsaView) -> Double { @_common.max(s.data) }

pub fn ml_rl_sarsa_view_to_string(s : MlrlsarsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_range_make(size : Int) -> MlrlsarsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_range_len(s : MlrlsarsaRange) -> Int { s.size }

pub fn ml_rl_sarsa_range_get(s : MlrlsarsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_range_set(s : MlrlsarsaRange, i : Int, v : Double) -> MlrlsarsaRange {
  let result = ml_rl_sarsa_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_range_sum(s : MlrlsarsaRange) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sarsa_range_mean(s : MlrlsarsaRange) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sarsa_range_scale(s : MlrlsarsaRange, f : Double) -> MlrlsarsaRange {
  let result = ml_rl_sarsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_range_add(a : MlrlsarsaRange, b : MlrlsarsaRange) -> MlrlsarsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_range_copy(s : MlrlsarsaRange) -> MlrlsarsaRange {
  let result = ml_rl_sarsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_range_fill(s : MlrlsarsaRange, v : Double) -> MlrlsarsaRange {
  let result = ml_rl_sarsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_range_min(s : MlrlsarsaRange) -> Double { @_common.min(s.data) }

pub fn ml_rl_sarsa_range_max(s : MlrlsarsaRange) -> Double { @_common.max(s.data) }

pub fn ml_rl_sarsa_range_to_string(s : MlrlsarsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_slice_make(size : Int) -> MlrlsarsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_slice_len(s : MlrlsarsaSlice) -> Int { s.size }

pub fn ml_rl_sarsa_slice_get(s : MlrlsarsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_slice_set(s : MlrlsarsaSlice, i : Int, v : Double) -> MlrlsarsaSlice {
  let result = ml_rl_sarsa_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_slice_sum(s : MlrlsarsaSlice) -> Double { @_common.sum(s.data) }

pub fn ml_rl_sarsa_slice_mean(s : MlrlsarsaSlice) -> Double { @_common.mean(s.data) }

pub fn ml_rl_sarsa_slice_scale(s : MlrlsarsaSlice, f : Double) -> MlrlsarsaSlice {
  let result = ml_rl_sarsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_slice_add(a : MlrlsarsaSlice, b : MlrlsarsaSlice) -> MlrlsarsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_slice_copy(s : MlrlsarsaSlice) -> MlrlsarsaSlice {
  let result = ml_rl_sarsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_slice_fill(s : MlrlsarsaSlice, v : Double) -> MlrlsarsaSlice {
  let result = ml_rl_sarsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_slice_min(s : MlrlsarsaSlice) -> Double { @_common.min(s.data) }

pub fn ml_rl_sarsa_slice_max(s : MlrlsarsaSlice) -> Double { @_common.max(s.data) }

pub fn ml_rl_sarsa_slice_to_string(s : MlrlsarsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

