///===
/// extcore/physics_mechanics_constraint

pub(all) struct PhysicsmechanicsconstraintPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_constraint_make_point(x : Double, y : Double) -> PhysicsmechanicsconstraintPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_constraint_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicsconstraintPoint {
  { x, y, z, label: 0 }
}

pub fn physics_mechanics_constraint_point_x(pt : PhysicsmechanicsconstraintPoint) -> Double { pt.x }

pub fn physics_mechanics_constraint_point_y(pt : PhysicsmechanicsconstraintPoint) -> Double { pt.y }

pub fn physics_mechanics_constraint_point_z(pt : PhysicsmechanicsconstraintPoint) -> Double { pt.z }

pub fn physics_mechanics_constraint_point_label(pt : PhysicsmechanicsconstraintPoint) -> Int { pt.label }

pub fn physics_mechanics_constraint_point_dist(a : PhysicsmechanicsconstraintPoint, b : PhysicsmechanicsconstraintPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_mechanics_constraint_point_add(a : PhysicsmechanicsconstraintPoint, b : PhysicsmechanicsconstraintPoint) -> PhysicsmechanicsconstraintPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_mechanics_constraint_point_sub(a : PhysicsmechanicsconstraintPoint, b : PhysicsmechanicsconstraintPoint) -> PhysicsmechanicsconstraintPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_mechanics_constraint_point_scale(pt : PhysicsmechanicsconstraintPoint, s : Double) -> PhysicsmechanicsconstraintPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_mechanics_constraint_point_dot(a : PhysicsmechanicsconstraintPoint, b : PhysicsmechanicsconstraintPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_mechanics_constraint_point_cross(a : PhysicsmechanicsconstraintPoint, b : PhysicsmechanicsconstraintPoint) -> PhysicsmechanicsconstraintPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_mechanics_constraint_point_norm(pt : PhysicsmechanicsconstraintPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_mechanics_constraint_point_normalize(pt : PhysicsmechanicsconstraintPoint) -> PhysicsmechanicsconstraintPoint {
  let n = physics_mechanics_constraint_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_mechanics_constraint_point_scale(pt, 1.0 / n) }
}

pub fn physics_mechanics_constraint_point_negate(pt : PhysicsmechanicsconstraintPoint) -> PhysicsmechanicsconstraintPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_mechanics_constraint_point_mid(a : PhysicsmechanicsconstraintPoint, b : PhysicsmechanicsconstraintPoint) -> PhysicsmechanicsconstraintPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_mechanics_constraint_point_lerp(a : PhysicsmechanicsconstraintPoint, b : PhysicsmechanicsconstraintPoint, t : Double) -> PhysicsmechanicsconstraintPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_mechanics_constraint_point_to_string(pt : PhysicsmechanicsconstraintPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_constraint_make_series(vals : Array[Double], name : String) -> PhysicsmechanicsconstraintSeries {
  { vals, name, meta: 0 }
}

pub fn physics_mechanics_constraint_series_len(s : PhysicsmechanicsconstraintSeries) -> Int { s.vals.length() }

pub fn physics_mechanics_constraint_series_sum(s : PhysicsmechanicsconstraintSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_mechanics_constraint_series_mean(s : PhysicsmechanicsconstraintSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_mechanics_constraint_series_min(s : PhysicsmechanicsconstraintSeries) -> Double { @_common.min(s.vals) }

pub fn physics_mechanics_constraint_series_max(s : PhysicsmechanicsconstraintSeries) -> Double { @_common.max(s.vals) }

pub fn physics_mechanics_constraint_series_range(s : PhysicsmechanicsconstraintSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_mechanics_constraint_series_var(s : PhysicsmechanicsconstraintSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_mechanics_constraint_series_std(s : PhysicsmechanicsconstraintSeries) -> Double { @_common.std(s.vals) }

pub fn physics_mechanics_constraint_series_median(s : PhysicsmechanicsconstraintSeries) -> Double { @_common.median(s.vals) }

pub fn physics_mechanics_constraint_series_scale(s : PhysicsmechanicsconstraintSeries, f : Double) -> PhysicsmechanicsconstraintSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_mechanics_constraint_series_add(a : PhysicsmechanicsconstraintSeries, b : PhysicsmechanicsconstraintSeries) -> PhysicsmechanicsconstraintSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_mechanics_constraint_series_sub(a : PhysicsmechanicsconstraintSeries, b : PhysicsmechanicsconstraintSeries) -> PhysicsmechanicsconstraintSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_mechanics_constraint_series_normalize(s : PhysicsmechanicsconstraintSeries) -> PhysicsmechanicsconstraintSeries {
  let mn = physics_mechanics_constraint_series_min(s)
  let mx = physics_mechanics_constraint_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_mechanics_constraint_series_cumsum(s : PhysicsmechanicsconstraintSeries) -> PhysicsmechanicsconstraintSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_mechanics_constraint_series_to_string(s : PhysicsmechanicsconstraintSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsconstraintMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_constraint_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicsconstraintMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_constraint_matrix_identity(n : Int) -> PhysicsmechanicsconstraintMatrix {
  let m = physics_mechanics_constraint_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_mechanics_constraint_matrix_get(m : PhysicsmechanicsconstraintMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_mechanics_constraint_matrix_transpose(m : PhysicsmechanicsconstraintMatrix) -> PhysicsmechanicsconstraintMatrix {
  let result = physics_mechanics_constraint_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_mechanics_constraint_matrix_add(a : PhysicsmechanicsconstraintMatrix, b : PhysicsmechanicsconstraintMatrix) -> PhysicsmechanicsconstraintMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_mechanics_constraint_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_mechanics_constraint_matrix_scale(m : PhysicsmechanicsconstraintMatrix, s : Double) -> PhysicsmechanicsconstraintMatrix {
  let result = physics_mechanics_constraint_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_mechanics_constraint_matrix_multiply(a : PhysicsmechanicsconstraintMatrix, b : PhysicsmechanicsconstraintMatrix) -> PhysicsmechanicsconstraintMatrix {
  if a.cols != b.rows { return physics_mechanics_constraint_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_mechanics_constraint_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_mechanics_constraint_matrix_trace(m : PhysicsmechanicsconstraintMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_mechanics_constraint_matrix_det(m : PhysicsmechanicsconstraintMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_mechanics_constraint_matrix_norm(m : PhysicsmechanicsconstraintMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_mechanics_constraint_matrix_to_string(m : PhysicsmechanicsconstraintMatrix) -> String {
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

pub(all) struct PhysicsmechanicsconstraintVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_constraint_make_vector(comps : Array[Double]) -> PhysicsmechanicsconstraintVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_constraint_vector_zero(dim : Int) -> PhysicsmechanicsconstraintVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_mechanics_constraint_vector_add(a : PhysicsmechanicsconstraintVector, b : PhysicsmechanicsconstraintVector) -> PhysicsmechanicsconstraintVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_constraint_vector_sub(a : PhysicsmechanicsconstraintVector, b : PhysicsmechanicsconstraintVector) -> PhysicsmechanicsconstraintVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_constraint_vector_scale(v : PhysicsmechanicsconstraintVector, s : Double) -> PhysicsmechanicsconstraintVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_mechanics_constraint_vector_dot(a : PhysicsmechanicsconstraintVector, b : PhysicsmechanicsconstraintVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_mechanics_constraint_vector_norm(v : PhysicsmechanicsconstraintVector) -> Double { @_common.sqrt(physics_mechanics_constraint_vector_dot(v, v)) }

pub fn physics_mechanics_constraint_vector_normalize(v : PhysicsmechanicsconstraintVector) -> PhysicsmechanicsconstraintVector {
  let n = physics_mechanics_constraint_vector_norm(v)
  if n < 0.0000001 { v } else { physics_mechanics_constraint_vector_scale(v, 1.0 / n) }
}

pub fn physics_mechanics_constraint_vector_dist(a : PhysicsmechanicsconstraintVector, b : PhysicsmechanicsconstraintVector) -> Double {
  physics_mechanics_constraint_vector_norm(physics_mechanics_constraint_vector_sub(a, b))
}

pub fn physics_mechanics_constraint_vector_to_string(v : PhysicsmechanicsconstraintVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_constraint_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_mechanics_constraint_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_mechanics_constraint_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_mechanics_constraint_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_mechanics_constraint_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_mechanics_constraint_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_mechanics_constraint_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_mechanics_constraint_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_mechanics_constraint_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_mechanics_constraint_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_mechanics_constraint_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_mechanics_constraint_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_mechanics_constraint_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_mechanics_constraint_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_mechanics_constraint_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_mechanics_constraint_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_mechanics_constraint_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_mechanics_constraint_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_mechanics_constraint_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_mechanics_constraint_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_mechanics_constraint_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_mechanics_constraint_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_mechanics_constraint_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_mechanics_constraint_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_mechanics_constraint_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_mechanics_constraint_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_mechanics_constraint_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_mechanics_constraint_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_mechanics_constraint_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsmechanicsconstraintFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_frame_make(size : Int) -> PhysicsmechanicsconstraintFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_frame_len(s : PhysicsmechanicsconstraintFrame) -> Int { s.size }

pub fn physics_mechanics_constraint_frame_get(s : PhysicsmechanicsconstraintFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_frame_set(s : PhysicsmechanicsconstraintFrame, i : Int, v : Double) -> PhysicsmechanicsconstraintFrame {
  let result = physics_mechanics_constraint_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_constraint_frame_sum(s : PhysicsmechanicsconstraintFrame) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_frame_mean(s : PhysicsmechanicsconstraintFrame) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_frame_scale(s : PhysicsmechanicsconstraintFrame, f : Double) -> PhysicsmechanicsconstraintFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_frame_add(a : PhysicsmechanicsconstraintFrame, b : PhysicsmechanicsconstraintFrame) -> PhysicsmechanicsconstraintFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_frame_copy(s : PhysicsmechanicsconstraintFrame) -> PhysicsmechanicsconstraintFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_frame_fill(s : PhysicsmechanicsconstraintFrame, v : Double) -> PhysicsmechanicsconstraintFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_frame_min(s : PhysicsmechanicsconstraintFrame) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_frame_max(s : PhysicsmechanicsconstraintFrame) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_frame_to_string(s : PhysicsmechanicsconstraintFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_table_make(size : Int) -> PhysicsmechanicsconstraintTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_table_len(s : PhysicsmechanicsconstraintTable) -> Int { s.size }

pub fn physics_mechanics_constraint_table_get(s : PhysicsmechanicsconstraintTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_table_set(s : PhysicsmechanicsconstraintTable, i : Int, v : Double) -> PhysicsmechanicsconstraintTable {
  let result = physics_mechanics_constraint_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_constraint_table_sum(s : PhysicsmechanicsconstraintTable) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_table_mean(s : PhysicsmechanicsconstraintTable) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_table_scale(s : PhysicsmechanicsconstraintTable, f : Double) -> PhysicsmechanicsconstraintTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_table_add(a : PhysicsmechanicsconstraintTable, b : PhysicsmechanicsconstraintTable) -> PhysicsmechanicsconstraintTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_table_copy(s : PhysicsmechanicsconstraintTable) -> PhysicsmechanicsconstraintTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_table_fill(s : PhysicsmechanicsconstraintTable, v : Double) -> PhysicsmechanicsconstraintTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_table_min(s : PhysicsmechanicsconstraintTable) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_table_max(s : PhysicsmechanicsconstraintTable) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_table_to_string(s : PhysicsmechanicsconstraintTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_graphn_make(size : Int) -> PhysicsmechanicsconstraintGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_graphn_len(s : PhysicsmechanicsconstraintGraphN) -> Int { s.size }

pub fn physics_mechanics_constraint_graphn_get(s : PhysicsmechanicsconstraintGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_graphn_set(s : PhysicsmechanicsconstraintGraphN, i : Int, v : Double) -> PhysicsmechanicsconstraintGraphN {
  let result = physics_mechanics_constraint_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_constraint_graphn_sum(s : PhysicsmechanicsconstraintGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_graphn_mean(s : PhysicsmechanicsconstraintGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_graphn_scale(s : PhysicsmechanicsconstraintGraphN, f : Double) -> PhysicsmechanicsconstraintGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_graphn_add(a : PhysicsmechanicsconstraintGraphN, b : PhysicsmechanicsconstraintGraphN) -> PhysicsmechanicsconstraintGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_graphn_copy(s : PhysicsmechanicsconstraintGraphN) -> PhysicsmechanicsconstraintGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_graphn_fill(s : PhysicsmechanicsconstraintGraphN, v : Double) -> PhysicsmechanicsconstraintGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_graphn_min(s : PhysicsmechanicsconstraintGraphN) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_graphn_max(s : PhysicsmechanicsconstraintGraphN) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_graphn_to_string(s : PhysicsmechanicsconstraintGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_node_make(size : Int) -> PhysicsmechanicsconstraintNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_node_len(s : PhysicsmechanicsconstraintNode) -> Int { s.size }

pub fn physics_mechanics_constraint_node_get(s : PhysicsmechanicsconstraintNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_node_set(s : PhysicsmechanicsconstraintNode, i : Int, v : Double) -> PhysicsmechanicsconstraintNode {
  let result = physics_mechanics_constraint_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_constraint_node_sum(s : PhysicsmechanicsconstraintNode) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_node_mean(s : PhysicsmechanicsconstraintNode) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_node_scale(s : PhysicsmechanicsconstraintNode, f : Double) -> PhysicsmechanicsconstraintNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_node_add(a : PhysicsmechanicsconstraintNode, b : PhysicsmechanicsconstraintNode) -> PhysicsmechanicsconstraintNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_node_copy(s : PhysicsmechanicsconstraintNode) -> PhysicsmechanicsconstraintNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_node_fill(s : PhysicsmechanicsconstraintNode, v : Double) -> PhysicsmechanicsconstraintNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_node_min(s : PhysicsmechanicsconstraintNode) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_node_max(s : PhysicsmechanicsconstraintNode) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_node_to_string(s : PhysicsmechanicsconstraintNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_edge_make(size : Int) -> PhysicsmechanicsconstraintEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_edge_len(s : PhysicsmechanicsconstraintEdge) -> Int { s.size }

pub fn physics_mechanics_constraint_edge_get(s : PhysicsmechanicsconstraintEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_edge_set(s : PhysicsmechanicsconstraintEdge, i : Int, v : Double) -> PhysicsmechanicsconstraintEdge {
  let result = physics_mechanics_constraint_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_constraint_edge_sum(s : PhysicsmechanicsconstraintEdge) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_edge_mean(s : PhysicsmechanicsconstraintEdge) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_edge_scale(s : PhysicsmechanicsconstraintEdge, f : Double) -> PhysicsmechanicsconstraintEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_edge_add(a : PhysicsmechanicsconstraintEdge, b : PhysicsmechanicsconstraintEdge) -> PhysicsmechanicsconstraintEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_edge_copy(s : PhysicsmechanicsconstraintEdge) -> PhysicsmechanicsconstraintEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_edge_fill(s : PhysicsmechanicsconstraintEdge, v : Double) -> PhysicsmechanicsconstraintEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_edge_min(s : PhysicsmechanicsconstraintEdge) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_edge_max(s : PhysicsmechanicsconstraintEdge) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_edge_to_string(s : PhysicsmechanicsconstraintEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_path_make(size : Int) -> PhysicsmechanicsconstraintPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_path_len(s : PhysicsmechanicsconstraintPath) -> Int { s.size }

pub fn physics_mechanics_constraint_path_get(s : PhysicsmechanicsconstraintPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_path_set(s : PhysicsmechanicsconstraintPath, i : Int, v : Double) -> PhysicsmechanicsconstraintPath {
  let result = physics_mechanics_constraint_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_constraint_path_sum(s : PhysicsmechanicsconstraintPath) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_path_mean(s : PhysicsmechanicsconstraintPath) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_path_scale(s : PhysicsmechanicsconstraintPath, f : Double) -> PhysicsmechanicsconstraintPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_path_add(a : PhysicsmechanicsconstraintPath, b : PhysicsmechanicsconstraintPath) -> PhysicsmechanicsconstraintPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_path_copy(s : PhysicsmechanicsconstraintPath) -> PhysicsmechanicsconstraintPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_path_fill(s : PhysicsmechanicsconstraintPath, v : Double) -> PhysicsmechanicsconstraintPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_path_min(s : PhysicsmechanicsconstraintPath) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_path_max(s : PhysicsmechanicsconstraintPath) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_path_to_string(s : PhysicsmechanicsconstraintPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_cluster_make(size : Int) -> PhysicsmechanicsconstraintCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_cluster_len(s : PhysicsmechanicsconstraintCluster) -> Int { s.size }

pub fn physics_mechanics_constraint_cluster_get(s : PhysicsmechanicsconstraintCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_cluster_set(s : PhysicsmechanicsconstraintCluster, i : Int, v : Double) -> PhysicsmechanicsconstraintCluster {
  let result = physics_mechanics_constraint_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_constraint_cluster_sum(s : PhysicsmechanicsconstraintCluster) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_cluster_mean(s : PhysicsmechanicsconstraintCluster) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_cluster_scale(s : PhysicsmechanicsconstraintCluster, f : Double) -> PhysicsmechanicsconstraintCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_cluster_add(a : PhysicsmechanicsconstraintCluster, b : PhysicsmechanicsconstraintCluster) -> PhysicsmechanicsconstraintCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_cluster_copy(s : PhysicsmechanicsconstraintCluster) -> PhysicsmechanicsconstraintCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_cluster_fill(s : PhysicsmechanicsconstraintCluster, v : Double) -> PhysicsmechanicsconstraintCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_cluster_min(s : PhysicsmechanicsconstraintCluster) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_cluster_max(s : PhysicsmechanicsconstraintCluster) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_cluster_to_string(s : PhysicsmechanicsconstraintCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_model_make(size : Int) -> PhysicsmechanicsconstraintModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_model_len(s : PhysicsmechanicsconstraintModel) -> Int { s.size }

pub fn physics_mechanics_constraint_model_get(s : PhysicsmechanicsconstraintModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_model_set(s : PhysicsmechanicsconstraintModel, i : Int, v : Double) -> PhysicsmechanicsconstraintModel {
  let result = physics_mechanics_constraint_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_constraint_model_sum(s : PhysicsmechanicsconstraintModel) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_model_mean(s : PhysicsmechanicsconstraintModel) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_model_scale(s : PhysicsmechanicsconstraintModel, f : Double) -> PhysicsmechanicsconstraintModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_model_add(a : PhysicsmechanicsconstraintModel, b : PhysicsmechanicsconstraintModel) -> PhysicsmechanicsconstraintModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_model_copy(s : PhysicsmechanicsconstraintModel) -> PhysicsmechanicsconstraintModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_model_fill(s : PhysicsmechanicsconstraintModel, v : Double) -> PhysicsmechanicsconstraintModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_model_min(s : PhysicsmechanicsconstraintModel) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_model_max(s : PhysicsmechanicsconstraintModel) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_model_to_string(s : PhysicsmechanicsconstraintModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_layer_make(size : Int) -> PhysicsmechanicsconstraintLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_layer_len(s : PhysicsmechanicsconstraintLayer) -> Int { s.size }

pub fn physics_mechanics_constraint_layer_get(s : PhysicsmechanicsconstraintLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_layer_set(s : PhysicsmechanicsconstraintLayer, i : Int, v : Double) -> PhysicsmechanicsconstraintLayer {
  let result = physics_mechanics_constraint_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_constraint_layer_sum(s : PhysicsmechanicsconstraintLayer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_layer_mean(s : PhysicsmechanicsconstraintLayer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_layer_scale(s : PhysicsmechanicsconstraintLayer, f : Double) -> PhysicsmechanicsconstraintLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_layer_add(a : PhysicsmechanicsconstraintLayer, b : PhysicsmechanicsconstraintLayer) -> PhysicsmechanicsconstraintLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_layer_copy(s : PhysicsmechanicsconstraintLayer) -> PhysicsmechanicsconstraintLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_layer_fill(s : PhysicsmechanicsconstraintLayer, v : Double) -> PhysicsmechanicsconstraintLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_layer_min(s : PhysicsmechanicsconstraintLayer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_layer_max(s : PhysicsmechanicsconstraintLayer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_layer_to_string(s : PhysicsmechanicsconstraintLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_buffer_make(size : Int) -> PhysicsmechanicsconstraintBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_buffer_len(s : PhysicsmechanicsconstraintBuffer) -> Int { s.size }

pub fn physics_mechanics_constraint_buffer_get(s : PhysicsmechanicsconstraintBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_buffer_set(s : PhysicsmechanicsconstraintBuffer, i : Int, v : Double) -> PhysicsmechanicsconstraintBuffer {
  let result = physics_mechanics_constraint_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_constraint_buffer_sum(s : PhysicsmechanicsconstraintBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_buffer_mean(s : PhysicsmechanicsconstraintBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_buffer_scale(s : PhysicsmechanicsconstraintBuffer, f : Double) -> PhysicsmechanicsconstraintBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_buffer_add(a : PhysicsmechanicsconstraintBuffer, b : PhysicsmechanicsconstraintBuffer) -> PhysicsmechanicsconstraintBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_buffer_copy(s : PhysicsmechanicsconstraintBuffer) -> PhysicsmechanicsconstraintBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_buffer_fill(s : PhysicsmechanicsconstraintBuffer, v : Double) -> PhysicsmechanicsconstraintBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_buffer_min(s : PhysicsmechanicsconstraintBuffer) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_buffer_max(s : PhysicsmechanicsconstraintBuffer) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_buffer_to_string(s : PhysicsmechanicsconstraintBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_cursor_make(size : Int) -> PhysicsmechanicsconstraintCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_cursor_len(s : PhysicsmechanicsconstraintCursor) -> Int { s.size }

pub fn physics_mechanics_constraint_cursor_get(s : PhysicsmechanicsconstraintCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_cursor_set(s : PhysicsmechanicsconstraintCursor, i : Int, v : Double) -> PhysicsmechanicsconstraintCursor {
  let result = physics_mechanics_constraint_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_constraint_cursor_sum(s : PhysicsmechanicsconstraintCursor) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_cursor_mean(s : PhysicsmechanicsconstraintCursor) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_cursor_scale(s : PhysicsmechanicsconstraintCursor, f : Double) -> PhysicsmechanicsconstraintCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_cursor_add(a : PhysicsmechanicsconstraintCursor, b : PhysicsmechanicsconstraintCursor) -> PhysicsmechanicsconstraintCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_cursor_copy(s : PhysicsmechanicsconstraintCursor) -> PhysicsmechanicsconstraintCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_cursor_fill(s : PhysicsmechanicsconstraintCursor, v : Double) -> PhysicsmechanicsconstraintCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_cursor_min(s : PhysicsmechanicsconstraintCursor) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_cursor_max(s : PhysicsmechanicsconstraintCursor) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_cursor_to_string(s : PhysicsmechanicsconstraintCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_view_make(size : Int) -> PhysicsmechanicsconstraintView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_view_len(s : PhysicsmechanicsconstraintView) -> Int { s.size }

pub fn physics_mechanics_constraint_view_get(s : PhysicsmechanicsconstraintView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_view_set(s : PhysicsmechanicsconstraintView, i : Int, v : Double) -> PhysicsmechanicsconstraintView {
  let result = physics_mechanics_constraint_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_constraint_view_sum(s : PhysicsmechanicsconstraintView) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_view_mean(s : PhysicsmechanicsconstraintView) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_view_scale(s : PhysicsmechanicsconstraintView, f : Double) -> PhysicsmechanicsconstraintView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_view_add(a : PhysicsmechanicsconstraintView, b : PhysicsmechanicsconstraintView) -> PhysicsmechanicsconstraintView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_view_copy(s : PhysicsmechanicsconstraintView) -> PhysicsmechanicsconstraintView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_view_fill(s : PhysicsmechanicsconstraintView, v : Double) -> PhysicsmechanicsconstraintView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_view_min(s : PhysicsmechanicsconstraintView) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_view_max(s : PhysicsmechanicsconstraintView) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_view_to_string(s : PhysicsmechanicsconstraintView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_range_make(size : Int) -> PhysicsmechanicsconstraintRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_range_len(s : PhysicsmechanicsconstraintRange) -> Int { s.size }

pub fn physics_mechanics_constraint_range_get(s : PhysicsmechanicsconstraintRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_range_set(s : PhysicsmechanicsconstraintRange, i : Int, v : Double) -> PhysicsmechanicsconstraintRange {
  let result = physics_mechanics_constraint_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_constraint_range_sum(s : PhysicsmechanicsconstraintRange) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_range_mean(s : PhysicsmechanicsconstraintRange) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_range_scale(s : PhysicsmechanicsconstraintRange, f : Double) -> PhysicsmechanicsconstraintRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_range_add(a : PhysicsmechanicsconstraintRange, b : PhysicsmechanicsconstraintRange) -> PhysicsmechanicsconstraintRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_range_copy(s : PhysicsmechanicsconstraintRange) -> PhysicsmechanicsconstraintRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_range_fill(s : PhysicsmechanicsconstraintRange, v : Double) -> PhysicsmechanicsconstraintRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_range_min(s : PhysicsmechanicsconstraintRange) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_range_max(s : PhysicsmechanicsconstraintRange) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_range_to_string(s : PhysicsmechanicsconstraintRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsconstraintSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_constraint_slice_make(size : Int) -> PhysicsmechanicsconstraintSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_constraint_slice_len(s : PhysicsmechanicsconstraintSlice) -> Int { s.size }

pub fn physics_mechanics_constraint_slice_get(s : PhysicsmechanicsconstraintSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_constraint_slice_set(s : PhysicsmechanicsconstraintSlice, i : Int, v : Double) -> PhysicsmechanicsconstraintSlice {
  let result = physics_mechanics_constraint_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_constraint_slice_sum(s : PhysicsmechanicsconstraintSlice) -> Double { @_common.sum(s.data) }

pub fn physics_mechanics_constraint_slice_mean(s : PhysicsmechanicsconstraintSlice) -> Double { @_common.mean(s.data) }

pub fn physics_mechanics_constraint_slice_scale(s : PhysicsmechanicsconstraintSlice, f : Double) -> PhysicsmechanicsconstraintSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_slice_add(a : PhysicsmechanicsconstraintSlice, b : PhysicsmechanicsconstraintSlice) -> PhysicsmechanicsconstraintSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_mechanics_constraint_slice_copy(s : PhysicsmechanicsconstraintSlice) -> PhysicsmechanicsconstraintSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_slice_fill(s : PhysicsmechanicsconstraintSlice, v : Double) -> PhysicsmechanicsconstraintSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_mechanics_constraint_slice_min(s : PhysicsmechanicsconstraintSlice) -> Double { @_common.min(s.data) }

pub fn physics_mechanics_constraint_slice_max(s : PhysicsmechanicsconstraintSlice) -> Double { @_common.max(s.data) }

pub fn physics_mechanics_constraint_slice_to_string(s : PhysicsmechanicsconstraintSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

