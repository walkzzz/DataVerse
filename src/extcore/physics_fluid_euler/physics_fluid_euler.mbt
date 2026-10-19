///===
/// extcore/physics_fluid_euler

pub(all) struct PhysicsfluideulerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_euler_make_point(x : Double, y : Double) -> PhysicsfluideulerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_euler_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluideulerPoint {
  { x, y, z, label: 0 }
}

pub fn physics_fluid_euler_point_x(pt : PhysicsfluideulerPoint) -> Double { pt.x }

pub fn physics_fluid_euler_point_y(pt : PhysicsfluideulerPoint) -> Double { pt.y }

pub fn physics_fluid_euler_point_z(pt : PhysicsfluideulerPoint) -> Double { pt.z }

pub fn physics_fluid_euler_point_label(pt : PhysicsfluideulerPoint) -> Int { pt.label }

pub fn physics_fluid_euler_point_dist(a : PhysicsfluideulerPoint, b : PhysicsfluideulerPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_fluid_euler_point_add(a : PhysicsfluideulerPoint, b : PhysicsfluideulerPoint) -> PhysicsfluideulerPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_fluid_euler_point_sub(a : PhysicsfluideulerPoint, b : PhysicsfluideulerPoint) -> PhysicsfluideulerPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_fluid_euler_point_scale(pt : PhysicsfluideulerPoint, s : Double) -> PhysicsfluideulerPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_fluid_euler_point_dot(a : PhysicsfluideulerPoint, b : PhysicsfluideulerPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_fluid_euler_point_cross(a : PhysicsfluideulerPoint, b : PhysicsfluideulerPoint) -> PhysicsfluideulerPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_fluid_euler_point_norm(pt : PhysicsfluideulerPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_fluid_euler_point_normalize(pt : PhysicsfluideulerPoint) -> PhysicsfluideulerPoint {
  let n = physics_fluid_euler_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_fluid_euler_point_scale(pt, 1.0 / n) }
}

pub fn physics_fluid_euler_point_negate(pt : PhysicsfluideulerPoint) -> PhysicsfluideulerPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_fluid_euler_point_mid(a : PhysicsfluideulerPoint, b : PhysicsfluideulerPoint) -> PhysicsfluideulerPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_fluid_euler_point_lerp(a : PhysicsfluideulerPoint, b : PhysicsfluideulerPoint, t : Double) -> PhysicsfluideulerPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_fluid_euler_point_to_string(pt : PhysicsfluideulerPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsfluideulerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_euler_make_series(vals : Array[Double], name : String) -> PhysicsfluideulerSeries {
  { vals, name, meta: 0 }
}

pub fn physics_fluid_euler_series_len(s : PhysicsfluideulerSeries) -> Int { s.vals.length() }

pub fn physics_fluid_euler_series_sum(s : PhysicsfluideulerSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_fluid_euler_series_mean(s : PhysicsfluideulerSeries) -> Double {
  let n = physics_fluid_euler_series_len(s)
  if n == 0 { 0.0 } else { physics_fluid_euler_series_sum(s) / n.to_double() }
}

pub fn physics_fluid_euler_series_min(s : PhysicsfluideulerSeries) -> Double {
  let n = physics_fluid_euler_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_fluid_euler_series_max(s : PhysicsfluideulerSeries) -> Double {
  let n = physics_fluid_euler_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_fluid_euler_series_range(s : PhysicsfluideulerSeries) -> Double {
  physics_fluid_euler_series_max(s) - physics_fluid_euler_series_min(s)
}

pub fn physics_fluid_euler_series_var(s : PhysicsfluideulerSeries) -> Double {
  let n = physics_fluid_euler_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_fluid_euler_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_fluid_euler_series_std(s : PhysicsfluideulerSeries) -> Double { @_common.sqrt(physics_fluid_euler_series_var(s)) }

pub fn physics_fluid_euler_series_median(s : PhysicsfluideulerSeries) -> Double {
  let n = physics_fluid_euler_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_fluid_euler_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_fluid_euler_series_scale(s : PhysicsfluideulerSeries, f : Double) -> PhysicsfluideulerSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_fluid_euler_series_add(a : PhysicsfluideulerSeries, b : PhysicsfluideulerSeries) -> PhysicsfluideulerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_fluid_euler_series_sub(a : PhysicsfluideulerSeries, b : PhysicsfluideulerSeries) -> PhysicsfluideulerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_fluid_euler_series_normalize(s : PhysicsfluideulerSeries) -> PhysicsfluideulerSeries {
  let mn = physics_fluid_euler_series_min(s)
  let mx = physics_fluid_euler_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_fluid_euler_series_cumsum(s : PhysicsfluideulerSeries) -> PhysicsfluideulerSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_fluid_euler_series_to_string(s : PhysicsfluideulerSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluideulerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_euler_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluideulerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_euler_matrix_identity(n : Int) -> PhysicsfluideulerMatrix {
  let m = physics_fluid_euler_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_fluid_euler_matrix_get(m : PhysicsfluideulerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_fluid_euler_matrix_transpose(m : PhysicsfluideulerMatrix) -> PhysicsfluideulerMatrix {
  let result = physics_fluid_euler_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_fluid_euler_matrix_add(a : PhysicsfluideulerMatrix, b : PhysicsfluideulerMatrix) -> PhysicsfluideulerMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_fluid_euler_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_fluid_euler_matrix_scale(m : PhysicsfluideulerMatrix, s : Double) -> PhysicsfluideulerMatrix {
  let result = physics_fluid_euler_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_fluid_euler_matrix_multiply(a : PhysicsfluideulerMatrix, b : PhysicsfluideulerMatrix) -> PhysicsfluideulerMatrix {
  if a.cols != b.rows { return physics_fluid_euler_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_fluid_euler_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_fluid_euler_matrix_trace(m : PhysicsfluideulerMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_fluid_euler_matrix_det(m : PhysicsfluideulerMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_fluid_euler_matrix_norm(m : PhysicsfluideulerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_fluid_euler_matrix_to_string(m : PhysicsfluideulerMatrix) -> String {
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

pub(all) struct PhysicsfluideulerVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_euler_make_vector(comps : Array[Double]) -> PhysicsfluideulerVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_euler_vector_zero(dim : Int) -> PhysicsfluideulerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_fluid_euler_vector_add(a : PhysicsfluideulerVector, b : PhysicsfluideulerVector) -> PhysicsfluideulerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_euler_vector_sub(a : PhysicsfluideulerVector, b : PhysicsfluideulerVector) -> PhysicsfluideulerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_euler_vector_scale(v : PhysicsfluideulerVector, s : Double) -> PhysicsfluideulerVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_fluid_euler_vector_dot(a : PhysicsfluideulerVector, b : PhysicsfluideulerVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_fluid_euler_vector_norm(v : PhysicsfluideulerVector) -> Double { @_common.sqrt(physics_fluid_euler_vector_dot(v, v)) }

pub fn physics_fluid_euler_vector_normalize(v : PhysicsfluideulerVector) -> PhysicsfluideulerVector {
  let n = physics_fluid_euler_vector_norm(v)
  if n < 0.0000001 { v } else { physics_fluid_euler_vector_scale(v, 1.0 / n) }
}

pub fn physics_fluid_euler_vector_dist(a : PhysicsfluideulerVector, b : PhysicsfluideulerVector) -> Double {
  physics_fluid_euler_vector_norm(physics_fluid_euler_vector_sub(a, b))
}

pub fn physics_fluid_euler_vector_to_string(v : PhysicsfluideulerVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_euler_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_fluid_euler_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_fluid_euler_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_fluid_euler_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_fluid_euler_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_fluid_euler_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_fluid_euler_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_fluid_euler_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_fluid_euler_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_fluid_euler_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_fluid_euler_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_fluid_euler_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_fluid_euler_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_fluid_euler_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_fluid_euler_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_fluid_euler_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_fluid_euler_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_fluid_euler_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_fluid_euler_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_fluid_euler_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_fluid_euler_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_fluid_euler_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_fluid_euler_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_fluid_euler_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_fluid_euler_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_fluid_euler_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_fluid_euler_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_fluid_euler_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_fluid_euler_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsfluideulerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_frame_make(size : Int) -> PhysicsfluideulerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_frame_len(s : PhysicsfluideulerFrame) -> Int { s.size }

pub fn physics_fluid_euler_frame_get(s : PhysicsfluideulerFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_frame_set(s : PhysicsfluideulerFrame, i : Int, v : Double) -> PhysicsfluideulerFrame {
  let result = physics_fluid_euler_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_frame_sum(s : PhysicsfluideulerFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_euler_frame_mean(s : PhysicsfluideulerFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_euler_frame_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_euler_frame_scale(s : PhysicsfluideulerFrame, f : Double) -> PhysicsfluideulerFrame {
  let result = physics_fluid_euler_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_euler_frame_add(a : PhysicsfluideulerFrame, b : PhysicsfluideulerFrame) -> PhysicsfluideulerFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_euler_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_euler_frame_copy(s : PhysicsfluideulerFrame) -> PhysicsfluideulerFrame {
  let result = physics_fluid_euler_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_euler_frame_fill(s : PhysicsfluideulerFrame, v : Double) -> PhysicsfluideulerFrame {
  let result = physics_fluid_euler_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_frame_min(s : PhysicsfluideulerFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_frame_max(s : PhysicsfluideulerFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_frame_to_string(s : PhysicsfluideulerFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_table_make(size : Int) -> PhysicsfluideulerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_table_len(s : PhysicsfluideulerTable) -> Int { s.size }

pub fn physics_fluid_euler_table_get(s : PhysicsfluideulerTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_table_set(s : PhysicsfluideulerTable, i : Int, v : Double) -> PhysicsfluideulerTable {
  let result = physics_fluid_euler_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_table_sum(s : PhysicsfluideulerTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_euler_table_mean(s : PhysicsfluideulerTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_euler_table_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_euler_table_scale(s : PhysicsfluideulerTable, f : Double) -> PhysicsfluideulerTable {
  let result = physics_fluid_euler_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_euler_table_add(a : PhysicsfluideulerTable, b : PhysicsfluideulerTable) -> PhysicsfluideulerTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_euler_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_euler_table_copy(s : PhysicsfluideulerTable) -> PhysicsfluideulerTable {
  let result = physics_fluid_euler_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_euler_table_fill(s : PhysicsfluideulerTable, v : Double) -> PhysicsfluideulerTable {
  let result = physics_fluid_euler_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_table_min(s : PhysicsfluideulerTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_table_max(s : PhysicsfluideulerTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_table_to_string(s : PhysicsfluideulerTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_graphn_make(size : Int) -> PhysicsfluideulerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_graphn_len(s : PhysicsfluideulerGraphN) -> Int { s.size }

pub fn physics_fluid_euler_graphn_get(s : PhysicsfluideulerGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_graphn_set(s : PhysicsfluideulerGraphN, i : Int, v : Double) -> PhysicsfluideulerGraphN {
  let result = physics_fluid_euler_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_graphn_sum(s : PhysicsfluideulerGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_euler_graphn_mean(s : PhysicsfluideulerGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_euler_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_euler_graphn_scale(s : PhysicsfluideulerGraphN, f : Double) -> PhysicsfluideulerGraphN {
  let result = physics_fluid_euler_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_euler_graphn_add(a : PhysicsfluideulerGraphN, b : PhysicsfluideulerGraphN) -> PhysicsfluideulerGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_euler_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_euler_graphn_copy(s : PhysicsfluideulerGraphN) -> PhysicsfluideulerGraphN {
  let result = physics_fluid_euler_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_euler_graphn_fill(s : PhysicsfluideulerGraphN, v : Double) -> PhysicsfluideulerGraphN {
  let result = physics_fluid_euler_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_graphn_min(s : PhysicsfluideulerGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_graphn_max(s : PhysicsfluideulerGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_graphn_to_string(s : PhysicsfluideulerGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_node_make(size : Int) -> PhysicsfluideulerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_node_len(s : PhysicsfluideulerNode) -> Int { s.size }

pub fn physics_fluid_euler_node_get(s : PhysicsfluideulerNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_node_set(s : PhysicsfluideulerNode, i : Int, v : Double) -> PhysicsfluideulerNode {
  let result = physics_fluid_euler_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_node_sum(s : PhysicsfluideulerNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_euler_node_mean(s : PhysicsfluideulerNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_euler_node_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_euler_node_scale(s : PhysicsfluideulerNode, f : Double) -> PhysicsfluideulerNode {
  let result = physics_fluid_euler_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_euler_node_add(a : PhysicsfluideulerNode, b : PhysicsfluideulerNode) -> PhysicsfluideulerNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_euler_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_euler_node_copy(s : PhysicsfluideulerNode) -> PhysicsfluideulerNode {
  let result = physics_fluid_euler_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_euler_node_fill(s : PhysicsfluideulerNode, v : Double) -> PhysicsfluideulerNode {
  let result = physics_fluid_euler_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_node_min(s : PhysicsfluideulerNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_node_max(s : PhysicsfluideulerNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_node_to_string(s : PhysicsfluideulerNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_edge_make(size : Int) -> PhysicsfluideulerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_edge_len(s : PhysicsfluideulerEdge) -> Int { s.size }

pub fn physics_fluid_euler_edge_get(s : PhysicsfluideulerEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_edge_set(s : PhysicsfluideulerEdge, i : Int, v : Double) -> PhysicsfluideulerEdge {
  let result = physics_fluid_euler_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_edge_sum(s : PhysicsfluideulerEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_euler_edge_mean(s : PhysicsfluideulerEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_euler_edge_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_euler_edge_scale(s : PhysicsfluideulerEdge, f : Double) -> PhysicsfluideulerEdge {
  let result = physics_fluid_euler_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_euler_edge_add(a : PhysicsfluideulerEdge, b : PhysicsfluideulerEdge) -> PhysicsfluideulerEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_euler_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_euler_edge_copy(s : PhysicsfluideulerEdge) -> PhysicsfluideulerEdge {
  let result = physics_fluid_euler_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_euler_edge_fill(s : PhysicsfluideulerEdge, v : Double) -> PhysicsfluideulerEdge {
  let result = physics_fluid_euler_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_edge_min(s : PhysicsfluideulerEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_edge_max(s : PhysicsfluideulerEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_edge_to_string(s : PhysicsfluideulerEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_path_make(size : Int) -> PhysicsfluideulerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_path_len(s : PhysicsfluideulerPath) -> Int { s.size }

pub fn physics_fluid_euler_path_get(s : PhysicsfluideulerPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_path_set(s : PhysicsfluideulerPath, i : Int, v : Double) -> PhysicsfluideulerPath {
  let result = physics_fluid_euler_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_path_sum(s : PhysicsfluideulerPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_euler_path_mean(s : PhysicsfluideulerPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_euler_path_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_euler_path_scale(s : PhysicsfluideulerPath, f : Double) -> PhysicsfluideulerPath {
  let result = physics_fluid_euler_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_euler_path_add(a : PhysicsfluideulerPath, b : PhysicsfluideulerPath) -> PhysicsfluideulerPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_euler_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_euler_path_copy(s : PhysicsfluideulerPath) -> PhysicsfluideulerPath {
  let result = physics_fluid_euler_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_euler_path_fill(s : PhysicsfluideulerPath, v : Double) -> PhysicsfluideulerPath {
  let result = physics_fluid_euler_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_path_min(s : PhysicsfluideulerPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_path_max(s : PhysicsfluideulerPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_path_to_string(s : PhysicsfluideulerPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_cluster_make(size : Int) -> PhysicsfluideulerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_cluster_len(s : PhysicsfluideulerCluster) -> Int { s.size }

pub fn physics_fluid_euler_cluster_get(s : PhysicsfluideulerCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_cluster_set(s : PhysicsfluideulerCluster, i : Int, v : Double) -> PhysicsfluideulerCluster {
  let result = physics_fluid_euler_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_cluster_sum(s : PhysicsfluideulerCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_euler_cluster_mean(s : PhysicsfluideulerCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_euler_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_euler_cluster_scale(s : PhysicsfluideulerCluster, f : Double) -> PhysicsfluideulerCluster {
  let result = physics_fluid_euler_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_euler_cluster_add(a : PhysicsfluideulerCluster, b : PhysicsfluideulerCluster) -> PhysicsfluideulerCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_euler_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_euler_cluster_copy(s : PhysicsfluideulerCluster) -> PhysicsfluideulerCluster {
  let result = physics_fluid_euler_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_euler_cluster_fill(s : PhysicsfluideulerCluster, v : Double) -> PhysicsfluideulerCluster {
  let result = physics_fluid_euler_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_cluster_min(s : PhysicsfluideulerCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_cluster_max(s : PhysicsfluideulerCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_cluster_to_string(s : PhysicsfluideulerCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_model_make(size : Int) -> PhysicsfluideulerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_model_len(s : PhysicsfluideulerModel) -> Int { s.size }

pub fn physics_fluid_euler_model_get(s : PhysicsfluideulerModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_model_set(s : PhysicsfluideulerModel, i : Int, v : Double) -> PhysicsfluideulerModel {
  let result = physics_fluid_euler_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_model_sum(s : PhysicsfluideulerModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_euler_model_mean(s : PhysicsfluideulerModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_euler_model_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_euler_model_scale(s : PhysicsfluideulerModel, f : Double) -> PhysicsfluideulerModel {
  let result = physics_fluid_euler_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_euler_model_add(a : PhysicsfluideulerModel, b : PhysicsfluideulerModel) -> PhysicsfluideulerModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_euler_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_euler_model_copy(s : PhysicsfluideulerModel) -> PhysicsfluideulerModel {
  let result = physics_fluid_euler_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_euler_model_fill(s : PhysicsfluideulerModel, v : Double) -> PhysicsfluideulerModel {
  let result = physics_fluid_euler_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_model_min(s : PhysicsfluideulerModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_model_max(s : PhysicsfluideulerModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_model_to_string(s : PhysicsfluideulerModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_layer_make(size : Int) -> PhysicsfluideulerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_layer_len(s : PhysicsfluideulerLayer) -> Int { s.size }

pub fn physics_fluid_euler_layer_get(s : PhysicsfluideulerLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_layer_set(s : PhysicsfluideulerLayer, i : Int, v : Double) -> PhysicsfluideulerLayer {
  let result = physics_fluid_euler_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_layer_sum(s : PhysicsfluideulerLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_euler_layer_mean(s : PhysicsfluideulerLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_euler_layer_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_euler_layer_scale(s : PhysicsfluideulerLayer, f : Double) -> PhysicsfluideulerLayer {
  let result = physics_fluid_euler_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_euler_layer_add(a : PhysicsfluideulerLayer, b : PhysicsfluideulerLayer) -> PhysicsfluideulerLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_euler_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_euler_layer_copy(s : PhysicsfluideulerLayer) -> PhysicsfluideulerLayer {
  let result = physics_fluid_euler_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_euler_layer_fill(s : PhysicsfluideulerLayer, v : Double) -> PhysicsfluideulerLayer {
  let result = physics_fluid_euler_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_layer_min(s : PhysicsfluideulerLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_layer_max(s : PhysicsfluideulerLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_layer_to_string(s : PhysicsfluideulerLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_buffer_make(size : Int) -> PhysicsfluideulerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_buffer_len(s : PhysicsfluideulerBuffer) -> Int { s.size }

pub fn physics_fluid_euler_buffer_get(s : PhysicsfluideulerBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_buffer_set(s : PhysicsfluideulerBuffer, i : Int, v : Double) -> PhysicsfluideulerBuffer {
  let result = physics_fluid_euler_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_buffer_sum(s : PhysicsfluideulerBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_euler_buffer_mean(s : PhysicsfluideulerBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_euler_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_euler_buffer_scale(s : PhysicsfluideulerBuffer, f : Double) -> PhysicsfluideulerBuffer {
  let result = physics_fluid_euler_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_euler_buffer_add(a : PhysicsfluideulerBuffer, b : PhysicsfluideulerBuffer) -> PhysicsfluideulerBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_euler_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_euler_buffer_copy(s : PhysicsfluideulerBuffer) -> PhysicsfluideulerBuffer {
  let result = physics_fluid_euler_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_euler_buffer_fill(s : PhysicsfluideulerBuffer, v : Double) -> PhysicsfluideulerBuffer {
  let result = physics_fluid_euler_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_buffer_min(s : PhysicsfluideulerBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_buffer_max(s : PhysicsfluideulerBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_buffer_to_string(s : PhysicsfluideulerBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_cursor_make(size : Int) -> PhysicsfluideulerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_cursor_len(s : PhysicsfluideulerCursor) -> Int { s.size }

pub fn physics_fluid_euler_cursor_get(s : PhysicsfluideulerCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_cursor_set(s : PhysicsfluideulerCursor, i : Int, v : Double) -> PhysicsfluideulerCursor {
  let result = physics_fluid_euler_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_cursor_sum(s : PhysicsfluideulerCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_euler_cursor_mean(s : PhysicsfluideulerCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_euler_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_euler_cursor_scale(s : PhysicsfluideulerCursor, f : Double) -> PhysicsfluideulerCursor {
  let result = physics_fluid_euler_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_euler_cursor_add(a : PhysicsfluideulerCursor, b : PhysicsfluideulerCursor) -> PhysicsfluideulerCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_euler_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_euler_cursor_copy(s : PhysicsfluideulerCursor) -> PhysicsfluideulerCursor {
  let result = physics_fluid_euler_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_euler_cursor_fill(s : PhysicsfluideulerCursor, v : Double) -> PhysicsfluideulerCursor {
  let result = physics_fluid_euler_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_cursor_min(s : PhysicsfluideulerCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_cursor_max(s : PhysicsfluideulerCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_cursor_to_string(s : PhysicsfluideulerCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_view_make(size : Int) -> PhysicsfluideulerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_view_len(s : PhysicsfluideulerView) -> Int { s.size }

pub fn physics_fluid_euler_view_get(s : PhysicsfluideulerView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_view_set(s : PhysicsfluideulerView, i : Int, v : Double) -> PhysicsfluideulerView {
  let result = physics_fluid_euler_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_view_sum(s : PhysicsfluideulerView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_euler_view_mean(s : PhysicsfluideulerView) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_euler_view_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_euler_view_scale(s : PhysicsfluideulerView, f : Double) -> PhysicsfluideulerView {
  let result = physics_fluid_euler_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_euler_view_add(a : PhysicsfluideulerView, b : PhysicsfluideulerView) -> PhysicsfluideulerView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_euler_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_euler_view_copy(s : PhysicsfluideulerView) -> PhysicsfluideulerView {
  let result = physics_fluid_euler_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_euler_view_fill(s : PhysicsfluideulerView, v : Double) -> PhysicsfluideulerView {
  let result = physics_fluid_euler_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_view_min(s : PhysicsfluideulerView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_view_max(s : PhysicsfluideulerView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_view_to_string(s : PhysicsfluideulerView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_range_make(size : Int) -> PhysicsfluideulerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_range_len(s : PhysicsfluideulerRange) -> Int { s.size }

pub fn physics_fluid_euler_range_get(s : PhysicsfluideulerRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_range_set(s : PhysicsfluideulerRange, i : Int, v : Double) -> PhysicsfluideulerRange {
  let result = physics_fluid_euler_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_range_sum(s : PhysicsfluideulerRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_euler_range_mean(s : PhysicsfluideulerRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_euler_range_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_euler_range_scale(s : PhysicsfluideulerRange, f : Double) -> PhysicsfluideulerRange {
  let result = physics_fluid_euler_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_euler_range_add(a : PhysicsfluideulerRange, b : PhysicsfluideulerRange) -> PhysicsfluideulerRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_euler_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_euler_range_copy(s : PhysicsfluideulerRange) -> PhysicsfluideulerRange {
  let result = physics_fluid_euler_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_euler_range_fill(s : PhysicsfluideulerRange, v : Double) -> PhysicsfluideulerRange {
  let result = physics_fluid_euler_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_range_min(s : PhysicsfluideulerRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_range_max(s : PhysicsfluideulerRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_range_to_string(s : PhysicsfluideulerRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluideulerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_euler_slice_make(size : Int) -> PhysicsfluideulerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_euler_slice_len(s : PhysicsfluideulerSlice) -> Int { s.size }

pub fn physics_fluid_euler_slice_get(s : PhysicsfluideulerSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_euler_slice_set(s : PhysicsfluideulerSlice, i : Int, v : Double) -> PhysicsfluideulerSlice {
  let result = physics_fluid_euler_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_slice_sum(s : PhysicsfluideulerSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_euler_slice_mean(s : PhysicsfluideulerSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_euler_slice_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_euler_slice_scale(s : PhysicsfluideulerSlice, f : Double) -> PhysicsfluideulerSlice {
  let result = physics_fluid_euler_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_euler_slice_add(a : PhysicsfluideulerSlice, b : PhysicsfluideulerSlice) -> PhysicsfluideulerSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_euler_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_euler_slice_copy(s : PhysicsfluideulerSlice) -> PhysicsfluideulerSlice {
  let result = physics_fluid_euler_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_euler_slice_fill(s : PhysicsfluideulerSlice, v : Double) -> PhysicsfluideulerSlice {
  let result = physics_fluid_euler_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_euler_slice_min(s : PhysicsfluideulerSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_slice_max(s : PhysicsfluideulerSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_euler_slice_to_string(s : PhysicsfluideulerSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

