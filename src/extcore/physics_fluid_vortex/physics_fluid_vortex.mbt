///===
/// extcore/physics_fluid_vortex

pub(all) struct PhysicsfluidvortexPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_vortex_make_point(x : Double, y : Double) -> PhysicsfluidvortexPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_vortex_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidvortexPoint {
  { x, y, z, label: 0 }
}

pub fn physics_fluid_vortex_point_x(pt : PhysicsfluidvortexPoint) -> Double { pt.x }

pub fn physics_fluid_vortex_point_y(pt : PhysicsfluidvortexPoint) -> Double { pt.y }

pub fn physics_fluid_vortex_point_z(pt : PhysicsfluidvortexPoint) -> Double { pt.z }

pub fn physics_fluid_vortex_point_label(pt : PhysicsfluidvortexPoint) -> Int { pt.label }

pub fn physics_fluid_vortex_point_dist(a : PhysicsfluidvortexPoint, b : PhysicsfluidvortexPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_fluid_vortex_point_add(a : PhysicsfluidvortexPoint, b : PhysicsfluidvortexPoint) -> PhysicsfluidvortexPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_fluid_vortex_point_sub(a : PhysicsfluidvortexPoint, b : PhysicsfluidvortexPoint) -> PhysicsfluidvortexPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_fluid_vortex_point_scale(pt : PhysicsfluidvortexPoint, s : Double) -> PhysicsfluidvortexPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_fluid_vortex_point_dot(a : PhysicsfluidvortexPoint, b : PhysicsfluidvortexPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_fluid_vortex_point_cross(a : PhysicsfluidvortexPoint, b : PhysicsfluidvortexPoint) -> PhysicsfluidvortexPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_fluid_vortex_point_norm(pt : PhysicsfluidvortexPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_fluid_vortex_point_normalize(pt : PhysicsfluidvortexPoint) -> PhysicsfluidvortexPoint {
  let n = physics_fluid_vortex_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_fluid_vortex_point_scale(pt, 1.0 / n) }
}

pub fn physics_fluid_vortex_point_negate(pt : PhysicsfluidvortexPoint) -> PhysicsfluidvortexPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_fluid_vortex_point_mid(a : PhysicsfluidvortexPoint, b : PhysicsfluidvortexPoint) -> PhysicsfluidvortexPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_fluid_vortex_point_lerp(a : PhysicsfluidvortexPoint, b : PhysicsfluidvortexPoint, t : Double) -> PhysicsfluidvortexPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_fluid_vortex_point_to_string(pt : PhysicsfluidvortexPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_vortex_make_series(vals : Array[Double], name : String) -> PhysicsfluidvortexSeries {
  { vals, name, meta: 0 }
}

pub fn physics_fluid_vortex_series_len(s : PhysicsfluidvortexSeries) -> Int { s.vals.length() }

pub fn physics_fluid_vortex_series_sum(s : PhysicsfluidvortexSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_fluid_vortex_series_mean(s : PhysicsfluidvortexSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_fluid_vortex_series_min(s : PhysicsfluidvortexSeries) -> Double { @_common.min(s.vals) }

pub fn physics_fluid_vortex_series_max(s : PhysicsfluidvortexSeries) -> Double { @_common.max(s.vals) }

pub fn physics_fluid_vortex_series_range(s : PhysicsfluidvortexSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_fluid_vortex_series_var(s : PhysicsfluidvortexSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_fluid_vortex_series_std(s : PhysicsfluidvortexSeries) -> Double { @_common.std(s.vals) }

pub fn physics_fluid_vortex_series_median(s : PhysicsfluidvortexSeries) -> Double { @_common.median(s.vals) }

pub fn physics_fluid_vortex_series_scale(s : PhysicsfluidvortexSeries, f : Double) -> PhysicsfluidvortexSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_fluid_vortex_series_add(a : PhysicsfluidvortexSeries, b : PhysicsfluidvortexSeries) -> PhysicsfluidvortexSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_fluid_vortex_series_sub(a : PhysicsfluidvortexSeries, b : PhysicsfluidvortexSeries) -> PhysicsfluidvortexSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_fluid_vortex_series_normalize(s : PhysicsfluidvortexSeries) -> PhysicsfluidvortexSeries {
  let mn = physics_fluid_vortex_series_min(s)
  let mx = physics_fluid_vortex_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_fluid_vortex_series_cumsum(s : PhysicsfluidvortexSeries) -> PhysicsfluidvortexSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_fluid_vortex_series_to_string(s : PhysicsfluidvortexSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidvortexMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_vortex_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidvortexMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_vortex_matrix_identity(n : Int) -> PhysicsfluidvortexMatrix {
  let m = physics_fluid_vortex_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_fluid_vortex_matrix_get(m : PhysicsfluidvortexMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_fluid_vortex_matrix_transpose(m : PhysicsfluidvortexMatrix) -> PhysicsfluidvortexMatrix {
  let result = physics_fluid_vortex_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_fluid_vortex_matrix_add(a : PhysicsfluidvortexMatrix, b : PhysicsfluidvortexMatrix) -> PhysicsfluidvortexMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_fluid_vortex_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_fluid_vortex_matrix_scale(m : PhysicsfluidvortexMatrix, s : Double) -> PhysicsfluidvortexMatrix {
  let result = physics_fluid_vortex_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_fluid_vortex_matrix_multiply(a : PhysicsfluidvortexMatrix, b : PhysicsfluidvortexMatrix) -> PhysicsfluidvortexMatrix {
  if a.cols != b.rows { return physics_fluid_vortex_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_fluid_vortex_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_fluid_vortex_matrix_trace(m : PhysicsfluidvortexMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_fluid_vortex_matrix_det(m : PhysicsfluidvortexMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_fluid_vortex_matrix_norm(m : PhysicsfluidvortexMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_fluid_vortex_matrix_to_string(m : PhysicsfluidvortexMatrix) -> String {
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

pub(all) struct PhysicsfluidvortexVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_vortex_make_vector(comps : Array[Double]) -> PhysicsfluidvortexVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_vortex_vector_zero(dim : Int) -> PhysicsfluidvortexVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_fluid_vortex_vector_add(a : PhysicsfluidvortexVector, b : PhysicsfluidvortexVector) -> PhysicsfluidvortexVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_vortex_vector_sub(a : PhysicsfluidvortexVector, b : PhysicsfluidvortexVector) -> PhysicsfluidvortexVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_vortex_vector_scale(v : PhysicsfluidvortexVector, s : Double) -> PhysicsfluidvortexVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_fluid_vortex_vector_dot(a : PhysicsfluidvortexVector, b : PhysicsfluidvortexVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_fluid_vortex_vector_norm(v : PhysicsfluidvortexVector) -> Double { @_common.sqrt(physics_fluid_vortex_vector_dot(v, v)) }

pub fn physics_fluid_vortex_vector_normalize(v : PhysicsfluidvortexVector) -> PhysicsfluidvortexVector {
  let n = physics_fluid_vortex_vector_norm(v)
  if n < 0.0000001 { v } else { physics_fluid_vortex_vector_scale(v, 1.0 / n) }
}

pub fn physics_fluid_vortex_vector_dist(a : PhysicsfluidvortexVector, b : PhysicsfluidvortexVector) -> Double {
  physics_fluid_vortex_vector_norm(physics_fluid_vortex_vector_sub(a, b))
}

pub fn physics_fluid_vortex_vector_to_string(v : PhysicsfluidvortexVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_vortex_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_fluid_vortex_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_fluid_vortex_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_fluid_vortex_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_fluid_vortex_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_fluid_vortex_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_fluid_vortex_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_fluid_vortex_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_fluid_vortex_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_fluid_vortex_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_fluid_vortex_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_fluid_vortex_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_fluid_vortex_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_fluid_vortex_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_fluid_vortex_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_fluid_vortex_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_fluid_vortex_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_fluid_vortex_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_fluid_vortex_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_fluid_vortex_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_fluid_vortex_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_fluid_vortex_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_fluid_vortex_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_fluid_vortex_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_fluid_vortex_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_fluid_vortex_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_fluid_vortex_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_fluid_vortex_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_fluid_vortex_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsfluidvortexFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_frame_make(size : Int) -> PhysicsfluidvortexFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_frame_len(s : PhysicsfluidvortexFrame) -> Int { s.size }

pub fn physics_fluid_vortex_frame_get(s : PhysicsfluidvortexFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_frame_set(s : PhysicsfluidvortexFrame, i : Int, v : Double) -> PhysicsfluidvortexFrame {
  let result = physics_fluid_vortex_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_frame_sum(s : PhysicsfluidvortexFrame) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_frame_mean(s : PhysicsfluidvortexFrame) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_frame_scale(s : PhysicsfluidvortexFrame, f : Double) -> PhysicsfluidvortexFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_frame_add(a : PhysicsfluidvortexFrame, b : PhysicsfluidvortexFrame) -> PhysicsfluidvortexFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_frame_copy(s : PhysicsfluidvortexFrame) -> PhysicsfluidvortexFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_frame_fill(s : PhysicsfluidvortexFrame, v : Double) -> PhysicsfluidvortexFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_frame_min(s : PhysicsfluidvortexFrame) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_frame_max(s : PhysicsfluidvortexFrame) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_frame_to_string(s : PhysicsfluidvortexFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_table_make(size : Int) -> PhysicsfluidvortexTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_table_len(s : PhysicsfluidvortexTable) -> Int { s.size }

pub fn physics_fluid_vortex_table_get(s : PhysicsfluidvortexTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_table_set(s : PhysicsfluidvortexTable, i : Int, v : Double) -> PhysicsfluidvortexTable {
  let result = physics_fluid_vortex_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_table_sum(s : PhysicsfluidvortexTable) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_table_mean(s : PhysicsfluidvortexTable) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_table_scale(s : PhysicsfluidvortexTable, f : Double) -> PhysicsfluidvortexTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_table_add(a : PhysicsfluidvortexTable, b : PhysicsfluidvortexTable) -> PhysicsfluidvortexTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_table_copy(s : PhysicsfluidvortexTable) -> PhysicsfluidvortexTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_table_fill(s : PhysicsfluidvortexTable, v : Double) -> PhysicsfluidvortexTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_table_min(s : PhysicsfluidvortexTable) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_table_max(s : PhysicsfluidvortexTable) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_table_to_string(s : PhysicsfluidvortexTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_graphn_make(size : Int) -> PhysicsfluidvortexGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_graphn_len(s : PhysicsfluidvortexGraphN) -> Int { s.size }

pub fn physics_fluid_vortex_graphn_get(s : PhysicsfluidvortexGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_graphn_set(s : PhysicsfluidvortexGraphN, i : Int, v : Double) -> PhysicsfluidvortexGraphN {
  let result = physics_fluid_vortex_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_graphn_sum(s : PhysicsfluidvortexGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_graphn_mean(s : PhysicsfluidvortexGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_graphn_scale(s : PhysicsfluidvortexGraphN, f : Double) -> PhysicsfluidvortexGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_graphn_add(a : PhysicsfluidvortexGraphN, b : PhysicsfluidvortexGraphN) -> PhysicsfluidvortexGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_graphn_copy(s : PhysicsfluidvortexGraphN) -> PhysicsfluidvortexGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_graphn_fill(s : PhysicsfluidvortexGraphN, v : Double) -> PhysicsfluidvortexGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_graphn_min(s : PhysicsfluidvortexGraphN) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_graphn_max(s : PhysicsfluidvortexGraphN) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_graphn_to_string(s : PhysicsfluidvortexGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_node_make(size : Int) -> PhysicsfluidvortexNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_node_len(s : PhysicsfluidvortexNode) -> Int { s.size }

pub fn physics_fluid_vortex_node_get(s : PhysicsfluidvortexNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_node_set(s : PhysicsfluidvortexNode, i : Int, v : Double) -> PhysicsfluidvortexNode {
  let result = physics_fluid_vortex_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_node_sum(s : PhysicsfluidvortexNode) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_node_mean(s : PhysicsfluidvortexNode) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_node_scale(s : PhysicsfluidvortexNode, f : Double) -> PhysicsfluidvortexNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_node_add(a : PhysicsfluidvortexNode, b : PhysicsfluidvortexNode) -> PhysicsfluidvortexNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_node_copy(s : PhysicsfluidvortexNode) -> PhysicsfluidvortexNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_node_fill(s : PhysicsfluidvortexNode, v : Double) -> PhysicsfluidvortexNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_node_min(s : PhysicsfluidvortexNode) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_node_max(s : PhysicsfluidvortexNode) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_node_to_string(s : PhysicsfluidvortexNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_edge_make(size : Int) -> PhysicsfluidvortexEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_edge_len(s : PhysicsfluidvortexEdge) -> Int { s.size }

pub fn physics_fluid_vortex_edge_get(s : PhysicsfluidvortexEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_edge_set(s : PhysicsfluidvortexEdge, i : Int, v : Double) -> PhysicsfluidvortexEdge {
  let result = physics_fluid_vortex_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_edge_sum(s : PhysicsfluidvortexEdge) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_edge_mean(s : PhysicsfluidvortexEdge) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_edge_scale(s : PhysicsfluidvortexEdge, f : Double) -> PhysicsfluidvortexEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_edge_add(a : PhysicsfluidvortexEdge, b : PhysicsfluidvortexEdge) -> PhysicsfluidvortexEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_edge_copy(s : PhysicsfluidvortexEdge) -> PhysicsfluidvortexEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_edge_fill(s : PhysicsfluidvortexEdge, v : Double) -> PhysicsfluidvortexEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_edge_min(s : PhysicsfluidvortexEdge) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_edge_max(s : PhysicsfluidvortexEdge) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_edge_to_string(s : PhysicsfluidvortexEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_path_make(size : Int) -> PhysicsfluidvortexPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_path_len(s : PhysicsfluidvortexPath) -> Int { s.size }

pub fn physics_fluid_vortex_path_get(s : PhysicsfluidvortexPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_path_set(s : PhysicsfluidvortexPath, i : Int, v : Double) -> PhysicsfluidvortexPath {
  let result = physics_fluid_vortex_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_path_sum(s : PhysicsfluidvortexPath) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_path_mean(s : PhysicsfluidvortexPath) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_path_scale(s : PhysicsfluidvortexPath, f : Double) -> PhysicsfluidvortexPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_path_add(a : PhysicsfluidvortexPath, b : PhysicsfluidvortexPath) -> PhysicsfluidvortexPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_path_copy(s : PhysicsfluidvortexPath) -> PhysicsfluidvortexPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_path_fill(s : PhysicsfluidvortexPath, v : Double) -> PhysicsfluidvortexPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_path_min(s : PhysicsfluidvortexPath) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_path_max(s : PhysicsfluidvortexPath) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_path_to_string(s : PhysicsfluidvortexPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_cluster_make(size : Int) -> PhysicsfluidvortexCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_cluster_len(s : PhysicsfluidvortexCluster) -> Int { s.size }

pub fn physics_fluid_vortex_cluster_get(s : PhysicsfluidvortexCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_cluster_set(s : PhysicsfluidvortexCluster, i : Int, v : Double) -> PhysicsfluidvortexCluster {
  let result = physics_fluid_vortex_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_cluster_sum(s : PhysicsfluidvortexCluster) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_cluster_mean(s : PhysicsfluidvortexCluster) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_cluster_scale(s : PhysicsfluidvortexCluster, f : Double) -> PhysicsfluidvortexCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_cluster_add(a : PhysicsfluidvortexCluster, b : PhysicsfluidvortexCluster) -> PhysicsfluidvortexCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_cluster_copy(s : PhysicsfluidvortexCluster) -> PhysicsfluidvortexCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_cluster_fill(s : PhysicsfluidvortexCluster, v : Double) -> PhysicsfluidvortexCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_cluster_min(s : PhysicsfluidvortexCluster) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_cluster_max(s : PhysicsfluidvortexCluster) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_cluster_to_string(s : PhysicsfluidvortexCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_model_make(size : Int) -> PhysicsfluidvortexModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_model_len(s : PhysicsfluidvortexModel) -> Int { s.size }

pub fn physics_fluid_vortex_model_get(s : PhysicsfluidvortexModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_model_set(s : PhysicsfluidvortexModel, i : Int, v : Double) -> PhysicsfluidvortexModel {
  let result = physics_fluid_vortex_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_model_sum(s : PhysicsfluidvortexModel) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_model_mean(s : PhysicsfluidvortexModel) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_model_scale(s : PhysicsfluidvortexModel, f : Double) -> PhysicsfluidvortexModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_model_add(a : PhysicsfluidvortexModel, b : PhysicsfluidvortexModel) -> PhysicsfluidvortexModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_model_copy(s : PhysicsfluidvortexModel) -> PhysicsfluidvortexModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_model_fill(s : PhysicsfluidvortexModel, v : Double) -> PhysicsfluidvortexModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_model_min(s : PhysicsfluidvortexModel) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_model_max(s : PhysicsfluidvortexModel) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_model_to_string(s : PhysicsfluidvortexModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_layer_make(size : Int) -> PhysicsfluidvortexLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_layer_len(s : PhysicsfluidvortexLayer) -> Int { s.size }

pub fn physics_fluid_vortex_layer_get(s : PhysicsfluidvortexLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_layer_set(s : PhysicsfluidvortexLayer, i : Int, v : Double) -> PhysicsfluidvortexLayer {
  let result = physics_fluid_vortex_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_layer_sum(s : PhysicsfluidvortexLayer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_layer_mean(s : PhysicsfluidvortexLayer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_layer_scale(s : PhysicsfluidvortexLayer, f : Double) -> PhysicsfluidvortexLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_layer_add(a : PhysicsfluidvortexLayer, b : PhysicsfluidvortexLayer) -> PhysicsfluidvortexLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_layer_copy(s : PhysicsfluidvortexLayer) -> PhysicsfluidvortexLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_layer_fill(s : PhysicsfluidvortexLayer, v : Double) -> PhysicsfluidvortexLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_layer_min(s : PhysicsfluidvortexLayer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_layer_max(s : PhysicsfluidvortexLayer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_layer_to_string(s : PhysicsfluidvortexLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_buffer_make(size : Int) -> PhysicsfluidvortexBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_buffer_len(s : PhysicsfluidvortexBuffer) -> Int { s.size }

pub fn physics_fluid_vortex_buffer_get(s : PhysicsfluidvortexBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_buffer_set(s : PhysicsfluidvortexBuffer, i : Int, v : Double) -> PhysicsfluidvortexBuffer {
  let result = physics_fluid_vortex_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_buffer_sum(s : PhysicsfluidvortexBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_buffer_mean(s : PhysicsfluidvortexBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_buffer_scale(s : PhysicsfluidvortexBuffer, f : Double) -> PhysicsfluidvortexBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_buffer_add(a : PhysicsfluidvortexBuffer, b : PhysicsfluidvortexBuffer) -> PhysicsfluidvortexBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_buffer_copy(s : PhysicsfluidvortexBuffer) -> PhysicsfluidvortexBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_buffer_fill(s : PhysicsfluidvortexBuffer, v : Double) -> PhysicsfluidvortexBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_buffer_min(s : PhysicsfluidvortexBuffer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_buffer_max(s : PhysicsfluidvortexBuffer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_buffer_to_string(s : PhysicsfluidvortexBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_cursor_make(size : Int) -> PhysicsfluidvortexCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_cursor_len(s : PhysicsfluidvortexCursor) -> Int { s.size }

pub fn physics_fluid_vortex_cursor_get(s : PhysicsfluidvortexCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_cursor_set(s : PhysicsfluidvortexCursor, i : Int, v : Double) -> PhysicsfluidvortexCursor {
  let result = physics_fluid_vortex_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_cursor_sum(s : PhysicsfluidvortexCursor) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_cursor_mean(s : PhysicsfluidvortexCursor) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_cursor_scale(s : PhysicsfluidvortexCursor, f : Double) -> PhysicsfluidvortexCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_cursor_add(a : PhysicsfluidvortexCursor, b : PhysicsfluidvortexCursor) -> PhysicsfluidvortexCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_cursor_copy(s : PhysicsfluidvortexCursor) -> PhysicsfluidvortexCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_cursor_fill(s : PhysicsfluidvortexCursor, v : Double) -> PhysicsfluidvortexCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_cursor_min(s : PhysicsfluidvortexCursor) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_cursor_max(s : PhysicsfluidvortexCursor) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_cursor_to_string(s : PhysicsfluidvortexCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_view_make(size : Int) -> PhysicsfluidvortexView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_view_len(s : PhysicsfluidvortexView) -> Int { s.size }

pub fn physics_fluid_vortex_view_get(s : PhysicsfluidvortexView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_view_set(s : PhysicsfluidvortexView, i : Int, v : Double) -> PhysicsfluidvortexView {
  let result = physics_fluid_vortex_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_view_sum(s : PhysicsfluidvortexView) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_view_mean(s : PhysicsfluidvortexView) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_view_scale(s : PhysicsfluidvortexView, f : Double) -> PhysicsfluidvortexView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_view_add(a : PhysicsfluidvortexView, b : PhysicsfluidvortexView) -> PhysicsfluidvortexView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_view_copy(s : PhysicsfluidvortexView) -> PhysicsfluidvortexView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_view_fill(s : PhysicsfluidvortexView, v : Double) -> PhysicsfluidvortexView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_view_min(s : PhysicsfluidvortexView) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_view_max(s : PhysicsfluidvortexView) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_view_to_string(s : PhysicsfluidvortexView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_range_make(size : Int) -> PhysicsfluidvortexRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_range_len(s : PhysicsfluidvortexRange) -> Int { s.size }

pub fn physics_fluid_vortex_range_get(s : PhysicsfluidvortexRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_range_set(s : PhysicsfluidvortexRange, i : Int, v : Double) -> PhysicsfluidvortexRange {
  let result = physics_fluid_vortex_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_range_sum(s : PhysicsfluidvortexRange) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_range_mean(s : PhysicsfluidvortexRange) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_range_scale(s : PhysicsfluidvortexRange, f : Double) -> PhysicsfluidvortexRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_range_add(a : PhysicsfluidvortexRange, b : PhysicsfluidvortexRange) -> PhysicsfluidvortexRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_range_copy(s : PhysicsfluidvortexRange) -> PhysicsfluidvortexRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_range_fill(s : PhysicsfluidvortexRange, v : Double) -> PhysicsfluidvortexRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_range_min(s : PhysicsfluidvortexRange) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_range_max(s : PhysicsfluidvortexRange) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_range_to_string(s : PhysicsfluidvortexRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvortexSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_vortex_slice_make(size : Int) -> PhysicsfluidvortexSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_vortex_slice_len(s : PhysicsfluidvortexSlice) -> Int { s.size }

pub fn physics_fluid_vortex_slice_get(s : PhysicsfluidvortexSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_vortex_slice_set(s : PhysicsfluidvortexSlice, i : Int, v : Double) -> PhysicsfluidvortexSlice {
  let result = physics_fluid_vortex_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_vortex_slice_sum(s : PhysicsfluidvortexSlice) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_vortex_slice_mean(s : PhysicsfluidvortexSlice) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_vortex_slice_scale(s : PhysicsfluidvortexSlice, f : Double) -> PhysicsfluidvortexSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_slice_add(a : PhysicsfluidvortexSlice, b : PhysicsfluidvortexSlice) -> PhysicsfluidvortexSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_vortex_slice_copy(s : PhysicsfluidvortexSlice) -> PhysicsfluidvortexSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_slice_fill(s : PhysicsfluidvortexSlice, v : Double) -> PhysicsfluidvortexSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_vortex_slice_min(s : PhysicsfluidvortexSlice) -> Double { @_common.min(s.data) }

pub fn physics_fluid_vortex_slice_max(s : PhysicsfluidvortexSlice) -> Double { @_common.max(s.data) }

pub fn physics_fluid_vortex_slice_to_string(s : PhysicsfluidvortexSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

