///===
/// extcore/physics_fluid_compressible

pub(all) struct PhysicsfluidcompressiblePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_compressible_make_point(x : Double, y : Double) -> PhysicsfluidcompressiblePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_compressible_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidcompressiblePoint {
  { x, y, z, label: 0 }
}

pub fn physics_fluid_compressible_point_x(pt : PhysicsfluidcompressiblePoint) -> Double { pt.x }

pub fn physics_fluid_compressible_point_y(pt : PhysicsfluidcompressiblePoint) -> Double { pt.y }

pub fn physics_fluid_compressible_point_z(pt : PhysicsfluidcompressiblePoint) -> Double { pt.z }

pub fn physics_fluid_compressible_point_label(pt : PhysicsfluidcompressiblePoint) -> Int { pt.label }

pub fn physics_fluid_compressible_point_dist(a : PhysicsfluidcompressiblePoint, b : PhysicsfluidcompressiblePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_fluid_compressible_point_add(a : PhysicsfluidcompressiblePoint, b : PhysicsfluidcompressiblePoint) -> PhysicsfluidcompressiblePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_fluid_compressible_point_sub(a : PhysicsfluidcompressiblePoint, b : PhysicsfluidcompressiblePoint) -> PhysicsfluidcompressiblePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_fluid_compressible_point_scale(pt : PhysicsfluidcompressiblePoint, s : Double) -> PhysicsfluidcompressiblePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_fluid_compressible_point_dot(a : PhysicsfluidcompressiblePoint, b : PhysicsfluidcompressiblePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_fluid_compressible_point_cross(a : PhysicsfluidcompressiblePoint, b : PhysicsfluidcompressiblePoint) -> PhysicsfluidcompressiblePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_fluid_compressible_point_norm(pt : PhysicsfluidcompressiblePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_fluid_compressible_point_normalize(pt : PhysicsfluidcompressiblePoint) -> PhysicsfluidcompressiblePoint {
  let n = physics_fluid_compressible_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_fluid_compressible_point_scale(pt, 1.0 / n) }
}

pub fn physics_fluid_compressible_point_negate(pt : PhysicsfluidcompressiblePoint) -> PhysicsfluidcompressiblePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_fluid_compressible_point_mid(a : PhysicsfluidcompressiblePoint, b : PhysicsfluidcompressiblePoint) -> PhysicsfluidcompressiblePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_fluid_compressible_point_lerp(a : PhysicsfluidcompressiblePoint, b : PhysicsfluidcompressiblePoint, t : Double) -> PhysicsfluidcompressiblePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_fluid_compressible_point_to_string(pt : PhysicsfluidcompressiblePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_compressible_make_series(vals : Array[Double], name : String) -> PhysicsfluidcompressibleSeries {
  { vals, name, meta: 0 }
}

pub fn physics_fluid_compressible_series_len(s : PhysicsfluidcompressibleSeries) -> Int { s.vals.length() }

pub fn physics_fluid_compressible_series_sum(s : PhysicsfluidcompressibleSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_fluid_compressible_series_mean(s : PhysicsfluidcompressibleSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_fluid_compressible_series_min(s : PhysicsfluidcompressibleSeries) -> Double { @_common.min(s.vals) }

pub fn physics_fluid_compressible_series_max(s : PhysicsfluidcompressibleSeries) -> Double { @_common.max(s.vals) }

pub fn physics_fluid_compressible_series_range(s : PhysicsfluidcompressibleSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_fluid_compressible_series_var(s : PhysicsfluidcompressibleSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_fluid_compressible_series_std(s : PhysicsfluidcompressibleSeries) -> Double { @_common.std(s.vals) }

pub fn physics_fluid_compressible_series_median(s : PhysicsfluidcompressibleSeries) -> Double { @_common.median(s.vals) }

pub fn physics_fluid_compressible_series_scale(s : PhysicsfluidcompressibleSeries, f : Double) -> PhysicsfluidcompressibleSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_fluid_compressible_series_add(a : PhysicsfluidcompressibleSeries, b : PhysicsfluidcompressibleSeries) -> PhysicsfluidcompressibleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_fluid_compressible_series_sub(a : PhysicsfluidcompressibleSeries, b : PhysicsfluidcompressibleSeries) -> PhysicsfluidcompressibleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_fluid_compressible_series_normalize(s : PhysicsfluidcompressibleSeries) -> PhysicsfluidcompressibleSeries {
  let mn = physics_fluid_compressible_series_min(s)
  let mx = physics_fluid_compressible_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_fluid_compressible_series_cumsum(s : PhysicsfluidcompressibleSeries) -> PhysicsfluidcompressibleSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_fluid_compressible_series_to_string(s : PhysicsfluidcompressibleSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidcompressibleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_compressible_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidcompressibleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_compressible_matrix_identity(n : Int) -> PhysicsfluidcompressibleMatrix {
  let m = physics_fluid_compressible_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_fluid_compressible_matrix_get(m : PhysicsfluidcompressibleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_fluid_compressible_matrix_transpose(m : PhysicsfluidcompressibleMatrix) -> PhysicsfluidcompressibleMatrix {
  let result = physics_fluid_compressible_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_fluid_compressible_matrix_add(a : PhysicsfluidcompressibleMatrix, b : PhysicsfluidcompressibleMatrix) -> PhysicsfluidcompressibleMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_fluid_compressible_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_fluid_compressible_matrix_scale(m : PhysicsfluidcompressibleMatrix, s : Double) -> PhysicsfluidcompressibleMatrix {
  let result = physics_fluid_compressible_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_fluid_compressible_matrix_multiply(a : PhysicsfluidcompressibleMatrix, b : PhysicsfluidcompressibleMatrix) -> PhysicsfluidcompressibleMatrix {
  if a.cols != b.rows { return physics_fluid_compressible_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_fluid_compressible_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_fluid_compressible_matrix_trace(m : PhysicsfluidcompressibleMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_fluid_compressible_matrix_det(m : PhysicsfluidcompressibleMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_fluid_compressible_matrix_norm(m : PhysicsfluidcompressibleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_fluid_compressible_matrix_to_string(m : PhysicsfluidcompressibleMatrix) -> String {
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

pub(all) struct PhysicsfluidcompressibleVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_compressible_make_vector(comps : Array[Double]) -> PhysicsfluidcompressibleVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_compressible_vector_zero(dim : Int) -> PhysicsfluidcompressibleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_fluid_compressible_vector_add(a : PhysicsfluidcompressibleVector, b : PhysicsfluidcompressibleVector) -> PhysicsfluidcompressibleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_compressible_vector_sub(a : PhysicsfluidcompressibleVector, b : PhysicsfluidcompressibleVector) -> PhysicsfluidcompressibleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_compressible_vector_scale(v : PhysicsfluidcompressibleVector, s : Double) -> PhysicsfluidcompressibleVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_fluid_compressible_vector_dot(a : PhysicsfluidcompressibleVector, b : PhysicsfluidcompressibleVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_fluid_compressible_vector_norm(v : PhysicsfluidcompressibleVector) -> Double { @_common.sqrt(physics_fluid_compressible_vector_dot(v, v)) }

pub fn physics_fluid_compressible_vector_normalize(v : PhysicsfluidcompressibleVector) -> PhysicsfluidcompressibleVector {
  let n = physics_fluid_compressible_vector_norm(v)
  if n < 0.0000001 { v } else { physics_fluid_compressible_vector_scale(v, 1.0 / n) }
}

pub fn physics_fluid_compressible_vector_dist(a : PhysicsfluidcompressibleVector, b : PhysicsfluidcompressibleVector) -> Double {
  physics_fluid_compressible_vector_norm(physics_fluid_compressible_vector_sub(a, b))
}

pub fn physics_fluid_compressible_vector_to_string(v : PhysicsfluidcompressibleVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_compressible_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_fluid_compressible_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_fluid_compressible_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_fluid_compressible_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_fluid_compressible_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_fluid_compressible_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_fluid_compressible_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_fluid_compressible_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_fluid_compressible_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_fluid_compressible_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_fluid_compressible_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_fluid_compressible_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_fluid_compressible_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_fluid_compressible_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_fluid_compressible_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_fluid_compressible_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_fluid_compressible_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_fluid_compressible_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_fluid_compressible_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_fluid_compressible_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_fluid_compressible_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_fluid_compressible_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_fluid_compressible_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_fluid_compressible_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_fluid_compressible_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_fluid_compressible_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_fluid_compressible_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_fluid_compressible_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_fluid_compressible_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsfluidcompressibleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_frame_make(size : Int) -> PhysicsfluidcompressibleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_frame_len(s : PhysicsfluidcompressibleFrame) -> Int { s.size }

pub fn physics_fluid_compressible_frame_get(s : PhysicsfluidcompressibleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_frame_set(s : PhysicsfluidcompressibleFrame, i : Int, v : Double) -> PhysicsfluidcompressibleFrame {
  let result = physics_fluid_compressible_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_frame_sum(s : PhysicsfluidcompressibleFrame) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_frame_mean(s : PhysicsfluidcompressibleFrame) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_frame_scale(s : PhysicsfluidcompressibleFrame, f : Double) -> PhysicsfluidcompressibleFrame {
  let result = physics_fluid_compressible_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_compressible_frame_add(a : PhysicsfluidcompressibleFrame, b : PhysicsfluidcompressibleFrame) -> PhysicsfluidcompressibleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_compressible_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_compressible_frame_copy(s : PhysicsfluidcompressibleFrame) -> PhysicsfluidcompressibleFrame {
  let result = physics_fluid_compressible_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_compressible_frame_fill(s : PhysicsfluidcompressibleFrame, v : Double) -> PhysicsfluidcompressibleFrame {
  let result = physics_fluid_compressible_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_frame_min(s : PhysicsfluidcompressibleFrame) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_frame_max(s : PhysicsfluidcompressibleFrame) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_frame_to_string(s : PhysicsfluidcompressibleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_table_make(size : Int) -> PhysicsfluidcompressibleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_table_len(s : PhysicsfluidcompressibleTable) -> Int { s.size }

pub fn physics_fluid_compressible_table_get(s : PhysicsfluidcompressibleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_table_set(s : PhysicsfluidcompressibleTable, i : Int, v : Double) -> PhysicsfluidcompressibleTable {
  let result = physics_fluid_compressible_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_table_sum(s : PhysicsfluidcompressibleTable) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_table_mean(s : PhysicsfluidcompressibleTable) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_table_scale(s : PhysicsfluidcompressibleTable, f : Double) -> PhysicsfluidcompressibleTable {
  let result = physics_fluid_compressible_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_compressible_table_add(a : PhysicsfluidcompressibleTable, b : PhysicsfluidcompressibleTable) -> PhysicsfluidcompressibleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_compressible_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_compressible_table_copy(s : PhysicsfluidcompressibleTable) -> PhysicsfluidcompressibleTable {
  let result = physics_fluid_compressible_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_compressible_table_fill(s : PhysicsfluidcompressibleTable, v : Double) -> PhysicsfluidcompressibleTable {
  let result = physics_fluid_compressible_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_table_min(s : PhysicsfluidcompressibleTable) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_table_max(s : PhysicsfluidcompressibleTable) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_table_to_string(s : PhysicsfluidcompressibleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_graphn_make(size : Int) -> PhysicsfluidcompressibleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_graphn_len(s : PhysicsfluidcompressibleGraphN) -> Int { s.size }

pub fn physics_fluid_compressible_graphn_get(s : PhysicsfluidcompressibleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_graphn_set(s : PhysicsfluidcompressibleGraphN, i : Int, v : Double) -> PhysicsfluidcompressibleGraphN {
  let result = physics_fluid_compressible_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_graphn_sum(s : PhysicsfluidcompressibleGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_graphn_mean(s : PhysicsfluidcompressibleGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_graphn_scale(s : PhysicsfluidcompressibleGraphN, f : Double) -> PhysicsfluidcompressibleGraphN {
  let result = physics_fluid_compressible_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_compressible_graphn_add(a : PhysicsfluidcompressibleGraphN, b : PhysicsfluidcompressibleGraphN) -> PhysicsfluidcompressibleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_compressible_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_compressible_graphn_copy(s : PhysicsfluidcompressibleGraphN) -> PhysicsfluidcompressibleGraphN {
  let result = physics_fluid_compressible_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_compressible_graphn_fill(s : PhysicsfluidcompressibleGraphN, v : Double) -> PhysicsfluidcompressibleGraphN {
  let result = physics_fluid_compressible_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_graphn_min(s : PhysicsfluidcompressibleGraphN) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_graphn_max(s : PhysicsfluidcompressibleGraphN) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_graphn_to_string(s : PhysicsfluidcompressibleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_node_make(size : Int) -> PhysicsfluidcompressibleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_node_len(s : PhysicsfluidcompressibleNode) -> Int { s.size }

pub fn physics_fluid_compressible_node_get(s : PhysicsfluidcompressibleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_node_set(s : PhysicsfluidcompressibleNode, i : Int, v : Double) -> PhysicsfluidcompressibleNode {
  let result = physics_fluid_compressible_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_node_sum(s : PhysicsfluidcompressibleNode) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_node_mean(s : PhysicsfluidcompressibleNode) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_node_scale(s : PhysicsfluidcompressibleNode, f : Double) -> PhysicsfluidcompressibleNode {
  let result = physics_fluid_compressible_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_compressible_node_add(a : PhysicsfluidcompressibleNode, b : PhysicsfluidcompressibleNode) -> PhysicsfluidcompressibleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_compressible_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_compressible_node_copy(s : PhysicsfluidcompressibleNode) -> PhysicsfluidcompressibleNode {
  let result = physics_fluid_compressible_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_compressible_node_fill(s : PhysicsfluidcompressibleNode, v : Double) -> PhysicsfluidcompressibleNode {
  let result = physics_fluid_compressible_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_node_min(s : PhysicsfluidcompressibleNode) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_node_max(s : PhysicsfluidcompressibleNode) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_node_to_string(s : PhysicsfluidcompressibleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_edge_make(size : Int) -> PhysicsfluidcompressibleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_edge_len(s : PhysicsfluidcompressibleEdge) -> Int { s.size }

pub fn physics_fluid_compressible_edge_get(s : PhysicsfluidcompressibleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_edge_set(s : PhysicsfluidcompressibleEdge, i : Int, v : Double) -> PhysicsfluidcompressibleEdge {
  let result = physics_fluid_compressible_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_edge_sum(s : PhysicsfluidcompressibleEdge) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_edge_mean(s : PhysicsfluidcompressibleEdge) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_edge_scale(s : PhysicsfluidcompressibleEdge, f : Double) -> PhysicsfluidcompressibleEdge {
  let result = physics_fluid_compressible_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_compressible_edge_add(a : PhysicsfluidcompressibleEdge, b : PhysicsfluidcompressibleEdge) -> PhysicsfluidcompressibleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_compressible_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_compressible_edge_copy(s : PhysicsfluidcompressibleEdge) -> PhysicsfluidcompressibleEdge {
  let result = physics_fluid_compressible_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_compressible_edge_fill(s : PhysicsfluidcompressibleEdge, v : Double) -> PhysicsfluidcompressibleEdge {
  let result = physics_fluid_compressible_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_edge_min(s : PhysicsfluidcompressibleEdge) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_edge_max(s : PhysicsfluidcompressibleEdge) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_edge_to_string(s : PhysicsfluidcompressibleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressiblePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_path_make(size : Int) -> PhysicsfluidcompressiblePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_path_len(s : PhysicsfluidcompressiblePath) -> Int { s.size }

pub fn physics_fluid_compressible_path_get(s : PhysicsfluidcompressiblePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_path_set(s : PhysicsfluidcompressiblePath, i : Int, v : Double) -> PhysicsfluidcompressiblePath {
  let result = physics_fluid_compressible_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_path_sum(s : PhysicsfluidcompressiblePath) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_path_mean(s : PhysicsfluidcompressiblePath) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_path_scale(s : PhysicsfluidcompressiblePath, f : Double) -> PhysicsfluidcompressiblePath {
  let result = physics_fluid_compressible_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_compressible_path_add(a : PhysicsfluidcompressiblePath, b : PhysicsfluidcompressiblePath) -> PhysicsfluidcompressiblePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_compressible_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_compressible_path_copy(s : PhysicsfluidcompressiblePath) -> PhysicsfluidcompressiblePath {
  let result = physics_fluid_compressible_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_compressible_path_fill(s : PhysicsfluidcompressiblePath, v : Double) -> PhysicsfluidcompressiblePath {
  let result = physics_fluid_compressible_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_path_min(s : PhysicsfluidcompressiblePath) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_path_max(s : PhysicsfluidcompressiblePath) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_path_to_string(s : PhysicsfluidcompressiblePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_cluster_make(size : Int) -> PhysicsfluidcompressibleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_cluster_len(s : PhysicsfluidcompressibleCluster) -> Int { s.size }

pub fn physics_fluid_compressible_cluster_get(s : PhysicsfluidcompressibleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_cluster_set(s : PhysicsfluidcompressibleCluster, i : Int, v : Double) -> PhysicsfluidcompressibleCluster {
  let result = physics_fluid_compressible_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_cluster_sum(s : PhysicsfluidcompressibleCluster) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_cluster_mean(s : PhysicsfluidcompressibleCluster) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_cluster_scale(s : PhysicsfluidcompressibleCluster, f : Double) -> PhysicsfluidcompressibleCluster {
  let result = physics_fluid_compressible_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_compressible_cluster_add(a : PhysicsfluidcompressibleCluster, b : PhysicsfluidcompressibleCluster) -> PhysicsfluidcompressibleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_compressible_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_compressible_cluster_copy(s : PhysicsfluidcompressibleCluster) -> PhysicsfluidcompressibleCluster {
  let result = physics_fluid_compressible_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_compressible_cluster_fill(s : PhysicsfluidcompressibleCluster, v : Double) -> PhysicsfluidcompressibleCluster {
  let result = physics_fluid_compressible_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_cluster_min(s : PhysicsfluidcompressibleCluster) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_cluster_max(s : PhysicsfluidcompressibleCluster) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_cluster_to_string(s : PhysicsfluidcompressibleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_model_make(size : Int) -> PhysicsfluidcompressibleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_model_len(s : PhysicsfluidcompressibleModel) -> Int { s.size }

pub fn physics_fluid_compressible_model_get(s : PhysicsfluidcompressibleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_model_set(s : PhysicsfluidcompressibleModel, i : Int, v : Double) -> PhysicsfluidcompressibleModel {
  let result = physics_fluid_compressible_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_model_sum(s : PhysicsfluidcompressibleModel) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_model_mean(s : PhysicsfluidcompressibleModel) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_model_scale(s : PhysicsfluidcompressibleModel, f : Double) -> PhysicsfluidcompressibleModel {
  let result = physics_fluid_compressible_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_compressible_model_add(a : PhysicsfluidcompressibleModel, b : PhysicsfluidcompressibleModel) -> PhysicsfluidcompressibleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_compressible_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_compressible_model_copy(s : PhysicsfluidcompressibleModel) -> PhysicsfluidcompressibleModel {
  let result = physics_fluid_compressible_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_compressible_model_fill(s : PhysicsfluidcompressibleModel, v : Double) -> PhysicsfluidcompressibleModel {
  let result = physics_fluid_compressible_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_model_min(s : PhysicsfluidcompressibleModel) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_model_max(s : PhysicsfluidcompressibleModel) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_model_to_string(s : PhysicsfluidcompressibleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_layer_make(size : Int) -> PhysicsfluidcompressibleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_layer_len(s : PhysicsfluidcompressibleLayer) -> Int { s.size }

pub fn physics_fluid_compressible_layer_get(s : PhysicsfluidcompressibleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_layer_set(s : PhysicsfluidcompressibleLayer, i : Int, v : Double) -> PhysicsfluidcompressibleLayer {
  let result = physics_fluid_compressible_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_layer_sum(s : PhysicsfluidcompressibleLayer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_layer_mean(s : PhysicsfluidcompressibleLayer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_layer_scale(s : PhysicsfluidcompressibleLayer, f : Double) -> PhysicsfluidcompressibleLayer {
  let result = physics_fluid_compressible_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_compressible_layer_add(a : PhysicsfluidcompressibleLayer, b : PhysicsfluidcompressibleLayer) -> PhysicsfluidcompressibleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_compressible_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_compressible_layer_copy(s : PhysicsfluidcompressibleLayer) -> PhysicsfluidcompressibleLayer {
  let result = physics_fluid_compressible_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_compressible_layer_fill(s : PhysicsfluidcompressibleLayer, v : Double) -> PhysicsfluidcompressibleLayer {
  let result = physics_fluid_compressible_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_layer_min(s : PhysicsfluidcompressibleLayer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_layer_max(s : PhysicsfluidcompressibleLayer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_layer_to_string(s : PhysicsfluidcompressibleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_buffer_make(size : Int) -> PhysicsfluidcompressibleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_buffer_len(s : PhysicsfluidcompressibleBuffer) -> Int { s.size }

pub fn physics_fluid_compressible_buffer_get(s : PhysicsfluidcompressibleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_buffer_set(s : PhysicsfluidcompressibleBuffer, i : Int, v : Double) -> PhysicsfluidcompressibleBuffer {
  let result = physics_fluid_compressible_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_buffer_sum(s : PhysicsfluidcompressibleBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_buffer_mean(s : PhysicsfluidcompressibleBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_buffer_scale(s : PhysicsfluidcompressibleBuffer, f : Double) -> PhysicsfluidcompressibleBuffer {
  let result = physics_fluid_compressible_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_compressible_buffer_add(a : PhysicsfluidcompressibleBuffer, b : PhysicsfluidcompressibleBuffer) -> PhysicsfluidcompressibleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_compressible_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_compressible_buffer_copy(s : PhysicsfluidcompressibleBuffer) -> PhysicsfluidcompressibleBuffer {
  let result = physics_fluid_compressible_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_compressible_buffer_fill(s : PhysicsfluidcompressibleBuffer, v : Double) -> PhysicsfluidcompressibleBuffer {
  let result = physics_fluid_compressible_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_buffer_min(s : PhysicsfluidcompressibleBuffer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_buffer_max(s : PhysicsfluidcompressibleBuffer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_buffer_to_string(s : PhysicsfluidcompressibleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_cursor_make(size : Int) -> PhysicsfluidcompressibleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_cursor_len(s : PhysicsfluidcompressibleCursor) -> Int { s.size }

pub fn physics_fluid_compressible_cursor_get(s : PhysicsfluidcompressibleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_cursor_set(s : PhysicsfluidcompressibleCursor, i : Int, v : Double) -> PhysicsfluidcompressibleCursor {
  let result = physics_fluid_compressible_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_cursor_sum(s : PhysicsfluidcompressibleCursor) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_cursor_mean(s : PhysicsfluidcompressibleCursor) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_cursor_scale(s : PhysicsfluidcompressibleCursor, f : Double) -> PhysicsfluidcompressibleCursor {
  let result = physics_fluid_compressible_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_compressible_cursor_add(a : PhysicsfluidcompressibleCursor, b : PhysicsfluidcompressibleCursor) -> PhysicsfluidcompressibleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_compressible_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_compressible_cursor_copy(s : PhysicsfluidcompressibleCursor) -> PhysicsfluidcompressibleCursor {
  let result = physics_fluid_compressible_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_compressible_cursor_fill(s : PhysicsfluidcompressibleCursor, v : Double) -> PhysicsfluidcompressibleCursor {
  let result = physics_fluid_compressible_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_cursor_min(s : PhysicsfluidcompressibleCursor) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_cursor_max(s : PhysicsfluidcompressibleCursor) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_cursor_to_string(s : PhysicsfluidcompressibleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_view_make(size : Int) -> PhysicsfluidcompressibleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_view_len(s : PhysicsfluidcompressibleView) -> Int { s.size }

pub fn physics_fluid_compressible_view_get(s : PhysicsfluidcompressibleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_view_set(s : PhysicsfluidcompressibleView, i : Int, v : Double) -> PhysicsfluidcompressibleView {
  let result = physics_fluid_compressible_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_view_sum(s : PhysicsfluidcompressibleView) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_view_mean(s : PhysicsfluidcompressibleView) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_view_scale(s : PhysicsfluidcompressibleView, f : Double) -> PhysicsfluidcompressibleView {
  let result = physics_fluid_compressible_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_compressible_view_add(a : PhysicsfluidcompressibleView, b : PhysicsfluidcompressibleView) -> PhysicsfluidcompressibleView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_compressible_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_compressible_view_copy(s : PhysicsfluidcompressibleView) -> PhysicsfluidcompressibleView {
  let result = physics_fluid_compressible_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_compressible_view_fill(s : PhysicsfluidcompressibleView, v : Double) -> PhysicsfluidcompressibleView {
  let result = physics_fluid_compressible_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_view_min(s : PhysicsfluidcompressibleView) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_view_max(s : PhysicsfluidcompressibleView) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_view_to_string(s : PhysicsfluidcompressibleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_range_make(size : Int) -> PhysicsfluidcompressibleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_range_len(s : PhysicsfluidcompressibleRange) -> Int { s.size }

pub fn physics_fluid_compressible_range_get(s : PhysicsfluidcompressibleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_range_set(s : PhysicsfluidcompressibleRange, i : Int, v : Double) -> PhysicsfluidcompressibleRange {
  let result = physics_fluid_compressible_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_range_sum(s : PhysicsfluidcompressibleRange) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_range_mean(s : PhysicsfluidcompressibleRange) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_range_scale(s : PhysicsfluidcompressibleRange, f : Double) -> PhysicsfluidcompressibleRange {
  let result = physics_fluid_compressible_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_compressible_range_add(a : PhysicsfluidcompressibleRange, b : PhysicsfluidcompressibleRange) -> PhysicsfluidcompressibleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_compressible_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_compressible_range_copy(s : PhysicsfluidcompressibleRange) -> PhysicsfluidcompressibleRange {
  let result = physics_fluid_compressible_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_compressible_range_fill(s : PhysicsfluidcompressibleRange, v : Double) -> PhysicsfluidcompressibleRange {
  let result = physics_fluid_compressible_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_range_min(s : PhysicsfluidcompressibleRange) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_range_max(s : PhysicsfluidcompressibleRange) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_range_to_string(s : PhysicsfluidcompressibleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidcompressibleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_compressible_slice_make(size : Int) -> PhysicsfluidcompressibleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_compressible_slice_len(s : PhysicsfluidcompressibleSlice) -> Int { s.size }

pub fn physics_fluid_compressible_slice_get(s : PhysicsfluidcompressibleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_compressible_slice_set(s : PhysicsfluidcompressibleSlice, i : Int, v : Double) -> PhysicsfluidcompressibleSlice {
  let result = physics_fluid_compressible_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_slice_sum(s : PhysicsfluidcompressibleSlice) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_compressible_slice_mean(s : PhysicsfluidcompressibleSlice) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_compressible_slice_scale(s : PhysicsfluidcompressibleSlice, f : Double) -> PhysicsfluidcompressibleSlice {
  let result = physics_fluid_compressible_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_compressible_slice_add(a : PhysicsfluidcompressibleSlice, b : PhysicsfluidcompressibleSlice) -> PhysicsfluidcompressibleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_compressible_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_compressible_slice_copy(s : PhysicsfluidcompressibleSlice) -> PhysicsfluidcompressibleSlice {
  let result = physics_fluid_compressible_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_compressible_slice_fill(s : PhysicsfluidcompressibleSlice, v : Double) -> PhysicsfluidcompressibleSlice {
  let result = physics_fluid_compressible_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_compressible_slice_min(s : PhysicsfluidcompressibleSlice) -> Double { @_common.min(s.data) }

pub fn physics_fluid_compressible_slice_max(s : PhysicsfluidcompressibleSlice) -> Double { @_common.max(s.data) }

pub fn physics_fluid_compressible_slice_to_string(s : PhysicsfluidcompressibleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

