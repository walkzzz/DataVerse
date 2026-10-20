///===
/// extcore/physics_fluid_turbulence

pub(all) struct PhysicsfluidturbulencePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_turbulence_make_point(x : Double, y : Double) -> PhysicsfluidturbulencePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_turbulence_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidturbulencePoint {
  { x, y, z, label: 0 }
}

pub fn physics_fluid_turbulence_point_x(pt : PhysicsfluidturbulencePoint) -> Double { pt.x }

pub fn physics_fluid_turbulence_point_y(pt : PhysicsfluidturbulencePoint) -> Double { pt.y }

pub fn physics_fluid_turbulence_point_z(pt : PhysicsfluidturbulencePoint) -> Double { pt.z }

pub fn physics_fluid_turbulence_point_label(pt : PhysicsfluidturbulencePoint) -> Int { pt.label }

pub fn physics_fluid_turbulence_point_dist(a : PhysicsfluidturbulencePoint, b : PhysicsfluidturbulencePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_fluid_turbulence_point_add(a : PhysicsfluidturbulencePoint, b : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_fluid_turbulence_point_sub(a : PhysicsfluidturbulencePoint, b : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_fluid_turbulence_point_scale(pt : PhysicsfluidturbulencePoint, s : Double) -> PhysicsfluidturbulencePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_fluid_turbulence_point_dot(a : PhysicsfluidturbulencePoint, b : PhysicsfluidturbulencePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_fluid_turbulence_point_cross(a : PhysicsfluidturbulencePoint, b : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_fluid_turbulence_point_norm(pt : PhysicsfluidturbulencePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_fluid_turbulence_point_normalize(pt : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  let n = physics_fluid_turbulence_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_fluid_turbulence_point_scale(pt, 1.0 / n) }
}

pub fn physics_fluid_turbulence_point_negate(pt : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_fluid_turbulence_point_mid(a : PhysicsfluidturbulencePoint, b : PhysicsfluidturbulencePoint) -> PhysicsfluidturbulencePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_fluid_turbulence_point_lerp(a : PhysicsfluidturbulencePoint, b : PhysicsfluidturbulencePoint, t : Double) -> PhysicsfluidturbulencePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_fluid_turbulence_point_to_string(pt : PhysicsfluidturbulencePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_turbulence_make_series(vals : Array[Double], name : String) -> PhysicsfluidturbulenceSeries {
  { vals, name, meta: 0 }
}

pub fn physics_fluid_turbulence_series_len(s : PhysicsfluidturbulenceSeries) -> Int { s.vals.length() }

pub fn physics_fluid_turbulence_series_sum(s : PhysicsfluidturbulenceSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_fluid_turbulence_series_mean(s : PhysicsfluidturbulenceSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_fluid_turbulence_series_min(s : PhysicsfluidturbulenceSeries) -> Double { @_common.min(s.vals) }

pub fn physics_fluid_turbulence_series_max(s : PhysicsfluidturbulenceSeries) -> Double { @_common.max(s.vals) }

pub fn physics_fluid_turbulence_series_range(s : PhysicsfluidturbulenceSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_fluid_turbulence_series_var(s : PhysicsfluidturbulenceSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_fluid_turbulence_series_std(s : PhysicsfluidturbulenceSeries) -> Double { @_common.std(s.vals) }

pub fn physics_fluid_turbulence_series_median(s : PhysicsfluidturbulenceSeries) -> Double { @_common.median(s.vals) }

pub fn physics_fluid_turbulence_series_scale(s : PhysicsfluidturbulenceSeries, f : Double) -> PhysicsfluidturbulenceSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_fluid_turbulence_series_add(a : PhysicsfluidturbulenceSeries, b : PhysicsfluidturbulenceSeries) -> PhysicsfluidturbulenceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_fluid_turbulence_series_sub(a : PhysicsfluidturbulenceSeries, b : PhysicsfluidturbulenceSeries) -> PhysicsfluidturbulenceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_fluid_turbulence_series_normalize(s : PhysicsfluidturbulenceSeries) -> PhysicsfluidturbulenceSeries {
  let mn = physics_fluid_turbulence_series_min(s)
  let mx = physics_fluid_turbulence_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_fluid_turbulence_series_cumsum(s : PhysicsfluidturbulenceSeries) -> PhysicsfluidturbulenceSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_fluid_turbulence_series_to_string(s : PhysicsfluidturbulenceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidturbulenceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_turbulence_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidturbulenceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_turbulence_matrix_identity(n : Int) -> PhysicsfluidturbulenceMatrix {
  let m = physics_fluid_turbulence_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_fluid_turbulence_matrix_get(m : PhysicsfluidturbulenceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_fluid_turbulence_matrix_transpose(m : PhysicsfluidturbulenceMatrix) -> PhysicsfluidturbulenceMatrix {
  let result = physics_fluid_turbulence_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_fluid_turbulence_matrix_add(a : PhysicsfluidturbulenceMatrix, b : PhysicsfluidturbulenceMatrix) -> PhysicsfluidturbulenceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_fluid_turbulence_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_fluid_turbulence_matrix_scale(m : PhysicsfluidturbulenceMatrix, s : Double) -> PhysicsfluidturbulenceMatrix {
  let result = physics_fluid_turbulence_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_fluid_turbulence_matrix_multiply(a : PhysicsfluidturbulenceMatrix, b : PhysicsfluidturbulenceMatrix) -> PhysicsfluidturbulenceMatrix {
  if a.cols != b.rows { return physics_fluid_turbulence_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_fluid_turbulence_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_fluid_turbulence_matrix_trace(m : PhysicsfluidturbulenceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_fluid_turbulence_matrix_det(m : PhysicsfluidturbulenceMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_fluid_turbulence_matrix_norm(m : PhysicsfluidturbulenceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_fluid_turbulence_matrix_to_string(m : PhysicsfluidturbulenceMatrix) -> String {
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

pub(all) struct PhysicsfluidturbulenceVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_turbulence_make_vector(comps : Array[Double]) -> PhysicsfluidturbulenceVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_turbulence_vector_zero(dim : Int) -> PhysicsfluidturbulenceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_fluid_turbulence_vector_add(a : PhysicsfluidturbulenceVector, b : PhysicsfluidturbulenceVector) -> PhysicsfluidturbulenceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_turbulence_vector_sub(a : PhysicsfluidturbulenceVector, b : PhysicsfluidturbulenceVector) -> PhysicsfluidturbulenceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_turbulence_vector_scale(v : PhysicsfluidturbulenceVector, s : Double) -> PhysicsfluidturbulenceVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_fluid_turbulence_vector_dot(a : PhysicsfluidturbulenceVector, b : PhysicsfluidturbulenceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_fluid_turbulence_vector_norm(v : PhysicsfluidturbulenceVector) -> Double { @_common.sqrt(physics_fluid_turbulence_vector_dot(v, v)) }

pub fn physics_fluid_turbulence_vector_normalize(v : PhysicsfluidturbulenceVector) -> PhysicsfluidturbulenceVector {
  let n = physics_fluid_turbulence_vector_norm(v)
  if n < 0.0000001 { v } else { physics_fluid_turbulence_vector_scale(v, 1.0 / n) }
}

pub fn physics_fluid_turbulence_vector_dist(a : PhysicsfluidturbulenceVector, b : PhysicsfluidturbulenceVector) -> Double {
  physics_fluid_turbulence_vector_norm(physics_fluid_turbulence_vector_sub(a, b))
}

pub fn physics_fluid_turbulence_vector_to_string(v : PhysicsfluidturbulenceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_turbulence_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_fluid_turbulence_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_fluid_turbulence_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_fluid_turbulence_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_fluid_turbulence_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_fluid_turbulence_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_fluid_turbulence_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_fluid_turbulence_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_fluid_turbulence_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_fluid_turbulence_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_fluid_turbulence_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_fluid_turbulence_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_fluid_turbulence_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_fluid_turbulence_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_fluid_turbulence_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_fluid_turbulence_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_fluid_turbulence_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_fluid_turbulence_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_fluid_turbulence_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_fluid_turbulence_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_fluid_turbulence_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_fluid_turbulence_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_fluid_turbulence_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_fluid_turbulence_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_fluid_turbulence_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_fluid_turbulence_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_fluid_turbulence_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_fluid_turbulence_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_fluid_turbulence_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsfluidturbulenceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_frame_make(size : Int) -> PhysicsfluidturbulenceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_frame_len(s : PhysicsfluidturbulenceFrame) -> Int { s.size }

pub fn physics_fluid_turbulence_frame_get(s : PhysicsfluidturbulenceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_frame_set(s : PhysicsfluidturbulenceFrame, i : Int, v : Double) -> PhysicsfluidturbulenceFrame {
  let result = physics_fluid_turbulence_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_frame_sum(s : PhysicsfluidturbulenceFrame) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_frame_mean(s : PhysicsfluidturbulenceFrame) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_frame_scale(s : PhysicsfluidturbulenceFrame, f : Double) -> PhysicsfluidturbulenceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_frame_add(a : PhysicsfluidturbulenceFrame, b : PhysicsfluidturbulenceFrame) -> PhysicsfluidturbulenceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_frame_copy(s : PhysicsfluidturbulenceFrame) -> PhysicsfluidturbulenceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_frame_fill(s : PhysicsfluidturbulenceFrame, v : Double) -> PhysicsfluidturbulenceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_frame_min(s : PhysicsfluidturbulenceFrame) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_frame_max(s : PhysicsfluidturbulenceFrame) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_frame_to_string(s : PhysicsfluidturbulenceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_table_make(size : Int) -> PhysicsfluidturbulenceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_table_len(s : PhysicsfluidturbulenceTable) -> Int { s.size }

pub fn physics_fluid_turbulence_table_get(s : PhysicsfluidturbulenceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_table_set(s : PhysicsfluidturbulenceTable, i : Int, v : Double) -> PhysicsfluidturbulenceTable {
  let result = physics_fluid_turbulence_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_table_sum(s : PhysicsfluidturbulenceTable) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_table_mean(s : PhysicsfluidturbulenceTable) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_table_scale(s : PhysicsfluidturbulenceTable, f : Double) -> PhysicsfluidturbulenceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_table_add(a : PhysicsfluidturbulenceTable, b : PhysicsfluidturbulenceTable) -> PhysicsfluidturbulenceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_table_copy(s : PhysicsfluidturbulenceTable) -> PhysicsfluidturbulenceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_table_fill(s : PhysicsfluidturbulenceTable, v : Double) -> PhysicsfluidturbulenceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_table_min(s : PhysicsfluidturbulenceTable) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_table_max(s : PhysicsfluidturbulenceTable) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_table_to_string(s : PhysicsfluidturbulenceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_graphn_make(size : Int) -> PhysicsfluidturbulenceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_graphn_len(s : PhysicsfluidturbulenceGraphN) -> Int { s.size }

pub fn physics_fluid_turbulence_graphn_get(s : PhysicsfluidturbulenceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_graphn_set(s : PhysicsfluidturbulenceGraphN, i : Int, v : Double) -> PhysicsfluidturbulenceGraphN {
  let result = physics_fluid_turbulence_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_graphn_sum(s : PhysicsfluidturbulenceGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_graphn_mean(s : PhysicsfluidturbulenceGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_graphn_scale(s : PhysicsfluidturbulenceGraphN, f : Double) -> PhysicsfluidturbulenceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_graphn_add(a : PhysicsfluidturbulenceGraphN, b : PhysicsfluidturbulenceGraphN) -> PhysicsfluidturbulenceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_graphn_copy(s : PhysicsfluidturbulenceGraphN) -> PhysicsfluidturbulenceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_graphn_fill(s : PhysicsfluidturbulenceGraphN, v : Double) -> PhysicsfluidturbulenceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_graphn_min(s : PhysicsfluidturbulenceGraphN) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_graphn_max(s : PhysicsfluidturbulenceGraphN) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_graphn_to_string(s : PhysicsfluidturbulenceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_node_make(size : Int) -> PhysicsfluidturbulenceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_node_len(s : PhysicsfluidturbulenceNode) -> Int { s.size }

pub fn physics_fluid_turbulence_node_get(s : PhysicsfluidturbulenceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_node_set(s : PhysicsfluidturbulenceNode, i : Int, v : Double) -> PhysicsfluidturbulenceNode {
  let result = physics_fluid_turbulence_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_node_sum(s : PhysicsfluidturbulenceNode) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_node_mean(s : PhysicsfluidturbulenceNode) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_node_scale(s : PhysicsfluidturbulenceNode, f : Double) -> PhysicsfluidturbulenceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_node_add(a : PhysicsfluidturbulenceNode, b : PhysicsfluidturbulenceNode) -> PhysicsfluidturbulenceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_node_copy(s : PhysicsfluidturbulenceNode) -> PhysicsfluidturbulenceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_node_fill(s : PhysicsfluidturbulenceNode, v : Double) -> PhysicsfluidturbulenceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_node_min(s : PhysicsfluidturbulenceNode) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_node_max(s : PhysicsfluidturbulenceNode) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_node_to_string(s : PhysicsfluidturbulenceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_edge_make(size : Int) -> PhysicsfluidturbulenceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_edge_len(s : PhysicsfluidturbulenceEdge) -> Int { s.size }

pub fn physics_fluid_turbulence_edge_get(s : PhysicsfluidturbulenceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_edge_set(s : PhysicsfluidturbulenceEdge, i : Int, v : Double) -> PhysicsfluidturbulenceEdge {
  let result = physics_fluid_turbulence_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_edge_sum(s : PhysicsfluidturbulenceEdge) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_edge_mean(s : PhysicsfluidturbulenceEdge) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_edge_scale(s : PhysicsfluidturbulenceEdge, f : Double) -> PhysicsfluidturbulenceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_edge_add(a : PhysicsfluidturbulenceEdge, b : PhysicsfluidturbulenceEdge) -> PhysicsfluidturbulenceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_edge_copy(s : PhysicsfluidturbulenceEdge) -> PhysicsfluidturbulenceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_edge_fill(s : PhysicsfluidturbulenceEdge, v : Double) -> PhysicsfluidturbulenceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_edge_min(s : PhysicsfluidturbulenceEdge) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_edge_max(s : PhysicsfluidturbulenceEdge) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_edge_to_string(s : PhysicsfluidturbulenceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_path_make(size : Int) -> PhysicsfluidturbulencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_path_len(s : PhysicsfluidturbulencePath) -> Int { s.size }

pub fn physics_fluid_turbulence_path_get(s : PhysicsfluidturbulencePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_path_set(s : PhysicsfluidturbulencePath, i : Int, v : Double) -> PhysicsfluidturbulencePath {
  let result = physics_fluid_turbulence_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_path_sum(s : PhysicsfluidturbulencePath) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_path_mean(s : PhysicsfluidturbulencePath) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_path_scale(s : PhysicsfluidturbulencePath, f : Double) -> PhysicsfluidturbulencePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_path_add(a : PhysicsfluidturbulencePath, b : PhysicsfluidturbulencePath) -> PhysicsfluidturbulencePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_path_copy(s : PhysicsfluidturbulencePath) -> PhysicsfluidturbulencePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_path_fill(s : PhysicsfluidturbulencePath, v : Double) -> PhysicsfluidturbulencePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_path_min(s : PhysicsfluidturbulencePath) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_path_max(s : PhysicsfluidturbulencePath) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_path_to_string(s : PhysicsfluidturbulencePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_cluster_make(size : Int) -> PhysicsfluidturbulenceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_cluster_len(s : PhysicsfluidturbulenceCluster) -> Int { s.size }

pub fn physics_fluid_turbulence_cluster_get(s : PhysicsfluidturbulenceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_cluster_set(s : PhysicsfluidturbulenceCluster, i : Int, v : Double) -> PhysicsfluidturbulenceCluster {
  let result = physics_fluid_turbulence_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_cluster_sum(s : PhysicsfluidturbulenceCluster) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_cluster_mean(s : PhysicsfluidturbulenceCluster) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_cluster_scale(s : PhysicsfluidturbulenceCluster, f : Double) -> PhysicsfluidturbulenceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_cluster_add(a : PhysicsfluidturbulenceCluster, b : PhysicsfluidturbulenceCluster) -> PhysicsfluidturbulenceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_cluster_copy(s : PhysicsfluidturbulenceCluster) -> PhysicsfluidturbulenceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_cluster_fill(s : PhysicsfluidturbulenceCluster, v : Double) -> PhysicsfluidturbulenceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_cluster_min(s : PhysicsfluidturbulenceCluster) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_cluster_max(s : PhysicsfluidturbulenceCluster) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_cluster_to_string(s : PhysicsfluidturbulenceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_model_make(size : Int) -> PhysicsfluidturbulenceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_model_len(s : PhysicsfluidturbulenceModel) -> Int { s.size }

pub fn physics_fluid_turbulence_model_get(s : PhysicsfluidturbulenceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_model_set(s : PhysicsfluidturbulenceModel, i : Int, v : Double) -> PhysicsfluidturbulenceModel {
  let result = physics_fluid_turbulence_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_model_sum(s : PhysicsfluidturbulenceModel) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_model_mean(s : PhysicsfluidturbulenceModel) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_model_scale(s : PhysicsfluidturbulenceModel, f : Double) -> PhysicsfluidturbulenceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_model_add(a : PhysicsfluidturbulenceModel, b : PhysicsfluidturbulenceModel) -> PhysicsfluidturbulenceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_model_copy(s : PhysicsfluidturbulenceModel) -> PhysicsfluidturbulenceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_model_fill(s : PhysicsfluidturbulenceModel, v : Double) -> PhysicsfluidturbulenceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_model_min(s : PhysicsfluidturbulenceModel) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_model_max(s : PhysicsfluidturbulenceModel) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_model_to_string(s : PhysicsfluidturbulenceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_layer_make(size : Int) -> PhysicsfluidturbulenceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_layer_len(s : PhysicsfluidturbulenceLayer) -> Int { s.size }

pub fn physics_fluid_turbulence_layer_get(s : PhysicsfluidturbulenceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_layer_set(s : PhysicsfluidturbulenceLayer, i : Int, v : Double) -> PhysicsfluidturbulenceLayer {
  let result = physics_fluid_turbulence_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_layer_sum(s : PhysicsfluidturbulenceLayer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_layer_mean(s : PhysicsfluidturbulenceLayer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_layer_scale(s : PhysicsfluidturbulenceLayer, f : Double) -> PhysicsfluidturbulenceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_layer_add(a : PhysicsfluidturbulenceLayer, b : PhysicsfluidturbulenceLayer) -> PhysicsfluidturbulenceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_layer_copy(s : PhysicsfluidturbulenceLayer) -> PhysicsfluidturbulenceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_layer_fill(s : PhysicsfluidturbulenceLayer, v : Double) -> PhysicsfluidturbulenceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_layer_min(s : PhysicsfluidturbulenceLayer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_layer_max(s : PhysicsfluidturbulenceLayer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_layer_to_string(s : PhysicsfluidturbulenceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_buffer_make(size : Int) -> PhysicsfluidturbulenceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_buffer_len(s : PhysicsfluidturbulenceBuffer) -> Int { s.size }

pub fn physics_fluid_turbulence_buffer_get(s : PhysicsfluidturbulenceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_buffer_set(s : PhysicsfluidturbulenceBuffer, i : Int, v : Double) -> PhysicsfluidturbulenceBuffer {
  let result = physics_fluid_turbulence_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_buffer_sum(s : PhysicsfluidturbulenceBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_buffer_mean(s : PhysicsfluidturbulenceBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_buffer_scale(s : PhysicsfluidturbulenceBuffer, f : Double) -> PhysicsfluidturbulenceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_buffer_add(a : PhysicsfluidturbulenceBuffer, b : PhysicsfluidturbulenceBuffer) -> PhysicsfluidturbulenceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_buffer_copy(s : PhysicsfluidturbulenceBuffer) -> PhysicsfluidturbulenceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_buffer_fill(s : PhysicsfluidturbulenceBuffer, v : Double) -> PhysicsfluidturbulenceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_buffer_min(s : PhysicsfluidturbulenceBuffer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_buffer_max(s : PhysicsfluidturbulenceBuffer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_buffer_to_string(s : PhysicsfluidturbulenceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_cursor_make(size : Int) -> PhysicsfluidturbulenceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_cursor_len(s : PhysicsfluidturbulenceCursor) -> Int { s.size }

pub fn physics_fluid_turbulence_cursor_get(s : PhysicsfluidturbulenceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_cursor_set(s : PhysicsfluidturbulenceCursor, i : Int, v : Double) -> PhysicsfluidturbulenceCursor {
  let result = physics_fluid_turbulence_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_cursor_sum(s : PhysicsfluidturbulenceCursor) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_cursor_mean(s : PhysicsfluidturbulenceCursor) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_cursor_scale(s : PhysicsfluidturbulenceCursor, f : Double) -> PhysicsfluidturbulenceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_cursor_add(a : PhysicsfluidturbulenceCursor, b : PhysicsfluidturbulenceCursor) -> PhysicsfluidturbulenceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_cursor_copy(s : PhysicsfluidturbulenceCursor) -> PhysicsfluidturbulenceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_cursor_fill(s : PhysicsfluidturbulenceCursor, v : Double) -> PhysicsfluidturbulenceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_cursor_min(s : PhysicsfluidturbulenceCursor) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_cursor_max(s : PhysicsfluidturbulenceCursor) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_cursor_to_string(s : PhysicsfluidturbulenceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_view_make(size : Int) -> PhysicsfluidturbulenceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_view_len(s : PhysicsfluidturbulenceView) -> Int { s.size }

pub fn physics_fluid_turbulence_view_get(s : PhysicsfluidturbulenceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_view_set(s : PhysicsfluidturbulenceView, i : Int, v : Double) -> PhysicsfluidturbulenceView {
  let result = physics_fluid_turbulence_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_view_sum(s : PhysicsfluidturbulenceView) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_view_mean(s : PhysicsfluidturbulenceView) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_view_scale(s : PhysicsfluidturbulenceView, f : Double) -> PhysicsfluidturbulenceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_view_add(a : PhysicsfluidturbulenceView, b : PhysicsfluidturbulenceView) -> PhysicsfluidturbulenceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_view_copy(s : PhysicsfluidturbulenceView) -> PhysicsfluidturbulenceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_view_fill(s : PhysicsfluidturbulenceView, v : Double) -> PhysicsfluidturbulenceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_view_min(s : PhysicsfluidturbulenceView) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_view_max(s : PhysicsfluidturbulenceView) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_view_to_string(s : PhysicsfluidturbulenceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_range_make(size : Int) -> PhysicsfluidturbulenceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_range_len(s : PhysicsfluidturbulenceRange) -> Int { s.size }

pub fn physics_fluid_turbulence_range_get(s : PhysicsfluidturbulenceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_range_set(s : PhysicsfluidturbulenceRange, i : Int, v : Double) -> PhysicsfluidturbulenceRange {
  let result = physics_fluid_turbulence_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_range_sum(s : PhysicsfluidturbulenceRange) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_range_mean(s : PhysicsfluidturbulenceRange) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_range_scale(s : PhysicsfluidturbulenceRange, f : Double) -> PhysicsfluidturbulenceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_range_add(a : PhysicsfluidturbulenceRange, b : PhysicsfluidturbulenceRange) -> PhysicsfluidturbulenceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_range_copy(s : PhysicsfluidturbulenceRange) -> PhysicsfluidturbulenceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_range_fill(s : PhysicsfluidturbulenceRange, v : Double) -> PhysicsfluidturbulenceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_range_min(s : PhysicsfluidturbulenceRange) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_range_max(s : PhysicsfluidturbulenceRange) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_range_to_string(s : PhysicsfluidturbulenceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidturbulenceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_turbulence_slice_make(size : Int) -> PhysicsfluidturbulenceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_turbulence_slice_len(s : PhysicsfluidturbulenceSlice) -> Int { s.size }

pub fn physics_fluid_turbulence_slice_get(s : PhysicsfluidturbulenceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_turbulence_slice_set(s : PhysicsfluidturbulenceSlice, i : Int, v : Double) -> PhysicsfluidturbulenceSlice {
  let result = physics_fluid_turbulence_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_turbulence_slice_sum(s : PhysicsfluidturbulenceSlice) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_turbulence_slice_mean(s : PhysicsfluidturbulenceSlice) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_turbulence_slice_scale(s : PhysicsfluidturbulenceSlice, f : Double) -> PhysicsfluidturbulenceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_slice_add(a : PhysicsfluidturbulenceSlice, b : PhysicsfluidturbulenceSlice) -> PhysicsfluidturbulenceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_turbulence_slice_copy(s : PhysicsfluidturbulenceSlice) -> PhysicsfluidturbulenceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_slice_fill(s : PhysicsfluidturbulenceSlice, v : Double) -> PhysicsfluidturbulenceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_turbulence_slice_min(s : PhysicsfluidturbulenceSlice) -> Double { @_common.min(s.data) }

pub fn physics_fluid_turbulence_slice_max(s : PhysicsfluidturbulenceSlice) -> Double { @_common.max(s.data) }

pub fn physics_fluid_turbulence_slice_to_string(s : PhysicsfluidturbulenceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

