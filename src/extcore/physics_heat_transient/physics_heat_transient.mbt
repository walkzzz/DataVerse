///===
/// extcore/physics_heat_transient

pub(all) struct PhysicsheattransientPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_transient_make_point(x : Double, y : Double) -> PhysicsheattransientPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_transient_make_point3(x : Double, y : Double, z : Double) -> PhysicsheattransientPoint {
  { x, y, z, label: 0 }
}

pub fn physics_heat_transient_point_x(pt : PhysicsheattransientPoint) -> Double { pt.x }

pub fn physics_heat_transient_point_y(pt : PhysicsheattransientPoint) -> Double { pt.y }

pub fn physics_heat_transient_point_z(pt : PhysicsheattransientPoint) -> Double { pt.z }

pub fn physics_heat_transient_point_label(pt : PhysicsheattransientPoint) -> Int { pt.label }

pub fn physics_heat_transient_point_dist(a : PhysicsheattransientPoint, b : PhysicsheattransientPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_heat_transient_point_add(a : PhysicsheattransientPoint, b : PhysicsheattransientPoint) -> PhysicsheattransientPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_heat_transient_point_sub(a : PhysicsheattransientPoint, b : PhysicsheattransientPoint) -> PhysicsheattransientPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_heat_transient_point_scale(pt : PhysicsheattransientPoint, s : Double) -> PhysicsheattransientPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_heat_transient_point_dot(a : PhysicsheattransientPoint, b : PhysicsheattransientPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_heat_transient_point_cross(a : PhysicsheattransientPoint, b : PhysicsheattransientPoint) -> PhysicsheattransientPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_heat_transient_point_norm(pt : PhysicsheattransientPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_heat_transient_point_normalize(pt : PhysicsheattransientPoint) -> PhysicsheattransientPoint {
  let n = physics_heat_transient_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_heat_transient_point_scale(pt, 1.0 / n) }
}

pub fn physics_heat_transient_point_negate(pt : PhysicsheattransientPoint) -> PhysicsheattransientPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_heat_transient_point_mid(a : PhysicsheattransientPoint, b : PhysicsheattransientPoint) -> PhysicsheattransientPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_heat_transient_point_lerp(a : PhysicsheattransientPoint, b : PhysicsheattransientPoint, t : Double) -> PhysicsheattransientPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_heat_transient_point_to_string(pt : PhysicsheattransientPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsheattransientSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_transient_make_series(vals : Array[Double], name : String) -> PhysicsheattransientSeries {
  { vals, name, meta: 0 }
}

pub fn physics_heat_transient_series_len(s : PhysicsheattransientSeries) -> Int { s.vals.length() }

pub fn physics_heat_transient_series_sum(s : PhysicsheattransientSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_heat_transient_series_mean(s : PhysicsheattransientSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_heat_transient_series_min(s : PhysicsheattransientSeries) -> Double { @_common.min(s.vals) }

pub fn physics_heat_transient_series_max(s : PhysicsheattransientSeries) -> Double { @_common.max(s.vals) }

pub fn physics_heat_transient_series_range(s : PhysicsheattransientSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_heat_transient_series_var(s : PhysicsheattransientSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_heat_transient_series_std(s : PhysicsheattransientSeries) -> Double { @_common.std(s.vals) }

pub fn physics_heat_transient_series_median(s : PhysicsheattransientSeries) -> Double { @_common.median(s.vals) }

pub fn physics_heat_transient_series_scale(s : PhysicsheattransientSeries, f : Double) -> PhysicsheattransientSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn physics_heat_transient_series_add(a : PhysicsheattransientSeries, b : PhysicsheattransientSeries) -> PhysicsheattransientSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_heat_transient_series_sub(a : PhysicsheattransientSeries, b : PhysicsheattransientSeries) -> PhysicsheattransientSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_heat_transient_series_normalize(s : PhysicsheattransientSeries) -> PhysicsheattransientSeries {
  let mn = physics_heat_transient_series_min(s)
  let mx = physics_heat_transient_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_heat_transient_series_cumsum(s : PhysicsheattransientSeries) -> PhysicsheattransientSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_heat_transient_series_to_string(s : PhysicsheattransientSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheattransientMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_transient_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheattransientMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_transient_matrix_identity(n : Int) -> PhysicsheattransientMatrix {
  let m = physics_heat_transient_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_heat_transient_matrix_get(m : PhysicsheattransientMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_heat_transient_matrix_transpose(m : PhysicsheattransientMatrix) -> PhysicsheattransientMatrix {
  let result = physics_heat_transient_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_heat_transient_matrix_add(a : PhysicsheattransientMatrix, b : PhysicsheattransientMatrix) -> PhysicsheattransientMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_heat_transient_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_heat_transient_matrix_scale(m : PhysicsheattransientMatrix, s : Double) -> PhysicsheattransientMatrix {
  let result = physics_heat_transient_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_heat_transient_matrix_multiply(a : PhysicsheattransientMatrix, b : PhysicsheattransientMatrix) -> PhysicsheattransientMatrix {
  if a.cols != b.rows { return physics_heat_transient_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_heat_transient_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_heat_transient_matrix_trace(m : PhysicsheattransientMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_heat_transient_matrix_det(m : PhysicsheattransientMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_heat_transient_matrix_norm(m : PhysicsheattransientMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_heat_transient_matrix_to_string(m : PhysicsheattransientMatrix) -> String {
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

pub(all) struct PhysicsheattransientVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_transient_make_vector(comps : Array[Double]) -> PhysicsheattransientVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_transient_vector_zero(dim : Int) -> PhysicsheattransientVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_heat_transient_vector_add(a : PhysicsheattransientVector, b : PhysicsheattransientVector) -> PhysicsheattransientVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn physics_heat_transient_vector_sub(a : PhysicsheattransientVector, b : PhysicsheattransientVector) -> PhysicsheattransientVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn physics_heat_transient_vector_scale(v : PhysicsheattransientVector, s : Double) -> PhysicsheattransientVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn physics_heat_transient_vector_dot(a : PhysicsheattransientVector, b : PhysicsheattransientVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_heat_transient_vector_norm(v : PhysicsheattransientVector) -> Double { @_common.sqrt(physics_heat_transient_vector_dot(v, v)) }

pub fn physics_heat_transient_vector_normalize(v : PhysicsheattransientVector) -> PhysicsheattransientVector {
  let n = physics_heat_transient_vector_norm(v)
  if n < 0.0000001 { v } else { physics_heat_transient_vector_scale(v, 1.0 / n) }
}

pub fn physics_heat_transient_vector_dist(a : PhysicsheattransientVector, b : PhysicsheattransientVector) -> Double {
  physics_heat_transient_vector_norm(physics_heat_transient_vector_sub(a, b))
}

pub fn physics_heat_transient_vector_to_string(v : PhysicsheattransientVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_transient_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_heat_transient_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_heat_transient_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_heat_transient_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_heat_transient_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_heat_transient_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_heat_transient_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_heat_transient_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_heat_transient_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_heat_transient_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_heat_transient_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_heat_transient_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_heat_transient_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_heat_transient_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_heat_transient_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_heat_transient_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_heat_transient_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_heat_transient_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_heat_transient_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_heat_transient_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_heat_transient_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_heat_transient_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_heat_transient_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_heat_transient_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_heat_transient_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_heat_transient_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_heat_transient_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_heat_transient_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_heat_transient_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsheattransientFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_frame_make(size : Int) -> PhysicsheattransientFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_frame_len(s : PhysicsheattransientFrame) -> Int { s.size }

pub fn physics_heat_transient_frame_get(s : PhysicsheattransientFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_frame_set(s : PhysicsheattransientFrame, i : Int, v : Double) -> PhysicsheattransientFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_frame_sum(s : PhysicsheattransientFrame) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_frame_mean(s : PhysicsheattransientFrame) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_frame_scale(s : PhysicsheattransientFrame, f : Double) -> PhysicsheattransientFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_frame_add(a : PhysicsheattransientFrame, b : PhysicsheattransientFrame) -> PhysicsheattransientFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_frame_copy(s : PhysicsheattransientFrame) -> PhysicsheattransientFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_frame_fill(s : PhysicsheattransientFrame, v : Double) -> PhysicsheattransientFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_frame_min(s : PhysicsheattransientFrame) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_frame_max(s : PhysicsheattransientFrame) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_frame_to_string(s : PhysicsheattransientFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_table_make(size : Int) -> PhysicsheattransientTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_table_len(s : PhysicsheattransientTable) -> Int { s.size }

pub fn physics_heat_transient_table_get(s : PhysicsheattransientTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_table_set(s : PhysicsheattransientTable, i : Int, v : Double) -> PhysicsheattransientTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_table_sum(s : PhysicsheattransientTable) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_table_mean(s : PhysicsheattransientTable) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_table_scale(s : PhysicsheattransientTable, f : Double) -> PhysicsheattransientTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_table_add(a : PhysicsheattransientTable, b : PhysicsheattransientTable) -> PhysicsheattransientTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_table_copy(s : PhysicsheattransientTable) -> PhysicsheattransientTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_table_fill(s : PhysicsheattransientTable, v : Double) -> PhysicsheattransientTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_table_min(s : PhysicsheattransientTable) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_table_max(s : PhysicsheattransientTable) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_table_to_string(s : PhysicsheattransientTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_graphn_make(size : Int) -> PhysicsheattransientGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_graphn_len(s : PhysicsheattransientGraphN) -> Int { s.size }

pub fn physics_heat_transient_graphn_get(s : PhysicsheattransientGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_graphn_set(s : PhysicsheattransientGraphN, i : Int, v : Double) -> PhysicsheattransientGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_graphn_sum(s : PhysicsheattransientGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_graphn_mean(s : PhysicsheattransientGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_graphn_scale(s : PhysicsheattransientGraphN, f : Double) -> PhysicsheattransientGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_graphn_add(a : PhysicsheattransientGraphN, b : PhysicsheattransientGraphN) -> PhysicsheattransientGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_graphn_copy(s : PhysicsheattransientGraphN) -> PhysicsheattransientGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_graphn_fill(s : PhysicsheattransientGraphN, v : Double) -> PhysicsheattransientGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_graphn_min(s : PhysicsheattransientGraphN) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_graphn_max(s : PhysicsheattransientGraphN) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_graphn_to_string(s : PhysicsheattransientGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_node_make(size : Int) -> PhysicsheattransientNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_node_len(s : PhysicsheattransientNode) -> Int { s.size }

pub fn physics_heat_transient_node_get(s : PhysicsheattransientNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_node_set(s : PhysicsheattransientNode, i : Int, v : Double) -> PhysicsheattransientNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_node_sum(s : PhysicsheattransientNode) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_node_mean(s : PhysicsheattransientNode) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_node_scale(s : PhysicsheattransientNode, f : Double) -> PhysicsheattransientNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_node_add(a : PhysicsheattransientNode, b : PhysicsheattransientNode) -> PhysicsheattransientNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_node_copy(s : PhysicsheattransientNode) -> PhysicsheattransientNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_node_fill(s : PhysicsheattransientNode, v : Double) -> PhysicsheattransientNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_node_min(s : PhysicsheattransientNode) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_node_max(s : PhysicsheattransientNode) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_node_to_string(s : PhysicsheattransientNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_edge_make(size : Int) -> PhysicsheattransientEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_edge_len(s : PhysicsheattransientEdge) -> Int { s.size }

pub fn physics_heat_transient_edge_get(s : PhysicsheattransientEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_edge_set(s : PhysicsheattransientEdge, i : Int, v : Double) -> PhysicsheattransientEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_edge_sum(s : PhysicsheattransientEdge) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_edge_mean(s : PhysicsheattransientEdge) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_edge_scale(s : PhysicsheattransientEdge, f : Double) -> PhysicsheattransientEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_edge_add(a : PhysicsheattransientEdge, b : PhysicsheattransientEdge) -> PhysicsheattransientEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_edge_copy(s : PhysicsheattransientEdge) -> PhysicsheattransientEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_edge_fill(s : PhysicsheattransientEdge, v : Double) -> PhysicsheattransientEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_edge_min(s : PhysicsheattransientEdge) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_edge_max(s : PhysicsheattransientEdge) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_edge_to_string(s : PhysicsheattransientEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_path_make(size : Int) -> PhysicsheattransientPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_path_len(s : PhysicsheattransientPath) -> Int { s.size }

pub fn physics_heat_transient_path_get(s : PhysicsheattransientPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_path_set(s : PhysicsheattransientPath, i : Int, v : Double) -> PhysicsheattransientPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_path_sum(s : PhysicsheattransientPath) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_path_mean(s : PhysicsheattransientPath) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_path_scale(s : PhysicsheattransientPath, f : Double) -> PhysicsheattransientPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_path_add(a : PhysicsheattransientPath, b : PhysicsheattransientPath) -> PhysicsheattransientPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_path_copy(s : PhysicsheattransientPath) -> PhysicsheattransientPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_path_fill(s : PhysicsheattransientPath, v : Double) -> PhysicsheattransientPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_path_min(s : PhysicsheattransientPath) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_path_max(s : PhysicsheattransientPath) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_path_to_string(s : PhysicsheattransientPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_cluster_make(size : Int) -> PhysicsheattransientCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_cluster_len(s : PhysicsheattransientCluster) -> Int { s.size }

pub fn physics_heat_transient_cluster_get(s : PhysicsheattransientCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_cluster_set(s : PhysicsheattransientCluster, i : Int, v : Double) -> PhysicsheattransientCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_cluster_sum(s : PhysicsheattransientCluster) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_cluster_mean(s : PhysicsheattransientCluster) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_cluster_scale(s : PhysicsheattransientCluster, f : Double) -> PhysicsheattransientCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_cluster_add(a : PhysicsheattransientCluster, b : PhysicsheattransientCluster) -> PhysicsheattransientCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_cluster_copy(s : PhysicsheattransientCluster) -> PhysicsheattransientCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_cluster_fill(s : PhysicsheattransientCluster, v : Double) -> PhysicsheattransientCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_cluster_min(s : PhysicsheattransientCluster) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_cluster_max(s : PhysicsheattransientCluster) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_cluster_to_string(s : PhysicsheattransientCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_model_make(size : Int) -> PhysicsheattransientModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_model_len(s : PhysicsheattransientModel) -> Int { s.size }

pub fn physics_heat_transient_model_get(s : PhysicsheattransientModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_model_set(s : PhysicsheattransientModel, i : Int, v : Double) -> PhysicsheattransientModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_model_sum(s : PhysicsheattransientModel) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_model_mean(s : PhysicsheattransientModel) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_model_scale(s : PhysicsheattransientModel, f : Double) -> PhysicsheattransientModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_model_add(a : PhysicsheattransientModel, b : PhysicsheattransientModel) -> PhysicsheattransientModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_model_copy(s : PhysicsheattransientModel) -> PhysicsheattransientModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_model_fill(s : PhysicsheattransientModel, v : Double) -> PhysicsheattransientModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_model_min(s : PhysicsheattransientModel) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_model_max(s : PhysicsheattransientModel) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_model_to_string(s : PhysicsheattransientModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_layer_make(size : Int) -> PhysicsheattransientLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_layer_len(s : PhysicsheattransientLayer) -> Int { s.size }

pub fn physics_heat_transient_layer_get(s : PhysicsheattransientLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_layer_set(s : PhysicsheattransientLayer, i : Int, v : Double) -> PhysicsheattransientLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_layer_sum(s : PhysicsheattransientLayer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_layer_mean(s : PhysicsheattransientLayer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_layer_scale(s : PhysicsheattransientLayer, f : Double) -> PhysicsheattransientLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_layer_add(a : PhysicsheattransientLayer, b : PhysicsheattransientLayer) -> PhysicsheattransientLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_layer_copy(s : PhysicsheattransientLayer) -> PhysicsheattransientLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_layer_fill(s : PhysicsheattransientLayer, v : Double) -> PhysicsheattransientLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_layer_min(s : PhysicsheattransientLayer) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_layer_max(s : PhysicsheattransientLayer) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_layer_to_string(s : PhysicsheattransientLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_buffer_make(size : Int) -> PhysicsheattransientBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_buffer_len(s : PhysicsheattransientBuffer) -> Int { s.size }

pub fn physics_heat_transient_buffer_get(s : PhysicsheattransientBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_buffer_set(s : PhysicsheattransientBuffer, i : Int, v : Double) -> PhysicsheattransientBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_buffer_sum(s : PhysicsheattransientBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_buffer_mean(s : PhysicsheattransientBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_buffer_scale(s : PhysicsheattransientBuffer, f : Double) -> PhysicsheattransientBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_buffer_add(a : PhysicsheattransientBuffer, b : PhysicsheattransientBuffer) -> PhysicsheattransientBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_buffer_copy(s : PhysicsheattransientBuffer) -> PhysicsheattransientBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_buffer_fill(s : PhysicsheattransientBuffer, v : Double) -> PhysicsheattransientBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_buffer_min(s : PhysicsheattransientBuffer) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_buffer_max(s : PhysicsheattransientBuffer) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_buffer_to_string(s : PhysicsheattransientBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_cursor_make(size : Int) -> PhysicsheattransientCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_cursor_len(s : PhysicsheattransientCursor) -> Int { s.size }

pub fn physics_heat_transient_cursor_get(s : PhysicsheattransientCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_cursor_set(s : PhysicsheattransientCursor, i : Int, v : Double) -> PhysicsheattransientCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_cursor_sum(s : PhysicsheattransientCursor) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_cursor_mean(s : PhysicsheattransientCursor) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_cursor_scale(s : PhysicsheattransientCursor, f : Double) -> PhysicsheattransientCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_cursor_add(a : PhysicsheattransientCursor, b : PhysicsheattransientCursor) -> PhysicsheattransientCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_cursor_copy(s : PhysicsheattransientCursor) -> PhysicsheattransientCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_cursor_fill(s : PhysicsheattransientCursor, v : Double) -> PhysicsheattransientCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_cursor_min(s : PhysicsheattransientCursor) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_cursor_max(s : PhysicsheattransientCursor) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_cursor_to_string(s : PhysicsheattransientCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_view_make(size : Int) -> PhysicsheattransientView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_view_len(s : PhysicsheattransientView) -> Int { s.size }

pub fn physics_heat_transient_view_get(s : PhysicsheattransientView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_view_set(s : PhysicsheattransientView, i : Int, v : Double) -> PhysicsheattransientView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_view_sum(s : PhysicsheattransientView) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_view_mean(s : PhysicsheattransientView) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_view_scale(s : PhysicsheattransientView, f : Double) -> PhysicsheattransientView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_view_add(a : PhysicsheattransientView, b : PhysicsheattransientView) -> PhysicsheattransientView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_view_copy(s : PhysicsheattransientView) -> PhysicsheattransientView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_view_fill(s : PhysicsheattransientView, v : Double) -> PhysicsheattransientView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_view_min(s : PhysicsheattransientView) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_view_max(s : PhysicsheattransientView) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_view_to_string(s : PhysicsheattransientView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_range_make(size : Int) -> PhysicsheattransientRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_range_len(s : PhysicsheattransientRange) -> Int { s.size }

pub fn physics_heat_transient_range_get(s : PhysicsheattransientRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_range_set(s : PhysicsheattransientRange, i : Int, v : Double) -> PhysicsheattransientRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_range_sum(s : PhysicsheattransientRange) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_range_mean(s : PhysicsheattransientRange) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_range_scale(s : PhysicsheattransientRange, f : Double) -> PhysicsheattransientRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_range_add(a : PhysicsheattransientRange, b : PhysicsheattransientRange) -> PhysicsheattransientRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_range_copy(s : PhysicsheattransientRange) -> PhysicsheattransientRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_range_fill(s : PhysicsheattransientRange, v : Double) -> PhysicsheattransientRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_range_min(s : PhysicsheattransientRange) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_range_max(s : PhysicsheattransientRange) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_range_to_string(s : PhysicsheattransientRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheattransientSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_transient_slice_make(size : Int) -> PhysicsheattransientSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_transient_slice_len(s : PhysicsheattransientSlice) -> Int { s.size }

pub fn physics_heat_transient_slice_get(s : PhysicsheattransientSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_transient_slice_set(s : PhysicsheattransientSlice, i : Int, v : Double) -> PhysicsheattransientSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_slice_sum(s : PhysicsheattransientSlice) -> Double { @_common.sum(s.data) }

pub fn physics_heat_transient_slice_mean(s : PhysicsheattransientSlice) -> Double { @_common.mean(s.data) }

pub fn physics_heat_transient_slice_scale(s : PhysicsheattransientSlice, f : Double) -> PhysicsheattransientSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_slice_add(a : PhysicsheattransientSlice, b : PhysicsheattransientSlice) -> PhysicsheattransientSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_transient_slice_copy(s : PhysicsheattransientSlice) -> PhysicsheattransientSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_slice_fill(s : PhysicsheattransientSlice, v : Double) -> PhysicsheattransientSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_transient_slice_min(s : PhysicsheattransientSlice) -> Double { @_common.min(s.data) }

pub fn physics_heat_transient_slice_max(s : PhysicsheattransientSlice) -> Double { @_common.max(s.data) }

pub fn physics_heat_transient_slice_to_string(s : PhysicsheattransientSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

