///===
/// extcore/physics_em_fDTD

pub(all) struct PhysicsemfDTDPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_fDTD_make_point(x : Double, y : Double) -> PhysicsemfDTDPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_fDTD_make_point3(x : Double, y : Double, z : Double) -> PhysicsemfDTDPoint {
  { x, y, z, label: 0 }
}

pub fn physics_em_fDTD_point_x(pt : PhysicsemfDTDPoint) -> Double { pt.x }

pub fn physics_em_fDTD_point_y(pt : PhysicsemfDTDPoint) -> Double { pt.y }

pub fn physics_em_fDTD_point_z(pt : PhysicsemfDTDPoint) -> Double { pt.z }

pub fn physics_em_fDTD_point_label(pt : PhysicsemfDTDPoint) -> Int { pt.label }

pub fn physics_em_fDTD_point_dist(a : PhysicsemfDTDPoint, b : PhysicsemfDTDPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_em_fDTD_point_add(a : PhysicsemfDTDPoint, b : PhysicsemfDTDPoint) -> PhysicsemfDTDPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_em_fDTD_point_sub(a : PhysicsemfDTDPoint, b : PhysicsemfDTDPoint) -> PhysicsemfDTDPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_em_fDTD_point_scale(pt : PhysicsemfDTDPoint, s : Double) -> PhysicsemfDTDPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_em_fDTD_point_dot(a : PhysicsemfDTDPoint, b : PhysicsemfDTDPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_em_fDTD_point_cross(a : PhysicsemfDTDPoint, b : PhysicsemfDTDPoint) -> PhysicsemfDTDPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_em_fDTD_point_norm(pt : PhysicsemfDTDPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_em_fDTD_point_normalize(pt : PhysicsemfDTDPoint) -> PhysicsemfDTDPoint {
  let n = physics_em_fDTD_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_em_fDTD_point_scale(pt, 1.0 / n) }
}

pub fn physics_em_fDTD_point_negate(pt : PhysicsemfDTDPoint) -> PhysicsemfDTDPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_em_fDTD_point_mid(a : PhysicsemfDTDPoint, b : PhysicsemfDTDPoint) -> PhysicsemfDTDPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_em_fDTD_point_lerp(a : PhysicsemfDTDPoint, b : PhysicsemfDTDPoint, t : Double) -> PhysicsemfDTDPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_em_fDTD_point_to_string(pt : PhysicsemfDTDPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsemfDTDSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_fDTD_make_series(vals : Array[Double], name : String) -> PhysicsemfDTDSeries {
  { vals, name, meta: 0 }
}

pub fn physics_em_fDTD_series_len(s : PhysicsemfDTDSeries) -> Int { s.vals.length() }

pub fn physics_em_fDTD_series_sum(s : PhysicsemfDTDSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_em_fDTD_series_mean(s : PhysicsemfDTDSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_em_fDTD_series_min(s : PhysicsemfDTDSeries) -> Double { @_common.min(s.vals) }

pub fn physics_em_fDTD_series_max(s : PhysicsemfDTDSeries) -> Double { @_common.max(s.vals) }

pub fn physics_em_fDTD_series_range(s : PhysicsemfDTDSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_em_fDTD_series_var(s : PhysicsemfDTDSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_em_fDTD_series_std(s : PhysicsemfDTDSeries) -> Double { @_common.std(s.vals) }

pub fn physics_em_fDTD_series_median(s : PhysicsemfDTDSeries) -> Double { @_common.median(s.vals) }

pub fn physics_em_fDTD_series_scale(s : PhysicsemfDTDSeries, f : Double) -> PhysicsemfDTDSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_em_fDTD_series_add(a : PhysicsemfDTDSeries, b : PhysicsemfDTDSeries) -> PhysicsemfDTDSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_em_fDTD_series_sub(a : PhysicsemfDTDSeries, b : PhysicsemfDTDSeries) -> PhysicsemfDTDSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_em_fDTD_series_normalize(s : PhysicsemfDTDSeries) -> PhysicsemfDTDSeries {
  let mn = physics_em_fDTD_series_min(s)
  let mx = physics_em_fDTD_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_em_fDTD_series_cumsum(s : PhysicsemfDTDSeries) -> PhysicsemfDTDSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_em_fDTD_series_to_string(s : PhysicsemfDTDSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemfDTDMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_fDTD_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemfDTDMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_fDTD_matrix_identity(n : Int) -> PhysicsemfDTDMatrix {
  let m = physics_em_fDTD_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_em_fDTD_matrix_get(m : PhysicsemfDTDMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_em_fDTD_matrix_transpose(m : PhysicsemfDTDMatrix) -> PhysicsemfDTDMatrix {
  let result = physics_em_fDTD_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_em_fDTD_matrix_add(a : PhysicsemfDTDMatrix, b : PhysicsemfDTDMatrix) -> PhysicsemfDTDMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_em_fDTD_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_em_fDTD_matrix_scale(m : PhysicsemfDTDMatrix, s : Double) -> PhysicsemfDTDMatrix {
  let result = physics_em_fDTD_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_em_fDTD_matrix_multiply(a : PhysicsemfDTDMatrix, b : PhysicsemfDTDMatrix) -> PhysicsemfDTDMatrix {
  if a.cols != b.rows { return physics_em_fDTD_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_em_fDTD_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_em_fDTD_matrix_trace(m : PhysicsemfDTDMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_em_fDTD_matrix_det(m : PhysicsemfDTDMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_em_fDTD_matrix_norm(m : PhysicsemfDTDMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_em_fDTD_matrix_to_string(m : PhysicsemfDTDMatrix) -> String {
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

pub(all) struct PhysicsemfDTDVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_fDTD_make_vector(comps : Array[Double]) -> PhysicsemfDTDVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_fDTD_vector_zero(dim : Int) -> PhysicsemfDTDVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_em_fDTD_vector_add(a : PhysicsemfDTDVector, b : PhysicsemfDTDVector) -> PhysicsemfDTDVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_fDTD_vector_sub(a : PhysicsemfDTDVector, b : PhysicsemfDTDVector) -> PhysicsemfDTDVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_fDTD_vector_scale(v : PhysicsemfDTDVector, s : Double) -> PhysicsemfDTDVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_em_fDTD_vector_dot(a : PhysicsemfDTDVector, b : PhysicsemfDTDVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_em_fDTD_vector_norm(v : PhysicsemfDTDVector) -> Double { @_common.sqrt(physics_em_fDTD_vector_dot(v, v)) }

pub fn physics_em_fDTD_vector_normalize(v : PhysicsemfDTDVector) -> PhysicsemfDTDVector {
  let n = physics_em_fDTD_vector_norm(v)
  if n < 0.0000001 { v } else { physics_em_fDTD_vector_scale(v, 1.0 / n) }
}

pub fn physics_em_fDTD_vector_dist(a : PhysicsemfDTDVector, b : PhysicsemfDTDVector) -> Double {
  physics_em_fDTD_vector_norm(physics_em_fDTD_vector_sub(a, b))
}

pub fn physics_em_fDTD_vector_to_string(v : PhysicsemfDTDVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_em_fDTD_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_em_fDTD_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_em_fDTD_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_em_fDTD_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_em_fDTD_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_em_fDTD_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_em_fDTD_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_em_fDTD_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_em_fDTD_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_em_fDTD_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_em_fDTD_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_em_fDTD_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_em_fDTD_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_em_fDTD_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_em_fDTD_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_em_fDTD_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_em_fDTD_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_em_fDTD_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_em_fDTD_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_em_fDTD_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_em_fDTD_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_em_fDTD_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_em_fDTD_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_em_fDTD_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_em_fDTD_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_em_fDTD_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_em_fDTD_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_em_fDTD_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_em_fDTD_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsemfDTDFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_frame_make(size : Int) -> PhysicsemfDTDFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_frame_len(s : PhysicsemfDTDFrame) -> Int { s.size }

pub fn physics_em_fDTD_frame_get(s : PhysicsemfDTDFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_frame_set(s : PhysicsemfDTDFrame, i : Int, v : Double) -> PhysicsemfDTDFrame {
  let result = physics_em_fDTD_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_frame_sum(s : PhysicsemfDTDFrame) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_frame_mean(s : PhysicsemfDTDFrame) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_frame_scale(s : PhysicsemfDTDFrame, f : Double) -> PhysicsemfDTDFrame {
  let result = physics_em_fDTD_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fDTD_frame_add(a : PhysicsemfDTDFrame, b : PhysicsemfDTDFrame) -> PhysicsemfDTDFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fDTD_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fDTD_frame_copy(s : PhysicsemfDTDFrame) -> PhysicsemfDTDFrame {
  let result = physics_em_fDTD_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fDTD_frame_fill(s : PhysicsemfDTDFrame, v : Double) -> PhysicsemfDTDFrame {
  let result = physics_em_fDTD_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_frame_min(s : PhysicsemfDTDFrame) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_frame_max(s : PhysicsemfDTDFrame) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_frame_to_string(s : PhysicsemfDTDFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_table_make(size : Int) -> PhysicsemfDTDTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_table_len(s : PhysicsemfDTDTable) -> Int { s.size }

pub fn physics_em_fDTD_table_get(s : PhysicsemfDTDTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_table_set(s : PhysicsemfDTDTable, i : Int, v : Double) -> PhysicsemfDTDTable {
  let result = physics_em_fDTD_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_table_sum(s : PhysicsemfDTDTable) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_table_mean(s : PhysicsemfDTDTable) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_table_scale(s : PhysicsemfDTDTable, f : Double) -> PhysicsemfDTDTable {
  let result = physics_em_fDTD_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fDTD_table_add(a : PhysicsemfDTDTable, b : PhysicsemfDTDTable) -> PhysicsemfDTDTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fDTD_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fDTD_table_copy(s : PhysicsemfDTDTable) -> PhysicsemfDTDTable {
  let result = physics_em_fDTD_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fDTD_table_fill(s : PhysicsemfDTDTable, v : Double) -> PhysicsemfDTDTable {
  let result = physics_em_fDTD_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_table_min(s : PhysicsemfDTDTable) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_table_max(s : PhysicsemfDTDTable) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_table_to_string(s : PhysicsemfDTDTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_graphn_make(size : Int) -> PhysicsemfDTDGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_graphn_len(s : PhysicsemfDTDGraphN) -> Int { s.size }

pub fn physics_em_fDTD_graphn_get(s : PhysicsemfDTDGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_graphn_set(s : PhysicsemfDTDGraphN, i : Int, v : Double) -> PhysicsemfDTDGraphN {
  let result = physics_em_fDTD_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_graphn_sum(s : PhysicsemfDTDGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_graphn_mean(s : PhysicsemfDTDGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_graphn_scale(s : PhysicsemfDTDGraphN, f : Double) -> PhysicsemfDTDGraphN {
  let result = physics_em_fDTD_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fDTD_graphn_add(a : PhysicsemfDTDGraphN, b : PhysicsemfDTDGraphN) -> PhysicsemfDTDGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fDTD_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fDTD_graphn_copy(s : PhysicsemfDTDGraphN) -> PhysicsemfDTDGraphN {
  let result = physics_em_fDTD_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fDTD_graphn_fill(s : PhysicsemfDTDGraphN, v : Double) -> PhysicsemfDTDGraphN {
  let result = physics_em_fDTD_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_graphn_min(s : PhysicsemfDTDGraphN) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_graphn_max(s : PhysicsemfDTDGraphN) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_graphn_to_string(s : PhysicsemfDTDGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_node_make(size : Int) -> PhysicsemfDTDNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_node_len(s : PhysicsemfDTDNode) -> Int { s.size }

pub fn physics_em_fDTD_node_get(s : PhysicsemfDTDNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_node_set(s : PhysicsemfDTDNode, i : Int, v : Double) -> PhysicsemfDTDNode {
  let result = physics_em_fDTD_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_node_sum(s : PhysicsemfDTDNode) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_node_mean(s : PhysicsemfDTDNode) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_node_scale(s : PhysicsemfDTDNode, f : Double) -> PhysicsemfDTDNode {
  let result = physics_em_fDTD_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fDTD_node_add(a : PhysicsemfDTDNode, b : PhysicsemfDTDNode) -> PhysicsemfDTDNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fDTD_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fDTD_node_copy(s : PhysicsemfDTDNode) -> PhysicsemfDTDNode {
  let result = physics_em_fDTD_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fDTD_node_fill(s : PhysicsemfDTDNode, v : Double) -> PhysicsemfDTDNode {
  let result = physics_em_fDTD_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_node_min(s : PhysicsemfDTDNode) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_node_max(s : PhysicsemfDTDNode) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_node_to_string(s : PhysicsemfDTDNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_edge_make(size : Int) -> PhysicsemfDTDEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_edge_len(s : PhysicsemfDTDEdge) -> Int { s.size }

pub fn physics_em_fDTD_edge_get(s : PhysicsemfDTDEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_edge_set(s : PhysicsemfDTDEdge, i : Int, v : Double) -> PhysicsemfDTDEdge {
  let result = physics_em_fDTD_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_edge_sum(s : PhysicsemfDTDEdge) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_edge_mean(s : PhysicsemfDTDEdge) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_edge_scale(s : PhysicsemfDTDEdge, f : Double) -> PhysicsemfDTDEdge {
  let result = physics_em_fDTD_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fDTD_edge_add(a : PhysicsemfDTDEdge, b : PhysicsemfDTDEdge) -> PhysicsemfDTDEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fDTD_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fDTD_edge_copy(s : PhysicsemfDTDEdge) -> PhysicsemfDTDEdge {
  let result = physics_em_fDTD_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fDTD_edge_fill(s : PhysicsemfDTDEdge, v : Double) -> PhysicsemfDTDEdge {
  let result = physics_em_fDTD_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_edge_min(s : PhysicsemfDTDEdge) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_edge_max(s : PhysicsemfDTDEdge) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_edge_to_string(s : PhysicsemfDTDEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_path_make(size : Int) -> PhysicsemfDTDPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_path_len(s : PhysicsemfDTDPath) -> Int { s.size }

pub fn physics_em_fDTD_path_get(s : PhysicsemfDTDPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_path_set(s : PhysicsemfDTDPath, i : Int, v : Double) -> PhysicsemfDTDPath {
  let result = physics_em_fDTD_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_path_sum(s : PhysicsemfDTDPath) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_path_mean(s : PhysicsemfDTDPath) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_path_scale(s : PhysicsemfDTDPath, f : Double) -> PhysicsemfDTDPath {
  let result = physics_em_fDTD_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fDTD_path_add(a : PhysicsemfDTDPath, b : PhysicsemfDTDPath) -> PhysicsemfDTDPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fDTD_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fDTD_path_copy(s : PhysicsemfDTDPath) -> PhysicsemfDTDPath {
  let result = physics_em_fDTD_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fDTD_path_fill(s : PhysicsemfDTDPath, v : Double) -> PhysicsemfDTDPath {
  let result = physics_em_fDTD_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_path_min(s : PhysicsemfDTDPath) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_path_max(s : PhysicsemfDTDPath) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_path_to_string(s : PhysicsemfDTDPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_cluster_make(size : Int) -> PhysicsemfDTDCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_cluster_len(s : PhysicsemfDTDCluster) -> Int { s.size }

pub fn physics_em_fDTD_cluster_get(s : PhysicsemfDTDCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_cluster_set(s : PhysicsemfDTDCluster, i : Int, v : Double) -> PhysicsemfDTDCluster {
  let result = physics_em_fDTD_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_cluster_sum(s : PhysicsemfDTDCluster) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_cluster_mean(s : PhysicsemfDTDCluster) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_cluster_scale(s : PhysicsemfDTDCluster, f : Double) -> PhysicsemfDTDCluster {
  let result = physics_em_fDTD_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fDTD_cluster_add(a : PhysicsemfDTDCluster, b : PhysicsemfDTDCluster) -> PhysicsemfDTDCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fDTD_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fDTD_cluster_copy(s : PhysicsemfDTDCluster) -> PhysicsemfDTDCluster {
  let result = physics_em_fDTD_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fDTD_cluster_fill(s : PhysicsemfDTDCluster, v : Double) -> PhysicsemfDTDCluster {
  let result = physics_em_fDTD_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_cluster_min(s : PhysicsemfDTDCluster) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_cluster_max(s : PhysicsemfDTDCluster) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_cluster_to_string(s : PhysicsemfDTDCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_model_make(size : Int) -> PhysicsemfDTDModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_model_len(s : PhysicsemfDTDModel) -> Int { s.size }

pub fn physics_em_fDTD_model_get(s : PhysicsemfDTDModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_model_set(s : PhysicsemfDTDModel, i : Int, v : Double) -> PhysicsemfDTDModel {
  let result = physics_em_fDTD_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_model_sum(s : PhysicsemfDTDModel) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_model_mean(s : PhysicsemfDTDModel) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_model_scale(s : PhysicsemfDTDModel, f : Double) -> PhysicsemfDTDModel {
  let result = physics_em_fDTD_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fDTD_model_add(a : PhysicsemfDTDModel, b : PhysicsemfDTDModel) -> PhysicsemfDTDModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fDTD_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fDTD_model_copy(s : PhysicsemfDTDModel) -> PhysicsemfDTDModel {
  let result = physics_em_fDTD_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fDTD_model_fill(s : PhysicsemfDTDModel, v : Double) -> PhysicsemfDTDModel {
  let result = physics_em_fDTD_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_model_min(s : PhysicsemfDTDModel) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_model_max(s : PhysicsemfDTDModel) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_model_to_string(s : PhysicsemfDTDModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_layer_make(size : Int) -> PhysicsemfDTDLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_layer_len(s : PhysicsemfDTDLayer) -> Int { s.size }

pub fn physics_em_fDTD_layer_get(s : PhysicsemfDTDLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_layer_set(s : PhysicsemfDTDLayer, i : Int, v : Double) -> PhysicsemfDTDLayer {
  let result = physics_em_fDTD_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_layer_sum(s : PhysicsemfDTDLayer) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_layer_mean(s : PhysicsemfDTDLayer) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_layer_scale(s : PhysicsemfDTDLayer, f : Double) -> PhysicsemfDTDLayer {
  let result = physics_em_fDTD_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fDTD_layer_add(a : PhysicsemfDTDLayer, b : PhysicsemfDTDLayer) -> PhysicsemfDTDLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fDTD_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fDTD_layer_copy(s : PhysicsemfDTDLayer) -> PhysicsemfDTDLayer {
  let result = physics_em_fDTD_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fDTD_layer_fill(s : PhysicsemfDTDLayer, v : Double) -> PhysicsemfDTDLayer {
  let result = physics_em_fDTD_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_layer_min(s : PhysicsemfDTDLayer) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_layer_max(s : PhysicsemfDTDLayer) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_layer_to_string(s : PhysicsemfDTDLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_buffer_make(size : Int) -> PhysicsemfDTDBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_buffer_len(s : PhysicsemfDTDBuffer) -> Int { s.size }

pub fn physics_em_fDTD_buffer_get(s : PhysicsemfDTDBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_buffer_set(s : PhysicsemfDTDBuffer, i : Int, v : Double) -> PhysicsemfDTDBuffer {
  let result = physics_em_fDTD_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_buffer_sum(s : PhysicsemfDTDBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_buffer_mean(s : PhysicsemfDTDBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_buffer_scale(s : PhysicsemfDTDBuffer, f : Double) -> PhysicsemfDTDBuffer {
  let result = physics_em_fDTD_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fDTD_buffer_add(a : PhysicsemfDTDBuffer, b : PhysicsemfDTDBuffer) -> PhysicsemfDTDBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fDTD_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fDTD_buffer_copy(s : PhysicsemfDTDBuffer) -> PhysicsemfDTDBuffer {
  let result = physics_em_fDTD_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fDTD_buffer_fill(s : PhysicsemfDTDBuffer, v : Double) -> PhysicsemfDTDBuffer {
  let result = physics_em_fDTD_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_buffer_min(s : PhysicsemfDTDBuffer) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_buffer_max(s : PhysicsemfDTDBuffer) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_buffer_to_string(s : PhysicsemfDTDBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_cursor_make(size : Int) -> PhysicsemfDTDCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_cursor_len(s : PhysicsemfDTDCursor) -> Int { s.size }

pub fn physics_em_fDTD_cursor_get(s : PhysicsemfDTDCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_cursor_set(s : PhysicsemfDTDCursor, i : Int, v : Double) -> PhysicsemfDTDCursor {
  let result = physics_em_fDTD_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_cursor_sum(s : PhysicsemfDTDCursor) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_cursor_mean(s : PhysicsemfDTDCursor) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_cursor_scale(s : PhysicsemfDTDCursor, f : Double) -> PhysicsemfDTDCursor {
  let result = physics_em_fDTD_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fDTD_cursor_add(a : PhysicsemfDTDCursor, b : PhysicsemfDTDCursor) -> PhysicsemfDTDCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fDTD_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fDTD_cursor_copy(s : PhysicsemfDTDCursor) -> PhysicsemfDTDCursor {
  let result = physics_em_fDTD_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fDTD_cursor_fill(s : PhysicsemfDTDCursor, v : Double) -> PhysicsemfDTDCursor {
  let result = physics_em_fDTD_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_cursor_min(s : PhysicsemfDTDCursor) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_cursor_max(s : PhysicsemfDTDCursor) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_cursor_to_string(s : PhysicsemfDTDCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_view_make(size : Int) -> PhysicsemfDTDView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_view_len(s : PhysicsemfDTDView) -> Int { s.size }

pub fn physics_em_fDTD_view_get(s : PhysicsemfDTDView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_view_set(s : PhysicsemfDTDView, i : Int, v : Double) -> PhysicsemfDTDView {
  let result = physics_em_fDTD_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_view_sum(s : PhysicsemfDTDView) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_view_mean(s : PhysicsemfDTDView) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_view_scale(s : PhysicsemfDTDView, f : Double) -> PhysicsemfDTDView {
  let result = physics_em_fDTD_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fDTD_view_add(a : PhysicsemfDTDView, b : PhysicsemfDTDView) -> PhysicsemfDTDView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fDTD_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fDTD_view_copy(s : PhysicsemfDTDView) -> PhysicsemfDTDView {
  let result = physics_em_fDTD_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fDTD_view_fill(s : PhysicsemfDTDView, v : Double) -> PhysicsemfDTDView {
  let result = physics_em_fDTD_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_view_min(s : PhysicsemfDTDView) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_view_max(s : PhysicsemfDTDView) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_view_to_string(s : PhysicsemfDTDView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_range_make(size : Int) -> PhysicsemfDTDRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_range_len(s : PhysicsemfDTDRange) -> Int { s.size }

pub fn physics_em_fDTD_range_get(s : PhysicsemfDTDRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_range_set(s : PhysicsemfDTDRange, i : Int, v : Double) -> PhysicsemfDTDRange {
  let result = physics_em_fDTD_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_range_sum(s : PhysicsemfDTDRange) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_range_mean(s : PhysicsemfDTDRange) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_range_scale(s : PhysicsemfDTDRange, f : Double) -> PhysicsemfDTDRange {
  let result = physics_em_fDTD_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fDTD_range_add(a : PhysicsemfDTDRange, b : PhysicsemfDTDRange) -> PhysicsemfDTDRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fDTD_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fDTD_range_copy(s : PhysicsemfDTDRange) -> PhysicsemfDTDRange {
  let result = physics_em_fDTD_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fDTD_range_fill(s : PhysicsemfDTDRange, v : Double) -> PhysicsemfDTDRange {
  let result = physics_em_fDTD_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_range_min(s : PhysicsemfDTDRange) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_range_max(s : PhysicsemfDTDRange) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_range_to_string(s : PhysicsemfDTDRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfDTDSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fDTD_slice_make(size : Int) -> PhysicsemfDTDSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fDTD_slice_len(s : PhysicsemfDTDSlice) -> Int { s.size }

pub fn physics_em_fDTD_slice_get(s : PhysicsemfDTDSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fDTD_slice_set(s : PhysicsemfDTDSlice, i : Int, v : Double) -> PhysicsemfDTDSlice {
  let result = physics_em_fDTD_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_slice_sum(s : PhysicsemfDTDSlice) -> Double { @_common.sum(s.data) }

pub fn physics_em_fDTD_slice_mean(s : PhysicsemfDTDSlice) -> Double { @_common.mean(s.data) }

pub fn physics_em_fDTD_slice_scale(s : PhysicsemfDTDSlice, f : Double) -> PhysicsemfDTDSlice {
  let result = physics_em_fDTD_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_em_fDTD_slice_add(a : PhysicsemfDTDSlice, b : PhysicsemfDTDSlice) -> PhysicsemfDTDSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_em_fDTD_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_em_fDTD_slice_copy(s : PhysicsemfDTDSlice) -> PhysicsemfDTDSlice {
  let result = physics_em_fDTD_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_em_fDTD_slice_fill(s : PhysicsemfDTDSlice, v : Double) -> PhysicsemfDTDSlice {
  let result = physics_em_fDTD_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_em_fDTD_slice_min(s : PhysicsemfDTDSlice) -> Double { @_common.min(s.data) }

pub fn physics_em_fDTD_slice_max(s : PhysicsemfDTDSlice) -> Double { @_common.max(s.data) }

pub fn physics_em_fDTD_slice_to_string(s : PhysicsemfDTDSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

