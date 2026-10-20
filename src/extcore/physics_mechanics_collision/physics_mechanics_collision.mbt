///===
/// extcore/physics_mechanics_collision

pub(all) struct PhysicsmechanicscollisionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_collision_make_point(x : Double, y : Double) -> PhysicsmechanicscollisionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_collision_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicscollisionPoint {
  { x, y, z, label: 0 }
}

pub fn physics_mechanics_collision_point_x(pt : PhysicsmechanicscollisionPoint) -> Double { pt.x }

pub fn physics_mechanics_collision_point_y(pt : PhysicsmechanicscollisionPoint) -> Double { pt.y }

pub fn physics_mechanics_collision_point_z(pt : PhysicsmechanicscollisionPoint) -> Double { pt.z }

pub fn physics_mechanics_collision_point_label(pt : PhysicsmechanicscollisionPoint) -> Int { pt.label }

pub fn physics_mechanics_collision_point_dist(a : PhysicsmechanicscollisionPoint, b : PhysicsmechanicscollisionPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_mechanics_collision_point_add(a : PhysicsmechanicscollisionPoint, b : PhysicsmechanicscollisionPoint) -> PhysicsmechanicscollisionPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_mechanics_collision_point_sub(a : PhysicsmechanicscollisionPoint, b : PhysicsmechanicscollisionPoint) -> PhysicsmechanicscollisionPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_mechanics_collision_point_scale(pt : PhysicsmechanicscollisionPoint, s : Double) -> PhysicsmechanicscollisionPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_mechanics_collision_point_dot(a : PhysicsmechanicscollisionPoint, b : PhysicsmechanicscollisionPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_mechanics_collision_point_cross(a : PhysicsmechanicscollisionPoint, b : PhysicsmechanicscollisionPoint) -> PhysicsmechanicscollisionPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_mechanics_collision_point_norm(pt : PhysicsmechanicscollisionPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_mechanics_collision_point_normalize(pt : PhysicsmechanicscollisionPoint) -> PhysicsmechanicscollisionPoint {
  let n = physics_mechanics_collision_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_mechanics_collision_point_scale(pt, 1.0 / n) }
}

pub fn physics_mechanics_collision_point_negate(pt : PhysicsmechanicscollisionPoint) -> PhysicsmechanicscollisionPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_mechanics_collision_point_mid(a : PhysicsmechanicscollisionPoint, b : PhysicsmechanicscollisionPoint) -> PhysicsmechanicscollisionPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_mechanics_collision_point_lerp(a : PhysicsmechanicscollisionPoint, b : PhysicsmechanicscollisionPoint, t : Double) -> PhysicsmechanicscollisionPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_mechanics_collision_point_to_string(pt : PhysicsmechanicscollisionPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_collision_make_series(vals : Array[Double], name : String) -> PhysicsmechanicscollisionSeries {
  { vals, name, meta: 0 }
}

pub fn physics_mechanics_collision_series_len(s : PhysicsmechanicscollisionSeries) -> Int { s.vals.length() }

pub fn physics_mechanics_collision_series_sum(s : PhysicsmechanicscollisionSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_mechanics_collision_series_mean(s : PhysicsmechanicscollisionSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_mechanics_collision_series_min(s : PhysicsmechanicscollisionSeries) -> Double { @_common.min(s.vals) }

pub fn physics_mechanics_collision_series_max(s : PhysicsmechanicscollisionSeries) -> Double { @_common.max(s.vals) }

pub fn physics_mechanics_collision_series_range(s : PhysicsmechanicscollisionSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_mechanics_collision_series_var(s : PhysicsmechanicscollisionSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_mechanics_collision_series_std(s : PhysicsmechanicscollisionSeries) -> Double { @_common.std(s.vals) }

pub fn physics_mechanics_collision_series_median(s : PhysicsmechanicscollisionSeries) -> Double { @_common.median(s.vals) }

pub fn physics_mechanics_collision_series_scale(s : PhysicsmechanicscollisionSeries, f : Double) -> PhysicsmechanicscollisionSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn physics_mechanics_collision_series_add(a : PhysicsmechanicscollisionSeries, b : PhysicsmechanicscollisionSeries) -> PhysicsmechanicscollisionSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_mechanics_collision_series_sub(a : PhysicsmechanicscollisionSeries, b : PhysicsmechanicscollisionSeries) -> PhysicsmechanicscollisionSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_mechanics_collision_series_normalize(s : PhysicsmechanicscollisionSeries) -> PhysicsmechanicscollisionSeries {
  let mn = physics_mechanics_collision_series_min(s)
  let mx = physics_mechanics_collision_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_mechanics_collision_series_cumsum(s : PhysicsmechanicscollisionSeries) -> PhysicsmechanicscollisionSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_mechanics_collision_series_to_string(s : PhysicsmechanicscollisionSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicscollisionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_collision_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicscollisionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_collision_matrix_identity(n : Int) -> PhysicsmechanicscollisionMatrix {
  let m = physics_mechanics_collision_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_mechanics_collision_matrix_get(m : PhysicsmechanicscollisionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_mechanics_collision_matrix_transpose(m : PhysicsmechanicscollisionMatrix) -> PhysicsmechanicscollisionMatrix {
  let result = physics_mechanics_collision_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_mechanics_collision_matrix_add(a : PhysicsmechanicscollisionMatrix, b : PhysicsmechanicscollisionMatrix) -> PhysicsmechanicscollisionMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_mechanics_collision_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_mechanics_collision_matrix_scale(m : PhysicsmechanicscollisionMatrix, s : Double) -> PhysicsmechanicscollisionMatrix {
  let result = physics_mechanics_collision_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_mechanics_collision_matrix_multiply(a : PhysicsmechanicscollisionMatrix, b : PhysicsmechanicscollisionMatrix) -> PhysicsmechanicscollisionMatrix {
  if a.cols != b.rows { return physics_mechanics_collision_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_mechanics_collision_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_mechanics_collision_matrix_trace(m : PhysicsmechanicscollisionMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_mechanics_collision_matrix_det(m : PhysicsmechanicscollisionMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_mechanics_collision_matrix_norm(m : PhysicsmechanicscollisionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_mechanics_collision_matrix_to_string(m : PhysicsmechanicscollisionMatrix) -> String {
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

pub(all) struct PhysicsmechanicscollisionVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_collision_make_vector(comps : Array[Double]) -> PhysicsmechanicscollisionVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_collision_vector_zero(dim : Int) -> PhysicsmechanicscollisionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_mechanics_collision_vector_add(a : PhysicsmechanicscollisionVector, b : PhysicsmechanicscollisionVector) -> PhysicsmechanicscollisionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn physics_mechanics_collision_vector_sub(a : PhysicsmechanicscollisionVector, b : PhysicsmechanicscollisionVector) -> PhysicsmechanicscollisionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn physics_mechanics_collision_vector_scale(v : PhysicsmechanicscollisionVector, s : Double) -> PhysicsmechanicscollisionVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn physics_mechanics_collision_vector_dot(a : PhysicsmechanicscollisionVector, b : PhysicsmechanicscollisionVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_mechanics_collision_vector_norm(v : PhysicsmechanicscollisionVector) -> Double { @_common.sqrt(physics_mechanics_collision_vector_dot(v, v)) }

pub fn physics_mechanics_collision_vector_normalize(v : PhysicsmechanicscollisionVector) -> PhysicsmechanicscollisionVector {
  let n = physics_mechanics_collision_vector_norm(v)
  if n < 0.0000001 { v } else { physics_mechanics_collision_vector_scale(v, 1.0 / n) }
}

pub fn physics_mechanics_collision_vector_dist(a : PhysicsmechanicscollisionVector, b : PhysicsmechanicscollisionVector) -> Double {
  physics_mechanics_collision_vector_norm(physics_mechanics_collision_vector_sub(a, b))
}

pub fn physics_mechanics_collision_vector_to_string(v : PhysicsmechanicscollisionVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_collision_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_mechanics_collision_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_mechanics_collision_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_mechanics_collision_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_mechanics_collision_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_mechanics_collision_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_mechanics_collision_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_mechanics_collision_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_mechanics_collision_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_mechanics_collision_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_mechanics_collision_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_mechanics_collision_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_mechanics_collision_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_mechanics_collision_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_mechanics_collision_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_mechanics_collision_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_mechanics_collision_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_mechanics_collision_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_mechanics_collision_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_mechanics_collision_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_mechanics_collision_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_mechanics_collision_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_mechanics_collision_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_mechanics_collision_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_mechanics_collision_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_mechanics_collision_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_mechanics_collision_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_mechanics_collision_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_mechanics_collision_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsmechanicscollisionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_frame_make(size : Int) -> PhysicsmechanicscollisionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_collision_frame_len(s : PhysicsmechanicscollisionFrame) -> Int { s.size }

pub fn physics_mechanics_collision_frame_get(s : PhysicsmechanicscollisionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_collision_frame_set(s : PhysicsmechanicscollisionFrame, i : Int, v : Double) -> PhysicsmechanicscollisionFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_frame_sum(s : PhysicsmechanicscollisionFrame) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_collision_frame_mean(s : PhysicsmechanicscollisionFrame) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_collision_frame_scale(s : PhysicsmechanicscollisionFrame, f : Double) -> PhysicsmechanicscollisionFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_frame_add(a : PhysicsmechanicscollisionFrame, b : PhysicsmechanicscollisionFrame) -> PhysicsmechanicscollisionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_collision_frame_copy(s : PhysicsmechanicscollisionFrame) -> PhysicsmechanicscollisionFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_frame_fill(s : PhysicsmechanicscollisionFrame, v : Double) -> PhysicsmechanicscollisionFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_frame_min(s : PhysicsmechanicscollisionFrame) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_collision_frame_max(s : PhysicsmechanicscollisionFrame) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_collision_frame_to_string(s : PhysicsmechanicscollisionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_table_make(size : Int) -> PhysicsmechanicscollisionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_collision_table_len(s : PhysicsmechanicscollisionTable) -> Int { s.size }

pub fn physics_mechanics_collision_table_get(s : PhysicsmechanicscollisionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_collision_table_set(s : PhysicsmechanicscollisionTable, i : Int, v : Double) -> PhysicsmechanicscollisionTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_table_sum(s : PhysicsmechanicscollisionTable) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_collision_table_mean(s : PhysicsmechanicscollisionTable) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_collision_table_scale(s : PhysicsmechanicscollisionTable, f : Double) -> PhysicsmechanicscollisionTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_table_add(a : PhysicsmechanicscollisionTable, b : PhysicsmechanicscollisionTable) -> PhysicsmechanicscollisionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_collision_table_copy(s : PhysicsmechanicscollisionTable) -> PhysicsmechanicscollisionTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_table_fill(s : PhysicsmechanicscollisionTable, v : Double) -> PhysicsmechanicscollisionTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_table_min(s : PhysicsmechanicscollisionTable) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_collision_table_max(s : PhysicsmechanicscollisionTable) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_collision_table_to_string(s : PhysicsmechanicscollisionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_graphn_make(size : Int) -> PhysicsmechanicscollisionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_collision_graphn_len(s : PhysicsmechanicscollisionGraphN) -> Int { s.size }

pub fn physics_mechanics_collision_graphn_get(s : PhysicsmechanicscollisionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_collision_graphn_set(s : PhysicsmechanicscollisionGraphN, i : Int, v : Double) -> PhysicsmechanicscollisionGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_graphn_sum(s : PhysicsmechanicscollisionGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_collision_graphn_mean(s : PhysicsmechanicscollisionGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_collision_graphn_scale(s : PhysicsmechanicscollisionGraphN, f : Double) -> PhysicsmechanicscollisionGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_graphn_add(a : PhysicsmechanicscollisionGraphN, b : PhysicsmechanicscollisionGraphN) -> PhysicsmechanicscollisionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_collision_graphn_copy(s : PhysicsmechanicscollisionGraphN) -> PhysicsmechanicscollisionGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_graphn_fill(s : PhysicsmechanicscollisionGraphN, v : Double) -> PhysicsmechanicscollisionGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_graphn_min(s : PhysicsmechanicscollisionGraphN) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_collision_graphn_max(s : PhysicsmechanicscollisionGraphN) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_collision_graphn_to_string(s : PhysicsmechanicscollisionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_node_make(size : Int) -> PhysicsmechanicscollisionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_collision_node_len(s : PhysicsmechanicscollisionNode) -> Int { s.size }

pub fn physics_mechanics_collision_node_get(s : PhysicsmechanicscollisionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_collision_node_set(s : PhysicsmechanicscollisionNode, i : Int, v : Double) -> PhysicsmechanicscollisionNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_node_sum(s : PhysicsmechanicscollisionNode) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_collision_node_mean(s : PhysicsmechanicscollisionNode) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_collision_node_scale(s : PhysicsmechanicscollisionNode, f : Double) -> PhysicsmechanicscollisionNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_node_add(a : PhysicsmechanicscollisionNode, b : PhysicsmechanicscollisionNode) -> PhysicsmechanicscollisionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_collision_node_copy(s : PhysicsmechanicscollisionNode) -> PhysicsmechanicscollisionNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_node_fill(s : PhysicsmechanicscollisionNode, v : Double) -> PhysicsmechanicscollisionNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_node_min(s : PhysicsmechanicscollisionNode) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_collision_node_max(s : PhysicsmechanicscollisionNode) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_collision_node_to_string(s : PhysicsmechanicscollisionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_edge_make(size : Int) -> PhysicsmechanicscollisionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_collision_edge_len(s : PhysicsmechanicscollisionEdge) -> Int { s.size }

pub fn physics_mechanics_collision_edge_get(s : PhysicsmechanicscollisionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_collision_edge_set(s : PhysicsmechanicscollisionEdge, i : Int, v : Double) -> PhysicsmechanicscollisionEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_edge_sum(s : PhysicsmechanicscollisionEdge) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_collision_edge_mean(s : PhysicsmechanicscollisionEdge) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_collision_edge_scale(s : PhysicsmechanicscollisionEdge, f : Double) -> PhysicsmechanicscollisionEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_edge_add(a : PhysicsmechanicscollisionEdge, b : PhysicsmechanicscollisionEdge) -> PhysicsmechanicscollisionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_collision_edge_copy(s : PhysicsmechanicscollisionEdge) -> PhysicsmechanicscollisionEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_edge_fill(s : PhysicsmechanicscollisionEdge, v : Double) -> PhysicsmechanicscollisionEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_edge_min(s : PhysicsmechanicscollisionEdge) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_collision_edge_max(s : PhysicsmechanicscollisionEdge) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_collision_edge_to_string(s : PhysicsmechanicscollisionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_path_make(size : Int) -> PhysicsmechanicscollisionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_collision_path_len(s : PhysicsmechanicscollisionPath) -> Int { s.size }

pub fn physics_mechanics_collision_path_get(s : PhysicsmechanicscollisionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_collision_path_set(s : PhysicsmechanicscollisionPath, i : Int, v : Double) -> PhysicsmechanicscollisionPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_path_sum(s : PhysicsmechanicscollisionPath) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_collision_path_mean(s : PhysicsmechanicscollisionPath) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_collision_path_scale(s : PhysicsmechanicscollisionPath, f : Double) -> PhysicsmechanicscollisionPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_path_add(a : PhysicsmechanicscollisionPath, b : PhysicsmechanicscollisionPath) -> PhysicsmechanicscollisionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_collision_path_copy(s : PhysicsmechanicscollisionPath) -> PhysicsmechanicscollisionPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_path_fill(s : PhysicsmechanicscollisionPath, v : Double) -> PhysicsmechanicscollisionPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_path_min(s : PhysicsmechanicscollisionPath) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_collision_path_max(s : PhysicsmechanicscollisionPath) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_collision_path_to_string(s : PhysicsmechanicscollisionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_cluster_make(size : Int) -> PhysicsmechanicscollisionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_collision_cluster_len(s : PhysicsmechanicscollisionCluster) -> Int { s.size }

pub fn physics_mechanics_collision_cluster_get(s : PhysicsmechanicscollisionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_collision_cluster_set(s : PhysicsmechanicscollisionCluster, i : Int, v : Double) -> PhysicsmechanicscollisionCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_cluster_sum(s : PhysicsmechanicscollisionCluster) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_collision_cluster_mean(s : PhysicsmechanicscollisionCluster) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_collision_cluster_scale(s : PhysicsmechanicscollisionCluster, f : Double) -> PhysicsmechanicscollisionCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_cluster_add(a : PhysicsmechanicscollisionCluster, b : PhysicsmechanicscollisionCluster) -> PhysicsmechanicscollisionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_collision_cluster_copy(s : PhysicsmechanicscollisionCluster) -> PhysicsmechanicscollisionCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_cluster_fill(s : PhysicsmechanicscollisionCluster, v : Double) -> PhysicsmechanicscollisionCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_cluster_min(s : PhysicsmechanicscollisionCluster) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_collision_cluster_max(s : PhysicsmechanicscollisionCluster) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_collision_cluster_to_string(s : PhysicsmechanicscollisionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_model_make(size : Int) -> PhysicsmechanicscollisionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_collision_model_len(s : PhysicsmechanicscollisionModel) -> Int { s.size }

pub fn physics_mechanics_collision_model_get(s : PhysicsmechanicscollisionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_collision_model_set(s : PhysicsmechanicscollisionModel, i : Int, v : Double) -> PhysicsmechanicscollisionModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_model_sum(s : PhysicsmechanicscollisionModel) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_collision_model_mean(s : PhysicsmechanicscollisionModel) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_collision_model_scale(s : PhysicsmechanicscollisionModel, f : Double) -> PhysicsmechanicscollisionModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_model_add(a : PhysicsmechanicscollisionModel, b : PhysicsmechanicscollisionModel) -> PhysicsmechanicscollisionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_collision_model_copy(s : PhysicsmechanicscollisionModel) -> PhysicsmechanicscollisionModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_model_fill(s : PhysicsmechanicscollisionModel, v : Double) -> PhysicsmechanicscollisionModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_model_min(s : PhysicsmechanicscollisionModel) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_collision_model_max(s : PhysicsmechanicscollisionModel) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_collision_model_to_string(s : PhysicsmechanicscollisionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_layer_make(size : Int) -> PhysicsmechanicscollisionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_collision_layer_len(s : PhysicsmechanicscollisionLayer) -> Int { s.size }

pub fn physics_mechanics_collision_layer_get(s : PhysicsmechanicscollisionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_collision_layer_set(s : PhysicsmechanicscollisionLayer, i : Int, v : Double) -> PhysicsmechanicscollisionLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_layer_sum(s : PhysicsmechanicscollisionLayer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_collision_layer_mean(s : PhysicsmechanicscollisionLayer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_collision_layer_scale(s : PhysicsmechanicscollisionLayer, f : Double) -> PhysicsmechanicscollisionLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_layer_add(a : PhysicsmechanicscollisionLayer, b : PhysicsmechanicscollisionLayer) -> PhysicsmechanicscollisionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_collision_layer_copy(s : PhysicsmechanicscollisionLayer) -> PhysicsmechanicscollisionLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_layer_fill(s : PhysicsmechanicscollisionLayer, v : Double) -> PhysicsmechanicscollisionLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_layer_min(s : PhysicsmechanicscollisionLayer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_collision_layer_max(s : PhysicsmechanicscollisionLayer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_collision_layer_to_string(s : PhysicsmechanicscollisionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_buffer_make(size : Int) -> PhysicsmechanicscollisionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_collision_buffer_len(s : PhysicsmechanicscollisionBuffer) -> Int { s.size }

pub fn physics_mechanics_collision_buffer_get(s : PhysicsmechanicscollisionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_collision_buffer_set(s : PhysicsmechanicscollisionBuffer, i : Int, v : Double) -> PhysicsmechanicscollisionBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_buffer_sum(s : PhysicsmechanicscollisionBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_collision_buffer_mean(s : PhysicsmechanicscollisionBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_collision_buffer_scale(s : PhysicsmechanicscollisionBuffer, f : Double) -> PhysicsmechanicscollisionBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_buffer_add(a : PhysicsmechanicscollisionBuffer, b : PhysicsmechanicscollisionBuffer) -> PhysicsmechanicscollisionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_collision_buffer_copy(s : PhysicsmechanicscollisionBuffer) -> PhysicsmechanicscollisionBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_buffer_fill(s : PhysicsmechanicscollisionBuffer, v : Double) -> PhysicsmechanicscollisionBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_buffer_min(s : PhysicsmechanicscollisionBuffer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_collision_buffer_max(s : PhysicsmechanicscollisionBuffer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_collision_buffer_to_string(s : PhysicsmechanicscollisionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_cursor_make(size : Int) -> PhysicsmechanicscollisionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_collision_cursor_len(s : PhysicsmechanicscollisionCursor) -> Int { s.size }

pub fn physics_mechanics_collision_cursor_get(s : PhysicsmechanicscollisionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_collision_cursor_set(s : PhysicsmechanicscollisionCursor, i : Int, v : Double) -> PhysicsmechanicscollisionCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_cursor_sum(s : PhysicsmechanicscollisionCursor) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_collision_cursor_mean(s : PhysicsmechanicscollisionCursor) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_collision_cursor_scale(s : PhysicsmechanicscollisionCursor, f : Double) -> PhysicsmechanicscollisionCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_cursor_add(a : PhysicsmechanicscollisionCursor, b : PhysicsmechanicscollisionCursor) -> PhysicsmechanicscollisionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_collision_cursor_copy(s : PhysicsmechanicscollisionCursor) -> PhysicsmechanicscollisionCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_cursor_fill(s : PhysicsmechanicscollisionCursor, v : Double) -> PhysicsmechanicscollisionCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_cursor_min(s : PhysicsmechanicscollisionCursor) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_collision_cursor_max(s : PhysicsmechanicscollisionCursor) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_collision_cursor_to_string(s : PhysicsmechanicscollisionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_view_make(size : Int) -> PhysicsmechanicscollisionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_collision_view_len(s : PhysicsmechanicscollisionView) -> Int { s.size }

pub fn physics_mechanics_collision_view_get(s : PhysicsmechanicscollisionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_collision_view_set(s : PhysicsmechanicscollisionView, i : Int, v : Double) -> PhysicsmechanicscollisionView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_view_sum(s : PhysicsmechanicscollisionView) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_collision_view_mean(s : PhysicsmechanicscollisionView) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_collision_view_scale(s : PhysicsmechanicscollisionView, f : Double) -> PhysicsmechanicscollisionView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_view_add(a : PhysicsmechanicscollisionView, b : PhysicsmechanicscollisionView) -> PhysicsmechanicscollisionView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_collision_view_copy(s : PhysicsmechanicscollisionView) -> PhysicsmechanicscollisionView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_view_fill(s : PhysicsmechanicscollisionView, v : Double) -> PhysicsmechanicscollisionView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_view_min(s : PhysicsmechanicscollisionView) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_collision_view_max(s : PhysicsmechanicscollisionView) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_collision_view_to_string(s : PhysicsmechanicscollisionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_range_make(size : Int) -> PhysicsmechanicscollisionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_collision_range_len(s : PhysicsmechanicscollisionRange) -> Int { s.size }

pub fn physics_mechanics_collision_range_get(s : PhysicsmechanicscollisionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_collision_range_set(s : PhysicsmechanicscollisionRange, i : Int, v : Double) -> PhysicsmechanicscollisionRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_range_sum(s : PhysicsmechanicscollisionRange) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_collision_range_mean(s : PhysicsmechanicscollisionRange) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_collision_range_scale(s : PhysicsmechanicscollisionRange, f : Double) -> PhysicsmechanicscollisionRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_range_add(a : PhysicsmechanicscollisionRange, b : PhysicsmechanicscollisionRange) -> PhysicsmechanicscollisionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_collision_range_copy(s : PhysicsmechanicscollisionRange) -> PhysicsmechanicscollisionRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_range_fill(s : PhysicsmechanicscollisionRange, v : Double) -> PhysicsmechanicscollisionRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_range_min(s : PhysicsmechanicscollisionRange) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_collision_range_max(s : PhysicsmechanicscollisionRange) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_collision_range_to_string(s : PhysicsmechanicscollisionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicscollisionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_collision_slice_make(size : Int) -> PhysicsmechanicscollisionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_collision_slice_len(s : PhysicsmechanicscollisionSlice) -> Int { s.size }

pub fn physics_mechanics_collision_slice_get(s : PhysicsmechanicscollisionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_collision_slice_set(s : PhysicsmechanicscollisionSlice, i : Int, v : Double) -> PhysicsmechanicscollisionSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_slice_sum(s : PhysicsmechanicscollisionSlice) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_collision_slice_mean(s : PhysicsmechanicscollisionSlice) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_collision_slice_scale(s : PhysicsmechanicscollisionSlice, f : Double) -> PhysicsmechanicscollisionSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_slice_add(a : PhysicsmechanicscollisionSlice, b : PhysicsmechanicscollisionSlice) -> PhysicsmechanicscollisionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_collision_slice_copy(s : PhysicsmechanicscollisionSlice) -> PhysicsmechanicscollisionSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_slice_fill(s : PhysicsmechanicscollisionSlice, v : Double) -> PhysicsmechanicscollisionSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_collision_slice_min(s : PhysicsmechanicscollisionSlice) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_collision_slice_max(s : PhysicsmechanicscollisionSlice) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_collision_slice_to_string(s : PhysicsmechanicscollisionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

