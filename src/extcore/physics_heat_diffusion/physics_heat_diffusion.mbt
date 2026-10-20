///===
/// extcore/physics_heat_diffusion

pub(all) struct PhysicsheatdiffusionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_diffusion_make_point(x : Double, y : Double) -> PhysicsheatdiffusionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_diffusion_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatdiffusionPoint {
  { x, y, z, label: 0 }
}

pub fn physics_heat_diffusion_point_x(pt : PhysicsheatdiffusionPoint) -> Double { pt.x }

pub fn physics_heat_diffusion_point_y(pt : PhysicsheatdiffusionPoint) -> Double { pt.y }

pub fn physics_heat_diffusion_point_z(pt : PhysicsheatdiffusionPoint) -> Double { pt.z }

pub fn physics_heat_diffusion_point_label(pt : PhysicsheatdiffusionPoint) -> Int { pt.label }

pub fn physics_heat_diffusion_point_dist(a : PhysicsheatdiffusionPoint, b : PhysicsheatdiffusionPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_heat_diffusion_point_add(a : PhysicsheatdiffusionPoint, b : PhysicsheatdiffusionPoint) -> PhysicsheatdiffusionPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_heat_diffusion_point_sub(a : PhysicsheatdiffusionPoint, b : PhysicsheatdiffusionPoint) -> PhysicsheatdiffusionPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_heat_diffusion_point_scale(pt : PhysicsheatdiffusionPoint, s : Double) -> PhysicsheatdiffusionPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_heat_diffusion_point_dot(a : PhysicsheatdiffusionPoint, b : PhysicsheatdiffusionPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_heat_diffusion_point_cross(a : PhysicsheatdiffusionPoint, b : PhysicsheatdiffusionPoint) -> PhysicsheatdiffusionPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_heat_diffusion_point_norm(pt : PhysicsheatdiffusionPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_heat_diffusion_point_normalize(pt : PhysicsheatdiffusionPoint) -> PhysicsheatdiffusionPoint {
  let n = physics_heat_diffusion_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_heat_diffusion_point_scale(pt, 1.0 / n) }
}

pub fn physics_heat_diffusion_point_negate(pt : PhysicsheatdiffusionPoint) -> PhysicsheatdiffusionPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_heat_diffusion_point_mid(a : PhysicsheatdiffusionPoint, b : PhysicsheatdiffusionPoint) -> PhysicsheatdiffusionPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_heat_diffusion_point_lerp(a : PhysicsheatdiffusionPoint, b : PhysicsheatdiffusionPoint, t : Double) -> PhysicsheatdiffusionPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_heat_diffusion_point_to_string(pt : PhysicsheatdiffusionPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_diffusion_make_series(vals : Array[Double], name : String) -> PhysicsheatdiffusionSeries {
  { vals, name, meta: 0 }
}

pub fn physics_heat_diffusion_series_len(s : PhysicsheatdiffusionSeries) -> Int { s.vals.length() }

pub fn physics_heat_diffusion_series_sum(s : PhysicsheatdiffusionSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_heat_diffusion_series_mean(s : PhysicsheatdiffusionSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_heat_diffusion_series_min(s : PhysicsheatdiffusionSeries) -> Double { @_common.min(s.vals) }

pub fn physics_heat_diffusion_series_max(s : PhysicsheatdiffusionSeries) -> Double { @_common.max(s.vals) }

pub fn physics_heat_diffusion_series_range(s : PhysicsheatdiffusionSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_heat_diffusion_series_var(s : PhysicsheatdiffusionSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_heat_diffusion_series_std(s : PhysicsheatdiffusionSeries) -> Double { @_common.std(s.vals) }

pub fn physics_heat_diffusion_series_median(s : PhysicsheatdiffusionSeries) -> Double { @_common.median(s.vals) }

pub fn physics_heat_diffusion_series_scale(s : PhysicsheatdiffusionSeries, f : Double) -> PhysicsheatdiffusionSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_heat_diffusion_series_add(a : PhysicsheatdiffusionSeries, b : PhysicsheatdiffusionSeries) -> PhysicsheatdiffusionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_heat_diffusion_series_sub(a : PhysicsheatdiffusionSeries, b : PhysicsheatdiffusionSeries) -> PhysicsheatdiffusionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_heat_diffusion_series_normalize(s : PhysicsheatdiffusionSeries) -> PhysicsheatdiffusionSeries {
  let mn = physics_heat_diffusion_series_min(s)
  let mx = physics_heat_diffusion_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_heat_diffusion_series_cumsum(s : PhysicsheatdiffusionSeries) -> PhysicsheatdiffusionSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_heat_diffusion_series_to_string(s : PhysicsheatdiffusionSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatdiffusionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_diffusion_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatdiffusionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_diffusion_matrix_identity(n : Int) -> PhysicsheatdiffusionMatrix {
  let m = physics_heat_diffusion_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_heat_diffusion_matrix_get(m : PhysicsheatdiffusionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_heat_diffusion_matrix_transpose(m : PhysicsheatdiffusionMatrix) -> PhysicsheatdiffusionMatrix {
  let result = physics_heat_diffusion_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_heat_diffusion_matrix_add(a : PhysicsheatdiffusionMatrix, b : PhysicsheatdiffusionMatrix) -> PhysicsheatdiffusionMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_heat_diffusion_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_heat_diffusion_matrix_scale(m : PhysicsheatdiffusionMatrix, s : Double) -> PhysicsheatdiffusionMatrix {
  let result = physics_heat_diffusion_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_heat_diffusion_matrix_multiply(a : PhysicsheatdiffusionMatrix, b : PhysicsheatdiffusionMatrix) -> PhysicsheatdiffusionMatrix {
  if a.cols != b.rows { return physics_heat_diffusion_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_heat_diffusion_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_heat_diffusion_matrix_trace(m : PhysicsheatdiffusionMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_heat_diffusion_matrix_det(m : PhysicsheatdiffusionMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_heat_diffusion_matrix_norm(m : PhysicsheatdiffusionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_heat_diffusion_matrix_to_string(m : PhysicsheatdiffusionMatrix) -> String {
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

pub(all) struct PhysicsheatdiffusionVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_diffusion_make_vector(comps : Array[Double]) -> PhysicsheatdiffusionVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_diffusion_vector_zero(dim : Int) -> PhysicsheatdiffusionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_heat_diffusion_vector_add(a : PhysicsheatdiffusionVector, b : PhysicsheatdiffusionVector) -> PhysicsheatdiffusionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_heat_diffusion_vector_sub(a : PhysicsheatdiffusionVector, b : PhysicsheatdiffusionVector) -> PhysicsheatdiffusionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_heat_diffusion_vector_scale(v : PhysicsheatdiffusionVector, s : Double) -> PhysicsheatdiffusionVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_heat_diffusion_vector_dot(a : PhysicsheatdiffusionVector, b : PhysicsheatdiffusionVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_heat_diffusion_vector_norm(v : PhysicsheatdiffusionVector) -> Double { @_common.sqrt(physics_heat_diffusion_vector_dot(v, v)) }

pub fn physics_heat_diffusion_vector_normalize(v : PhysicsheatdiffusionVector) -> PhysicsheatdiffusionVector {
  let n = physics_heat_diffusion_vector_norm(v)
  if n < 0.0000001 { v } else { physics_heat_diffusion_vector_scale(v, 1.0 / n) }
}

pub fn physics_heat_diffusion_vector_dist(a : PhysicsheatdiffusionVector, b : PhysicsheatdiffusionVector) -> Double {
  physics_heat_diffusion_vector_norm(physics_heat_diffusion_vector_sub(a, b))
}

pub fn physics_heat_diffusion_vector_to_string(v : PhysicsheatdiffusionVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_diffusion_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_heat_diffusion_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_heat_diffusion_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_heat_diffusion_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_heat_diffusion_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_heat_diffusion_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_heat_diffusion_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_heat_diffusion_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_heat_diffusion_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_heat_diffusion_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_heat_diffusion_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_heat_diffusion_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_heat_diffusion_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_heat_diffusion_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_heat_diffusion_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_heat_diffusion_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_heat_diffusion_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_heat_diffusion_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_heat_diffusion_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_heat_diffusion_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_heat_diffusion_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_heat_diffusion_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_heat_diffusion_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_heat_diffusion_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_heat_diffusion_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_heat_diffusion_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_heat_diffusion_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_heat_diffusion_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_heat_diffusion_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsheatdiffusionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_frame_make(size : Int) -> PhysicsheatdiffusionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_frame_len(s : PhysicsheatdiffusionFrame) -> Int { s.size }

pub fn physics_heat_diffusion_frame_get(s : PhysicsheatdiffusionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_frame_set(s : PhysicsheatdiffusionFrame, i : Int, v : Double) -> PhysicsheatdiffusionFrame {
  let result = physics_heat_diffusion_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_frame_sum(s : PhysicsheatdiffusionFrame) -> Double { @_common.sum(s.data) }

pub fn physics_heat_diffusion_frame_mean(s : PhysicsheatdiffusionFrame) -> Double { @_common.mean(s.data) }

pub fn physics_heat_diffusion_frame_scale(s : PhysicsheatdiffusionFrame, f : Double) -> PhysicsheatdiffusionFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_frame_add(a : PhysicsheatdiffusionFrame, b : PhysicsheatdiffusionFrame) -> PhysicsheatdiffusionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_diffusion_frame_copy(s : PhysicsheatdiffusionFrame) -> PhysicsheatdiffusionFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_frame_fill(s : PhysicsheatdiffusionFrame, v : Double) -> PhysicsheatdiffusionFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_frame_min(s : PhysicsheatdiffusionFrame) -> Double { @_common.min(s.data) }

pub fn physics_heat_diffusion_frame_max(s : PhysicsheatdiffusionFrame) -> Double { @_common.max(s.data) }

pub fn physics_heat_diffusion_frame_to_string(s : PhysicsheatdiffusionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_table_make(size : Int) -> PhysicsheatdiffusionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_table_len(s : PhysicsheatdiffusionTable) -> Int { s.size }

pub fn physics_heat_diffusion_table_get(s : PhysicsheatdiffusionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_table_set(s : PhysicsheatdiffusionTable, i : Int, v : Double) -> PhysicsheatdiffusionTable {
  let result = physics_heat_diffusion_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_table_sum(s : PhysicsheatdiffusionTable) -> Double { @_common.sum(s.data) }

pub fn physics_heat_diffusion_table_mean(s : PhysicsheatdiffusionTable) -> Double { @_common.mean(s.data) }

pub fn physics_heat_diffusion_table_scale(s : PhysicsheatdiffusionTable, f : Double) -> PhysicsheatdiffusionTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_table_add(a : PhysicsheatdiffusionTable, b : PhysicsheatdiffusionTable) -> PhysicsheatdiffusionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_diffusion_table_copy(s : PhysicsheatdiffusionTable) -> PhysicsheatdiffusionTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_table_fill(s : PhysicsheatdiffusionTable, v : Double) -> PhysicsheatdiffusionTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_table_min(s : PhysicsheatdiffusionTable) -> Double { @_common.min(s.data) }

pub fn physics_heat_diffusion_table_max(s : PhysicsheatdiffusionTable) -> Double { @_common.max(s.data) }

pub fn physics_heat_diffusion_table_to_string(s : PhysicsheatdiffusionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_graphn_make(size : Int) -> PhysicsheatdiffusionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_graphn_len(s : PhysicsheatdiffusionGraphN) -> Int { s.size }

pub fn physics_heat_diffusion_graphn_get(s : PhysicsheatdiffusionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_graphn_set(s : PhysicsheatdiffusionGraphN, i : Int, v : Double) -> PhysicsheatdiffusionGraphN {
  let result = physics_heat_diffusion_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_graphn_sum(s : PhysicsheatdiffusionGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_heat_diffusion_graphn_mean(s : PhysicsheatdiffusionGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_heat_diffusion_graphn_scale(s : PhysicsheatdiffusionGraphN, f : Double) -> PhysicsheatdiffusionGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_graphn_add(a : PhysicsheatdiffusionGraphN, b : PhysicsheatdiffusionGraphN) -> PhysicsheatdiffusionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_diffusion_graphn_copy(s : PhysicsheatdiffusionGraphN) -> PhysicsheatdiffusionGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_graphn_fill(s : PhysicsheatdiffusionGraphN, v : Double) -> PhysicsheatdiffusionGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_graphn_min(s : PhysicsheatdiffusionGraphN) -> Double { @_common.min(s.data) }

pub fn physics_heat_diffusion_graphn_max(s : PhysicsheatdiffusionGraphN) -> Double { @_common.max(s.data) }

pub fn physics_heat_diffusion_graphn_to_string(s : PhysicsheatdiffusionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_node_make(size : Int) -> PhysicsheatdiffusionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_node_len(s : PhysicsheatdiffusionNode) -> Int { s.size }

pub fn physics_heat_diffusion_node_get(s : PhysicsheatdiffusionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_node_set(s : PhysicsheatdiffusionNode, i : Int, v : Double) -> PhysicsheatdiffusionNode {
  let result = physics_heat_diffusion_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_node_sum(s : PhysicsheatdiffusionNode) -> Double { @_common.sum(s.data) }

pub fn physics_heat_diffusion_node_mean(s : PhysicsheatdiffusionNode) -> Double { @_common.mean(s.data) }

pub fn physics_heat_diffusion_node_scale(s : PhysicsheatdiffusionNode, f : Double) -> PhysicsheatdiffusionNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_node_add(a : PhysicsheatdiffusionNode, b : PhysicsheatdiffusionNode) -> PhysicsheatdiffusionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_diffusion_node_copy(s : PhysicsheatdiffusionNode) -> PhysicsheatdiffusionNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_node_fill(s : PhysicsheatdiffusionNode, v : Double) -> PhysicsheatdiffusionNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_node_min(s : PhysicsheatdiffusionNode) -> Double { @_common.min(s.data) }

pub fn physics_heat_diffusion_node_max(s : PhysicsheatdiffusionNode) -> Double { @_common.max(s.data) }

pub fn physics_heat_diffusion_node_to_string(s : PhysicsheatdiffusionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_edge_make(size : Int) -> PhysicsheatdiffusionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_edge_len(s : PhysicsheatdiffusionEdge) -> Int { s.size }

pub fn physics_heat_diffusion_edge_get(s : PhysicsheatdiffusionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_edge_set(s : PhysicsheatdiffusionEdge, i : Int, v : Double) -> PhysicsheatdiffusionEdge {
  let result = physics_heat_diffusion_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_edge_sum(s : PhysicsheatdiffusionEdge) -> Double { @_common.sum(s.data) }

pub fn physics_heat_diffusion_edge_mean(s : PhysicsheatdiffusionEdge) -> Double { @_common.mean(s.data) }

pub fn physics_heat_diffusion_edge_scale(s : PhysicsheatdiffusionEdge, f : Double) -> PhysicsheatdiffusionEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_edge_add(a : PhysicsheatdiffusionEdge, b : PhysicsheatdiffusionEdge) -> PhysicsheatdiffusionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_diffusion_edge_copy(s : PhysicsheatdiffusionEdge) -> PhysicsheatdiffusionEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_edge_fill(s : PhysicsheatdiffusionEdge, v : Double) -> PhysicsheatdiffusionEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_edge_min(s : PhysicsheatdiffusionEdge) -> Double { @_common.min(s.data) }

pub fn physics_heat_diffusion_edge_max(s : PhysicsheatdiffusionEdge) -> Double { @_common.max(s.data) }

pub fn physics_heat_diffusion_edge_to_string(s : PhysicsheatdiffusionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_path_make(size : Int) -> PhysicsheatdiffusionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_path_len(s : PhysicsheatdiffusionPath) -> Int { s.size }

pub fn physics_heat_diffusion_path_get(s : PhysicsheatdiffusionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_path_set(s : PhysicsheatdiffusionPath, i : Int, v : Double) -> PhysicsheatdiffusionPath {
  let result = physics_heat_diffusion_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_path_sum(s : PhysicsheatdiffusionPath) -> Double { @_common.sum(s.data) }

pub fn physics_heat_diffusion_path_mean(s : PhysicsheatdiffusionPath) -> Double { @_common.mean(s.data) }

pub fn physics_heat_diffusion_path_scale(s : PhysicsheatdiffusionPath, f : Double) -> PhysicsheatdiffusionPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_path_add(a : PhysicsheatdiffusionPath, b : PhysicsheatdiffusionPath) -> PhysicsheatdiffusionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_diffusion_path_copy(s : PhysicsheatdiffusionPath) -> PhysicsheatdiffusionPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_path_fill(s : PhysicsheatdiffusionPath, v : Double) -> PhysicsheatdiffusionPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_path_min(s : PhysicsheatdiffusionPath) -> Double { @_common.min(s.data) }

pub fn physics_heat_diffusion_path_max(s : PhysicsheatdiffusionPath) -> Double { @_common.max(s.data) }

pub fn physics_heat_diffusion_path_to_string(s : PhysicsheatdiffusionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_cluster_make(size : Int) -> PhysicsheatdiffusionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_cluster_len(s : PhysicsheatdiffusionCluster) -> Int { s.size }

pub fn physics_heat_diffusion_cluster_get(s : PhysicsheatdiffusionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_cluster_set(s : PhysicsheatdiffusionCluster, i : Int, v : Double) -> PhysicsheatdiffusionCluster {
  let result = physics_heat_diffusion_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_cluster_sum(s : PhysicsheatdiffusionCluster) -> Double { @_common.sum(s.data) }

pub fn physics_heat_diffusion_cluster_mean(s : PhysicsheatdiffusionCluster) -> Double { @_common.mean(s.data) }

pub fn physics_heat_diffusion_cluster_scale(s : PhysicsheatdiffusionCluster, f : Double) -> PhysicsheatdiffusionCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_cluster_add(a : PhysicsheatdiffusionCluster, b : PhysicsheatdiffusionCluster) -> PhysicsheatdiffusionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_diffusion_cluster_copy(s : PhysicsheatdiffusionCluster) -> PhysicsheatdiffusionCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_cluster_fill(s : PhysicsheatdiffusionCluster, v : Double) -> PhysicsheatdiffusionCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_cluster_min(s : PhysicsheatdiffusionCluster) -> Double { @_common.min(s.data) }

pub fn physics_heat_diffusion_cluster_max(s : PhysicsheatdiffusionCluster) -> Double { @_common.max(s.data) }

pub fn physics_heat_diffusion_cluster_to_string(s : PhysicsheatdiffusionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_model_make(size : Int) -> PhysicsheatdiffusionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_model_len(s : PhysicsheatdiffusionModel) -> Int { s.size }

pub fn physics_heat_diffusion_model_get(s : PhysicsheatdiffusionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_model_set(s : PhysicsheatdiffusionModel, i : Int, v : Double) -> PhysicsheatdiffusionModel {
  let result = physics_heat_diffusion_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_model_sum(s : PhysicsheatdiffusionModel) -> Double { @_common.sum(s.data) }

pub fn physics_heat_diffusion_model_mean(s : PhysicsheatdiffusionModel) -> Double { @_common.mean(s.data) }

pub fn physics_heat_diffusion_model_scale(s : PhysicsheatdiffusionModel, f : Double) -> PhysicsheatdiffusionModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_model_add(a : PhysicsheatdiffusionModel, b : PhysicsheatdiffusionModel) -> PhysicsheatdiffusionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_diffusion_model_copy(s : PhysicsheatdiffusionModel) -> PhysicsheatdiffusionModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_model_fill(s : PhysicsheatdiffusionModel, v : Double) -> PhysicsheatdiffusionModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_model_min(s : PhysicsheatdiffusionModel) -> Double { @_common.min(s.data) }

pub fn physics_heat_diffusion_model_max(s : PhysicsheatdiffusionModel) -> Double { @_common.max(s.data) }

pub fn physics_heat_diffusion_model_to_string(s : PhysicsheatdiffusionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_layer_make(size : Int) -> PhysicsheatdiffusionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_layer_len(s : PhysicsheatdiffusionLayer) -> Int { s.size }

pub fn physics_heat_diffusion_layer_get(s : PhysicsheatdiffusionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_layer_set(s : PhysicsheatdiffusionLayer, i : Int, v : Double) -> PhysicsheatdiffusionLayer {
  let result = physics_heat_diffusion_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_layer_sum(s : PhysicsheatdiffusionLayer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_diffusion_layer_mean(s : PhysicsheatdiffusionLayer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_diffusion_layer_scale(s : PhysicsheatdiffusionLayer, f : Double) -> PhysicsheatdiffusionLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_layer_add(a : PhysicsheatdiffusionLayer, b : PhysicsheatdiffusionLayer) -> PhysicsheatdiffusionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_diffusion_layer_copy(s : PhysicsheatdiffusionLayer) -> PhysicsheatdiffusionLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_layer_fill(s : PhysicsheatdiffusionLayer, v : Double) -> PhysicsheatdiffusionLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_layer_min(s : PhysicsheatdiffusionLayer) -> Double { @_common.min(s.data) }

pub fn physics_heat_diffusion_layer_max(s : PhysicsheatdiffusionLayer) -> Double { @_common.max(s.data) }

pub fn physics_heat_diffusion_layer_to_string(s : PhysicsheatdiffusionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_buffer_make(size : Int) -> PhysicsheatdiffusionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_buffer_len(s : PhysicsheatdiffusionBuffer) -> Int { s.size }

pub fn physics_heat_diffusion_buffer_get(s : PhysicsheatdiffusionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_buffer_set(s : PhysicsheatdiffusionBuffer, i : Int, v : Double) -> PhysicsheatdiffusionBuffer {
  let result = physics_heat_diffusion_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_buffer_sum(s : PhysicsheatdiffusionBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_diffusion_buffer_mean(s : PhysicsheatdiffusionBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_diffusion_buffer_scale(s : PhysicsheatdiffusionBuffer, f : Double) -> PhysicsheatdiffusionBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_buffer_add(a : PhysicsheatdiffusionBuffer, b : PhysicsheatdiffusionBuffer) -> PhysicsheatdiffusionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_diffusion_buffer_copy(s : PhysicsheatdiffusionBuffer) -> PhysicsheatdiffusionBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_buffer_fill(s : PhysicsheatdiffusionBuffer, v : Double) -> PhysicsheatdiffusionBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_buffer_min(s : PhysicsheatdiffusionBuffer) -> Double { @_common.min(s.data) }

pub fn physics_heat_diffusion_buffer_max(s : PhysicsheatdiffusionBuffer) -> Double { @_common.max(s.data) }

pub fn physics_heat_diffusion_buffer_to_string(s : PhysicsheatdiffusionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_cursor_make(size : Int) -> PhysicsheatdiffusionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_cursor_len(s : PhysicsheatdiffusionCursor) -> Int { s.size }

pub fn physics_heat_diffusion_cursor_get(s : PhysicsheatdiffusionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_cursor_set(s : PhysicsheatdiffusionCursor, i : Int, v : Double) -> PhysicsheatdiffusionCursor {
  let result = physics_heat_diffusion_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_cursor_sum(s : PhysicsheatdiffusionCursor) -> Double { @_common.sum(s.data) }

pub fn physics_heat_diffusion_cursor_mean(s : PhysicsheatdiffusionCursor) -> Double { @_common.mean(s.data) }

pub fn physics_heat_diffusion_cursor_scale(s : PhysicsheatdiffusionCursor, f : Double) -> PhysicsheatdiffusionCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_cursor_add(a : PhysicsheatdiffusionCursor, b : PhysicsheatdiffusionCursor) -> PhysicsheatdiffusionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_diffusion_cursor_copy(s : PhysicsheatdiffusionCursor) -> PhysicsheatdiffusionCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_cursor_fill(s : PhysicsheatdiffusionCursor, v : Double) -> PhysicsheatdiffusionCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_cursor_min(s : PhysicsheatdiffusionCursor) -> Double { @_common.min(s.data) }

pub fn physics_heat_diffusion_cursor_max(s : PhysicsheatdiffusionCursor) -> Double { @_common.max(s.data) }

pub fn physics_heat_diffusion_cursor_to_string(s : PhysicsheatdiffusionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_view_make(size : Int) -> PhysicsheatdiffusionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_view_len(s : PhysicsheatdiffusionView) -> Int { s.size }

pub fn physics_heat_diffusion_view_get(s : PhysicsheatdiffusionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_view_set(s : PhysicsheatdiffusionView, i : Int, v : Double) -> PhysicsheatdiffusionView {
  let result = physics_heat_diffusion_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_view_sum(s : PhysicsheatdiffusionView) -> Double { @_common.sum(s.data) }

pub fn physics_heat_diffusion_view_mean(s : PhysicsheatdiffusionView) -> Double { @_common.mean(s.data) }

pub fn physics_heat_diffusion_view_scale(s : PhysicsheatdiffusionView, f : Double) -> PhysicsheatdiffusionView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_view_add(a : PhysicsheatdiffusionView, b : PhysicsheatdiffusionView) -> PhysicsheatdiffusionView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_diffusion_view_copy(s : PhysicsheatdiffusionView) -> PhysicsheatdiffusionView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_view_fill(s : PhysicsheatdiffusionView, v : Double) -> PhysicsheatdiffusionView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_view_min(s : PhysicsheatdiffusionView) -> Double { @_common.min(s.data) }

pub fn physics_heat_diffusion_view_max(s : PhysicsheatdiffusionView) -> Double { @_common.max(s.data) }

pub fn physics_heat_diffusion_view_to_string(s : PhysicsheatdiffusionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_range_make(size : Int) -> PhysicsheatdiffusionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_range_len(s : PhysicsheatdiffusionRange) -> Int { s.size }

pub fn physics_heat_diffusion_range_get(s : PhysicsheatdiffusionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_range_set(s : PhysicsheatdiffusionRange, i : Int, v : Double) -> PhysicsheatdiffusionRange {
  let result = physics_heat_diffusion_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_range_sum(s : PhysicsheatdiffusionRange) -> Double { @_common.sum(s.data) }

pub fn physics_heat_diffusion_range_mean(s : PhysicsheatdiffusionRange) -> Double { @_common.mean(s.data) }

pub fn physics_heat_diffusion_range_scale(s : PhysicsheatdiffusionRange, f : Double) -> PhysicsheatdiffusionRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_range_add(a : PhysicsheatdiffusionRange, b : PhysicsheatdiffusionRange) -> PhysicsheatdiffusionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_diffusion_range_copy(s : PhysicsheatdiffusionRange) -> PhysicsheatdiffusionRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_range_fill(s : PhysicsheatdiffusionRange, v : Double) -> PhysicsheatdiffusionRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_range_min(s : PhysicsheatdiffusionRange) -> Double { @_common.min(s.data) }

pub fn physics_heat_diffusion_range_max(s : PhysicsheatdiffusionRange) -> Double { @_common.max(s.data) }

pub fn physics_heat_diffusion_range_to_string(s : PhysicsheatdiffusionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatdiffusionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_diffusion_slice_make(size : Int) -> PhysicsheatdiffusionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_diffusion_slice_len(s : PhysicsheatdiffusionSlice) -> Int { s.size }

pub fn physics_heat_diffusion_slice_get(s : PhysicsheatdiffusionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_diffusion_slice_set(s : PhysicsheatdiffusionSlice, i : Int, v : Double) -> PhysicsheatdiffusionSlice {
  let result = physics_heat_diffusion_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_diffusion_slice_sum(s : PhysicsheatdiffusionSlice) -> Double { @_common.sum(s.data) }

pub fn physics_heat_diffusion_slice_mean(s : PhysicsheatdiffusionSlice) -> Double { @_common.mean(s.data) }

pub fn physics_heat_diffusion_slice_scale(s : PhysicsheatdiffusionSlice, f : Double) -> PhysicsheatdiffusionSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_slice_add(a : PhysicsheatdiffusionSlice, b : PhysicsheatdiffusionSlice) -> PhysicsheatdiffusionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_heat_diffusion_slice_copy(s : PhysicsheatdiffusionSlice) -> PhysicsheatdiffusionSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_slice_fill(s : PhysicsheatdiffusionSlice, v : Double) -> PhysicsheatdiffusionSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_heat_diffusion_slice_min(s : PhysicsheatdiffusionSlice) -> Double { @_common.min(s.data) }

pub fn physics_heat_diffusion_slice_max(s : PhysicsheatdiffusionSlice) -> Double { @_common.max(s.data) }

pub fn physics_heat_diffusion_slice_to_string(s : PhysicsheatdiffusionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

