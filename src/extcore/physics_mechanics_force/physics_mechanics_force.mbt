///===
/// extcore/physics_mechanics_force

pub(all) struct PhysicsmechanicsforcePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_force_make_point(x : Double, y : Double) -> PhysicsmechanicsforcePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_force_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicsforcePoint {
  { x, y, z, label: 0 }
}

pub fn physics_mechanics_force_point_x(pt : PhysicsmechanicsforcePoint) -> Double { pt.x }

pub fn physics_mechanics_force_point_y(pt : PhysicsmechanicsforcePoint) -> Double { pt.y }

pub fn physics_mechanics_force_point_z(pt : PhysicsmechanicsforcePoint) -> Double { pt.z }

pub fn physics_mechanics_force_point_label(pt : PhysicsmechanicsforcePoint) -> Int { pt.label }

pub fn physics_mechanics_force_point_dist(a : PhysicsmechanicsforcePoint, b : PhysicsmechanicsforcePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_mechanics_force_point_add(a : PhysicsmechanicsforcePoint, b : PhysicsmechanicsforcePoint) -> PhysicsmechanicsforcePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_mechanics_force_point_sub(a : PhysicsmechanicsforcePoint, b : PhysicsmechanicsforcePoint) -> PhysicsmechanicsforcePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_mechanics_force_point_scale(pt : PhysicsmechanicsforcePoint, s : Double) -> PhysicsmechanicsforcePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_mechanics_force_point_dot(a : PhysicsmechanicsforcePoint, b : PhysicsmechanicsforcePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_mechanics_force_point_cross(a : PhysicsmechanicsforcePoint, b : PhysicsmechanicsforcePoint) -> PhysicsmechanicsforcePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_mechanics_force_point_norm(pt : PhysicsmechanicsforcePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_mechanics_force_point_normalize(pt : PhysicsmechanicsforcePoint) -> PhysicsmechanicsforcePoint {
  let n = physics_mechanics_force_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_mechanics_force_point_scale(pt, 1.0 / n) }
}

pub fn physics_mechanics_force_point_negate(pt : PhysicsmechanicsforcePoint) -> PhysicsmechanicsforcePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_mechanics_force_point_mid(a : PhysicsmechanicsforcePoint, b : PhysicsmechanicsforcePoint) -> PhysicsmechanicsforcePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_mechanics_force_point_lerp(a : PhysicsmechanicsforcePoint, b : PhysicsmechanicsforcePoint, t : Double) -> PhysicsmechanicsforcePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_mechanics_force_point_to_string(pt : PhysicsmechanicsforcePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_force_make_series(vals : Array[Double], name : String) -> PhysicsmechanicsforceSeries {
  { vals, name, meta: 0 }
}

pub fn physics_mechanics_force_series_len(s : PhysicsmechanicsforceSeries) -> Int { s.vals.length() }

pub fn physics_mechanics_force_series_sum(s : PhysicsmechanicsforceSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_mechanics_force_series_mean(s : PhysicsmechanicsforceSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_mechanics_force_series_min(s : PhysicsmechanicsforceSeries) -> Double { @_common.min(s.vals) }

pub fn physics_mechanics_force_series_max(s : PhysicsmechanicsforceSeries) -> Double { @_common.max(s.vals) }

pub fn physics_mechanics_force_series_range(s : PhysicsmechanicsforceSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_mechanics_force_series_var(s : PhysicsmechanicsforceSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_mechanics_force_series_std(s : PhysicsmechanicsforceSeries) -> Double { @_common.std(s.vals) }

pub fn physics_mechanics_force_series_median(s : PhysicsmechanicsforceSeries) -> Double { @_common.median(s.vals) }

pub fn physics_mechanics_force_series_scale(s : PhysicsmechanicsforceSeries, f : Double) -> PhysicsmechanicsforceSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_mechanics_force_series_add(a : PhysicsmechanicsforceSeries, b : PhysicsmechanicsforceSeries) -> PhysicsmechanicsforceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_mechanics_force_series_sub(a : PhysicsmechanicsforceSeries, b : PhysicsmechanicsforceSeries) -> PhysicsmechanicsforceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_mechanics_force_series_normalize(s : PhysicsmechanicsforceSeries) -> PhysicsmechanicsforceSeries {
  let mn = physics_mechanics_force_series_min(s)
  let mx = physics_mechanics_force_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_mechanics_force_series_cumsum(s : PhysicsmechanicsforceSeries) -> PhysicsmechanicsforceSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_mechanics_force_series_to_string(s : PhysicsmechanicsforceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsforceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_force_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicsforceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_force_matrix_identity(n : Int) -> PhysicsmechanicsforceMatrix {
  let m = physics_mechanics_force_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_mechanics_force_matrix_get(m : PhysicsmechanicsforceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_mechanics_force_matrix_transpose(m : PhysicsmechanicsforceMatrix) -> PhysicsmechanicsforceMatrix {
  let result = physics_mechanics_force_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_mechanics_force_matrix_add(a : PhysicsmechanicsforceMatrix, b : PhysicsmechanicsforceMatrix) -> PhysicsmechanicsforceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_mechanics_force_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_mechanics_force_matrix_scale(m : PhysicsmechanicsforceMatrix, s : Double) -> PhysicsmechanicsforceMatrix {
  let result = physics_mechanics_force_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_mechanics_force_matrix_multiply(a : PhysicsmechanicsforceMatrix, b : PhysicsmechanicsforceMatrix) -> PhysicsmechanicsforceMatrix {
  if a.cols != b.rows { return physics_mechanics_force_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_mechanics_force_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_mechanics_force_matrix_trace(m : PhysicsmechanicsforceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_mechanics_force_matrix_det(m : PhysicsmechanicsforceMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_mechanics_force_matrix_norm(m : PhysicsmechanicsforceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_mechanics_force_matrix_to_string(m : PhysicsmechanicsforceMatrix) -> String {
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

pub(all) struct PhysicsmechanicsforceVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_force_make_vector(comps : Array[Double]) -> PhysicsmechanicsforceVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_force_vector_zero(dim : Int) -> PhysicsmechanicsforceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_mechanics_force_vector_add(a : PhysicsmechanicsforceVector, b : PhysicsmechanicsforceVector) -> PhysicsmechanicsforceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_force_vector_sub(a : PhysicsmechanicsforceVector, b : PhysicsmechanicsforceVector) -> PhysicsmechanicsforceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_force_vector_scale(v : PhysicsmechanicsforceVector, s : Double) -> PhysicsmechanicsforceVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_mechanics_force_vector_dot(a : PhysicsmechanicsforceVector, b : PhysicsmechanicsforceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_mechanics_force_vector_norm(v : PhysicsmechanicsforceVector) -> Double { @_common.sqrt(physics_mechanics_force_vector_dot(v, v)) }

pub fn physics_mechanics_force_vector_normalize(v : PhysicsmechanicsforceVector) -> PhysicsmechanicsforceVector {
  let n = physics_mechanics_force_vector_norm(v)
  if n < 0.0000001 { v } else { physics_mechanics_force_vector_scale(v, 1.0 / n) }
}

pub fn physics_mechanics_force_vector_dist(a : PhysicsmechanicsforceVector, b : PhysicsmechanicsforceVector) -> Double {
  physics_mechanics_force_vector_norm(physics_mechanics_force_vector_sub(a, b))
}

pub fn physics_mechanics_force_vector_to_string(v : PhysicsmechanicsforceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_force_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_mechanics_force_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_mechanics_force_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_mechanics_force_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_mechanics_force_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_mechanics_force_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_mechanics_force_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_mechanics_force_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_mechanics_force_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_mechanics_force_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_mechanics_force_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_mechanics_force_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_mechanics_force_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_mechanics_force_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_mechanics_force_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_mechanics_force_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_mechanics_force_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_mechanics_force_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_mechanics_force_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_mechanics_force_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_mechanics_force_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_mechanics_force_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_mechanics_force_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_mechanics_force_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_mechanics_force_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_mechanics_force_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_mechanics_force_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_mechanics_force_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_mechanics_force_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsmechanicsforceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_frame_make(size : Int) -> PhysicsmechanicsforceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_frame_len(s : PhysicsmechanicsforceFrame) -> Int { s.size }

pub fn physics_mechanics_force_frame_get(s : PhysicsmechanicsforceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_frame_set(s : PhysicsmechanicsforceFrame, i : Int, v : Double) -> PhysicsmechanicsforceFrame {
  let result = physics_mechanics_force_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_frame_sum(s : PhysicsmechanicsforceFrame) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_frame_mean(s : PhysicsmechanicsforceFrame) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_frame_scale(s : PhysicsmechanicsforceFrame, f : Double) -> PhysicsmechanicsforceFrame {
  let result = physics_mechanics_force_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_force_frame_add(a : PhysicsmechanicsforceFrame, b : PhysicsmechanicsforceFrame) -> PhysicsmechanicsforceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_force_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_force_frame_copy(s : PhysicsmechanicsforceFrame) -> PhysicsmechanicsforceFrame {
  let result = physics_mechanics_force_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_force_frame_fill(s : PhysicsmechanicsforceFrame, v : Double) -> PhysicsmechanicsforceFrame {
  let result = physics_mechanics_force_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_frame_min(s : PhysicsmechanicsforceFrame) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_frame_max(s : PhysicsmechanicsforceFrame) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_frame_to_string(s : PhysicsmechanicsforceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_table_make(size : Int) -> PhysicsmechanicsforceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_table_len(s : PhysicsmechanicsforceTable) -> Int { s.size }

pub fn physics_mechanics_force_table_get(s : PhysicsmechanicsforceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_table_set(s : PhysicsmechanicsforceTable, i : Int, v : Double) -> PhysicsmechanicsforceTable {
  let result = physics_mechanics_force_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_table_sum(s : PhysicsmechanicsforceTable) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_table_mean(s : PhysicsmechanicsforceTable) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_table_scale(s : PhysicsmechanicsforceTable, f : Double) -> PhysicsmechanicsforceTable {
  let result = physics_mechanics_force_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_force_table_add(a : PhysicsmechanicsforceTable, b : PhysicsmechanicsforceTable) -> PhysicsmechanicsforceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_force_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_force_table_copy(s : PhysicsmechanicsforceTable) -> PhysicsmechanicsforceTable {
  let result = physics_mechanics_force_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_force_table_fill(s : PhysicsmechanicsforceTable, v : Double) -> PhysicsmechanicsforceTable {
  let result = physics_mechanics_force_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_table_min(s : PhysicsmechanicsforceTable) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_table_max(s : PhysicsmechanicsforceTable) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_table_to_string(s : PhysicsmechanicsforceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_graphn_make(size : Int) -> PhysicsmechanicsforceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_graphn_len(s : PhysicsmechanicsforceGraphN) -> Int { s.size }

pub fn physics_mechanics_force_graphn_get(s : PhysicsmechanicsforceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_graphn_set(s : PhysicsmechanicsforceGraphN, i : Int, v : Double) -> PhysicsmechanicsforceGraphN {
  let result = physics_mechanics_force_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_graphn_sum(s : PhysicsmechanicsforceGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_graphn_mean(s : PhysicsmechanicsforceGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_graphn_scale(s : PhysicsmechanicsforceGraphN, f : Double) -> PhysicsmechanicsforceGraphN {
  let result = physics_mechanics_force_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_force_graphn_add(a : PhysicsmechanicsforceGraphN, b : PhysicsmechanicsforceGraphN) -> PhysicsmechanicsforceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_force_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_force_graphn_copy(s : PhysicsmechanicsforceGraphN) -> PhysicsmechanicsforceGraphN {
  let result = physics_mechanics_force_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_force_graphn_fill(s : PhysicsmechanicsforceGraphN, v : Double) -> PhysicsmechanicsforceGraphN {
  let result = physics_mechanics_force_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_graphn_min(s : PhysicsmechanicsforceGraphN) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_graphn_max(s : PhysicsmechanicsforceGraphN) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_graphn_to_string(s : PhysicsmechanicsforceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_node_make(size : Int) -> PhysicsmechanicsforceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_node_len(s : PhysicsmechanicsforceNode) -> Int { s.size }

pub fn physics_mechanics_force_node_get(s : PhysicsmechanicsforceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_node_set(s : PhysicsmechanicsforceNode, i : Int, v : Double) -> PhysicsmechanicsforceNode {
  let result = physics_mechanics_force_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_node_sum(s : PhysicsmechanicsforceNode) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_node_mean(s : PhysicsmechanicsforceNode) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_node_scale(s : PhysicsmechanicsforceNode, f : Double) -> PhysicsmechanicsforceNode {
  let result = physics_mechanics_force_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_force_node_add(a : PhysicsmechanicsforceNode, b : PhysicsmechanicsforceNode) -> PhysicsmechanicsforceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_force_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_force_node_copy(s : PhysicsmechanicsforceNode) -> PhysicsmechanicsforceNode {
  let result = physics_mechanics_force_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_force_node_fill(s : PhysicsmechanicsforceNode, v : Double) -> PhysicsmechanicsforceNode {
  let result = physics_mechanics_force_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_node_min(s : PhysicsmechanicsforceNode) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_node_max(s : PhysicsmechanicsforceNode) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_node_to_string(s : PhysicsmechanicsforceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_edge_make(size : Int) -> PhysicsmechanicsforceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_edge_len(s : PhysicsmechanicsforceEdge) -> Int { s.size }

pub fn physics_mechanics_force_edge_get(s : PhysicsmechanicsforceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_edge_set(s : PhysicsmechanicsforceEdge, i : Int, v : Double) -> PhysicsmechanicsforceEdge {
  let result = physics_mechanics_force_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_edge_sum(s : PhysicsmechanicsforceEdge) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_edge_mean(s : PhysicsmechanicsforceEdge) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_edge_scale(s : PhysicsmechanicsforceEdge, f : Double) -> PhysicsmechanicsforceEdge {
  let result = physics_mechanics_force_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_force_edge_add(a : PhysicsmechanicsforceEdge, b : PhysicsmechanicsforceEdge) -> PhysicsmechanicsforceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_force_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_force_edge_copy(s : PhysicsmechanicsforceEdge) -> PhysicsmechanicsforceEdge {
  let result = physics_mechanics_force_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_force_edge_fill(s : PhysicsmechanicsforceEdge, v : Double) -> PhysicsmechanicsforceEdge {
  let result = physics_mechanics_force_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_edge_min(s : PhysicsmechanicsforceEdge) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_edge_max(s : PhysicsmechanicsforceEdge) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_edge_to_string(s : PhysicsmechanicsforceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforcePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_path_make(size : Int) -> PhysicsmechanicsforcePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_path_len(s : PhysicsmechanicsforcePath) -> Int { s.size }

pub fn physics_mechanics_force_path_get(s : PhysicsmechanicsforcePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_path_set(s : PhysicsmechanicsforcePath, i : Int, v : Double) -> PhysicsmechanicsforcePath {
  let result = physics_mechanics_force_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_path_sum(s : PhysicsmechanicsforcePath) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_path_mean(s : PhysicsmechanicsforcePath) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_path_scale(s : PhysicsmechanicsforcePath, f : Double) -> PhysicsmechanicsforcePath {
  let result = physics_mechanics_force_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_force_path_add(a : PhysicsmechanicsforcePath, b : PhysicsmechanicsforcePath) -> PhysicsmechanicsforcePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_force_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_force_path_copy(s : PhysicsmechanicsforcePath) -> PhysicsmechanicsforcePath {
  let result = physics_mechanics_force_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_force_path_fill(s : PhysicsmechanicsforcePath, v : Double) -> PhysicsmechanicsforcePath {
  let result = physics_mechanics_force_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_path_min(s : PhysicsmechanicsforcePath) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_path_max(s : PhysicsmechanicsforcePath) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_path_to_string(s : PhysicsmechanicsforcePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_cluster_make(size : Int) -> PhysicsmechanicsforceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_cluster_len(s : PhysicsmechanicsforceCluster) -> Int { s.size }

pub fn physics_mechanics_force_cluster_get(s : PhysicsmechanicsforceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_cluster_set(s : PhysicsmechanicsforceCluster, i : Int, v : Double) -> PhysicsmechanicsforceCluster {
  let result = physics_mechanics_force_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_cluster_sum(s : PhysicsmechanicsforceCluster) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_cluster_mean(s : PhysicsmechanicsforceCluster) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_cluster_scale(s : PhysicsmechanicsforceCluster, f : Double) -> PhysicsmechanicsforceCluster {
  let result = physics_mechanics_force_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_force_cluster_add(a : PhysicsmechanicsforceCluster, b : PhysicsmechanicsforceCluster) -> PhysicsmechanicsforceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_force_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_force_cluster_copy(s : PhysicsmechanicsforceCluster) -> PhysicsmechanicsforceCluster {
  let result = physics_mechanics_force_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_force_cluster_fill(s : PhysicsmechanicsforceCluster, v : Double) -> PhysicsmechanicsforceCluster {
  let result = physics_mechanics_force_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_cluster_min(s : PhysicsmechanicsforceCluster) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_cluster_max(s : PhysicsmechanicsforceCluster) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_cluster_to_string(s : PhysicsmechanicsforceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_model_make(size : Int) -> PhysicsmechanicsforceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_model_len(s : PhysicsmechanicsforceModel) -> Int { s.size }

pub fn physics_mechanics_force_model_get(s : PhysicsmechanicsforceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_model_set(s : PhysicsmechanicsforceModel, i : Int, v : Double) -> PhysicsmechanicsforceModel {
  let result = physics_mechanics_force_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_model_sum(s : PhysicsmechanicsforceModel) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_model_mean(s : PhysicsmechanicsforceModel) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_model_scale(s : PhysicsmechanicsforceModel, f : Double) -> PhysicsmechanicsforceModel {
  let result = physics_mechanics_force_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_force_model_add(a : PhysicsmechanicsforceModel, b : PhysicsmechanicsforceModel) -> PhysicsmechanicsforceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_force_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_force_model_copy(s : PhysicsmechanicsforceModel) -> PhysicsmechanicsforceModel {
  let result = physics_mechanics_force_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_force_model_fill(s : PhysicsmechanicsforceModel, v : Double) -> PhysicsmechanicsforceModel {
  let result = physics_mechanics_force_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_model_min(s : PhysicsmechanicsforceModel) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_model_max(s : PhysicsmechanicsforceModel) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_model_to_string(s : PhysicsmechanicsforceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_layer_make(size : Int) -> PhysicsmechanicsforceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_layer_len(s : PhysicsmechanicsforceLayer) -> Int { s.size }

pub fn physics_mechanics_force_layer_get(s : PhysicsmechanicsforceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_layer_set(s : PhysicsmechanicsforceLayer, i : Int, v : Double) -> PhysicsmechanicsforceLayer {
  let result = physics_mechanics_force_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_layer_sum(s : PhysicsmechanicsforceLayer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_layer_mean(s : PhysicsmechanicsforceLayer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_layer_scale(s : PhysicsmechanicsforceLayer, f : Double) -> PhysicsmechanicsforceLayer {
  let result = physics_mechanics_force_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_force_layer_add(a : PhysicsmechanicsforceLayer, b : PhysicsmechanicsforceLayer) -> PhysicsmechanicsforceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_force_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_force_layer_copy(s : PhysicsmechanicsforceLayer) -> PhysicsmechanicsforceLayer {
  let result = physics_mechanics_force_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_force_layer_fill(s : PhysicsmechanicsforceLayer, v : Double) -> PhysicsmechanicsforceLayer {
  let result = physics_mechanics_force_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_layer_min(s : PhysicsmechanicsforceLayer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_layer_max(s : PhysicsmechanicsforceLayer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_layer_to_string(s : PhysicsmechanicsforceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_buffer_make(size : Int) -> PhysicsmechanicsforceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_buffer_len(s : PhysicsmechanicsforceBuffer) -> Int { s.size }

pub fn physics_mechanics_force_buffer_get(s : PhysicsmechanicsforceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_buffer_set(s : PhysicsmechanicsforceBuffer, i : Int, v : Double) -> PhysicsmechanicsforceBuffer {
  let result = physics_mechanics_force_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_buffer_sum(s : PhysicsmechanicsforceBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_buffer_mean(s : PhysicsmechanicsforceBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_buffer_scale(s : PhysicsmechanicsforceBuffer, f : Double) -> PhysicsmechanicsforceBuffer {
  let result = physics_mechanics_force_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_force_buffer_add(a : PhysicsmechanicsforceBuffer, b : PhysicsmechanicsforceBuffer) -> PhysicsmechanicsforceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_force_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_force_buffer_copy(s : PhysicsmechanicsforceBuffer) -> PhysicsmechanicsforceBuffer {
  let result = physics_mechanics_force_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_force_buffer_fill(s : PhysicsmechanicsforceBuffer, v : Double) -> PhysicsmechanicsforceBuffer {
  let result = physics_mechanics_force_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_buffer_min(s : PhysicsmechanicsforceBuffer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_buffer_max(s : PhysicsmechanicsforceBuffer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_buffer_to_string(s : PhysicsmechanicsforceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_cursor_make(size : Int) -> PhysicsmechanicsforceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_cursor_len(s : PhysicsmechanicsforceCursor) -> Int { s.size }

pub fn physics_mechanics_force_cursor_get(s : PhysicsmechanicsforceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_cursor_set(s : PhysicsmechanicsforceCursor, i : Int, v : Double) -> PhysicsmechanicsforceCursor {
  let result = physics_mechanics_force_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_cursor_sum(s : PhysicsmechanicsforceCursor) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_cursor_mean(s : PhysicsmechanicsforceCursor) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_cursor_scale(s : PhysicsmechanicsforceCursor, f : Double) -> PhysicsmechanicsforceCursor {
  let result = physics_mechanics_force_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_force_cursor_add(a : PhysicsmechanicsforceCursor, b : PhysicsmechanicsforceCursor) -> PhysicsmechanicsforceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_force_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_force_cursor_copy(s : PhysicsmechanicsforceCursor) -> PhysicsmechanicsforceCursor {
  let result = physics_mechanics_force_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_force_cursor_fill(s : PhysicsmechanicsforceCursor, v : Double) -> PhysicsmechanicsforceCursor {
  let result = physics_mechanics_force_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_cursor_min(s : PhysicsmechanicsforceCursor) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_cursor_max(s : PhysicsmechanicsforceCursor) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_cursor_to_string(s : PhysicsmechanicsforceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_view_make(size : Int) -> PhysicsmechanicsforceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_view_len(s : PhysicsmechanicsforceView) -> Int { s.size }

pub fn physics_mechanics_force_view_get(s : PhysicsmechanicsforceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_view_set(s : PhysicsmechanicsforceView, i : Int, v : Double) -> PhysicsmechanicsforceView {
  let result = physics_mechanics_force_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_view_sum(s : PhysicsmechanicsforceView) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_view_mean(s : PhysicsmechanicsforceView) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_view_scale(s : PhysicsmechanicsforceView, f : Double) -> PhysicsmechanicsforceView {
  let result = physics_mechanics_force_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_force_view_add(a : PhysicsmechanicsforceView, b : PhysicsmechanicsforceView) -> PhysicsmechanicsforceView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_force_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_force_view_copy(s : PhysicsmechanicsforceView) -> PhysicsmechanicsforceView {
  let result = physics_mechanics_force_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_force_view_fill(s : PhysicsmechanicsforceView, v : Double) -> PhysicsmechanicsforceView {
  let result = physics_mechanics_force_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_view_min(s : PhysicsmechanicsforceView) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_view_max(s : PhysicsmechanicsforceView) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_view_to_string(s : PhysicsmechanicsforceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_range_make(size : Int) -> PhysicsmechanicsforceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_range_len(s : PhysicsmechanicsforceRange) -> Int { s.size }

pub fn physics_mechanics_force_range_get(s : PhysicsmechanicsforceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_range_set(s : PhysicsmechanicsforceRange, i : Int, v : Double) -> PhysicsmechanicsforceRange {
  let result = physics_mechanics_force_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_range_sum(s : PhysicsmechanicsforceRange) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_range_mean(s : PhysicsmechanicsforceRange) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_range_scale(s : PhysicsmechanicsforceRange, f : Double) -> PhysicsmechanicsforceRange {
  let result = physics_mechanics_force_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_force_range_add(a : PhysicsmechanicsforceRange, b : PhysicsmechanicsforceRange) -> PhysicsmechanicsforceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_force_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_force_range_copy(s : PhysicsmechanicsforceRange) -> PhysicsmechanicsforceRange {
  let result = physics_mechanics_force_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_force_range_fill(s : PhysicsmechanicsforceRange, v : Double) -> PhysicsmechanicsforceRange {
  let result = physics_mechanics_force_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_range_min(s : PhysicsmechanicsforceRange) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_range_max(s : PhysicsmechanicsforceRange) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_range_to_string(s : PhysicsmechanicsforceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsforceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_force_slice_make(size : Int) -> PhysicsmechanicsforceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_force_slice_len(s : PhysicsmechanicsforceSlice) -> Int { s.size }

pub fn physics_mechanics_force_slice_get(s : PhysicsmechanicsforceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_force_slice_set(s : PhysicsmechanicsforceSlice, i : Int, v : Double) -> PhysicsmechanicsforceSlice {
  let result = physics_mechanics_force_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_slice_sum(s : PhysicsmechanicsforceSlice) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_force_slice_mean(s : PhysicsmechanicsforceSlice) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_force_slice_scale(s : PhysicsmechanicsforceSlice, f : Double) -> PhysicsmechanicsforceSlice {
  let result = physics_mechanics_force_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_force_slice_add(a : PhysicsmechanicsforceSlice, b : PhysicsmechanicsforceSlice) -> PhysicsmechanicsforceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_force_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_force_slice_copy(s : PhysicsmechanicsforceSlice) -> PhysicsmechanicsforceSlice {
  let result = physics_mechanics_force_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_force_slice_fill(s : PhysicsmechanicsforceSlice, v : Double) -> PhysicsmechanicsforceSlice {
  let result = physics_mechanics_force_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_force_slice_min(s : PhysicsmechanicsforceSlice) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_force_slice_max(s : PhysicsmechanicsforceSlice) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_force_slice_to_string(s : PhysicsmechanicsforceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

