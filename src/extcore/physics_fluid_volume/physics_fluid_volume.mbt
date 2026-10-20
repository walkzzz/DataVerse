///===
/// extcore/physics_fluid_volume

pub(all) struct PhysicsfluidvolumePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_volume_make_point(x : Double, y : Double) -> PhysicsfluidvolumePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_volume_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidvolumePoint {
  { x, y, z, label: 0 }
}

pub fn physics_fluid_volume_point_x(pt : PhysicsfluidvolumePoint) -> Double { pt.x }

pub fn physics_fluid_volume_point_y(pt : PhysicsfluidvolumePoint) -> Double { pt.y }

pub fn physics_fluid_volume_point_z(pt : PhysicsfluidvolumePoint) -> Double { pt.z }

pub fn physics_fluid_volume_point_label(pt : PhysicsfluidvolumePoint) -> Int { pt.label }

pub fn physics_fluid_volume_point_dist(a : PhysicsfluidvolumePoint, b : PhysicsfluidvolumePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_fluid_volume_point_add(a : PhysicsfluidvolumePoint, b : PhysicsfluidvolumePoint) -> PhysicsfluidvolumePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_fluid_volume_point_sub(a : PhysicsfluidvolumePoint, b : PhysicsfluidvolumePoint) -> PhysicsfluidvolumePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_fluid_volume_point_scale(pt : PhysicsfluidvolumePoint, s : Double) -> PhysicsfluidvolumePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_fluid_volume_point_dot(a : PhysicsfluidvolumePoint, b : PhysicsfluidvolumePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_fluid_volume_point_cross(a : PhysicsfluidvolumePoint, b : PhysicsfluidvolumePoint) -> PhysicsfluidvolumePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_fluid_volume_point_norm(pt : PhysicsfluidvolumePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_fluid_volume_point_normalize(pt : PhysicsfluidvolumePoint) -> PhysicsfluidvolumePoint {
  let n = physics_fluid_volume_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_fluid_volume_point_scale(pt, 1.0 / n) }
}

pub fn physics_fluid_volume_point_negate(pt : PhysicsfluidvolumePoint) -> PhysicsfluidvolumePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_fluid_volume_point_mid(a : PhysicsfluidvolumePoint, b : PhysicsfluidvolumePoint) -> PhysicsfluidvolumePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_fluid_volume_point_lerp(a : PhysicsfluidvolumePoint, b : PhysicsfluidvolumePoint, t : Double) -> PhysicsfluidvolumePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_fluid_volume_point_to_string(pt : PhysicsfluidvolumePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_volume_make_series(vals : Array[Double], name : String) -> PhysicsfluidvolumeSeries {
  { vals, name, meta: 0 }
}

pub fn physics_fluid_volume_series_len(s : PhysicsfluidvolumeSeries) -> Int { s.vals.length() }

pub fn physics_fluid_volume_series_sum(s : PhysicsfluidvolumeSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_fluid_volume_series_mean(s : PhysicsfluidvolumeSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_fluid_volume_series_min(s : PhysicsfluidvolumeSeries) -> Double { @_common.min(s.vals) }

pub fn physics_fluid_volume_series_max(s : PhysicsfluidvolumeSeries) -> Double { @_common.max(s.vals) }

pub fn physics_fluid_volume_series_range(s : PhysicsfluidvolumeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_fluid_volume_series_var(s : PhysicsfluidvolumeSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_fluid_volume_series_std(s : PhysicsfluidvolumeSeries) -> Double { @_common.std(s.vals) }

pub fn physics_fluid_volume_series_median(s : PhysicsfluidvolumeSeries) -> Double { @_common.median(s.vals) }

pub fn physics_fluid_volume_series_scale(s : PhysicsfluidvolumeSeries, f : Double) -> PhysicsfluidvolumeSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn physics_fluid_volume_series_add(a : PhysicsfluidvolumeSeries, b : PhysicsfluidvolumeSeries) -> PhysicsfluidvolumeSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_fluid_volume_series_sub(a : PhysicsfluidvolumeSeries, b : PhysicsfluidvolumeSeries) -> PhysicsfluidvolumeSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_fluid_volume_series_normalize(s : PhysicsfluidvolumeSeries) -> PhysicsfluidvolumeSeries {
  let mn = physics_fluid_volume_series_min(s)
  let mx = physics_fluid_volume_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_fluid_volume_series_cumsum(s : PhysicsfluidvolumeSeries) -> PhysicsfluidvolumeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_fluid_volume_series_to_string(s : PhysicsfluidvolumeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidvolumeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_volume_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidvolumeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_volume_matrix_identity(n : Int) -> PhysicsfluidvolumeMatrix {
  let m = physics_fluid_volume_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_fluid_volume_matrix_get(m : PhysicsfluidvolumeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_fluid_volume_matrix_transpose(m : PhysicsfluidvolumeMatrix) -> PhysicsfluidvolumeMatrix {
  let result = physics_fluid_volume_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_fluid_volume_matrix_add(a : PhysicsfluidvolumeMatrix, b : PhysicsfluidvolumeMatrix) -> PhysicsfluidvolumeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_fluid_volume_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_fluid_volume_matrix_scale(m : PhysicsfluidvolumeMatrix, s : Double) -> PhysicsfluidvolumeMatrix {
  let result = physics_fluid_volume_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_fluid_volume_matrix_multiply(a : PhysicsfluidvolumeMatrix, b : PhysicsfluidvolumeMatrix) -> PhysicsfluidvolumeMatrix {
  if a.cols != b.rows { return physics_fluid_volume_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_fluid_volume_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_fluid_volume_matrix_trace(m : PhysicsfluidvolumeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_fluid_volume_matrix_det(m : PhysicsfluidvolumeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_fluid_volume_matrix_norm(m : PhysicsfluidvolumeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_fluid_volume_matrix_to_string(m : PhysicsfluidvolumeMatrix) -> String {
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

pub(all) struct PhysicsfluidvolumeVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_volume_make_vector(comps : Array[Double]) -> PhysicsfluidvolumeVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_volume_vector_zero(dim : Int) -> PhysicsfluidvolumeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_fluid_volume_vector_add(a : PhysicsfluidvolumeVector, b : PhysicsfluidvolumeVector) -> PhysicsfluidvolumeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn physics_fluid_volume_vector_sub(a : PhysicsfluidvolumeVector, b : PhysicsfluidvolumeVector) -> PhysicsfluidvolumeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn physics_fluid_volume_vector_scale(v : PhysicsfluidvolumeVector, s : Double) -> PhysicsfluidvolumeVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn physics_fluid_volume_vector_dot(a : PhysicsfluidvolumeVector, b : PhysicsfluidvolumeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_fluid_volume_vector_norm(v : PhysicsfluidvolumeVector) -> Double { @_common.sqrt(physics_fluid_volume_vector_dot(v, v)) }

pub fn physics_fluid_volume_vector_normalize(v : PhysicsfluidvolumeVector) -> PhysicsfluidvolumeVector {
  let n = physics_fluid_volume_vector_norm(v)
  if n < 0.0000001 { v } else { physics_fluid_volume_vector_scale(v, 1.0 / n) }
}

pub fn physics_fluid_volume_vector_dist(a : PhysicsfluidvolumeVector, b : PhysicsfluidvolumeVector) -> Double {
  physics_fluid_volume_vector_norm(physics_fluid_volume_vector_sub(a, b))
}

pub fn physics_fluid_volume_vector_to_string(v : PhysicsfluidvolumeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_volume_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_fluid_volume_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_fluid_volume_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_fluid_volume_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_fluid_volume_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_fluid_volume_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_fluid_volume_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_fluid_volume_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_fluid_volume_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_fluid_volume_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_fluid_volume_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_fluid_volume_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_fluid_volume_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_fluid_volume_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_fluid_volume_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_fluid_volume_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_fluid_volume_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_fluid_volume_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_fluid_volume_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_fluid_volume_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_fluid_volume_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_fluid_volume_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_fluid_volume_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_fluid_volume_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_fluid_volume_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_fluid_volume_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_fluid_volume_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_fluid_volume_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_fluid_volume_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsfluidvolumeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_frame_make(size : Int) -> PhysicsfluidvolumeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_frame_len(s : PhysicsfluidvolumeFrame) -> Int { s.size }

pub fn physics_fluid_volume_frame_get(s : PhysicsfluidvolumeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_frame_set(s : PhysicsfluidvolumeFrame, i : Int, v : Double) -> PhysicsfluidvolumeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_frame_sum(s : PhysicsfluidvolumeFrame) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_frame_mean(s : PhysicsfluidvolumeFrame) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_frame_scale(s : PhysicsfluidvolumeFrame, f : Double) -> PhysicsfluidvolumeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_frame_add(a : PhysicsfluidvolumeFrame, b : PhysicsfluidvolumeFrame) -> PhysicsfluidvolumeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_frame_copy(s : PhysicsfluidvolumeFrame) -> PhysicsfluidvolumeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_frame_fill(s : PhysicsfluidvolumeFrame, v : Double) -> PhysicsfluidvolumeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_frame_min(s : PhysicsfluidvolumeFrame) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_frame_max(s : PhysicsfluidvolumeFrame) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_frame_to_string(s : PhysicsfluidvolumeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_table_make(size : Int) -> PhysicsfluidvolumeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_table_len(s : PhysicsfluidvolumeTable) -> Int { s.size }

pub fn physics_fluid_volume_table_get(s : PhysicsfluidvolumeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_table_set(s : PhysicsfluidvolumeTable, i : Int, v : Double) -> PhysicsfluidvolumeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_table_sum(s : PhysicsfluidvolumeTable) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_table_mean(s : PhysicsfluidvolumeTable) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_table_scale(s : PhysicsfluidvolumeTable, f : Double) -> PhysicsfluidvolumeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_table_add(a : PhysicsfluidvolumeTable, b : PhysicsfluidvolumeTable) -> PhysicsfluidvolumeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_table_copy(s : PhysicsfluidvolumeTable) -> PhysicsfluidvolumeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_table_fill(s : PhysicsfluidvolumeTable, v : Double) -> PhysicsfluidvolumeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_table_min(s : PhysicsfluidvolumeTable) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_table_max(s : PhysicsfluidvolumeTable) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_table_to_string(s : PhysicsfluidvolumeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_graphn_make(size : Int) -> PhysicsfluidvolumeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_graphn_len(s : PhysicsfluidvolumeGraphN) -> Int { s.size }

pub fn physics_fluid_volume_graphn_get(s : PhysicsfluidvolumeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_graphn_set(s : PhysicsfluidvolumeGraphN, i : Int, v : Double) -> PhysicsfluidvolumeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_graphn_sum(s : PhysicsfluidvolumeGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_graphn_mean(s : PhysicsfluidvolumeGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_graphn_scale(s : PhysicsfluidvolumeGraphN, f : Double) -> PhysicsfluidvolumeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_graphn_add(a : PhysicsfluidvolumeGraphN, b : PhysicsfluidvolumeGraphN) -> PhysicsfluidvolumeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_graphn_copy(s : PhysicsfluidvolumeGraphN) -> PhysicsfluidvolumeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_graphn_fill(s : PhysicsfluidvolumeGraphN, v : Double) -> PhysicsfluidvolumeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_graphn_min(s : PhysicsfluidvolumeGraphN) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_graphn_max(s : PhysicsfluidvolumeGraphN) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_graphn_to_string(s : PhysicsfluidvolumeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_node_make(size : Int) -> PhysicsfluidvolumeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_node_len(s : PhysicsfluidvolumeNode) -> Int { s.size }

pub fn physics_fluid_volume_node_get(s : PhysicsfluidvolumeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_node_set(s : PhysicsfluidvolumeNode, i : Int, v : Double) -> PhysicsfluidvolumeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_node_sum(s : PhysicsfluidvolumeNode) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_node_mean(s : PhysicsfluidvolumeNode) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_node_scale(s : PhysicsfluidvolumeNode, f : Double) -> PhysicsfluidvolumeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_node_add(a : PhysicsfluidvolumeNode, b : PhysicsfluidvolumeNode) -> PhysicsfluidvolumeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_node_copy(s : PhysicsfluidvolumeNode) -> PhysicsfluidvolumeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_node_fill(s : PhysicsfluidvolumeNode, v : Double) -> PhysicsfluidvolumeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_node_min(s : PhysicsfluidvolumeNode) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_node_max(s : PhysicsfluidvolumeNode) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_node_to_string(s : PhysicsfluidvolumeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_edge_make(size : Int) -> PhysicsfluidvolumeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_edge_len(s : PhysicsfluidvolumeEdge) -> Int { s.size }

pub fn physics_fluid_volume_edge_get(s : PhysicsfluidvolumeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_edge_set(s : PhysicsfluidvolumeEdge, i : Int, v : Double) -> PhysicsfluidvolumeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_edge_sum(s : PhysicsfluidvolumeEdge) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_edge_mean(s : PhysicsfluidvolumeEdge) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_edge_scale(s : PhysicsfluidvolumeEdge, f : Double) -> PhysicsfluidvolumeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_edge_add(a : PhysicsfluidvolumeEdge, b : PhysicsfluidvolumeEdge) -> PhysicsfluidvolumeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_edge_copy(s : PhysicsfluidvolumeEdge) -> PhysicsfluidvolumeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_edge_fill(s : PhysicsfluidvolumeEdge, v : Double) -> PhysicsfluidvolumeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_edge_min(s : PhysicsfluidvolumeEdge) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_edge_max(s : PhysicsfluidvolumeEdge) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_edge_to_string(s : PhysicsfluidvolumeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_path_make(size : Int) -> PhysicsfluidvolumePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_path_len(s : PhysicsfluidvolumePath) -> Int { s.size }

pub fn physics_fluid_volume_path_get(s : PhysicsfluidvolumePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_path_set(s : PhysicsfluidvolumePath, i : Int, v : Double) -> PhysicsfluidvolumePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_path_sum(s : PhysicsfluidvolumePath) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_path_mean(s : PhysicsfluidvolumePath) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_path_scale(s : PhysicsfluidvolumePath, f : Double) -> PhysicsfluidvolumePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_path_add(a : PhysicsfluidvolumePath, b : PhysicsfluidvolumePath) -> PhysicsfluidvolumePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_path_copy(s : PhysicsfluidvolumePath) -> PhysicsfluidvolumePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_path_fill(s : PhysicsfluidvolumePath, v : Double) -> PhysicsfluidvolumePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_path_min(s : PhysicsfluidvolumePath) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_path_max(s : PhysicsfluidvolumePath) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_path_to_string(s : PhysicsfluidvolumePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_cluster_make(size : Int) -> PhysicsfluidvolumeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_cluster_len(s : PhysicsfluidvolumeCluster) -> Int { s.size }

pub fn physics_fluid_volume_cluster_get(s : PhysicsfluidvolumeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_cluster_set(s : PhysicsfluidvolumeCluster, i : Int, v : Double) -> PhysicsfluidvolumeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_cluster_sum(s : PhysicsfluidvolumeCluster) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_cluster_mean(s : PhysicsfluidvolumeCluster) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_cluster_scale(s : PhysicsfluidvolumeCluster, f : Double) -> PhysicsfluidvolumeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_cluster_add(a : PhysicsfluidvolumeCluster, b : PhysicsfluidvolumeCluster) -> PhysicsfluidvolumeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_cluster_copy(s : PhysicsfluidvolumeCluster) -> PhysicsfluidvolumeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_cluster_fill(s : PhysicsfluidvolumeCluster, v : Double) -> PhysicsfluidvolumeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_cluster_min(s : PhysicsfluidvolumeCluster) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_cluster_max(s : PhysicsfluidvolumeCluster) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_cluster_to_string(s : PhysicsfluidvolumeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_model_make(size : Int) -> PhysicsfluidvolumeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_model_len(s : PhysicsfluidvolumeModel) -> Int { s.size }

pub fn physics_fluid_volume_model_get(s : PhysicsfluidvolumeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_model_set(s : PhysicsfluidvolumeModel, i : Int, v : Double) -> PhysicsfluidvolumeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_model_sum(s : PhysicsfluidvolumeModel) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_model_mean(s : PhysicsfluidvolumeModel) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_model_scale(s : PhysicsfluidvolumeModel, f : Double) -> PhysicsfluidvolumeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_model_add(a : PhysicsfluidvolumeModel, b : PhysicsfluidvolumeModel) -> PhysicsfluidvolumeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_model_copy(s : PhysicsfluidvolumeModel) -> PhysicsfluidvolumeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_model_fill(s : PhysicsfluidvolumeModel, v : Double) -> PhysicsfluidvolumeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_model_min(s : PhysicsfluidvolumeModel) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_model_max(s : PhysicsfluidvolumeModel) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_model_to_string(s : PhysicsfluidvolumeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_layer_make(size : Int) -> PhysicsfluidvolumeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_layer_len(s : PhysicsfluidvolumeLayer) -> Int { s.size }

pub fn physics_fluid_volume_layer_get(s : PhysicsfluidvolumeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_layer_set(s : PhysicsfluidvolumeLayer, i : Int, v : Double) -> PhysicsfluidvolumeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_layer_sum(s : PhysicsfluidvolumeLayer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_layer_mean(s : PhysicsfluidvolumeLayer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_layer_scale(s : PhysicsfluidvolumeLayer, f : Double) -> PhysicsfluidvolumeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_layer_add(a : PhysicsfluidvolumeLayer, b : PhysicsfluidvolumeLayer) -> PhysicsfluidvolumeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_layer_copy(s : PhysicsfluidvolumeLayer) -> PhysicsfluidvolumeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_layer_fill(s : PhysicsfluidvolumeLayer, v : Double) -> PhysicsfluidvolumeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_layer_min(s : PhysicsfluidvolumeLayer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_layer_max(s : PhysicsfluidvolumeLayer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_layer_to_string(s : PhysicsfluidvolumeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_buffer_make(size : Int) -> PhysicsfluidvolumeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_buffer_len(s : PhysicsfluidvolumeBuffer) -> Int { s.size }

pub fn physics_fluid_volume_buffer_get(s : PhysicsfluidvolumeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_buffer_set(s : PhysicsfluidvolumeBuffer, i : Int, v : Double) -> PhysicsfluidvolumeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_buffer_sum(s : PhysicsfluidvolumeBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_buffer_mean(s : PhysicsfluidvolumeBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_buffer_scale(s : PhysicsfluidvolumeBuffer, f : Double) -> PhysicsfluidvolumeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_buffer_add(a : PhysicsfluidvolumeBuffer, b : PhysicsfluidvolumeBuffer) -> PhysicsfluidvolumeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_buffer_copy(s : PhysicsfluidvolumeBuffer) -> PhysicsfluidvolumeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_buffer_fill(s : PhysicsfluidvolumeBuffer, v : Double) -> PhysicsfluidvolumeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_buffer_min(s : PhysicsfluidvolumeBuffer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_buffer_max(s : PhysicsfluidvolumeBuffer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_buffer_to_string(s : PhysicsfluidvolumeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_cursor_make(size : Int) -> PhysicsfluidvolumeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_cursor_len(s : PhysicsfluidvolumeCursor) -> Int { s.size }

pub fn physics_fluid_volume_cursor_get(s : PhysicsfluidvolumeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_cursor_set(s : PhysicsfluidvolumeCursor, i : Int, v : Double) -> PhysicsfluidvolumeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_cursor_sum(s : PhysicsfluidvolumeCursor) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_cursor_mean(s : PhysicsfluidvolumeCursor) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_cursor_scale(s : PhysicsfluidvolumeCursor, f : Double) -> PhysicsfluidvolumeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_cursor_add(a : PhysicsfluidvolumeCursor, b : PhysicsfluidvolumeCursor) -> PhysicsfluidvolumeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_cursor_copy(s : PhysicsfluidvolumeCursor) -> PhysicsfluidvolumeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_cursor_fill(s : PhysicsfluidvolumeCursor, v : Double) -> PhysicsfluidvolumeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_cursor_min(s : PhysicsfluidvolumeCursor) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_cursor_max(s : PhysicsfluidvolumeCursor) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_cursor_to_string(s : PhysicsfluidvolumeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_view_make(size : Int) -> PhysicsfluidvolumeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_view_len(s : PhysicsfluidvolumeView) -> Int { s.size }

pub fn physics_fluid_volume_view_get(s : PhysicsfluidvolumeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_view_set(s : PhysicsfluidvolumeView, i : Int, v : Double) -> PhysicsfluidvolumeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_view_sum(s : PhysicsfluidvolumeView) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_view_mean(s : PhysicsfluidvolumeView) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_view_scale(s : PhysicsfluidvolumeView, f : Double) -> PhysicsfluidvolumeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_view_add(a : PhysicsfluidvolumeView, b : PhysicsfluidvolumeView) -> PhysicsfluidvolumeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_view_copy(s : PhysicsfluidvolumeView) -> PhysicsfluidvolumeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_view_fill(s : PhysicsfluidvolumeView, v : Double) -> PhysicsfluidvolumeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_view_min(s : PhysicsfluidvolumeView) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_view_max(s : PhysicsfluidvolumeView) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_view_to_string(s : PhysicsfluidvolumeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_range_make(size : Int) -> PhysicsfluidvolumeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_range_len(s : PhysicsfluidvolumeRange) -> Int { s.size }

pub fn physics_fluid_volume_range_get(s : PhysicsfluidvolumeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_range_set(s : PhysicsfluidvolumeRange, i : Int, v : Double) -> PhysicsfluidvolumeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_range_sum(s : PhysicsfluidvolumeRange) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_range_mean(s : PhysicsfluidvolumeRange) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_range_scale(s : PhysicsfluidvolumeRange, f : Double) -> PhysicsfluidvolumeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_range_add(a : PhysicsfluidvolumeRange, b : PhysicsfluidvolumeRange) -> PhysicsfluidvolumeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_range_copy(s : PhysicsfluidvolumeRange) -> PhysicsfluidvolumeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_range_fill(s : PhysicsfluidvolumeRange, v : Double) -> PhysicsfluidvolumeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_range_min(s : PhysicsfluidvolumeRange) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_range_max(s : PhysicsfluidvolumeRange) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_range_to_string(s : PhysicsfluidvolumeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidvolumeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_volume_slice_make(size : Int) -> PhysicsfluidvolumeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_volume_slice_len(s : PhysicsfluidvolumeSlice) -> Int { s.size }

pub fn physics_fluid_volume_slice_get(s : PhysicsfluidvolumeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_volume_slice_set(s : PhysicsfluidvolumeSlice, i : Int, v : Double) -> PhysicsfluidvolumeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_slice_sum(s : PhysicsfluidvolumeSlice) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_volume_slice_mean(s : PhysicsfluidvolumeSlice) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_volume_slice_scale(s : PhysicsfluidvolumeSlice, f : Double) -> PhysicsfluidvolumeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_slice_add(a : PhysicsfluidvolumeSlice, b : PhysicsfluidvolumeSlice) -> PhysicsfluidvolumeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_volume_slice_copy(s : PhysicsfluidvolumeSlice) -> PhysicsfluidvolumeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_slice_fill(s : PhysicsfluidvolumeSlice, v : Double) -> PhysicsfluidvolumeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_volume_slice_min(s : PhysicsfluidvolumeSlice) -> Double { @_common.min(s.data) }

pub fn physics_fluid_volume_slice_max(s : PhysicsfluidvolumeSlice) -> Double { @_common.max(s.data) }

pub fn physics_fluid_volume_slice_to_string(s : PhysicsfluidvolumeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

