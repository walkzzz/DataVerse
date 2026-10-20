///===
/// extcore/physics_em_maxwell

pub(all) struct PhysicsemmaxwellPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_maxwell_make_point(x : Double, y : Double) -> PhysicsemmaxwellPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_maxwell_make_point3(x : Double, y : Double, z : Double) -> PhysicsemmaxwellPoint {
  { x, y, z, label: 0 }
}

pub fn physics_em_maxwell_point_x(pt : PhysicsemmaxwellPoint) -> Double { pt.x }

pub fn physics_em_maxwell_point_y(pt : PhysicsemmaxwellPoint) -> Double { pt.y }

pub fn physics_em_maxwell_point_z(pt : PhysicsemmaxwellPoint) -> Double { pt.z }

pub fn physics_em_maxwell_point_label(pt : PhysicsemmaxwellPoint) -> Int { pt.label }

pub fn physics_em_maxwell_point_dist(a : PhysicsemmaxwellPoint, b : PhysicsemmaxwellPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_em_maxwell_point_add(a : PhysicsemmaxwellPoint, b : PhysicsemmaxwellPoint) -> PhysicsemmaxwellPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_em_maxwell_point_sub(a : PhysicsemmaxwellPoint, b : PhysicsemmaxwellPoint) -> PhysicsemmaxwellPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_em_maxwell_point_scale(pt : PhysicsemmaxwellPoint, s : Double) -> PhysicsemmaxwellPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_em_maxwell_point_dot(a : PhysicsemmaxwellPoint, b : PhysicsemmaxwellPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_em_maxwell_point_cross(a : PhysicsemmaxwellPoint, b : PhysicsemmaxwellPoint) -> PhysicsemmaxwellPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_em_maxwell_point_norm(pt : PhysicsemmaxwellPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_em_maxwell_point_normalize(pt : PhysicsemmaxwellPoint) -> PhysicsemmaxwellPoint {
  let n = physics_em_maxwell_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_em_maxwell_point_scale(pt, 1.0 / n) }
}

pub fn physics_em_maxwell_point_negate(pt : PhysicsemmaxwellPoint) -> PhysicsemmaxwellPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_em_maxwell_point_mid(a : PhysicsemmaxwellPoint, b : PhysicsemmaxwellPoint) -> PhysicsemmaxwellPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_em_maxwell_point_lerp(a : PhysicsemmaxwellPoint, b : PhysicsemmaxwellPoint, t : Double) -> PhysicsemmaxwellPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_em_maxwell_point_to_string(pt : PhysicsemmaxwellPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_maxwell_make_series(vals : Array[Double], name : String) -> PhysicsemmaxwellSeries {
  { vals, name, meta: 0 }
}

pub fn physics_em_maxwell_series_len(s : PhysicsemmaxwellSeries) -> Int { s.vals.length() }

pub fn physics_em_maxwell_series_sum(s : PhysicsemmaxwellSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_em_maxwell_series_mean(s : PhysicsemmaxwellSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_em_maxwell_series_min(s : PhysicsemmaxwellSeries) -> Double { @_common.min(s.vals) }

pub fn physics_em_maxwell_series_max(s : PhysicsemmaxwellSeries) -> Double { @_common.max(s.vals) }

pub fn physics_em_maxwell_series_range(s : PhysicsemmaxwellSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_em_maxwell_series_var(s : PhysicsemmaxwellSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_em_maxwell_series_std(s : PhysicsemmaxwellSeries) -> Double { @_common.std(s.vals) }

pub fn physics_em_maxwell_series_median(s : PhysicsemmaxwellSeries) -> Double { @_common.median(s.vals) }

pub fn physics_em_maxwell_series_scale(s : PhysicsemmaxwellSeries, f : Double) -> PhysicsemmaxwellSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_em_maxwell_series_add(a : PhysicsemmaxwellSeries, b : PhysicsemmaxwellSeries) -> PhysicsemmaxwellSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_em_maxwell_series_sub(a : PhysicsemmaxwellSeries, b : PhysicsemmaxwellSeries) -> PhysicsemmaxwellSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_em_maxwell_series_normalize(s : PhysicsemmaxwellSeries) -> PhysicsemmaxwellSeries {
  let mn = physics_em_maxwell_series_min(s)
  let mx = physics_em_maxwell_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_em_maxwell_series_cumsum(s : PhysicsemmaxwellSeries) -> PhysicsemmaxwellSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_em_maxwell_series_to_string(s : PhysicsemmaxwellSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemmaxwellMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_maxwell_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemmaxwellMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_maxwell_matrix_identity(n : Int) -> PhysicsemmaxwellMatrix {
  let m = physics_em_maxwell_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_em_maxwell_matrix_get(m : PhysicsemmaxwellMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_em_maxwell_matrix_transpose(m : PhysicsemmaxwellMatrix) -> PhysicsemmaxwellMatrix {
  let result = physics_em_maxwell_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_em_maxwell_matrix_add(a : PhysicsemmaxwellMatrix, b : PhysicsemmaxwellMatrix) -> PhysicsemmaxwellMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_em_maxwell_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_em_maxwell_matrix_scale(m : PhysicsemmaxwellMatrix, s : Double) -> PhysicsemmaxwellMatrix {
  let result = physics_em_maxwell_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_em_maxwell_matrix_multiply(a : PhysicsemmaxwellMatrix, b : PhysicsemmaxwellMatrix) -> PhysicsemmaxwellMatrix {
  if a.cols != b.rows { return physics_em_maxwell_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_em_maxwell_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_em_maxwell_matrix_trace(m : PhysicsemmaxwellMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_em_maxwell_matrix_det(m : PhysicsemmaxwellMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_em_maxwell_matrix_norm(m : PhysicsemmaxwellMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_em_maxwell_matrix_to_string(m : PhysicsemmaxwellMatrix) -> String {
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

pub(all) struct PhysicsemmaxwellVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_maxwell_make_vector(comps : Array[Double]) -> PhysicsemmaxwellVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_maxwell_vector_zero(dim : Int) -> PhysicsemmaxwellVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_em_maxwell_vector_add(a : PhysicsemmaxwellVector, b : PhysicsemmaxwellVector) -> PhysicsemmaxwellVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_maxwell_vector_sub(a : PhysicsemmaxwellVector, b : PhysicsemmaxwellVector) -> PhysicsemmaxwellVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_maxwell_vector_scale(v : PhysicsemmaxwellVector, s : Double) -> PhysicsemmaxwellVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_em_maxwell_vector_dot(a : PhysicsemmaxwellVector, b : PhysicsemmaxwellVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_em_maxwell_vector_norm(v : PhysicsemmaxwellVector) -> Double { @_common.sqrt(physics_em_maxwell_vector_dot(v, v)) }

pub fn physics_em_maxwell_vector_normalize(v : PhysicsemmaxwellVector) -> PhysicsemmaxwellVector {
  let n = physics_em_maxwell_vector_norm(v)
  if n < 0.0000001 { v } else { physics_em_maxwell_vector_scale(v, 1.0 / n) }
}

pub fn physics_em_maxwell_vector_dist(a : PhysicsemmaxwellVector, b : PhysicsemmaxwellVector) -> Double {
  physics_em_maxwell_vector_norm(physics_em_maxwell_vector_sub(a, b))
}

pub fn physics_em_maxwell_vector_to_string(v : PhysicsemmaxwellVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_em_maxwell_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_em_maxwell_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_em_maxwell_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_em_maxwell_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_em_maxwell_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_em_maxwell_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_em_maxwell_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_em_maxwell_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_em_maxwell_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_em_maxwell_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_em_maxwell_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_em_maxwell_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_em_maxwell_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_em_maxwell_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_em_maxwell_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_em_maxwell_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_em_maxwell_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_em_maxwell_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_em_maxwell_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_em_maxwell_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_em_maxwell_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_em_maxwell_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_em_maxwell_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_em_maxwell_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_em_maxwell_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_em_maxwell_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_em_maxwell_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_em_maxwell_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_em_maxwell_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsemmaxwellFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_frame_make(size : Int) -> PhysicsemmaxwellFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_frame_len(s : PhysicsemmaxwellFrame) -> Int { s.size }

pub fn physics_em_maxwell_frame_get(s : PhysicsemmaxwellFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_frame_set(s : PhysicsemmaxwellFrame, i : Int, v : Double) -> PhysicsemmaxwellFrame {
  let result = physics_em_maxwell_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_frame_sum(s : PhysicsemmaxwellFrame) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_frame_mean(s : PhysicsemmaxwellFrame) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_frame_scale(s : PhysicsemmaxwellFrame, f : Double) -> PhysicsemmaxwellFrame {
  let result = physics_em_maxwell_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_maxwell_frame_add(a : PhysicsemmaxwellFrame, b : PhysicsemmaxwellFrame) -> PhysicsemmaxwellFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_maxwell_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_maxwell_frame_copy(s : PhysicsemmaxwellFrame) -> PhysicsemmaxwellFrame {
  let result = physics_em_maxwell_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_maxwell_frame_fill(s : PhysicsemmaxwellFrame, v : Double) -> PhysicsemmaxwellFrame {
  let result = physics_em_maxwell_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_frame_min(s : PhysicsemmaxwellFrame) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_frame_max(s : PhysicsemmaxwellFrame) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_frame_to_string(s : PhysicsemmaxwellFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_table_make(size : Int) -> PhysicsemmaxwellTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_table_len(s : PhysicsemmaxwellTable) -> Int { s.size }

pub fn physics_em_maxwell_table_get(s : PhysicsemmaxwellTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_table_set(s : PhysicsemmaxwellTable, i : Int, v : Double) -> PhysicsemmaxwellTable {
  let result = physics_em_maxwell_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_table_sum(s : PhysicsemmaxwellTable) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_table_mean(s : PhysicsemmaxwellTable) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_table_scale(s : PhysicsemmaxwellTable, f : Double) -> PhysicsemmaxwellTable {
  let result = physics_em_maxwell_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_maxwell_table_add(a : PhysicsemmaxwellTable, b : PhysicsemmaxwellTable) -> PhysicsemmaxwellTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_maxwell_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_maxwell_table_copy(s : PhysicsemmaxwellTable) -> PhysicsemmaxwellTable {
  let result = physics_em_maxwell_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_maxwell_table_fill(s : PhysicsemmaxwellTable, v : Double) -> PhysicsemmaxwellTable {
  let result = physics_em_maxwell_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_table_min(s : PhysicsemmaxwellTable) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_table_max(s : PhysicsemmaxwellTable) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_table_to_string(s : PhysicsemmaxwellTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_graphn_make(size : Int) -> PhysicsemmaxwellGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_graphn_len(s : PhysicsemmaxwellGraphN) -> Int { s.size }

pub fn physics_em_maxwell_graphn_get(s : PhysicsemmaxwellGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_graphn_set(s : PhysicsemmaxwellGraphN, i : Int, v : Double) -> PhysicsemmaxwellGraphN {
  let result = physics_em_maxwell_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_graphn_sum(s : PhysicsemmaxwellGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_graphn_mean(s : PhysicsemmaxwellGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_graphn_scale(s : PhysicsemmaxwellGraphN, f : Double) -> PhysicsemmaxwellGraphN {
  let result = physics_em_maxwell_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_maxwell_graphn_add(a : PhysicsemmaxwellGraphN, b : PhysicsemmaxwellGraphN) -> PhysicsemmaxwellGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_maxwell_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_maxwell_graphn_copy(s : PhysicsemmaxwellGraphN) -> PhysicsemmaxwellGraphN {
  let result = physics_em_maxwell_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_maxwell_graphn_fill(s : PhysicsemmaxwellGraphN, v : Double) -> PhysicsemmaxwellGraphN {
  let result = physics_em_maxwell_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_graphn_min(s : PhysicsemmaxwellGraphN) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_graphn_max(s : PhysicsemmaxwellGraphN) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_graphn_to_string(s : PhysicsemmaxwellGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_node_make(size : Int) -> PhysicsemmaxwellNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_node_len(s : PhysicsemmaxwellNode) -> Int { s.size }

pub fn physics_em_maxwell_node_get(s : PhysicsemmaxwellNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_node_set(s : PhysicsemmaxwellNode, i : Int, v : Double) -> PhysicsemmaxwellNode {
  let result = physics_em_maxwell_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_node_sum(s : PhysicsemmaxwellNode) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_node_mean(s : PhysicsemmaxwellNode) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_node_scale(s : PhysicsemmaxwellNode, f : Double) -> PhysicsemmaxwellNode {
  let result = physics_em_maxwell_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_maxwell_node_add(a : PhysicsemmaxwellNode, b : PhysicsemmaxwellNode) -> PhysicsemmaxwellNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_maxwell_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_maxwell_node_copy(s : PhysicsemmaxwellNode) -> PhysicsemmaxwellNode {
  let result = physics_em_maxwell_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_maxwell_node_fill(s : PhysicsemmaxwellNode, v : Double) -> PhysicsemmaxwellNode {
  let result = physics_em_maxwell_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_node_min(s : PhysicsemmaxwellNode) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_node_max(s : PhysicsemmaxwellNode) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_node_to_string(s : PhysicsemmaxwellNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_edge_make(size : Int) -> PhysicsemmaxwellEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_edge_len(s : PhysicsemmaxwellEdge) -> Int { s.size }

pub fn physics_em_maxwell_edge_get(s : PhysicsemmaxwellEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_edge_set(s : PhysicsemmaxwellEdge, i : Int, v : Double) -> PhysicsemmaxwellEdge {
  let result = physics_em_maxwell_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_edge_sum(s : PhysicsemmaxwellEdge) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_edge_mean(s : PhysicsemmaxwellEdge) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_edge_scale(s : PhysicsemmaxwellEdge, f : Double) -> PhysicsemmaxwellEdge {
  let result = physics_em_maxwell_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_maxwell_edge_add(a : PhysicsemmaxwellEdge, b : PhysicsemmaxwellEdge) -> PhysicsemmaxwellEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_maxwell_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_maxwell_edge_copy(s : PhysicsemmaxwellEdge) -> PhysicsemmaxwellEdge {
  let result = physics_em_maxwell_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_maxwell_edge_fill(s : PhysicsemmaxwellEdge, v : Double) -> PhysicsemmaxwellEdge {
  let result = physics_em_maxwell_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_edge_min(s : PhysicsemmaxwellEdge) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_edge_max(s : PhysicsemmaxwellEdge) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_edge_to_string(s : PhysicsemmaxwellEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_path_make(size : Int) -> PhysicsemmaxwellPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_path_len(s : PhysicsemmaxwellPath) -> Int { s.size }

pub fn physics_em_maxwell_path_get(s : PhysicsemmaxwellPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_path_set(s : PhysicsemmaxwellPath, i : Int, v : Double) -> PhysicsemmaxwellPath {
  let result = physics_em_maxwell_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_path_sum(s : PhysicsemmaxwellPath) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_path_mean(s : PhysicsemmaxwellPath) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_path_scale(s : PhysicsemmaxwellPath, f : Double) -> PhysicsemmaxwellPath {
  let result = physics_em_maxwell_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_maxwell_path_add(a : PhysicsemmaxwellPath, b : PhysicsemmaxwellPath) -> PhysicsemmaxwellPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_maxwell_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_maxwell_path_copy(s : PhysicsemmaxwellPath) -> PhysicsemmaxwellPath {
  let result = physics_em_maxwell_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_maxwell_path_fill(s : PhysicsemmaxwellPath, v : Double) -> PhysicsemmaxwellPath {
  let result = physics_em_maxwell_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_path_min(s : PhysicsemmaxwellPath) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_path_max(s : PhysicsemmaxwellPath) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_path_to_string(s : PhysicsemmaxwellPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_cluster_make(size : Int) -> PhysicsemmaxwellCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_cluster_len(s : PhysicsemmaxwellCluster) -> Int { s.size }

pub fn physics_em_maxwell_cluster_get(s : PhysicsemmaxwellCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_cluster_set(s : PhysicsemmaxwellCluster, i : Int, v : Double) -> PhysicsemmaxwellCluster {
  let result = physics_em_maxwell_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_cluster_sum(s : PhysicsemmaxwellCluster) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_cluster_mean(s : PhysicsemmaxwellCluster) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_cluster_scale(s : PhysicsemmaxwellCluster, f : Double) -> PhysicsemmaxwellCluster {
  let result = physics_em_maxwell_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_maxwell_cluster_add(a : PhysicsemmaxwellCluster, b : PhysicsemmaxwellCluster) -> PhysicsemmaxwellCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_maxwell_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_maxwell_cluster_copy(s : PhysicsemmaxwellCluster) -> PhysicsemmaxwellCluster {
  let result = physics_em_maxwell_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_maxwell_cluster_fill(s : PhysicsemmaxwellCluster, v : Double) -> PhysicsemmaxwellCluster {
  let result = physics_em_maxwell_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_cluster_min(s : PhysicsemmaxwellCluster) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_cluster_max(s : PhysicsemmaxwellCluster) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_cluster_to_string(s : PhysicsemmaxwellCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_model_make(size : Int) -> PhysicsemmaxwellModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_model_len(s : PhysicsemmaxwellModel) -> Int { s.size }

pub fn physics_em_maxwell_model_get(s : PhysicsemmaxwellModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_model_set(s : PhysicsemmaxwellModel, i : Int, v : Double) -> PhysicsemmaxwellModel {
  let result = physics_em_maxwell_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_model_sum(s : PhysicsemmaxwellModel) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_model_mean(s : PhysicsemmaxwellModel) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_model_scale(s : PhysicsemmaxwellModel, f : Double) -> PhysicsemmaxwellModel {
  let result = physics_em_maxwell_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_maxwell_model_add(a : PhysicsemmaxwellModel, b : PhysicsemmaxwellModel) -> PhysicsemmaxwellModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_maxwell_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_maxwell_model_copy(s : PhysicsemmaxwellModel) -> PhysicsemmaxwellModel {
  let result = physics_em_maxwell_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_maxwell_model_fill(s : PhysicsemmaxwellModel, v : Double) -> PhysicsemmaxwellModel {
  let result = physics_em_maxwell_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_model_min(s : PhysicsemmaxwellModel) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_model_max(s : PhysicsemmaxwellModel) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_model_to_string(s : PhysicsemmaxwellModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_layer_make(size : Int) -> PhysicsemmaxwellLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_layer_len(s : PhysicsemmaxwellLayer) -> Int { s.size }

pub fn physics_em_maxwell_layer_get(s : PhysicsemmaxwellLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_layer_set(s : PhysicsemmaxwellLayer, i : Int, v : Double) -> PhysicsemmaxwellLayer {
  let result = physics_em_maxwell_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_layer_sum(s : PhysicsemmaxwellLayer) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_layer_mean(s : PhysicsemmaxwellLayer) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_layer_scale(s : PhysicsemmaxwellLayer, f : Double) -> PhysicsemmaxwellLayer {
  let result = physics_em_maxwell_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_maxwell_layer_add(a : PhysicsemmaxwellLayer, b : PhysicsemmaxwellLayer) -> PhysicsemmaxwellLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_maxwell_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_maxwell_layer_copy(s : PhysicsemmaxwellLayer) -> PhysicsemmaxwellLayer {
  let result = physics_em_maxwell_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_maxwell_layer_fill(s : PhysicsemmaxwellLayer, v : Double) -> PhysicsemmaxwellLayer {
  let result = physics_em_maxwell_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_layer_min(s : PhysicsemmaxwellLayer) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_layer_max(s : PhysicsemmaxwellLayer) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_layer_to_string(s : PhysicsemmaxwellLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_buffer_make(size : Int) -> PhysicsemmaxwellBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_buffer_len(s : PhysicsemmaxwellBuffer) -> Int { s.size }

pub fn physics_em_maxwell_buffer_get(s : PhysicsemmaxwellBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_buffer_set(s : PhysicsemmaxwellBuffer, i : Int, v : Double) -> PhysicsemmaxwellBuffer {
  let result = physics_em_maxwell_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_buffer_sum(s : PhysicsemmaxwellBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_buffer_mean(s : PhysicsemmaxwellBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_buffer_scale(s : PhysicsemmaxwellBuffer, f : Double) -> PhysicsemmaxwellBuffer {
  let result = physics_em_maxwell_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_maxwell_buffer_add(a : PhysicsemmaxwellBuffer, b : PhysicsemmaxwellBuffer) -> PhysicsemmaxwellBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_maxwell_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_maxwell_buffer_copy(s : PhysicsemmaxwellBuffer) -> PhysicsemmaxwellBuffer {
  let result = physics_em_maxwell_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_maxwell_buffer_fill(s : PhysicsemmaxwellBuffer, v : Double) -> PhysicsemmaxwellBuffer {
  let result = physics_em_maxwell_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_buffer_min(s : PhysicsemmaxwellBuffer) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_buffer_max(s : PhysicsemmaxwellBuffer) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_buffer_to_string(s : PhysicsemmaxwellBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_cursor_make(size : Int) -> PhysicsemmaxwellCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_cursor_len(s : PhysicsemmaxwellCursor) -> Int { s.size }

pub fn physics_em_maxwell_cursor_get(s : PhysicsemmaxwellCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_cursor_set(s : PhysicsemmaxwellCursor, i : Int, v : Double) -> PhysicsemmaxwellCursor {
  let result = physics_em_maxwell_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_cursor_sum(s : PhysicsemmaxwellCursor) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_cursor_mean(s : PhysicsemmaxwellCursor) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_cursor_scale(s : PhysicsemmaxwellCursor, f : Double) -> PhysicsemmaxwellCursor {
  let result = physics_em_maxwell_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_maxwell_cursor_add(a : PhysicsemmaxwellCursor, b : PhysicsemmaxwellCursor) -> PhysicsemmaxwellCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_maxwell_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_maxwell_cursor_copy(s : PhysicsemmaxwellCursor) -> PhysicsemmaxwellCursor {
  let result = physics_em_maxwell_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_maxwell_cursor_fill(s : PhysicsemmaxwellCursor, v : Double) -> PhysicsemmaxwellCursor {
  let result = physics_em_maxwell_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_cursor_min(s : PhysicsemmaxwellCursor) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_cursor_max(s : PhysicsemmaxwellCursor) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_cursor_to_string(s : PhysicsemmaxwellCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_view_make(size : Int) -> PhysicsemmaxwellView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_view_len(s : PhysicsemmaxwellView) -> Int { s.size }

pub fn physics_em_maxwell_view_get(s : PhysicsemmaxwellView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_view_set(s : PhysicsemmaxwellView, i : Int, v : Double) -> PhysicsemmaxwellView {
  let result = physics_em_maxwell_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_view_sum(s : PhysicsemmaxwellView) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_view_mean(s : PhysicsemmaxwellView) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_view_scale(s : PhysicsemmaxwellView, f : Double) -> PhysicsemmaxwellView {
  let result = physics_em_maxwell_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_maxwell_view_add(a : PhysicsemmaxwellView, b : PhysicsemmaxwellView) -> PhysicsemmaxwellView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_maxwell_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_maxwell_view_copy(s : PhysicsemmaxwellView) -> PhysicsemmaxwellView {
  let result = physics_em_maxwell_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_maxwell_view_fill(s : PhysicsemmaxwellView, v : Double) -> PhysicsemmaxwellView {
  let result = physics_em_maxwell_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_view_min(s : PhysicsemmaxwellView) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_view_max(s : PhysicsemmaxwellView) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_view_to_string(s : PhysicsemmaxwellView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_range_make(size : Int) -> PhysicsemmaxwellRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_range_len(s : PhysicsemmaxwellRange) -> Int { s.size }

pub fn physics_em_maxwell_range_get(s : PhysicsemmaxwellRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_range_set(s : PhysicsemmaxwellRange, i : Int, v : Double) -> PhysicsemmaxwellRange {
  let result = physics_em_maxwell_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_range_sum(s : PhysicsemmaxwellRange) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_range_mean(s : PhysicsemmaxwellRange) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_range_scale(s : PhysicsemmaxwellRange, f : Double) -> PhysicsemmaxwellRange {
  let result = physics_em_maxwell_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_maxwell_range_add(a : PhysicsemmaxwellRange, b : PhysicsemmaxwellRange) -> PhysicsemmaxwellRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_maxwell_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_maxwell_range_copy(s : PhysicsemmaxwellRange) -> PhysicsemmaxwellRange {
  let result = physics_em_maxwell_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_maxwell_range_fill(s : PhysicsemmaxwellRange, v : Double) -> PhysicsemmaxwellRange {
  let result = physics_em_maxwell_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_range_min(s : PhysicsemmaxwellRange) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_range_max(s : PhysicsemmaxwellRange) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_range_to_string(s : PhysicsemmaxwellRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemmaxwellSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_maxwell_slice_make(size : Int) -> PhysicsemmaxwellSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_maxwell_slice_len(s : PhysicsemmaxwellSlice) -> Int { s.size }

pub fn physics_em_maxwell_slice_get(s : PhysicsemmaxwellSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_maxwell_slice_set(s : PhysicsemmaxwellSlice, i : Int, v : Double) -> PhysicsemmaxwellSlice {
  let result = physics_em_maxwell_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_slice_sum(s : PhysicsemmaxwellSlice) -> Double { @_common.sum(s.data) }

pub fn physics_em_maxwell_slice_mean(s : PhysicsemmaxwellSlice) -> Double { @_common.mean(s.data) }

pub fn physics_em_maxwell_slice_scale(s : PhysicsemmaxwellSlice, f : Double) -> PhysicsemmaxwellSlice {
  let result = physics_em_maxwell_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_maxwell_slice_add(a : PhysicsemmaxwellSlice, b : PhysicsemmaxwellSlice) -> PhysicsemmaxwellSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_maxwell_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_maxwell_slice_copy(s : PhysicsemmaxwellSlice) -> PhysicsemmaxwellSlice {
  let result = physics_em_maxwell_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_maxwell_slice_fill(s : PhysicsemmaxwellSlice, v : Double) -> PhysicsemmaxwellSlice {
  let result = physics_em_maxwell_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_maxwell_slice_min(s : PhysicsemmaxwellSlice) -> Double { @_common.min(s.data) }

pub fn physics_em_maxwell_slice_max(s : PhysicsemmaxwellSlice) -> Double { @_common.max(s.data) }

pub fn physics_em_maxwell_slice_to_string(s : PhysicsemmaxwellSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

