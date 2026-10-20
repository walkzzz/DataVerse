///===
/// extcore/physics_mechanics_rigid

pub(all) struct PhysicsmechanicsrigidPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_rigid_make_point(x : Double, y : Double) -> PhysicsmechanicsrigidPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_rigid_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicsrigidPoint {
  { x, y, z, label: 0 }
}

pub fn physics_mechanics_rigid_point_x(pt : PhysicsmechanicsrigidPoint) -> Double { pt.x }

pub fn physics_mechanics_rigid_point_y(pt : PhysicsmechanicsrigidPoint) -> Double { pt.y }

pub fn physics_mechanics_rigid_point_z(pt : PhysicsmechanicsrigidPoint) -> Double { pt.z }

pub fn physics_mechanics_rigid_point_label(pt : PhysicsmechanicsrigidPoint) -> Int { pt.label }

pub fn physics_mechanics_rigid_point_dist(a : PhysicsmechanicsrigidPoint, b : PhysicsmechanicsrigidPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_mechanics_rigid_point_add(a : PhysicsmechanicsrigidPoint, b : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_mechanics_rigid_point_sub(a : PhysicsmechanicsrigidPoint, b : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_mechanics_rigid_point_scale(pt : PhysicsmechanicsrigidPoint, s : Double) -> PhysicsmechanicsrigidPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_mechanics_rigid_point_dot(a : PhysicsmechanicsrigidPoint, b : PhysicsmechanicsrigidPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_mechanics_rigid_point_cross(a : PhysicsmechanicsrigidPoint, b : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_mechanics_rigid_point_norm(pt : PhysicsmechanicsrigidPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_mechanics_rigid_point_normalize(pt : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  let n = physics_mechanics_rigid_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_mechanics_rigid_point_scale(pt, 1.0 / n) }
}

pub fn physics_mechanics_rigid_point_negate(pt : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_mechanics_rigid_point_mid(a : PhysicsmechanicsrigidPoint, b : PhysicsmechanicsrigidPoint) -> PhysicsmechanicsrigidPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_mechanics_rigid_point_lerp(a : PhysicsmechanicsrigidPoint, b : PhysicsmechanicsrigidPoint, t : Double) -> PhysicsmechanicsrigidPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_mechanics_rigid_point_to_string(pt : PhysicsmechanicsrigidPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_rigid_make_series(vals : Array[Double], name : String) -> PhysicsmechanicsrigidSeries {
  { vals, name, meta: 0 }
}

pub fn physics_mechanics_rigid_series_len(s : PhysicsmechanicsrigidSeries) -> Int { s.vals.length() }

pub fn physics_mechanics_rigid_series_sum(s : PhysicsmechanicsrigidSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_mechanics_rigid_series_mean(s : PhysicsmechanicsrigidSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_mechanics_rigid_series_min(s : PhysicsmechanicsrigidSeries) -> Double { @_common.min(s.vals) }

pub fn physics_mechanics_rigid_series_max(s : PhysicsmechanicsrigidSeries) -> Double { @_common.max(s.vals) }

pub fn physics_mechanics_rigid_series_range(s : PhysicsmechanicsrigidSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_mechanics_rigid_series_var(s : PhysicsmechanicsrigidSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_mechanics_rigid_series_std(s : PhysicsmechanicsrigidSeries) -> Double { @_common.std(s.vals) }

pub fn physics_mechanics_rigid_series_median(s : PhysicsmechanicsrigidSeries) -> Double { @_common.median(s.vals) }

pub fn physics_mechanics_rigid_series_scale(s : PhysicsmechanicsrigidSeries, f : Double) -> PhysicsmechanicsrigidSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_mechanics_rigid_series_add(a : PhysicsmechanicsrigidSeries, b : PhysicsmechanicsrigidSeries) -> PhysicsmechanicsrigidSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_mechanics_rigid_series_sub(a : PhysicsmechanicsrigidSeries, b : PhysicsmechanicsrigidSeries) -> PhysicsmechanicsrigidSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_mechanics_rigid_series_normalize(s : PhysicsmechanicsrigidSeries) -> PhysicsmechanicsrigidSeries {
  let mn = physics_mechanics_rigid_series_min(s)
  let mx = physics_mechanics_rigid_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_mechanics_rigid_series_cumsum(s : PhysicsmechanicsrigidSeries) -> PhysicsmechanicsrigidSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_mechanics_rigid_series_to_string(s : PhysicsmechanicsrigidSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsrigidMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_rigid_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicsrigidMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_rigid_matrix_identity(n : Int) -> PhysicsmechanicsrigidMatrix {
  let m = physics_mechanics_rigid_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_mechanics_rigid_matrix_get(m : PhysicsmechanicsrigidMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_mechanics_rigid_matrix_transpose(m : PhysicsmechanicsrigidMatrix) -> PhysicsmechanicsrigidMatrix {
  let result = physics_mechanics_rigid_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_mechanics_rigid_matrix_add(a : PhysicsmechanicsrigidMatrix, b : PhysicsmechanicsrigidMatrix) -> PhysicsmechanicsrigidMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_mechanics_rigid_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_mechanics_rigid_matrix_scale(m : PhysicsmechanicsrigidMatrix, s : Double) -> PhysicsmechanicsrigidMatrix {
  let result = physics_mechanics_rigid_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_mechanics_rigid_matrix_multiply(a : PhysicsmechanicsrigidMatrix, b : PhysicsmechanicsrigidMatrix) -> PhysicsmechanicsrigidMatrix {
  if a.cols != b.rows { return physics_mechanics_rigid_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_mechanics_rigid_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_mechanics_rigid_matrix_trace(m : PhysicsmechanicsrigidMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_mechanics_rigid_matrix_det(m : PhysicsmechanicsrigidMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_mechanics_rigid_matrix_norm(m : PhysicsmechanicsrigidMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_mechanics_rigid_matrix_to_string(m : PhysicsmechanicsrigidMatrix) -> String {
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

pub(all) struct PhysicsmechanicsrigidVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_rigid_make_vector(comps : Array[Double]) -> PhysicsmechanicsrigidVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_rigid_vector_zero(dim : Int) -> PhysicsmechanicsrigidVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_mechanics_rigid_vector_add(a : PhysicsmechanicsrigidVector, b : PhysicsmechanicsrigidVector) -> PhysicsmechanicsrigidVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_rigid_vector_sub(a : PhysicsmechanicsrigidVector, b : PhysicsmechanicsrigidVector) -> PhysicsmechanicsrigidVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_rigid_vector_scale(v : PhysicsmechanicsrigidVector, s : Double) -> PhysicsmechanicsrigidVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_mechanics_rigid_vector_dot(a : PhysicsmechanicsrigidVector, b : PhysicsmechanicsrigidVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_mechanics_rigid_vector_norm(v : PhysicsmechanicsrigidVector) -> Double { @_common.sqrt(physics_mechanics_rigid_vector_dot(v, v)) }

pub fn physics_mechanics_rigid_vector_normalize(v : PhysicsmechanicsrigidVector) -> PhysicsmechanicsrigidVector {
  let n = physics_mechanics_rigid_vector_norm(v)
  if n < 0.0000001 { v } else { physics_mechanics_rigid_vector_scale(v, 1.0 / n) }
}

pub fn physics_mechanics_rigid_vector_dist(a : PhysicsmechanicsrigidVector, b : PhysicsmechanicsrigidVector) -> Double {
  physics_mechanics_rigid_vector_norm(physics_mechanics_rigid_vector_sub(a, b))
}

pub fn physics_mechanics_rigid_vector_to_string(v : PhysicsmechanicsrigidVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_rigid_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_mechanics_rigid_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_mechanics_rigid_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_mechanics_rigid_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_mechanics_rigid_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_mechanics_rigid_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_mechanics_rigid_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_mechanics_rigid_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_mechanics_rigid_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_mechanics_rigid_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_mechanics_rigid_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_mechanics_rigid_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_mechanics_rigid_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_mechanics_rigid_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_mechanics_rigid_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_mechanics_rigid_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_mechanics_rigid_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_mechanics_rigid_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_mechanics_rigid_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_mechanics_rigid_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_mechanics_rigid_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_mechanics_rigid_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_mechanics_rigid_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_mechanics_rigid_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_mechanics_rigid_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_mechanics_rigid_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_mechanics_rigid_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_mechanics_rigid_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_mechanics_rigid_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsmechanicsrigidFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_frame_make(size : Int) -> PhysicsmechanicsrigidFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_frame_len(s : PhysicsmechanicsrigidFrame) -> Int { s.size }

pub fn physics_mechanics_rigid_frame_get(s : PhysicsmechanicsrigidFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_frame_set(s : PhysicsmechanicsrigidFrame, i : Int, v : Double) -> PhysicsmechanicsrigidFrame {
  let result = physics_mechanics_rigid_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_frame_sum(s : PhysicsmechanicsrigidFrame) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_frame_mean(s : PhysicsmechanicsrigidFrame) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_frame_scale(s : PhysicsmechanicsrigidFrame, f : Double) -> PhysicsmechanicsrigidFrame {
  let result = physics_mechanics_rigid_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_frame_add(a : PhysicsmechanicsrigidFrame, b : PhysicsmechanicsrigidFrame) -> PhysicsmechanicsrigidFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_frame_copy(s : PhysicsmechanicsrigidFrame) -> PhysicsmechanicsrigidFrame {
  let result = physics_mechanics_rigid_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_frame_fill(s : PhysicsmechanicsrigidFrame, v : Double) -> PhysicsmechanicsrigidFrame {
  let result = physics_mechanics_rigid_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_frame_min(s : PhysicsmechanicsrigidFrame) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_frame_max(s : PhysicsmechanicsrigidFrame) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_frame_to_string(s : PhysicsmechanicsrigidFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_table_make(size : Int) -> PhysicsmechanicsrigidTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_table_len(s : PhysicsmechanicsrigidTable) -> Int { s.size }

pub fn physics_mechanics_rigid_table_get(s : PhysicsmechanicsrigidTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_table_set(s : PhysicsmechanicsrigidTable, i : Int, v : Double) -> PhysicsmechanicsrigidTable {
  let result = physics_mechanics_rigid_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_table_sum(s : PhysicsmechanicsrigidTable) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_table_mean(s : PhysicsmechanicsrigidTable) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_table_scale(s : PhysicsmechanicsrigidTable, f : Double) -> PhysicsmechanicsrigidTable {
  let result = physics_mechanics_rigid_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_table_add(a : PhysicsmechanicsrigidTable, b : PhysicsmechanicsrigidTable) -> PhysicsmechanicsrigidTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_table_copy(s : PhysicsmechanicsrigidTable) -> PhysicsmechanicsrigidTable {
  let result = physics_mechanics_rigid_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_table_fill(s : PhysicsmechanicsrigidTable, v : Double) -> PhysicsmechanicsrigidTable {
  let result = physics_mechanics_rigid_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_table_min(s : PhysicsmechanicsrigidTable) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_table_max(s : PhysicsmechanicsrigidTable) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_table_to_string(s : PhysicsmechanicsrigidTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_graphn_make(size : Int) -> PhysicsmechanicsrigidGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_graphn_len(s : PhysicsmechanicsrigidGraphN) -> Int { s.size }

pub fn physics_mechanics_rigid_graphn_get(s : PhysicsmechanicsrigidGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_graphn_set(s : PhysicsmechanicsrigidGraphN, i : Int, v : Double) -> PhysicsmechanicsrigidGraphN {
  let result = physics_mechanics_rigid_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_graphn_sum(s : PhysicsmechanicsrigidGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_graphn_mean(s : PhysicsmechanicsrigidGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_graphn_scale(s : PhysicsmechanicsrigidGraphN, f : Double) -> PhysicsmechanicsrigidGraphN {
  let result = physics_mechanics_rigid_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_graphn_add(a : PhysicsmechanicsrigidGraphN, b : PhysicsmechanicsrigidGraphN) -> PhysicsmechanicsrigidGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_graphn_copy(s : PhysicsmechanicsrigidGraphN) -> PhysicsmechanicsrigidGraphN {
  let result = physics_mechanics_rigid_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_graphn_fill(s : PhysicsmechanicsrigidGraphN, v : Double) -> PhysicsmechanicsrigidGraphN {
  let result = physics_mechanics_rigid_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_graphn_min(s : PhysicsmechanicsrigidGraphN) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_graphn_max(s : PhysicsmechanicsrigidGraphN) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_graphn_to_string(s : PhysicsmechanicsrigidGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_node_make(size : Int) -> PhysicsmechanicsrigidNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_node_len(s : PhysicsmechanicsrigidNode) -> Int { s.size }

pub fn physics_mechanics_rigid_node_get(s : PhysicsmechanicsrigidNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_node_set(s : PhysicsmechanicsrigidNode, i : Int, v : Double) -> PhysicsmechanicsrigidNode {
  let result = physics_mechanics_rigid_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_node_sum(s : PhysicsmechanicsrigidNode) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_node_mean(s : PhysicsmechanicsrigidNode) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_node_scale(s : PhysicsmechanicsrigidNode, f : Double) -> PhysicsmechanicsrigidNode {
  let result = physics_mechanics_rigid_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_node_add(a : PhysicsmechanicsrigidNode, b : PhysicsmechanicsrigidNode) -> PhysicsmechanicsrigidNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_node_copy(s : PhysicsmechanicsrigidNode) -> PhysicsmechanicsrigidNode {
  let result = physics_mechanics_rigid_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_node_fill(s : PhysicsmechanicsrigidNode, v : Double) -> PhysicsmechanicsrigidNode {
  let result = physics_mechanics_rigid_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_node_min(s : PhysicsmechanicsrigidNode) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_node_max(s : PhysicsmechanicsrigidNode) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_node_to_string(s : PhysicsmechanicsrigidNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_edge_make(size : Int) -> PhysicsmechanicsrigidEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_edge_len(s : PhysicsmechanicsrigidEdge) -> Int { s.size }

pub fn physics_mechanics_rigid_edge_get(s : PhysicsmechanicsrigidEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_edge_set(s : PhysicsmechanicsrigidEdge, i : Int, v : Double) -> PhysicsmechanicsrigidEdge {
  let result = physics_mechanics_rigid_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_edge_sum(s : PhysicsmechanicsrigidEdge) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_edge_mean(s : PhysicsmechanicsrigidEdge) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_edge_scale(s : PhysicsmechanicsrigidEdge, f : Double) -> PhysicsmechanicsrigidEdge {
  let result = physics_mechanics_rigid_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_edge_add(a : PhysicsmechanicsrigidEdge, b : PhysicsmechanicsrigidEdge) -> PhysicsmechanicsrigidEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_edge_copy(s : PhysicsmechanicsrigidEdge) -> PhysicsmechanicsrigidEdge {
  let result = physics_mechanics_rigid_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_edge_fill(s : PhysicsmechanicsrigidEdge, v : Double) -> PhysicsmechanicsrigidEdge {
  let result = physics_mechanics_rigid_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_edge_min(s : PhysicsmechanicsrigidEdge) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_edge_max(s : PhysicsmechanicsrigidEdge) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_edge_to_string(s : PhysicsmechanicsrigidEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_path_make(size : Int) -> PhysicsmechanicsrigidPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_path_len(s : PhysicsmechanicsrigidPath) -> Int { s.size }

pub fn physics_mechanics_rigid_path_get(s : PhysicsmechanicsrigidPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_path_set(s : PhysicsmechanicsrigidPath, i : Int, v : Double) -> PhysicsmechanicsrigidPath {
  let result = physics_mechanics_rigid_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_path_sum(s : PhysicsmechanicsrigidPath) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_path_mean(s : PhysicsmechanicsrigidPath) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_path_scale(s : PhysicsmechanicsrigidPath, f : Double) -> PhysicsmechanicsrigidPath {
  let result = physics_mechanics_rigid_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_path_add(a : PhysicsmechanicsrigidPath, b : PhysicsmechanicsrigidPath) -> PhysicsmechanicsrigidPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_path_copy(s : PhysicsmechanicsrigidPath) -> PhysicsmechanicsrigidPath {
  let result = physics_mechanics_rigid_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_path_fill(s : PhysicsmechanicsrigidPath, v : Double) -> PhysicsmechanicsrigidPath {
  let result = physics_mechanics_rigid_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_path_min(s : PhysicsmechanicsrigidPath) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_path_max(s : PhysicsmechanicsrigidPath) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_path_to_string(s : PhysicsmechanicsrigidPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_cluster_make(size : Int) -> PhysicsmechanicsrigidCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_cluster_len(s : PhysicsmechanicsrigidCluster) -> Int { s.size }

pub fn physics_mechanics_rigid_cluster_get(s : PhysicsmechanicsrigidCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_cluster_set(s : PhysicsmechanicsrigidCluster, i : Int, v : Double) -> PhysicsmechanicsrigidCluster {
  let result = physics_mechanics_rigid_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_cluster_sum(s : PhysicsmechanicsrigidCluster) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_cluster_mean(s : PhysicsmechanicsrigidCluster) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_cluster_scale(s : PhysicsmechanicsrigidCluster, f : Double) -> PhysicsmechanicsrigidCluster {
  let result = physics_mechanics_rigid_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_cluster_add(a : PhysicsmechanicsrigidCluster, b : PhysicsmechanicsrigidCluster) -> PhysicsmechanicsrigidCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_cluster_copy(s : PhysicsmechanicsrigidCluster) -> PhysicsmechanicsrigidCluster {
  let result = physics_mechanics_rigid_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_cluster_fill(s : PhysicsmechanicsrigidCluster, v : Double) -> PhysicsmechanicsrigidCluster {
  let result = physics_mechanics_rigid_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_cluster_min(s : PhysicsmechanicsrigidCluster) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_cluster_max(s : PhysicsmechanicsrigidCluster) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_cluster_to_string(s : PhysicsmechanicsrigidCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_model_make(size : Int) -> PhysicsmechanicsrigidModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_model_len(s : PhysicsmechanicsrigidModel) -> Int { s.size }

pub fn physics_mechanics_rigid_model_get(s : PhysicsmechanicsrigidModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_model_set(s : PhysicsmechanicsrigidModel, i : Int, v : Double) -> PhysicsmechanicsrigidModel {
  let result = physics_mechanics_rigid_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_model_sum(s : PhysicsmechanicsrigidModel) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_model_mean(s : PhysicsmechanicsrigidModel) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_model_scale(s : PhysicsmechanicsrigidModel, f : Double) -> PhysicsmechanicsrigidModel {
  let result = physics_mechanics_rigid_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_model_add(a : PhysicsmechanicsrigidModel, b : PhysicsmechanicsrigidModel) -> PhysicsmechanicsrigidModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_model_copy(s : PhysicsmechanicsrigidModel) -> PhysicsmechanicsrigidModel {
  let result = physics_mechanics_rigid_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_model_fill(s : PhysicsmechanicsrigidModel, v : Double) -> PhysicsmechanicsrigidModel {
  let result = physics_mechanics_rigid_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_model_min(s : PhysicsmechanicsrigidModel) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_model_max(s : PhysicsmechanicsrigidModel) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_model_to_string(s : PhysicsmechanicsrigidModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_layer_make(size : Int) -> PhysicsmechanicsrigidLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_layer_len(s : PhysicsmechanicsrigidLayer) -> Int { s.size }

pub fn physics_mechanics_rigid_layer_get(s : PhysicsmechanicsrigidLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_layer_set(s : PhysicsmechanicsrigidLayer, i : Int, v : Double) -> PhysicsmechanicsrigidLayer {
  let result = physics_mechanics_rigid_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_layer_sum(s : PhysicsmechanicsrigidLayer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_layer_mean(s : PhysicsmechanicsrigidLayer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_layer_scale(s : PhysicsmechanicsrigidLayer, f : Double) -> PhysicsmechanicsrigidLayer {
  let result = physics_mechanics_rigid_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_layer_add(a : PhysicsmechanicsrigidLayer, b : PhysicsmechanicsrigidLayer) -> PhysicsmechanicsrigidLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_layer_copy(s : PhysicsmechanicsrigidLayer) -> PhysicsmechanicsrigidLayer {
  let result = physics_mechanics_rigid_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_layer_fill(s : PhysicsmechanicsrigidLayer, v : Double) -> PhysicsmechanicsrigidLayer {
  let result = physics_mechanics_rigid_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_layer_min(s : PhysicsmechanicsrigidLayer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_layer_max(s : PhysicsmechanicsrigidLayer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_layer_to_string(s : PhysicsmechanicsrigidLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_buffer_make(size : Int) -> PhysicsmechanicsrigidBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_buffer_len(s : PhysicsmechanicsrigidBuffer) -> Int { s.size }

pub fn physics_mechanics_rigid_buffer_get(s : PhysicsmechanicsrigidBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_buffer_set(s : PhysicsmechanicsrigidBuffer, i : Int, v : Double) -> PhysicsmechanicsrigidBuffer {
  let result = physics_mechanics_rigid_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_buffer_sum(s : PhysicsmechanicsrigidBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_buffer_mean(s : PhysicsmechanicsrigidBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_buffer_scale(s : PhysicsmechanicsrigidBuffer, f : Double) -> PhysicsmechanicsrigidBuffer {
  let result = physics_mechanics_rigid_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_buffer_add(a : PhysicsmechanicsrigidBuffer, b : PhysicsmechanicsrigidBuffer) -> PhysicsmechanicsrigidBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_buffer_copy(s : PhysicsmechanicsrigidBuffer) -> PhysicsmechanicsrigidBuffer {
  let result = physics_mechanics_rigid_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_buffer_fill(s : PhysicsmechanicsrigidBuffer, v : Double) -> PhysicsmechanicsrigidBuffer {
  let result = physics_mechanics_rigid_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_buffer_min(s : PhysicsmechanicsrigidBuffer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_buffer_max(s : PhysicsmechanicsrigidBuffer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_buffer_to_string(s : PhysicsmechanicsrigidBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_cursor_make(size : Int) -> PhysicsmechanicsrigidCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_cursor_len(s : PhysicsmechanicsrigidCursor) -> Int { s.size }

pub fn physics_mechanics_rigid_cursor_get(s : PhysicsmechanicsrigidCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_cursor_set(s : PhysicsmechanicsrigidCursor, i : Int, v : Double) -> PhysicsmechanicsrigidCursor {
  let result = physics_mechanics_rigid_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_cursor_sum(s : PhysicsmechanicsrigidCursor) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_cursor_mean(s : PhysicsmechanicsrigidCursor) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_cursor_scale(s : PhysicsmechanicsrigidCursor, f : Double) -> PhysicsmechanicsrigidCursor {
  let result = physics_mechanics_rigid_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_cursor_add(a : PhysicsmechanicsrigidCursor, b : PhysicsmechanicsrigidCursor) -> PhysicsmechanicsrigidCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_cursor_copy(s : PhysicsmechanicsrigidCursor) -> PhysicsmechanicsrigidCursor {
  let result = physics_mechanics_rigid_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_cursor_fill(s : PhysicsmechanicsrigidCursor, v : Double) -> PhysicsmechanicsrigidCursor {
  let result = physics_mechanics_rigid_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_cursor_min(s : PhysicsmechanicsrigidCursor) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_cursor_max(s : PhysicsmechanicsrigidCursor) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_cursor_to_string(s : PhysicsmechanicsrigidCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_view_make(size : Int) -> PhysicsmechanicsrigidView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_view_len(s : PhysicsmechanicsrigidView) -> Int { s.size }

pub fn physics_mechanics_rigid_view_get(s : PhysicsmechanicsrigidView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_view_set(s : PhysicsmechanicsrigidView, i : Int, v : Double) -> PhysicsmechanicsrigidView {
  let result = physics_mechanics_rigid_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_view_sum(s : PhysicsmechanicsrigidView) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_view_mean(s : PhysicsmechanicsrigidView) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_view_scale(s : PhysicsmechanicsrigidView, f : Double) -> PhysicsmechanicsrigidView {
  let result = physics_mechanics_rigid_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_view_add(a : PhysicsmechanicsrigidView, b : PhysicsmechanicsrigidView) -> PhysicsmechanicsrigidView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_view_copy(s : PhysicsmechanicsrigidView) -> PhysicsmechanicsrigidView {
  let result = physics_mechanics_rigid_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_view_fill(s : PhysicsmechanicsrigidView, v : Double) -> PhysicsmechanicsrigidView {
  let result = physics_mechanics_rigid_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_view_min(s : PhysicsmechanicsrigidView) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_view_max(s : PhysicsmechanicsrigidView) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_view_to_string(s : PhysicsmechanicsrigidView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_range_make(size : Int) -> PhysicsmechanicsrigidRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_range_len(s : PhysicsmechanicsrigidRange) -> Int { s.size }

pub fn physics_mechanics_rigid_range_get(s : PhysicsmechanicsrigidRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_range_set(s : PhysicsmechanicsrigidRange, i : Int, v : Double) -> PhysicsmechanicsrigidRange {
  let result = physics_mechanics_rigid_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_range_sum(s : PhysicsmechanicsrigidRange) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_range_mean(s : PhysicsmechanicsrigidRange) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_range_scale(s : PhysicsmechanicsrigidRange, f : Double) -> PhysicsmechanicsrigidRange {
  let result = physics_mechanics_rigid_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_range_add(a : PhysicsmechanicsrigidRange, b : PhysicsmechanicsrigidRange) -> PhysicsmechanicsrigidRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_range_copy(s : PhysicsmechanicsrigidRange) -> PhysicsmechanicsrigidRange {
  let result = physics_mechanics_rigid_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_range_fill(s : PhysicsmechanicsrigidRange, v : Double) -> PhysicsmechanicsrigidRange {
  let result = physics_mechanics_rigid_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_range_min(s : PhysicsmechanicsrigidRange) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_range_max(s : PhysicsmechanicsrigidRange) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_range_to_string(s : PhysicsmechanicsrigidRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsrigidSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_rigid_slice_make(size : Int) -> PhysicsmechanicsrigidSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_rigid_slice_len(s : PhysicsmechanicsrigidSlice) -> Int { s.size }

pub fn physics_mechanics_rigid_slice_get(s : PhysicsmechanicsrigidSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_rigid_slice_set(s : PhysicsmechanicsrigidSlice, i : Int, v : Double) -> PhysicsmechanicsrigidSlice {
  let result = physics_mechanics_rigid_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_slice_sum(s : PhysicsmechanicsrigidSlice) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_rigid_slice_mean(s : PhysicsmechanicsrigidSlice) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_rigid_slice_scale(s : PhysicsmechanicsrigidSlice, f : Double) -> PhysicsmechanicsrigidSlice {
  let result = physics_mechanics_rigid_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_rigid_slice_add(a : PhysicsmechanicsrigidSlice, b : PhysicsmechanicsrigidSlice) -> PhysicsmechanicsrigidSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_rigid_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_rigid_slice_copy(s : PhysicsmechanicsrigidSlice) -> PhysicsmechanicsrigidSlice {
  let result = physics_mechanics_rigid_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_rigid_slice_fill(s : PhysicsmechanicsrigidSlice, v : Double) -> PhysicsmechanicsrigidSlice {
  let result = physics_mechanics_rigid_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_rigid_slice_min(s : PhysicsmechanicsrigidSlice) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_rigid_slice_max(s : PhysicsmechanicsrigidSlice) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_rigid_slice_to_string(s : PhysicsmechanicsrigidSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

