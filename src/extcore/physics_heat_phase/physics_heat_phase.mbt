///===
/// extcore/physics_heat_phase

pub(all) struct PhysicsheatphasePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_phase_make_point(x : Double, y : Double) -> PhysicsheatphasePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_phase_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatphasePoint {
  { x, y, z, label: 0 }
}

pub fn physics_heat_phase_point_x(pt : PhysicsheatphasePoint) -> Double { pt.x }

pub fn physics_heat_phase_point_y(pt : PhysicsheatphasePoint) -> Double { pt.y }

pub fn physics_heat_phase_point_z(pt : PhysicsheatphasePoint) -> Double { pt.z }

pub fn physics_heat_phase_point_label(pt : PhysicsheatphasePoint) -> Int { pt.label }

pub fn physics_heat_phase_point_dist(a : PhysicsheatphasePoint, b : PhysicsheatphasePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_heat_phase_point_add(a : PhysicsheatphasePoint, b : PhysicsheatphasePoint) -> PhysicsheatphasePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_heat_phase_point_sub(a : PhysicsheatphasePoint, b : PhysicsheatphasePoint) -> PhysicsheatphasePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_heat_phase_point_scale(pt : PhysicsheatphasePoint, s : Double) -> PhysicsheatphasePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_heat_phase_point_dot(a : PhysicsheatphasePoint, b : PhysicsheatphasePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_heat_phase_point_cross(a : PhysicsheatphasePoint, b : PhysicsheatphasePoint) -> PhysicsheatphasePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_heat_phase_point_norm(pt : PhysicsheatphasePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_heat_phase_point_normalize(pt : PhysicsheatphasePoint) -> PhysicsheatphasePoint {
  let n = physics_heat_phase_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_heat_phase_point_scale(pt, 1.0 / n) }
}

pub fn physics_heat_phase_point_negate(pt : PhysicsheatphasePoint) -> PhysicsheatphasePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_heat_phase_point_mid(a : PhysicsheatphasePoint, b : PhysicsheatphasePoint) -> PhysicsheatphasePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_heat_phase_point_lerp(a : PhysicsheatphasePoint, b : PhysicsheatphasePoint, t : Double) -> PhysicsheatphasePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_heat_phase_point_to_string(pt : PhysicsheatphasePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsheatphaseSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_phase_make_series(vals : Array[Double], name : String) -> PhysicsheatphaseSeries {
  { vals, name, meta: 0 }
}

pub fn physics_heat_phase_series_len(s : PhysicsheatphaseSeries) -> Int { s.vals.length() }

pub fn physics_heat_phase_series_sum(s : PhysicsheatphaseSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_heat_phase_series_mean(s : PhysicsheatphaseSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_heat_phase_series_min(s : PhysicsheatphaseSeries) -> Double { @_common.min(s.vals) }

pub fn physics_heat_phase_series_max(s : PhysicsheatphaseSeries) -> Double { @_common.max(s.vals) }

pub fn physics_heat_phase_series_range(s : PhysicsheatphaseSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_heat_phase_series_var(s : PhysicsheatphaseSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_heat_phase_series_std(s : PhysicsheatphaseSeries) -> Double { @_common.std(s.vals) }

pub fn physics_heat_phase_series_median(s : PhysicsheatphaseSeries) -> Double { @_common.median(s.vals) }

pub fn physics_heat_phase_series_scale(s : PhysicsheatphaseSeries, f : Double) -> PhysicsheatphaseSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_heat_phase_series_add(a : PhysicsheatphaseSeries, b : PhysicsheatphaseSeries) -> PhysicsheatphaseSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_heat_phase_series_sub(a : PhysicsheatphaseSeries, b : PhysicsheatphaseSeries) -> PhysicsheatphaseSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_heat_phase_series_normalize(s : PhysicsheatphaseSeries) -> PhysicsheatphaseSeries {
  let mn = physics_heat_phase_series_min(s)
  let mx = physics_heat_phase_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_heat_phase_series_cumsum(s : PhysicsheatphaseSeries) -> PhysicsheatphaseSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_heat_phase_series_to_string(s : PhysicsheatphaseSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatphaseMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_phase_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatphaseMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_phase_matrix_identity(n : Int) -> PhysicsheatphaseMatrix {
  let m = physics_heat_phase_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_heat_phase_matrix_get(m : PhysicsheatphaseMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_heat_phase_matrix_transpose(m : PhysicsheatphaseMatrix) -> PhysicsheatphaseMatrix {
  let result = physics_heat_phase_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_heat_phase_matrix_add(a : PhysicsheatphaseMatrix, b : PhysicsheatphaseMatrix) -> PhysicsheatphaseMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_heat_phase_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_heat_phase_matrix_scale(m : PhysicsheatphaseMatrix, s : Double) -> PhysicsheatphaseMatrix {
  let result = physics_heat_phase_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_heat_phase_matrix_multiply(a : PhysicsheatphaseMatrix, b : PhysicsheatphaseMatrix) -> PhysicsheatphaseMatrix {
  if a.cols != b.rows { return physics_heat_phase_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_heat_phase_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_heat_phase_matrix_trace(m : PhysicsheatphaseMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_heat_phase_matrix_det(m : PhysicsheatphaseMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_heat_phase_matrix_norm(m : PhysicsheatphaseMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_heat_phase_matrix_to_string(m : PhysicsheatphaseMatrix) -> String {
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

pub(all) struct PhysicsheatphaseVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_phase_make_vector(comps : Array[Double]) -> PhysicsheatphaseVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_phase_vector_zero(dim : Int) -> PhysicsheatphaseVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_heat_phase_vector_add(a : PhysicsheatphaseVector, b : PhysicsheatphaseVector) -> PhysicsheatphaseVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_heat_phase_vector_sub(a : PhysicsheatphaseVector, b : PhysicsheatphaseVector) -> PhysicsheatphaseVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_heat_phase_vector_scale(v : PhysicsheatphaseVector, s : Double) -> PhysicsheatphaseVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_heat_phase_vector_dot(a : PhysicsheatphaseVector, b : PhysicsheatphaseVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_heat_phase_vector_norm(v : PhysicsheatphaseVector) -> Double { @_common.sqrt(physics_heat_phase_vector_dot(v, v)) }

pub fn physics_heat_phase_vector_normalize(v : PhysicsheatphaseVector) -> PhysicsheatphaseVector {
  let n = physics_heat_phase_vector_norm(v)
  if n < 0.0000001 { v } else { physics_heat_phase_vector_scale(v, 1.0 / n) }
}

pub fn physics_heat_phase_vector_dist(a : PhysicsheatphaseVector, b : PhysicsheatphaseVector) -> Double {
  physics_heat_phase_vector_norm(physics_heat_phase_vector_sub(a, b))
}

pub fn physics_heat_phase_vector_to_string(v : PhysicsheatphaseVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_phase_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_heat_phase_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_heat_phase_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_heat_phase_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_heat_phase_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_heat_phase_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_heat_phase_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_heat_phase_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_heat_phase_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_heat_phase_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_heat_phase_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_heat_phase_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_heat_phase_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_heat_phase_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_heat_phase_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_heat_phase_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_heat_phase_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_heat_phase_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_heat_phase_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_heat_phase_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_heat_phase_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_heat_phase_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_heat_phase_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_heat_phase_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_heat_phase_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_heat_phase_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_heat_phase_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_heat_phase_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_heat_phase_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsheatphaseFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_frame_make(size : Int) -> PhysicsheatphaseFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_frame_len(s : PhysicsheatphaseFrame) -> Int { s.size }

pub fn physics_heat_phase_frame_get(s : PhysicsheatphaseFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_frame_set(s : PhysicsheatphaseFrame, i : Int, v : Double) -> PhysicsheatphaseFrame {
  let result = physics_heat_phase_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_frame_sum(s : PhysicsheatphaseFrame) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_frame_mean(s : PhysicsheatphaseFrame) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_frame_scale(s : PhysicsheatphaseFrame, f : Double) -> PhysicsheatphaseFrame {
  let result = physics_heat_phase_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_phase_frame_add(a : PhysicsheatphaseFrame, b : PhysicsheatphaseFrame) -> PhysicsheatphaseFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_phase_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_phase_frame_copy(s : PhysicsheatphaseFrame) -> PhysicsheatphaseFrame {
  let result = physics_heat_phase_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_phase_frame_fill(s : PhysicsheatphaseFrame, v : Double) -> PhysicsheatphaseFrame {
  let result = physics_heat_phase_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_frame_min(s : PhysicsheatphaseFrame) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_frame_max(s : PhysicsheatphaseFrame) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_frame_to_string(s : PhysicsheatphaseFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_table_make(size : Int) -> PhysicsheatphaseTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_table_len(s : PhysicsheatphaseTable) -> Int { s.size }

pub fn physics_heat_phase_table_get(s : PhysicsheatphaseTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_table_set(s : PhysicsheatphaseTable, i : Int, v : Double) -> PhysicsheatphaseTable {
  let result = physics_heat_phase_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_table_sum(s : PhysicsheatphaseTable) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_table_mean(s : PhysicsheatphaseTable) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_table_scale(s : PhysicsheatphaseTable, f : Double) -> PhysicsheatphaseTable {
  let result = physics_heat_phase_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_phase_table_add(a : PhysicsheatphaseTable, b : PhysicsheatphaseTable) -> PhysicsheatphaseTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_phase_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_phase_table_copy(s : PhysicsheatphaseTable) -> PhysicsheatphaseTable {
  let result = physics_heat_phase_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_phase_table_fill(s : PhysicsheatphaseTable, v : Double) -> PhysicsheatphaseTable {
  let result = physics_heat_phase_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_table_min(s : PhysicsheatphaseTable) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_table_max(s : PhysicsheatphaseTable) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_table_to_string(s : PhysicsheatphaseTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_graphn_make(size : Int) -> PhysicsheatphaseGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_graphn_len(s : PhysicsheatphaseGraphN) -> Int { s.size }

pub fn physics_heat_phase_graphn_get(s : PhysicsheatphaseGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_graphn_set(s : PhysicsheatphaseGraphN, i : Int, v : Double) -> PhysicsheatphaseGraphN {
  let result = physics_heat_phase_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_graphn_sum(s : PhysicsheatphaseGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_graphn_mean(s : PhysicsheatphaseGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_graphn_scale(s : PhysicsheatphaseGraphN, f : Double) -> PhysicsheatphaseGraphN {
  let result = physics_heat_phase_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_phase_graphn_add(a : PhysicsheatphaseGraphN, b : PhysicsheatphaseGraphN) -> PhysicsheatphaseGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_phase_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_phase_graphn_copy(s : PhysicsheatphaseGraphN) -> PhysicsheatphaseGraphN {
  let result = physics_heat_phase_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_phase_graphn_fill(s : PhysicsheatphaseGraphN, v : Double) -> PhysicsheatphaseGraphN {
  let result = physics_heat_phase_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_graphn_min(s : PhysicsheatphaseGraphN) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_graphn_max(s : PhysicsheatphaseGraphN) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_graphn_to_string(s : PhysicsheatphaseGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_node_make(size : Int) -> PhysicsheatphaseNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_node_len(s : PhysicsheatphaseNode) -> Int { s.size }

pub fn physics_heat_phase_node_get(s : PhysicsheatphaseNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_node_set(s : PhysicsheatphaseNode, i : Int, v : Double) -> PhysicsheatphaseNode {
  let result = physics_heat_phase_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_node_sum(s : PhysicsheatphaseNode) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_node_mean(s : PhysicsheatphaseNode) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_node_scale(s : PhysicsheatphaseNode, f : Double) -> PhysicsheatphaseNode {
  let result = physics_heat_phase_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_phase_node_add(a : PhysicsheatphaseNode, b : PhysicsheatphaseNode) -> PhysicsheatphaseNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_phase_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_phase_node_copy(s : PhysicsheatphaseNode) -> PhysicsheatphaseNode {
  let result = physics_heat_phase_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_phase_node_fill(s : PhysicsheatphaseNode, v : Double) -> PhysicsheatphaseNode {
  let result = physics_heat_phase_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_node_min(s : PhysicsheatphaseNode) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_node_max(s : PhysicsheatphaseNode) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_node_to_string(s : PhysicsheatphaseNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_edge_make(size : Int) -> PhysicsheatphaseEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_edge_len(s : PhysicsheatphaseEdge) -> Int { s.size }

pub fn physics_heat_phase_edge_get(s : PhysicsheatphaseEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_edge_set(s : PhysicsheatphaseEdge, i : Int, v : Double) -> PhysicsheatphaseEdge {
  let result = physics_heat_phase_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_edge_sum(s : PhysicsheatphaseEdge) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_edge_mean(s : PhysicsheatphaseEdge) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_edge_scale(s : PhysicsheatphaseEdge, f : Double) -> PhysicsheatphaseEdge {
  let result = physics_heat_phase_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_phase_edge_add(a : PhysicsheatphaseEdge, b : PhysicsheatphaseEdge) -> PhysicsheatphaseEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_phase_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_phase_edge_copy(s : PhysicsheatphaseEdge) -> PhysicsheatphaseEdge {
  let result = physics_heat_phase_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_phase_edge_fill(s : PhysicsheatphaseEdge, v : Double) -> PhysicsheatphaseEdge {
  let result = physics_heat_phase_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_edge_min(s : PhysicsheatphaseEdge) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_edge_max(s : PhysicsheatphaseEdge) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_edge_to_string(s : PhysicsheatphaseEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphasePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_path_make(size : Int) -> PhysicsheatphasePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_path_len(s : PhysicsheatphasePath) -> Int { s.size }

pub fn physics_heat_phase_path_get(s : PhysicsheatphasePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_path_set(s : PhysicsheatphasePath, i : Int, v : Double) -> PhysicsheatphasePath {
  let result = physics_heat_phase_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_path_sum(s : PhysicsheatphasePath) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_path_mean(s : PhysicsheatphasePath) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_path_scale(s : PhysicsheatphasePath, f : Double) -> PhysicsheatphasePath {
  let result = physics_heat_phase_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_phase_path_add(a : PhysicsheatphasePath, b : PhysicsheatphasePath) -> PhysicsheatphasePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_phase_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_phase_path_copy(s : PhysicsheatphasePath) -> PhysicsheatphasePath {
  let result = physics_heat_phase_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_phase_path_fill(s : PhysicsheatphasePath, v : Double) -> PhysicsheatphasePath {
  let result = physics_heat_phase_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_path_min(s : PhysicsheatphasePath) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_path_max(s : PhysicsheatphasePath) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_path_to_string(s : PhysicsheatphasePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_cluster_make(size : Int) -> PhysicsheatphaseCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_cluster_len(s : PhysicsheatphaseCluster) -> Int { s.size }

pub fn physics_heat_phase_cluster_get(s : PhysicsheatphaseCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_cluster_set(s : PhysicsheatphaseCluster, i : Int, v : Double) -> PhysicsheatphaseCluster {
  let result = physics_heat_phase_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_cluster_sum(s : PhysicsheatphaseCluster) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_cluster_mean(s : PhysicsheatphaseCluster) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_cluster_scale(s : PhysicsheatphaseCluster, f : Double) -> PhysicsheatphaseCluster {
  let result = physics_heat_phase_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_phase_cluster_add(a : PhysicsheatphaseCluster, b : PhysicsheatphaseCluster) -> PhysicsheatphaseCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_phase_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_phase_cluster_copy(s : PhysicsheatphaseCluster) -> PhysicsheatphaseCluster {
  let result = physics_heat_phase_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_phase_cluster_fill(s : PhysicsheatphaseCluster, v : Double) -> PhysicsheatphaseCluster {
  let result = physics_heat_phase_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_cluster_min(s : PhysicsheatphaseCluster) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_cluster_max(s : PhysicsheatphaseCluster) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_cluster_to_string(s : PhysicsheatphaseCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_model_make(size : Int) -> PhysicsheatphaseModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_model_len(s : PhysicsheatphaseModel) -> Int { s.size }

pub fn physics_heat_phase_model_get(s : PhysicsheatphaseModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_model_set(s : PhysicsheatphaseModel, i : Int, v : Double) -> PhysicsheatphaseModel {
  let result = physics_heat_phase_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_model_sum(s : PhysicsheatphaseModel) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_model_mean(s : PhysicsheatphaseModel) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_model_scale(s : PhysicsheatphaseModel, f : Double) -> PhysicsheatphaseModel {
  let result = physics_heat_phase_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_phase_model_add(a : PhysicsheatphaseModel, b : PhysicsheatphaseModel) -> PhysicsheatphaseModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_phase_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_phase_model_copy(s : PhysicsheatphaseModel) -> PhysicsheatphaseModel {
  let result = physics_heat_phase_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_phase_model_fill(s : PhysicsheatphaseModel, v : Double) -> PhysicsheatphaseModel {
  let result = physics_heat_phase_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_model_min(s : PhysicsheatphaseModel) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_model_max(s : PhysicsheatphaseModel) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_model_to_string(s : PhysicsheatphaseModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_layer_make(size : Int) -> PhysicsheatphaseLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_layer_len(s : PhysicsheatphaseLayer) -> Int { s.size }

pub fn physics_heat_phase_layer_get(s : PhysicsheatphaseLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_layer_set(s : PhysicsheatphaseLayer, i : Int, v : Double) -> PhysicsheatphaseLayer {
  let result = physics_heat_phase_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_layer_sum(s : PhysicsheatphaseLayer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_layer_mean(s : PhysicsheatphaseLayer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_layer_scale(s : PhysicsheatphaseLayer, f : Double) -> PhysicsheatphaseLayer {
  let result = physics_heat_phase_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_phase_layer_add(a : PhysicsheatphaseLayer, b : PhysicsheatphaseLayer) -> PhysicsheatphaseLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_phase_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_phase_layer_copy(s : PhysicsheatphaseLayer) -> PhysicsheatphaseLayer {
  let result = physics_heat_phase_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_phase_layer_fill(s : PhysicsheatphaseLayer, v : Double) -> PhysicsheatphaseLayer {
  let result = physics_heat_phase_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_layer_min(s : PhysicsheatphaseLayer) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_layer_max(s : PhysicsheatphaseLayer) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_layer_to_string(s : PhysicsheatphaseLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_buffer_make(size : Int) -> PhysicsheatphaseBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_buffer_len(s : PhysicsheatphaseBuffer) -> Int { s.size }

pub fn physics_heat_phase_buffer_get(s : PhysicsheatphaseBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_buffer_set(s : PhysicsheatphaseBuffer, i : Int, v : Double) -> PhysicsheatphaseBuffer {
  let result = physics_heat_phase_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_buffer_sum(s : PhysicsheatphaseBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_buffer_mean(s : PhysicsheatphaseBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_buffer_scale(s : PhysicsheatphaseBuffer, f : Double) -> PhysicsheatphaseBuffer {
  let result = physics_heat_phase_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_phase_buffer_add(a : PhysicsheatphaseBuffer, b : PhysicsheatphaseBuffer) -> PhysicsheatphaseBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_phase_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_phase_buffer_copy(s : PhysicsheatphaseBuffer) -> PhysicsheatphaseBuffer {
  let result = physics_heat_phase_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_phase_buffer_fill(s : PhysicsheatphaseBuffer, v : Double) -> PhysicsheatphaseBuffer {
  let result = physics_heat_phase_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_buffer_min(s : PhysicsheatphaseBuffer) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_buffer_max(s : PhysicsheatphaseBuffer) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_buffer_to_string(s : PhysicsheatphaseBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_cursor_make(size : Int) -> PhysicsheatphaseCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_cursor_len(s : PhysicsheatphaseCursor) -> Int { s.size }

pub fn physics_heat_phase_cursor_get(s : PhysicsheatphaseCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_cursor_set(s : PhysicsheatphaseCursor, i : Int, v : Double) -> PhysicsheatphaseCursor {
  let result = physics_heat_phase_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_cursor_sum(s : PhysicsheatphaseCursor) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_cursor_mean(s : PhysicsheatphaseCursor) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_cursor_scale(s : PhysicsheatphaseCursor, f : Double) -> PhysicsheatphaseCursor {
  let result = physics_heat_phase_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_phase_cursor_add(a : PhysicsheatphaseCursor, b : PhysicsheatphaseCursor) -> PhysicsheatphaseCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_phase_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_phase_cursor_copy(s : PhysicsheatphaseCursor) -> PhysicsheatphaseCursor {
  let result = physics_heat_phase_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_phase_cursor_fill(s : PhysicsheatphaseCursor, v : Double) -> PhysicsheatphaseCursor {
  let result = physics_heat_phase_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_cursor_min(s : PhysicsheatphaseCursor) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_cursor_max(s : PhysicsheatphaseCursor) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_cursor_to_string(s : PhysicsheatphaseCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_view_make(size : Int) -> PhysicsheatphaseView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_view_len(s : PhysicsheatphaseView) -> Int { s.size }

pub fn physics_heat_phase_view_get(s : PhysicsheatphaseView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_view_set(s : PhysicsheatphaseView, i : Int, v : Double) -> PhysicsheatphaseView {
  let result = physics_heat_phase_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_view_sum(s : PhysicsheatphaseView) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_view_mean(s : PhysicsheatphaseView) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_view_scale(s : PhysicsheatphaseView, f : Double) -> PhysicsheatphaseView {
  let result = physics_heat_phase_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_phase_view_add(a : PhysicsheatphaseView, b : PhysicsheatphaseView) -> PhysicsheatphaseView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_phase_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_phase_view_copy(s : PhysicsheatphaseView) -> PhysicsheatphaseView {
  let result = physics_heat_phase_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_phase_view_fill(s : PhysicsheatphaseView, v : Double) -> PhysicsheatphaseView {
  let result = physics_heat_phase_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_view_min(s : PhysicsheatphaseView) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_view_max(s : PhysicsheatphaseView) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_view_to_string(s : PhysicsheatphaseView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_range_make(size : Int) -> PhysicsheatphaseRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_range_len(s : PhysicsheatphaseRange) -> Int { s.size }

pub fn physics_heat_phase_range_get(s : PhysicsheatphaseRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_range_set(s : PhysicsheatphaseRange, i : Int, v : Double) -> PhysicsheatphaseRange {
  let result = physics_heat_phase_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_range_sum(s : PhysicsheatphaseRange) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_range_mean(s : PhysicsheatphaseRange) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_range_scale(s : PhysicsheatphaseRange, f : Double) -> PhysicsheatphaseRange {
  let result = physics_heat_phase_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_phase_range_add(a : PhysicsheatphaseRange, b : PhysicsheatphaseRange) -> PhysicsheatphaseRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_phase_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_phase_range_copy(s : PhysicsheatphaseRange) -> PhysicsheatphaseRange {
  let result = physics_heat_phase_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_phase_range_fill(s : PhysicsheatphaseRange, v : Double) -> PhysicsheatphaseRange {
  let result = physics_heat_phase_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_range_min(s : PhysicsheatphaseRange) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_range_max(s : PhysicsheatphaseRange) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_range_to_string(s : PhysicsheatphaseRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatphaseSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_phase_slice_make(size : Int) -> PhysicsheatphaseSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_phase_slice_len(s : PhysicsheatphaseSlice) -> Int { s.size }

pub fn physics_heat_phase_slice_get(s : PhysicsheatphaseSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_phase_slice_set(s : PhysicsheatphaseSlice, i : Int, v : Double) -> PhysicsheatphaseSlice {
  let result = physics_heat_phase_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_slice_sum(s : PhysicsheatphaseSlice) -> Double { @_common.sum(s.data) }

pub fn physics_heat_phase_slice_mean(s : PhysicsheatphaseSlice) -> Double { @_common.mean(s.data) }

pub fn physics_heat_phase_slice_scale(s : PhysicsheatphaseSlice, f : Double) -> PhysicsheatphaseSlice {
  let result = physics_heat_phase_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_phase_slice_add(a : PhysicsheatphaseSlice, b : PhysicsheatphaseSlice) -> PhysicsheatphaseSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_phase_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_phase_slice_copy(s : PhysicsheatphaseSlice) -> PhysicsheatphaseSlice {
  let result = physics_heat_phase_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_phase_slice_fill(s : PhysicsheatphaseSlice, v : Double) -> PhysicsheatphaseSlice {
  let result = physics_heat_phase_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_phase_slice_min(s : PhysicsheatphaseSlice) -> Double { @_common.min(s.data) }

pub fn physics_heat_phase_slice_max(s : PhysicsheatphaseSlice) -> Double { @_common.max(s.data) }

pub fn physics_heat_phase_slice_to_string(s : PhysicsheatphaseSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

