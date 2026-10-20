///===
/// extcore/physics_mechanics_static

pub(all) struct PhysicsmechanicsstaticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn physics_mechanics_static_make_point(x : Double, y : Double) -> PhysicsmechanicsstaticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn physics_mechanics_static_make_point3(x : Double, y : Double, z : Double) -> PhysicsmechanicsstaticPoint {
  { x, y, z, label: 0 }
}

pub fn physics_mechanics_static_point_x(pt : PhysicsmechanicsstaticPoint) -> Double { pt.x }

pub fn physics_mechanics_static_point_y(pt : PhysicsmechanicsstaticPoint) -> Double { pt.y }

pub fn physics_mechanics_static_point_z(pt : PhysicsmechanicsstaticPoint) -> Double { pt.z }

pub fn physics_mechanics_static_point_label(pt : PhysicsmechanicsstaticPoint) -> Int { pt.label }

pub fn physics_mechanics_static_point_dist(a : PhysicsmechanicsstaticPoint, b : PhysicsmechanicsstaticPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn physics_mechanics_static_point_add(a : PhysicsmechanicsstaticPoint, b : PhysicsmechanicsstaticPoint) -> PhysicsmechanicsstaticPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn physics_mechanics_static_point_sub(a : PhysicsmechanicsstaticPoint, b : PhysicsmechanicsstaticPoint) -> PhysicsmechanicsstaticPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn physics_mechanics_static_point_scale(pt : PhysicsmechanicsstaticPoint, s : Double) -> PhysicsmechanicsstaticPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn physics_mechanics_static_point_dot(a : PhysicsmechanicsstaticPoint, b : PhysicsmechanicsstaticPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn physics_mechanics_static_point_cross(a : PhysicsmechanicsstaticPoint, b : PhysicsmechanicsstaticPoint) -> PhysicsmechanicsstaticPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn physics_mechanics_static_point_norm(pt : PhysicsmechanicsstaticPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn physics_mechanics_static_point_normalize(pt : PhysicsmechanicsstaticPoint) -> PhysicsmechanicsstaticPoint {
  let n = physics_mechanics_static_point_norm(pt)
  if n < 0.0000001 { pt } else { physics_mechanics_static_point_scale(pt, 1.0 / n) }
}

pub fn physics_mechanics_static_point_negate(pt : PhysicsmechanicsstaticPoint) -> PhysicsmechanicsstaticPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn physics_mechanics_static_point_mid(a : PhysicsmechanicsstaticPoint, b : PhysicsmechanicsstaticPoint) -> PhysicsmechanicsstaticPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn physics_mechanics_static_point_lerp(a : PhysicsmechanicsstaticPoint, b : PhysicsmechanicsstaticPoint, t : Double) -> PhysicsmechanicsstaticPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn physics_mechanics_static_point_to_string(pt : PhysicsmechanicsstaticPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn physics_mechanics_static_make_series(vals : Array[Double], name : String) -> PhysicsmechanicsstaticSeries {
  { vals, name, meta: 0 }
}

pub fn physics_mechanics_static_series_len(s : PhysicsmechanicsstaticSeries) -> Int { s.vals.length() }

pub fn physics_mechanics_static_series_sum(s : PhysicsmechanicsstaticSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn physics_mechanics_static_series_mean(s : PhysicsmechanicsstaticSeries) -> Double { @_common.mean(s.vals) }

pub fn physics_mechanics_static_series_min(s : PhysicsmechanicsstaticSeries) -> Double { @_common.min(s.vals) }

pub fn physics_mechanics_static_series_max(s : PhysicsmechanicsstaticSeries) -> Double { @_common.max(s.vals) }

pub fn physics_mechanics_static_series_range(s : PhysicsmechanicsstaticSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn physics_mechanics_static_series_var(s : PhysicsmechanicsstaticSeries) -> Double { @_common.variance(s.vals) }

pub fn physics_mechanics_static_series_std(s : PhysicsmechanicsstaticSeries) -> Double { @_common.std(s.vals) }

pub fn physics_mechanics_static_series_median(s : PhysicsmechanicsstaticSeries) -> Double { @_common.median(s.vals) }

pub fn physics_mechanics_static_series_scale(s : PhysicsmechanicsstaticSeries, f : Double) -> PhysicsmechanicsstaticSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn physics_mechanics_static_series_add(a : PhysicsmechanicsstaticSeries, b : PhysicsmechanicsstaticSeries) -> PhysicsmechanicsstaticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn physics_mechanics_static_series_sub(a : PhysicsmechanicsstaticSeries, b : PhysicsmechanicsstaticSeries) -> PhysicsmechanicsstaticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn physics_mechanics_static_series_normalize(s : PhysicsmechanicsstaticSeries) -> PhysicsmechanicsstaticSeries {
  let mn = physics_mechanics_static_series_min(s)
  let mx = physics_mechanics_static_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn physics_mechanics_static_series_cumsum(s : PhysicsmechanicsstaticSeries) -> PhysicsmechanicsstaticSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn physics_mechanics_static_series_to_string(s : PhysicsmechanicsstaticSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct PhysicsmechanicsstaticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn physics_mechanics_static_make_matrix(rows : Int, cols : Int, val : Double) -> PhysicsmechanicsstaticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn physics_mechanics_static_matrix_identity(n : Int) -> PhysicsmechanicsstaticMatrix {
  let m = physics_mechanics_static_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn physics_mechanics_static_matrix_get(m : PhysicsmechanicsstaticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn physics_mechanics_static_matrix_transpose(m : PhysicsmechanicsstaticMatrix) -> PhysicsmechanicsstaticMatrix {
  let result = physics_mechanics_static_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn physics_mechanics_static_matrix_add(a : PhysicsmechanicsstaticMatrix, b : PhysicsmechanicsstaticMatrix) -> PhysicsmechanicsstaticMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = physics_mechanics_static_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn physics_mechanics_static_matrix_scale(m : PhysicsmechanicsstaticMatrix, s : Double) -> PhysicsmechanicsstaticMatrix {
  let result = physics_mechanics_static_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn physics_mechanics_static_matrix_multiply(a : PhysicsmechanicsstaticMatrix, b : PhysicsmechanicsstaticMatrix) -> PhysicsmechanicsstaticMatrix {
  if a.cols != b.rows { return physics_mechanics_static_make_matrix(a.rows, b.cols, 0.0) }
  let result = physics_mechanics_static_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn physics_mechanics_static_matrix_trace(m : PhysicsmechanicsstaticMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn physics_mechanics_static_matrix_det(m : PhysicsmechanicsstaticMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn physics_mechanics_static_matrix_norm(m : PhysicsmechanicsstaticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn physics_mechanics_static_matrix_to_string(m : PhysicsmechanicsstaticMatrix) -> String {
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

pub(all) struct PhysicsmechanicsstaticVector {
  comps : Array[Double]
  dim : Int
}

pub fn physics_mechanics_static_make_vector(comps : Array[Double]) -> PhysicsmechanicsstaticVector {
  { comps, dim: comps.length() }
}

pub fn physics_mechanics_static_vector_zero(dim : Int) -> PhysicsmechanicsstaticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn physics_mechanics_static_vector_add(a : PhysicsmechanicsstaticVector, b : PhysicsmechanicsstaticVector) -> PhysicsmechanicsstaticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_static_vector_sub(a : PhysicsmechanicsstaticVector, b : PhysicsmechanicsstaticVector) -> PhysicsmechanicsstaticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn physics_mechanics_static_vector_scale(v : PhysicsmechanicsstaticVector, s : Double) -> PhysicsmechanicsstaticVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn physics_mechanics_static_vector_dot(a : PhysicsmechanicsstaticVector, b : PhysicsmechanicsstaticVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn physics_mechanics_static_vector_norm(v : PhysicsmechanicsstaticVector) -> Double { @_common.sqrt(physics_mechanics_static_vector_dot(v, v)) }

pub fn physics_mechanics_static_vector_normalize(v : PhysicsmechanicsstaticVector) -> PhysicsmechanicsstaticVector {
  let n = physics_mechanics_static_vector_norm(v)
  if n < 0.0000001 { v } else { physics_mechanics_static_vector_scale(v, 1.0 / n) }
}

pub fn physics_mechanics_static_vector_dist(a : PhysicsmechanicsstaticVector, b : PhysicsmechanicsstaticVector) -> Double {
  physics_mechanics_static_vector_norm(physics_mechanics_static_vector_sub(a, b))
}

pub fn physics_mechanics_static_vector_to_string(v : PhysicsmechanicsstaticVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn physics_mechanics_static_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn physics_mechanics_static_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn physics_mechanics_static_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn physics_mechanics_static_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn physics_mechanics_static_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn physics_mechanics_static_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn physics_mechanics_static_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn physics_mechanics_static_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn physics_mechanics_static_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn physics_mechanics_static_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn physics_mechanics_static_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn physics_mechanics_static_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn physics_mechanics_static_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn physics_mechanics_static_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn physics_mechanics_static_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn physics_mechanics_static_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn physics_mechanics_static_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn physics_mechanics_static_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn physics_mechanics_static_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn physics_mechanics_static_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn physics_mechanics_static_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn physics_mechanics_static_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn physics_mechanics_static_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn physics_mechanics_static_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn physics_mechanics_static_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn physics_mechanics_static_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn physics_mechanics_static_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn physics_mechanics_static_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn physics_mechanics_static_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct PhysicsmechanicsstaticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_frame_make(size : Int) -> PhysicsmechanicsstaticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_frame_len(s : PhysicsmechanicsstaticFrame) -> Int { s.size }

pub fn physics_mechanics_static_frame_get(s : PhysicsmechanicsstaticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_frame_set(s : PhysicsmechanicsstaticFrame, i : Int, v : Double) -> PhysicsmechanicsstaticFrame {
  let result = physics_mechanics_static_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_frame_sum(s : PhysicsmechanicsstaticFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_static_frame_mean(s : PhysicsmechanicsstaticFrame) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_static_frame_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_static_frame_scale(s : PhysicsmechanicsstaticFrame, f : Double) -> PhysicsmechanicsstaticFrame {
  let result = physics_mechanics_static_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_static_frame_add(a : PhysicsmechanicsstaticFrame, b : PhysicsmechanicsstaticFrame) -> PhysicsmechanicsstaticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_static_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_static_frame_copy(s : PhysicsmechanicsstaticFrame) -> PhysicsmechanicsstaticFrame {
  let result = physics_mechanics_static_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_static_frame_fill(s : PhysicsmechanicsstaticFrame, v : Double) -> PhysicsmechanicsstaticFrame {
  let result = physics_mechanics_static_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_frame_min(s : PhysicsmechanicsstaticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_frame_max(s : PhysicsmechanicsstaticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_frame_to_string(s : PhysicsmechanicsstaticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_table_make(size : Int) -> PhysicsmechanicsstaticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_table_len(s : PhysicsmechanicsstaticTable) -> Int { s.size }

pub fn physics_mechanics_static_table_get(s : PhysicsmechanicsstaticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_table_set(s : PhysicsmechanicsstaticTable, i : Int, v : Double) -> PhysicsmechanicsstaticTable {
  let result = physics_mechanics_static_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_table_sum(s : PhysicsmechanicsstaticTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_static_table_mean(s : PhysicsmechanicsstaticTable) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_static_table_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_static_table_scale(s : PhysicsmechanicsstaticTable, f : Double) -> PhysicsmechanicsstaticTable {
  let result = physics_mechanics_static_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_static_table_add(a : PhysicsmechanicsstaticTable, b : PhysicsmechanicsstaticTable) -> PhysicsmechanicsstaticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_static_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_static_table_copy(s : PhysicsmechanicsstaticTable) -> PhysicsmechanicsstaticTable {
  let result = physics_mechanics_static_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_static_table_fill(s : PhysicsmechanicsstaticTable, v : Double) -> PhysicsmechanicsstaticTable {
  let result = physics_mechanics_static_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_table_min(s : PhysicsmechanicsstaticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_table_max(s : PhysicsmechanicsstaticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_table_to_string(s : PhysicsmechanicsstaticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_graphn_make(size : Int) -> PhysicsmechanicsstaticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_graphn_len(s : PhysicsmechanicsstaticGraphN) -> Int { s.size }

pub fn physics_mechanics_static_graphn_get(s : PhysicsmechanicsstaticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_graphn_set(s : PhysicsmechanicsstaticGraphN, i : Int, v : Double) -> PhysicsmechanicsstaticGraphN {
  let result = physics_mechanics_static_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_graphn_sum(s : PhysicsmechanicsstaticGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_static_graphn_mean(s : PhysicsmechanicsstaticGraphN) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_static_graphn_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_static_graphn_scale(s : PhysicsmechanicsstaticGraphN, f : Double) -> PhysicsmechanicsstaticGraphN {
  let result = physics_mechanics_static_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_static_graphn_add(a : PhysicsmechanicsstaticGraphN, b : PhysicsmechanicsstaticGraphN) -> PhysicsmechanicsstaticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_static_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_static_graphn_copy(s : PhysicsmechanicsstaticGraphN) -> PhysicsmechanicsstaticGraphN {
  let result = physics_mechanics_static_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_static_graphn_fill(s : PhysicsmechanicsstaticGraphN, v : Double) -> PhysicsmechanicsstaticGraphN {
  let result = physics_mechanics_static_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_graphn_min(s : PhysicsmechanicsstaticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_graphn_max(s : PhysicsmechanicsstaticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_graphn_to_string(s : PhysicsmechanicsstaticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_node_make(size : Int) -> PhysicsmechanicsstaticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_node_len(s : PhysicsmechanicsstaticNode) -> Int { s.size }

pub fn physics_mechanics_static_node_get(s : PhysicsmechanicsstaticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_node_set(s : PhysicsmechanicsstaticNode, i : Int, v : Double) -> PhysicsmechanicsstaticNode {
  let result = physics_mechanics_static_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_node_sum(s : PhysicsmechanicsstaticNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_static_node_mean(s : PhysicsmechanicsstaticNode) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_static_node_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_static_node_scale(s : PhysicsmechanicsstaticNode, f : Double) -> PhysicsmechanicsstaticNode {
  let result = physics_mechanics_static_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_static_node_add(a : PhysicsmechanicsstaticNode, b : PhysicsmechanicsstaticNode) -> PhysicsmechanicsstaticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_static_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_static_node_copy(s : PhysicsmechanicsstaticNode) -> PhysicsmechanicsstaticNode {
  let result = physics_mechanics_static_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_static_node_fill(s : PhysicsmechanicsstaticNode, v : Double) -> PhysicsmechanicsstaticNode {
  let result = physics_mechanics_static_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_node_min(s : PhysicsmechanicsstaticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_node_max(s : PhysicsmechanicsstaticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_node_to_string(s : PhysicsmechanicsstaticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_edge_make(size : Int) -> PhysicsmechanicsstaticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_edge_len(s : PhysicsmechanicsstaticEdge) -> Int { s.size }

pub fn physics_mechanics_static_edge_get(s : PhysicsmechanicsstaticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_edge_set(s : PhysicsmechanicsstaticEdge, i : Int, v : Double) -> PhysicsmechanicsstaticEdge {
  let result = physics_mechanics_static_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_edge_sum(s : PhysicsmechanicsstaticEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_static_edge_mean(s : PhysicsmechanicsstaticEdge) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_static_edge_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_static_edge_scale(s : PhysicsmechanicsstaticEdge, f : Double) -> PhysicsmechanicsstaticEdge {
  let result = physics_mechanics_static_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_static_edge_add(a : PhysicsmechanicsstaticEdge, b : PhysicsmechanicsstaticEdge) -> PhysicsmechanicsstaticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_static_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_static_edge_copy(s : PhysicsmechanicsstaticEdge) -> PhysicsmechanicsstaticEdge {
  let result = physics_mechanics_static_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_static_edge_fill(s : PhysicsmechanicsstaticEdge, v : Double) -> PhysicsmechanicsstaticEdge {
  let result = physics_mechanics_static_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_edge_min(s : PhysicsmechanicsstaticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_edge_max(s : PhysicsmechanicsstaticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_edge_to_string(s : PhysicsmechanicsstaticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_path_make(size : Int) -> PhysicsmechanicsstaticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_path_len(s : PhysicsmechanicsstaticPath) -> Int { s.size }

pub fn physics_mechanics_static_path_get(s : PhysicsmechanicsstaticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_path_set(s : PhysicsmechanicsstaticPath, i : Int, v : Double) -> PhysicsmechanicsstaticPath {
  let result = physics_mechanics_static_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_path_sum(s : PhysicsmechanicsstaticPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_static_path_mean(s : PhysicsmechanicsstaticPath) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_static_path_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_static_path_scale(s : PhysicsmechanicsstaticPath, f : Double) -> PhysicsmechanicsstaticPath {
  let result = physics_mechanics_static_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_static_path_add(a : PhysicsmechanicsstaticPath, b : PhysicsmechanicsstaticPath) -> PhysicsmechanicsstaticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_static_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_static_path_copy(s : PhysicsmechanicsstaticPath) -> PhysicsmechanicsstaticPath {
  let result = physics_mechanics_static_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_static_path_fill(s : PhysicsmechanicsstaticPath, v : Double) -> PhysicsmechanicsstaticPath {
  let result = physics_mechanics_static_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_path_min(s : PhysicsmechanicsstaticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_path_max(s : PhysicsmechanicsstaticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_path_to_string(s : PhysicsmechanicsstaticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_cluster_make(size : Int) -> PhysicsmechanicsstaticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_cluster_len(s : PhysicsmechanicsstaticCluster) -> Int { s.size }

pub fn physics_mechanics_static_cluster_get(s : PhysicsmechanicsstaticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_cluster_set(s : PhysicsmechanicsstaticCluster, i : Int, v : Double) -> PhysicsmechanicsstaticCluster {
  let result = physics_mechanics_static_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_cluster_sum(s : PhysicsmechanicsstaticCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_static_cluster_mean(s : PhysicsmechanicsstaticCluster) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_static_cluster_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_static_cluster_scale(s : PhysicsmechanicsstaticCluster, f : Double) -> PhysicsmechanicsstaticCluster {
  let result = physics_mechanics_static_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_static_cluster_add(a : PhysicsmechanicsstaticCluster, b : PhysicsmechanicsstaticCluster) -> PhysicsmechanicsstaticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_static_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_static_cluster_copy(s : PhysicsmechanicsstaticCluster) -> PhysicsmechanicsstaticCluster {
  let result = physics_mechanics_static_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_static_cluster_fill(s : PhysicsmechanicsstaticCluster, v : Double) -> PhysicsmechanicsstaticCluster {
  let result = physics_mechanics_static_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_cluster_min(s : PhysicsmechanicsstaticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_cluster_max(s : PhysicsmechanicsstaticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_cluster_to_string(s : PhysicsmechanicsstaticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_model_make(size : Int) -> PhysicsmechanicsstaticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_model_len(s : PhysicsmechanicsstaticModel) -> Int { s.size }

pub fn physics_mechanics_static_model_get(s : PhysicsmechanicsstaticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_model_set(s : PhysicsmechanicsstaticModel, i : Int, v : Double) -> PhysicsmechanicsstaticModel {
  let result = physics_mechanics_static_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_model_sum(s : PhysicsmechanicsstaticModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_static_model_mean(s : PhysicsmechanicsstaticModel) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_static_model_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_static_model_scale(s : PhysicsmechanicsstaticModel, f : Double) -> PhysicsmechanicsstaticModel {
  let result = physics_mechanics_static_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_static_model_add(a : PhysicsmechanicsstaticModel, b : PhysicsmechanicsstaticModel) -> PhysicsmechanicsstaticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_static_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_static_model_copy(s : PhysicsmechanicsstaticModel) -> PhysicsmechanicsstaticModel {
  let result = physics_mechanics_static_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_static_model_fill(s : PhysicsmechanicsstaticModel, v : Double) -> PhysicsmechanicsstaticModel {
  let result = physics_mechanics_static_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_model_min(s : PhysicsmechanicsstaticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_model_max(s : PhysicsmechanicsstaticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_model_to_string(s : PhysicsmechanicsstaticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_layer_make(size : Int) -> PhysicsmechanicsstaticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_layer_len(s : PhysicsmechanicsstaticLayer) -> Int { s.size }

pub fn physics_mechanics_static_layer_get(s : PhysicsmechanicsstaticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_layer_set(s : PhysicsmechanicsstaticLayer, i : Int, v : Double) -> PhysicsmechanicsstaticLayer {
  let result = physics_mechanics_static_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_layer_sum(s : PhysicsmechanicsstaticLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_static_layer_mean(s : PhysicsmechanicsstaticLayer) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_static_layer_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_static_layer_scale(s : PhysicsmechanicsstaticLayer, f : Double) -> PhysicsmechanicsstaticLayer {
  let result = physics_mechanics_static_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_static_layer_add(a : PhysicsmechanicsstaticLayer, b : PhysicsmechanicsstaticLayer) -> PhysicsmechanicsstaticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_static_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_static_layer_copy(s : PhysicsmechanicsstaticLayer) -> PhysicsmechanicsstaticLayer {
  let result = physics_mechanics_static_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_static_layer_fill(s : PhysicsmechanicsstaticLayer, v : Double) -> PhysicsmechanicsstaticLayer {
  let result = physics_mechanics_static_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_layer_min(s : PhysicsmechanicsstaticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_layer_max(s : PhysicsmechanicsstaticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_layer_to_string(s : PhysicsmechanicsstaticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_buffer_make(size : Int) -> PhysicsmechanicsstaticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_buffer_len(s : PhysicsmechanicsstaticBuffer) -> Int { s.size }

pub fn physics_mechanics_static_buffer_get(s : PhysicsmechanicsstaticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_buffer_set(s : PhysicsmechanicsstaticBuffer, i : Int, v : Double) -> PhysicsmechanicsstaticBuffer {
  let result = physics_mechanics_static_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_buffer_sum(s : PhysicsmechanicsstaticBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_static_buffer_mean(s : PhysicsmechanicsstaticBuffer) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_static_buffer_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_static_buffer_scale(s : PhysicsmechanicsstaticBuffer, f : Double) -> PhysicsmechanicsstaticBuffer {
  let result = physics_mechanics_static_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_static_buffer_add(a : PhysicsmechanicsstaticBuffer, b : PhysicsmechanicsstaticBuffer) -> PhysicsmechanicsstaticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_static_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_static_buffer_copy(s : PhysicsmechanicsstaticBuffer) -> PhysicsmechanicsstaticBuffer {
  let result = physics_mechanics_static_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_static_buffer_fill(s : PhysicsmechanicsstaticBuffer, v : Double) -> PhysicsmechanicsstaticBuffer {
  let result = physics_mechanics_static_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_buffer_min(s : PhysicsmechanicsstaticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_buffer_max(s : PhysicsmechanicsstaticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_buffer_to_string(s : PhysicsmechanicsstaticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_cursor_make(size : Int) -> PhysicsmechanicsstaticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_cursor_len(s : PhysicsmechanicsstaticCursor) -> Int { s.size }

pub fn physics_mechanics_static_cursor_get(s : PhysicsmechanicsstaticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_cursor_set(s : PhysicsmechanicsstaticCursor, i : Int, v : Double) -> PhysicsmechanicsstaticCursor {
  let result = physics_mechanics_static_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_cursor_sum(s : PhysicsmechanicsstaticCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_static_cursor_mean(s : PhysicsmechanicsstaticCursor) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_static_cursor_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_static_cursor_scale(s : PhysicsmechanicsstaticCursor, f : Double) -> PhysicsmechanicsstaticCursor {
  let result = physics_mechanics_static_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_static_cursor_add(a : PhysicsmechanicsstaticCursor, b : PhysicsmechanicsstaticCursor) -> PhysicsmechanicsstaticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_static_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_static_cursor_copy(s : PhysicsmechanicsstaticCursor) -> PhysicsmechanicsstaticCursor {
  let result = physics_mechanics_static_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_static_cursor_fill(s : PhysicsmechanicsstaticCursor, v : Double) -> PhysicsmechanicsstaticCursor {
  let result = physics_mechanics_static_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_cursor_min(s : PhysicsmechanicsstaticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_cursor_max(s : PhysicsmechanicsstaticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_cursor_to_string(s : PhysicsmechanicsstaticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_view_make(size : Int) -> PhysicsmechanicsstaticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_view_len(s : PhysicsmechanicsstaticView) -> Int { s.size }

pub fn physics_mechanics_static_view_get(s : PhysicsmechanicsstaticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_view_set(s : PhysicsmechanicsstaticView, i : Int, v : Double) -> PhysicsmechanicsstaticView {
  let result = physics_mechanics_static_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_view_sum(s : PhysicsmechanicsstaticView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_static_view_mean(s : PhysicsmechanicsstaticView) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_static_view_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_static_view_scale(s : PhysicsmechanicsstaticView, f : Double) -> PhysicsmechanicsstaticView {
  let result = physics_mechanics_static_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_static_view_add(a : PhysicsmechanicsstaticView, b : PhysicsmechanicsstaticView) -> PhysicsmechanicsstaticView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_static_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_static_view_copy(s : PhysicsmechanicsstaticView) -> PhysicsmechanicsstaticView {
  let result = physics_mechanics_static_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_static_view_fill(s : PhysicsmechanicsstaticView, v : Double) -> PhysicsmechanicsstaticView {
  let result = physics_mechanics_static_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_view_min(s : PhysicsmechanicsstaticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_view_max(s : PhysicsmechanicsstaticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_view_to_string(s : PhysicsmechanicsstaticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_range_make(size : Int) -> PhysicsmechanicsstaticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_range_len(s : PhysicsmechanicsstaticRange) -> Int { s.size }

pub fn physics_mechanics_static_range_get(s : PhysicsmechanicsstaticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_range_set(s : PhysicsmechanicsstaticRange, i : Int, v : Double) -> PhysicsmechanicsstaticRange {
  let result = physics_mechanics_static_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_range_sum(s : PhysicsmechanicsstaticRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_static_range_mean(s : PhysicsmechanicsstaticRange) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_static_range_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_static_range_scale(s : PhysicsmechanicsstaticRange, f : Double) -> PhysicsmechanicsstaticRange {
  let result = physics_mechanics_static_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_static_range_add(a : PhysicsmechanicsstaticRange, b : PhysicsmechanicsstaticRange) -> PhysicsmechanicsstaticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_static_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_static_range_copy(s : PhysicsmechanicsstaticRange) -> PhysicsmechanicsstaticRange {
  let result = physics_mechanics_static_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_static_range_fill(s : PhysicsmechanicsstaticRange, v : Double) -> PhysicsmechanicsstaticRange {
  let result = physics_mechanics_static_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_range_min(s : PhysicsmechanicsstaticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_range_max(s : PhysicsmechanicsstaticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_range_to_string(s : PhysicsmechanicsstaticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct PhysicsmechanicsstaticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn physics_mechanics_static_slice_make(size : Int) -> PhysicsmechanicsstaticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn physics_mechanics_static_slice_len(s : PhysicsmechanicsstaticSlice) -> Int { s.size }

pub fn physics_mechanics_static_slice_get(s : PhysicsmechanicsstaticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn physics_mechanics_static_slice_set(s : PhysicsmechanicsstaticSlice, i : Int, v : Double) -> PhysicsmechanicsstaticSlice {
  let result = physics_mechanics_static_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_slice_sum(s : PhysicsmechanicsstaticSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn physics_mechanics_static_slice_mean(s : PhysicsmechanicsstaticSlice) -> Double {
  if s.size == 0 { 0.0 } else { physics_mechanics_static_slice_sum(s) / s.size.to_double() }
}

pub fn physics_mechanics_static_slice_scale(s : PhysicsmechanicsstaticSlice, f : Double) -> PhysicsmechanicsstaticSlice {
  let result = physics_mechanics_static_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn physics_mechanics_static_slice_add(a : PhysicsmechanicsstaticSlice, b : PhysicsmechanicsstaticSlice) -> PhysicsmechanicsstaticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = physics_mechanics_static_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn physics_mechanics_static_slice_copy(s : PhysicsmechanicsstaticSlice) -> PhysicsmechanicsstaticSlice {
  let result = physics_mechanics_static_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn physics_mechanics_static_slice_fill(s : PhysicsmechanicsstaticSlice, v : Double) -> PhysicsmechanicsstaticSlice {
  let result = physics_mechanics_static_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn physics_mechanics_static_slice_min(s : PhysicsmechanicsstaticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_slice_max(s : PhysicsmechanicsstaticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn physics_mechanics_static_slice_to_string(s : PhysicsmechanicsstaticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

