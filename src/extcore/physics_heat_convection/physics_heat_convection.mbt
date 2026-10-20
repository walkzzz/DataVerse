///===
/// extcore/physics_heat_convection

pub(all) struct PhysicsheatconvectionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_convection_make_point(x : Double, y : Double) -> PhysicsheatconvectionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_convection_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatconvectionPoint {
  { x, y, z, label: 0 }
}

pub fn physics_heat_convection_point_x(pt : PhysicsheatconvectionPoint) -> Double { pt.x }

pub fn physics_heat_convection_point_y(pt : PhysicsheatconvectionPoint) -> Double { pt.y }

pub fn physics_heat_convection_point_z(pt : PhysicsheatconvectionPoint) -> Double { pt.z }

pub fn physics_heat_convection_point_label(pt : PhysicsheatconvectionPoint) -> Int { pt.label }

pub fn physics_heat_convection_point_dist(a : PhysicsheatconvectionPoint, b : PhysicsheatconvectionPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_heat_convection_point_add(a : PhysicsheatconvectionPoint, b : PhysicsheatconvectionPoint) -> PhysicsheatconvectionPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_heat_convection_point_sub(a : PhysicsheatconvectionPoint, b : PhysicsheatconvectionPoint) -> PhysicsheatconvectionPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_heat_convection_point_scale(pt : PhysicsheatconvectionPoint, s : Double) -> PhysicsheatconvectionPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_heat_convection_point_dot(a : PhysicsheatconvectionPoint, b : PhysicsheatconvectionPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_heat_convection_point_cross(a : PhysicsheatconvectionPoint, b : PhysicsheatconvectionPoint) -> PhysicsheatconvectionPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_heat_convection_point_norm(pt : PhysicsheatconvectionPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_heat_convection_point_normalize(pt : PhysicsheatconvectionPoint) -> PhysicsheatconvectionPoint {
  let n = physics_heat_convection_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_heat_convection_point_scale(pt, 1.0 / n) }
}

pub fn physics_heat_convection_point_negate(pt : PhysicsheatconvectionPoint) -> PhysicsheatconvectionPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_heat_convection_point_mid(a : PhysicsheatconvectionPoint, b : PhysicsheatconvectionPoint) -> PhysicsheatconvectionPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_heat_convection_point_lerp(a : PhysicsheatconvectionPoint, b : PhysicsheatconvectionPoint, t : Double) -> PhysicsheatconvectionPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_heat_convection_point_to_string(pt : PhysicsheatconvectionPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_convection_make_series(vals : Array[Double], name : String) -> PhysicsheatconvectionSeries {
  { vals, name, meta: 0 }
}

pub fn physics_heat_convection_series_len(s : PhysicsheatconvectionSeries) -> Int { s.vals.length() }

pub fn physics_heat_convection_series_sum(s : PhysicsheatconvectionSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_heat_convection_series_mean(s : PhysicsheatconvectionSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_heat_convection_series_min(s : PhysicsheatconvectionSeries) -> Double { @_common.min(s.vals) }

pub fn physics_heat_convection_series_max(s : PhysicsheatconvectionSeries) -> Double { @_common.max(s.vals) }

pub fn physics_heat_convection_series_range(s : PhysicsheatconvectionSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_heat_convection_series_var(s : PhysicsheatconvectionSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_heat_convection_series_std(s : PhysicsheatconvectionSeries) -> Double { @_common.std(s.vals) }

pub fn physics_heat_convection_series_median(s : PhysicsheatconvectionSeries) -> Double { @_common.median(s.vals) }

pub fn physics_heat_convection_series_scale(s : PhysicsheatconvectionSeries, f : Double) -> PhysicsheatconvectionSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn physics_heat_convection_series_add(a : PhysicsheatconvectionSeries, b : PhysicsheatconvectionSeries) -> PhysicsheatconvectionSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_heat_convection_series_sub(a : PhysicsheatconvectionSeries, b : PhysicsheatconvectionSeries) -> PhysicsheatconvectionSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_heat_convection_series_normalize(s : PhysicsheatconvectionSeries) -> PhysicsheatconvectionSeries {
  let mn = physics_heat_convection_series_min(s)
  let mx = physics_heat_convection_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_heat_convection_series_cumsum(s : PhysicsheatconvectionSeries) -> PhysicsheatconvectionSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_heat_convection_series_to_string(s : PhysicsheatconvectionSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatconvectionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_convection_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatconvectionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_convection_matrix_identity(n : Int) -> PhysicsheatconvectionMatrix {
  let m = physics_heat_convection_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_heat_convection_matrix_get(m : PhysicsheatconvectionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_heat_convection_matrix_transpose(m : PhysicsheatconvectionMatrix) -> PhysicsheatconvectionMatrix {
  let result = physics_heat_convection_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_heat_convection_matrix_add(a : PhysicsheatconvectionMatrix, b : PhysicsheatconvectionMatrix) -> PhysicsheatconvectionMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_heat_convection_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_heat_convection_matrix_scale(m : PhysicsheatconvectionMatrix, s : Double) -> PhysicsheatconvectionMatrix {
  let result = physics_heat_convection_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_heat_convection_matrix_multiply(a : PhysicsheatconvectionMatrix, b : PhysicsheatconvectionMatrix) -> PhysicsheatconvectionMatrix {
  if a.cols != b.rows { return physics_heat_convection_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_heat_convection_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_heat_convection_matrix_trace(m : PhysicsheatconvectionMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_heat_convection_matrix_det(m : PhysicsheatconvectionMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_heat_convection_matrix_norm(m : PhysicsheatconvectionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_heat_convection_matrix_to_string(m : PhysicsheatconvectionMatrix) -> String {
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

pub(all) struct PhysicsheatconvectionVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_convection_make_vector(comps : Array[Double]) -> PhysicsheatconvectionVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_convection_vector_zero(dim : Int) -> PhysicsheatconvectionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_heat_convection_vector_add(a : PhysicsheatconvectionVector, b : PhysicsheatconvectionVector) -> PhysicsheatconvectionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn physics_heat_convection_vector_sub(a : PhysicsheatconvectionVector, b : PhysicsheatconvectionVector) -> PhysicsheatconvectionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn physics_heat_convection_vector_scale(v : PhysicsheatconvectionVector, s : Double) -> PhysicsheatconvectionVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn physics_heat_convection_vector_dot(a : PhysicsheatconvectionVector, b : PhysicsheatconvectionVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_heat_convection_vector_norm(v : PhysicsheatconvectionVector) -> Double { @_common.sqrt(physics_heat_convection_vector_dot(v, v)) }

pub fn physics_heat_convection_vector_normalize(v : PhysicsheatconvectionVector) -> PhysicsheatconvectionVector {
  let n = physics_heat_convection_vector_norm(v)
  if n < 0.0000001 { v } else { physics_heat_convection_vector_scale(v, 1.0 / n) }
}

pub fn physics_heat_convection_vector_dist(a : PhysicsheatconvectionVector, b : PhysicsheatconvectionVector) -> Double {
  physics_heat_convection_vector_norm(physics_heat_convection_vector_sub(a, b))
}

pub fn physics_heat_convection_vector_to_string(v : PhysicsheatconvectionVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_convection_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_heat_convection_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_heat_convection_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_heat_convection_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_heat_convection_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_heat_convection_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_heat_convection_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_heat_convection_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_heat_convection_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_heat_convection_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_heat_convection_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_heat_convection_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_heat_convection_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_heat_convection_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_heat_convection_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_heat_convection_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_heat_convection_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_heat_convection_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_heat_convection_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_heat_convection_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_heat_convection_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_heat_convection_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_heat_convection_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_heat_convection_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_heat_convection_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_heat_convection_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_heat_convection_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_heat_convection_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_heat_convection_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsheatconvectionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_frame_make(size : Int) -> PhysicsheatconvectionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_frame_len(s : PhysicsheatconvectionFrame) -> Int { s.size }

pub fn physics_heat_convection_frame_get(s : PhysicsheatconvectionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_frame_set(s : PhysicsheatconvectionFrame, i : Int, v : Double) -> PhysicsheatconvectionFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_frame_sum(s : PhysicsheatconvectionFrame) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_frame_mean(s : PhysicsheatconvectionFrame) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_frame_scale(s : PhysicsheatconvectionFrame, f : Double) -> PhysicsheatconvectionFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_frame_add(a : PhysicsheatconvectionFrame, b : PhysicsheatconvectionFrame) -> PhysicsheatconvectionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_frame_copy(s : PhysicsheatconvectionFrame) -> PhysicsheatconvectionFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_frame_fill(s : PhysicsheatconvectionFrame, v : Double) -> PhysicsheatconvectionFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_frame_min(s : PhysicsheatconvectionFrame) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_frame_max(s : PhysicsheatconvectionFrame) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_frame_to_string(s : PhysicsheatconvectionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_table_make(size : Int) -> PhysicsheatconvectionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_table_len(s : PhysicsheatconvectionTable) -> Int { s.size }

pub fn physics_heat_convection_table_get(s : PhysicsheatconvectionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_table_set(s : PhysicsheatconvectionTable, i : Int, v : Double) -> PhysicsheatconvectionTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_table_sum(s : PhysicsheatconvectionTable) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_table_mean(s : PhysicsheatconvectionTable) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_table_scale(s : PhysicsheatconvectionTable, f : Double) -> PhysicsheatconvectionTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_table_add(a : PhysicsheatconvectionTable, b : PhysicsheatconvectionTable) -> PhysicsheatconvectionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_table_copy(s : PhysicsheatconvectionTable) -> PhysicsheatconvectionTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_table_fill(s : PhysicsheatconvectionTable, v : Double) -> PhysicsheatconvectionTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_table_min(s : PhysicsheatconvectionTable) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_table_max(s : PhysicsheatconvectionTable) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_table_to_string(s : PhysicsheatconvectionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_graphn_make(size : Int) -> PhysicsheatconvectionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_graphn_len(s : PhysicsheatconvectionGraphN) -> Int { s.size }

pub fn physics_heat_convection_graphn_get(s : PhysicsheatconvectionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_graphn_set(s : PhysicsheatconvectionGraphN, i : Int, v : Double) -> PhysicsheatconvectionGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_graphn_sum(s : PhysicsheatconvectionGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_graphn_mean(s : PhysicsheatconvectionGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_graphn_scale(s : PhysicsheatconvectionGraphN, f : Double) -> PhysicsheatconvectionGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_graphn_add(a : PhysicsheatconvectionGraphN, b : PhysicsheatconvectionGraphN) -> PhysicsheatconvectionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_graphn_copy(s : PhysicsheatconvectionGraphN) -> PhysicsheatconvectionGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_graphn_fill(s : PhysicsheatconvectionGraphN, v : Double) -> PhysicsheatconvectionGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_graphn_min(s : PhysicsheatconvectionGraphN) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_graphn_max(s : PhysicsheatconvectionGraphN) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_graphn_to_string(s : PhysicsheatconvectionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_node_make(size : Int) -> PhysicsheatconvectionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_node_len(s : PhysicsheatconvectionNode) -> Int { s.size }

pub fn physics_heat_convection_node_get(s : PhysicsheatconvectionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_node_set(s : PhysicsheatconvectionNode, i : Int, v : Double) -> PhysicsheatconvectionNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_node_sum(s : PhysicsheatconvectionNode) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_node_mean(s : PhysicsheatconvectionNode) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_node_scale(s : PhysicsheatconvectionNode, f : Double) -> PhysicsheatconvectionNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_node_add(a : PhysicsheatconvectionNode, b : PhysicsheatconvectionNode) -> PhysicsheatconvectionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_node_copy(s : PhysicsheatconvectionNode) -> PhysicsheatconvectionNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_node_fill(s : PhysicsheatconvectionNode, v : Double) -> PhysicsheatconvectionNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_node_min(s : PhysicsheatconvectionNode) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_node_max(s : PhysicsheatconvectionNode) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_node_to_string(s : PhysicsheatconvectionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_edge_make(size : Int) -> PhysicsheatconvectionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_edge_len(s : PhysicsheatconvectionEdge) -> Int { s.size }

pub fn physics_heat_convection_edge_get(s : PhysicsheatconvectionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_edge_set(s : PhysicsheatconvectionEdge, i : Int, v : Double) -> PhysicsheatconvectionEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_edge_sum(s : PhysicsheatconvectionEdge) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_edge_mean(s : PhysicsheatconvectionEdge) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_edge_scale(s : PhysicsheatconvectionEdge, f : Double) -> PhysicsheatconvectionEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_edge_add(a : PhysicsheatconvectionEdge, b : PhysicsheatconvectionEdge) -> PhysicsheatconvectionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_edge_copy(s : PhysicsheatconvectionEdge) -> PhysicsheatconvectionEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_edge_fill(s : PhysicsheatconvectionEdge, v : Double) -> PhysicsheatconvectionEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_edge_min(s : PhysicsheatconvectionEdge) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_edge_max(s : PhysicsheatconvectionEdge) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_edge_to_string(s : PhysicsheatconvectionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_path_make(size : Int) -> PhysicsheatconvectionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_path_len(s : PhysicsheatconvectionPath) -> Int { s.size }

pub fn physics_heat_convection_path_get(s : PhysicsheatconvectionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_path_set(s : PhysicsheatconvectionPath, i : Int, v : Double) -> PhysicsheatconvectionPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_path_sum(s : PhysicsheatconvectionPath) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_path_mean(s : PhysicsheatconvectionPath) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_path_scale(s : PhysicsheatconvectionPath, f : Double) -> PhysicsheatconvectionPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_path_add(a : PhysicsheatconvectionPath, b : PhysicsheatconvectionPath) -> PhysicsheatconvectionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_path_copy(s : PhysicsheatconvectionPath) -> PhysicsheatconvectionPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_path_fill(s : PhysicsheatconvectionPath, v : Double) -> PhysicsheatconvectionPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_path_min(s : PhysicsheatconvectionPath) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_path_max(s : PhysicsheatconvectionPath) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_path_to_string(s : PhysicsheatconvectionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_cluster_make(size : Int) -> PhysicsheatconvectionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_cluster_len(s : PhysicsheatconvectionCluster) -> Int { s.size }

pub fn physics_heat_convection_cluster_get(s : PhysicsheatconvectionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_cluster_set(s : PhysicsheatconvectionCluster, i : Int, v : Double) -> PhysicsheatconvectionCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_cluster_sum(s : PhysicsheatconvectionCluster) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_cluster_mean(s : PhysicsheatconvectionCluster) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_cluster_scale(s : PhysicsheatconvectionCluster, f : Double) -> PhysicsheatconvectionCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_cluster_add(a : PhysicsheatconvectionCluster, b : PhysicsheatconvectionCluster) -> PhysicsheatconvectionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_cluster_copy(s : PhysicsheatconvectionCluster) -> PhysicsheatconvectionCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_cluster_fill(s : PhysicsheatconvectionCluster, v : Double) -> PhysicsheatconvectionCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_cluster_min(s : PhysicsheatconvectionCluster) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_cluster_max(s : PhysicsheatconvectionCluster) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_cluster_to_string(s : PhysicsheatconvectionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_model_make(size : Int) -> PhysicsheatconvectionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_model_len(s : PhysicsheatconvectionModel) -> Int { s.size }

pub fn physics_heat_convection_model_get(s : PhysicsheatconvectionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_model_set(s : PhysicsheatconvectionModel, i : Int, v : Double) -> PhysicsheatconvectionModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_model_sum(s : PhysicsheatconvectionModel) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_model_mean(s : PhysicsheatconvectionModel) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_model_scale(s : PhysicsheatconvectionModel, f : Double) -> PhysicsheatconvectionModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_model_add(a : PhysicsheatconvectionModel, b : PhysicsheatconvectionModel) -> PhysicsheatconvectionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_model_copy(s : PhysicsheatconvectionModel) -> PhysicsheatconvectionModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_model_fill(s : PhysicsheatconvectionModel, v : Double) -> PhysicsheatconvectionModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_model_min(s : PhysicsheatconvectionModel) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_model_max(s : PhysicsheatconvectionModel) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_model_to_string(s : PhysicsheatconvectionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_layer_make(size : Int) -> PhysicsheatconvectionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_layer_len(s : PhysicsheatconvectionLayer) -> Int { s.size }

pub fn physics_heat_convection_layer_get(s : PhysicsheatconvectionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_layer_set(s : PhysicsheatconvectionLayer, i : Int, v : Double) -> PhysicsheatconvectionLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_layer_sum(s : PhysicsheatconvectionLayer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_layer_mean(s : PhysicsheatconvectionLayer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_layer_scale(s : PhysicsheatconvectionLayer, f : Double) -> PhysicsheatconvectionLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_layer_add(a : PhysicsheatconvectionLayer, b : PhysicsheatconvectionLayer) -> PhysicsheatconvectionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_layer_copy(s : PhysicsheatconvectionLayer) -> PhysicsheatconvectionLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_layer_fill(s : PhysicsheatconvectionLayer, v : Double) -> PhysicsheatconvectionLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_layer_min(s : PhysicsheatconvectionLayer) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_layer_max(s : PhysicsheatconvectionLayer) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_layer_to_string(s : PhysicsheatconvectionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_buffer_make(size : Int) -> PhysicsheatconvectionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_buffer_len(s : PhysicsheatconvectionBuffer) -> Int { s.size }

pub fn physics_heat_convection_buffer_get(s : PhysicsheatconvectionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_buffer_set(s : PhysicsheatconvectionBuffer, i : Int, v : Double) -> PhysicsheatconvectionBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_buffer_sum(s : PhysicsheatconvectionBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_buffer_mean(s : PhysicsheatconvectionBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_buffer_scale(s : PhysicsheatconvectionBuffer, f : Double) -> PhysicsheatconvectionBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_buffer_add(a : PhysicsheatconvectionBuffer, b : PhysicsheatconvectionBuffer) -> PhysicsheatconvectionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_buffer_copy(s : PhysicsheatconvectionBuffer) -> PhysicsheatconvectionBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_buffer_fill(s : PhysicsheatconvectionBuffer, v : Double) -> PhysicsheatconvectionBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_buffer_min(s : PhysicsheatconvectionBuffer) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_buffer_max(s : PhysicsheatconvectionBuffer) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_buffer_to_string(s : PhysicsheatconvectionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_cursor_make(size : Int) -> PhysicsheatconvectionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_cursor_len(s : PhysicsheatconvectionCursor) -> Int { s.size }

pub fn physics_heat_convection_cursor_get(s : PhysicsheatconvectionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_cursor_set(s : PhysicsheatconvectionCursor, i : Int, v : Double) -> PhysicsheatconvectionCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_cursor_sum(s : PhysicsheatconvectionCursor) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_cursor_mean(s : PhysicsheatconvectionCursor) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_cursor_scale(s : PhysicsheatconvectionCursor, f : Double) -> PhysicsheatconvectionCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_cursor_add(a : PhysicsheatconvectionCursor, b : PhysicsheatconvectionCursor) -> PhysicsheatconvectionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_cursor_copy(s : PhysicsheatconvectionCursor) -> PhysicsheatconvectionCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_cursor_fill(s : PhysicsheatconvectionCursor, v : Double) -> PhysicsheatconvectionCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_cursor_min(s : PhysicsheatconvectionCursor) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_cursor_max(s : PhysicsheatconvectionCursor) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_cursor_to_string(s : PhysicsheatconvectionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_view_make(size : Int) -> PhysicsheatconvectionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_view_len(s : PhysicsheatconvectionView) -> Int { s.size }

pub fn physics_heat_convection_view_get(s : PhysicsheatconvectionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_view_set(s : PhysicsheatconvectionView, i : Int, v : Double) -> PhysicsheatconvectionView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_view_sum(s : PhysicsheatconvectionView) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_view_mean(s : PhysicsheatconvectionView) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_view_scale(s : PhysicsheatconvectionView, f : Double) -> PhysicsheatconvectionView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_view_add(a : PhysicsheatconvectionView, b : PhysicsheatconvectionView) -> PhysicsheatconvectionView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_view_copy(s : PhysicsheatconvectionView) -> PhysicsheatconvectionView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_view_fill(s : PhysicsheatconvectionView, v : Double) -> PhysicsheatconvectionView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_view_min(s : PhysicsheatconvectionView) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_view_max(s : PhysicsheatconvectionView) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_view_to_string(s : PhysicsheatconvectionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_range_make(size : Int) -> PhysicsheatconvectionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_range_len(s : PhysicsheatconvectionRange) -> Int { s.size }

pub fn physics_heat_convection_range_get(s : PhysicsheatconvectionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_range_set(s : PhysicsheatconvectionRange, i : Int, v : Double) -> PhysicsheatconvectionRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_range_sum(s : PhysicsheatconvectionRange) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_range_mean(s : PhysicsheatconvectionRange) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_range_scale(s : PhysicsheatconvectionRange, f : Double) -> PhysicsheatconvectionRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_range_add(a : PhysicsheatconvectionRange, b : PhysicsheatconvectionRange) -> PhysicsheatconvectionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_range_copy(s : PhysicsheatconvectionRange) -> PhysicsheatconvectionRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_range_fill(s : PhysicsheatconvectionRange, v : Double) -> PhysicsheatconvectionRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_range_min(s : PhysicsheatconvectionRange) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_range_max(s : PhysicsheatconvectionRange) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_range_to_string(s : PhysicsheatconvectionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconvectionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_convection_slice_make(size : Int) -> PhysicsheatconvectionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_convection_slice_len(s : PhysicsheatconvectionSlice) -> Int { s.size }

pub fn physics_heat_convection_slice_get(s : PhysicsheatconvectionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_convection_slice_set(s : PhysicsheatconvectionSlice, i : Int, v : Double) -> PhysicsheatconvectionSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_slice_sum(s : PhysicsheatconvectionSlice) -> Double { @_common.sum(s.data) }

pub fn physics_heat_convection_slice_mean(s : PhysicsheatconvectionSlice) -> Double { @_common.mean(s.data) }

pub fn physics_heat_convection_slice_scale(s : PhysicsheatconvectionSlice, f : Double) -> PhysicsheatconvectionSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_slice_add(a : PhysicsheatconvectionSlice, b : PhysicsheatconvectionSlice) -> PhysicsheatconvectionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_convection_slice_copy(s : PhysicsheatconvectionSlice) -> PhysicsheatconvectionSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_slice_fill(s : PhysicsheatconvectionSlice, v : Double) -> PhysicsheatconvectionSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_convection_slice_min(s : PhysicsheatconvectionSlice) -> Double { @_common.min(s.data) }

pub fn physics_heat_convection_slice_max(s : PhysicsheatconvectionSlice) -> Double { @_common.max(s.data) }

pub fn physics_heat_convection_slice_to_string(s : PhysicsheatconvectionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

