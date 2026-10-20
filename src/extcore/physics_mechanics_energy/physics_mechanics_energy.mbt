///===
/// extcore/physics_mechanics_energy

pub(all) struct PhysicsmechanicsenergyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_energy_make_point(x : Double, y : Double) -> PhysicsmechanicsenergyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_energy_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicsenergyPoint {
  { x, y, z, label: 0 }
}

pub fn physics_mechanics_energy_point_x(pt : PhysicsmechanicsenergyPoint) -> Double { pt.x }

pub fn physics_mechanics_energy_point_y(pt : PhysicsmechanicsenergyPoint) -> Double { pt.y }

pub fn physics_mechanics_energy_point_z(pt : PhysicsmechanicsenergyPoint) -> Double { pt.z }

pub fn physics_mechanics_energy_point_label(pt : PhysicsmechanicsenergyPoint) -> Int { pt.label }

pub fn physics_mechanics_energy_point_dist(a : PhysicsmechanicsenergyPoint, b : PhysicsmechanicsenergyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_mechanics_energy_point_add(a : PhysicsmechanicsenergyPoint, b : PhysicsmechanicsenergyPoint) -> PhysicsmechanicsenergyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_mechanics_energy_point_sub(a : PhysicsmechanicsenergyPoint, b : PhysicsmechanicsenergyPoint) -> PhysicsmechanicsenergyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_mechanics_energy_point_scale(pt : PhysicsmechanicsenergyPoint, s : Double) -> PhysicsmechanicsenergyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_mechanics_energy_point_dot(a : PhysicsmechanicsenergyPoint, b : PhysicsmechanicsenergyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_mechanics_energy_point_cross(a : PhysicsmechanicsenergyPoint, b : PhysicsmechanicsenergyPoint) -> PhysicsmechanicsenergyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_mechanics_energy_point_norm(pt : PhysicsmechanicsenergyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_mechanics_energy_point_normalize(pt : PhysicsmechanicsenergyPoint) -> PhysicsmechanicsenergyPoint {
  let n = physics_mechanics_energy_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_mechanics_energy_point_scale(pt, 1.0 / n) }
}

pub fn physics_mechanics_energy_point_negate(pt : PhysicsmechanicsenergyPoint) -> PhysicsmechanicsenergyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_mechanics_energy_point_mid(a : PhysicsmechanicsenergyPoint, b : PhysicsmechanicsenergyPoint) -> PhysicsmechanicsenergyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_mechanics_energy_point_lerp(a : PhysicsmechanicsenergyPoint, b : PhysicsmechanicsenergyPoint, t : Double) -> PhysicsmechanicsenergyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_mechanics_energy_point_to_string(pt : PhysicsmechanicsenergyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_energy_make_series(vals : Array[Double], name : String) -> PhysicsmechanicsenergySeries {
  { vals, name, meta: 0 }
}

pub fn physics_mechanics_energy_series_len(s : PhysicsmechanicsenergySeries) -> Int { s.vals.length() }

pub fn physics_mechanics_energy_series_sum(s : PhysicsmechanicsenergySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_mechanics_energy_series_mean(s : PhysicsmechanicsenergySeries) -> Double { @_common.mean(s.vals) }

pub fn physics_mechanics_energy_series_min(s : PhysicsmechanicsenergySeries) -> Double { @_common.min(s.vals) }

pub fn physics_mechanics_energy_series_max(s : PhysicsmechanicsenergySeries) -> Double { @_common.max(s.vals) }

pub fn physics_mechanics_energy_series_range(s : PhysicsmechanicsenergySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_mechanics_energy_series_var(s : PhysicsmechanicsenergySeries) -> Double { @_common.variance(s.vals) }

pub fn physics_mechanics_energy_series_std(s : PhysicsmechanicsenergySeries) -> Double { @_common.std(s.vals) }

pub fn physics_mechanics_energy_series_median(s : PhysicsmechanicsenergySeries) -> Double { @_common.median(s.vals) }

pub fn physics_mechanics_energy_series_scale(s : PhysicsmechanicsenergySeries, f : Double) -> PhysicsmechanicsenergySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_mechanics_energy_series_add(a : PhysicsmechanicsenergySeries, b : PhysicsmechanicsenergySeries) -> PhysicsmechanicsenergySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_mechanics_energy_series_sub(a : PhysicsmechanicsenergySeries, b : PhysicsmechanicsenergySeries) -> PhysicsmechanicsenergySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_mechanics_energy_series_normalize(s : PhysicsmechanicsenergySeries) -> PhysicsmechanicsenergySeries {
  let mn = physics_mechanics_energy_series_min(s)
  let mx = physics_mechanics_energy_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_mechanics_energy_series_cumsum(s : PhysicsmechanicsenergySeries) -> PhysicsmechanicsenergySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_mechanics_energy_series_to_string(s : PhysicsmechanicsenergySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsenergyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_energy_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicsenergyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_energy_matrix_identity(n : Int) -> PhysicsmechanicsenergyMatrix {
  let m = physics_mechanics_energy_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_mechanics_energy_matrix_get(m : PhysicsmechanicsenergyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_mechanics_energy_matrix_transpose(m : PhysicsmechanicsenergyMatrix) -> PhysicsmechanicsenergyMatrix {
  let result = physics_mechanics_energy_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_mechanics_energy_matrix_add(a : PhysicsmechanicsenergyMatrix, b : PhysicsmechanicsenergyMatrix) -> PhysicsmechanicsenergyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_mechanics_energy_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_mechanics_energy_matrix_scale(m : PhysicsmechanicsenergyMatrix, s : Double) -> PhysicsmechanicsenergyMatrix {
  let result = physics_mechanics_energy_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_mechanics_energy_matrix_multiply(a : PhysicsmechanicsenergyMatrix, b : PhysicsmechanicsenergyMatrix) -> PhysicsmechanicsenergyMatrix {
  if a.cols != b.rows { return physics_mechanics_energy_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_mechanics_energy_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_mechanics_energy_matrix_trace(m : PhysicsmechanicsenergyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_mechanics_energy_matrix_det(m : PhysicsmechanicsenergyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_mechanics_energy_matrix_norm(m : PhysicsmechanicsenergyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_mechanics_energy_matrix_to_string(m : PhysicsmechanicsenergyMatrix) -> String {
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

pub(all) struct PhysicsmechanicsenergyVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_energy_make_vector(comps : Array[Double]) -> PhysicsmechanicsenergyVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_energy_vector_zero(dim : Int) -> PhysicsmechanicsenergyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_mechanics_energy_vector_add(a : PhysicsmechanicsenergyVector, b : PhysicsmechanicsenergyVector) -> PhysicsmechanicsenergyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_energy_vector_sub(a : PhysicsmechanicsenergyVector, b : PhysicsmechanicsenergyVector) -> PhysicsmechanicsenergyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_energy_vector_scale(v : PhysicsmechanicsenergyVector, s : Double) -> PhysicsmechanicsenergyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_mechanics_energy_vector_dot(a : PhysicsmechanicsenergyVector, b : PhysicsmechanicsenergyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_mechanics_energy_vector_norm(v : PhysicsmechanicsenergyVector) -> Double { @_common.sqrt(physics_mechanics_energy_vector_dot(v, v)) }

pub fn physics_mechanics_energy_vector_normalize(v : PhysicsmechanicsenergyVector) -> PhysicsmechanicsenergyVector {
  let n = physics_mechanics_energy_vector_norm(v)
  if n < 0.0000001 { v } else { physics_mechanics_energy_vector_scale(v, 1.0 / n) }
}

pub fn physics_mechanics_energy_vector_dist(a : PhysicsmechanicsenergyVector, b : PhysicsmechanicsenergyVector) -> Double {
  physics_mechanics_energy_vector_norm(physics_mechanics_energy_vector_sub(a, b))
}

pub fn physics_mechanics_energy_vector_to_string(v : PhysicsmechanicsenergyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_energy_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_mechanics_energy_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_mechanics_energy_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_mechanics_energy_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_mechanics_energy_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_mechanics_energy_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_mechanics_energy_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_mechanics_energy_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_mechanics_energy_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_mechanics_energy_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_mechanics_energy_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_mechanics_energy_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_mechanics_energy_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_mechanics_energy_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_mechanics_energy_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_mechanics_energy_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_mechanics_energy_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_mechanics_energy_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_mechanics_energy_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_mechanics_energy_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_mechanics_energy_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_mechanics_energy_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_mechanics_energy_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_mechanics_energy_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_mechanics_energy_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_mechanics_energy_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_mechanics_energy_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_mechanics_energy_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_mechanics_energy_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsmechanicsenergyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_frame_make(size : Int) -> PhysicsmechanicsenergyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_frame_len(s : PhysicsmechanicsenergyFrame) -> Int { s.size }

pub fn physics_mechanics_energy_frame_get(s : PhysicsmechanicsenergyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_frame_set(s : PhysicsmechanicsenergyFrame, i : Int, v : Double) -> PhysicsmechanicsenergyFrame {
  let result = physics_mechanics_energy_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_frame_sum(s : PhysicsmechanicsenergyFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_energy_frame_mean(s : PhysicsmechanicsenergyFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_energy_frame_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_energy_frame_scale(s : PhysicsmechanicsenergyFrame, f : Double) -> PhysicsmechanicsenergyFrame {
  let result = physics_mechanics_energy_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_energy_frame_add(a : PhysicsmechanicsenergyFrame, b : PhysicsmechanicsenergyFrame) -> PhysicsmechanicsenergyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_energy_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_energy_frame_copy(s : PhysicsmechanicsenergyFrame) -> PhysicsmechanicsenergyFrame {
  let result = physics_mechanics_energy_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_energy_frame_fill(s : PhysicsmechanicsenergyFrame, v : Double) -> PhysicsmechanicsenergyFrame {
  let result = physics_mechanics_energy_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_frame_min(s : PhysicsmechanicsenergyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_frame_max(s : PhysicsmechanicsenergyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_frame_to_string(s : PhysicsmechanicsenergyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_table_make(size : Int) -> PhysicsmechanicsenergyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_table_len(s : PhysicsmechanicsenergyTable) -> Int { s.size }

pub fn physics_mechanics_energy_table_get(s : PhysicsmechanicsenergyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_table_set(s : PhysicsmechanicsenergyTable, i : Int, v : Double) -> PhysicsmechanicsenergyTable {
  let result = physics_mechanics_energy_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_table_sum(s : PhysicsmechanicsenergyTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_energy_table_mean(s : PhysicsmechanicsenergyTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_energy_table_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_energy_table_scale(s : PhysicsmechanicsenergyTable, f : Double) -> PhysicsmechanicsenergyTable {
  let result = physics_mechanics_energy_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_energy_table_add(a : PhysicsmechanicsenergyTable, b : PhysicsmechanicsenergyTable) -> PhysicsmechanicsenergyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_energy_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_energy_table_copy(s : PhysicsmechanicsenergyTable) -> PhysicsmechanicsenergyTable {
  let result = physics_mechanics_energy_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_energy_table_fill(s : PhysicsmechanicsenergyTable, v : Double) -> PhysicsmechanicsenergyTable {
  let result = physics_mechanics_energy_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_table_min(s : PhysicsmechanicsenergyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_table_max(s : PhysicsmechanicsenergyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_table_to_string(s : PhysicsmechanicsenergyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_graphn_make(size : Int) -> PhysicsmechanicsenergyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_graphn_len(s : PhysicsmechanicsenergyGraphN) -> Int { s.size }

pub fn physics_mechanics_energy_graphn_get(s : PhysicsmechanicsenergyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_graphn_set(s : PhysicsmechanicsenergyGraphN, i : Int, v : Double) -> PhysicsmechanicsenergyGraphN {
  let result = physics_mechanics_energy_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_graphn_sum(s : PhysicsmechanicsenergyGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_energy_graphn_mean(s : PhysicsmechanicsenergyGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_energy_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_energy_graphn_scale(s : PhysicsmechanicsenergyGraphN, f : Double) -> PhysicsmechanicsenergyGraphN {
  let result = physics_mechanics_energy_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_energy_graphn_add(a : PhysicsmechanicsenergyGraphN, b : PhysicsmechanicsenergyGraphN) -> PhysicsmechanicsenergyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_energy_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_energy_graphn_copy(s : PhysicsmechanicsenergyGraphN) -> PhysicsmechanicsenergyGraphN {
  let result = physics_mechanics_energy_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_energy_graphn_fill(s : PhysicsmechanicsenergyGraphN, v : Double) -> PhysicsmechanicsenergyGraphN {
  let result = physics_mechanics_energy_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_graphn_min(s : PhysicsmechanicsenergyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_graphn_max(s : PhysicsmechanicsenergyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_graphn_to_string(s : PhysicsmechanicsenergyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_node_make(size : Int) -> PhysicsmechanicsenergyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_node_len(s : PhysicsmechanicsenergyNode) -> Int { s.size }

pub fn physics_mechanics_energy_node_get(s : PhysicsmechanicsenergyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_node_set(s : PhysicsmechanicsenergyNode, i : Int, v : Double) -> PhysicsmechanicsenergyNode {
  let result = physics_mechanics_energy_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_node_sum(s : PhysicsmechanicsenergyNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_energy_node_mean(s : PhysicsmechanicsenergyNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_energy_node_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_energy_node_scale(s : PhysicsmechanicsenergyNode, f : Double) -> PhysicsmechanicsenergyNode {
  let result = physics_mechanics_energy_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_energy_node_add(a : PhysicsmechanicsenergyNode, b : PhysicsmechanicsenergyNode) -> PhysicsmechanicsenergyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_energy_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_energy_node_copy(s : PhysicsmechanicsenergyNode) -> PhysicsmechanicsenergyNode {
  let result = physics_mechanics_energy_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_energy_node_fill(s : PhysicsmechanicsenergyNode, v : Double) -> PhysicsmechanicsenergyNode {
  let result = physics_mechanics_energy_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_node_min(s : PhysicsmechanicsenergyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_node_max(s : PhysicsmechanicsenergyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_node_to_string(s : PhysicsmechanicsenergyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_edge_make(size : Int) -> PhysicsmechanicsenergyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_edge_len(s : PhysicsmechanicsenergyEdge) -> Int { s.size }

pub fn physics_mechanics_energy_edge_get(s : PhysicsmechanicsenergyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_edge_set(s : PhysicsmechanicsenergyEdge, i : Int, v : Double) -> PhysicsmechanicsenergyEdge {
  let result = physics_mechanics_energy_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_edge_sum(s : PhysicsmechanicsenergyEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_energy_edge_mean(s : PhysicsmechanicsenergyEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_energy_edge_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_energy_edge_scale(s : PhysicsmechanicsenergyEdge, f : Double) -> PhysicsmechanicsenergyEdge {
  let result = physics_mechanics_energy_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_energy_edge_add(a : PhysicsmechanicsenergyEdge, b : PhysicsmechanicsenergyEdge) -> PhysicsmechanicsenergyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_energy_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_energy_edge_copy(s : PhysicsmechanicsenergyEdge) -> PhysicsmechanicsenergyEdge {
  let result = physics_mechanics_energy_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_energy_edge_fill(s : PhysicsmechanicsenergyEdge, v : Double) -> PhysicsmechanicsenergyEdge {
  let result = physics_mechanics_energy_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_edge_min(s : PhysicsmechanicsenergyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_edge_max(s : PhysicsmechanicsenergyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_edge_to_string(s : PhysicsmechanicsenergyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_path_make(size : Int) -> PhysicsmechanicsenergyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_path_len(s : PhysicsmechanicsenergyPath) -> Int { s.size }

pub fn physics_mechanics_energy_path_get(s : PhysicsmechanicsenergyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_path_set(s : PhysicsmechanicsenergyPath, i : Int, v : Double) -> PhysicsmechanicsenergyPath {
  let result = physics_mechanics_energy_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_path_sum(s : PhysicsmechanicsenergyPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_energy_path_mean(s : PhysicsmechanicsenergyPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_energy_path_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_energy_path_scale(s : PhysicsmechanicsenergyPath, f : Double) -> PhysicsmechanicsenergyPath {
  let result = physics_mechanics_energy_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_energy_path_add(a : PhysicsmechanicsenergyPath, b : PhysicsmechanicsenergyPath) -> PhysicsmechanicsenergyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_energy_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_energy_path_copy(s : PhysicsmechanicsenergyPath) -> PhysicsmechanicsenergyPath {
  let result = physics_mechanics_energy_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_energy_path_fill(s : PhysicsmechanicsenergyPath, v : Double) -> PhysicsmechanicsenergyPath {
  let result = physics_mechanics_energy_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_path_min(s : PhysicsmechanicsenergyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_path_max(s : PhysicsmechanicsenergyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_path_to_string(s : PhysicsmechanicsenergyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_cluster_make(size : Int) -> PhysicsmechanicsenergyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_cluster_len(s : PhysicsmechanicsenergyCluster) -> Int { s.size }

pub fn physics_mechanics_energy_cluster_get(s : PhysicsmechanicsenergyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_cluster_set(s : PhysicsmechanicsenergyCluster, i : Int, v : Double) -> PhysicsmechanicsenergyCluster {
  let result = physics_mechanics_energy_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_cluster_sum(s : PhysicsmechanicsenergyCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_energy_cluster_mean(s : PhysicsmechanicsenergyCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_energy_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_energy_cluster_scale(s : PhysicsmechanicsenergyCluster, f : Double) -> PhysicsmechanicsenergyCluster {
  let result = physics_mechanics_energy_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_energy_cluster_add(a : PhysicsmechanicsenergyCluster, b : PhysicsmechanicsenergyCluster) -> PhysicsmechanicsenergyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_energy_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_energy_cluster_copy(s : PhysicsmechanicsenergyCluster) -> PhysicsmechanicsenergyCluster {
  let result = physics_mechanics_energy_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_energy_cluster_fill(s : PhysicsmechanicsenergyCluster, v : Double) -> PhysicsmechanicsenergyCluster {
  let result = physics_mechanics_energy_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_cluster_min(s : PhysicsmechanicsenergyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_cluster_max(s : PhysicsmechanicsenergyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_cluster_to_string(s : PhysicsmechanicsenergyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_model_make(size : Int) -> PhysicsmechanicsenergyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_model_len(s : PhysicsmechanicsenergyModel) -> Int { s.size }

pub fn physics_mechanics_energy_model_get(s : PhysicsmechanicsenergyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_model_set(s : PhysicsmechanicsenergyModel, i : Int, v : Double) -> PhysicsmechanicsenergyModel {
  let result = physics_mechanics_energy_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_model_sum(s : PhysicsmechanicsenergyModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_energy_model_mean(s : PhysicsmechanicsenergyModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_energy_model_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_energy_model_scale(s : PhysicsmechanicsenergyModel, f : Double) -> PhysicsmechanicsenergyModel {
  let result = physics_mechanics_energy_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_energy_model_add(a : PhysicsmechanicsenergyModel, b : PhysicsmechanicsenergyModel) -> PhysicsmechanicsenergyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_energy_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_energy_model_copy(s : PhysicsmechanicsenergyModel) -> PhysicsmechanicsenergyModel {
  let result = physics_mechanics_energy_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_energy_model_fill(s : PhysicsmechanicsenergyModel, v : Double) -> PhysicsmechanicsenergyModel {
  let result = physics_mechanics_energy_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_model_min(s : PhysicsmechanicsenergyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_model_max(s : PhysicsmechanicsenergyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_model_to_string(s : PhysicsmechanicsenergyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_layer_make(size : Int) -> PhysicsmechanicsenergyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_layer_len(s : PhysicsmechanicsenergyLayer) -> Int { s.size }

pub fn physics_mechanics_energy_layer_get(s : PhysicsmechanicsenergyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_layer_set(s : PhysicsmechanicsenergyLayer, i : Int, v : Double) -> PhysicsmechanicsenergyLayer {
  let result = physics_mechanics_energy_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_layer_sum(s : PhysicsmechanicsenergyLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_energy_layer_mean(s : PhysicsmechanicsenergyLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_energy_layer_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_energy_layer_scale(s : PhysicsmechanicsenergyLayer, f : Double) -> PhysicsmechanicsenergyLayer {
  let result = physics_mechanics_energy_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_energy_layer_add(a : PhysicsmechanicsenergyLayer, b : PhysicsmechanicsenergyLayer) -> PhysicsmechanicsenergyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_energy_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_energy_layer_copy(s : PhysicsmechanicsenergyLayer) -> PhysicsmechanicsenergyLayer {
  let result = physics_mechanics_energy_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_energy_layer_fill(s : PhysicsmechanicsenergyLayer, v : Double) -> PhysicsmechanicsenergyLayer {
  let result = physics_mechanics_energy_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_layer_min(s : PhysicsmechanicsenergyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_layer_max(s : PhysicsmechanicsenergyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_layer_to_string(s : PhysicsmechanicsenergyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_buffer_make(size : Int) -> PhysicsmechanicsenergyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_buffer_len(s : PhysicsmechanicsenergyBuffer) -> Int { s.size }

pub fn physics_mechanics_energy_buffer_get(s : PhysicsmechanicsenergyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_buffer_set(s : PhysicsmechanicsenergyBuffer, i : Int, v : Double) -> PhysicsmechanicsenergyBuffer {
  let result = physics_mechanics_energy_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_buffer_sum(s : PhysicsmechanicsenergyBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_energy_buffer_mean(s : PhysicsmechanicsenergyBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_energy_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_energy_buffer_scale(s : PhysicsmechanicsenergyBuffer, f : Double) -> PhysicsmechanicsenergyBuffer {
  let result = physics_mechanics_energy_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_energy_buffer_add(a : PhysicsmechanicsenergyBuffer, b : PhysicsmechanicsenergyBuffer) -> PhysicsmechanicsenergyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_energy_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_energy_buffer_copy(s : PhysicsmechanicsenergyBuffer) -> PhysicsmechanicsenergyBuffer {
  let result = physics_mechanics_energy_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_energy_buffer_fill(s : PhysicsmechanicsenergyBuffer, v : Double) -> PhysicsmechanicsenergyBuffer {
  let result = physics_mechanics_energy_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_buffer_min(s : PhysicsmechanicsenergyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_buffer_max(s : PhysicsmechanicsenergyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_buffer_to_string(s : PhysicsmechanicsenergyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_cursor_make(size : Int) -> PhysicsmechanicsenergyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_cursor_len(s : PhysicsmechanicsenergyCursor) -> Int { s.size }

pub fn physics_mechanics_energy_cursor_get(s : PhysicsmechanicsenergyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_cursor_set(s : PhysicsmechanicsenergyCursor, i : Int, v : Double) -> PhysicsmechanicsenergyCursor {
  let result = physics_mechanics_energy_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_cursor_sum(s : PhysicsmechanicsenergyCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_energy_cursor_mean(s : PhysicsmechanicsenergyCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_energy_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_energy_cursor_scale(s : PhysicsmechanicsenergyCursor, f : Double) -> PhysicsmechanicsenergyCursor {
  let result = physics_mechanics_energy_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_energy_cursor_add(a : PhysicsmechanicsenergyCursor, b : PhysicsmechanicsenergyCursor) -> PhysicsmechanicsenergyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_energy_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_energy_cursor_copy(s : PhysicsmechanicsenergyCursor) -> PhysicsmechanicsenergyCursor {
  let result = physics_mechanics_energy_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_energy_cursor_fill(s : PhysicsmechanicsenergyCursor, v : Double) -> PhysicsmechanicsenergyCursor {
  let result = physics_mechanics_energy_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_cursor_min(s : PhysicsmechanicsenergyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_cursor_max(s : PhysicsmechanicsenergyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_cursor_to_string(s : PhysicsmechanicsenergyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_view_make(size : Int) -> PhysicsmechanicsenergyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_view_len(s : PhysicsmechanicsenergyView) -> Int { s.size }

pub fn physics_mechanics_energy_view_get(s : PhysicsmechanicsenergyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_view_set(s : PhysicsmechanicsenergyView, i : Int, v : Double) -> PhysicsmechanicsenergyView {
  let result = physics_mechanics_energy_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_view_sum(s : PhysicsmechanicsenergyView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_energy_view_mean(s : PhysicsmechanicsenergyView) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_energy_view_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_energy_view_scale(s : PhysicsmechanicsenergyView, f : Double) -> PhysicsmechanicsenergyView {
  let result = physics_mechanics_energy_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_energy_view_add(a : PhysicsmechanicsenergyView, b : PhysicsmechanicsenergyView) -> PhysicsmechanicsenergyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_energy_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_energy_view_copy(s : PhysicsmechanicsenergyView) -> PhysicsmechanicsenergyView {
  let result = physics_mechanics_energy_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_energy_view_fill(s : PhysicsmechanicsenergyView, v : Double) -> PhysicsmechanicsenergyView {
  let result = physics_mechanics_energy_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_view_min(s : PhysicsmechanicsenergyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_view_max(s : PhysicsmechanicsenergyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_view_to_string(s : PhysicsmechanicsenergyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_range_make(size : Int) -> PhysicsmechanicsenergyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_range_len(s : PhysicsmechanicsenergyRange) -> Int { s.size }

pub fn physics_mechanics_energy_range_get(s : PhysicsmechanicsenergyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_range_set(s : PhysicsmechanicsenergyRange, i : Int, v : Double) -> PhysicsmechanicsenergyRange {
  let result = physics_mechanics_energy_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_range_sum(s : PhysicsmechanicsenergyRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_energy_range_mean(s : PhysicsmechanicsenergyRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_energy_range_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_energy_range_scale(s : PhysicsmechanicsenergyRange, f : Double) -> PhysicsmechanicsenergyRange {
  let result = physics_mechanics_energy_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_energy_range_add(a : PhysicsmechanicsenergyRange, b : PhysicsmechanicsenergyRange) -> PhysicsmechanicsenergyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_energy_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_energy_range_copy(s : PhysicsmechanicsenergyRange) -> PhysicsmechanicsenergyRange {
  let result = physics_mechanics_energy_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_energy_range_fill(s : PhysicsmechanicsenergyRange, v : Double) -> PhysicsmechanicsenergyRange {
  let result = physics_mechanics_energy_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_range_min(s : PhysicsmechanicsenergyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_range_max(s : PhysicsmechanicsenergyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_range_to_string(s : PhysicsmechanicsenergyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsenergySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_energy_slice_make(size : Int) -> PhysicsmechanicsenergySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_energy_slice_len(s : PhysicsmechanicsenergySlice) -> Int { s.size }

pub fn physics_mechanics_energy_slice_get(s : PhysicsmechanicsenergySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_energy_slice_set(s : PhysicsmechanicsenergySlice, i : Int, v : Double) -> PhysicsmechanicsenergySlice {
  let result = physics_mechanics_energy_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_slice_sum(s : PhysicsmechanicsenergySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_energy_slice_mean(s : PhysicsmechanicsenergySlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_energy_slice_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_energy_slice_scale(s : PhysicsmechanicsenergySlice, f : Double) -> PhysicsmechanicsenergySlice {
  let result = physics_mechanics_energy_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_energy_slice_add(a : PhysicsmechanicsenergySlice, b : PhysicsmechanicsenergySlice) -> PhysicsmechanicsenergySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_energy_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_energy_slice_copy(s : PhysicsmechanicsenergySlice) -> PhysicsmechanicsenergySlice {
  let result = physics_mechanics_energy_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_energy_slice_fill(s : PhysicsmechanicsenergySlice, v : Double) -> PhysicsmechanicsenergySlice {
  let result = physics_mechanics_energy_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_energy_slice_min(s : PhysicsmechanicsenergySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_slice_max(s : PhysicsmechanicsenergySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_energy_slice_to_string(s : PhysicsmechanicsenergySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

