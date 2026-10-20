///===
/// extcore/physics_heat_conduction

pub(all) struct PhysicsheatconductionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_conduction_make_point(x : Double, y : Double) -> PhysicsheatconductionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_conduction_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatconductionPoint {
  { x, y, z, label: 0 }
}

pub fn physics_heat_conduction_point_x(pt : PhysicsheatconductionPoint) -> Double { pt.x }

pub fn physics_heat_conduction_point_y(pt : PhysicsheatconductionPoint) -> Double { pt.y }

pub fn physics_heat_conduction_point_z(pt : PhysicsheatconductionPoint) -> Double { pt.z }

pub fn physics_heat_conduction_point_label(pt : PhysicsheatconductionPoint) -> Int { pt.label }

pub fn physics_heat_conduction_point_dist(a : PhysicsheatconductionPoint, b : PhysicsheatconductionPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_heat_conduction_point_add(a : PhysicsheatconductionPoint, b : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_heat_conduction_point_sub(a : PhysicsheatconductionPoint, b : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_heat_conduction_point_scale(pt : PhysicsheatconductionPoint, s : Double) -> PhysicsheatconductionPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_heat_conduction_point_dot(a : PhysicsheatconductionPoint, b : PhysicsheatconductionPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_heat_conduction_point_cross(a : PhysicsheatconductionPoint, b : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_heat_conduction_point_norm(pt : PhysicsheatconductionPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_heat_conduction_point_normalize(pt : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  let n = physics_heat_conduction_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_heat_conduction_point_scale(pt, 1.0 / n) }
}

pub fn physics_heat_conduction_point_negate(pt : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_heat_conduction_point_mid(a : PhysicsheatconductionPoint, b : PhysicsheatconductionPoint) -> PhysicsheatconductionPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_heat_conduction_point_lerp(a : PhysicsheatconductionPoint, b : PhysicsheatconductionPoint, t : Double) -> PhysicsheatconductionPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_heat_conduction_point_to_string(pt : PhysicsheatconductionPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsheatconductionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_conduction_make_series(vals : Array[Double], name : String) -> PhysicsheatconductionSeries {
  { vals, name, meta: 0 }
}

pub fn physics_heat_conduction_series_len(s : PhysicsheatconductionSeries) -> Int { s.vals.length() }

pub fn physics_heat_conduction_series_sum(s : PhysicsheatconductionSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_heat_conduction_series_mean(s : PhysicsheatconductionSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_heat_conduction_series_min(s : PhysicsheatconductionSeries) -> Double { @_common.min(s.vals) }

pub fn physics_heat_conduction_series_max(s : PhysicsheatconductionSeries) -> Double { @_common.max(s.vals) }

pub fn physics_heat_conduction_series_range(s : PhysicsheatconductionSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_heat_conduction_series_var(s : PhysicsheatconductionSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_heat_conduction_series_std(s : PhysicsheatconductionSeries) -> Double { @_common.std(s.vals) }

pub fn physics_heat_conduction_series_median(s : PhysicsheatconductionSeries) -> Double { @_common.median(s.vals) }

pub fn physics_heat_conduction_series_scale(s : PhysicsheatconductionSeries, f : Double) -> PhysicsheatconductionSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn physics_heat_conduction_series_add(a : PhysicsheatconductionSeries, b : PhysicsheatconductionSeries) -> PhysicsheatconductionSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_heat_conduction_series_sub(a : PhysicsheatconductionSeries, b : PhysicsheatconductionSeries) -> PhysicsheatconductionSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_heat_conduction_series_normalize(s : PhysicsheatconductionSeries) -> PhysicsheatconductionSeries {
  let mn = physics_heat_conduction_series_min(s)
  let mx = physics_heat_conduction_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_heat_conduction_series_cumsum(s : PhysicsheatconductionSeries) -> PhysicsheatconductionSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_heat_conduction_series_to_string(s : PhysicsheatconductionSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatconductionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_conduction_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatconductionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_conduction_matrix_identity(n : Int) -> PhysicsheatconductionMatrix {
  let m = physics_heat_conduction_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_heat_conduction_matrix_get(m : PhysicsheatconductionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_heat_conduction_matrix_transpose(m : PhysicsheatconductionMatrix) -> PhysicsheatconductionMatrix {
  let result = physics_heat_conduction_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_heat_conduction_matrix_add(a : PhysicsheatconductionMatrix, b : PhysicsheatconductionMatrix) -> PhysicsheatconductionMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_heat_conduction_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_heat_conduction_matrix_scale(m : PhysicsheatconductionMatrix, s : Double) -> PhysicsheatconductionMatrix {
  let result = physics_heat_conduction_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_heat_conduction_matrix_multiply(a : PhysicsheatconductionMatrix, b : PhysicsheatconductionMatrix) -> PhysicsheatconductionMatrix {
  if a.cols != b.rows { return physics_heat_conduction_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_heat_conduction_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_heat_conduction_matrix_trace(m : PhysicsheatconductionMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_heat_conduction_matrix_det(m : PhysicsheatconductionMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_heat_conduction_matrix_norm(m : PhysicsheatconductionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_heat_conduction_matrix_to_string(m : PhysicsheatconductionMatrix) -> String {
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

pub(all) struct PhysicsheatconductionVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_conduction_make_vector(comps : Array[Double]) -> PhysicsheatconductionVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_conduction_vector_zero(dim : Int) -> PhysicsheatconductionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_heat_conduction_vector_add(a : PhysicsheatconductionVector, b : PhysicsheatconductionVector) -> PhysicsheatconductionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn physics_heat_conduction_vector_sub(a : PhysicsheatconductionVector, b : PhysicsheatconductionVector) -> PhysicsheatconductionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn physics_heat_conduction_vector_scale(v : PhysicsheatconductionVector, s : Double) -> PhysicsheatconductionVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn physics_heat_conduction_vector_dot(a : PhysicsheatconductionVector, b : PhysicsheatconductionVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_heat_conduction_vector_norm(v : PhysicsheatconductionVector) -> Double { @_common.sqrt(physics_heat_conduction_vector_dot(v, v)) }

pub fn physics_heat_conduction_vector_normalize(v : PhysicsheatconductionVector) -> PhysicsheatconductionVector {
  let n = physics_heat_conduction_vector_norm(v)
  if n < 0.0000001 { v } else { physics_heat_conduction_vector_scale(v, 1.0 / n) }
}

pub fn physics_heat_conduction_vector_dist(a : PhysicsheatconductionVector, b : PhysicsheatconductionVector) -> Double {
  physics_heat_conduction_vector_norm(physics_heat_conduction_vector_sub(a, b))
}

pub fn physics_heat_conduction_vector_to_string(v : PhysicsheatconductionVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_conduction_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_heat_conduction_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_heat_conduction_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_heat_conduction_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_heat_conduction_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_heat_conduction_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_heat_conduction_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_heat_conduction_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_heat_conduction_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_heat_conduction_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_heat_conduction_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_heat_conduction_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_heat_conduction_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_heat_conduction_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_heat_conduction_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_heat_conduction_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_heat_conduction_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_heat_conduction_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_heat_conduction_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_heat_conduction_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_heat_conduction_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_heat_conduction_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_heat_conduction_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_heat_conduction_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_heat_conduction_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_heat_conduction_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_heat_conduction_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_heat_conduction_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_heat_conduction_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsheatconductionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_frame_make(size : Int) -> PhysicsheatconductionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_frame_len(s : PhysicsheatconductionFrame) -> Int { s.size }

pub fn physics_heat_conduction_frame_get(s : PhysicsheatconductionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_frame_set(s : PhysicsheatconductionFrame, i : Int, v : Double) -> PhysicsheatconductionFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_frame_sum(s : PhysicsheatconductionFrame) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_frame_mean(s : PhysicsheatconductionFrame) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_frame_scale(s : PhysicsheatconductionFrame, f : Double) -> PhysicsheatconductionFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_frame_add(a : PhysicsheatconductionFrame, b : PhysicsheatconductionFrame) -> PhysicsheatconductionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_frame_copy(s : PhysicsheatconductionFrame) -> PhysicsheatconductionFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_frame_fill(s : PhysicsheatconductionFrame, v : Double) -> PhysicsheatconductionFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_frame_min(s : PhysicsheatconductionFrame) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_frame_max(s : PhysicsheatconductionFrame) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_frame_to_string(s : PhysicsheatconductionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_table_make(size : Int) -> PhysicsheatconductionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_table_len(s : PhysicsheatconductionTable) -> Int { s.size }

pub fn physics_heat_conduction_table_get(s : PhysicsheatconductionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_table_set(s : PhysicsheatconductionTable, i : Int, v : Double) -> PhysicsheatconductionTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_table_sum(s : PhysicsheatconductionTable) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_table_mean(s : PhysicsheatconductionTable) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_table_scale(s : PhysicsheatconductionTable, f : Double) -> PhysicsheatconductionTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_table_add(a : PhysicsheatconductionTable, b : PhysicsheatconductionTable) -> PhysicsheatconductionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_table_copy(s : PhysicsheatconductionTable) -> PhysicsheatconductionTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_table_fill(s : PhysicsheatconductionTable, v : Double) -> PhysicsheatconductionTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_table_min(s : PhysicsheatconductionTable) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_table_max(s : PhysicsheatconductionTable) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_table_to_string(s : PhysicsheatconductionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_graphn_make(size : Int) -> PhysicsheatconductionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_graphn_len(s : PhysicsheatconductionGraphN) -> Int { s.size }

pub fn physics_heat_conduction_graphn_get(s : PhysicsheatconductionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_graphn_set(s : PhysicsheatconductionGraphN, i : Int, v : Double) -> PhysicsheatconductionGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_graphn_sum(s : PhysicsheatconductionGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_graphn_mean(s : PhysicsheatconductionGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_graphn_scale(s : PhysicsheatconductionGraphN, f : Double) -> PhysicsheatconductionGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_graphn_add(a : PhysicsheatconductionGraphN, b : PhysicsheatconductionGraphN) -> PhysicsheatconductionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_graphn_copy(s : PhysicsheatconductionGraphN) -> PhysicsheatconductionGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_graphn_fill(s : PhysicsheatconductionGraphN, v : Double) -> PhysicsheatconductionGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_graphn_min(s : PhysicsheatconductionGraphN) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_graphn_max(s : PhysicsheatconductionGraphN) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_graphn_to_string(s : PhysicsheatconductionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_node_make(size : Int) -> PhysicsheatconductionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_node_len(s : PhysicsheatconductionNode) -> Int { s.size }

pub fn physics_heat_conduction_node_get(s : PhysicsheatconductionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_node_set(s : PhysicsheatconductionNode, i : Int, v : Double) -> PhysicsheatconductionNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_node_sum(s : PhysicsheatconductionNode) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_node_mean(s : PhysicsheatconductionNode) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_node_scale(s : PhysicsheatconductionNode, f : Double) -> PhysicsheatconductionNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_node_add(a : PhysicsheatconductionNode, b : PhysicsheatconductionNode) -> PhysicsheatconductionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_node_copy(s : PhysicsheatconductionNode) -> PhysicsheatconductionNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_node_fill(s : PhysicsheatconductionNode, v : Double) -> PhysicsheatconductionNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_node_min(s : PhysicsheatconductionNode) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_node_max(s : PhysicsheatconductionNode) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_node_to_string(s : PhysicsheatconductionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_edge_make(size : Int) -> PhysicsheatconductionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_edge_len(s : PhysicsheatconductionEdge) -> Int { s.size }

pub fn physics_heat_conduction_edge_get(s : PhysicsheatconductionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_edge_set(s : PhysicsheatconductionEdge, i : Int, v : Double) -> PhysicsheatconductionEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_edge_sum(s : PhysicsheatconductionEdge) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_edge_mean(s : PhysicsheatconductionEdge) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_edge_scale(s : PhysicsheatconductionEdge, f : Double) -> PhysicsheatconductionEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_edge_add(a : PhysicsheatconductionEdge, b : PhysicsheatconductionEdge) -> PhysicsheatconductionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_edge_copy(s : PhysicsheatconductionEdge) -> PhysicsheatconductionEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_edge_fill(s : PhysicsheatconductionEdge, v : Double) -> PhysicsheatconductionEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_edge_min(s : PhysicsheatconductionEdge) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_edge_max(s : PhysicsheatconductionEdge) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_edge_to_string(s : PhysicsheatconductionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_path_make(size : Int) -> PhysicsheatconductionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_path_len(s : PhysicsheatconductionPath) -> Int { s.size }

pub fn physics_heat_conduction_path_get(s : PhysicsheatconductionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_path_set(s : PhysicsheatconductionPath, i : Int, v : Double) -> PhysicsheatconductionPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_path_sum(s : PhysicsheatconductionPath) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_path_mean(s : PhysicsheatconductionPath) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_path_scale(s : PhysicsheatconductionPath, f : Double) -> PhysicsheatconductionPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_path_add(a : PhysicsheatconductionPath, b : PhysicsheatconductionPath) -> PhysicsheatconductionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_path_copy(s : PhysicsheatconductionPath) -> PhysicsheatconductionPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_path_fill(s : PhysicsheatconductionPath, v : Double) -> PhysicsheatconductionPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_path_min(s : PhysicsheatconductionPath) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_path_max(s : PhysicsheatconductionPath) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_path_to_string(s : PhysicsheatconductionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_cluster_make(size : Int) -> PhysicsheatconductionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_cluster_len(s : PhysicsheatconductionCluster) -> Int { s.size }

pub fn physics_heat_conduction_cluster_get(s : PhysicsheatconductionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_cluster_set(s : PhysicsheatconductionCluster, i : Int, v : Double) -> PhysicsheatconductionCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_cluster_sum(s : PhysicsheatconductionCluster) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_cluster_mean(s : PhysicsheatconductionCluster) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_cluster_scale(s : PhysicsheatconductionCluster, f : Double) -> PhysicsheatconductionCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_cluster_add(a : PhysicsheatconductionCluster, b : PhysicsheatconductionCluster) -> PhysicsheatconductionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_cluster_copy(s : PhysicsheatconductionCluster) -> PhysicsheatconductionCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_cluster_fill(s : PhysicsheatconductionCluster, v : Double) -> PhysicsheatconductionCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_cluster_min(s : PhysicsheatconductionCluster) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_cluster_max(s : PhysicsheatconductionCluster) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_cluster_to_string(s : PhysicsheatconductionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_model_make(size : Int) -> PhysicsheatconductionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_model_len(s : PhysicsheatconductionModel) -> Int { s.size }

pub fn physics_heat_conduction_model_get(s : PhysicsheatconductionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_model_set(s : PhysicsheatconductionModel, i : Int, v : Double) -> PhysicsheatconductionModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_model_sum(s : PhysicsheatconductionModel) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_model_mean(s : PhysicsheatconductionModel) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_model_scale(s : PhysicsheatconductionModel, f : Double) -> PhysicsheatconductionModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_model_add(a : PhysicsheatconductionModel, b : PhysicsheatconductionModel) -> PhysicsheatconductionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_model_copy(s : PhysicsheatconductionModel) -> PhysicsheatconductionModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_model_fill(s : PhysicsheatconductionModel, v : Double) -> PhysicsheatconductionModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_model_min(s : PhysicsheatconductionModel) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_model_max(s : PhysicsheatconductionModel) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_model_to_string(s : PhysicsheatconductionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_layer_make(size : Int) -> PhysicsheatconductionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_layer_len(s : PhysicsheatconductionLayer) -> Int { s.size }

pub fn physics_heat_conduction_layer_get(s : PhysicsheatconductionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_layer_set(s : PhysicsheatconductionLayer, i : Int, v : Double) -> PhysicsheatconductionLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_layer_sum(s : PhysicsheatconductionLayer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_layer_mean(s : PhysicsheatconductionLayer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_layer_scale(s : PhysicsheatconductionLayer, f : Double) -> PhysicsheatconductionLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_layer_add(a : PhysicsheatconductionLayer, b : PhysicsheatconductionLayer) -> PhysicsheatconductionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_layer_copy(s : PhysicsheatconductionLayer) -> PhysicsheatconductionLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_layer_fill(s : PhysicsheatconductionLayer, v : Double) -> PhysicsheatconductionLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_layer_min(s : PhysicsheatconductionLayer) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_layer_max(s : PhysicsheatconductionLayer) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_layer_to_string(s : PhysicsheatconductionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_buffer_make(size : Int) -> PhysicsheatconductionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_buffer_len(s : PhysicsheatconductionBuffer) -> Int { s.size }

pub fn physics_heat_conduction_buffer_get(s : PhysicsheatconductionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_buffer_set(s : PhysicsheatconductionBuffer, i : Int, v : Double) -> PhysicsheatconductionBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_buffer_sum(s : PhysicsheatconductionBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_buffer_mean(s : PhysicsheatconductionBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_buffer_scale(s : PhysicsheatconductionBuffer, f : Double) -> PhysicsheatconductionBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_buffer_add(a : PhysicsheatconductionBuffer, b : PhysicsheatconductionBuffer) -> PhysicsheatconductionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_buffer_copy(s : PhysicsheatconductionBuffer) -> PhysicsheatconductionBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_buffer_fill(s : PhysicsheatconductionBuffer, v : Double) -> PhysicsheatconductionBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_buffer_min(s : PhysicsheatconductionBuffer) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_buffer_max(s : PhysicsheatconductionBuffer) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_buffer_to_string(s : PhysicsheatconductionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_cursor_make(size : Int) -> PhysicsheatconductionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_cursor_len(s : PhysicsheatconductionCursor) -> Int { s.size }

pub fn physics_heat_conduction_cursor_get(s : PhysicsheatconductionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_cursor_set(s : PhysicsheatconductionCursor, i : Int, v : Double) -> PhysicsheatconductionCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_cursor_sum(s : PhysicsheatconductionCursor) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_cursor_mean(s : PhysicsheatconductionCursor) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_cursor_scale(s : PhysicsheatconductionCursor, f : Double) -> PhysicsheatconductionCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_cursor_add(a : PhysicsheatconductionCursor, b : PhysicsheatconductionCursor) -> PhysicsheatconductionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_cursor_copy(s : PhysicsheatconductionCursor) -> PhysicsheatconductionCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_cursor_fill(s : PhysicsheatconductionCursor, v : Double) -> PhysicsheatconductionCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_cursor_min(s : PhysicsheatconductionCursor) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_cursor_max(s : PhysicsheatconductionCursor) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_cursor_to_string(s : PhysicsheatconductionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_view_make(size : Int) -> PhysicsheatconductionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_view_len(s : PhysicsheatconductionView) -> Int { s.size }

pub fn physics_heat_conduction_view_get(s : PhysicsheatconductionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_view_set(s : PhysicsheatconductionView, i : Int, v : Double) -> PhysicsheatconductionView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_view_sum(s : PhysicsheatconductionView) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_view_mean(s : PhysicsheatconductionView) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_view_scale(s : PhysicsheatconductionView, f : Double) -> PhysicsheatconductionView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_view_add(a : PhysicsheatconductionView, b : PhysicsheatconductionView) -> PhysicsheatconductionView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_view_copy(s : PhysicsheatconductionView) -> PhysicsheatconductionView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_view_fill(s : PhysicsheatconductionView, v : Double) -> PhysicsheatconductionView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_view_min(s : PhysicsheatconductionView) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_view_max(s : PhysicsheatconductionView) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_view_to_string(s : PhysicsheatconductionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_range_make(size : Int) -> PhysicsheatconductionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_range_len(s : PhysicsheatconductionRange) -> Int { s.size }

pub fn physics_heat_conduction_range_get(s : PhysicsheatconductionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_range_set(s : PhysicsheatconductionRange, i : Int, v : Double) -> PhysicsheatconductionRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_range_sum(s : PhysicsheatconductionRange) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_range_mean(s : PhysicsheatconductionRange) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_range_scale(s : PhysicsheatconductionRange, f : Double) -> PhysicsheatconductionRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_range_add(a : PhysicsheatconductionRange, b : PhysicsheatconductionRange) -> PhysicsheatconductionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_range_copy(s : PhysicsheatconductionRange) -> PhysicsheatconductionRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_range_fill(s : PhysicsheatconductionRange, v : Double) -> PhysicsheatconductionRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_range_min(s : PhysicsheatconductionRange) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_range_max(s : PhysicsheatconductionRange) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_range_to_string(s : PhysicsheatconductionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatconductionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_conduction_slice_make(size : Int) -> PhysicsheatconductionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_conduction_slice_len(s : PhysicsheatconductionSlice) -> Int { s.size }

pub fn physics_heat_conduction_slice_get(s : PhysicsheatconductionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_conduction_slice_set(s : PhysicsheatconductionSlice, i : Int, v : Double) -> PhysicsheatconductionSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_slice_sum(s : PhysicsheatconductionSlice) -> Double { @_common.sum(s.data) }

pub fn physics_heat_conduction_slice_mean(s : PhysicsheatconductionSlice) -> Double { @_common.mean(s.data) }

pub fn physics_heat_conduction_slice_scale(s : PhysicsheatconductionSlice, f : Double) -> PhysicsheatconductionSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_slice_add(a : PhysicsheatconductionSlice, b : PhysicsheatconductionSlice) -> PhysicsheatconductionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_conduction_slice_copy(s : PhysicsheatconductionSlice) -> PhysicsheatconductionSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_slice_fill(s : PhysicsheatconductionSlice, v : Double) -> PhysicsheatconductionSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_conduction_slice_min(s : PhysicsheatconductionSlice) -> Double { @_common.min(s.data) }

pub fn physics_heat_conduction_slice_max(s : PhysicsheatconductionSlice) -> Double { @_common.max(s.data) }

pub fn physics_heat_conduction_slice_to_string(s : PhysicsheatconductionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

