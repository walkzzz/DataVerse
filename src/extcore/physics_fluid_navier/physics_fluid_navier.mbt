///===
/// extcore/physics_fluid_navier

pub(all) struct PhysicsfluidnavierPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_navier_make_point(x : Double, y : Double) -> PhysicsfluidnavierPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_navier_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidnavierPoint {
  { x, y, z, label: 0 }
}

pub fn physics_fluid_navier_point_x(pt : PhysicsfluidnavierPoint) -> Double { pt.x }

pub fn physics_fluid_navier_point_y(pt : PhysicsfluidnavierPoint) -> Double { pt.y }

pub fn physics_fluid_navier_point_z(pt : PhysicsfluidnavierPoint) -> Double { pt.z }

pub fn physics_fluid_navier_point_label(pt : PhysicsfluidnavierPoint) -> Int { pt.label }

pub fn physics_fluid_navier_point_dist(a : PhysicsfluidnavierPoint, b : PhysicsfluidnavierPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_fluid_navier_point_add(a : PhysicsfluidnavierPoint, b : PhysicsfluidnavierPoint) -> PhysicsfluidnavierPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_fluid_navier_point_sub(a : PhysicsfluidnavierPoint, b : PhysicsfluidnavierPoint) -> PhysicsfluidnavierPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_fluid_navier_point_scale(pt : PhysicsfluidnavierPoint, s : Double) -> PhysicsfluidnavierPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_fluid_navier_point_dot(a : PhysicsfluidnavierPoint, b : PhysicsfluidnavierPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_fluid_navier_point_cross(a : PhysicsfluidnavierPoint, b : PhysicsfluidnavierPoint) -> PhysicsfluidnavierPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_fluid_navier_point_norm(pt : PhysicsfluidnavierPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_fluid_navier_point_normalize(pt : PhysicsfluidnavierPoint) -> PhysicsfluidnavierPoint {
  let n = physics_fluid_navier_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_fluid_navier_point_scale(pt, 1.0 / n) }
}

pub fn physics_fluid_navier_point_negate(pt : PhysicsfluidnavierPoint) -> PhysicsfluidnavierPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_fluid_navier_point_mid(a : PhysicsfluidnavierPoint, b : PhysicsfluidnavierPoint) -> PhysicsfluidnavierPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_fluid_navier_point_lerp(a : PhysicsfluidnavierPoint, b : PhysicsfluidnavierPoint, t : Double) -> PhysicsfluidnavierPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_fluid_navier_point_to_string(pt : PhysicsfluidnavierPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_navier_make_series(vals : Array[Double], name : String) -> PhysicsfluidnavierSeries {
  { vals, name, meta: 0 }
}

pub fn physics_fluid_navier_series_len(s : PhysicsfluidnavierSeries) -> Int { s.vals.length() }

pub fn physics_fluid_navier_series_sum(s : PhysicsfluidnavierSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_fluid_navier_series_mean(s : PhysicsfluidnavierSeries) -> Double {
  let n = physics_fluid_navier_series_len(s)
  if n == 0 { 0.0 } else { physics_fluid_navier_series_sum(s) / n.to_double() }
}

pub fn physics_fluid_navier_series_min(s : PhysicsfluidnavierSeries) -> Double {
  let n = physics_fluid_navier_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_fluid_navier_series_max(s : PhysicsfluidnavierSeries) -> Double {
  let n = physics_fluid_navier_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_fluid_navier_series_range(s : PhysicsfluidnavierSeries) -> Double {
  physics_fluid_navier_series_max(s) - physics_fluid_navier_series_min(s)
}

pub fn physics_fluid_navier_series_var(s : PhysicsfluidnavierSeries) -> Double {
  let n = physics_fluid_navier_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_fluid_navier_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_fluid_navier_series_std(s : PhysicsfluidnavierSeries) -> Double { @_common.sqrt(physics_fluid_navier_series_var(s)) }

pub fn physics_fluid_navier_series_median(s : PhysicsfluidnavierSeries) -> Double {
  let n = physics_fluid_navier_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_fluid_navier_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_fluid_navier_series_scale(s : PhysicsfluidnavierSeries, f : Double) -> PhysicsfluidnavierSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_fluid_navier_series_add(a : PhysicsfluidnavierSeries, b : PhysicsfluidnavierSeries) -> PhysicsfluidnavierSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_fluid_navier_series_sub(a : PhysicsfluidnavierSeries, b : PhysicsfluidnavierSeries) -> PhysicsfluidnavierSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_fluid_navier_series_normalize(s : PhysicsfluidnavierSeries) -> PhysicsfluidnavierSeries {
  let mn = physics_fluid_navier_series_min(s)
  let mx = physics_fluid_navier_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_fluid_navier_series_cumsum(s : PhysicsfluidnavierSeries) -> PhysicsfluidnavierSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_fluid_navier_series_to_string(s : PhysicsfluidnavierSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidnavierMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_navier_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidnavierMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_navier_matrix_identity(n : Int) -> PhysicsfluidnavierMatrix {
  let m = physics_fluid_navier_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_fluid_navier_matrix_get(m : PhysicsfluidnavierMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_fluid_navier_matrix_transpose(m : PhysicsfluidnavierMatrix) -> PhysicsfluidnavierMatrix {
  let result = physics_fluid_navier_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_fluid_navier_matrix_add(a : PhysicsfluidnavierMatrix, b : PhysicsfluidnavierMatrix) -> PhysicsfluidnavierMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_fluid_navier_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_fluid_navier_matrix_scale(m : PhysicsfluidnavierMatrix, s : Double) -> PhysicsfluidnavierMatrix {
  let result = physics_fluid_navier_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_fluid_navier_matrix_multiply(a : PhysicsfluidnavierMatrix, b : PhysicsfluidnavierMatrix) -> PhysicsfluidnavierMatrix {
  if a.cols != b.rows { return physics_fluid_navier_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_fluid_navier_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_fluid_navier_matrix_trace(m : PhysicsfluidnavierMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_fluid_navier_matrix_det(m : PhysicsfluidnavierMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_fluid_navier_matrix_norm(m : PhysicsfluidnavierMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_fluid_navier_matrix_to_string(m : PhysicsfluidnavierMatrix) -> String {
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

pub(all) struct PhysicsfluidnavierVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_navier_make_vector(comps : Array[Double]) -> PhysicsfluidnavierVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_navier_vector_zero(dim : Int) -> PhysicsfluidnavierVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_fluid_navier_vector_add(a : PhysicsfluidnavierVector, b : PhysicsfluidnavierVector) -> PhysicsfluidnavierVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_navier_vector_sub(a : PhysicsfluidnavierVector, b : PhysicsfluidnavierVector) -> PhysicsfluidnavierVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_navier_vector_scale(v : PhysicsfluidnavierVector, s : Double) -> PhysicsfluidnavierVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_fluid_navier_vector_dot(a : PhysicsfluidnavierVector, b : PhysicsfluidnavierVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_fluid_navier_vector_norm(v : PhysicsfluidnavierVector) -> Double { @_common.sqrt(physics_fluid_navier_vector_dot(v, v)) }

pub fn physics_fluid_navier_vector_normalize(v : PhysicsfluidnavierVector) -> PhysicsfluidnavierVector {
  let n = physics_fluid_navier_vector_norm(v)
  if n < 0.0000001 { v } else { physics_fluid_navier_vector_scale(v, 1.0 / n) }
}

pub fn physics_fluid_navier_vector_dist(a : PhysicsfluidnavierVector, b : PhysicsfluidnavierVector) -> Double {
  physics_fluid_navier_vector_norm(physics_fluid_navier_vector_sub(a, b))
}

pub fn physics_fluid_navier_vector_to_string(v : PhysicsfluidnavierVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_navier_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_fluid_navier_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_fluid_navier_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_fluid_navier_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_fluid_navier_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_fluid_navier_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_fluid_navier_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_fluid_navier_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_fluid_navier_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_fluid_navier_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_fluid_navier_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_fluid_navier_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_fluid_navier_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_fluid_navier_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_fluid_navier_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_fluid_navier_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_fluid_navier_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_fluid_navier_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_fluid_navier_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_fluid_navier_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_fluid_navier_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_fluid_navier_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_fluid_navier_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_fluid_navier_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_fluid_navier_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_fluid_navier_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_fluid_navier_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_fluid_navier_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_fluid_navier_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsfluidnavierFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_frame_make(size : Int) -> PhysicsfluidnavierFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_frame_len(s : PhysicsfluidnavierFrame) -> Int { s.size }

pub fn physics_fluid_navier_frame_get(s : PhysicsfluidnavierFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_frame_set(s : PhysicsfluidnavierFrame, i : Int, v : Double) -> PhysicsfluidnavierFrame {
  let result = physics_fluid_navier_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_frame_sum(s : PhysicsfluidnavierFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_navier_frame_mean(s : PhysicsfluidnavierFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_navier_frame_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_navier_frame_scale(s : PhysicsfluidnavierFrame, f : Double) -> PhysicsfluidnavierFrame {
  let result = physics_fluid_navier_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_navier_frame_add(a : PhysicsfluidnavierFrame, b : PhysicsfluidnavierFrame) -> PhysicsfluidnavierFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_navier_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_navier_frame_copy(s : PhysicsfluidnavierFrame) -> PhysicsfluidnavierFrame {
  let result = physics_fluid_navier_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_navier_frame_fill(s : PhysicsfluidnavierFrame, v : Double) -> PhysicsfluidnavierFrame {
  let result = physics_fluid_navier_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_frame_min(s : PhysicsfluidnavierFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_frame_max(s : PhysicsfluidnavierFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_frame_to_string(s : PhysicsfluidnavierFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_table_make(size : Int) -> PhysicsfluidnavierTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_table_len(s : PhysicsfluidnavierTable) -> Int { s.size }

pub fn physics_fluid_navier_table_get(s : PhysicsfluidnavierTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_table_set(s : PhysicsfluidnavierTable, i : Int, v : Double) -> PhysicsfluidnavierTable {
  let result = physics_fluid_navier_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_table_sum(s : PhysicsfluidnavierTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_navier_table_mean(s : PhysicsfluidnavierTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_navier_table_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_navier_table_scale(s : PhysicsfluidnavierTable, f : Double) -> PhysicsfluidnavierTable {
  let result = physics_fluid_navier_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_navier_table_add(a : PhysicsfluidnavierTable, b : PhysicsfluidnavierTable) -> PhysicsfluidnavierTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_navier_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_navier_table_copy(s : PhysicsfluidnavierTable) -> PhysicsfluidnavierTable {
  let result = physics_fluid_navier_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_navier_table_fill(s : PhysicsfluidnavierTable, v : Double) -> PhysicsfluidnavierTable {
  let result = physics_fluid_navier_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_table_min(s : PhysicsfluidnavierTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_table_max(s : PhysicsfluidnavierTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_table_to_string(s : PhysicsfluidnavierTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_graphn_make(size : Int) -> PhysicsfluidnavierGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_graphn_len(s : PhysicsfluidnavierGraphN) -> Int { s.size }

pub fn physics_fluid_navier_graphn_get(s : PhysicsfluidnavierGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_graphn_set(s : PhysicsfluidnavierGraphN, i : Int, v : Double) -> PhysicsfluidnavierGraphN {
  let result = physics_fluid_navier_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_graphn_sum(s : PhysicsfluidnavierGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_navier_graphn_mean(s : PhysicsfluidnavierGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_navier_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_navier_graphn_scale(s : PhysicsfluidnavierGraphN, f : Double) -> PhysicsfluidnavierGraphN {
  let result = physics_fluid_navier_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_navier_graphn_add(a : PhysicsfluidnavierGraphN, b : PhysicsfluidnavierGraphN) -> PhysicsfluidnavierGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_navier_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_navier_graphn_copy(s : PhysicsfluidnavierGraphN) -> PhysicsfluidnavierGraphN {
  let result = physics_fluid_navier_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_navier_graphn_fill(s : PhysicsfluidnavierGraphN, v : Double) -> PhysicsfluidnavierGraphN {
  let result = physics_fluid_navier_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_graphn_min(s : PhysicsfluidnavierGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_graphn_max(s : PhysicsfluidnavierGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_graphn_to_string(s : PhysicsfluidnavierGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_node_make(size : Int) -> PhysicsfluidnavierNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_node_len(s : PhysicsfluidnavierNode) -> Int { s.size }

pub fn physics_fluid_navier_node_get(s : PhysicsfluidnavierNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_node_set(s : PhysicsfluidnavierNode, i : Int, v : Double) -> PhysicsfluidnavierNode {
  let result = physics_fluid_navier_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_node_sum(s : PhysicsfluidnavierNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_navier_node_mean(s : PhysicsfluidnavierNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_navier_node_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_navier_node_scale(s : PhysicsfluidnavierNode, f : Double) -> PhysicsfluidnavierNode {
  let result = physics_fluid_navier_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_navier_node_add(a : PhysicsfluidnavierNode, b : PhysicsfluidnavierNode) -> PhysicsfluidnavierNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_navier_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_navier_node_copy(s : PhysicsfluidnavierNode) -> PhysicsfluidnavierNode {
  let result = physics_fluid_navier_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_navier_node_fill(s : PhysicsfluidnavierNode, v : Double) -> PhysicsfluidnavierNode {
  let result = physics_fluid_navier_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_node_min(s : PhysicsfluidnavierNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_node_max(s : PhysicsfluidnavierNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_node_to_string(s : PhysicsfluidnavierNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_edge_make(size : Int) -> PhysicsfluidnavierEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_edge_len(s : PhysicsfluidnavierEdge) -> Int { s.size }

pub fn physics_fluid_navier_edge_get(s : PhysicsfluidnavierEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_edge_set(s : PhysicsfluidnavierEdge, i : Int, v : Double) -> PhysicsfluidnavierEdge {
  let result = physics_fluid_navier_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_edge_sum(s : PhysicsfluidnavierEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_navier_edge_mean(s : PhysicsfluidnavierEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_navier_edge_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_navier_edge_scale(s : PhysicsfluidnavierEdge, f : Double) -> PhysicsfluidnavierEdge {
  let result = physics_fluid_navier_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_navier_edge_add(a : PhysicsfluidnavierEdge, b : PhysicsfluidnavierEdge) -> PhysicsfluidnavierEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_navier_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_navier_edge_copy(s : PhysicsfluidnavierEdge) -> PhysicsfluidnavierEdge {
  let result = physics_fluid_navier_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_navier_edge_fill(s : PhysicsfluidnavierEdge, v : Double) -> PhysicsfluidnavierEdge {
  let result = physics_fluid_navier_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_edge_min(s : PhysicsfluidnavierEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_edge_max(s : PhysicsfluidnavierEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_edge_to_string(s : PhysicsfluidnavierEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_path_make(size : Int) -> PhysicsfluidnavierPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_path_len(s : PhysicsfluidnavierPath) -> Int { s.size }

pub fn physics_fluid_navier_path_get(s : PhysicsfluidnavierPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_path_set(s : PhysicsfluidnavierPath, i : Int, v : Double) -> PhysicsfluidnavierPath {
  let result = physics_fluid_navier_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_path_sum(s : PhysicsfluidnavierPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_navier_path_mean(s : PhysicsfluidnavierPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_navier_path_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_navier_path_scale(s : PhysicsfluidnavierPath, f : Double) -> PhysicsfluidnavierPath {
  let result = physics_fluid_navier_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_navier_path_add(a : PhysicsfluidnavierPath, b : PhysicsfluidnavierPath) -> PhysicsfluidnavierPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_navier_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_navier_path_copy(s : PhysicsfluidnavierPath) -> PhysicsfluidnavierPath {
  let result = physics_fluid_navier_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_navier_path_fill(s : PhysicsfluidnavierPath, v : Double) -> PhysicsfluidnavierPath {
  let result = physics_fluid_navier_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_path_min(s : PhysicsfluidnavierPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_path_max(s : PhysicsfluidnavierPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_path_to_string(s : PhysicsfluidnavierPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_cluster_make(size : Int) -> PhysicsfluidnavierCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_cluster_len(s : PhysicsfluidnavierCluster) -> Int { s.size }

pub fn physics_fluid_navier_cluster_get(s : PhysicsfluidnavierCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_cluster_set(s : PhysicsfluidnavierCluster, i : Int, v : Double) -> PhysicsfluidnavierCluster {
  let result = physics_fluid_navier_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_cluster_sum(s : PhysicsfluidnavierCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_navier_cluster_mean(s : PhysicsfluidnavierCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_navier_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_navier_cluster_scale(s : PhysicsfluidnavierCluster, f : Double) -> PhysicsfluidnavierCluster {
  let result = physics_fluid_navier_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_navier_cluster_add(a : PhysicsfluidnavierCluster, b : PhysicsfluidnavierCluster) -> PhysicsfluidnavierCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_navier_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_navier_cluster_copy(s : PhysicsfluidnavierCluster) -> PhysicsfluidnavierCluster {
  let result = physics_fluid_navier_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_navier_cluster_fill(s : PhysicsfluidnavierCluster, v : Double) -> PhysicsfluidnavierCluster {
  let result = physics_fluid_navier_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_cluster_min(s : PhysicsfluidnavierCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_cluster_max(s : PhysicsfluidnavierCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_cluster_to_string(s : PhysicsfluidnavierCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_model_make(size : Int) -> PhysicsfluidnavierModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_model_len(s : PhysicsfluidnavierModel) -> Int { s.size }

pub fn physics_fluid_navier_model_get(s : PhysicsfluidnavierModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_model_set(s : PhysicsfluidnavierModel, i : Int, v : Double) -> PhysicsfluidnavierModel {
  let result = physics_fluid_navier_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_model_sum(s : PhysicsfluidnavierModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_navier_model_mean(s : PhysicsfluidnavierModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_navier_model_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_navier_model_scale(s : PhysicsfluidnavierModel, f : Double) -> PhysicsfluidnavierModel {
  let result = physics_fluid_navier_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_navier_model_add(a : PhysicsfluidnavierModel, b : PhysicsfluidnavierModel) -> PhysicsfluidnavierModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_navier_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_navier_model_copy(s : PhysicsfluidnavierModel) -> PhysicsfluidnavierModel {
  let result = physics_fluid_navier_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_navier_model_fill(s : PhysicsfluidnavierModel, v : Double) -> PhysicsfluidnavierModel {
  let result = physics_fluid_navier_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_model_min(s : PhysicsfluidnavierModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_model_max(s : PhysicsfluidnavierModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_model_to_string(s : PhysicsfluidnavierModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_layer_make(size : Int) -> PhysicsfluidnavierLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_layer_len(s : PhysicsfluidnavierLayer) -> Int { s.size }

pub fn physics_fluid_navier_layer_get(s : PhysicsfluidnavierLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_layer_set(s : PhysicsfluidnavierLayer, i : Int, v : Double) -> PhysicsfluidnavierLayer {
  let result = physics_fluid_navier_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_layer_sum(s : PhysicsfluidnavierLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_navier_layer_mean(s : PhysicsfluidnavierLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_navier_layer_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_navier_layer_scale(s : PhysicsfluidnavierLayer, f : Double) -> PhysicsfluidnavierLayer {
  let result = physics_fluid_navier_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_navier_layer_add(a : PhysicsfluidnavierLayer, b : PhysicsfluidnavierLayer) -> PhysicsfluidnavierLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_navier_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_navier_layer_copy(s : PhysicsfluidnavierLayer) -> PhysicsfluidnavierLayer {
  let result = physics_fluid_navier_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_navier_layer_fill(s : PhysicsfluidnavierLayer, v : Double) -> PhysicsfluidnavierLayer {
  let result = physics_fluid_navier_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_layer_min(s : PhysicsfluidnavierLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_layer_max(s : PhysicsfluidnavierLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_layer_to_string(s : PhysicsfluidnavierLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_buffer_make(size : Int) -> PhysicsfluidnavierBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_buffer_len(s : PhysicsfluidnavierBuffer) -> Int { s.size }

pub fn physics_fluid_navier_buffer_get(s : PhysicsfluidnavierBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_buffer_set(s : PhysicsfluidnavierBuffer, i : Int, v : Double) -> PhysicsfluidnavierBuffer {
  let result = physics_fluid_navier_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_buffer_sum(s : PhysicsfluidnavierBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_navier_buffer_mean(s : PhysicsfluidnavierBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_navier_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_navier_buffer_scale(s : PhysicsfluidnavierBuffer, f : Double) -> PhysicsfluidnavierBuffer {
  let result = physics_fluid_navier_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_navier_buffer_add(a : PhysicsfluidnavierBuffer, b : PhysicsfluidnavierBuffer) -> PhysicsfluidnavierBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_navier_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_navier_buffer_copy(s : PhysicsfluidnavierBuffer) -> PhysicsfluidnavierBuffer {
  let result = physics_fluid_navier_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_navier_buffer_fill(s : PhysicsfluidnavierBuffer, v : Double) -> PhysicsfluidnavierBuffer {
  let result = physics_fluid_navier_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_buffer_min(s : PhysicsfluidnavierBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_buffer_max(s : PhysicsfluidnavierBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_buffer_to_string(s : PhysicsfluidnavierBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_cursor_make(size : Int) -> PhysicsfluidnavierCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_cursor_len(s : PhysicsfluidnavierCursor) -> Int { s.size }

pub fn physics_fluid_navier_cursor_get(s : PhysicsfluidnavierCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_cursor_set(s : PhysicsfluidnavierCursor, i : Int, v : Double) -> PhysicsfluidnavierCursor {
  let result = physics_fluid_navier_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_cursor_sum(s : PhysicsfluidnavierCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_navier_cursor_mean(s : PhysicsfluidnavierCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_navier_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_navier_cursor_scale(s : PhysicsfluidnavierCursor, f : Double) -> PhysicsfluidnavierCursor {
  let result = physics_fluid_navier_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_navier_cursor_add(a : PhysicsfluidnavierCursor, b : PhysicsfluidnavierCursor) -> PhysicsfluidnavierCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_navier_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_navier_cursor_copy(s : PhysicsfluidnavierCursor) -> PhysicsfluidnavierCursor {
  let result = physics_fluid_navier_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_navier_cursor_fill(s : PhysicsfluidnavierCursor, v : Double) -> PhysicsfluidnavierCursor {
  let result = physics_fluid_navier_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_cursor_min(s : PhysicsfluidnavierCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_cursor_max(s : PhysicsfluidnavierCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_cursor_to_string(s : PhysicsfluidnavierCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_view_make(size : Int) -> PhysicsfluidnavierView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_view_len(s : PhysicsfluidnavierView) -> Int { s.size }

pub fn physics_fluid_navier_view_get(s : PhysicsfluidnavierView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_view_set(s : PhysicsfluidnavierView, i : Int, v : Double) -> PhysicsfluidnavierView {
  let result = physics_fluid_navier_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_view_sum(s : PhysicsfluidnavierView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_navier_view_mean(s : PhysicsfluidnavierView) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_navier_view_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_navier_view_scale(s : PhysicsfluidnavierView, f : Double) -> PhysicsfluidnavierView {
  let result = physics_fluid_navier_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_navier_view_add(a : PhysicsfluidnavierView, b : PhysicsfluidnavierView) -> PhysicsfluidnavierView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_navier_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_navier_view_copy(s : PhysicsfluidnavierView) -> PhysicsfluidnavierView {
  let result = physics_fluid_navier_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_navier_view_fill(s : PhysicsfluidnavierView, v : Double) -> PhysicsfluidnavierView {
  let result = physics_fluid_navier_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_view_min(s : PhysicsfluidnavierView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_view_max(s : PhysicsfluidnavierView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_view_to_string(s : PhysicsfluidnavierView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_range_make(size : Int) -> PhysicsfluidnavierRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_range_len(s : PhysicsfluidnavierRange) -> Int { s.size }

pub fn physics_fluid_navier_range_get(s : PhysicsfluidnavierRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_range_set(s : PhysicsfluidnavierRange, i : Int, v : Double) -> PhysicsfluidnavierRange {
  let result = physics_fluid_navier_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_range_sum(s : PhysicsfluidnavierRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_navier_range_mean(s : PhysicsfluidnavierRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_navier_range_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_navier_range_scale(s : PhysicsfluidnavierRange, f : Double) -> PhysicsfluidnavierRange {
  let result = physics_fluid_navier_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_navier_range_add(a : PhysicsfluidnavierRange, b : PhysicsfluidnavierRange) -> PhysicsfluidnavierRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_navier_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_navier_range_copy(s : PhysicsfluidnavierRange) -> PhysicsfluidnavierRange {
  let result = physics_fluid_navier_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_navier_range_fill(s : PhysicsfluidnavierRange, v : Double) -> PhysicsfluidnavierRange {
  let result = physics_fluid_navier_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_range_min(s : PhysicsfluidnavierRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_range_max(s : PhysicsfluidnavierRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_range_to_string(s : PhysicsfluidnavierRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidnavierSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_navier_slice_make(size : Int) -> PhysicsfluidnavierSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_navier_slice_len(s : PhysicsfluidnavierSlice) -> Int { s.size }

pub fn physics_fluid_navier_slice_get(s : PhysicsfluidnavierSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_navier_slice_set(s : PhysicsfluidnavierSlice, i : Int, v : Double) -> PhysicsfluidnavierSlice {
  let result = physics_fluid_navier_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_slice_sum(s : PhysicsfluidnavierSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_fluid_navier_slice_mean(s : PhysicsfluidnavierSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_fluid_navier_slice_sum(s) / s.size.to_double() }
}

pub fn physics_fluid_navier_slice_scale(s : PhysicsfluidnavierSlice, f : Double) -> PhysicsfluidnavierSlice {
  let result = physics_fluid_navier_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_fluid_navier_slice_add(a : PhysicsfluidnavierSlice, b : PhysicsfluidnavierSlice) -> PhysicsfluidnavierSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_fluid_navier_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_fluid_navier_slice_copy(s : PhysicsfluidnavierSlice) -> PhysicsfluidnavierSlice {
  let result = physics_fluid_navier_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_fluid_navier_slice_fill(s : PhysicsfluidnavierSlice, v : Double) -> PhysicsfluidnavierSlice {
  let result = physics_fluid_navier_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_navier_slice_min(s : PhysicsfluidnavierSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_slice_max(s : PhysicsfluidnavierSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_fluid_navier_slice_to_string(s : PhysicsfluidnavierSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

