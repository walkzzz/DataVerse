///===
/// extcore/physics_mechanics_joint

pub(all) struct PhysicsmechanicsjointPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_joint_make_point(x : Double, y : Double) -> PhysicsmechanicsjointPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_joint_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicsjointPoint {
  { x, y, z, label: 0 }
}

pub fn physics_mechanics_joint_point_x(pt : PhysicsmechanicsjointPoint) -> Double { pt.x }

pub fn physics_mechanics_joint_point_y(pt : PhysicsmechanicsjointPoint) -> Double { pt.y }

pub fn physics_mechanics_joint_point_z(pt : PhysicsmechanicsjointPoint) -> Double { pt.z }

pub fn physics_mechanics_joint_point_label(pt : PhysicsmechanicsjointPoint) -> Int { pt.label }

pub fn physics_mechanics_joint_point_dist(a : PhysicsmechanicsjointPoint, b : PhysicsmechanicsjointPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_mechanics_joint_point_add(a : PhysicsmechanicsjointPoint, b : PhysicsmechanicsjointPoint) -> PhysicsmechanicsjointPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_mechanics_joint_point_sub(a : PhysicsmechanicsjointPoint, b : PhysicsmechanicsjointPoint) -> PhysicsmechanicsjointPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_mechanics_joint_point_scale(pt : PhysicsmechanicsjointPoint, s : Double) -> PhysicsmechanicsjointPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_mechanics_joint_point_dot(a : PhysicsmechanicsjointPoint, b : PhysicsmechanicsjointPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_mechanics_joint_point_cross(a : PhysicsmechanicsjointPoint, b : PhysicsmechanicsjointPoint) -> PhysicsmechanicsjointPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_mechanics_joint_point_norm(pt : PhysicsmechanicsjointPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_mechanics_joint_point_normalize(pt : PhysicsmechanicsjointPoint) -> PhysicsmechanicsjointPoint {
  let n = physics_mechanics_joint_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_mechanics_joint_point_scale(pt, 1.0 / n) }
}

pub fn physics_mechanics_joint_point_negate(pt : PhysicsmechanicsjointPoint) -> PhysicsmechanicsjointPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_mechanics_joint_point_mid(a : PhysicsmechanicsjointPoint, b : PhysicsmechanicsjointPoint) -> PhysicsmechanicsjointPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_mechanics_joint_point_lerp(a : PhysicsmechanicsjointPoint, b : PhysicsmechanicsjointPoint, t : Double) -> PhysicsmechanicsjointPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_mechanics_joint_point_to_string(pt : PhysicsmechanicsjointPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_joint_make_series(vals : Array[Double], name : String) -> PhysicsmechanicsjointSeries {
  { vals, name, meta: 0 }
}

pub fn physics_mechanics_joint_series_len(s : PhysicsmechanicsjointSeries) -> Int { s.vals.length() }

pub fn physics_mechanics_joint_series_sum(s : PhysicsmechanicsjointSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_mechanics_joint_series_mean(s : PhysicsmechanicsjointSeries) -> Double {
  let n = physics_mechanics_joint_series_len(s)
  if n == 0 { 0.0 } else { physics_mechanics_joint_series_sum(s) / n.to_double() }
}

pub fn physics_mechanics_joint_series_min(s : PhysicsmechanicsjointSeries) -> Double {
  let n = physics_mechanics_joint_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_mechanics_joint_series_max(s : PhysicsmechanicsjointSeries) -> Double {
  let n = physics_mechanics_joint_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_mechanics_joint_series_range(s : PhysicsmechanicsjointSeries) -> Double {
  physics_mechanics_joint_series_max(s) - physics_mechanics_joint_series_min(s)
}

pub fn physics_mechanics_joint_series_var(s : PhysicsmechanicsjointSeries) -> Double {
  let n = physics_mechanics_joint_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_mechanics_joint_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_mechanics_joint_series_std(s : PhysicsmechanicsjointSeries) -> Double { @_common.sqrt(physics_mechanics_joint_series_var(s)) }

pub fn physics_mechanics_joint_series_median(s : PhysicsmechanicsjointSeries) -> Double {
  let n = physics_mechanics_joint_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_mechanics_joint_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_mechanics_joint_series_scale(s : PhysicsmechanicsjointSeries, f : Double) -> PhysicsmechanicsjointSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_mechanics_joint_series_add(a : PhysicsmechanicsjointSeries, b : PhysicsmechanicsjointSeries) -> PhysicsmechanicsjointSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_mechanics_joint_series_sub(a : PhysicsmechanicsjointSeries, b : PhysicsmechanicsjointSeries) -> PhysicsmechanicsjointSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_mechanics_joint_series_normalize(s : PhysicsmechanicsjointSeries) -> PhysicsmechanicsjointSeries {
  let mn = physics_mechanics_joint_series_min(s)
  let mx = physics_mechanics_joint_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_mechanics_joint_series_cumsum(s : PhysicsmechanicsjointSeries) -> PhysicsmechanicsjointSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_mechanics_joint_series_to_string(s : PhysicsmechanicsjointSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsjointMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_joint_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicsjointMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_joint_matrix_identity(n : Int) -> PhysicsmechanicsjointMatrix {
  let m = physics_mechanics_joint_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_mechanics_joint_matrix_get(m : PhysicsmechanicsjointMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_mechanics_joint_matrix_transpose(m : PhysicsmechanicsjointMatrix) -> PhysicsmechanicsjointMatrix {
  let result = physics_mechanics_joint_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_mechanics_joint_matrix_add(a : PhysicsmechanicsjointMatrix, b : PhysicsmechanicsjointMatrix) -> PhysicsmechanicsjointMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_mechanics_joint_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_mechanics_joint_matrix_scale(m : PhysicsmechanicsjointMatrix, s : Double) -> PhysicsmechanicsjointMatrix {
  let result = physics_mechanics_joint_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_mechanics_joint_matrix_multiply(a : PhysicsmechanicsjointMatrix, b : PhysicsmechanicsjointMatrix) -> PhysicsmechanicsjointMatrix {
  if a.cols != b.rows { return physics_mechanics_joint_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_mechanics_joint_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_mechanics_joint_matrix_trace(m : PhysicsmechanicsjointMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_mechanics_joint_matrix_det(m : PhysicsmechanicsjointMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_mechanics_joint_matrix_norm(m : PhysicsmechanicsjointMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_mechanics_joint_matrix_to_string(m : PhysicsmechanicsjointMatrix) -> String {
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

pub(all) struct PhysicsmechanicsjointVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_joint_make_vector(comps : Array[Double]) -> PhysicsmechanicsjointVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_joint_vector_zero(dim : Int) -> PhysicsmechanicsjointVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_mechanics_joint_vector_add(a : PhysicsmechanicsjointVector, b : PhysicsmechanicsjointVector) -> PhysicsmechanicsjointVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_joint_vector_sub(a : PhysicsmechanicsjointVector, b : PhysicsmechanicsjointVector) -> PhysicsmechanicsjointVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_joint_vector_scale(v : PhysicsmechanicsjointVector, s : Double) -> PhysicsmechanicsjointVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_mechanics_joint_vector_dot(a : PhysicsmechanicsjointVector, b : PhysicsmechanicsjointVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_mechanics_joint_vector_norm(v : PhysicsmechanicsjointVector) -> Double { @_common.sqrt(physics_mechanics_joint_vector_dot(v, v)) }

pub fn physics_mechanics_joint_vector_normalize(v : PhysicsmechanicsjointVector) -> PhysicsmechanicsjointVector {
  let n = physics_mechanics_joint_vector_norm(v)
  if n < 0.0000001 { v } else { physics_mechanics_joint_vector_scale(v, 1.0 / n) }
}

pub fn physics_mechanics_joint_vector_dist(a : PhysicsmechanicsjointVector, b : PhysicsmechanicsjointVector) -> Double {
  physics_mechanics_joint_vector_norm(physics_mechanics_joint_vector_sub(a, b))
}

pub fn physics_mechanics_joint_vector_to_string(v : PhysicsmechanicsjointVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_joint_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_mechanics_joint_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_mechanics_joint_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_mechanics_joint_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_mechanics_joint_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_mechanics_joint_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_mechanics_joint_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_mechanics_joint_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_mechanics_joint_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_mechanics_joint_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_mechanics_joint_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_mechanics_joint_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_mechanics_joint_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_mechanics_joint_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_mechanics_joint_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_mechanics_joint_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_mechanics_joint_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_mechanics_joint_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_mechanics_joint_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_mechanics_joint_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_mechanics_joint_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_mechanics_joint_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_mechanics_joint_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_mechanics_joint_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_mechanics_joint_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_mechanics_joint_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_mechanics_joint_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_mechanics_joint_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_mechanics_joint_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsmechanicsjointFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_frame_make(size : Int) -> PhysicsmechanicsjointFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_frame_len(s : PhysicsmechanicsjointFrame) -> Int { s.size }

pub fn physics_mechanics_joint_frame_get(s : PhysicsmechanicsjointFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_frame_set(s : PhysicsmechanicsjointFrame, i : Int, v : Double) -> PhysicsmechanicsjointFrame {
  let result = physics_mechanics_joint_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_frame_sum(s : PhysicsmechanicsjointFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_joint_frame_mean(s : PhysicsmechanicsjointFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_joint_frame_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_joint_frame_scale(s : PhysicsmechanicsjointFrame, f : Double) -> PhysicsmechanicsjointFrame {
  let result = physics_mechanics_joint_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_joint_frame_add(a : PhysicsmechanicsjointFrame, b : PhysicsmechanicsjointFrame) -> PhysicsmechanicsjointFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_joint_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_joint_frame_copy(s : PhysicsmechanicsjointFrame) -> PhysicsmechanicsjointFrame {
  let result = physics_mechanics_joint_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_joint_frame_fill(s : PhysicsmechanicsjointFrame, v : Double) -> PhysicsmechanicsjointFrame {
  let result = physics_mechanics_joint_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_frame_min(s : PhysicsmechanicsjointFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_frame_max(s : PhysicsmechanicsjointFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_frame_to_string(s : PhysicsmechanicsjointFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_table_make(size : Int) -> PhysicsmechanicsjointTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_table_len(s : PhysicsmechanicsjointTable) -> Int { s.size }

pub fn physics_mechanics_joint_table_get(s : PhysicsmechanicsjointTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_table_set(s : PhysicsmechanicsjointTable, i : Int, v : Double) -> PhysicsmechanicsjointTable {
  let result = physics_mechanics_joint_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_table_sum(s : PhysicsmechanicsjointTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_joint_table_mean(s : PhysicsmechanicsjointTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_joint_table_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_joint_table_scale(s : PhysicsmechanicsjointTable, f : Double) -> PhysicsmechanicsjointTable {
  let result = physics_mechanics_joint_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_joint_table_add(a : PhysicsmechanicsjointTable, b : PhysicsmechanicsjointTable) -> PhysicsmechanicsjointTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_joint_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_joint_table_copy(s : PhysicsmechanicsjointTable) -> PhysicsmechanicsjointTable {
  let result = physics_mechanics_joint_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_joint_table_fill(s : PhysicsmechanicsjointTable, v : Double) -> PhysicsmechanicsjointTable {
  let result = physics_mechanics_joint_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_table_min(s : PhysicsmechanicsjointTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_table_max(s : PhysicsmechanicsjointTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_table_to_string(s : PhysicsmechanicsjointTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_graphn_make(size : Int) -> PhysicsmechanicsjointGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_graphn_len(s : PhysicsmechanicsjointGraphN) -> Int { s.size }

pub fn physics_mechanics_joint_graphn_get(s : PhysicsmechanicsjointGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_graphn_set(s : PhysicsmechanicsjointGraphN, i : Int, v : Double) -> PhysicsmechanicsjointGraphN {
  let result = physics_mechanics_joint_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_graphn_sum(s : PhysicsmechanicsjointGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_joint_graphn_mean(s : PhysicsmechanicsjointGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_joint_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_joint_graphn_scale(s : PhysicsmechanicsjointGraphN, f : Double) -> PhysicsmechanicsjointGraphN {
  let result = physics_mechanics_joint_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_joint_graphn_add(a : PhysicsmechanicsjointGraphN, b : PhysicsmechanicsjointGraphN) -> PhysicsmechanicsjointGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_joint_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_joint_graphn_copy(s : PhysicsmechanicsjointGraphN) -> PhysicsmechanicsjointGraphN {
  let result = physics_mechanics_joint_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_joint_graphn_fill(s : PhysicsmechanicsjointGraphN, v : Double) -> PhysicsmechanicsjointGraphN {
  let result = physics_mechanics_joint_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_graphn_min(s : PhysicsmechanicsjointGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_graphn_max(s : PhysicsmechanicsjointGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_graphn_to_string(s : PhysicsmechanicsjointGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_node_make(size : Int) -> PhysicsmechanicsjointNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_node_len(s : PhysicsmechanicsjointNode) -> Int { s.size }

pub fn physics_mechanics_joint_node_get(s : PhysicsmechanicsjointNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_node_set(s : PhysicsmechanicsjointNode, i : Int, v : Double) -> PhysicsmechanicsjointNode {
  let result = physics_mechanics_joint_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_node_sum(s : PhysicsmechanicsjointNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_joint_node_mean(s : PhysicsmechanicsjointNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_joint_node_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_joint_node_scale(s : PhysicsmechanicsjointNode, f : Double) -> PhysicsmechanicsjointNode {
  let result = physics_mechanics_joint_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_joint_node_add(a : PhysicsmechanicsjointNode, b : PhysicsmechanicsjointNode) -> PhysicsmechanicsjointNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_joint_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_joint_node_copy(s : PhysicsmechanicsjointNode) -> PhysicsmechanicsjointNode {
  let result = physics_mechanics_joint_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_joint_node_fill(s : PhysicsmechanicsjointNode, v : Double) -> PhysicsmechanicsjointNode {
  let result = physics_mechanics_joint_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_node_min(s : PhysicsmechanicsjointNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_node_max(s : PhysicsmechanicsjointNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_node_to_string(s : PhysicsmechanicsjointNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_edge_make(size : Int) -> PhysicsmechanicsjointEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_edge_len(s : PhysicsmechanicsjointEdge) -> Int { s.size }

pub fn physics_mechanics_joint_edge_get(s : PhysicsmechanicsjointEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_edge_set(s : PhysicsmechanicsjointEdge, i : Int, v : Double) -> PhysicsmechanicsjointEdge {
  let result = physics_mechanics_joint_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_edge_sum(s : PhysicsmechanicsjointEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_joint_edge_mean(s : PhysicsmechanicsjointEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_joint_edge_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_joint_edge_scale(s : PhysicsmechanicsjointEdge, f : Double) -> PhysicsmechanicsjointEdge {
  let result = physics_mechanics_joint_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_joint_edge_add(a : PhysicsmechanicsjointEdge, b : PhysicsmechanicsjointEdge) -> PhysicsmechanicsjointEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_joint_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_joint_edge_copy(s : PhysicsmechanicsjointEdge) -> PhysicsmechanicsjointEdge {
  let result = physics_mechanics_joint_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_joint_edge_fill(s : PhysicsmechanicsjointEdge, v : Double) -> PhysicsmechanicsjointEdge {
  let result = physics_mechanics_joint_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_edge_min(s : PhysicsmechanicsjointEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_edge_max(s : PhysicsmechanicsjointEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_edge_to_string(s : PhysicsmechanicsjointEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_path_make(size : Int) -> PhysicsmechanicsjointPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_path_len(s : PhysicsmechanicsjointPath) -> Int { s.size }

pub fn physics_mechanics_joint_path_get(s : PhysicsmechanicsjointPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_path_set(s : PhysicsmechanicsjointPath, i : Int, v : Double) -> PhysicsmechanicsjointPath {
  let result = physics_mechanics_joint_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_path_sum(s : PhysicsmechanicsjointPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_joint_path_mean(s : PhysicsmechanicsjointPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_joint_path_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_joint_path_scale(s : PhysicsmechanicsjointPath, f : Double) -> PhysicsmechanicsjointPath {
  let result = physics_mechanics_joint_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_joint_path_add(a : PhysicsmechanicsjointPath, b : PhysicsmechanicsjointPath) -> PhysicsmechanicsjointPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_joint_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_joint_path_copy(s : PhysicsmechanicsjointPath) -> PhysicsmechanicsjointPath {
  let result = physics_mechanics_joint_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_joint_path_fill(s : PhysicsmechanicsjointPath, v : Double) -> PhysicsmechanicsjointPath {
  let result = physics_mechanics_joint_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_path_min(s : PhysicsmechanicsjointPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_path_max(s : PhysicsmechanicsjointPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_path_to_string(s : PhysicsmechanicsjointPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_cluster_make(size : Int) -> PhysicsmechanicsjointCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_cluster_len(s : PhysicsmechanicsjointCluster) -> Int { s.size }

pub fn physics_mechanics_joint_cluster_get(s : PhysicsmechanicsjointCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_cluster_set(s : PhysicsmechanicsjointCluster, i : Int, v : Double) -> PhysicsmechanicsjointCluster {
  let result = physics_mechanics_joint_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_cluster_sum(s : PhysicsmechanicsjointCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_joint_cluster_mean(s : PhysicsmechanicsjointCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_joint_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_joint_cluster_scale(s : PhysicsmechanicsjointCluster, f : Double) -> PhysicsmechanicsjointCluster {
  let result = physics_mechanics_joint_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_joint_cluster_add(a : PhysicsmechanicsjointCluster, b : PhysicsmechanicsjointCluster) -> PhysicsmechanicsjointCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_joint_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_joint_cluster_copy(s : PhysicsmechanicsjointCluster) -> PhysicsmechanicsjointCluster {
  let result = physics_mechanics_joint_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_joint_cluster_fill(s : PhysicsmechanicsjointCluster, v : Double) -> PhysicsmechanicsjointCluster {
  let result = physics_mechanics_joint_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_cluster_min(s : PhysicsmechanicsjointCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_cluster_max(s : PhysicsmechanicsjointCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_cluster_to_string(s : PhysicsmechanicsjointCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_model_make(size : Int) -> PhysicsmechanicsjointModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_model_len(s : PhysicsmechanicsjointModel) -> Int { s.size }

pub fn physics_mechanics_joint_model_get(s : PhysicsmechanicsjointModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_model_set(s : PhysicsmechanicsjointModel, i : Int, v : Double) -> PhysicsmechanicsjointModel {
  let result = physics_mechanics_joint_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_model_sum(s : PhysicsmechanicsjointModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_joint_model_mean(s : PhysicsmechanicsjointModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_joint_model_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_joint_model_scale(s : PhysicsmechanicsjointModel, f : Double) -> PhysicsmechanicsjointModel {
  let result = physics_mechanics_joint_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_joint_model_add(a : PhysicsmechanicsjointModel, b : PhysicsmechanicsjointModel) -> PhysicsmechanicsjointModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_joint_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_joint_model_copy(s : PhysicsmechanicsjointModel) -> PhysicsmechanicsjointModel {
  let result = physics_mechanics_joint_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_joint_model_fill(s : PhysicsmechanicsjointModel, v : Double) -> PhysicsmechanicsjointModel {
  let result = physics_mechanics_joint_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_model_min(s : PhysicsmechanicsjointModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_model_max(s : PhysicsmechanicsjointModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_model_to_string(s : PhysicsmechanicsjointModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_layer_make(size : Int) -> PhysicsmechanicsjointLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_layer_len(s : PhysicsmechanicsjointLayer) -> Int { s.size }

pub fn physics_mechanics_joint_layer_get(s : PhysicsmechanicsjointLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_layer_set(s : PhysicsmechanicsjointLayer, i : Int, v : Double) -> PhysicsmechanicsjointLayer {
  let result = physics_mechanics_joint_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_layer_sum(s : PhysicsmechanicsjointLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_joint_layer_mean(s : PhysicsmechanicsjointLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_joint_layer_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_joint_layer_scale(s : PhysicsmechanicsjointLayer, f : Double) -> PhysicsmechanicsjointLayer {
  let result = physics_mechanics_joint_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_joint_layer_add(a : PhysicsmechanicsjointLayer, b : PhysicsmechanicsjointLayer) -> PhysicsmechanicsjointLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_joint_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_joint_layer_copy(s : PhysicsmechanicsjointLayer) -> PhysicsmechanicsjointLayer {
  let result = physics_mechanics_joint_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_joint_layer_fill(s : PhysicsmechanicsjointLayer, v : Double) -> PhysicsmechanicsjointLayer {
  let result = physics_mechanics_joint_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_layer_min(s : PhysicsmechanicsjointLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_layer_max(s : PhysicsmechanicsjointLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_layer_to_string(s : PhysicsmechanicsjointLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_buffer_make(size : Int) -> PhysicsmechanicsjointBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_buffer_len(s : PhysicsmechanicsjointBuffer) -> Int { s.size }

pub fn physics_mechanics_joint_buffer_get(s : PhysicsmechanicsjointBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_buffer_set(s : PhysicsmechanicsjointBuffer, i : Int, v : Double) -> PhysicsmechanicsjointBuffer {
  let result = physics_mechanics_joint_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_buffer_sum(s : PhysicsmechanicsjointBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_joint_buffer_mean(s : PhysicsmechanicsjointBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_joint_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_joint_buffer_scale(s : PhysicsmechanicsjointBuffer, f : Double) -> PhysicsmechanicsjointBuffer {
  let result = physics_mechanics_joint_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_joint_buffer_add(a : PhysicsmechanicsjointBuffer, b : PhysicsmechanicsjointBuffer) -> PhysicsmechanicsjointBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_joint_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_joint_buffer_copy(s : PhysicsmechanicsjointBuffer) -> PhysicsmechanicsjointBuffer {
  let result = physics_mechanics_joint_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_joint_buffer_fill(s : PhysicsmechanicsjointBuffer, v : Double) -> PhysicsmechanicsjointBuffer {
  let result = physics_mechanics_joint_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_buffer_min(s : PhysicsmechanicsjointBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_buffer_max(s : PhysicsmechanicsjointBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_buffer_to_string(s : PhysicsmechanicsjointBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_cursor_make(size : Int) -> PhysicsmechanicsjointCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_cursor_len(s : PhysicsmechanicsjointCursor) -> Int { s.size }

pub fn physics_mechanics_joint_cursor_get(s : PhysicsmechanicsjointCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_cursor_set(s : PhysicsmechanicsjointCursor, i : Int, v : Double) -> PhysicsmechanicsjointCursor {
  let result = physics_mechanics_joint_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_cursor_sum(s : PhysicsmechanicsjointCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_joint_cursor_mean(s : PhysicsmechanicsjointCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_joint_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_joint_cursor_scale(s : PhysicsmechanicsjointCursor, f : Double) -> PhysicsmechanicsjointCursor {
  let result = physics_mechanics_joint_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_joint_cursor_add(a : PhysicsmechanicsjointCursor, b : PhysicsmechanicsjointCursor) -> PhysicsmechanicsjointCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_joint_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_joint_cursor_copy(s : PhysicsmechanicsjointCursor) -> PhysicsmechanicsjointCursor {
  let result = physics_mechanics_joint_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_joint_cursor_fill(s : PhysicsmechanicsjointCursor, v : Double) -> PhysicsmechanicsjointCursor {
  let result = physics_mechanics_joint_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_cursor_min(s : PhysicsmechanicsjointCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_cursor_max(s : PhysicsmechanicsjointCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_cursor_to_string(s : PhysicsmechanicsjointCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_view_make(size : Int) -> PhysicsmechanicsjointView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_view_len(s : PhysicsmechanicsjointView) -> Int { s.size }

pub fn physics_mechanics_joint_view_get(s : PhysicsmechanicsjointView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_view_set(s : PhysicsmechanicsjointView, i : Int, v : Double) -> PhysicsmechanicsjointView {
  let result = physics_mechanics_joint_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_view_sum(s : PhysicsmechanicsjointView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_joint_view_mean(s : PhysicsmechanicsjointView) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_joint_view_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_joint_view_scale(s : PhysicsmechanicsjointView, f : Double) -> PhysicsmechanicsjointView {
  let result = physics_mechanics_joint_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_joint_view_add(a : PhysicsmechanicsjointView, b : PhysicsmechanicsjointView) -> PhysicsmechanicsjointView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_joint_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_joint_view_copy(s : PhysicsmechanicsjointView) -> PhysicsmechanicsjointView {
  let result = physics_mechanics_joint_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_joint_view_fill(s : PhysicsmechanicsjointView, v : Double) -> PhysicsmechanicsjointView {
  let result = physics_mechanics_joint_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_view_min(s : PhysicsmechanicsjointView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_view_max(s : PhysicsmechanicsjointView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_view_to_string(s : PhysicsmechanicsjointView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_range_make(size : Int) -> PhysicsmechanicsjointRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_range_len(s : PhysicsmechanicsjointRange) -> Int { s.size }

pub fn physics_mechanics_joint_range_get(s : PhysicsmechanicsjointRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_range_set(s : PhysicsmechanicsjointRange, i : Int, v : Double) -> PhysicsmechanicsjointRange {
  let result = physics_mechanics_joint_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_range_sum(s : PhysicsmechanicsjointRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_joint_range_mean(s : PhysicsmechanicsjointRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_joint_range_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_joint_range_scale(s : PhysicsmechanicsjointRange, f : Double) -> PhysicsmechanicsjointRange {
  let result = physics_mechanics_joint_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_joint_range_add(a : PhysicsmechanicsjointRange, b : PhysicsmechanicsjointRange) -> PhysicsmechanicsjointRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_joint_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_joint_range_copy(s : PhysicsmechanicsjointRange) -> PhysicsmechanicsjointRange {
  let result = physics_mechanics_joint_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_joint_range_fill(s : PhysicsmechanicsjointRange, v : Double) -> PhysicsmechanicsjointRange {
  let result = physics_mechanics_joint_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_range_min(s : PhysicsmechanicsjointRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_range_max(s : PhysicsmechanicsjointRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_range_to_string(s : PhysicsmechanicsjointRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsjointSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_joint_slice_make(size : Int) -> PhysicsmechanicsjointSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_joint_slice_len(s : PhysicsmechanicsjointSlice) -> Int { s.size }

pub fn physics_mechanics_joint_slice_get(s : PhysicsmechanicsjointSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_joint_slice_set(s : PhysicsmechanicsjointSlice, i : Int, v : Double) -> PhysicsmechanicsjointSlice {
  let result = physics_mechanics_joint_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_slice_sum(s : PhysicsmechanicsjointSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_joint_slice_mean(s : PhysicsmechanicsjointSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_joint_slice_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_joint_slice_scale(s : PhysicsmechanicsjointSlice, f : Double) -> PhysicsmechanicsjointSlice {
  let result = physics_mechanics_joint_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_joint_slice_add(a : PhysicsmechanicsjointSlice, b : PhysicsmechanicsjointSlice) -> PhysicsmechanicsjointSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_joint_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_joint_slice_copy(s : PhysicsmechanicsjointSlice) -> PhysicsmechanicsjointSlice {
  let result = physics_mechanics_joint_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_joint_slice_fill(s : PhysicsmechanicsjointSlice, v : Double) -> PhysicsmechanicsjointSlice {
  let result = physics_mechanics_joint_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_joint_slice_min(s : PhysicsmechanicsjointSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_slice_max(s : PhysicsmechanicsjointSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_joint_slice_to_string(s : PhysicsmechanicsjointSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

