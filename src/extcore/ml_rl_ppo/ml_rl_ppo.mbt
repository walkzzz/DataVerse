///===
/// extcore/ml_rl_ppo

pub(all) struct MlrlppoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_ppo_make_point(x : Double, y : Double) -> MlrlppoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_ppo_make_point3(x : Double, y : Double, z : Double) -> MlrlppoPoint {
  { x, y, z, label: 0 }
}

pub fn ml_rl_ppo_point_x(pt : MlrlppoPoint) -> Double { pt.x }

pub fn ml_rl_ppo_point_y(pt : MlrlppoPoint) -> Double { pt.y }

pub fn ml_rl_ppo_point_z(pt : MlrlppoPoint) -> Double { pt.z }

pub fn ml_rl_ppo_point_label(pt : MlrlppoPoint) -> Int { pt.label }

pub fn ml_rl_ppo_point_dist(a : MlrlppoPoint, b : MlrlppoPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_rl_ppo_point_add(a : MlrlppoPoint, b : MlrlppoPoint) -> MlrlppoPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_rl_ppo_point_sub(a : MlrlppoPoint, b : MlrlppoPoint) -> MlrlppoPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_rl_ppo_point_scale(pt : MlrlppoPoint, s : Double) -> MlrlppoPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_rl_ppo_point_dot(a : MlrlppoPoint, b : MlrlppoPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_rl_ppo_point_cross(a : MlrlppoPoint, b : MlrlppoPoint) -> MlrlppoPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_rl_ppo_point_norm(pt : MlrlppoPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_rl_ppo_point_normalize(pt : MlrlppoPoint) -> MlrlppoPoint {
  let n = ml_rl_ppo_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_rl_ppo_point_scale(pt, 1.0 / n) }
}

pub fn ml_rl_ppo_point_negate(pt : MlrlppoPoint) -> MlrlppoPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_rl_ppo_point_mid(a : MlrlppoPoint, b : MlrlppoPoint) -> MlrlppoPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_rl_ppo_point_lerp(a : MlrlppoPoint, b : MlrlppoPoint, t : Double) -> MlrlppoPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_rl_ppo_point_to_string(pt : MlrlppoPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlrlppoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_ppo_make_series(vals : Array[Double], name : String) -> MlrlppoSeries {
  { vals, name, meta: 0 }
}

pub fn ml_rl_ppo_series_len(s : MlrlppoSeries) -> Int { s.vals.length() }

pub fn ml_rl_ppo_series_sum(s : MlrlppoSeries) -> Double { @_common.sum(s.vals) }

pub fn ml_rl_ppo_series_mean(s : MlrlppoSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_rl_ppo_series_min(s : MlrlppoSeries) -> Double { @_common.min(s.vals) }

pub fn ml_rl_ppo_series_max(s : MlrlppoSeries) -> Double { @_common.max(s.vals) }

pub fn ml_rl_ppo_series_range(s : MlrlppoSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_rl_ppo_series_var(s : MlrlppoSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_rl_ppo_series_std(s : MlrlppoSeries) -> Double { @_common.std(s.vals) }

pub fn ml_rl_ppo_series_median(s : MlrlppoSeries) -> Double { @_common.median(s.vals) }

pub fn ml_rl_ppo_series_scale(s : MlrlppoSeries, f : Double) -> MlrlppoSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_rl_ppo_series_add(a : MlrlppoSeries, b : MlrlppoSeries) -> MlrlppoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_rl_ppo_series_sub(a : MlrlppoSeries, b : MlrlppoSeries) -> MlrlppoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_rl_ppo_series_normalize(s : MlrlppoSeries) -> MlrlppoSeries {
  let mn = ml_rl_ppo_series_min(s)
  let mx = ml_rl_ppo_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_rl_ppo_series_cumsum(s : MlrlppoSeries) -> MlrlppoSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_rl_ppo_series_to_string(s : MlrlppoSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlppoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_ppo_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlppoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_ppo_matrix_identity(n : Int) -> MlrlppoMatrix {
  let m = ml_rl_ppo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_rl_ppo_matrix_get(m : MlrlppoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_rl_ppo_matrix_transpose(m : MlrlppoMatrix) -> MlrlppoMatrix {
  let result = ml_rl_ppo_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_rl_ppo_matrix_add(a : MlrlppoMatrix, b : MlrlppoMatrix) -> MlrlppoMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_rl_ppo_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_rl_ppo_matrix_scale(m : MlrlppoMatrix, s : Double) -> MlrlppoMatrix {
  let result = ml_rl_ppo_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_rl_ppo_matrix_multiply(a : MlrlppoMatrix, b : MlrlppoMatrix) -> MlrlppoMatrix {
  if a.cols != b.rows { return ml_rl_ppo_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_rl_ppo_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_rl_ppo_matrix_trace(m : MlrlppoMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_rl_ppo_matrix_det(m : MlrlppoMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_rl_ppo_matrix_norm(m : MlrlppoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_rl_ppo_matrix_to_string(m : MlrlppoMatrix) -> String {
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

pub(all) struct MlrlppoVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_ppo_make_vector(comps : Array[Double]) -> MlrlppoVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_ppo_vector_zero(dim : Int) -> MlrlppoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_rl_ppo_vector_add(a : MlrlppoVector, b : MlrlppoVector) -> MlrlppoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_ppo_vector_sub(a : MlrlppoVector, b : MlrlppoVector) -> MlrlppoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_ppo_vector_scale(v : MlrlppoVector, s : Double) -> MlrlppoVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_rl_ppo_vector_dot(a : MlrlppoVector, b : MlrlppoVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_rl_ppo_vector_norm(v : MlrlppoVector) -> Double { @_common.sqrt(ml_rl_ppo_vector_dot(v, v)) }

pub fn ml_rl_ppo_vector_normalize(v : MlrlppoVector) -> MlrlppoVector {
  let n = ml_rl_ppo_vector_norm(v)
  if n < 0.0000001 { v } else { ml_rl_ppo_vector_scale(v, 1.0 / n) }
}

pub fn ml_rl_ppo_vector_dist(a : MlrlppoVector, b : MlrlppoVector) -> Double {
  ml_rl_ppo_vector_norm(ml_rl_ppo_vector_sub(a, b))
}

pub fn ml_rl_ppo_vector_to_string(v : MlrlppoVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_ppo_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_rl_ppo_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_rl_ppo_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_rl_ppo_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_rl_ppo_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_rl_ppo_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_rl_ppo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_rl_ppo_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_rl_ppo_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_rl_ppo_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_rl_ppo_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_rl_ppo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_rl_ppo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_rl_ppo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_rl_ppo_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_rl_ppo_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_rl_ppo_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_rl_ppo_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_rl_ppo_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_rl_ppo_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_rl_ppo_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_rl_ppo_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_rl_ppo_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_rl_ppo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_rl_ppo_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_rl_ppo_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_rl_ppo_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_rl_ppo_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_rl_ppo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlrlppoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_frame_make(size : Int) -> MlrlppoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_frame_len(s : MlrlppoFrame) -> Int { s.size }

pub fn ml_rl_ppo_frame_get(s : MlrlppoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_frame_set(s : MlrlppoFrame, i : Int, v : Double) -> MlrlppoFrame {
  let result = ml_rl_ppo_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_frame_sum(s : MlrlppoFrame) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_frame_mean(s : MlrlppoFrame) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_frame_scale(s : MlrlppoFrame, f : Double) -> MlrlppoFrame {
  let result = ml_rl_ppo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ppo_frame_add(a : MlrlppoFrame, b : MlrlppoFrame) -> MlrlppoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ppo_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ppo_frame_copy(s : MlrlppoFrame) -> MlrlppoFrame {
  let result = ml_rl_ppo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ppo_frame_fill(s : MlrlppoFrame, v : Double) -> MlrlppoFrame {
  let result = ml_rl_ppo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_frame_min(s : MlrlppoFrame) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_frame_max(s : MlrlppoFrame) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_frame_to_string(s : MlrlppoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_table_make(size : Int) -> MlrlppoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_table_len(s : MlrlppoTable) -> Int { s.size }

pub fn ml_rl_ppo_table_get(s : MlrlppoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_table_set(s : MlrlppoTable, i : Int, v : Double) -> MlrlppoTable {
  let result = ml_rl_ppo_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_table_sum(s : MlrlppoTable) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_table_mean(s : MlrlppoTable) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_table_scale(s : MlrlppoTable, f : Double) -> MlrlppoTable {
  let result = ml_rl_ppo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ppo_table_add(a : MlrlppoTable, b : MlrlppoTable) -> MlrlppoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ppo_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ppo_table_copy(s : MlrlppoTable) -> MlrlppoTable {
  let result = ml_rl_ppo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ppo_table_fill(s : MlrlppoTable, v : Double) -> MlrlppoTable {
  let result = ml_rl_ppo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_table_min(s : MlrlppoTable) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_table_max(s : MlrlppoTable) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_table_to_string(s : MlrlppoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_graphn_make(size : Int) -> MlrlppoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_graphn_len(s : MlrlppoGraphN) -> Int { s.size }

pub fn ml_rl_ppo_graphn_get(s : MlrlppoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_graphn_set(s : MlrlppoGraphN, i : Int, v : Double) -> MlrlppoGraphN {
  let result = ml_rl_ppo_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_graphn_sum(s : MlrlppoGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_graphn_mean(s : MlrlppoGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_graphn_scale(s : MlrlppoGraphN, f : Double) -> MlrlppoGraphN {
  let result = ml_rl_ppo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ppo_graphn_add(a : MlrlppoGraphN, b : MlrlppoGraphN) -> MlrlppoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ppo_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ppo_graphn_copy(s : MlrlppoGraphN) -> MlrlppoGraphN {
  let result = ml_rl_ppo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ppo_graphn_fill(s : MlrlppoGraphN, v : Double) -> MlrlppoGraphN {
  let result = ml_rl_ppo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_graphn_min(s : MlrlppoGraphN) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_graphn_max(s : MlrlppoGraphN) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_graphn_to_string(s : MlrlppoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_node_make(size : Int) -> MlrlppoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_node_len(s : MlrlppoNode) -> Int { s.size }

pub fn ml_rl_ppo_node_get(s : MlrlppoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_node_set(s : MlrlppoNode, i : Int, v : Double) -> MlrlppoNode {
  let result = ml_rl_ppo_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_node_sum(s : MlrlppoNode) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_node_mean(s : MlrlppoNode) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_node_scale(s : MlrlppoNode, f : Double) -> MlrlppoNode {
  let result = ml_rl_ppo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ppo_node_add(a : MlrlppoNode, b : MlrlppoNode) -> MlrlppoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ppo_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ppo_node_copy(s : MlrlppoNode) -> MlrlppoNode {
  let result = ml_rl_ppo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ppo_node_fill(s : MlrlppoNode, v : Double) -> MlrlppoNode {
  let result = ml_rl_ppo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_node_min(s : MlrlppoNode) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_node_max(s : MlrlppoNode) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_node_to_string(s : MlrlppoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_edge_make(size : Int) -> MlrlppoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_edge_len(s : MlrlppoEdge) -> Int { s.size }

pub fn ml_rl_ppo_edge_get(s : MlrlppoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_edge_set(s : MlrlppoEdge, i : Int, v : Double) -> MlrlppoEdge {
  let result = ml_rl_ppo_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_edge_sum(s : MlrlppoEdge) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_edge_mean(s : MlrlppoEdge) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_edge_scale(s : MlrlppoEdge, f : Double) -> MlrlppoEdge {
  let result = ml_rl_ppo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ppo_edge_add(a : MlrlppoEdge, b : MlrlppoEdge) -> MlrlppoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ppo_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ppo_edge_copy(s : MlrlppoEdge) -> MlrlppoEdge {
  let result = ml_rl_ppo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ppo_edge_fill(s : MlrlppoEdge, v : Double) -> MlrlppoEdge {
  let result = ml_rl_ppo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_edge_min(s : MlrlppoEdge) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_edge_max(s : MlrlppoEdge) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_edge_to_string(s : MlrlppoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_path_make(size : Int) -> MlrlppoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_path_len(s : MlrlppoPath) -> Int { s.size }

pub fn ml_rl_ppo_path_get(s : MlrlppoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_path_set(s : MlrlppoPath, i : Int, v : Double) -> MlrlppoPath {
  let result = ml_rl_ppo_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_path_sum(s : MlrlppoPath) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_path_mean(s : MlrlppoPath) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_path_scale(s : MlrlppoPath, f : Double) -> MlrlppoPath {
  let result = ml_rl_ppo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ppo_path_add(a : MlrlppoPath, b : MlrlppoPath) -> MlrlppoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ppo_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ppo_path_copy(s : MlrlppoPath) -> MlrlppoPath {
  let result = ml_rl_ppo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ppo_path_fill(s : MlrlppoPath, v : Double) -> MlrlppoPath {
  let result = ml_rl_ppo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_path_min(s : MlrlppoPath) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_path_max(s : MlrlppoPath) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_path_to_string(s : MlrlppoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_cluster_make(size : Int) -> MlrlppoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_cluster_len(s : MlrlppoCluster) -> Int { s.size }

pub fn ml_rl_ppo_cluster_get(s : MlrlppoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_cluster_set(s : MlrlppoCluster, i : Int, v : Double) -> MlrlppoCluster {
  let result = ml_rl_ppo_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_cluster_sum(s : MlrlppoCluster) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_cluster_mean(s : MlrlppoCluster) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_cluster_scale(s : MlrlppoCluster, f : Double) -> MlrlppoCluster {
  let result = ml_rl_ppo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ppo_cluster_add(a : MlrlppoCluster, b : MlrlppoCluster) -> MlrlppoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ppo_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ppo_cluster_copy(s : MlrlppoCluster) -> MlrlppoCluster {
  let result = ml_rl_ppo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ppo_cluster_fill(s : MlrlppoCluster, v : Double) -> MlrlppoCluster {
  let result = ml_rl_ppo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_cluster_min(s : MlrlppoCluster) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_cluster_max(s : MlrlppoCluster) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_cluster_to_string(s : MlrlppoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_model_make(size : Int) -> MlrlppoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_model_len(s : MlrlppoModel) -> Int { s.size }

pub fn ml_rl_ppo_model_get(s : MlrlppoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_model_set(s : MlrlppoModel, i : Int, v : Double) -> MlrlppoModel {
  let result = ml_rl_ppo_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_model_sum(s : MlrlppoModel) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_model_mean(s : MlrlppoModel) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_model_scale(s : MlrlppoModel, f : Double) -> MlrlppoModel {
  let result = ml_rl_ppo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ppo_model_add(a : MlrlppoModel, b : MlrlppoModel) -> MlrlppoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ppo_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ppo_model_copy(s : MlrlppoModel) -> MlrlppoModel {
  let result = ml_rl_ppo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ppo_model_fill(s : MlrlppoModel, v : Double) -> MlrlppoModel {
  let result = ml_rl_ppo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_model_min(s : MlrlppoModel) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_model_max(s : MlrlppoModel) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_model_to_string(s : MlrlppoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_layer_make(size : Int) -> MlrlppoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_layer_len(s : MlrlppoLayer) -> Int { s.size }

pub fn ml_rl_ppo_layer_get(s : MlrlppoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_layer_set(s : MlrlppoLayer, i : Int, v : Double) -> MlrlppoLayer {
  let result = ml_rl_ppo_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_layer_sum(s : MlrlppoLayer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_layer_mean(s : MlrlppoLayer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_layer_scale(s : MlrlppoLayer, f : Double) -> MlrlppoLayer {
  let result = ml_rl_ppo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ppo_layer_add(a : MlrlppoLayer, b : MlrlppoLayer) -> MlrlppoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ppo_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ppo_layer_copy(s : MlrlppoLayer) -> MlrlppoLayer {
  let result = ml_rl_ppo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ppo_layer_fill(s : MlrlppoLayer, v : Double) -> MlrlppoLayer {
  let result = ml_rl_ppo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_layer_min(s : MlrlppoLayer) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_layer_max(s : MlrlppoLayer) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_layer_to_string(s : MlrlppoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_buffer_make(size : Int) -> MlrlppoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_buffer_len(s : MlrlppoBuffer) -> Int { s.size }

pub fn ml_rl_ppo_buffer_get(s : MlrlppoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_buffer_set(s : MlrlppoBuffer, i : Int, v : Double) -> MlrlppoBuffer {
  let result = ml_rl_ppo_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_buffer_sum(s : MlrlppoBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_buffer_mean(s : MlrlppoBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_buffer_scale(s : MlrlppoBuffer, f : Double) -> MlrlppoBuffer {
  let result = ml_rl_ppo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ppo_buffer_add(a : MlrlppoBuffer, b : MlrlppoBuffer) -> MlrlppoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ppo_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ppo_buffer_copy(s : MlrlppoBuffer) -> MlrlppoBuffer {
  let result = ml_rl_ppo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ppo_buffer_fill(s : MlrlppoBuffer, v : Double) -> MlrlppoBuffer {
  let result = ml_rl_ppo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_buffer_min(s : MlrlppoBuffer) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_buffer_max(s : MlrlppoBuffer) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_buffer_to_string(s : MlrlppoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_cursor_make(size : Int) -> MlrlppoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_cursor_len(s : MlrlppoCursor) -> Int { s.size }

pub fn ml_rl_ppo_cursor_get(s : MlrlppoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_cursor_set(s : MlrlppoCursor, i : Int, v : Double) -> MlrlppoCursor {
  let result = ml_rl_ppo_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_cursor_sum(s : MlrlppoCursor) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_cursor_mean(s : MlrlppoCursor) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_cursor_scale(s : MlrlppoCursor, f : Double) -> MlrlppoCursor {
  let result = ml_rl_ppo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ppo_cursor_add(a : MlrlppoCursor, b : MlrlppoCursor) -> MlrlppoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ppo_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ppo_cursor_copy(s : MlrlppoCursor) -> MlrlppoCursor {
  let result = ml_rl_ppo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ppo_cursor_fill(s : MlrlppoCursor, v : Double) -> MlrlppoCursor {
  let result = ml_rl_ppo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_cursor_min(s : MlrlppoCursor) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_cursor_max(s : MlrlppoCursor) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_cursor_to_string(s : MlrlppoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_view_make(size : Int) -> MlrlppoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_view_len(s : MlrlppoView) -> Int { s.size }

pub fn ml_rl_ppo_view_get(s : MlrlppoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_view_set(s : MlrlppoView, i : Int, v : Double) -> MlrlppoView {
  let result = ml_rl_ppo_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_view_sum(s : MlrlppoView) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_view_mean(s : MlrlppoView) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_view_scale(s : MlrlppoView, f : Double) -> MlrlppoView {
  let result = ml_rl_ppo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ppo_view_add(a : MlrlppoView, b : MlrlppoView) -> MlrlppoView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ppo_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ppo_view_copy(s : MlrlppoView) -> MlrlppoView {
  let result = ml_rl_ppo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ppo_view_fill(s : MlrlppoView, v : Double) -> MlrlppoView {
  let result = ml_rl_ppo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_view_min(s : MlrlppoView) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_view_max(s : MlrlppoView) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_view_to_string(s : MlrlppoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_range_make(size : Int) -> MlrlppoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_range_len(s : MlrlppoRange) -> Int { s.size }

pub fn ml_rl_ppo_range_get(s : MlrlppoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_range_set(s : MlrlppoRange, i : Int, v : Double) -> MlrlppoRange {
  let result = ml_rl_ppo_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_range_sum(s : MlrlppoRange) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_range_mean(s : MlrlppoRange) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_range_scale(s : MlrlppoRange, f : Double) -> MlrlppoRange {
  let result = ml_rl_ppo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ppo_range_add(a : MlrlppoRange, b : MlrlppoRange) -> MlrlppoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ppo_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ppo_range_copy(s : MlrlppoRange) -> MlrlppoRange {
  let result = ml_rl_ppo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ppo_range_fill(s : MlrlppoRange, v : Double) -> MlrlppoRange {
  let result = ml_rl_ppo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_range_min(s : MlrlppoRange) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_range_max(s : MlrlppoRange) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_range_to_string(s : MlrlppoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlppoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_ppo_slice_make(size : Int) -> MlrlppoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_ppo_slice_len(s : MlrlppoSlice) -> Int { s.size }

pub fn ml_rl_ppo_slice_get(s : MlrlppoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_ppo_slice_set(s : MlrlppoSlice, i : Int, v : Double) -> MlrlppoSlice {
  let result = ml_rl_ppo_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_slice_sum(s : MlrlppoSlice) -> Double { @_common.sum(s.data) }

pub fn ml_rl_ppo_slice_mean(s : MlrlppoSlice) -> Double { @_common.mean(s.data) }

pub fn ml_rl_ppo_slice_scale(s : MlrlppoSlice, f : Double) -> MlrlppoSlice {
  let result = ml_rl_ppo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_ppo_slice_add(a : MlrlppoSlice, b : MlrlppoSlice) -> MlrlppoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_ppo_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_ppo_slice_copy(s : MlrlppoSlice) -> MlrlppoSlice {
  let result = ml_rl_ppo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_ppo_slice_fill(s : MlrlppoSlice, v : Double) -> MlrlppoSlice {
  let result = ml_rl_ppo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_ppo_slice_min(s : MlrlppoSlice) -> Double { @_common.min(s.data) }

pub fn ml_rl_ppo_slice_max(s : MlrlppoSlice) -> Double { @_common.max(s.data) }

pub fn ml_rl_ppo_slice_to_string(s : MlrlppoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

