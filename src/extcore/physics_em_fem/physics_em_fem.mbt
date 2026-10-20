///===
/// extcore/physics_em_fem

pub(all) struct PhysicsemfemPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_em_fem_make_point(x : Double, y : Double) -> PhysicsemfemPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_em_fem_make_point3(x : Double, y : Double, z : Double) -> PhysicsemfemPoint {
  { x, y, z, label: 0 }
}

pub fn physics_em_fem_point_x(pt : PhysicsemfemPoint) -> Double { pt.x }

pub fn physics_em_fem_point_y(pt : PhysicsemfemPoint) -> Double { pt.y }

pub fn physics_em_fem_point_z(pt : PhysicsemfemPoint) -> Double { pt.z }

pub fn physics_em_fem_point_label(pt : PhysicsemfemPoint) -> Int { pt.label }

pub fn physics_em_fem_point_dist(a : PhysicsemfemPoint, b : PhysicsemfemPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_em_fem_point_add(a : PhysicsemfemPoint, b : PhysicsemfemPoint) -> PhysicsemfemPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_em_fem_point_sub(a : PhysicsemfemPoint, b : PhysicsemfemPoint) -> PhysicsemfemPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_em_fem_point_scale(pt : PhysicsemfemPoint, s : Double) -> PhysicsemfemPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_em_fem_point_dot(a : PhysicsemfemPoint, b : PhysicsemfemPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_em_fem_point_cross(a : PhysicsemfemPoint, b : PhysicsemfemPoint) -> PhysicsemfemPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_em_fem_point_norm(pt : PhysicsemfemPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_em_fem_point_normalize(pt : PhysicsemfemPoint) -> PhysicsemfemPoint {
  let n = physics_em_fem_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_em_fem_point_scale(pt, 1.0 / n) }
}

pub fn physics_em_fem_point_negate(pt : PhysicsemfemPoint) -> PhysicsemfemPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_em_fem_point_mid(a : PhysicsemfemPoint, b : PhysicsemfemPoint) -> PhysicsemfemPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_em_fem_point_lerp(a : PhysicsemfemPoint, b : PhysicsemfemPoint, t : Double) -> PhysicsemfemPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_em_fem_point_to_string(pt : PhysicsemfemPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsemfemSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_em_fem_make_series(vals : Array[Double], name : String) -> PhysicsemfemSeries {
  { vals, name, meta: 0 }
}

pub fn physics_em_fem_series_len(s : PhysicsemfemSeries) -> Int { s.vals.length() }

pub fn physics_em_fem_series_sum(s : PhysicsemfemSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_em_fem_series_mean(s : PhysicsemfemSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_em_fem_series_min(s : PhysicsemfemSeries) -> Double { @_common.min(s.vals) }

pub fn physics_em_fem_series_max(s : PhysicsemfemSeries) -> Double { @_common.max(s.vals) }

pub fn physics_em_fem_series_range(s : PhysicsemfemSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_em_fem_series_var(s : PhysicsemfemSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_em_fem_series_std(s : PhysicsemfemSeries) -> Double { @_common.std(s.vals) }

pub fn physics_em_fem_series_median(s : PhysicsemfemSeries) -> Double { @_common.median(s.vals) }

pub fn physics_em_fem_series_scale(s : PhysicsemfemSeries, f : Double) -> PhysicsemfemSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_em_fem_series_add(a : PhysicsemfemSeries, b : PhysicsemfemSeries) -> PhysicsemfemSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_em_fem_series_sub(a : PhysicsemfemSeries, b : PhysicsemfemSeries) -> PhysicsemfemSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_em_fem_series_normalize(s : PhysicsemfemSeries) -> PhysicsemfemSeries {
  let mn = physics_em_fem_series_min(s)
  let mx = physics_em_fem_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_em_fem_series_cumsum(s : PhysicsemfemSeries) -> PhysicsemfemSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_em_fem_series_to_string(s : PhysicsemfemSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsemfemMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_em_fem_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsemfemMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_em_fem_matrix_identity(n : Int) -> PhysicsemfemMatrix {
  let m = physics_em_fem_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_em_fem_matrix_get(m : PhysicsemfemMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_em_fem_matrix_transpose(m : PhysicsemfemMatrix) -> PhysicsemfemMatrix {
  let result = physics_em_fem_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_em_fem_matrix_add(a : PhysicsemfemMatrix, b : PhysicsemfemMatrix) -> PhysicsemfemMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_em_fem_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_em_fem_matrix_scale(m : PhysicsemfemMatrix, s : Double) -> PhysicsemfemMatrix {
  let result = physics_em_fem_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_em_fem_matrix_multiply(a : PhysicsemfemMatrix, b : PhysicsemfemMatrix) -> PhysicsemfemMatrix {
  if a.cols != b.rows { return physics_em_fem_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_em_fem_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_em_fem_matrix_trace(m : PhysicsemfemMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_em_fem_matrix_det(m : PhysicsemfemMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_em_fem_matrix_norm(m : PhysicsemfemMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_em_fem_matrix_to_string(m : PhysicsemfemMatrix) -> String {
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

pub(all) struct PhysicsemfemVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_em_fem_make_vector(comps : Array[Double]) -> PhysicsemfemVector {
  { comps, dim: comps.length() }
}

pub fn physics_em_fem_vector_zero(dim : Int) -> PhysicsemfemVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_em_fem_vector_add(a : PhysicsemfemVector, b : PhysicsemfemVector) -> PhysicsemfemVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_fem_vector_sub(a : PhysicsemfemVector, b : PhysicsemfemVector) -> PhysicsemfemVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_em_fem_vector_scale(v : PhysicsemfemVector, s : Double) -> PhysicsemfemVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_em_fem_vector_dot(a : PhysicsemfemVector, b : PhysicsemfemVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_em_fem_vector_norm(v : PhysicsemfemVector) -> Double { @_common.sqrt(physics_em_fem_vector_dot(v, v)) }

pub fn physics_em_fem_vector_normalize(v : PhysicsemfemVector) -> PhysicsemfemVector {
  let n = physics_em_fem_vector_norm(v)
  if n < 0.0000001 { v } else { physics_em_fem_vector_scale(v, 1.0 / n) }
}

pub fn physics_em_fem_vector_dist(a : PhysicsemfemVector, b : PhysicsemfemVector) -> Double {
  physics_em_fem_vector_norm(physics_em_fem_vector_sub(a, b))
}

pub fn physics_em_fem_vector_to_string(v : PhysicsemfemVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_em_fem_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_em_fem_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_em_fem_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_em_fem_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_em_fem_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_em_fem_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_em_fem_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_em_fem_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_em_fem_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_em_fem_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_em_fem_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_em_fem_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_em_fem_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_em_fem_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_em_fem_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_em_fem_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_em_fem_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_em_fem_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_em_fem_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_em_fem_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_em_fem_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_em_fem_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_em_fem_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_em_fem_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_em_fem_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_em_fem_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_em_fem_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_em_fem_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_em_fem_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsemfemFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_frame_make(size : Int) -> PhysicsemfemFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_frame_len(s : PhysicsemfemFrame) -> Int { s.size }

pub fn physics_em_fem_frame_get(s : PhysicsemfemFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_frame_set(s : PhysicsemfemFrame, i : Int, v : Double) -> PhysicsemfemFrame {
  let result = physics_em_fem_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_frame_sum(s : PhysicsemfemFrame) -> Double { @_common.sum(s.data) }

pub fn physics_em_fem_frame_mean(s : PhysicsemfemFrame) -> Double { @_common.mean(s.data) }

pub fn physics_em_fem_frame_scale(s : PhysicsemfemFrame, f : Double) -> PhysicsemfemFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_frame_add(a : PhysicsemfemFrame, b : PhysicsemfemFrame) -> PhysicsemfemFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fem_frame_copy(s : PhysicsemfemFrame) -> PhysicsemfemFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_frame_fill(s : PhysicsemfemFrame, v : Double) -> PhysicsemfemFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_frame_min(s : PhysicsemfemFrame) -> Double { @_common.min(s.data) }

pub fn physics_em_fem_frame_max(s : PhysicsemfemFrame) -> Double { @_common.max(s.data) }

pub fn physics_em_fem_frame_to_string(s : PhysicsemfemFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_table_make(size : Int) -> PhysicsemfemTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_table_len(s : PhysicsemfemTable) -> Int { s.size }

pub fn physics_em_fem_table_get(s : PhysicsemfemTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_table_set(s : PhysicsemfemTable, i : Int, v : Double) -> PhysicsemfemTable {
  let result = physics_em_fem_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_table_sum(s : PhysicsemfemTable) -> Double { @_common.sum(s.data) }

pub fn physics_em_fem_table_mean(s : PhysicsemfemTable) -> Double { @_common.mean(s.data) }

pub fn physics_em_fem_table_scale(s : PhysicsemfemTable, f : Double) -> PhysicsemfemTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_table_add(a : PhysicsemfemTable, b : PhysicsemfemTable) -> PhysicsemfemTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fem_table_copy(s : PhysicsemfemTable) -> PhysicsemfemTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_table_fill(s : PhysicsemfemTable, v : Double) -> PhysicsemfemTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_table_min(s : PhysicsemfemTable) -> Double { @_common.min(s.data) }

pub fn physics_em_fem_table_max(s : PhysicsemfemTable) -> Double { @_common.max(s.data) }

pub fn physics_em_fem_table_to_string(s : PhysicsemfemTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_graphn_make(size : Int) -> PhysicsemfemGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_graphn_len(s : PhysicsemfemGraphN) -> Int { s.size }

pub fn physics_em_fem_graphn_get(s : PhysicsemfemGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_graphn_set(s : PhysicsemfemGraphN, i : Int, v : Double) -> PhysicsemfemGraphN {
  let result = physics_em_fem_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_graphn_sum(s : PhysicsemfemGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_em_fem_graphn_mean(s : PhysicsemfemGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_em_fem_graphn_scale(s : PhysicsemfemGraphN, f : Double) -> PhysicsemfemGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_graphn_add(a : PhysicsemfemGraphN, b : PhysicsemfemGraphN) -> PhysicsemfemGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fem_graphn_copy(s : PhysicsemfemGraphN) -> PhysicsemfemGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_graphn_fill(s : PhysicsemfemGraphN, v : Double) -> PhysicsemfemGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_graphn_min(s : PhysicsemfemGraphN) -> Double { @_common.min(s.data) }

pub fn physics_em_fem_graphn_max(s : PhysicsemfemGraphN) -> Double { @_common.max(s.data) }

pub fn physics_em_fem_graphn_to_string(s : PhysicsemfemGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_node_make(size : Int) -> PhysicsemfemNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_node_len(s : PhysicsemfemNode) -> Int { s.size }

pub fn physics_em_fem_node_get(s : PhysicsemfemNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_node_set(s : PhysicsemfemNode, i : Int, v : Double) -> PhysicsemfemNode {
  let result = physics_em_fem_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_node_sum(s : PhysicsemfemNode) -> Double { @_common.sum(s.data) }

pub fn physics_em_fem_node_mean(s : PhysicsemfemNode) -> Double { @_common.mean(s.data) }

pub fn physics_em_fem_node_scale(s : PhysicsemfemNode, f : Double) -> PhysicsemfemNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_node_add(a : PhysicsemfemNode, b : PhysicsemfemNode) -> PhysicsemfemNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fem_node_copy(s : PhysicsemfemNode) -> PhysicsemfemNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_node_fill(s : PhysicsemfemNode, v : Double) -> PhysicsemfemNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_node_min(s : PhysicsemfemNode) -> Double { @_common.min(s.data) }

pub fn physics_em_fem_node_max(s : PhysicsemfemNode) -> Double { @_common.max(s.data) }

pub fn physics_em_fem_node_to_string(s : PhysicsemfemNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_edge_make(size : Int) -> PhysicsemfemEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_edge_len(s : PhysicsemfemEdge) -> Int { s.size }

pub fn physics_em_fem_edge_get(s : PhysicsemfemEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_edge_set(s : PhysicsemfemEdge, i : Int, v : Double) -> PhysicsemfemEdge {
  let result = physics_em_fem_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_edge_sum(s : PhysicsemfemEdge) -> Double { @_common.sum(s.data) }

pub fn physics_em_fem_edge_mean(s : PhysicsemfemEdge) -> Double { @_common.mean(s.data) }

pub fn physics_em_fem_edge_scale(s : PhysicsemfemEdge, f : Double) -> PhysicsemfemEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_edge_add(a : PhysicsemfemEdge, b : PhysicsemfemEdge) -> PhysicsemfemEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fem_edge_copy(s : PhysicsemfemEdge) -> PhysicsemfemEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_edge_fill(s : PhysicsemfemEdge, v : Double) -> PhysicsemfemEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_edge_min(s : PhysicsemfemEdge) -> Double { @_common.min(s.data) }

pub fn physics_em_fem_edge_max(s : PhysicsemfemEdge) -> Double { @_common.max(s.data) }

pub fn physics_em_fem_edge_to_string(s : PhysicsemfemEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_path_make(size : Int) -> PhysicsemfemPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_path_len(s : PhysicsemfemPath) -> Int { s.size }

pub fn physics_em_fem_path_get(s : PhysicsemfemPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_path_set(s : PhysicsemfemPath, i : Int, v : Double) -> PhysicsemfemPath {
  let result = physics_em_fem_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_path_sum(s : PhysicsemfemPath) -> Double { @_common.sum(s.data) }

pub fn physics_em_fem_path_mean(s : PhysicsemfemPath) -> Double { @_common.mean(s.data) }

pub fn physics_em_fem_path_scale(s : PhysicsemfemPath, f : Double) -> PhysicsemfemPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_path_add(a : PhysicsemfemPath, b : PhysicsemfemPath) -> PhysicsemfemPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fem_path_copy(s : PhysicsemfemPath) -> PhysicsemfemPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_path_fill(s : PhysicsemfemPath, v : Double) -> PhysicsemfemPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_path_min(s : PhysicsemfemPath) -> Double { @_common.min(s.data) }

pub fn physics_em_fem_path_max(s : PhysicsemfemPath) -> Double { @_common.max(s.data) }

pub fn physics_em_fem_path_to_string(s : PhysicsemfemPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_cluster_make(size : Int) -> PhysicsemfemCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_cluster_len(s : PhysicsemfemCluster) -> Int { s.size }

pub fn physics_em_fem_cluster_get(s : PhysicsemfemCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_cluster_set(s : PhysicsemfemCluster, i : Int, v : Double) -> PhysicsemfemCluster {
  let result = physics_em_fem_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_cluster_sum(s : PhysicsemfemCluster) -> Double { @_common.sum(s.data) }

pub fn physics_em_fem_cluster_mean(s : PhysicsemfemCluster) -> Double { @_common.mean(s.data) }

pub fn physics_em_fem_cluster_scale(s : PhysicsemfemCluster, f : Double) -> PhysicsemfemCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_cluster_add(a : PhysicsemfemCluster, b : PhysicsemfemCluster) -> PhysicsemfemCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fem_cluster_copy(s : PhysicsemfemCluster) -> PhysicsemfemCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_cluster_fill(s : PhysicsemfemCluster, v : Double) -> PhysicsemfemCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_cluster_min(s : PhysicsemfemCluster) -> Double { @_common.min(s.data) }

pub fn physics_em_fem_cluster_max(s : PhysicsemfemCluster) -> Double { @_common.max(s.data) }

pub fn physics_em_fem_cluster_to_string(s : PhysicsemfemCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_model_make(size : Int) -> PhysicsemfemModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_model_len(s : PhysicsemfemModel) -> Int { s.size }

pub fn physics_em_fem_model_get(s : PhysicsemfemModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_model_set(s : PhysicsemfemModel, i : Int, v : Double) -> PhysicsemfemModel {
  let result = physics_em_fem_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_model_sum(s : PhysicsemfemModel) -> Double { @_common.sum(s.data) }

pub fn physics_em_fem_model_mean(s : PhysicsemfemModel) -> Double { @_common.mean(s.data) }

pub fn physics_em_fem_model_scale(s : PhysicsemfemModel, f : Double) -> PhysicsemfemModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_model_add(a : PhysicsemfemModel, b : PhysicsemfemModel) -> PhysicsemfemModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fem_model_copy(s : PhysicsemfemModel) -> PhysicsemfemModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_model_fill(s : PhysicsemfemModel, v : Double) -> PhysicsemfemModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_model_min(s : PhysicsemfemModel) -> Double { @_common.min(s.data) }

pub fn physics_em_fem_model_max(s : PhysicsemfemModel) -> Double { @_common.max(s.data) }

pub fn physics_em_fem_model_to_string(s : PhysicsemfemModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_layer_make(size : Int) -> PhysicsemfemLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_layer_len(s : PhysicsemfemLayer) -> Int { s.size }

pub fn physics_em_fem_layer_get(s : PhysicsemfemLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_layer_set(s : PhysicsemfemLayer, i : Int, v : Double) -> PhysicsemfemLayer {
  let result = physics_em_fem_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_layer_sum(s : PhysicsemfemLayer) -> Double { @_common.sum(s.data) }

pub fn physics_em_fem_layer_mean(s : PhysicsemfemLayer) -> Double { @_common.mean(s.data) }

pub fn physics_em_fem_layer_scale(s : PhysicsemfemLayer, f : Double) -> PhysicsemfemLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_layer_add(a : PhysicsemfemLayer, b : PhysicsemfemLayer) -> PhysicsemfemLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fem_layer_copy(s : PhysicsemfemLayer) -> PhysicsemfemLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_layer_fill(s : PhysicsemfemLayer, v : Double) -> PhysicsemfemLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_layer_min(s : PhysicsemfemLayer) -> Double { @_common.min(s.data) }

pub fn physics_em_fem_layer_max(s : PhysicsemfemLayer) -> Double { @_common.max(s.data) }

pub fn physics_em_fem_layer_to_string(s : PhysicsemfemLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_buffer_make(size : Int) -> PhysicsemfemBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_buffer_len(s : PhysicsemfemBuffer) -> Int { s.size }

pub fn physics_em_fem_buffer_get(s : PhysicsemfemBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_buffer_set(s : PhysicsemfemBuffer, i : Int, v : Double) -> PhysicsemfemBuffer {
  let result = physics_em_fem_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_buffer_sum(s : PhysicsemfemBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_em_fem_buffer_mean(s : PhysicsemfemBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_em_fem_buffer_scale(s : PhysicsemfemBuffer, f : Double) -> PhysicsemfemBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_buffer_add(a : PhysicsemfemBuffer, b : PhysicsemfemBuffer) -> PhysicsemfemBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fem_buffer_copy(s : PhysicsemfemBuffer) -> PhysicsemfemBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_buffer_fill(s : PhysicsemfemBuffer, v : Double) -> PhysicsemfemBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_buffer_min(s : PhysicsemfemBuffer) -> Double { @_common.min(s.data) }

pub fn physics_em_fem_buffer_max(s : PhysicsemfemBuffer) -> Double { @_common.max(s.data) }

pub fn physics_em_fem_buffer_to_string(s : PhysicsemfemBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_cursor_make(size : Int) -> PhysicsemfemCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_cursor_len(s : PhysicsemfemCursor) -> Int { s.size }

pub fn physics_em_fem_cursor_get(s : PhysicsemfemCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_cursor_set(s : PhysicsemfemCursor, i : Int, v : Double) -> PhysicsemfemCursor {
  let result = physics_em_fem_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_cursor_sum(s : PhysicsemfemCursor) -> Double { @_common.sum(s.data) }

pub fn physics_em_fem_cursor_mean(s : PhysicsemfemCursor) -> Double { @_common.mean(s.data) }

pub fn physics_em_fem_cursor_scale(s : PhysicsemfemCursor, f : Double) -> PhysicsemfemCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_cursor_add(a : PhysicsemfemCursor, b : PhysicsemfemCursor) -> PhysicsemfemCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fem_cursor_copy(s : PhysicsemfemCursor) -> PhysicsemfemCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_cursor_fill(s : PhysicsemfemCursor, v : Double) -> PhysicsemfemCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_cursor_min(s : PhysicsemfemCursor) -> Double { @_common.min(s.data) }

pub fn physics_em_fem_cursor_max(s : PhysicsemfemCursor) -> Double { @_common.max(s.data) }

pub fn physics_em_fem_cursor_to_string(s : PhysicsemfemCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_view_make(size : Int) -> PhysicsemfemView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_view_len(s : PhysicsemfemView) -> Int { s.size }

pub fn physics_em_fem_view_get(s : PhysicsemfemView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_view_set(s : PhysicsemfemView, i : Int, v : Double) -> PhysicsemfemView {
  let result = physics_em_fem_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_view_sum(s : PhysicsemfemView) -> Double { @_common.sum(s.data) }

pub fn physics_em_fem_view_mean(s : PhysicsemfemView) -> Double { @_common.mean(s.data) }

pub fn physics_em_fem_view_scale(s : PhysicsemfemView, f : Double) -> PhysicsemfemView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_view_add(a : PhysicsemfemView, b : PhysicsemfemView) -> PhysicsemfemView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fem_view_copy(s : PhysicsemfemView) -> PhysicsemfemView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_view_fill(s : PhysicsemfemView, v : Double) -> PhysicsemfemView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_view_min(s : PhysicsemfemView) -> Double { @_common.min(s.data) }

pub fn physics_em_fem_view_max(s : PhysicsemfemView) -> Double { @_common.max(s.data) }

pub fn physics_em_fem_view_to_string(s : PhysicsemfemView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_range_make(size : Int) -> PhysicsemfemRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_range_len(s : PhysicsemfemRange) -> Int { s.size }

pub fn physics_em_fem_range_get(s : PhysicsemfemRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_range_set(s : PhysicsemfemRange, i : Int, v : Double) -> PhysicsemfemRange {
  let result = physics_em_fem_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_range_sum(s : PhysicsemfemRange) -> Double { @_common.sum(s.data) }

pub fn physics_em_fem_range_mean(s : PhysicsemfemRange) -> Double { @_common.mean(s.data) }

pub fn physics_em_fem_range_scale(s : PhysicsemfemRange, f : Double) -> PhysicsemfemRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_range_add(a : PhysicsemfemRange, b : PhysicsemfemRange) -> PhysicsemfemRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fem_range_copy(s : PhysicsemfemRange) -> PhysicsemfemRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_range_fill(s : PhysicsemfemRange, v : Double) -> PhysicsemfemRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_range_min(s : PhysicsemfemRange) -> Double { @_common.min(s.data) }

pub fn physics_em_fem_range_max(s : PhysicsemfemRange) -> Double { @_common.max(s.data) }

pub fn physics_em_fem_range_to_string(s : PhysicsemfemRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsemfemSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_em_fem_slice_make(size : Int) -> PhysicsemfemSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_em_fem_slice_len(s : PhysicsemfemSlice) -> Int { s.size }

pub fn physics_em_fem_slice_get(s : PhysicsemfemSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_em_fem_slice_set(s : PhysicsemfemSlice, i : Int, v : Double) -> PhysicsemfemSlice {
  let result = physics_em_fem_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_em_fem_slice_sum(s : PhysicsemfemSlice) -> Double { @_common.sum(s.data) }

pub fn physics_em_fem_slice_mean(s : PhysicsemfemSlice) -> Double { @_common.mean(s.data) }

pub fn physics_em_fem_slice_scale(s : PhysicsemfemSlice, f : Double) -> PhysicsemfemSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_slice_add(a : PhysicsemfemSlice, b : PhysicsemfemSlice) -> PhysicsemfemSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn physics_em_fem_slice_copy(s : PhysicsemfemSlice) -> PhysicsemfemSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_slice_fill(s : PhysicsemfemSlice, v : Double) -> PhysicsemfemSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn physics_em_fem_slice_min(s : PhysicsemfemSlice) -> Double { @_common.min(s.data) }

pub fn physics_em_fem_slice_max(s : PhysicsemfemSlice) -> Double { @_common.max(s.data) }

pub fn physics_em_fem_slice_to_string(s : PhysicsemfemSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

