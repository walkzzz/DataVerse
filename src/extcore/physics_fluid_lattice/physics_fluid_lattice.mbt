///===
/// extcore/physics_fluid_lattice

pub(all) struct PhysicsfluidlatticePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_fluid_lattice_make_point(x : Double, y : Double) -> PhysicsfluidlatticePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_fluid_lattice_make_point3(x : Double, y : Double, z : Double) -> PhysicsfluidlatticePoint {
  { x, y, z, label: 0 }
}

pub fn physics_fluid_lattice_point_x(pt : PhysicsfluidlatticePoint) -> Double { pt.x }

pub fn physics_fluid_lattice_point_y(pt : PhysicsfluidlatticePoint) -> Double { pt.y }

pub fn physics_fluid_lattice_point_z(pt : PhysicsfluidlatticePoint) -> Double { pt.z }

pub fn physics_fluid_lattice_point_label(pt : PhysicsfluidlatticePoint) -> Int { pt.label }

pub fn physics_fluid_lattice_point_dist(a : PhysicsfluidlatticePoint, b : PhysicsfluidlatticePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_fluid_lattice_point_add(a : PhysicsfluidlatticePoint, b : PhysicsfluidlatticePoint) -> PhysicsfluidlatticePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_fluid_lattice_point_sub(a : PhysicsfluidlatticePoint, b : PhysicsfluidlatticePoint) -> PhysicsfluidlatticePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_fluid_lattice_point_scale(pt : PhysicsfluidlatticePoint, s : Double) -> PhysicsfluidlatticePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_fluid_lattice_point_dot(a : PhysicsfluidlatticePoint, b : PhysicsfluidlatticePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_fluid_lattice_point_cross(a : PhysicsfluidlatticePoint, b : PhysicsfluidlatticePoint) -> PhysicsfluidlatticePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_fluid_lattice_point_norm(pt : PhysicsfluidlatticePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_fluid_lattice_point_normalize(pt : PhysicsfluidlatticePoint) -> PhysicsfluidlatticePoint {
  let n = physics_fluid_lattice_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_fluid_lattice_point_scale(pt, 1.0 / n) }
}

pub fn physics_fluid_lattice_point_negate(pt : PhysicsfluidlatticePoint) -> PhysicsfluidlatticePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_fluid_lattice_point_mid(a : PhysicsfluidlatticePoint, b : PhysicsfluidlatticePoint) -> PhysicsfluidlatticePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_fluid_lattice_point_lerp(a : PhysicsfluidlatticePoint, b : PhysicsfluidlatticePoint, t : Double) -> PhysicsfluidlatticePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_fluid_lattice_point_to_string(pt : PhysicsfluidlatticePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_fluid_lattice_make_series(vals : Array[Double], name : String) -> PhysicsfluidlatticeSeries {
  { vals, name, meta: 0 }
}

pub fn physics_fluid_lattice_series_len(s : PhysicsfluidlatticeSeries) -> Int { s.vals.length() }

pub fn physics_fluid_lattice_series_sum(s : PhysicsfluidlatticeSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_fluid_lattice_series_mean(s : PhysicsfluidlatticeSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_fluid_lattice_series_min(s : PhysicsfluidlatticeSeries) -> Double { @_common.min(s.vals) }

pub fn physics_fluid_lattice_series_max(s : PhysicsfluidlatticeSeries) -> Double { @_common.max(s.vals) }

pub fn physics_fluid_lattice_series_range(s : PhysicsfluidlatticeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_fluid_lattice_series_var(s : PhysicsfluidlatticeSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_fluid_lattice_series_std(s : PhysicsfluidlatticeSeries) -> Double { @_common.std(s.vals) }

pub fn physics_fluid_lattice_series_median(s : PhysicsfluidlatticeSeries) -> Double { @_common.median(s.vals) }

pub fn physics_fluid_lattice_series_scale(s : PhysicsfluidlatticeSeries, f : Double) -> PhysicsfluidlatticeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_fluid_lattice_series_add(a : PhysicsfluidlatticeSeries, b : PhysicsfluidlatticeSeries) -> PhysicsfluidlatticeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_fluid_lattice_series_sub(a : PhysicsfluidlatticeSeries, b : PhysicsfluidlatticeSeries) -> PhysicsfluidlatticeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_fluid_lattice_series_normalize(s : PhysicsfluidlatticeSeries) -> PhysicsfluidlatticeSeries {
  let mn = physics_fluid_lattice_series_min(s)
  let mx = physics_fluid_lattice_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_fluid_lattice_series_cumsum(s : PhysicsfluidlatticeSeries) -> PhysicsfluidlatticeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_fluid_lattice_series_to_string(s : PhysicsfluidlatticeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsfluidlatticeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_fluid_lattice_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsfluidlatticeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_fluid_lattice_matrix_identity(n : Int) -> PhysicsfluidlatticeMatrix {
  let m = physics_fluid_lattice_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_fluid_lattice_matrix_get(m : PhysicsfluidlatticeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_fluid_lattice_matrix_transpose(m : PhysicsfluidlatticeMatrix) -> PhysicsfluidlatticeMatrix {
  let result = physics_fluid_lattice_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_fluid_lattice_matrix_add(a : PhysicsfluidlatticeMatrix, b : PhysicsfluidlatticeMatrix) -> PhysicsfluidlatticeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_fluid_lattice_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_fluid_lattice_matrix_scale(m : PhysicsfluidlatticeMatrix, s : Double) -> PhysicsfluidlatticeMatrix {
  let result = physics_fluid_lattice_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_fluid_lattice_matrix_multiply(a : PhysicsfluidlatticeMatrix, b : PhysicsfluidlatticeMatrix) -> PhysicsfluidlatticeMatrix {
  if a.cols != b.rows { return physics_fluid_lattice_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_fluid_lattice_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_fluid_lattice_matrix_trace(m : PhysicsfluidlatticeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_fluid_lattice_matrix_det(m : PhysicsfluidlatticeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_fluid_lattice_matrix_norm(m : PhysicsfluidlatticeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_fluid_lattice_matrix_to_string(m : PhysicsfluidlatticeMatrix) -> String {
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

pub(all) struct PhysicsfluidlatticeVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_fluid_lattice_make_vector(comps : Array[Double]) -> PhysicsfluidlatticeVector {
  { comps, dim: comps.length() }
}

pub fn physics_fluid_lattice_vector_zero(dim : Int) -> PhysicsfluidlatticeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_fluid_lattice_vector_add(a : PhysicsfluidlatticeVector, b : PhysicsfluidlatticeVector) -> PhysicsfluidlatticeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_lattice_vector_sub(a : PhysicsfluidlatticeVector, b : PhysicsfluidlatticeVector) -> PhysicsfluidlatticeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_fluid_lattice_vector_scale(v : PhysicsfluidlatticeVector, s : Double) -> PhysicsfluidlatticeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_fluid_lattice_vector_dot(a : PhysicsfluidlatticeVector, b : PhysicsfluidlatticeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_fluid_lattice_vector_norm(v : PhysicsfluidlatticeVector) -> Double { @_common.sqrt(physics_fluid_lattice_vector_dot(v, v)) }

pub fn physics_fluid_lattice_vector_normalize(v : PhysicsfluidlatticeVector) -> PhysicsfluidlatticeVector {
  let n = physics_fluid_lattice_vector_norm(v)
  if n < 0.0000001 { v } else { physics_fluid_lattice_vector_scale(v, 1.0 / n) }
}

pub fn physics_fluid_lattice_vector_dist(a : PhysicsfluidlatticeVector, b : PhysicsfluidlatticeVector) -> Double {
  physics_fluid_lattice_vector_norm(physics_fluid_lattice_vector_sub(a, b))
}

pub fn physics_fluid_lattice_vector_to_string(v : PhysicsfluidlatticeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_fluid_lattice_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_fluid_lattice_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_fluid_lattice_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_fluid_lattice_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_fluid_lattice_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_fluid_lattice_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_fluid_lattice_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_fluid_lattice_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_fluid_lattice_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_fluid_lattice_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_fluid_lattice_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_fluid_lattice_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_fluid_lattice_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_fluid_lattice_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_fluid_lattice_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_fluid_lattice_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_fluid_lattice_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_fluid_lattice_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_fluid_lattice_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_fluid_lattice_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_fluid_lattice_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_fluid_lattice_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_fluid_lattice_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_fluid_lattice_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_fluid_lattice_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_fluid_lattice_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_fluid_lattice_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_fluid_lattice_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_fluid_lattice_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsfluidlatticeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_frame_make(size : Int) -> PhysicsfluidlatticeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_frame_len(s : PhysicsfluidlatticeFrame) -> Int { s.size }

pub fn physics_fluid_lattice_frame_get(s : PhysicsfluidlatticeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_frame_set(s : PhysicsfluidlatticeFrame, i : Int, v : Double) -> PhysicsfluidlatticeFrame {
  let result = physics_fluid_lattice_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_lattice_frame_sum(s : PhysicsfluidlatticeFrame) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_frame_mean(s : PhysicsfluidlatticeFrame) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_frame_scale(s : PhysicsfluidlatticeFrame, f : Double) -> PhysicsfluidlatticeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_frame_add(a : PhysicsfluidlatticeFrame, b : PhysicsfluidlatticeFrame) -> PhysicsfluidlatticeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_frame_copy(s : PhysicsfluidlatticeFrame) -> PhysicsfluidlatticeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_frame_fill(s : PhysicsfluidlatticeFrame, v : Double) -> PhysicsfluidlatticeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_frame_min(s : PhysicsfluidlatticeFrame) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_frame_max(s : PhysicsfluidlatticeFrame) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_frame_to_string(s : PhysicsfluidlatticeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_table_make(size : Int) -> PhysicsfluidlatticeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_table_len(s : PhysicsfluidlatticeTable) -> Int { s.size }

pub fn physics_fluid_lattice_table_get(s : PhysicsfluidlatticeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_table_set(s : PhysicsfluidlatticeTable, i : Int, v : Double) -> PhysicsfluidlatticeTable {
  let result = physics_fluid_lattice_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_lattice_table_sum(s : PhysicsfluidlatticeTable) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_table_mean(s : PhysicsfluidlatticeTable) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_table_scale(s : PhysicsfluidlatticeTable, f : Double) -> PhysicsfluidlatticeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_table_add(a : PhysicsfluidlatticeTable, b : PhysicsfluidlatticeTable) -> PhysicsfluidlatticeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_table_copy(s : PhysicsfluidlatticeTable) -> PhysicsfluidlatticeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_table_fill(s : PhysicsfluidlatticeTable, v : Double) -> PhysicsfluidlatticeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_table_min(s : PhysicsfluidlatticeTable) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_table_max(s : PhysicsfluidlatticeTable) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_table_to_string(s : PhysicsfluidlatticeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_graphn_make(size : Int) -> PhysicsfluidlatticeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_graphn_len(s : PhysicsfluidlatticeGraphN) -> Int { s.size }

pub fn physics_fluid_lattice_graphn_get(s : PhysicsfluidlatticeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_graphn_set(s : PhysicsfluidlatticeGraphN, i : Int, v : Double) -> PhysicsfluidlatticeGraphN {
  let result = physics_fluid_lattice_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_lattice_graphn_sum(s : PhysicsfluidlatticeGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_graphn_mean(s : PhysicsfluidlatticeGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_graphn_scale(s : PhysicsfluidlatticeGraphN, f : Double) -> PhysicsfluidlatticeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_graphn_add(a : PhysicsfluidlatticeGraphN, b : PhysicsfluidlatticeGraphN) -> PhysicsfluidlatticeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_graphn_copy(s : PhysicsfluidlatticeGraphN) -> PhysicsfluidlatticeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_graphn_fill(s : PhysicsfluidlatticeGraphN, v : Double) -> PhysicsfluidlatticeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_graphn_min(s : PhysicsfluidlatticeGraphN) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_graphn_max(s : PhysicsfluidlatticeGraphN) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_graphn_to_string(s : PhysicsfluidlatticeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_node_make(size : Int) -> PhysicsfluidlatticeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_node_len(s : PhysicsfluidlatticeNode) -> Int { s.size }

pub fn physics_fluid_lattice_node_get(s : PhysicsfluidlatticeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_node_set(s : PhysicsfluidlatticeNode, i : Int, v : Double) -> PhysicsfluidlatticeNode {
  let result = physics_fluid_lattice_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_lattice_node_sum(s : PhysicsfluidlatticeNode) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_node_mean(s : PhysicsfluidlatticeNode) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_node_scale(s : PhysicsfluidlatticeNode, f : Double) -> PhysicsfluidlatticeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_node_add(a : PhysicsfluidlatticeNode, b : PhysicsfluidlatticeNode) -> PhysicsfluidlatticeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_node_copy(s : PhysicsfluidlatticeNode) -> PhysicsfluidlatticeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_node_fill(s : PhysicsfluidlatticeNode, v : Double) -> PhysicsfluidlatticeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_node_min(s : PhysicsfluidlatticeNode) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_node_max(s : PhysicsfluidlatticeNode) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_node_to_string(s : PhysicsfluidlatticeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_edge_make(size : Int) -> PhysicsfluidlatticeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_edge_len(s : PhysicsfluidlatticeEdge) -> Int { s.size }

pub fn physics_fluid_lattice_edge_get(s : PhysicsfluidlatticeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_edge_set(s : PhysicsfluidlatticeEdge, i : Int, v : Double) -> PhysicsfluidlatticeEdge {
  let result = physics_fluid_lattice_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_lattice_edge_sum(s : PhysicsfluidlatticeEdge) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_edge_mean(s : PhysicsfluidlatticeEdge) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_edge_scale(s : PhysicsfluidlatticeEdge, f : Double) -> PhysicsfluidlatticeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_edge_add(a : PhysicsfluidlatticeEdge, b : PhysicsfluidlatticeEdge) -> PhysicsfluidlatticeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_edge_copy(s : PhysicsfluidlatticeEdge) -> PhysicsfluidlatticeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_edge_fill(s : PhysicsfluidlatticeEdge, v : Double) -> PhysicsfluidlatticeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_edge_min(s : PhysicsfluidlatticeEdge) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_edge_max(s : PhysicsfluidlatticeEdge) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_edge_to_string(s : PhysicsfluidlatticeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_path_make(size : Int) -> PhysicsfluidlatticePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_path_len(s : PhysicsfluidlatticePath) -> Int { s.size }

pub fn physics_fluid_lattice_path_get(s : PhysicsfluidlatticePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_path_set(s : PhysicsfluidlatticePath, i : Int, v : Double) -> PhysicsfluidlatticePath {
  let result = physics_fluid_lattice_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_lattice_path_sum(s : PhysicsfluidlatticePath) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_path_mean(s : PhysicsfluidlatticePath) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_path_scale(s : PhysicsfluidlatticePath, f : Double) -> PhysicsfluidlatticePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_path_add(a : PhysicsfluidlatticePath, b : PhysicsfluidlatticePath) -> PhysicsfluidlatticePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_path_copy(s : PhysicsfluidlatticePath) -> PhysicsfluidlatticePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_path_fill(s : PhysicsfluidlatticePath, v : Double) -> PhysicsfluidlatticePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_path_min(s : PhysicsfluidlatticePath) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_path_max(s : PhysicsfluidlatticePath) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_path_to_string(s : PhysicsfluidlatticePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_cluster_make(size : Int) -> PhysicsfluidlatticeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_cluster_len(s : PhysicsfluidlatticeCluster) -> Int { s.size }

pub fn physics_fluid_lattice_cluster_get(s : PhysicsfluidlatticeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_cluster_set(s : PhysicsfluidlatticeCluster, i : Int, v : Double) -> PhysicsfluidlatticeCluster {
  let result = physics_fluid_lattice_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_lattice_cluster_sum(s : PhysicsfluidlatticeCluster) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_cluster_mean(s : PhysicsfluidlatticeCluster) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_cluster_scale(s : PhysicsfluidlatticeCluster, f : Double) -> PhysicsfluidlatticeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_cluster_add(a : PhysicsfluidlatticeCluster, b : PhysicsfluidlatticeCluster) -> PhysicsfluidlatticeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_cluster_copy(s : PhysicsfluidlatticeCluster) -> PhysicsfluidlatticeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_cluster_fill(s : PhysicsfluidlatticeCluster, v : Double) -> PhysicsfluidlatticeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_cluster_min(s : PhysicsfluidlatticeCluster) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_cluster_max(s : PhysicsfluidlatticeCluster) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_cluster_to_string(s : PhysicsfluidlatticeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_model_make(size : Int) -> PhysicsfluidlatticeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_model_len(s : PhysicsfluidlatticeModel) -> Int { s.size }

pub fn physics_fluid_lattice_model_get(s : PhysicsfluidlatticeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_model_set(s : PhysicsfluidlatticeModel, i : Int, v : Double) -> PhysicsfluidlatticeModel {
  let result = physics_fluid_lattice_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_lattice_model_sum(s : PhysicsfluidlatticeModel) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_model_mean(s : PhysicsfluidlatticeModel) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_model_scale(s : PhysicsfluidlatticeModel, f : Double) -> PhysicsfluidlatticeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_model_add(a : PhysicsfluidlatticeModel, b : PhysicsfluidlatticeModel) -> PhysicsfluidlatticeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_model_copy(s : PhysicsfluidlatticeModel) -> PhysicsfluidlatticeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_model_fill(s : PhysicsfluidlatticeModel, v : Double) -> PhysicsfluidlatticeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_model_min(s : PhysicsfluidlatticeModel) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_model_max(s : PhysicsfluidlatticeModel) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_model_to_string(s : PhysicsfluidlatticeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_layer_make(size : Int) -> PhysicsfluidlatticeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_layer_len(s : PhysicsfluidlatticeLayer) -> Int { s.size }

pub fn physics_fluid_lattice_layer_get(s : PhysicsfluidlatticeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_layer_set(s : PhysicsfluidlatticeLayer, i : Int, v : Double) -> PhysicsfluidlatticeLayer {
  let result = physics_fluid_lattice_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_lattice_layer_sum(s : PhysicsfluidlatticeLayer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_layer_mean(s : PhysicsfluidlatticeLayer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_layer_scale(s : PhysicsfluidlatticeLayer, f : Double) -> PhysicsfluidlatticeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_layer_add(a : PhysicsfluidlatticeLayer, b : PhysicsfluidlatticeLayer) -> PhysicsfluidlatticeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_layer_copy(s : PhysicsfluidlatticeLayer) -> PhysicsfluidlatticeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_layer_fill(s : PhysicsfluidlatticeLayer, v : Double) -> PhysicsfluidlatticeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_layer_min(s : PhysicsfluidlatticeLayer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_layer_max(s : PhysicsfluidlatticeLayer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_layer_to_string(s : PhysicsfluidlatticeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_buffer_make(size : Int) -> PhysicsfluidlatticeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_buffer_len(s : PhysicsfluidlatticeBuffer) -> Int { s.size }

pub fn physics_fluid_lattice_buffer_get(s : PhysicsfluidlatticeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_buffer_set(s : PhysicsfluidlatticeBuffer, i : Int, v : Double) -> PhysicsfluidlatticeBuffer {
  let result = physics_fluid_lattice_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_lattice_buffer_sum(s : PhysicsfluidlatticeBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_buffer_mean(s : PhysicsfluidlatticeBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_buffer_scale(s : PhysicsfluidlatticeBuffer, f : Double) -> PhysicsfluidlatticeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_buffer_add(a : PhysicsfluidlatticeBuffer, b : PhysicsfluidlatticeBuffer) -> PhysicsfluidlatticeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_buffer_copy(s : PhysicsfluidlatticeBuffer) -> PhysicsfluidlatticeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_buffer_fill(s : PhysicsfluidlatticeBuffer, v : Double) -> PhysicsfluidlatticeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_buffer_min(s : PhysicsfluidlatticeBuffer) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_buffer_max(s : PhysicsfluidlatticeBuffer) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_buffer_to_string(s : PhysicsfluidlatticeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_cursor_make(size : Int) -> PhysicsfluidlatticeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_cursor_len(s : PhysicsfluidlatticeCursor) -> Int { s.size }

pub fn physics_fluid_lattice_cursor_get(s : PhysicsfluidlatticeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_cursor_set(s : PhysicsfluidlatticeCursor, i : Int, v : Double) -> PhysicsfluidlatticeCursor {
  let result = physics_fluid_lattice_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_lattice_cursor_sum(s : PhysicsfluidlatticeCursor) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_cursor_mean(s : PhysicsfluidlatticeCursor) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_cursor_scale(s : PhysicsfluidlatticeCursor, f : Double) -> PhysicsfluidlatticeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_cursor_add(a : PhysicsfluidlatticeCursor, b : PhysicsfluidlatticeCursor) -> PhysicsfluidlatticeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_cursor_copy(s : PhysicsfluidlatticeCursor) -> PhysicsfluidlatticeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_cursor_fill(s : PhysicsfluidlatticeCursor, v : Double) -> PhysicsfluidlatticeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_cursor_min(s : PhysicsfluidlatticeCursor) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_cursor_max(s : PhysicsfluidlatticeCursor) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_cursor_to_string(s : PhysicsfluidlatticeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_view_make(size : Int) -> PhysicsfluidlatticeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_view_len(s : PhysicsfluidlatticeView) -> Int { s.size }

pub fn physics_fluid_lattice_view_get(s : PhysicsfluidlatticeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_view_set(s : PhysicsfluidlatticeView, i : Int, v : Double) -> PhysicsfluidlatticeView {
  let result = physics_fluid_lattice_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_lattice_view_sum(s : PhysicsfluidlatticeView) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_view_mean(s : PhysicsfluidlatticeView) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_view_scale(s : PhysicsfluidlatticeView, f : Double) -> PhysicsfluidlatticeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_view_add(a : PhysicsfluidlatticeView, b : PhysicsfluidlatticeView) -> PhysicsfluidlatticeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_view_copy(s : PhysicsfluidlatticeView) -> PhysicsfluidlatticeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_view_fill(s : PhysicsfluidlatticeView, v : Double) -> PhysicsfluidlatticeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_view_min(s : PhysicsfluidlatticeView) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_view_max(s : PhysicsfluidlatticeView) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_view_to_string(s : PhysicsfluidlatticeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_range_make(size : Int) -> PhysicsfluidlatticeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_range_len(s : PhysicsfluidlatticeRange) -> Int { s.size }

pub fn physics_fluid_lattice_range_get(s : PhysicsfluidlatticeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_range_set(s : PhysicsfluidlatticeRange, i : Int, v : Double) -> PhysicsfluidlatticeRange {
  let result = physics_fluid_lattice_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_lattice_range_sum(s : PhysicsfluidlatticeRange) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_range_mean(s : PhysicsfluidlatticeRange) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_range_scale(s : PhysicsfluidlatticeRange, f : Double) -> PhysicsfluidlatticeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_range_add(a : PhysicsfluidlatticeRange, b : PhysicsfluidlatticeRange) -> PhysicsfluidlatticeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_range_copy(s : PhysicsfluidlatticeRange) -> PhysicsfluidlatticeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_range_fill(s : PhysicsfluidlatticeRange, v : Double) -> PhysicsfluidlatticeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_range_min(s : PhysicsfluidlatticeRange) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_range_max(s : PhysicsfluidlatticeRange) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_range_to_string(s : PhysicsfluidlatticeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsfluidlatticeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_fluid_lattice_slice_make(size : Int) -> PhysicsfluidlatticeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_fluid_lattice_slice_len(s : PhysicsfluidlatticeSlice) -> Int { s.size }

pub fn physics_fluid_lattice_slice_get(s : PhysicsfluidlatticeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_fluid_lattice_slice_set(s : PhysicsfluidlatticeSlice, i : Int, v : Double) -> PhysicsfluidlatticeSlice {
  let result = physics_fluid_lattice_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_fluid_lattice_slice_sum(s : PhysicsfluidlatticeSlice) -> Double { @_common.sum(s.data) }

pub fn physics_fluid_lattice_slice_mean(s : PhysicsfluidlatticeSlice) -> Double { @_common.mean(s.data) }

pub fn physics_fluid_lattice_slice_scale(s : PhysicsfluidlatticeSlice, f : Double) -> PhysicsfluidlatticeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_slice_add(a : PhysicsfluidlatticeSlice, b : PhysicsfluidlatticeSlice) -> PhysicsfluidlatticeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_fluid_lattice_slice_copy(s : PhysicsfluidlatticeSlice) -> PhysicsfluidlatticeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_slice_fill(s : PhysicsfluidlatticeSlice, v : Double) -> PhysicsfluidlatticeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_fluid_lattice_slice_min(s : PhysicsfluidlatticeSlice) -> Double { @_common.min(s.data) }

pub fn physics_fluid_lattice_slice_max(s : PhysicsfluidlatticeSlice) -> Double { @_common.max(s.data) }

pub fn physics_fluid_lattice_slice_to_string(s : PhysicsfluidlatticeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

