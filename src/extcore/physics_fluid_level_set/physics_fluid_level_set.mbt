///===
/// extcore/physics_fluid_level_set

pub(all) struct PhysicsfluidlevelsetPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_level_set_make_point(x : Double, y : Double) -> PhysicsfluidlevelsetPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_level_set_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidlevelsetPoint {
  { x, y, z, label: 0 }
}

pub fn physics_fluid_level_set_point_x(pt : PhysicsfluidlevelsetPoint) -> Double { pt.x }

pub fn physics_fluid_level_set_point_y(pt : PhysicsfluidlevelsetPoint) -> Double { pt.y }

pub fn physics_fluid_level_set_point_z(pt : PhysicsfluidlevelsetPoint) -> Double { pt.z }

pub fn physics_fluid_level_set_point_label(pt : PhysicsfluidlevelsetPoint) -> Int { pt.label }

pub fn physics_fluid_level_set_point_dist(a : PhysicsfluidlevelsetPoint, b : PhysicsfluidlevelsetPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_fluid_level_set_point_add(a : PhysicsfluidlevelsetPoint, b : PhysicsfluidlevelsetPoint) -> PhysicsfluidlevelsetPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_fluid_level_set_point_sub(a : PhysicsfluidlevelsetPoint, b : PhysicsfluidlevelsetPoint) -> PhysicsfluidlevelsetPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_fluid_level_set_point_scale(pt : PhysicsfluidlevelsetPoint, s : Double) -> PhysicsfluidlevelsetPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_fluid_level_set_point_dot(a : PhysicsfluidlevelsetPoint, b : PhysicsfluidlevelsetPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_fluid_level_set_point_cross(a : PhysicsfluidlevelsetPoint, b : PhysicsfluidlevelsetPoint) -> PhysicsfluidlevelsetPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_fluid_level_set_point_norm(pt : PhysicsfluidlevelsetPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_fluid_level_set_point_normalize(pt : PhysicsfluidlevelsetPoint) -> PhysicsfluidlevelsetPoint {
  let n = physics_fluid_level_set_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_fluid_level_set_point_scale(pt, 1.0 / n) }
}

pub fn physics_fluid_level_set_point_negate(pt : PhysicsfluidlevelsetPoint) -> PhysicsfluidlevelsetPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_fluid_level_set_point_mid(a : PhysicsfluidlevelsetPoint, b : PhysicsfluidlevelsetPoint) -> PhysicsfluidlevelsetPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_fluid_level_set_point_lerp(a : PhysicsfluidlevelsetPoint, b : PhysicsfluidlevelsetPoint, t : Double) -> PhysicsfluidlevelsetPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_fluid_level_set_point_to_string(pt : PhysicsfluidlevelsetPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_level_set_make_series(vals : Array[Double], name : String) -> PhysicsfluidlevelsetSeries {
  { vals, name, meta: 0 }
}

pub fn physics_fluid_level_set_series_len(s : PhysicsfluidlevelsetSeries) -> Int { s.vals.length() }

pub fn physics_fluid_level_set_series_sum(s : PhysicsfluidlevelsetSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_fluid_level_set_series_mean(s : PhysicsfluidlevelsetSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_fluid_level_set_series_min(s : PhysicsfluidlevelsetSeries) -> Double { @_common.min(s.vals) }

pub fn physics_fluid_level_set_series_max(s : PhysicsfluidlevelsetSeries) -> Double { @_common.max(s.vals) }

pub fn physics_fluid_level_set_series_range(s : PhysicsfluidlevelsetSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_fluid_level_set_series_var(s : PhysicsfluidlevelsetSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_fluid_level_set_series_std(s : PhysicsfluidlevelsetSeries) -> Double { @_common.std(s.vals) }

pub fn physics_fluid_level_set_series_median(s : PhysicsfluidlevelsetSeries) -> Double { @_common.median(s.vals) }

pub fn physics_fluid_level_set_series_scale(s : PhysicsfluidlevelsetSeries, f : Double) -> PhysicsfluidlevelsetSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_fluid_level_set_series_add(a : PhysicsfluidlevelsetSeries, b : PhysicsfluidlevelsetSeries) -> PhysicsfluidlevelsetSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_fluid_level_set_series_sub(a : PhysicsfluidlevelsetSeries, b : PhysicsfluidlevelsetSeries) -> PhysicsfluidlevelsetSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_fluid_level_set_series_normalize(s : PhysicsfluidlevelsetSeries) -> PhysicsfluidlevelsetSeries {
  let mn = physics_fluid_level_set_series_min(s)
  let mx = physics_fluid_level_set_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_fluid_level_set_series_cumsum(s : PhysicsfluidlevelsetSeries) -> PhysicsfluidlevelsetSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_fluid_level_set_series_to_string(s : PhysicsfluidlevelsetSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidlevelsetMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_level_set_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidlevelsetMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_level_set_matrix_identity(n : Int) -> PhysicsfluidlevelsetMatrix {
  let m = physics_fluid_level_set_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_fluid_level_set_matrix_get(m : PhysicsfluidlevelsetMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_fluid_level_set_matrix_transpose(m : PhysicsfluidlevelsetMatrix) -> PhysicsfluidlevelsetMatrix {
  let result = physics_fluid_level_set_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_fluid_level_set_matrix_add(a : PhysicsfluidlevelsetMatrix, b : PhysicsfluidlevelsetMatrix) -> PhysicsfluidlevelsetMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_fluid_level_set_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_fluid_level_set_matrix_scale(m : PhysicsfluidlevelsetMatrix, s : Double) -> PhysicsfluidlevelsetMatrix {
  let result = physics_fluid_level_set_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_fluid_level_set_matrix_multiply(a : PhysicsfluidlevelsetMatrix, b : PhysicsfluidlevelsetMatrix) -> PhysicsfluidlevelsetMatrix {
  if a.cols != b.rows { return physics_fluid_level_set_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_fluid_level_set_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_fluid_level_set_matrix_trace(m : PhysicsfluidlevelsetMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_fluid_level_set_matrix_det(m : PhysicsfluidlevelsetMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_fluid_level_set_matrix_norm(m : PhysicsfluidlevelsetMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_fluid_level_set_matrix_to_string(m : PhysicsfluidlevelsetMatrix) -> String {
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

pub(all) struct PhysicsfluidlevelsetVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_level_set_make_vector(comps : Array[Double]) -> PhysicsfluidlevelsetVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_level_set_vector_zero(dim : Int) -> PhysicsfluidlevelsetVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_fluid_level_set_vector_add(a : PhysicsfluidlevelsetVector, b : PhysicsfluidlevelsetVector) -> PhysicsfluidlevelsetVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_level_set_vector_sub(a : PhysicsfluidlevelsetVector, b : PhysicsfluidlevelsetVector) -> PhysicsfluidlevelsetVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_level_set_vector_scale(v : PhysicsfluidlevelsetVector, s : Double) -> PhysicsfluidlevelsetVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_fluid_level_set_vector_dot(a : PhysicsfluidlevelsetVector, b : PhysicsfluidlevelsetVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_fluid_level_set_vector_norm(v : PhysicsfluidlevelsetVector) -> Double { @_common.sqrt(physics_fluid_level_set_vector_dot(v, v)) }

pub fn physics_fluid_level_set_vector_normalize(v : PhysicsfluidlevelsetVector) -> PhysicsfluidlevelsetVector {
  let n = physics_fluid_level_set_vector_norm(v)
  if n < 0.0000001 { v } else { physics_fluid_level_set_vector_scale(v, 1.0 / n) }
}

pub fn physics_fluid_level_set_vector_dist(a : PhysicsfluidlevelsetVector, b : PhysicsfluidlevelsetVector) -> Double {
  physics_fluid_level_set_vector_norm(physics_fluid_level_set_vector_sub(a, b))
}

pub fn physics_fluid_level_set_vector_to_string(v : PhysicsfluidlevelsetVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_level_set_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_fluid_level_set_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_fluid_level_set_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_fluid_level_set_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_fluid_level_set_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_fluid_level_set_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_fluid_level_set_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_fluid_level_set_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_fluid_level_set_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_fluid_level_set_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_fluid_level_set_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_fluid_level_set_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_fluid_level_set_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_fluid_level_set_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_fluid_level_set_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_fluid_level_set_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_fluid_level_set_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_fluid_level_set_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_fluid_level_set_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_fluid_level_set_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_fluid_level_set_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_fluid_level_set_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_fluid_level_set_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_fluid_level_set_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_fluid_level_set_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_fluid_level_set_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_fluid_level_set_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_fluid_level_set_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_fluid_level_set_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsfluidlevelsetFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_frame_make(size : Int) -> PhysicsfluidlevelsetFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_frame_len(s : PhysicsfluidlevelsetFrame) -> Int { s.size }

pub fn physics_fluid_level_set_frame_get(s : PhysicsfluidlevelsetFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_frame_set(s : PhysicsfluidlevelsetFrame, i : Int, v : Double) -> PhysicsfluidlevelsetFrame {
  let result = physics_fluid_level_set_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_frame_sum(s : PhysicsfluidlevelsetFrame) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_frame_mean(s : PhysicsfluidlevelsetFrame) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_frame_scale(s : PhysicsfluidlevelsetFrame, f : Double) -> PhysicsfluidlevelsetFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_frame_add(a : PhysicsfluidlevelsetFrame, b : PhysicsfluidlevelsetFrame) -> PhysicsfluidlevelsetFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_frame_copy(s : PhysicsfluidlevelsetFrame) -> PhysicsfluidlevelsetFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_frame_fill(s : PhysicsfluidlevelsetFrame, v : Double) -> PhysicsfluidlevelsetFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_frame_min(s : PhysicsfluidlevelsetFrame) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_frame_max(s : PhysicsfluidlevelsetFrame) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_frame_to_string(s : PhysicsfluidlevelsetFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_table_make(size : Int) -> PhysicsfluidlevelsetTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_table_len(s : PhysicsfluidlevelsetTable) -> Int { s.size }

pub fn physics_fluid_level_set_table_get(s : PhysicsfluidlevelsetTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_table_set(s : PhysicsfluidlevelsetTable, i : Int, v : Double) -> PhysicsfluidlevelsetTable {
  let result = physics_fluid_level_set_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_table_sum(s : PhysicsfluidlevelsetTable) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_table_mean(s : PhysicsfluidlevelsetTable) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_table_scale(s : PhysicsfluidlevelsetTable, f : Double) -> PhysicsfluidlevelsetTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_table_add(a : PhysicsfluidlevelsetTable, b : PhysicsfluidlevelsetTable) -> PhysicsfluidlevelsetTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_table_copy(s : PhysicsfluidlevelsetTable) -> PhysicsfluidlevelsetTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_table_fill(s : PhysicsfluidlevelsetTable, v : Double) -> PhysicsfluidlevelsetTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_table_min(s : PhysicsfluidlevelsetTable) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_table_max(s : PhysicsfluidlevelsetTable) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_table_to_string(s : PhysicsfluidlevelsetTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_graphn_make(size : Int) -> PhysicsfluidlevelsetGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_graphn_len(s : PhysicsfluidlevelsetGraphN) -> Int { s.size }

pub fn physics_fluid_level_set_graphn_get(s : PhysicsfluidlevelsetGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_graphn_set(s : PhysicsfluidlevelsetGraphN, i : Int, v : Double) -> PhysicsfluidlevelsetGraphN {
  let result = physics_fluid_level_set_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_graphn_sum(s : PhysicsfluidlevelsetGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_graphn_mean(s : PhysicsfluidlevelsetGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_graphn_scale(s : PhysicsfluidlevelsetGraphN, f : Double) -> PhysicsfluidlevelsetGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_graphn_add(a : PhysicsfluidlevelsetGraphN, b : PhysicsfluidlevelsetGraphN) -> PhysicsfluidlevelsetGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_graphn_copy(s : PhysicsfluidlevelsetGraphN) -> PhysicsfluidlevelsetGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_graphn_fill(s : PhysicsfluidlevelsetGraphN, v : Double) -> PhysicsfluidlevelsetGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_graphn_min(s : PhysicsfluidlevelsetGraphN) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_graphn_max(s : PhysicsfluidlevelsetGraphN) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_graphn_to_string(s : PhysicsfluidlevelsetGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_node_make(size : Int) -> PhysicsfluidlevelsetNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_node_len(s : PhysicsfluidlevelsetNode) -> Int { s.size }

pub fn physics_fluid_level_set_node_get(s : PhysicsfluidlevelsetNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_node_set(s : PhysicsfluidlevelsetNode, i : Int, v : Double) -> PhysicsfluidlevelsetNode {
  let result = physics_fluid_level_set_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_node_sum(s : PhysicsfluidlevelsetNode) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_node_mean(s : PhysicsfluidlevelsetNode) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_node_scale(s : PhysicsfluidlevelsetNode, f : Double) -> PhysicsfluidlevelsetNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_node_add(a : PhysicsfluidlevelsetNode, b : PhysicsfluidlevelsetNode) -> PhysicsfluidlevelsetNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_node_copy(s : PhysicsfluidlevelsetNode) -> PhysicsfluidlevelsetNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_node_fill(s : PhysicsfluidlevelsetNode, v : Double) -> PhysicsfluidlevelsetNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_node_min(s : PhysicsfluidlevelsetNode) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_node_max(s : PhysicsfluidlevelsetNode) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_node_to_string(s : PhysicsfluidlevelsetNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_edge_make(size : Int) -> PhysicsfluidlevelsetEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_edge_len(s : PhysicsfluidlevelsetEdge) -> Int { s.size }

pub fn physics_fluid_level_set_edge_get(s : PhysicsfluidlevelsetEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_edge_set(s : PhysicsfluidlevelsetEdge, i : Int, v : Double) -> PhysicsfluidlevelsetEdge {
  let result = physics_fluid_level_set_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_edge_sum(s : PhysicsfluidlevelsetEdge) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_edge_mean(s : PhysicsfluidlevelsetEdge) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_edge_scale(s : PhysicsfluidlevelsetEdge, f : Double) -> PhysicsfluidlevelsetEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_edge_add(a : PhysicsfluidlevelsetEdge, b : PhysicsfluidlevelsetEdge) -> PhysicsfluidlevelsetEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_edge_copy(s : PhysicsfluidlevelsetEdge) -> PhysicsfluidlevelsetEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_edge_fill(s : PhysicsfluidlevelsetEdge, v : Double) -> PhysicsfluidlevelsetEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_edge_min(s : PhysicsfluidlevelsetEdge) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_edge_max(s : PhysicsfluidlevelsetEdge) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_edge_to_string(s : PhysicsfluidlevelsetEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_path_make(size : Int) -> PhysicsfluidlevelsetPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_path_len(s : PhysicsfluidlevelsetPath) -> Int { s.size }

pub fn physics_fluid_level_set_path_get(s : PhysicsfluidlevelsetPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_path_set(s : PhysicsfluidlevelsetPath, i : Int, v : Double) -> PhysicsfluidlevelsetPath {
  let result = physics_fluid_level_set_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_path_sum(s : PhysicsfluidlevelsetPath) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_path_mean(s : PhysicsfluidlevelsetPath) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_path_scale(s : PhysicsfluidlevelsetPath, f : Double) -> PhysicsfluidlevelsetPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_path_add(a : PhysicsfluidlevelsetPath, b : PhysicsfluidlevelsetPath) -> PhysicsfluidlevelsetPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_path_copy(s : PhysicsfluidlevelsetPath) -> PhysicsfluidlevelsetPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_path_fill(s : PhysicsfluidlevelsetPath, v : Double) -> PhysicsfluidlevelsetPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_path_min(s : PhysicsfluidlevelsetPath) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_path_max(s : PhysicsfluidlevelsetPath) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_path_to_string(s : PhysicsfluidlevelsetPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_cluster_make(size : Int) -> PhysicsfluidlevelsetCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_cluster_len(s : PhysicsfluidlevelsetCluster) -> Int { s.size }

pub fn physics_fluid_level_set_cluster_get(s : PhysicsfluidlevelsetCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_cluster_set(s : PhysicsfluidlevelsetCluster, i : Int, v : Double) -> PhysicsfluidlevelsetCluster {
  let result = physics_fluid_level_set_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_cluster_sum(s : PhysicsfluidlevelsetCluster) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_cluster_mean(s : PhysicsfluidlevelsetCluster) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_cluster_scale(s : PhysicsfluidlevelsetCluster, f : Double) -> PhysicsfluidlevelsetCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_cluster_add(a : PhysicsfluidlevelsetCluster, b : PhysicsfluidlevelsetCluster) -> PhysicsfluidlevelsetCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_cluster_copy(s : PhysicsfluidlevelsetCluster) -> PhysicsfluidlevelsetCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_cluster_fill(s : PhysicsfluidlevelsetCluster, v : Double) -> PhysicsfluidlevelsetCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_cluster_min(s : PhysicsfluidlevelsetCluster) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_cluster_max(s : PhysicsfluidlevelsetCluster) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_cluster_to_string(s : PhysicsfluidlevelsetCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_model_make(size : Int) -> PhysicsfluidlevelsetModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_model_len(s : PhysicsfluidlevelsetModel) -> Int { s.size }

pub fn physics_fluid_level_set_model_get(s : PhysicsfluidlevelsetModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_model_set(s : PhysicsfluidlevelsetModel, i : Int, v : Double) -> PhysicsfluidlevelsetModel {
  let result = physics_fluid_level_set_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_model_sum(s : PhysicsfluidlevelsetModel) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_model_mean(s : PhysicsfluidlevelsetModel) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_model_scale(s : PhysicsfluidlevelsetModel, f : Double) -> PhysicsfluidlevelsetModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_model_add(a : PhysicsfluidlevelsetModel, b : PhysicsfluidlevelsetModel) -> PhysicsfluidlevelsetModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_model_copy(s : PhysicsfluidlevelsetModel) -> PhysicsfluidlevelsetModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_model_fill(s : PhysicsfluidlevelsetModel, v : Double) -> PhysicsfluidlevelsetModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_model_min(s : PhysicsfluidlevelsetModel) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_model_max(s : PhysicsfluidlevelsetModel) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_model_to_string(s : PhysicsfluidlevelsetModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_layer_make(size : Int) -> PhysicsfluidlevelsetLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_layer_len(s : PhysicsfluidlevelsetLayer) -> Int { s.size }

pub fn physics_fluid_level_set_layer_get(s : PhysicsfluidlevelsetLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_layer_set(s : PhysicsfluidlevelsetLayer, i : Int, v : Double) -> PhysicsfluidlevelsetLayer {
  let result = physics_fluid_level_set_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_layer_sum(s : PhysicsfluidlevelsetLayer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_layer_mean(s : PhysicsfluidlevelsetLayer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_layer_scale(s : PhysicsfluidlevelsetLayer, f : Double) -> PhysicsfluidlevelsetLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_layer_add(a : PhysicsfluidlevelsetLayer, b : PhysicsfluidlevelsetLayer) -> PhysicsfluidlevelsetLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_layer_copy(s : PhysicsfluidlevelsetLayer) -> PhysicsfluidlevelsetLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_layer_fill(s : PhysicsfluidlevelsetLayer, v : Double) -> PhysicsfluidlevelsetLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_layer_min(s : PhysicsfluidlevelsetLayer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_layer_max(s : PhysicsfluidlevelsetLayer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_layer_to_string(s : PhysicsfluidlevelsetLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_buffer_make(size : Int) -> PhysicsfluidlevelsetBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_buffer_len(s : PhysicsfluidlevelsetBuffer) -> Int { s.size }

pub fn physics_fluid_level_set_buffer_get(s : PhysicsfluidlevelsetBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_buffer_set(s : PhysicsfluidlevelsetBuffer, i : Int, v : Double) -> PhysicsfluidlevelsetBuffer {
  let result = physics_fluid_level_set_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_buffer_sum(s : PhysicsfluidlevelsetBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_buffer_mean(s : PhysicsfluidlevelsetBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_buffer_scale(s : PhysicsfluidlevelsetBuffer, f : Double) -> PhysicsfluidlevelsetBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_buffer_add(a : PhysicsfluidlevelsetBuffer, b : PhysicsfluidlevelsetBuffer) -> PhysicsfluidlevelsetBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_buffer_copy(s : PhysicsfluidlevelsetBuffer) -> PhysicsfluidlevelsetBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_buffer_fill(s : PhysicsfluidlevelsetBuffer, v : Double) -> PhysicsfluidlevelsetBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_buffer_min(s : PhysicsfluidlevelsetBuffer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_buffer_max(s : PhysicsfluidlevelsetBuffer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_buffer_to_string(s : PhysicsfluidlevelsetBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_cursor_make(size : Int) -> PhysicsfluidlevelsetCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_cursor_len(s : PhysicsfluidlevelsetCursor) -> Int { s.size }

pub fn physics_fluid_level_set_cursor_get(s : PhysicsfluidlevelsetCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_cursor_set(s : PhysicsfluidlevelsetCursor, i : Int, v : Double) -> PhysicsfluidlevelsetCursor {
  let result = physics_fluid_level_set_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_cursor_sum(s : PhysicsfluidlevelsetCursor) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_cursor_mean(s : PhysicsfluidlevelsetCursor) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_cursor_scale(s : PhysicsfluidlevelsetCursor, f : Double) -> PhysicsfluidlevelsetCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_cursor_add(a : PhysicsfluidlevelsetCursor, b : PhysicsfluidlevelsetCursor) -> PhysicsfluidlevelsetCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_cursor_copy(s : PhysicsfluidlevelsetCursor) -> PhysicsfluidlevelsetCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_cursor_fill(s : PhysicsfluidlevelsetCursor, v : Double) -> PhysicsfluidlevelsetCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_cursor_min(s : PhysicsfluidlevelsetCursor) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_cursor_max(s : PhysicsfluidlevelsetCursor) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_cursor_to_string(s : PhysicsfluidlevelsetCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_view_make(size : Int) -> PhysicsfluidlevelsetView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_view_len(s : PhysicsfluidlevelsetView) -> Int { s.size }

pub fn physics_fluid_level_set_view_get(s : PhysicsfluidlevelsetView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_view_set(s : PhysicsfluidlevelsetView, i : Int, v : Double) -> PhysicsfluidlevelsetView {
  let result = physics_fluid_level_set_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_view_sum(s : PhysicsfluidlevelsetView) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_view_mean(s : PhysicsfluidlevelsetView) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_view_scale(s : PhysicsfluidlevelsetView, f : Double) -> PhysicsfluidlevelsetView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_view_add(a : PhysicsfluidlevelsetView, b : PhysicsfluidlevelsetView) -> PhysicsfluidlevelsetView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_view_copy(s : PhysicsfluidlevelsetView) -> PhysicsfluidlevelsetView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_view_fill(s : PhysicsfluidlevelsetView, v : Double) -> PhysicsfluidlevelsetView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_view_min(s : PhysicsfluidlevelsetView) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_view_max(s : PhysicsfluidlevelsetView) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_view_to_string(s : PhysicsfluidlevelsetView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_range_make(size : Int) -> PhysicsfluidlevelsetRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_range_len(s : PhysicsfluidlevelsetRange) -> Int { s.size }

pub fn physics_fluid_level_set_range_get(s : PhysicsfluidlevelsetRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_range_set(s : PhysicsfluidlevelsetRange, i : Int, v : Double) -> PhysicsfluidlevelsetRange {
  let result = physics_fluid_level_set_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_range_sum(s : PhysicsfluidlevelsetRange) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_range_mean(s : PhysicsfluidlevelsetRange) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_range_scale(s : PhysicsfluidlevelsetRange, f : Double) -> PhysicsfluidlevelsetRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_range_add(a : PhysicsfluidlevelsetRange, b : PhysicsfluidlevelsetRange) -> PhysicsfluidlevelsetRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_range_copy(s : PhysicsfluidlevelsetRange) -> PhysicsfluidlevelsetRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_range_fill(s : PhysicsfluidlevelsetRange, v : Double) -> PhysicsfluidlevelsetRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_range_min(s : PhysicsfluidlevelsetRange) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_range_max(s : PhysicsfluidlevelsetRange) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_range_to_string(s : PhysicsfluidlevelsetRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlevelsetSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_level_set_slice_make(size : Int) -> PhysicsfluidlevelsetSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_level_set_slice_len(s : PhysicsfluidlevelsetSlice) -> Int { s.size }

pub fn physics_fluid_level_set_slice_get(s : PhysicsfluidlevelsetSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_level_set_slice_set(s : PhysicsfluidlevelsetSlice, i : Int, v : Double) -> PhysicsfluidlevelsetSlice {
  let result = physics_fluid_level_set_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_level_set_slice_sum(s : PhysicsfluidlevelsetSlice) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_level_set_slice_mean(s : PhysicsfluidlevelsetSlice) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_level_set_slice_scale(s : PhysicsfluidlevelsetSlice, f : Double) -> PhysicsfluidlevelsetSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_slice_add(a : PhysicsfluidlevelsetSlice, b : PhysicsfluidlevelsetSlice) -> PhysicsfluidlevelsetSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_level_set_slice_copy(s : PhysicsfluidlevelsetSlice) -> PhysicsfluidlevelsetSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_slice_fill(s : PhysicsfluidlevelsetSlice, v : Double) -> PhysicsfluidlevelsetSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_level_set_slice_min(s : PhysicsfluidlevelsetSlice) -> Double { @_common.min(s.data) }

pub fn physics_fluid_level_set_slice_max(s : PhysicsfluidlevelsetSlice) -> Double { @_common.max(s.data) }

pub fn physics_fluid_level_set_slice_to_string(s : PhysicsfluidlevelsetSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

