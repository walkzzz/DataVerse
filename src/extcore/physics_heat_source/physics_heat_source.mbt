///===
/// extcore/physics_heat_source

pub(all) struct PhysicsheatsourcePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_heat_source_make_point(x : Double, y : Double) -> PhysicsheatsourcePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_heat_source_make_point3(x : Double, y : Double, z : Double) -> PhysicsheatsourcePoint {
  { x, y, z, label: 0 }
}

pub fn physics_heat_source_point_x(pt : PhysicsheatsourcePoint) -> Double { pt.x }

pub fn physics_heat_source_point_y(pt : PhysicsheatsourcePoint) -> Double { pt.y }

pub fn physics_heat_source_point_z(pt : PhysicsheatsourcePoint) -> Double { pt.z }

pub fn physics_heat_source_point_label(pt : PhysicsheatsourcePoint) -> Int { pt.label }

pub fn physics_heat_source_point_dist(a : PhysicsheatsourcePoint, b : PhysicsheatsourcePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_heat_source_point_add(a : PhysicsheatsourcePoint, b : PhysicsheatsourcePoint) -> PhysicsheatsourcePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_heat_source_point_sub(a : PhysicsheatsourcePoint, b : PhysicsheatsourcePoint) -> PhysicsheatsourcePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_heat_source_point_scale(pt : PhysicsheatsourcePoint, s : Double) -> PhysicsheatsourcePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_heat_source_point_dot(a : PhysicsheatsourcePoint, b : PhysicsheatsourcePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_heat_source_point_cross(a : PhysicsheatsourcePoint, b : PhysicsheatsourcePoint) -> PhysicsheatsourcePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_heat_source_point_norm(pt : PhysicsheatsourcePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_heat_source_point_normalize(pt : PhysicsheatsourcePoint) -> PhysicsheatsourcePoint {
  let n = physics_heat_source_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_heat_source_point_scale(pt, 1.0 / n) }
}

pub fn physics_heat_source_point_negate(pt : PhysicsheatsourcePoint) -> PhysicsheatsourcePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_heat_source_point_mid(a : PhysicsheatsourcePoint, b : PhysicsheatsourcePoint) -> PhysicsheatsourcePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_heat_source_point_lerp(a : PhysicsheatsourcePoint, b : PhysicsheatsourcePoint, t : Double) -> PhysicsheatsourcePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_heat_source_point_to_string(pt : PhysicsheatsourcePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsheatsourceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_heat_source_make_series(vals : Array[Double], name : String) -> PhysicsheatsourceSeries {
  { vals, name, meta: 0 }
}

pub fn physics_heat_source_series_len(s : PhysicsheatsourceSeries) -> Int { s.vals.length() }

pub fn physics_heat_source_series_sum(s : PhysicsheatsourceSeries) -> Double { @_common.sum(s.vals) }

pub fn physics_heat_source_series_mean(s : PhysicsheatsourceSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_heat_source_series_min(s : PhysicsheatsourceSeries) -> Double { @_common.min(s.vals) }

pub fn physics_heat_source_series_max(s : PhysicsheatsourceSeries) -> Double { @_common.max(s.vals) }

pub fn physics_heat_source_series_range(s : PhysicsheatsourceSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_heat_source_series_var(s : PhysicsheatsourceSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_heat_source_series_std(s : PhysicsheatsourceSeries) -> Double { @_common.std(s.vals) }

pub fn physics_heat_source_series_median(s : PhysicsheatsourceSeries) -> Double { @_common.median(s.vals) }

pub fn physics_heat_source_series_scale(s : PhysicsheatsourceSeries, f : Double) -> PhysicsheatsourceSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_heat_source_series_add(a : PhysicsheatsourceSeries, b : PhysicsheatsourceSeries) -> PhysicsheatsourceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_heat_source_series_sub(a : PhysicsheatsourceSeries, b : PhysicsheatsourceSeries) -> PhysicsheatsourceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_heat_source_series_normalize(s : PhysicsheatsourceSeries) -> PhysicsheatsourceSeries {
  let mn = physics_heat_source_series_min(s)
  let mx = physics_heat_source_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_heat_source_series_cumsum(s : PhysicsheatsourceSeries) -> PhysicsheatsourceSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_heat_source_series_to_string(s : PhysicsheatsourceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsheatsourceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_heat_source_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsheatsourceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_heat_source_matrix_identity(n : Int) -> PhysicsheatsourceMatrix {
  let m = physics_heat_source_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_heat_source_matrix_get(m : PhysicsheatsourceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_heat_source_matrix_transpose(m : PhysicsheatsourceMatrix) -> PhysicsheatsourceMatrix {
  let result = physics_heat_source_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_heat_source_matrix_add(a : PhysicsheatsourceMatrix, b : PhysicsheatsourceMatrix) -> PhysicsheatsourceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_heat_source_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_heat_source_matrix_scale(m : PhysicsheatsourceMatrix, s : Double) -> PhysicsheatsourceMatrix {
  let result = physics_heat_source_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_heat_source_matrix_multiply(a : PhysicsheatsourceMatrix, b : PhysicsheatsourceMatrix) -> PhysicsheatsourceMatrix {
  if a.cols != b.rows { return physics_heat_source_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_heat_source_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_heat_source_matrix_trace(m : PhysicsheatsourceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_heat_source_matrix_det(m : PhysicsheatsourceMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_heat_source_matrix_norm(m : PhysicsheatsourceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_heat_source_matrix_to_string(m : PhysicsheatsourceMatrix) -> String {
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

pub(all) struct PhysicsheatsourceVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_heat_source_make_vector(comps : Array[Double]) -> PhysicsheatsourceVector {
  { comps, dim: comps.length() }
}

pub fn physics_heat_source_vector_zero(dim : Int) -> PhysicsheatsourceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_heat_source_vector_add(a : PhysicsheatsourceVector, b : PhysicsheatsourceVector) -> PhysicsheatsourceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_heat_source_vector_sub(a : PhysicsheatsourceVector, b : PhysicsheatsourceVector) -> PhysicsheatsourceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_heat_source_vector_scale(v : PhysicsheatsourceVector, s : Double) -> PhysicsheatsourceVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_heat_source_vector_dot(a : PhysicsheatsourceVector, b : PhysicsheatsourceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_heat_source_vector_norm(v : PhysicsheatsourceVector) -> Double { @_common.sqrt(physics_heat_source_vector_dot(v, v)) }

pub fn physics_heat_source_vector_normalize(v : PhysicsheatsourceVector) -> PhysicsheatsourceVector {
  let n = physics_heat_source_vector_norm(v)
  if n < 0.0000001 { v } else { physics_heat_source_vector_scale(v, 1.0 / n) }
}

pub fn physics_heat_source_vector_dist(a : PhysicsheatsourceVector, b : PhysicsheatsourceVector) -> Double {
  physics_heat_source_vector_norm(physics_heat_source_vector_sub(a, b))
}

pub fn physics_heat_source_vector_to_string(v : PhysicsheatsourceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_heat_source_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_heat_source_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_heat_source_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_heat_source_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_heat_source_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_heat_source_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_heat_source_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_heat_source_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_heat_source_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_heat_source_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_heat_source_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_heat_source_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_heat_source_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_heat_source_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_heat_source_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_heat_source_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_heat_source_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_heat_source_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_heat_source_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_heat_source_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_heat_source_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_heat_source_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_heat_source_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_heat_source_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_heat_source_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_heat_source_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_heat_source_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_heat_source_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_heat_source_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsheatsourceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_frame_make(size : Int) -> PhysicsheatsourceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_frame_len(s : PhysicsheatsourceFrame) -> Int { s.size }

pub fn physics_heat_source_frame_get(s : PhysicsheatsourceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_frame_set(s : PhysicsheatsourceFrame, i : Int, v : Double) -> PhysicsheatsourceFrame {
  let result = physics_heat_source_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_frame_sum(s : PhysicsheatsourceFrame) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_frame_mean(s : PhysicsheatsourceFrame) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_frame_scale(s : PhysicsheatsourceFrame, f : Double) -> PhysicsheatsourceFrame {
  let result = physics_heat_source_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_source_frame_add(a : PhysicsheatsourceFrame, b : PhysicsheatsourceFrame) -> PhysicsheatsourceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_source_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_source_frame_copy(s : PhysicsheatsourceFrame) -> PhysicsheatsourceFrame {
  let result = physics_heat_source_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_source_frame_fill(s : PhysicsheatsourceFrame, v : Double) -> PhysicsheatsourceFrame {
  let result = physics_heat_source_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_frame_min(s : PhysicsheatsourceFrame) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_frame_max(s : PhysicsheatsourceFrame) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_frame_to_string(s : PhysicsheatsourceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_table_make(size : Int) -> PhysicsheatsourceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_table_len(s : PhysicsheatsourceTable) -> Int { s.size }

pub fn physics_heat_source_table_get(s : PhysicsheatsourceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_table_set(s : PhysicsheatsourceTable, i : Int, v : Double) -> PhysicsheatsourceTable {
  let result = physics_heat_source_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_table_sum(s : PhysicsheatsourceTable) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_table_mean(s : PhysicsheatsourceTable) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_table_scale(s : PhysicsheatsourceTable, f : Double) -> PhysicsheatsourceTable {
  let result = physics_heat_source_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_source_table_add(a : PhysicsheatsourceTable, b : PhysicsheatsourceTable) -> PhysicsheatsourceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_source_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_source_table_copy(s : PhysicsheatsourceTable) -> PhysicsheatsourceTable {
  let result = physics_heat_source_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_source_table_fill(s : PhysicsheatsourceTable, v : Double) -> PhysicsheatsourceTable {
  let result = physics_heat_source_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_table_min(s : PhysicsheatsourceTable) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_table_max(s : PhysicsheatsourceTable) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_table_to_string(s : PhysicsheatsourceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_graphn_make(size : Int) -> PhysicsheatsourceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_graphn_len(s : PhysicsheatsourceGraphN) -> Int { s.size }

pub fn physics_heat_source_graphn_get(s : PhysicsheatsourceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_graphn_set(s : PhysicsheatsourceGraphN, i : Int, v : Double) -> PhysicsheatsourceGraphN {
  let result = physics_heat_source_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_graphn_sum(s : PhysicsheatsourceGraphN) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_graphn_mean(s : PhysicsheatsourceGraphN) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_graphn_scale(s : PhysicsheatsourceGraphN, f : Double) -> PhysicsheatsourceGraphN {
  let result = physics_heat_source_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_source_graphn_add(a : PhysicsheatsourceGraphN, b : PhysicsheatsourceGraphN) -> PhysicsheatsourceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_source_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_source_graphn_copy(s : PhysicsheatsourceGraphN) -> PhysicsheatsourceGraphN {
  let result = physics_heat_source_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_source_graphn_fill(s : PhysicsheatsourceGraphN, v : Double) -> PhysicsheatsourceGraphN {
  let result = physics_heat_source_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_graphn_min(s : PhysicsheatsourceGraphN) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_graphn_max(s : PhysicsheatsourceGraphN) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_graphn_to_string(s : PhysicsheatsourceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_node_make(size : Int) -> PhysicsheatsourceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_node_len(s : PhysicsheatsourceNode) -> Int { s.size }

pub fn physics_heat_source_node_get(s : PhysicsheatsourceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_node_set(s : PhysicsheatsourceNode, i : Int, v : Double) -> PhysicsheatsourceNode {
  let result = physics_heat_source_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_node_sum(s : PhysicsheatsourceNode) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_node_mean(s : PhysicsheatsourceNode) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_node_scale(s : PhysicsheatsourceNode, f : Double) -> PhysicsheatsourceNode {
  let result = physics_heat_source_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_source_node_add(a : PhysicsheatsourceNode, b : PhysicsheatsourceNode) -> PhysicsheatsourceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_source_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_source_node_copy(s : PhysicsheatsourceNode) -> PhysicsheatsourceNode {
  let result = physics_heat_source_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_source_node_fill(s : PhysicsheatsourceNode, v : Double) -> PhysicsheatsourceNode {
  let result = physics_heat_source_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_node_min(s : PhysicsheatsourceNode) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_node_max(s : PhysicsheatsourceNode) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_node_to_string(s : PhysicsheatsourceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_edge_make(size : Int) -> PhysicsheatsourceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_edge_len(s : PhysicsheatsourceEdge) -> Int { s.size }

pub fn physics_heat_source_edge_get(s : PhysicsheatsourceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_edge_set(s : PhysicsheatsourceEdge, i : Int, v : Double) -> PhysicsheatsourceEdge {
  let result = physics_heat_source_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_edge_sum(s : PhysicsheatsourceEdge) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_edge_mean(s : PhysicsheatsourceEdge) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_edge_scale(s : PhysicsheatsourceEdge, f : Double) -> PhysicsheatsourceEdge {
  let result = physics_heat_source_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_source_edge_add(a : PhysicsheatsourceEdge, b : PhysicsheatsourceEdge) -> PhysicsheatsourceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_source_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_source_edge_copy(s : PhysicsheatsourceEdge) -> PhysicsheatsourceEdge {
  let result = physics_heat_source_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_source_edge_fill(s : PhysicsheatsourceEdge, v : Double) -> PhysicsheatsourceEdge {
  let result = physics_heat_source_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_edge_min(s : PhysicsheatsourceEdge) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_edge_max(s : PhysicsheatsourceEdge) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_edge_to_string(s : PhysicsheatsourceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourcePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_path_make(size : Int) -> PhysicsheatsourcePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_path_len(s : PhysicsheatsourcePath) -> Int { s.size }

pub fn physics_heat_source_path_get(s : PhysicsheatsourcePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_path_set(s : PhysicsheatsourcePath, i : Int, v : Double) -> PhysicsheatsourcePath {
  let result = physics_heat_source_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_path_sum(s : PhysicsheatsourcePath) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_path_mean(s : PhysicsheatsourcePath) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_path_scale(s : PhysicsheatsourcePath, f : Double) -> PhysicsheatsourcePath {
  let result = physics_heat_source_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_source_path_add(a : PhysicsheatsourcePath, b : PhysicsheatsourcePath) -> PhysicsheatsourcePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_source_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_source_path_copy(s : PhysicsheatsourcePath) -> PhysicsheatsourcePath {
  let result = physics_heat_source_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_source_path_fill(s : PhysicsheatsourcePath, v : Double) -> PhysicsheatsourcePath {
  let result = physics_heat_source_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_path_min(s : PhysicsheatsourcePath) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_path_max(s : PhysicsheatsourcePath) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_path_to_string(s : PhysicsheatsourcePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_cluster_make(size : Int) -> PhysicsheatsourceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_cluster_len(s : PhysicsheatsourceCluster) -> Int { s.size }

pub fn physics_heat_source_cluster_get(s : PhysicsheatsourceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_cluster_set(s : PhysicsheatsourceCluster, i : Int, v : Double) -> PhysicsheatsourceCluster {
  let result = physics_heat_source_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_cluster_sum(s : PhysicsheatsourceCluster) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_cluster_mean(s : PhysicsheatsourceCluster) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_cluster_scale(s : PhysicsheatsourceCluster, f : Double) -> PhysicsheatsourceCluster {
  let result = physics_heat_source_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_source_cluster_add(a : PhysicsheatsourceCluster, b : PhysicsheatsourceCluster) -> PhysicsheatsourceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_source_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_source_cluster_copy(s : PhysicsheatsourceCluster) -> PhysicsheatsourceCluster {
  let result = physics_heat_source_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_source_cluster_fill(s : PhysicsheatsourceCluster, v : Double) -> PhysicsheatsourceCluster {
  let result = physics_heat_source_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_cluster_min(s : PhysicsheatsourceCluster) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_cluster_max(s : PhysicsheatsourceCluster) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_cluster_to_string(s : PhysicsheatsourceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_model_make(size : Int) -> PhysicsheatsourceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_model_len(s : PhysicsheatsourceModel) -> Int { s.size }

pub fn physics_heat_source_model_get(s : PhysicsheatsourceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_model_set(s : PhysicsheatsourceModel, i : Int, v : Double) -> PhysicsheatsourceModel {
  let result = physics_heat_source_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_model_sum(s : PhysicsheatsourceModel) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_model_mean(s : PhysicsheatsourceModel) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_model_scale(s : PhysicsheatsourceModel, f : Double) -> PhysicsheatsourceModel {
  let result = physics_heat_source_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_source_model_add(a : PhysicsheatsourceModel, b : PhysicsheatsourceModel) -> PhysicsheatsourceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_source_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_source_model_copy(s : PhysicsheatsourceModel) -> PhysicsheatsourceModel {
  let result = physics_heat_source_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_source_model_fill(s : PhysicsheatsourceModel, v : Double) -> PhysicsheatsourceModel {
  let result = physics_heat_source_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_model_min(s : PhysicsheatsourceModel) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_model_max(s : PhysicsheatsourceModel) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_model_to_string(s : PhysicsheatsourceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_layer_make(size : Int) -> PhysicsheatsourceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_layer_len(s : PhysicsheatsourceLayer) -> Int { s.size }

pub fn physics_heat_source_layer_get(s : PhysicsheatsourceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_layer_set(s : PhysicsheatsourceLayer, i : Int, v : Double) -> PhysicsheatsourceLayer {
  let result = physics_heat_source_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_layer_sum(s : PhysicsheatsourceLayer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_layer_mean(s : PhysicsheatsourceLayer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_layer_scale(s : PhysicsheatsourceLayer, f : Double) -> PhysicsheatsourceLayer {
  let result = physics_heat_source_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_source_layer_add(a : PhysicsheatsourceLayer, b : PhysicsheatsourceLayer) -> PhysicsheatsourceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_source_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_source_layer_copy(s : PhysicsheatsourceLayer) -> PhysicsheatsourceLayer {
  let result = physics_heat_source_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_source_layer_fill(s : PhysicsheatsourceLayer, v : Double) -> PhysicsheatsourceLayer {
  let result = physics_heat_source_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_layer_min(s : PhysicsheatsourceLayer) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_layer_max(s : PhysicsheatsourceLayer) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_layer_to_string(s : PhysicsheatsourceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_buffer_make(size : Int) -> PhysicsheatsourceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_buffer_len(s : PhysicsheatsourceBuffer) -> Int { s.size }

pub fn physics_heat_source_buffer_get(s : PhysicsheatsourceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_buffer_set(s : PhysicsheatsourceBuffer, i : Int, v : Double) -> PhysicsheatsourceBuffer {
  let result = physics_heat_source_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_buffer_sum(s : PhysicsheatsourceBuffer) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_buffer_mean(s : PhysicsheatsourceBuffer) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_buffer_scale(s : PhysicsheatsourceBuffer, f : Double) -> PhysicsheatsourceBuffer {
  let result = physics_heat_source_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_source_buffer_add(a : PhysicsheatsourceBuffer, b : PhysicsheatsourceBuffer) -> PhysicsheatsourceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_source_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_source_buffer_copy(s : PhysicsheatsourceBuffer) -> PhysicsheatsourceBuffer {
  let result = physics_heat_source_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_source_buffer_fill(s : PhysicsheatsourceBuffer, v : Double) -> PhysicsheatsourceBuffer {
  let result = physics_heat_source_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_buffer_min(s : PhysicsheatsourceBuffer) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_buffer_max(s : PhysicsheatsourceBuffer) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_buffer_to_string(s : PhysicsheatsourceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_cursor_make(size : Int) -> PhysicsheatsourceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_cursor_len(s : PhysicsheatsourceCursor) -> Int { s.size }

pub fn physics_heat_source_cursor_get(s : PhysicsheatsourceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_cursor_set(s : PhysicsheatsourceCursor, i : Int, v : Double) -> PhysicsheatsourceCursor {
  let result = physics_heat_source_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_cursor_sum(s : PhysicsheatsourceCursor) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_cursor_mean(s : PhysicsheatsourceCursor) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_cursor_scale(s : PhysicsheatsourceCursor, f : Double) -> PhysicsheatsourceCursor {
  let result = physics_heat_source_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_source_cursor_add(a : PhysicsheatsourceCursor, b : PhysicsheatsourceCursor) -> PhysicsheatsourceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_source_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_source_cursor_copy(s : PhysicsheatsourceCursor) -> PhysicsheatsourceCursor {
  let result = physics_heat_source_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_source_cursor_fill(s : PhysicsheatsourceCursor, v : Double) -> PhysicsheatsourceCursor {
  let result = physics_heat_source_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_cursor_min(s : PhysicsheatsourceCursor) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_cursor_max(s : PhysicsheatsourceCursor) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_cursor_to_string(s : PhysicsheatsourceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_view_make(size : Int) -> PhysicsheatsourceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_view_len(s : PhysicsheatsourceView) -> Int { s.size }

pub fn physics_heat_source_view_get(s : PhysicsheatsourceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_view_set(s : PhysicsheatsourceView, i : Int, v : Double) -> PhysicsheatsourceView {
  let result = physics_heat_source_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_view_sum(s : PhysicsheatsourceView) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_view_mean(s : PhysicsheatsourceView) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_view_scale(s : PhysicsheatsourceView, f : Double) -> PhysicsheatsourceView {
  let result = physics_heat_source_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_source_view_add(a : PhysicsheatsourceView, b : PhysicsheatsourceView) -> PhysicsheatsourceView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_source_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_source_view_copy(s : PhysicsheatsourceView) -> PhysicsheatsourceView {
  let result = physics_heat_source_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_source_view_fill(s : PhysicsheatsourceView, v : Double) -> PhysicsheatsourceView {
  let result = physics_heat_source_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_view_min(s : PhysicsheatsourceView) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_view_max(s : PhysicsheatsourceView) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_view_to_string(s : PhysicsheatsourceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_range_make(size : Int) -> PhysicsheatsourceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_range_len(s : PhysicsheatsourceRange) -> Int { s.size }

pub fn physics_heat_source_range_get(s : PhysicsheatsourceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_range_set(s : PhysicsheatsourceRange, i : Int, v : Double) -> PhysicsheatsourceRange {
  let result = physics_heat_source_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_range_sum(s : PhysicsheatsourceRange) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_range_mean(s : PhysicsheatsourceRange) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_range_scale(s : PhysicsheatsourceRange, f : Double) -> PhysicsheatsourceRange {
  let result = physics_heat_source_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_source_range_add(a : PhysicsheatsourceRange, b : PhysicsheatsourceRange) -> PhysicsheatsourceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_source_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_source_range_copy(s : PhysicsheatsourceRange) -> PhysicsheatsourceRange {
  let result = physics_heat_source_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_source_range_fill(s : PhysicsheatsourceRange, v : Double) -> PhysicsheatsourceRange {
  let result = physics_heat_source_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_range_min(s : PhysicsheatsourceRange) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_range_max(s : PhysicsheatsourceRange) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_range_to_string(s : PhysicsheatsourceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsheatsourceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_heat_source_slice_make(size : Int) -> PhysicsheatsourceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_heat_source_slice_len(s : PhysicsheatsourceSlice) -> Int { s.size }

pub fn physics_heat_source_slice_get(s : PhysicsheatsourceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_heat_source_slice_set(s : PhysicsheatsourceSlice, i : Int, v : Double) -> PhysicsheatsourceSlice {
  let result = physics_heat_source_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_slice_sum(s : PhysicsheatsourceSlice) -> Double { @_common.sum(s.data) }

pub fn physics_heat_source_slice_mean(s : PhysicsheatsourceSlice) -> Double { @_common.mean(s.data) }

pub fn physics_heat_source_slice_scale(s : PhysicsheatsourceSlice, f : Double) -> PhysicsheatsourceSlice {
  let result = physics_heat_source_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_heat_source_slice_add(a : PhysicsheatsourceSlice, b : PhysicsheatsourceSlice) -> PhysicsheatsourceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_heat_source_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_heat_source_slice_copy(s : PhysicsheatsourceSlice) -> PhysicsheatsourceSlice {
  let result = physics_heat_source_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_heat_source_slice_fill(s : PhysicsheatsourceSlice, v : Double) -> PhysicsheatsourceSlice {
  let result = physics_heat_source_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_heat_source_slice_min(s : PhysicsheatsourceSlice) -> Double { @_common.min(s.data) }

pub fn physics_heat_source_slice_max(s : PhysicsheatsourceSlice) -> Double { @_common.max(s.data) }

pub fn physics_heat_source_slice_to_string(s : PhysicsheatsourceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

