///===
/// extcore/physics_em_high_freq

pub(all) struct PhysicsemhighfreqPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_high_freq_make_point(x : Double, y : Double) -> PhysicsemhighfreqPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_high_freq_make_point3(x : Double, y : Double, z : Double) -> PhysicsemhighfreqPoint {
  { x, y, z, label: 0 }
}

pub fn physics_em_high_freq_point_x(pt : PhysicsemhighfreqPoint) -> Double { pt.x }

pub fn physics_em_high_freq_point_y(pt : PhysicsemhighfreqPoint) -> Double { pt.y }

pub fn physics_em_high_freq_point_z(pt : PhysicsemhighfreqPoint) -> Double { pt.z }

pub fn physics_em_high_freq_point_label(pt : PhysicsemhighfreqPoint) -> Int { pt.label }

pub fn physics_em_high_freq_point_dist(a : PhysicsemhighfreqPoint, b : PhysicsemhighfreqPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_em_high_freq_point_add(a : PhysicsemhighfreqPoint, b : PhysicsemhighfreqPoint) -> PhysicsemhighfreqPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_em_high_freq_point_sub(a : PhysicsemhighfreqPoint, b : PhysicsemhighfreqPoint) -> PhysicsemhighfreqPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_em_high_freq_point_scale(pt : PhysicsemhighfreqPoint, s : Double) -> PhysicsemhighfreqPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_em_high_freq_point_dot(a : PhysicsemhighfreqPoint, b : PhysicsemhighfreqPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_em_high_freq_point_cross(a : PhysicsemhighfreqPoint, b : PhysicsemhighfreqPoint) -> PhysicsemhighfreqPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_em_high_freq_point_norm(pt : PhysicsemhighfreqPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_em_high_freq_point_normalize(pt : PhysicsemhighfreqPoint) -> PhysicsemhighfreqPoint {
  let n = physics_em_high_freq_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_em_high_freq_point_scale(pt, 1.0 / n) }
}

pub fn physics_em_high_freq_point_negate(pt : PhysicsemhighfreqPoint) -> PhysicsemhighfreqPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_em_high_freq_point_mid(a : PhysicsemhighfreqPoint, b : PhysicsemhighfreqPoint) -> PhysicsemhighfreqPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_em_high_freq_point_lerp(a : PhysicsemhighfreqPoint, b : PhysicsemhighfreqPoint, t : Double) -> PhysicsemhighfreqPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_em_high_freq_point_to_string(pt : PhysicsemhighfreqPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_high_freq_make_series(vals : Array[Double], name : String) -> PhysicsemhighfreqSeries {
  { vals, name, meta: 0 }
}

pub fn physics_em_high_freq_series_len(s : PhysicsemhighfreqSeries) -> Int { s.vals.length() }

pub fn physics_em_high_freq_series_sum(s : PhysicsemhighfreqSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_em_high_freq_series_mean(s : PhysicsemhighfreqSeries) -> Double {
  let n = physics_em_high_freq_series_len(s)
  if n == 0 { 0.0 } else { physics_em_high_freq_series_sum(s) / n.to_double() }
}

pub fn physics_em_high_freq_series_min(s : PhysicsemhighfreqSeries) -> Double {
  let n = physics_em_high_freq_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_em_high_freq_series_max(s : PhysicsemhighfreqSeries) -> Double {
  let n = physics_em_high_freq_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_em_high_freq_series_range(s : PhysicsemhighfreqSeries) -> Double {
  physics_em_high_freq_series_max(s) - physics_em_high_freq_series_min(s)
}

pub fn physics_em_high_freq_series_var(s : PhysicsemhighfreqSeries) -> Double {
  let n = physics_em_high_freq_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_em_high_freq_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_em_high_freq_series_std(s : PhysicsemhighfreqSeries) -> Double { @_common.sqrt(physics_em_high_freq_series_var(s)) }

pub fn physics_em_high_freq_series_median(s : PhysicsemhighfreqSeries) -> Double {
  let n = physics_em_high_freq_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_em_high_freq_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_em_high_freq_series_scale(s : PhysicsemhighfreqSeries, f : Double) -> PhysicsemhighfreqSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_em_high_freq_series_add(a : PhysicsemhighfreqSeries, b : PhysicsemhighfreqSeries) -> PhysicsemhighfreqSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_em_high_freq_series_sub(a : PhysicsemhighfreqSeries, b : PhysicsemhighfreqSeries) -> PhysicsemhighfreqSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_em_high_freq_series_normalize(s : PhysicsemhighfreqSeries) -> PhysicsemhighfreqSeries {
  let mn = physics_em_high_freq_series_min(s)
  let mx = physics_em_high_freq_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_em_high_freq_series_cumsum(s : PhysicsemhighfreqSeries) -> PhysicsemhighfreqSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_em_high_freq_series_to_string(s : PhysicsemhighfreqSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemhighfreqMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_high_freq_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemhighfreqMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_high_freq_matrix_identity(n : Int) -> PhysicsemhighfreqMatrix {
  let m = physics_em_high_freq_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_em_high_freq_matrix_get(m : PhysicsemhighfreqMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_em_high_freq_matrix_transpose(m : PhysicsemhighfreqMatrix) -> PhysicsemhighfreqMatrix {
  let result = physics_em_high_freq_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_em_high_freq_matrix_add(a : PhysicsemhighfreqMatrix, b : PhysicsemhighfreqMatrix) -> PhysicsemhighfreqMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_em_high_freq_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_em_high_freq_matrix_scale(m : PhysicsemhighfreqMatrix, s : Double) -> PhysicsemhighfreqMatrix {
  let result = physics_em_high_freq_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_em_high_freq_matrix_multiply(a : PhysicsemhighfreqMatrix, b : PhysicsemhighfreqMatrix) -> PhysicsemhighfreqMatrix {
  if a.cols != b.rows { return physics_em_high_freq_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_em_high_freq_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_em_high_freq_matrix_trace(m : PhysicsemhighfreqMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_em_high_freq_matrix_det(m : PhysicsemhighfreqMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_em_high_freq_matrix_norm(m : PhysicsemhighfreqMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_em_high_freq_matrix_to_string(m : PhysicsemhighfreqMatrix) -> String {
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

pub(all) struct PhysicsemhighfreqVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_high_freq_make_vector(comps : Array[Double]) -> PhysicsemhighfreqVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_high_freq_vector_zero(dim : Int) -> PhysicsemhighfreqVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_em_high_freq_vector_add(a : PhysicsemhighfreqVector, b : PhysicsemhighfreqVector) -> PhysicsemhighfreqVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_high_freq_vector_sub(a : PhysicsemhighfreqVector, b : PhysicsemhighfreqVector) -> PhysicsemhighfreqVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_high_freq_vector_scale(v : PhysicsemhighfreqVector, s : Double) -> PhysicsemhighfreqVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_em_high_freq_vector_dot(a : PhysicsemhighfreqVector, b : PhysicsemhighfreqVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_em_high_freq_vector_norm(v : PhysicsemhighfreqVector) -> Double { @_common.sqrt(physics_em_high_freq_vector_dot(v, v)) }

pub fn physics_em_high_freq_vector_normalize(v : PhysicsemhighfreqVector) -> PhysicsemhighfreqVector {
  let n = physics_em_high_freq_vector_norm(v)
  if n < 0.0000001 { v } else { physics_em_high_freq_vector_scale(v, 1.0 / n) }
}

pub fn physics_em_high_freq_vector_dist(a : PhysicsemhighfreqVector, b : PhysicsemhighfreqVector) -> Double {
  physics_em_high_freq_vector_norm(physics_em_high_freq_vector_sub(a, b))
}

pub fn physics_em_high_freq_vector_to_string(v : PhysicsemhighfreqVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_em_high_freq_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_em_high_freq_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_em_high_freq_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_em_high_freq_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_em_high_freq_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_em_high_freq_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_em_high_freq_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_em_high_freq_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_em_high_freq_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_em_high_freq_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_em_high_freq_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_em_high_freq_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_em_high_freq_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_em_high_freq_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_em_high_freq_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_em_high_freq_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_em_high_freq_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_em_high_freq_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_em_high_freq_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_em_high_freq_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_em_high_freq_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_em_high_freq_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_em_high_freq_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_em_high_freq_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_em_high_freq_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_em_high_freq_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_em_high_freq_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_em_high_freq_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_em_high_freq_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsemhighfreqFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_frame_make(size : Int) -> PhysicsemhighfreqFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_frame_len(s : PhysicsemhighfreqFrame) -> Int { s.size }

pub fn physics_em_high_freq_frame_get(s : PhysicsemhighfreqFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_frame_set(s : PhysicsemhighfreqFrame, i : Int, v : Double) -> PhysicsemhighfreqFrame {
  let result = physics_em_high_freq_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_frame_sum(s : PhysicsemhighfreqFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_high_freq_frame_mean(s : PhysicsemhighfreqFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_high_freq_frame_sum(s) / s.size.to_double() }
}

pub fn physics_em_high_freq_frame_scale(s : PhysicsemhighfreqFrame, f : Double) -> PhysicsemhighfreqFrame {
  let result = physics_em_high_freq_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_high_freq_frame_add(a : PhysicsemhighfreqFrame, b : PhysicsemhighfreqFrame) -> PhysicsemhighfreqFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_high_freq_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_high_freq_frame_copy(s : PhysicsemhighfreqFrame) -> PhysicsemhighfreqFrame {
  let result = physics_em_high_freq_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_high_freq_frame_fill(s : PhysicsemhighfreqFrame, v : Double) -> PhysicsemhighfreqFrame {
  let result = physics_em_high_freq_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_frame_min(s : PhysicsemhighfreqFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_frame_max(s : PhysicsemhighfreqFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_frame_to_string(s : PhysicsemhighfreqFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_table_make(size : Int) -> PhysicsemhighfreqTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_table_len(s : PhysicsemhighfreqTable) -> Int { s.size }

pub fn physics_em_high_freq_table_get(s : PhysicsemhighfreqTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_table_set(s : PhysicsemhighfreqTable, i : Int, v : Double) -> PhysicsemhighfreqTable {
  let result = physics_em_high_freq_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_table_sum(s : PhysicsemhighfreqTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_high_freq_table_mean(s : PhysicsemhighfreqTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_high_freq_table_sum(s) / s.size.to_double() }
}

pub fn physics_em_high_freq_table_scale(s : PhysicsemhighfreqTable, f : Double) -> PhysicsemhighfreqTable {
  let result = physics_em_high_freq_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_high_freq_table_add(a : PhysicsemhighfreqTable, b : PhysicsemhighfreqTable) -> PhysicsemhighfreqTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_high_freq_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_high_freq_table_copy(s : PhysicsemhighfreqTable) -> PhysicsemhighfreqTable {
  let result = physics_em_high_freq_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_high_freq_table_fill(s : PhysicsemhighfreqTable, v : Double) -> PhysicsemhighfreqTable {
  let result = physics_em_high_freq_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_table_min(s : PhysicsemhighfreqTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_table_max(s : PhysicsemhighfreqTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_table_to_string(s : PhysicsemhighfreqTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_graphn_make(size : Int) -> PhysicsemhighfreqGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_graphn_len(s : PhysicsemhighfreqGraphN) -> Int { s.size }

pub fn physics_em_high_freq_graphn_get(s : PhysicsemhighfreqGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_graphn_set(s : PhysicsemhighfreqGraphN, i : Int, v : Double) -> PhysicsemhighfreqGraphN {
  let result = physics_em_high_freq_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_graphn_sum(s : PhysicsemhighfreqGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_high_freq_graphn_mean(s : PhysicsemhighfreqGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_high_freq_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_em_high_freq_graphn_scale(s : PhysicsemhighfreqGraphN, f : Double) -> PhysicsemhighfreqGraphN {
  let result = physics_em_high_freq_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_high_freq_graphn_add(a : PhysicsemhighfreqGraphN, b : PhysicsemhighfreqGraphN) -> PhysicsemhighfreqGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_high_freq_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_high_freq_graphn_copy(s : PhysicsemhighfreqGraphN) -> PhysicsemhighfreqGraphN {
  let result = physics_em_high_freq_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_high_freq_graphn_fill(s : PhysicsemhighfreqGraphN, v : Double) -> PhysicsemhighfreqGraphN {
  let result = physics_em_high_freq_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_graphn_min(s : PhysicsemhighfreqGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_graphn_max(s : PhysicsemhighfreqGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_graphn_to_string(s : PhysicsemhighfreqGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_node_make(size : Int) -> PhysicsemhighfreqNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_node_len(s : PhysicsemhighfreqNode) -> Int { s.size }

pub fn physics_em_high_freq_node_get(s : PhysicsemhighfreqNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_node_set(s : PhysicsemhighfreqNode, i : Int, v : Double) -> PhysicsemhighfreqNode {
  let result = physics_em_high_freq_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_node_sum(s : PhysicsemhighfreqNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_high_freq_node_mean(s : PhysicsemhighfreqNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_high_freq_node_sum(s) / s.size.to_double() }
}

pub fn physics_em_high_freq_node_scale(s : PhysicsemhighfreqNode, f : Double) -> PhysicsemhighfreqNode {
  let result = physics_em_high_freq_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_high_freq_node_add(a : PhysicsemhighfreqNode, b : PhysicsemhighfreqNode) -> PhysicsemhighfreqNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_high_freq_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_high_freq_node_copy(s : PhysicsemhighfreqNode) -> PhysicsemhighfreqNode {
  let result = physics_em_high_freq_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_high_freq_node_fill(s : PhysicsemhighfreqNode, v : Double) -> PhysicsemhighfreqNode {
  let result = physics_em_high_freq_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_node_min(s : PhysicsemhighfreqNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_node_max(s : PhysicsemhighfreqNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_node_to_string(s : PhysicsemhighfreqNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_edge_make(size : Int) -> PhysicsemhighfreqEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_edge_len(s : PhysicsemhighfreqEdge) -> Int { s.size }

pub fn physics_em_high_freq_edge_get(s : PhysicsemhighfreqEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_edge_set(s : PhysicsemhighfreqEdge, i : Int, v : Double) -> PhysicsemhighfreqEdge {
  let result = physics_em_high_freq_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_edge_sum(s : PhysicsemhighfreqEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_high_freq_edge_mean(s : PhysicsemhighfreqEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_high_freq_edge_sum(s) / s.size.to_double() }
}

pub fn physics_em_high_freq_edge_scale(s : PhysicsemhighfreqEdge, f : Double) -> PhysicsemhighfreqEdge {
  let result = physics_em_high_freq_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_high_freq_edge_add(a : PhysicsemhighfreqEdge, b : PhysicsemhighfreqEdge) -> PhysicsemhighfreqEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_high_freq_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_high_freq_edge_copy(s : PhysicsemhighfreqEdge) -> PhysicsemhighfreqEdge {
  let result = physics_em_high_freq_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_high_freq_edge_fill(s : PhysicsemhighfreqEdge, v : Double) -> PhysicsemhighfreqEdge {
  let result = physics_em_high_freq_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_edge_min(s : PhysicsemhighfreqEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_edge_max(s : PhysicsemhighfreqEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_edge_to_string(s : PhysicsemhighfreqEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_path_make(size : Int) -> PhysicsemhighfreqPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_path_len(s : PhysicsemhighfreqPath) -> Int { s.size }

pub fn physics_em_high_freq_path_get(s : PhysicsemhighfreqPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_path_set(s : PhysicsemhighfreqPath, i : Int, v : Double) -> PhysicsemhighfreqPath {
  let result = physics_em_high_freq_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_path_sum(s : PhysicsemhighfreqPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_high_freq_path_mean(s : PhysicsemhighfreqPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_high_freq_path_sum(s) / s.size.to_double() }
}

pub fn physics_em_high_freq_path_scale(s : PhysicsemhighfreqPath, f : Double) -> PhysicsemhighfreqPath {
  let result = physics_em_high_freq_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_high_freq_path_add(a : PhysicsemhighfreqPath, b : PhysicsemhighfreqPath) -> PhysicsemhighfreqPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_high_freq_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_high_freq_path_copy(s : PhysicsemhighfreqPath) -> PhysicsemhighfreqPath {
  let result = physics_em_high_freq_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_high_freq_path_fill(s : PhysicsemhighfreqPath, v : Double) -> PhysicsemhighfreqPath {
  let result = physics_em_high_freq_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_path_min(s : PhysicsemhighfreqPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_path_max(s : PhysicsemhighfreqPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_path_to_string(s : PhysicsemhighfreqPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_cluster_make(size : Int) -> PhysicsemhighfreqCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_cluster_len(s : PhysicsemhighfreqCluster) -> Int { s.size }

pub fn physics_em_high_freq_cluster_get(s : PhysicsemhighfreqCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_cluster_set(s : PhysicsemhighfreqCluster, i : Int, v : Double) -> PhysicsemhighfreqCluster {
  let result = physics_em_high_freq_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_cluster_sum(s : PhysicsemhighfreqCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_high_freq_cluster_mean(s : PhysicsemhighfreqCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_high_freq_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_em_high_freq_cluster_scale(s : PhysicsemhighfreqCluster, f : Double) -> PhysicsemhighfreqCluster {
  let result = physics_em_high_freq_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_high_freq_cluster_add(a : PhysicsemhighfreqCluster, b : PhysicsemhighfreqCluster) -> PhysicsemhighfreqCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_high_freq_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_high_freq_cluster_copy(s : PhysicsemhighfreqCluster) -> PhysicsemhighfreqCluster {
  let result = physics_em_high_freq_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_high_freq_cluster_fill(s : PhysicsemhighfreqCluster, v : Double) -> PhysicsemhighfreqCluster {
  let result = physics_em_high_freq_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_cluster_min(s : PhysicsemhighfreqCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_cluster_max(s : PhysicsemhighfreqCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_cluster_to_string(s : PhysicsemhighfreqCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_model_make(size : Int) -> PhysicsemhighfreqModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_model_len(s : PhysicsemhighfreqModel) -> Int { s.size }

pub fn physics_em_high_freq_model_get(s : PhysicsemhighfreqModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_model_set(s : PhysicsemhighfreqModel, i : Int, v : Double) -> PhysicsemhighfreqModel {
  let result = physics_em_high_freq_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_model_sum(s : PhysicsemhighfreqModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_high_freq_model_mean(s : PhysicsemhighfreqModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_high_freq_model_sum(s) / s.size.to_double() }
}

pub fn physics_em_high_freq_model_scale(s : PhysicsemhighfreqModel, f : Double) -> PhysicsemhighfreqModel {
  let result = physics_em_high_freq_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_high_freq_model_add(a : PhysicsemhighfreqModel, b : PhysicsemhighfreqModel) -> PhysicsemhighfreqModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_high_freq_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_high_freq_model_copy(s : PhysicsemhighfreqModel) -> PhysicsemhighfreqModel {
  let result = physics_em_high_freq_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_high_freq_model_fill(s : PhysicsemhighfreqModel, v : Double) -> PhysicsemhighfreqModel {
  let result = physics_em_high_freq_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_model_min(s : PhysicsemhighfreqModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_model_max(s : PhysicsemhighfreqModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_model_to_string(s : PhysicsemhighfreqModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_layer_make(size : Int) -> PhysicsemhighfreqLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_layer_len(s : PhysicsemhighfreqLayer) -> Int { s.size }

pub fn physics_em_high_freq_layer_get(s : PhysicsemhighfreqLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_layer_set(s : PhysicsemhighfreqLayer, i : Int, v : Double) -> PhysicsemhighfreqLayer {
  let result = physics_em_high_freq_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_layer_sum(s : PhysicsemhighfreqLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_high_freq_layer_mean(s : PhysicsemhighfreqLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_high_freq_layer_sum(s) / s.size.to_double() }
}

pub fn physics_em_high_freq_layer_scale(s : PhysicsemhighfreqLayer, f : Double) -> PhysicsemhighfreqLayer {
  let result = physics_em_high_freq_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_high_freq_layer_add(a : PhysicsemhighfreqLayer, b : PhysicsemhighfreqLayer) -> PhysicsemhighfreqLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_high_freq_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_high_freq_layer_copy(s : PhysicsemhighfreqLayer) -> PhysicsemhighfreqLayer {
  let result = physics_em_high_freq_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_high_freq_layer_fill(s : PhysicsemhighfreqLayer, v : Double) -> PhysicsemhighfreqLayer {
  let result = physics_em_high_freq_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_layer_min(s : PhysicsemhighfreqLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_layer_max(s : PhysicsemhighfreqLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_layer_to_string(s : PhysicsemhighfreqLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_buffer_make(size : Int) -> PhysicsemhighfreqBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_buffer_len(s : PhysicsemhighfreqBuffer) -> Int { s.size }

pub fn physics_em_high_freq_buffer_get(s : PhysicsemhighfreqBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_buffer_set(s : PhysicsemhighfreqBuffer, i : Int, v : Double) -> PhysicsemhighfreqBuffer {
  let result = physics_em_high_freq_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_buffer_sum(s : PhysicsemhighfreqBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_high_freq_buffer_mean(s : PhysicsemhighfreqBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_high_freq_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_em_high_freq_buffer_scale(s : PhysicsemhighfreqBuffer, f : Double) -> PhysicsemhighfreqBuffer {
  let result = physics_em_high_freq_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_high_freq_buffer_add(a : PhysicsemhighfreqBuffer, b : PhysicsemhighfreqBuffer) -> PhysicsemhighfreqBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_high_freq_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_high_freq_buffer_copy(s : PhysicsemhighfreqBuffer) -> PhysicsemhighfreqBuffer {
  let result = physics_em_high_freq_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_high_freq_buffer_fill(s : PhysicsemhighfreqBuffer, v : Double) -> PhysicsemhighfreqBuffer {
  let result = physics_em_high_freq_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_buffer_min(s : PhysicsemhighfreqBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_buffer_max(s : PhysicsemhighfreqBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_buffer_to_string(s : PhysicsemhighfreqBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_cursor_make(size : Int) -> PhysicsemhighfreqCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_cursor_len(s : PhysicsemhighfreqCursor) -> Int { s.size }

pub fn physics_em_high_freq_cursor_get(s : PhysicsemhighfreqCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_cursor_set(s : PhysicsemhighfreqCursor, i : Int, v : Double) -> PhysicsemhighfreqCursor {
  let result = physics_em_high_freq_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_cursor_sum(s : PhysicsemhighfreqCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_high_freq_cursor_mean(s : PhysicsemhighfreqCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_high_freq_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_em_high_freq_cursor_scale(s : PhysicsemhighfreqCursor, f : Double) -> PhysicsemhighfreqCursor {
  let result = physics_em_high_freq_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_high_freq_cursor_add(a : PhysicsemhighfreqCursor, b : PhysicsemhighfreqCursor) -> PhysicsemhighfreqCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_high_freq_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_high_freq_cursor_copy(s : PhysicsemhighfreqCursor) -> PhysicsemhighfreqCursor {
  let result = physics_em_high_freq_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_high_freq_cursor_fill(s : PhysicsemhighfreqCursor, v : Double) -> PhysicsemhighfreqCursor {
  let result = physics_em_high_freq_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_cursor_min(s : PhysicsemhighfreqCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_cursor_max(s : PhysicsemhighfreqCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_cursor_to_string(s : PhysicsemhighfreqCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_view_make(size : Int) -> PhysicsemhighfreqView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_view_len(s : PhysicsemhighfreqView) -> Int { s.size }

pub fn physics_em_high_freq_view_get(s : PhysicsemhighfreqView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_view_set(s : PhysicsemhighfreqView, i : Int, v : Double) -> PhysicsemhighfreqView {
  let result = physics_em_high_freq_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_view_sum(s : PhysicsemhighfreqView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_high_freq_view_mean(s : PhysicsemhighfreqView) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_high_freq_view_sum(s) / s.size.to_double() }
}

pub fn physics_em_high_freq_view_scale(s : PhysicsemhighfreqView, f : Double) -> PhysicsemhighfreqView {
  let result = physics_em_high_freq_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_high_freq_view_add(a : PhysicsemhighfreqView, b : PhysicsemhighfreqView) -> PhysicsemhighfreqView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_high_freq_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_high_freq_view_copy(s : PhysicsemhighfreqView) -> PhysicsemhighfreqView {
  let result = physics_em_high_freq_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_high_freq_view_fill(s : PhysicsemhighfreqView, v : Double) -> PhysicsemhighfreqView {
  let result = physics_em_high_freq_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_view_min(s : PhysicsemhighfreqView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_view_max(s : PhysicsemhighfreqView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_view_to_string(s : PhysicsemhighfreqView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_range_make(size : Int) -> PhysicsemhighfreqRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_range_len(s : PhysicsemhighfreqRange) -> Int { s.size }

pub fn physics_em_high_freq_range_get(s : PhysicsemhighfreqRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_range_set(s : PhysicsemhighfreqRange, i : Int, v : Double) -> PhysicsemhighfreqRange {
  let result = physics_em_high_freq_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_range_sum(s : PhysicsemhighfreqRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_high_freq_range_mean(s : PhysicsemhighfreqRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_high_freq_range_sum(s) / s.size.to_double() }
}

pub fn physics_em_high_freq_range_scale(s : PhysicsemhighfreqRange, f : Double) -> PhysicsemhighfreqRange {
  let result = physics_em_high_freq_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_high_freq_range_add(a : PhysicsemhighfreqRange, b : PhysicsemhighfreqRange) -> PhysicsemhighfreqRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_high_freq_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_high_freq_range_copy(s : PhysicsemhighfreqRange) -> PhysicsemhighfreqRange {
  let result = physics_em_high_freq_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_high_freq_range_fill(s : PhysicsemhighfreqRange, v : Double) -> PhysicsemhighfreqRange {
  let result = physics_em_high_freq_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_range_min(s : PhysicsemhighfreqRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_range_max(s : PhysicsemhighfreqRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_range_to_string(s : PhysicsemhighfreqRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemhighfreqSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_high_freq_slice_make(size : Int) -> PhysicsemhighfreqSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_high_freq_slice_len(s : PhysicsemhighfreqSlice) -> Int { s.size }

pub fn physics_em_high_freq_slice_get(s : PhysicsemhighfreqSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_high_freq_slice_set(s : PhysicsemhighfreqSlice, i : Int, v : Double) -> PhysicsemhighfreqSlice {
  let result = physics_em_high_freq_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_slice_sum(s : PhysicsemhighfreqSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_high_freq_slice_mean(s : PhysicsemhighfreqSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_high_freq_slice_sum(s) / s.size.to_double() }
}

pub fn physics_em_high_freq_slice_scale(s : PhysicsemhighfreqSlice, f : Double) -> PhysicsemhighfreqSlice {
  let result = physics_em_high_freq_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_high_freq_slice_add(a : PhysicsemhighfreqSlice, b : PhysicsemhighfreqSlice) -> PhysicsemhighfreqSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_high_freq_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_high_freq_slice_copy(s : PhysicsemhighfreqSlice) -> PhysicsemhighfreqSlice {
  let result = physics_em_high_freq_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_high_freq_slice_fill(s : PhysicsemhighfreqSlice, v : Double) -> PhysicsemhighfreqSlice {
  let result = physics_em_high_freq_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_high_freq_slice_min(s : PhysicsemhighfreqSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_slice_max(s : PhysicsemhighfreqSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_high_freq_slice_to_string(s : PhysicsemhighfreqSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

