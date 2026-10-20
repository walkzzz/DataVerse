///===
/// extcore/physics_em_wave

pub(all) struct PhysicsemwavePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_wave_make_point(x : Double, y : Double) -> PhysicsemwavePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_wave_make_point3(x : Double, y : Double, z : Double) -> PhysicsemwavePoint {
  { x, y, z, label: 0 }
}

pub fn physics_em_wave_point_x(pt : PhysicsemwavePoint) -> Double { pt.x }

pub fn physics_em_wave_point_y(pt : PhysicsemwavePoint) -> Double { pt.y }

pub fn physics_em_wave_point_z(pt : PhysicsemwavePoint) -> Double { pt.z }

pub fn physics_em_wave_point_label(pt : PhysicsemwavePoint) -> Int { pt.label }

pub fn physics_em_wave_point_dist(a : PhysicsemwavePoint, b : PhysicsemwavePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_em_wave_point_add(a : PhysicsemwavePoint, b : PhysicsemwavePoint) -> PhysicsemwavePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_em_wave_point_sub(a : PhysicsemwavePoint, b : PhysicsemwavePoint) -> PhysicsemwavePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_em_wave_point_scale(pt : PhysicsemwavePoint, s : Double) -> PhysicsemwavePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_em_wave_point_dot(a : PhysicsemwavePoint, b : PhysicsemwavePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_em_wave_point_cross(a : PhysicsemwavePoint, b : PhysicsemwavePoint) -> PhysicsemwavePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_em_wave_point_norm(pt : PhysicsemwavePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_em_wave_point_normalize(pt : PhysicsemwavePoint) -> PhysicsemwavePoint {
  let n = physics_em_wave_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_em_wave_point_scale(pt, 1.0 / n) }
}

pub fn physics_em_wave_point_negate(pt : PhysicsemwavePoint) -> PhysicsemwavePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_em_wave_point_mid(a : PhysicsemwavePoint, b : PhysicsemwavePoint) -> PhysicsemwavePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_em_wave_point_lerp(a : PhysicsemwavePoint, b : PhysicsemwavePoint, t : Double) -> PhysicsemwavePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_em_wave_point_to_string(pt : PhysicsemwavePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsemwaveSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_wave_make_series(vals : Array[Double], name : String) -> PhysicsemwaveSeries {
  { vals, name, meta: 0 }
}

pub fn physics_em_wave_series_len(s : PhysicsemwaveSeries) -> Int { s.vals.length() }

pub fn physics_em_wave_series_sum(s : PhysicsemwaveSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_em_wave_series_mean(s : PhysicsemwaveSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_em_wave_series_min(s : PhysicsemwaveSeries) -> Double { @_common.min(s.vals) }

pub fn physics_em_wave_series_max(s : PhysicsemwaveSeries) -> Double { @_common.max(s.vals) }

pub fn physics_em_wave_series_range(s : PhysicsemwaveSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_em_wave_series_var(s : PhysicsemwaveSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_em_wave_series_std(s : PhysicsemwaveSeries) -> Double { @_common.std(s.vals) }

pub fn physics_em_wave_series_median(s : PhysicsemwaveSeries) -> Double { @_common.median(s.vals) }

pub fn physics_em_wave_series_scale(s : PhysicsemwaveSeries, f : Double) -> PhysicsemwaveSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_em_wave_series_add(a : PhysicsemwaveSeries, b : PhysicsemwaveSeries) -> PhysicsemwaveSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_em_wave_series_sub(a : PhysicsemwaveSeries, b : PhysicsemwaveSeries) -> PhysicsemwaveSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_em_wave_series_normalize(s : PhysicsemwaveSeries) -> PhysicsemwaveSeries {
  let mn = physics_em_wave_series_min(s)
  let mx = physics_em_wave_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_em_wave_series_cumsum(s : PhysicsemwaveSeries) -> PhysicsemwaveSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_em_wave_series_to_string(s : PhysicsemwaveSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemwaveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_wave_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemwaveMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_wave_matrix_identity(n : Int) -> PhysicsemwaveMatrix {
  let m = physics_em_wave_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_em_wave_matrix_get(m : PhysicsemwaveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_em_wave_matrix_transpose(m : PhysicsemwaveMatrix) -> PhysicsemwaveMatrix {
  let result = physics_em_wave_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_em_wave_matrix_add(a : PhysicsemwaveMatrix, b : PhysicsemwaveMatrix) -> PhysicsemwaveMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_em_wave_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_em_wave_matrix_scale(m : PhysicsemwaveMatrix, s : Double) -> PhysicsemwaveMatrix {
  let result = physics_em_wave_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_em_wave_matrix_multiply(a : PhysicsemwaveMatrix, b : PhysicsemwaveMatrix) -> PhysicsemwaveMatrix {
  if a.cols != b.rows { return physics_em_wave_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_em_wave_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_em_wave_matrix_trace(m : PhysicsemwaveMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_em_wave_matrix_det(m : PhysicsemwaveMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_em_wave_matrix_norm(m : PhysicsemwaveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_em_wave_matrix_to_string(m : PhysicsemwaveMatrix) -> String {
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

pub(all) struct PhysicsemwaveVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_wave_make_vector(comps : Array[Double]) -> PhysicsemwaveVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_wave_vector_zero(dim : Int) -> PhysicsemwaveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_em_wave_vector_add(a : PhysicsemwaveVector, b : PhysicsemwaveVector) -> PhysicsemwaveVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_wave_vector_sub(a : PhysicsemwaveVector, b : PhysicsemwaveVector) -> PhysicsemwaveVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_wave_vector_scale(v : PhysicsemwaveVector, s : Double) -> PhysicsemwaveVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_em_wave_vector_dot(a : PhysicsemwaveVector, b : PhysicsemwaveVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_em_wave_vector_norm(v : PhysicsemwaveVector) -> Double { @_common.sqrt(physics_em_wave_vector_dot(v, v)) }

pub fn physics_em_wave_vector_normalize(v : PhysicsemwaveVector) -> PhysicsemwaveVector {
  let n = physics_em_wave_vector_norm(v)
  if n < 0.0000001 { v } else { physics_em_wave_vector_scale(v, 1.0 / n) }
}

pub fn physics_em_wave_vector_dist(a : PhysicsemwaveVector, b : PhysicsemwaveVector) -> Double {
  physics_em_wave_vector_norm(physics_em_wave_vector_sub(a, b))
}

pub fn physics_em_wave_vector_to_string(v : PhysicsemwaveVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_em_wave_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_em_wave_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_em_wave_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_em_wave_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_em_wave_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_em_wave_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_em_wave_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_em_wave_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_em_wave_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_em_wave_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_em_wave_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_em_wave_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_em_wave_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_em_wave_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_em_wave_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_em_wave_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_em_wave_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_em_wave_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_em_wave_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_em_wave_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_em_wave_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_em_wave_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_em_wave_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_em_wave_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_em_wave_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_em_wave_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_em_wave_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_em_wave_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_em_wave_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsemwaveFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_frame_make(size : Int) -> PhysicsemwaveFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_frame_len(s : PhysicsemwaveFrame) -> Int { s.size }

pub fn physics_em_wave_frame_get(s : PhysicsemwaveFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_frame_set(s : PhysicsemwaveFrame, i : Int, v : Double) -> PhysicsemwaveFrame {
  let result = physics_em_wave_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_frame_sum(s : PhysicsemwaveFrame) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_frame_mean(s : PhysicsemwaveFrame) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_frame_scale(s : PhysicsemwaveFrame, f : Double) -> PhysicsemwaveFrame {
  let result = physics_em_wave_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_wave_frame_add(a : PhysicsemwaveFrame, b : PhysicsemwaveFrame) -> PhysicsemwaveFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_wave_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_wave_frame_copy(s : PhysicsemwaveFrame) -> PhysicsemwaveFrame {
  let result = physics_em_wave_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_wave_frame_fill(s : PhysicsemwaveFrame, v : Double) -> PhysicsemwaveFrame {
  let result = physics_em_wave_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_frame_min(s : PhysicsemwaveFrame) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_frame_max(s : PhysicsemwaveFrame) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_frame_to_string(s : PhysicsemwaveFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_table_make(size : Int) -> PhysicsemwaveTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_table_len(s : PhysicsemwaveTable) -> Int { s.size }

pub fn physics_em_wave_table_get(s : PhysicsemwaveTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_table_set(s : PhysicsemwaveTable, i : Int, v : Double) -> PhysicsemwaveTable {
  let result = physics_em_wave_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_table_sum(s : PhysicsemwaveTable) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_table_mean(s : PhysicsemwaveTable) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_table_scale(s : PhysicsemwaveTable, f : Double) -> PhysicsemwaveTable {
  let result = physics_em_wave_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_wave_table_add(a : PhysicsemwaveTable, b : PhysicsemwaveTable) -> PhysicsemwaveTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_wave_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_wave_table_copy(s : PhysicsemwaveTable) -> PhysicsemwaveTable {
  let result = physics_em_wave_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_wave_table_fill(s : PhysicsemwaveTable, v : Double) -> PhysicsemwaveTable {
  let result = physics_em_wave_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_table_min(s : PhysicsemwaveTable) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_table_max(s : PhysicsemwaveTable) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_table_to_string(s : PhysicsemwaveTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_graphn_make(size : Int) -> PhysicsemwaveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_graphn_len(s : PhysicsemwaveGraphN) -> Int { s.size }

pub fn physics_em_wave_graphn_get(s : PhysicsemwaveGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_graphn_set(s : PhysicsemwaveGraphN, i : Int, v : Double) -> PhysicsemwaveGraphN {
  let result = physics_em_wave_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_graphn_sum(s : PhysicsemwaveGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_graphn_mean(s : PhysicsemwaveGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_graphn_scale(s : PhysicsemwaveGraphN, f : Double) -> PhysicsemwaveGraphN {
  let result = physics_em_wave_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_wave_graphn_add(a : PhysicsemwaveGraphN, b : PhysicsemwaveGraphN) -> PhysicsemwaveGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_wave_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_wave_graphn_copy(s : PhysicsemwaveGraphN) -> PhysicsemwaveGraphN {
  let result = physics_em_wave_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_wave_graphn_fill(s : PhysicsemwaveGraphN, v : Double) -> PhysicsemwaveGraphN {
  let result = physics_em_wave_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_graphn_min(s : PhysicsemwaveGraphN) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_graphn_max(s : PhysicsemwaveGraphN) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_graphn_to_string(s : PhysicsemwaveGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_node_make(size : Int) -> PhysicsemwaveNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_node_len(s : PhysicsemwaveNode) -> Int { s.size }

pub fn physics_em_wave_node_get(s : PhysicsemwaveNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_node_set(s : PhysicsemwaveNode, i : Int, v : Double) -> PhysicsemwaveNode {
  let result = physics_em_wave_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_node_sum(s : PhysicsemwaveNode) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_node_mean(s : PhysicsemwaveNode) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_node_scale(s : PhysicsemwaveNode, f : Double) -> PhysicsemwaveNode {
  let result = physics_em_wave_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_wave_node_add(a : PhysicsemwaveNode, b : PhysicsemwaveNode) -> PhysicsemwaveNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_wave_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_wave_node_copy(s : PhysicsemwaveNode) -> PhysicsemwaveNode {
  let result = physics_em_wave_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_wave_node_fill(s : PhysicsemwaveNode, v : Double) -> PhysicsemwaveNode {
  let result = physics_em_wave_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_node_min(s : PhysicsemwaveNode) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_node_max(s : PhysicsemwaveNode) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_node_to_string(s : PhysicsemwaveNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_edge_make(size : Int) -> PhysicsemwaveEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_edge_len(s : PhysicsemwaveEdge) -> Int { s.size }

pub fn physics_em_wave_edge_get(s : PhysicsemwaveEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_edge_set(s : PhysicsemwaveEdge, i : Int, v : Double) -> PhysicsemwaveEdge {
  let result = physics_em_wave_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_edge_sum(s : PhysicsemwaveEdge) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_edge_mean(s : PhysicsemwaveEdge) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_edge_scale(s : PhysicsemwaveEdge, f : Double) -> PhysicsemwaveEdge {
  let result = physics_em_wave_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_wave_edge_add(a : PhysicsemwaveEdge, b : PhysicsemwaveEdge) -> PhysicsemwaveEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_wave_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_wave_edge_copy(s : PhysicsemwaveEdge) -> PhysicsemwaveEdge {
  let result = physics_em_wave_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_wave_edge_fill(s : PhysicsemwaveEdge, v : Double) -> PhysicsemwaveEdge {
  let result = physics_em_wave_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_edge_min(s : PhysicsemwaveEdge) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_edge_max(s : PhysicsemwaveEdge) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_edge_to_string(s : PhysicsemwaveEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwavePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_path_make(size : Int) -> PhysicsemwavePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_path_len(s : PhysicsemwavePath) -> Int { s.size }

pub fn physics_em_wave_path_get(s : PhysicsemwavePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_path_set(s : PhysicsemwavePath, i : Int, v : Double) -> PhysicsemwavePath {
  let result = physics_em_wave_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_path_sum(s : PhysicsemwavePath) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_path_mean(s : PhysicsemwavePath) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_path_scale(s : PhysicsemwavePath, f : Double) -> PhysicsemwavePath {
  let result = physics_em_wave_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_wave_path_add(a : PhysicsemwavePath, b : PhysicsemwavePath) -> PhysicsemwavePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_wave_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_wave_path_copy(s : PhysicsemwavePath) -> PhysicsemwavePath {
  let result = physics_em_wave_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_wave_path_fill(s : PhysicsemwavePath, v : Double) -> PhysicsemwavePath {
  let result = physics_em_wave_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_path_min(s : PhysicsemwavePath) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_path_max(s : PhysicsemwavePath) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_path_to_string(s : PhysicsemwavePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_cluster_make(size : Int) -> PhysicsemwaveCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_cluster_len(s : PhysicsemwaveCluster) -> Int { s.size }

pub fn physics_em_wave_cluster_get(s : PhysicsemwaveCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_cluster_set(s : PhysicsemwaveCluster, i : Int, v : Double) -> PhysicsemwaveCluster {
  let result = physics_em_wave_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_cluster_sum(s : PhysicsemwaveCluster) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_cluster_mean(s : PhysicsemwaveCluster) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_cluster_scale(s : PhysicsemwaveCluster, f : Double) -> PhysicsemwaveCluster {
  let result = physics_em_wave_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_wave_cluster_add(a : PhysicsemwaveCluster, b : PhysicsemwaveCluster) -> PhysicsemwaveCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_wave_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_wave_cluster_copy(s : PhysicsemwaveCluster) -> PhysicsemwaveCluster {
  let result = physics_em_wave_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_wave_cluster_fill(s : PhysicsemwaveCluster, v : Double) -> PhysicsemwaveCluster {
  let result = physics_em_wave_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_cluster_min(s : PhysicsemwaveCluster) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_cluster_max(s : PhysicsemwaveCluster) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_cluster_to_string(s : PhysicsemwaveCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_model_make(size : Int) -> PhysicsemwaveModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_model_len(s : PhysicsemwaveModel) -> Int { s.size }

pub fn physics_em_wave_model_get(s : PhysicsemwaveModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_model_set(s : PhysicsemwaveModel, i : Int, v : Double) -> PhysicsemwaveModel {
  let result = physics_em_wave_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_model_sum(s : PhysicsemwaveModel) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_model_mean(s : PhysicsemwaveModel) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_model_scale(s : PhysicsemwaveModel, f : Double) -> PhysicsemwaveModel {
  let result = physics_em_wave_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_wave_model_add(a : PhysicsemwaveModel, b : PhysicsemwaveModel) -> PhysicsemwaveModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_wave_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_wave_model_copy(s : PhysicsemwaveModel) -> PhysicsemwaveModel {
  let result = physics_em_wave_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_wave_model_fill(s : PhysicsemwaveModel, v : Double) -> PhysicsemwaveModel {
  let result = physics_em_wave_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_model_min(s : PhysicsemwaveModel) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_model_max(s : PhysicsemwaveModel) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_model_to_string(s : PhysicsemwaveModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_layer_make(size : Int) -> PhysicsemwaveLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_layer_len(s : PhysicsemwaveLayer) -> Int { s.size }

pub fn physics_em_wave_layer_get(s : PhysicsemwaveLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_layer_set(s : PhysicsemwaveLayer, i : Int, v : Double) -> PhysicsemwaveLayer {
  let result = physics_em_wave_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_layer_sum(s : PhysicsemwaveLayer) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_layer_mean(s : PhysicsemwaveLayer) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_layer_scale(s : PhysicsemwaveLayer, f : Double) -> PhysicsemwaveLayer {
  let result = physics_em_wave_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_wave_layer_add(a : PhysicsemwaveLayer, b : PhysicsemwaveLayer) -> PhysicsemwaveLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_wave_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_wave_layer_copy(s : PhysicsemwaveLayer) -> PhysicsemwaveLayer {
  let result = physics_em_wave_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_wave_layer_fill(s : PhysicsemwaveLayer, v : Double) -> PhysicsemwaveLayer {
  let result = physics_em_wave_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_layer_min(s : PhysicsemwaveLayer) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_layer_max(s : PhysicsemwaveLayer) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_layer_to_string(s : PhysicsemwaveLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_buffer_make(size : Int) -> PhysicsemwaveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_buffer_len(s : PhysicsemwaveBuffer) -> Int { s.size }

pub fn physics_em_wave_buffer_get(s : PhysicsemwaveBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_buffer_set(s : PhysicsemwaveBuffer, i : Int, v : Double) -> PhysicsemwaveBuffer {
  let result = physics_em_wave_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_buffer_sum(s : PhysicsemwaveBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_buffer_mean(s : PhysicsemwaveBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_buffer_scale(s : PhysicsemwaveBuffer, f : Double) -> PhysicsemwaveBuffer {
  let result = physics_em_wave_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_wave_buffer_add(a : PhysicsemwaveBuffer, b : PhysicsemwaveBuffer) -> PhysicsemwaveBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_wave_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_wave_buffer_copy(s : PhysicsemwaveBuffer) -> PhysicsemwaveBuffer {
  let result = physics_em_wave_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_wave_buffer_fill(s : PhysicsemwaveBuffer, v : Double) -> PhysicsemwaveBuffer {
  let result = physics_em_wave_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_buffer_min(s : PhysicsemwaveBuffer) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_buffer_max(s : PhysicsemwaveBuffer) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_buffer_to_string(s : PhysicsemwaveBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_cursor_make(size : Int) -> PhysicsemwaveCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_cursor_len(s : PhysicsemwaveCursor) -> Int { s.size }

pub fn physics_em_wave_cursor_get(s : PhysicsemwaveCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_cursor_set(s : PhysicsemwaveCursor, i : Int, v : Double) -> PhysicsemwaveCursor {
  let result = physics_em_wave_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_cursor_sum(s : PhysicsemwaveCursor) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_cursor_mean(s : PhysicsemwaveCursor) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_cursor_scale(s : PhysicsemwaveCursor, f : Double) -> PhysicsemwaveCursor {
  let result = physics_em_wave_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_wave_cursor_add(a : PhysicsemwaveCursor, b : PhysicsemwaveCursor) -> PhysicsemwaveCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_wave_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_wave_cursor_copy(s : PhysicsemwaveCursor) -> PhysicsemwaveCursor {
  let result = physics_em_wave_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_wave_cursor_fill(s : PhysicsemwaveCursor, v : Double) -> PhysicsemwaveCursor {
  let result = physics_em_wave_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_cursor_min(s : PhysicsemwaveCursor) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_cursor_max(s : PhysicsemwaveCursor) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_cursor_to_string(s : PhysicsemwaveCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_view_make(size : Int) -> PhysicsemwaveView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_view_len(s : PhysicsemwaveView) -> Int { s.size }

pub fn physics_em_wave_view_get(s : PhysicsemwaveView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_view_set(s : PhysicsemwaveView, i : Int, v : Double) -> PhysicsemwaveView {
  let result = physics_em_wave_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_view_sum(s : PhysicsemwaveView) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_view_mean(s : PhysicsemwaveView) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_view_scale(s : PhysicsemwaveView, f : Double) -> PhysicsemwaveView {
  let result = physics_em_wave_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_wave_view_add(a : PhysicsemwaveView, b : PhysicsemwaveView) -> PhysicsemwaveView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_wave_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_wave_view_copy(s : PhysicsemwaveView) -> PhysicsemwaveView {
  let result = physics_em_wave_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_wave_view_fill(s : PhysicsemwaveView, v : Double) -> PhysicsemwaveView {
  let result = physics_em_wave_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_view_min(s : PhysicsemwaveView) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_view_max(s : PhysicsemwaveView) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_view_to_string(s : PhysicsemwaveView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_range_make(size : Int) -> PhysicsemwaveRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_range_len(s : PhysicsemwaveRange) -> Int { s.size }

pub fn physics_em_wave_range_get(s : PhysicsemwaveRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_range_set(s : PhysicsemwaveRange, i : Int, v : Double) -> PhysicsemwaveRange {
  let result = physics_em_wave_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_range_sum(s : PhysicsemwaveRange) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_range_mean(s : PhysicsemwaveRange) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_range_scale(s : PhysicsemwaveRange, f : Double) -> PhysicsemwaveRange {
  let result = physics_em_wave_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_wave_range_add(a : PhysicsemwaveRange, b : PhysicsemwaveRange) -> PhysicsemwaveRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_wave_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_wave_range_copy(s : PhysicsemwaveRange) -> PhysicsemwaveRange {
  let result = physics_em_wave_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_wave_range_fill(s : PhysicsemwaveRange, v : Double) -> PhysicsemwaveRange {
  let result = physics_em_wave_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_range_min(s : PhysicsemwaveRange) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_range_max(s : PhysicsemwaveRange) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_range_to_string(s : PhysicsemwaveRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemwaveSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_wave_slice_make(size : Int) -> PhysicsemwaveSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_wave_slice_len(s : PhysicsemwaveSlice) -> Int { s.size }

pub fn physics_em_wave_slice_get(s : PhysicsemwaveSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_wave_slice_set(s : PhysicsemwaveSlice, i : Int, v : Double) -> PhysicsemwaveSlice {
  let result = physics_em_wave_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_slice_sum(s : PhysicsemwaveSlice) -> Double { @_common.sum(s.data) }

pub fn physics_em_wave_slice_mean(s : PhysicsemwaveSlice) -> Double { @_common.mean(s.data) }

pub fn physics_em_wave_slice_scale(s : PhysicsemwaveSlice, f : Double) -> PhysicsemwaveSlice {
  let result = physics_em_wave_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_wave_slice_add(a : PhysicsemwaveSlice, b : PhysicsemwaveSlice) -> PhysicsemwaveSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_wave_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_wave_slice_copy(s : PhysicsemwaveSlice) -> PhysicsemwaveSlice {
  let result = physics_em_wave_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_wave_slice_fill(s : PhysicsemwaveSlice, v : Double) -> PhysicsemwaveSlice {
  let result = physics_em_wave_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_wave_slice_min(s : PhysicsemwaveSlice) -> Double { @_common.min(s.data) }

pub fn physics_em_wave_slice_max(s : PhysicsemwaveSlice) -> Double { @_common.max(s.data) }

pub fn physics_em_wave_slice_to_string(s : PhysicsemwaveSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

