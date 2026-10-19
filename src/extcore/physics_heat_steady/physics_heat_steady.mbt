///===
/// extcore/physics_heat_steady

pub(all) struct PhysicsheatsteadyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_steady_make_point(x : Double, y : Double) -> PhysicsheatsteadyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_steady_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatsteadyPoint {
  { x, y, z, label: 0 }
}

pub fn physics_heat_steady_point_x(pt : PhysicsheatsteadyPoint) -> Double { pt.x }

pub fn physics_heat_steady_point_y(pt : PhysicsheatsteadyPoint) -> Double { pt.y }

pub fn physics_heat_steady_point_z(pt : PhysicsheatsteadyPoint) -> Double { pt.z }

pub fn physics_heat_steady_point_label(pt : PhysicsheatsteadyPoint) -> Int { pt.label }

pub fn physics_heat_steady_point_dist(a : PhysicsheatsteadyPoint, b : PhysicsheatsteadyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_heat_steady_point_add(a : PhysicsheatsteadyPoint, b : PhysicsheatsteadyPoint) -> PhysicsheatsteadyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_heat_steady_point_sub(a : PhysicsheatsteadyPoint, b : PhysicsheatsteadyPoint) -> PhysicsheatsteadyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_heat_steady_point_scale(pt : PhysicsheatsteadyPoint, s : Double) -> PhysicsheatsteadyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_heat_steady_point_dot(a : PhysicsheatsteadyPoint, b : PhysicsheatsteadyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_heat_steady_point_cross(a : PhysicsheatsteadyPoint, b : PhysicsheatsteadyPoint) -> PhysicsheatsteadyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_heat_steady_point_norm(pt : PhysicsheatsteadyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_heat_steady_point_normalize(pt : PhysicsheatsteadyPoint) -> PhysicsheatsteadyPoint {
  let n = physics_heat_steady_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_heat_steady_point_scale(pt, 1.0 / n) }
}

pub fn physics_heat_steady_point_negate(pt : PhysicsheatsteadyPoint) -> PhysicsheatsteadyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_heat_steady_point_mid(a : PhysicsheatsteadyPoint, b : PhysicsheatsteadyPoint) -> PhysicsheatsteadyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_heat_steady_point_lerp(a : PhysicsheatsteadyPoint, b : PhysicsheatsteadyPoint, t : Double) -> PhysicsheatsteadyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_heat_steady_point_to_string(pt : PhysicsheatsteadyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsheatsteadySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_steady_make_series(vals : Array[Double], name : String) -> PhysicsheatsteadySeries {
  { vals, name, meta: 0 }
}

pub fn physics_heat_steady_series_len(s : PhysicsheatsteadySeries) -> Int { s.vals.length() }

pub fn physics_heat_steady_series_sum(s : PhysicsheatsteadySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_heat_steady_series_mean(s : PhysicsheatsteadySeries) -> Double {
  let n = physics_heat_steady_series_len(s)
  if n == 0 { 0.0 } else { physics_heat_steady_series_sum(s) / n.to_double() }
}

pub fn physics_heat_steady_series_min(s : PhysicsheatsteadySeries) -> Double {
  let n = physics_heat_steady_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_heat_steady_series_max(s : PhysicsheatsteadySeries) -> Double {
  let n = physics_heat_steady_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_heat_steady_series_range(s : PhysicsheatsteadySeries) -> Double {
  physics_heat_steady_series_max(s) - physics_heat_steady_series_min(s)
}

pub fn physics_heat_steady_series_var(s : PhysicsheatsteadySeries) -> Double {
  let n = physics_heat_steady_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_heat_steady_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_heat_steady_series_std(s : PhysicsheatsteadySeries) -> Double { @_common.sqrt(physics_heat_steady_series_var(s)) }

pub fn physics_heat_steady_series_median(s : PhysicsheatsteadySeries) -> Double {
  let n = physics_heat_steady_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_heat_steady_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_heat_steady_series_scale(s : PhysicsheatsteadySeries, f : Double) -> PhysicsheatsteadySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_heat_steady_series_add(a : PhysicsheatsteadySeries, b : PhysicsheatsteadySeries) -> PhysicsheatsteadySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_heat_steady_series_sub(a : PhysicsheatsteadySeries, b : PhysicsheatsteadySeries) -> PhysicsheatsteadySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_heat_steady_series_normalize(s : PhysicsheatsteadySeries) -> PhysicsheatsteadySeries {
  let mn = physics_heat_steady_series_min(s)
  let mx = physics_heat_steady_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_heat_steady_series_cumsum(s : PhysicsheatsteadySeries) -> PhysicsheatsteadySeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_heat_steady_series_to_string(s : PhysicsheatsteadySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatsteadyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_steady_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatsteadyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_steady_matrix_identity(n : Int) -> PhysicsheatsteadyMatrix {
  let m = physics_heat_steady_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_heat_steady_matrix_get(m : PhysicsheatsteadyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_heat_steady_matrix_transpose(m : PhysicsheatsteadyMatrix) -> PhysicsheatsteadyMatrix {
  let result = physics_heat_steady_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_heat_steady_matrix_add(a : PhysicsheatsteadyMatrix, b : PhysicsheatsteadyMatrix) -> PhysicsheatsteadyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_heat_steady_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_heat_steady_matrix_scale(m : PhysicsheatsteadyMatrix, s : Double) -> PhysicsheatsteadyMatrix {
  let result = physics_heat_steady_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_heat_steady_matrix_multiply(a : PhysicsheatsteadyMatrix, b : PhysicsheatsteadyMatrix) -> PhysicsheatsteadyMatrix {
  if a.cols != b.rows { return physics_heat_steady_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_heat_steady_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_heat_steady_matrix_trace(m : PhysicsheatsteadyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_heat_steady_matrix_det(m : PhysicsheatsteadyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_heat_steady_matrix_norm(m : PhysicsheatsteadyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_heat_steady_matrix_to_string(m : PhysicsheatsteadyMatrix) -> String {
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

pub(all) struct PhysicsheatsteadyVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_steady_make_vector(comps : Array[Double]) -> PhysicsheatsteadyVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_steady_vector_zero(dim : Int) -> PhysicsheatsteadyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_heat_steady_vector_add(a : PhysicsheatsteadyVector, b : PhysicsheatsteadyVector) -> PhysicsheatsteadyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_heat_steady_vector_sub(a : PhysicsheatsteadyVector, b : PhysicsheatsteadyVector) -> PhysicsheatsteadyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_heat_steady_vector_scale(v : PhysicsheatsteadyVector, s : Double) -> PhysicsheatsteadyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_heat_steady_vector_dot(a : PhysicsheatsteadyVector, b : PhysicsheatsteadyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_heat_steady_vector_norm(v : PhysicsheatsteadyVector) -> Double { @_common.sqrt(physics_heat_steady_vector_dot(v, v)) }

pub fn physics_heat_steady_vector_normalize(v : PhysicsheatsteadyVector) -> PhysicsheatsteadyVector {
  let n = physics_heat_steady_vector_norm(v)
  if n < 0.0000001 { v } else { physics_heat_steady_vector_scale(v, 1.0 / n) }
}

pub fn physics_heat_steady_vector_dist(a : PhysicsheatsteadyVector, b : PhysicsheatsteadyVector) -> Double {
  physics_heat_steady_vector_norm(physics_heat_steady_vector_sub(a, b))
}

pub fn physics_heat_steady_vector_to_string(v : PhysicsheatsteadyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_steady_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_heat_steady_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_heat_steady_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_heat_steady_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_heat_steady_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_heat_steady_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_heat_steady_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_heat_steady_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_heat_steady_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_heat_steady_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_heat_steady_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_heat_steady_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_heat_steady_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_heat_steady_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_heat_steady_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_heat_steady_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_heat_steady_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_heat_steady_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_heat_steady_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_heat_steady_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_heat_steady_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_heat_steady_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_heat_steady_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_heat_steady_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_heat_steady_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_heat_steady_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_heat_steady_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_heat_steady_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_heat_steady_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsheatsteadyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_frame_make(size : Int) -> PhysicsheatsteadyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_frame_len(s : PhysicsheatsteadyFrame) -> Int { s.size }

pub fn physics_heat_steady_frame_get(s : PhysicsheatsteadyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_frame_set(s : PhysicsheatsteadyFrame, i : Int, v : Double) -> PhysicsheatsteadyFrame {
  let result = physics_heat_steady_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_frame_sum(s : PhysicsheatsteadyFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_steady_frame_mean(s : PhysicsheatsteadyFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_steady_frame_sum(s) / s.size.to_double() }
}

pub fn physics_heat_steady_frame_scale(s : PhysicsheatsteadyFrame, f : Double) -> PhysicsheatsteadyFrame {
  let result = physics_heat_steady_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_steady_frame_add(a : PhysicsheatsteadyFrame, b : PhysicsheatsteadyFrame) -> PhysicsheatsteadyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_steady_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_steady_frame_copy(s : PhysicsheatsteadyFrame) -> PhysicsheatsteadyFrame {
  let result = physics_heat_steady_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_steady_frame_fill(s : PhysicsheatsteadyFrame, v : Double) -> PhysicsheatsteadyFrame {
  let result = physics_heat_steady_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_frame_min(s : PhysicsheatsteadyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_frame_max(s : PhysicsheatsteadyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_frame_to_string(s : PhysicsheatsteadyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_table_make(size : Int) -> PhysicsheatsteadyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_table_len(s : PhysicsheatsteadyTable) -> Int { s.size }

pub fn physics_heat_steady_table_get(s : PhysicsheatsteadyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_table_set(s : PhysicsheatsteadyTable, i : Int, v : Double) -> PhysicsheatsteadyTable {
  let result = physics_heat_steady_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_table_sum(s : PhysicsheatsteadyTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_steady_table_mean(s : PhysicsheatsteadyTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_steady_table_sum(s) / s.size.to_double() }
}

pub fn physics_heat_steady_table_scale(s : PhysicsheatsteadyTable, f : Double) -> PhysicsheatsteadyTable {
  let result = physics_heat_steady_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_steady_table_add(a : PhysicsheatsteadyTable, b : PhysicsheatsteadyTable) -> PhysicsheatsteadyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_steady_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_steady_table_copy(s : PhysicsheatsteadyTable) -> PhysicsheatsteadyTable {
  let result = physics_heat_steady_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_steady_table_fill(s : PhysicsheatsteadyTable, v : Double) -> PhysicsheatsteadyTable {
  let result = physics_heat_steady_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_table_min(s : PhysicsheatsteadyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_table_max(s : PhysicsheatsteadyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_table_to_string(s : PhysicsheatsteadyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_graphn_make(size : Int) -> PhysicsheatsteadyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_graphn_len(s : PhysicsheatsteadyGraphN) -> Int { s.size }

pub fn physics_heat_steady_graphn_get(s : PhysicsheatsteadyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_graphn_set(s : PhysicsheatsteadyGraphN, i : Int, v : Double) -> PhysicsheatsteadyGraphN {
  let result = physics_heat_steady_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_graphn_sum(s : PhysicsheatsteadyGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_steady_graphn_mean(s : PhysicsheatsteadyGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_steady_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_heat_steady_graphn_scale(s : PhysicsheatsteadyGraphN, f : Double) -> PhysicsheatsteadyGraphN {
  let result = physics_heat_steady_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_steady_graphn_add(a : PhysicsheatsteadyGraphN, b : PhysicsheatsteadyGraphN) -> PhysicsheatsteadyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_steady_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_steady_graphn_copy(s : PhysicsheatsteadyGraphN) -> PhysicsheatsteadyGraphN {
  let result = physics_heat_steady_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_steady_graphn_fill(s : PhysicsheatsteadyGraphN, v : Double) -> PhysicsheatsteadyGraphN {
  let result = physics_heat_steady_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_graphn_min(s : PhysicsheatsteadyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_graphn_max(s : PhysicsheatsteadyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_graphn_to_string(s : PhysicsheatsteadyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_node_make(size : Int) -> PhysicsheatsteadyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_node_len(s : PhysicsheatsteadyNode) -> Int { s.size }

pub fn physics_heat_steady_node_get(s : PhysicsheatsteadyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_node_set(s : PhysicsheatsteadyNode, i : Int, v : Double) -> PhysicsheatsteadyNode {
  let result = physics_heat_steady_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_node_sum(s : PhysicsheatsteadyNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_steady_node_mean(s : PhysicsheatsteadyNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_steady_node_sum(s) / s.size.to_double() }
}

pub fn physics_heat_steady_node_scale(s : PhysicsheatsteadyNode, f : Double) -> PhysicsheatsteadyNode {
  let result = physics_heat_steady_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_steady_node_add(a : PhysicsheatsteadyNode, b : PhysicsheatsteadyNode) -> PhysicsheatsteadyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_steady_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_steady_node_copy(s : PhysicsheatsteadyNode) -> PhysicsheatsteadyNode {
  let result = physics_heat_steady_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_steady_node_fill(s : PhysicsheatsteadyNode, v : Double) -> PhysicsheatsteadyNode {
  let result = physics_heat_steady_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_node_min(s : PhysicsheatsteadyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_node_max(s : PhysicsheatsteadyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_node_to_string(s : PhysicsheatsteadyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_edge_make(size : Int) -> PhysicsheatsteadyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_edge_len(s : PhysicsheatsteadyEdge) -> Int { s.size }

pub fn physics_heat_steady_edge_get(s : PhysicsheatsteadyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_edge_set(s : PhysicsheatsteadyEdge, i : Int, v : Double) -> PhysicsheatsteadyEdge {
  let result = physics_heat_steady_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_edge_sum(s : PhysicsheatsteadyEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_steady_edge_mean(s : PhysicsheatsteadyEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_steady_edge_sum(s) / s.size.to_double() }
}

pub fn physics_heat_steady_edge_scale(s : PhysicsheatsteadyEdge, f : Double) -> PhysicsheatsteadyEdge {
  let result = physics_heat_steady_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_steady_edge_add(a : PhysicsheatsteadyEdge, b : PhysicsheatsteadyEdge) -> PhysicsheatsteadyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_steady_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_steady_edge_copy(s : PhysicsheatsteadyEdge) -> PhysicsheatsteadyEdge {
  let result = physics_heat_steady_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_steady_edge_fill(s : PhysicsheatsteadyEdge, v : Double) -> PhysicsheatsteadyEdge {
  let result = physics_heat_steady_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_edge_min(s : PhysicsheatsteadyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_edge_max(s : PhysicsheatsteadyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_edge_to_string(s : PhysicsheatsteadyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_path_make(size : Int) -> PhysicsheatsteadyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_path_len(s : PhysicsheatsteadyPath) -> Int { s.size }

pub fn physics_heat_steady_path_get(s : PhysicsheatsteadyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_path_set(s : PhysicsheatsteadyPath, i : Int, v : Double) -> PhysicsheatsteadyPath {
  let result = physics_heat_steady_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_path_sum(s : PhysicsheatsteadyPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_steady_path_mean(s : PhysicsheatsteadyPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_steady_path_sum(s) / s.size.to_double() }
}

pub fn physics_heat_steady_path_scale(s : PhysicsheatsteadyPath, f : Double) -> PhysicsheatsteadyPath {
  let result = physics_heat_steady_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_steady_path_add(a : PhysicsheatsteadyPath, b : PhysicsheatsteadyPath) -> PhysicsheatsteadyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_steady_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_steady_path_copy(s : PhysicsheatsteadyPath) -> PhysicsheatsteadyPath {
  let result = physics_heat_steady_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_steady_path_fill(s : PhysicsheatsteadyPath, v : Double) -> PhysicsheatsteadyPath {
  let result = physics_heat_steady_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_path_min(s : PhysicsheatsteadyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_path_max(s : PhysicsheatsteadyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_path_to_string(s : PhysicsheatsteadyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_cluster_make(size : Int) -> PhysicsheatsteadyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_cluster_len(s : PhysicsheatsteadyCluster) -> Int { s.size }

pub fn physics_heat_steady_cluster_get(s : PhysicsheatsteadyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_cluster_set(s : PhysicsheatsteadyCluster, i : Int, v : Double) -> PhysicsheatsteadyCluster {
  let result = physics_heat_steady_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_cluster_sum(s : PhysicsheatsteadyCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_steady_cluster_mean(s : PhysicsheatsteadyCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_steady_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_heat_steady_cluster_scale(s : PhysicsheatsteadyCluster, f : Double) -> PhysicsheatsteadyCluster {
  let result = physics_heat_steady_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_steady_cluster_add(a : PhysicsheatsteadyCluster, b : PhysicsheatsteadyCluster) -> PhysicsheatsteadyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_steady_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_steady_cluster_copy(s : PhysicsheatsteadyCluster) -> PhysicsheatsteadyCluster {
  let result = physics_heat_steady_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_steady_cluster_fill(s : PhysicsheatsteadyCluster, v : Double) -> PhysicsheatsteadyCluster {
  let result = physics_heat_steady_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_cluster_min(s : PhysicsheatsteadyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_cluster_max(s : PhysicsheatsteadyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_cluster_to_string(s : PhysicsheatsteadyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_model_make(size : Int) -> PhysicsheatsteadyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_model_len(s : PhysicsheatsteadyModel) -> Int { s.size }

pub fn physics_heat_steady_model_get(s : PhysicsheatsteadyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_model_set(s : PhysicsheatsteadyModel, i : Int, v : Double) -> PhysicsheatsteadyModel {
  let result = physics_heat_steady_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_model_sum(s : PhysicsheatsteadyModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_steady_model_mean(s : PhysicsheatsteadyModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_steady_model_sum(s) / s.size.to_double() }
}

pub fn physics_heat_steady_model_scale(s : PhysicsheatsteadyModel, f : Double) -> PhysicsheatsteadyModel {
  let result = physics_heat_steady_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_steady_model_add(a : PhysicsheatsteadyModel, b : PhysicsheatsteadyModel) -> PhysicsheatsteadyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_steady_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_steady_model_copy(s : PhysicsheatsteadyModel) -> PhysicsheatsteadyModel {
  let result = physics_heat_steady_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_steady_model_fill(s : PhysicsheatsteadyModel, v : Double) -> PhysicsheatsteadyModel {
  let result = physics_heat_steady_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_model_min(s : PhysicsheatsteadyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_model_max(s : PhysicsheatsteadyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_model_to_string(s : PhysicsheatsteadyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_layer_make(size : Int) -> PhysicsheatsteadyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_layer_len(s : PhysicsheatsteadyLayer) -> Int { s.size }

pub fn physics_heat_steady_layer_get(s : PhysicsheatsteadyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_layer_set(s : PhysicsheatsteadyLayer, i : Int, v : Double) -> PhysicsheatsteadyLayer {
  let result = physics_heat_steady_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_layer_sum(s : PhysicsheatsteadyLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_steady_layer_mean(s : PhysicsheatsteadyLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_steady_layer_sum(s) / s.size.to_double() }
}

pub fn physics_heat_steady_layer_scale(s : PhysicsheatsteadyLayer, f : Double) -> PhysicsheatsteadyLayer {
  let result = physics_heat_steady_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_steady_layer_add(a : PhysicsheatsteadyLayer, b : PhysicsheatsteadyLayer) -> PhysicsheatsteadyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_steady_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_steady_layer_copy(s : PhysicsheatsteadyLayer) -> PhysicsheatsteadyLayer {
  let result = physics_heat_steady_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_steady_layer_fill(s : PhysicsheatsteadyLayer, v : Double) -> PhysicsheatsteadyLayer {
  let result = physics_heat_steady_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_layer_min(s : PhysicsheatsteadyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_layer_max(s : PhysicsheatsteadyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_layer_to_string(s : PhysicsheatsteadyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_buffer_make(size : Int) -> PhysicsheatsteadyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_buffer_len(s : PhysicsheatsteadyBuffer) -> Int { s.size }

pub fn physics_heat_steady_buffer_get(s : PhysicsheatsteadyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_buffer_set(s : PhysicsheatsteadyBuffer, i : Int, v : Double) -> PhysicsheatsteadyBuffer {
  let result = physics_heat_steady_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_buffer_sum(s : PhysicsheatsteadyBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_steady_buffer_mean(s : PhysicsheatsteadyBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_steady_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_heat_steady_buffer_scale(s : PhysicsheatsteadyBuffer, f : Double) -> PhysicsheatsteadyBuffer {
  let result = physics_heat_steady_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_steady_buffer_add(a : PhysicsheatsteadyBuffer, b : PhysicsheatsteadyBuffer) -> PhysicsheatsteadyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_steady_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_steady_buffer_copy(s : PhysicsheatsteadyBuffer) -> PhysicsheatsteadyBuffer {
  let result = physics_heat_steady_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_steady_buffer_fill(s : PhysicsheatsteadyBuffer, v : Double) -> PhysicsheatsteadyBuffer {
  let result = physics_heat_steady_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_buffer_min(s : PhysicsheatsteadyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_buffer_max(s : PhysicsheatsteadyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_buffer_to_string(s : PhysicsheatsteadyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_cursor_make(size : Int) -> PhysicsheatsteadyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_cursor_len(s : PhysicsheatsteadyCursor) -> Int { s.size }

pub fn physics_heat_steady_cursor_get(s : PhysicsheatsteadyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_cursor_set(s : PhysicsheatsteadyCursor, i : Int, v : Double) -> PhysicsheatsteadyCursor {
  let result = physics_heat_steady_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_cursor_sum(s : PhysicsheatsteadyCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_steady_cursor_mean(s : PhysicsheatsteadyCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_steady_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_heat_steady_cursor_scale(s : PhysicsheatsteadyCursor, f : Double) -> PhysicsheatsteadyCursor {
  let result = physics_heat_steady_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_steady_cursor_add(a : PhysicsheatsteadyCursor, b : PhysicsheatsteadyCursor) -> PhysicsheatsteadyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_steady_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_steady_cursor_copy(s : PhysicsheatsteadyCursor) -> PhysicsheatsteadyCursor {
  let result = physics_heat_steady_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_steady_cursor_fill(s : PhysicsheatsteadyCursor, v : Double) -> PhysicsheatsteadyCursor {
  let result = physics_heat_steady_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_cursor_min(s : PhysicsheatsteadyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_cursor_max(s : PhysicsheatsteadyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_cursor_to_string(s : PhysicsheatsteadyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_view_make(size : Int) -> PhysicsheatsteadyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_view_len(s : PhysicsheatsteadyView) -> Int { s.size }

pub fn physics_heat_steady_view_get(s : PhysicsheatsteadyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_view_set(s : PhysicsheatsteadyView, i : Int, v : Double) -> PhysicsheatsteadyView {
  let result = physics_heat_steady_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_view_sum(s : PhysicsheatsteadyView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_steady_view_mean(s : PhysicsheatsteadyView) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_steady_view_sum(s) / s.size.to_double() }
}

pub fn physics_heat_steady_view_scale(s : PhysicsheatsteadyView, f : Double) -> PhysicsheatsteadyView {
  let result = physics_heat_steady_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_steady_view_add(a : PhysicsheatsteadyView, b : PhysicsheatsteadyView) -> PhysicsheatsteadyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_steady_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_steady_view_copy(s : PhysicsheatsteadyView) -> PhysicsheatsteadyView {
  let result = physics_heat_steady_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_steady_view_fill(s : PhysicsheatsteadyView, v : Double) -> PhysicsheatsteadyView {
  let result = physics_heat_steady_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_view_min(s : PhysicsheatsteadyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_view_max(s : PhysicsheatsteadyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_view_to_string(s : PhysicsheatsteadyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_range_make(size : Int) -> PhysicsheatsteadyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_range_len(s : PhysicsheatsteadyRange) -> Int { s.size }

pub fn physics_heat_steady_range_get(s : PhysicsheatsteadyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_range_set(s : PhysicsheatsteadyRange, i : Int, v : Double) -> PhysicsheatsteadyRange {
  let result = physics_heat_steady_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_range_sum(s : PhysicsheatsteadyRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_steady_range_mean(s : PhysicsheatsteadyRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_steady_range_sum(s) / s.size.to_double() }
}

pub fn physics_heat_steady_range_scale(s : PhysicsheatsteadyRange, f : Double) -> PhysicsheatsteadyRange {
  let result = physics_heat_steady_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_steady_range_add(a : PhysicsheatsteadyRange, b : PhysicsheatsteadyRange) -> PhysicsheatsteadyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_steady_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_steady_range_copy(s : PhysicsheatsteadyRange) -> PhysicsheatsteadyRange {
  let result = physics_heat_steady_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_steady_range_fill(s : PhysicsheatsteadyRange, v : Double) -> PhysicsheatsteadyRange {
  let result = physics_heat_steady_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_range_min(s : PhysicsheatsteadyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_range_max(s : PhysicsheatsteadyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_range_to_string(s : PhysicsheatsteadyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsteadySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_steady_slice_make(size : Int) -> PhysicsheatsteadySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_steady_slice_len(s : PhysicsheatsteadySlice) -> Int { s.size }

pub fn physics_heat_steady_slice_get(s : PhysicsheatsteadySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_steady_slice_set(s : PhysicsheatsteadySlice, i : Int, v : Double) -> PhysicsheatsteadySlice {
  let result = physics_heat_steady_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_slice_sum(s : PhysicsheatsteadySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_heat_steady_slice_mean(s : PhysicsheatsteadySlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_heat_steady_slice_sum(s) / s.size.to_double() }
}

pub fn physics_heat_steady_slice_scale(s : PhysicsheatsteadySlice, f : Double) -> PhysicsheatsteadySlice {
  let result = physics_heat_steady_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_steady_slice_add(a : PhysicsheatsteadySlice, b : PhysicsheatsteadySlice) -> PhysicsheatsteadySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_steady_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_steady_slice_copy(s : PhysicsheatsteadySlice) -> PhysicsheatsteadySlice {
  let result = physics_heat_steady_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_steady_slice_fill(s : PhysicsheatsteadySlice, v : Double) -> PhysicsheatsteadySlice {
  let result = physics_heat_steady_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_steady_slice_min(s : PhysicsheatsteadySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_slice_max(s : PhysicsheatsteadySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_heat_steady_slice_to_string(s : PhysicsheatsteadySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

