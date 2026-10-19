///===
/// extcore/physics_em_electrostatic

pub(all) struct PhysicsemelectrostaticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_electrostatic_make_point(x : Double, y : Double) -> PhysicsemelectrostaticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_electrostatic_make_point3(x : Double, y : Double, z : Double) -> PhysicsemelectrostaticPoint {
  { x, y, z, label: 0 }
}

pub fn physics_em_electrostatic_point_x(pt : PhysicsemelectrostaticPoint) -> Double { pt.x }

pub fn physics_em_electrostatic_point_y(pt : PhysicsemelectrostaticPoint) -> Double { pt.y }

pub fn physics_em_electrostatic_point_z(pt : PhysicsemelectrostaticPoint) -> Double { pt.z }

pub fn physics_em_electrostatic_point_label(pt : PhysicsemelectrostaticPoint) -> Int { pt.label }

pub fn physics_em_electrostatic_point_dist(a : PhysicsemelectrostaticPoint, b : PhysicsemelectrostaticPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_em_electrostatic_point_add(a : PhysicsemelectrostaticPoint, b : PhysicsemelectrostaticPoint) -> PhysicsemelectrostaticPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_em_electrostatic_point_sub(a : PhysicsemelectrostaticPoint, b : PhysicsemelectrostaticPoint) -> PhysicsemelectrostaticPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_em_electrostatic_point_scale(pt : PhysicsemelectrostaticPoint, s : Double) -> PhysicsemelectrostaticPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_em_electrostatic_point_dot(a : PhysicsemelectrostaticPoint, b : PhysicsemelectrostaticPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_em_electrostatic_point_cross(a : PhysicsemelectrostaticPoint, b : PhysicsemelectrostaticPoint) -> PhysicsemelectrostaticPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_em_electrostatic_point_norm(pt : PhysicsemelectrostaticPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_em_electrostatic_point_normalize(pt : PhysicsemelectrostaticPoint) -> PhysicsemelectrostaticPoint {
  let n = physics_em_electrostatic_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_em_electrostatic_point_scale(pt, 1.0 / n) }
}

pub fn physics_em_electrostatic_point_negate(pt : PhysicsemelectrostaticPoint) -> PhysicsemelectrostaticPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_em_electrostatic_point_mid(a : PhysicsemelectrostaticPoint, b : PhysicsemelectrostaticPoint) -> PhysicsemelectrostaticPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_em_electrostatic_point_lerp(a : PhysicsemelectrostaticPoint, b : PhysicsemelectrostaticPoint, t : Double) -> PhysicsemelectrostaticPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_em_electrostatic_point_to_string(pt : PhysicsemelectrostaticPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_electrostatic_make_series(vals : Array[Double], name : String) -> PhysicsemelectrostaticSeries {
  { vals, name, meta: 0 }
}

pub fn physics_em_electrostatic_series_len(s : PhysicsemelectrostaticSeries) -> Int { s.vals.length() }

pub fn physics_em_electrostatic_series_sum(s : PhysicsemelectrostaticSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_em_electrostatic_series_mean(s : PhysicsemelectrostaticSeries) -> Double {
  let n = physics_em_electrostatic_series_len(s)
  if n == 0 { 0.0 } else { physics_em_electrostatic_series_sum(s) / n.to_double() }
}

pub fn physics_em_electrostatic_series_min(s : PhysicsemelectrostaticSeries) -> Double {
  let n = physics_em_electrostatic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn physics_em_electrostatic_series_max(s : PhysicsemelectrostaticSeries) -> Double {
  let n = physics_em_electrostatic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn physics_em_electrostatic_series_range(s : PhysicsemelectrostaticSeries) -> Double {
  physics_em_electrostatic_series_max(s) - physics_em_electrostatic_series_min(s)
}

pub fn physics_em_electrostatic_series_var(s : PhysicsemelectrostaticSeries) -> Double {
  let n = physics_em_electrostatic_series_len(s)
  if n == 0 { 0.0 } else {
    let m = physics_em_electrostatic_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn physics_em_electrostatic_series_std(s : PhysicsemelectrostaticSeries) -> Double { @_common.sqrt(physics_em_electrostatic_series_var(s)) }

pub fn physics_em_electrostatic_series_median(s : PhysicsemelectrostaticSeries) -> Double {
  let n = physics_em_electrostatic_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = physics_em_electrostatic_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn physics_em_electrostatic_series_scale(s : PhysicsemelectrostaticSeries, f : Double) -> PhysicsemelectrostaticSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_em_electrostatic_series_add(a : PhysicsemelectrostaticSeries, b : PhysicsemelectrostaticSeries) -> PhysicsemelectrostaticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_em_electrostatic_series_sub(a : PhysicsemelectrostaticSeries, b : PhysicsemelectrostaticSeries) -> PhysicsemelectrostaticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_em_electrostatic_series_normalize(s : PhysicsemelectrostaticSeries) -> PhysicsemelectrostaticSeries {
  let mn = physics_em_electrostatic_series_min(s)
  let mx = physics_em_electrostatic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_em_electrostatic_series_cumsum(s : PhysicsemelectrostaticSeries) -> PhysicsemelectrostaticSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_em_electrostatic_series_to_string(s : PhysicsemelectrostaticSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemelectrostaticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_electrostatic_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemelectrostaticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_electrostatic_matrix_identity(n : Int) -> PhysicsemelectrostaticMatrix {
  let m = physics_em_electrostatic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_em_electrostatic_matrix_get(m : PhysicsemelectrostaticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_em_electrostatic_matrix_transpose(m : PhysicsemelectrostaticMatrix) -> PhysicsemelectrostaticMatrix {
  let result = physics_em_electrostatic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_em_electrostatic_matrix_add(a : PhysicsemelectrostaticMatrix, b : PhysicsemelectrostaticMatrix) -> PhysicsemelectrostaticMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_em_electrostatic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_em_electrostatic_matrix_scale(m : PhysicsemelectrostaticMatrix, s : Double) -> PhysicsemelectrostaticMatrix {
  let result = physics_em_electrostatic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_em_electrostatic_matrix_multiply(a : PhysicsemelectrostaticMatrix, b : PhysicsemelectrostaticMatrix) -> PhysicsemelectrostaticMatrix {
  if a.cols != b.rows { return physics_em_electrostatic_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_em_electrostatic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_em_electrostatic_matrix_trace(m : PhysicsemelectrostaticMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_em_electrostatic_matrix_det(m : PhysicsemelectrostaticMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_em_electrostatic_matrix_norm(m : PhysicsemelectrostaticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_em_electrostatic_matrix_to_string(m : PhysicsemelectrostaticMatrix) -> String {
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

pub(all) struct PhysicsemelectrostaticVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_electrostatic_make_vector(comps : Array[Double]) -> PhysicsemelectrostaticVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_electrostatic_vector_zero(dim : Int) -> PhysicsemelectrostaticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_em_electrostatic_vector_add(a : PhysicsemelectrostaticVector, b : PhysicsemelectrostaticVector) -> PhysicsemelectrostaticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_electrostatic_vector_sub(a : PhysicsemelectrostaticVector, b : PhysicsemelectrostaticVector) -> PhysicsemelectrostaticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_electrostatic_vector_scale(v : PhysicsemelectrostaticVector, s : Double) -> PhysicsemelectrostaticVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_em_electrostatic_vector_dot(a : PhysicsemelectrostaticVector, b : PhysicsemelectrostaticVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_em_electrostatic_vector_norm(v : PhysicsemelectrostaticVector) -> Double { @_common.sqrt(physics_em_electrostatic_vector_dot(v, v)) }

pub fn physics_em_electrostatic_vector_normalize(v : PhysicsemelectrostaticVector) -> PhysicsemelectrostaticVector {
  let n = physics_em_electrostatic_vector_norm(v)
  if n < 0.0000001 { v } else { physics_em_electrostatic_vector_scale(v, 1.0 / n) }
}

pub fn physics_em_electrostatic_vector_dist(a : PhysicsemelectrostaticVector, b : PhysicsemelectrostaticVector) -> Double {
  physics_em_electrostatic_vector_norm(physics_em_electrostatic_vector_sub(a, b))
}

pub fn physics_em_electrostatic_vector_to_string(v : PhysicsemelectrostaticVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_em_electrostatic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_em_electrostatic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_em_electrostatic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_em_electrostatic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_em_electrostatic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_em_electrostatic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_em_electrostatic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_em_electrostatic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_em_electrostatic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_em_electrostatic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_em_electrostatic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_em_electrostatic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_em_electrostatic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_em_electrostatic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_em_electrostatic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_em_electrostatic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_em_electrostatic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_em_electrostatic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_em_electrostatic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_em_electrostatic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_em_electrostatic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_em_electrostatic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_em_electrostatic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_em_electrostatic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_em_electrostatic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_em_electrostatic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_em_electrostatic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_em_electrostatic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_em_electrostatic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsemelectrostaticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_frame_make(size : Int) -> PhysicsemelectrostaticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_frame_len(s : PhysicsemelectrostaticFrame) -> Int { s.size }

pub fn physics_em_electrostatic_frame_get(s : PhysicsemelectrostaticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_frame_set(s : PhysicsemelectrostaticFrame, i : Int, v : Double) -> PhysicsemelectrostaticFrame {
  let result = physics_em_electrostatic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_frame_sum(s : PhysicsemelectrostaticFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_electrostatic_frame_mean(s : PhysicsemelectrostaticFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_electrostatic_frame_sum(s) / s.size.to_double() }
}

pub fn physics_em_electrostatic_frame_scale(s : PhysicsemelectrostaticFrame, f : Double) -> PhysicsemelectrostaticFrame {
  let result = physics_em_electrostatic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_electrostatic_frame_add(a : PhysicsemelectrostaticFrame, b : PhysicsemelectrostaticFrame) -> PhysicsemelectrostaticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_electrostatic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_electrostatic_frame_copy(s : PhysicsemelectrostaticFrame) -> PhysicsemelectrostaticFrame {
  let result = physics_em_electrostatic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_electrostatic_frame_fill(s : PhysicsemelectrostaticFrame, v : Double) -> PhysicsemelectrostaticFrame {
  let result = physics_em_electrostatic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_frame_min(s : PhysicsemelectrostaticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_frame_max(s : PhysicsemelectrostaticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_frame_to_string(s : PhysicsemelectrostaticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_table_make(size : Int) -> PhysicsemelectrostaticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_table_len(s : PhysicsemelectrostaticTable) -> Int { s.size }

pub fn physics_em_electrostatic_table_get(s : PhysicsemelectrostaticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_table_set(s : PhysicsemelectrostaticTable, i : Int, v : Double) -> PhysicsemelectrostaticTable {
  let result = physics_em_electrostatic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_table_sum(s : PhysicsemelectrostaticTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_electrostatic_table_mean(s : PhysicsemelectrostaticTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_electrostatic_table_sum(s) / s.size.to_double() }
}

pub fn physics_em_electrostatic_table_scale(s : PhysicsemelectrostaticTable, f : Double) -> PhysicsemelectrostaticTable {
  let result = physics_em_electrostatic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_electrostatic_table_add(a : PhysicsemelectrostaticTable, b : PhysicsemelectrostaticTable) -> PhysicsemelectrostaticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_electrostatic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_electrostatic_table_copy(s : PhysicsemelectrostaticTable) -> PhysicsemelectrostaticTable {
  let result = physics_em_electrostatic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_electrostatic_table_fill(s : PhysicsemelectrostaticTable, v : Double) -> PhysicsemelectrostaticTable {
  let result = physics_em_electrostatic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_table_min(s : PhysicsemelectrostaticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_table_max(s : PhysicsemelectrostaticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_table_to_string(s : PhysicsemelectrostaticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_graphn_make(size : Int) -> PhysicsemelectrostaticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_graphn_len(s : PhysicsemelectrostaticGraphN) -> Int { s.size }

pub fn physics_em_electrostatic_graphn_get(s : PhysicsemelectrostaticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_graphn_set(s : PhysicsemelectrostaticGraphN, i : Int, v : Double) -> PhysicsemelectrostaticGraphN {
  let result = physics_em_electrostatic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_graphn_sum(s : PhysicsemelectrostaticGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_electrostatic_graphn_mean(s : PhysicsemelectrostaticGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_electrostatic_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_em_electrostatic_graphn_scale(s : PhysicsemelectrostaticGraphN, f : Double) -> PhysicsemelectrostaticGraphN {
  let result = physics_em_electrostatic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_electrostatic_graphn_add(a : PhysicsemelectrostaticGraphN, b : PhysicsemelectrostaticGraphN) -> PhysicsemelectrostaticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_electrostatic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_electrostatic_graphn_copy(s : PhysicsemelectrostaticGraphN) -> PhysicsemelectrostaticGraphN {
  let result = physics_em_electrostatic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_electrostatic_graphn_fill(s : PhysicsemelectrostaticGraphN, v : Double) -> PhysicsemelectrostaticGraphN {
  let result = physics_em_electrostatic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_graphn_min(s : PhysicsemelectrostaticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_graphn_max(s : PhysicsemelectrostaticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_graphn_to_string(s : PhysicsemelectrostaticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_node_make(size : Int) -> PhysicsemelectrostaticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_node_len(s : PhysicsemelectrostaticNode) -> Int { s.size }

pub fn physics_em_electrostatic_node_get(s : PhysicsemelectrostaticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_node_set(s : PhysicsemelectrostaticNode, i : Int, v : Double) -> PhysicsemelectrostaticNode {
  let result = physics_em_electrostatic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_node_sum(s : PhysicsemelectrostaticNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_electrostatic_node_mean(s : PhysicsemelectrostaticNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_electrostatic_node_sum(s) / s.size.to_double() }
}

pub fn physics_em_electrostatic_node_scale(s : PhysicsemelectrostaticNode, f : Double) -> PhysicsemelectrostaticNode {
  let result = physics_em_electrostatic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_electrostatic_node_add(a : PhysicsemelectrostaticNode, b : PhysicsemelectrostaticNode) -> PhysicsemelectrostaticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_electrostatic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_electrostatic_node_copy(s : PhysicsemelectrostaticNode) -> PhysicsemelectrostaticNode {
  let result = physics_em_electrostatic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_electrostatic_node_fill(s : PhysicsemelectrostaticNode, v : Double) -> PhysicsemelectrostaticNode {
  let result = physics_em_electrostatic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_node_min(s : PhysicsemelectrostaticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_node_max(s : PhysicsemelectrostaticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_node_to_string(s : PhysicsemelectrostaticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_edge_make(size : Int) -> PhysicsemelectrostaticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_edge_len(s : PhysicsemelectrostaticEdge) -> Int { s.size }

pub fn physics_em_electrostatic_edge_get(s : PhysicsemelectrostaticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_edge_set(s : PhysicsemelectrostaticEdge, i : Int, v : Double) -> PhysicsemelectrostaticEdge {
  let result = physics_em_electrostatic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_edge_sum(s : PhysicsemelectrostaticEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_electrostatic_edge_mean(s : PhysicsemelectrostaticEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_electrostatic_edge_sum(s) / s.size.to_double() }
}

pub fn physics_em_electrostatic_edge_scale(s : PhysicsemelectrostaticEdge, f : Double) -> PhysicsemelectrostaticEdge {
  let result = physics_em_electrostatic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_electrostatic_edge_add(a : PhysicsemelectrostaticEdge, b : PhysicsemelectrostaticEdge) -> PhysicsemelectrostaticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_electrostatic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_electrostatic_edge_copy(s : PhysicsemelectrostaticEdge) -> PhysicsemelectrostaticEdge {
  let result = physics_em_electrostatic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_electrostatic_edge_fill(s : PhysicsemelectrostaticEdge, v : Double) -> PhysicsemelectrostaticEdge {
  let result = physics_em_electrostatic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_edge_min(s : PhysicsemelectrostaticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_edge_max(s : PhysicsemelectrostaticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_edge_to_string(s : PhysicsemelectrostaticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_path_make(size : Int) -> PhysicsemelectrostaticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_path_len(s : PhysicsemelectrostaticPath) -> Int { s.size }

pub fn physics_em_electrostatic_path_get(s : PhysicsemelectrostaticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_path_set(s : PhysicsemelectrostaticPath, i : Int, v : Double) -> PhysicsemelectrostaticPath {
  let result = physics_em_electrostatic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_path_sum(s : PhysicsemelectrostaticPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_electrostatic_path_mean(s : PhysicsemelectrostaticPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_electrostatic_path_sum(s) / s.size.to_double() }
}

pub fn physics_em_electrostatic_path_scale(s : PhysicsemelectrostaticPath, f : Double) -> PhysicsemelectrostaticPath {
  let result = physics_em_electrostatic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_electrostatic_path_add(a : PhysicsemelectrostaticPath, b : PhysicsemelectrostaticPath) -> PhysicsemelectrostaticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_electrostatic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_electrostatic_path_copy(s : PhysicsemelectrostaticPath) -> PhysicsemelectrostaticPath {
  let result = physics_em_electrostatic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_electrostatic_path_fill(s : PhysicsemelectrostaticPath, v : Double) -> PhysicsemelectrostaticPath {
  let result = physics_em_electrostatic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_path_min(s : PhysicsemelectrostaticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_path_max(s : PhysicsemelectrostaticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_path_to_string(s : PhysicsemelectrostaticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_cluster_make(size : Int) -> PhysicsemelectrostaticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_cluster_len(s : PhysicsemelectrostaticCluster) -> Int { s.size }

pub fn physics_em_electrostatic_cluster_get(s : PhysicsemelectrostaticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_cluster_set(s : PhysicsemelectrostaticCluster, i : Int, v : Double) -> PhysicsemelectrostaticCluster {
  let result = physics_em_electrostatic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_cluster_sum(s : PhysicsemelectrostaticCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_electrostatic_cluster_mean(s : PhysicsemelectrostaticCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_electrostatic_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_em_electrostatic_cluster_scale(s : PhysicsemelectrostaticCluster, f : Double) -> PhysicsemelectrostaticCluster {
  let result = physics_em_electrostatic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_electrostatic_cluster_add(a : PhysicsemelectrostaticCluster, b : PhysicsemelectrostaticCluster) -> PhysicsemelectrostaticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_electrostatic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_electrostatic_cluster_copy(s : PhysicsemelectrostaticCluster) -> PhysicsemelectrostaticCluster {
  let result = physics_em_electrostatic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_electrostatic_cluster_fill(s : PhysicsemelectrostaticCluster, v : Double) -> PhysicsemelectrostaticCluster {
  let result = physics_em_electrostatic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_cluster_min(s : PhysicsemelectrostaticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_cluster_max(s : PhysicsemelectrostaticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_cluster_to_string(s : PhysicsemelectrostaticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_model_make(size : Int) -> PhysicsemelectrostaticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_model_len(s : PhysicsemelectrostaticModel) -> Int { s.size }

pub fn physics_em_electrostatic_model_get(s : PhysicsemelectrostaticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_model_set(s : PhysicsemelectrostaticModel, i : Int, v : Double) -> PhysicsemelectrostaticModel {
  let result = physics_em_electrostatic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_model_sum(s : PhysicsemelectrostaticModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_electrostatic_model_mean(s : PhysicsemelectrostaticModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_electrostatic_model_sum(s) / s.size.to_double() }
}

pub fn physics_em_electrostatic_model_scale(s : PhysicsemelectrostaticModel, f : Double) -> PhysicsemelectrostaticModel {
  let result = physics_em_electrostatic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_electrostatic_model_add(a : PhysicsemelectrostaticModel, b : PhysicsemelectrostaticModel) -> PhysicsemelectrostaticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_electrostatic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_electrostatic_model_copy(s : PhysicsemelectrostaticModel) -> PhysicsemelectrostaticModel {
  let result = physics_em_electrostatic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_electrostatic_model_fill(s : PhysicsemelectrostaticModel, v : Double) -> PhysicsemelectrostaticModel {
  let result = physics_em_electrostatic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_model_min(s : PhysicsemelectrostaticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_model_max(s : PhysicsemelectrostaticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_model_to_string(s : PhysicsemelectrostaticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_layer_make(size : Int) -> PhysicsemelectrostaticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_layer_len(s : PhysicsemelectrostaticLayer) -> Int { s.size }

pub fn physics_em_electrostatic_layer_get(s : PhysicsemelectrostaticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_layer_set(s : PhysicsemelectrostaticLayer, i : Int, v : Double) -> PhysicsemelectrostaticLayer {
  let result = physics_em_electrostatic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_layer_sum(s : PhysicsemelectrostaticLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_electrostatic_layer_mean(s : PhysicsemelectrostaticLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_electrostatic_layer_sum(s) / s.size.to_double() }
}

pub fn physics_em_electrostatic_layer_scale(s : PhysicsemelectrostaticLayer, f : Double) -> PhysicsemelectrostaticLayer {
  let result = physics_em_electrostatic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_electrostatic_layer_add(a : PhysicsemelectrostaticLayer, b : PhysicsemelectrostaticLayer) -> PhysicsemelectrostaticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_electrostatic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_electrostatic_layer_copy(s : PhysicsemelectrostaticLayer) -> PhysicsemelectrostaticLayer {
  let result = physics_em_electrostatic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_electrostatic_layer_fill(s : PhysicsemelectrostaticLayer, v : Double) -> PhysicsemelectrostaticLayer {
  let result = physics_em_electrostatic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_layer_min(s : PhysicsemelectrostaticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_layer_max(s : PhysicsemelectrostaticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_layer_to_string(s : PhysicsemelectrostaticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_buffer_make(size : Int) -> PhysicsemelectrostaticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_buffer_len(s : PhysicsemelectrostaticBuffer) -> Int { s.size }

pub fn physics_em_electrostatic_buffer_get(s : PhysicsemelectrostaticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_buffer_set(s : PhysicsemelectrostaticBuffer, i : Int, v : Double) -> PhysicsemelectrostaticBuffer {
  let result = physics_em_electrostatic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_buffer_sum(s : PhysicsemelectrostaticBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_electrostatic_buffer_mean(s : PhysicsemelectrostaticBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_electrostatic_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_em_electrostatic_buffer_scale(s : PhysicsemelectrostaticBuffer, f : Double) -> PhysicsemelectrostaticBuffer {
  let result = physics_em_electrostatic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_electrostatic_buffer_add(a : PhysicsemelectrostaticBuffer, b : PhysicsemelectrostaticBuffer) -> PhysicsemelectrostaticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_electrostatic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_electrostatic_buffer_copy(s : PhysicsemelectrostaticBuffer) -> PhysicsemelectrostaticBuffer {
  let result = physics_em_electrostatic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_electrostatic_buffer_fill(s : PhysicsemelectrostaticBuffer, v : Double) -> PhysicsemelectrostaticBuffer {
  let result = physics_em_electrostatic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_buffer_min(s : PhysicsemelectrostaticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_buffer_max(s : PhysicsemelectrostaticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_buffer_to_string(s : PhysicsemelectrostaticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_cursor_make(size : Int) -> PhysicsemelectrostaticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_cursor_len(s : PhysicsemelectrostaticCursor) -> Int { s.size }

pub fn physics_em_electrostatic_cursor_get(s : PhysicsemelectrostaticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_cursor_set(s : PhysicsemelectrostaticCursor, i : Int, v : Double) -> PhysicsemelectrostaticCursor {
  let result = physics_em_electrostatic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_cursor_sum(s : PhysicsemelectrostaticCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_electrostatic_cursor_mean(s : PhysicsemelectrostaticCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_electrostatic_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_em_electrostatic_cursor_scale(s : PhysicsemelectrostaticCursor, f : Double) -> PhysicsemelectrostaticCursor {
  let result = physics_em_electrostatic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_electrostatic_cursor_add(a : PhysicsemelectrostaticCursor, b : PhysicsemelectrostaticCursor) -> PhysicsemelectrostaticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_electrostatic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_electrostatic_cursor_copy(s : PhysicsemelectrostaticCursor) -> PhysicsemelectrostaticCursor {
  let result = physics_em_electrostatic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_electrostatic_cursor_fill(s : PhysicsemelectrostaticCursor, v : Double) -> PhysicsemelectrostaticCursor {
  let result = physics_em_electrostatic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_cursor_min(s : PhysicsemelectrostaticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_cursor_max(s : PhysicsemelectrostaticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_cursor_to_string(s : PhysicsemelectrostaticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_view_make(size : Int) -> PhysicsemelectrostaticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_view_len(s : PhysicsemelectrostaticView) -> Int { s.size }

pub fn physics_em_electrostatic_view_get(s : PhysicsemelectrostaticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_view_set(s : PhysicsemelectrostaticView, i : Int, v : Double) -> PhysicsemelectrostaticView {
  let result = physics_em_electrostatic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_view_sum(s : PhysicsemelectrostaticView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_electrostatic_view_mean(s : PhysicsemelectrostaticView) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_electrostatic_view_sum(s) / s.size.to_double() }
}

pub fn physics_em_electrostatic_view_scale(s : PhysicsemelectrostaticView, f : Double) -> PhysicsemelectrostaticView {
  let result = physics_em_electrostatic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_electrostatic_view_add(a : PhysicsemelectrostaticView, b : PhysicsemelectrostaticView) -> PhysicsemelectrostaticView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_electrostatic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_electrostatic_view_copy(s : PhysicsemelectrostaticView) -> PhysicsemelectrostaticView {
  let result = physics_em_electrostatic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_electrostatic_view_fill(s : PhysicsemelectrostaticView, v : Double) -> PhysicsemelectrostaticView {
  let result = physics_em_electrostatic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_view_min(s : PhysicsemelectrostaticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_view_max(s : PhysicsemelectrostaticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_view_to_string(s : PhysicsemelectrostaticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_range_make(size : Int) -> PhysicsemelectrostaticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_range_len(s : PhysicsemelectrostaticRange) -> Int { s.size }

pub fn physics_em_electrostatic_range_get(s : PhysicsemelectrostaticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_range_set(s : PhysicsemelectrostaticRange, i : Int, v : Double) -> PhysicsemelectrostaticRange {
  let result = physics_em_electrostatic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_range_sum(s : PhysicsemelectrostaticRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_electrostatic_range_mean(s : PhysicsemelectrostaticRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_electrostatic_range_sum(s) / s.size.to_double() }
}

pub fn physics_em_electrostatic_range_scale(s : PhysicsemelectrostaticRange, f : Double) -> PhysicsemelectrostaticRange {
  let result = physics_em_electrostatic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_electrostatic_range_add(a : PhysicsemelectrostaticRange, b : PhysicsemelectrostaticRange) -> PhysicsemelectrostaticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_electrostatic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_electrostatic_range_copy(s : PhysicsemelectrostaticRange) -> PhysicsemelectrostaticRange {
  let result = physics_em_electrostatic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_electrostatic_range_fill(s : PhysicsemelectrostaticRange, v : Double) -> PhysicsemelectrostaticRange {
  let result = physics_em_electrostatic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_range_min(s : PhysicsemelectrostaticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_range_max(s : PhysicsemelectrostaticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_range_to_string(s : PhysicsemelectrostaticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemelectrostaticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_electrostatic_slice_make(size : Int) -> PhysicsemelectrostaticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_electrostatic_slice_len(s : PhysicsemelectrostaticSlice) -> Int { s.size }

pub fn physics_em_electrostatic_slice_get(s : PhysicsemelectrostaticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_electrostatic_slice_set(s : PhysicsemelectrostaticSlice, i : Int, v : Double) -> PhysicsemelectrostaticSlice {
  let result = physics_em_electrostatic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_slice_sum(s : PhysicsemelectrostaticSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_em_electrostatic_slice_mean(s : PhysicsemelectrostaticSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_em_electrostatic_slice_sum(s) / s.size.to_double() }
}

pub fn physics_em_electrostatic_slice_scale(s : PhysicsemelectrostaticSlice, f : Double) -> PhysicsemelectrostaticSlice {
  let result = physics_em_electrostatic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_electrostatic_slice_add(a : PhysicsemelectrostaticSlice, b : PhysicsemelectrostaticSlice) -> PhysicsemelectrostaticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_electrostatic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_electrostatic_slice_copy(s : PhysicsemelectrostaticSlice) -> PhysicsemelectrostaticSlice {
  let result = physics_em_electrostatic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_electrostatic_slice_fill(s : PhysicsemelectrostaticSlice, v : Double) -> PhysicsemelectrostaticSlice {
  let result = physics_em_electrostatic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_electrostatic_slice_min(s : PhysicsemelectrostaticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_slice_max(s : PhysicsemelectrostaticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_em_electrostatic_slice_to_string(s : PhysicsemelectrostaticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

