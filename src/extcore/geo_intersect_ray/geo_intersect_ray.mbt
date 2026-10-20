///===
/// extcore/geo_intersect_ray

pub(all) struct GeointersectrayPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_ray_make_point(x : Double, y : Double) -> GeointersectrayPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_ray_make_point3(x : Double, y : Double, z : Double) -> GeointersectrayPoint {
  { x, y, z, label: 0 }
}

pub fn geo_intersect_ray_point_x(pt : GeointersectrayPoint) -> Double { pt.x }

pub fn geo_intersect_ray_point_y(pt : GeointersectrayPoint) -> Double { pt.y }

pub fn geo_intersect_ray_point_z(pt : GeointersectrayPoint) -> Double { pt.z }

pub fn geo_intersect_ray_point_label(pt : GeointersectrayPoint) -> Int { pt.label }

pub fn geo_intersect_ray_point_dist(a : GeointersectrayPoint, b : GeointersectrayPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_intersect_ray_point_add(a : GeointersectrayPoint, b : GeointersectrayPoint) -> GeointersectrayPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_intersect_ray_point_sub(a : GeointersectrayPoint, b : GeointersectrayPoint) -> GeointersectrayPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_intersect_ray_point_scale(pt : GeointersectrayPoint, s : Double) -> GeointersectrayPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_intersect_ray_point_dot(a : GeointersectrayPoint, b : GeointersectrayPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_intersect_ray_point_cross(a : GeointersectrayPoint, b : GeointersectrayPoint) -> GeointersectrayPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_intersect_ray_point_norm(pt : GeointersectrayPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_intersect_ray_point_normalize(pt : GeointersectrayPoint) -> GeointersectrayPoint {
  let n = geo_intersect_ray_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_intersect_ray_point_scale(pt, 1.0 / n) }
}

pub fn geo_intersect_ray_point_negate(pt : GeointersectrayPoint) -> GeointersectrayPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_intersect_ray_point_mid(a : GeointersectrayPoint, b : GeointersectrayPoint) -> GeointersectrayPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_intersect_ray_point_lerp(a : GeointersectrayPoint, b : GeointersectrayPoint, t : Double) -> GeointersectrayPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_intersect_ray_point_to_string(pt : GeointersectrayPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeointersectraySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_ray_make_series(vals : Array[Double], name : String) -> GeointersectraySeries {
  { vals, name, meta: 0 }
}

pub fn geo_intersect_ray_series_len(s : GeointersectraySeries) -> Int { s.vals.length() }

pub fn geo_intersect_ray_series_sum(s : GeointersectraySeries) -> Double { @_common.sum(s.vals) }

pub fn geo_intersect_ray_series_mean(s : GeointersectraySeries) -> Double { @_common.mean(s.vals) }

pub fn geo_intersect_ray_series_min(s : GeointersectraySeries) -> Double { @_common.min(s.vals) }

pub fn geo_intersect_ray_series_max(s : GeointersectraySeries) -> Double { @_common.max(s.vals) }

pub fn geo_intersect_ray_series_range(s : GeointersectraySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_intersect_ray_series_var(s : GeointersectraySeries) -> Double { @_common.variance(s.vals) }

pub fn geo_intersect_ray_series_std(s : GeointersectraySeries) -> Double { @_common.std(s.vals) }

pub fn geo_intersect_ray_series_median(s : GeointersectraySeries) -> Double { @_common.median(s.vals) }

pub fn geo_intersect_ray_series_scale(s : GeointersectraySeries, f : Double) -> GeointersectraySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_intersect_ray_series_add(a : GeointersectraySeries, b : GeointersectraySeries) -> GeointersectraySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_intersect_ray_series_sub(a : GeointersectraySeries, b : GeointersectraySeries) -> GeointersectraySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_intersect_ray_series_normalize(s : GeointersectraySeries) -> GeointersectraySeries {
  let mn = geo_intersect_ray_series_min(s)
  let mx = geo_intersect_ray_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_intersect_ray_series_cumsum(s : GeointersectraySeries) -> GeointersectraySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_intersect_ray_series_to_string(s : GeointersectraySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectrayMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_ray_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectrayMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_ray_matrix_identity(n : Int) -> GeointersectrayMatrix {
  let m = geo_intersect_ray_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_intersect_ray_matrix_get(m : GeointersectrayMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_intersect_ray_matrix_transpose(m : GeointersectrayMatrix) -> GeointersectrayMatrix {
  let result = geo_intersect_ray_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_intersect_ray_matrix_add(a : GeointersectrayMatrix, b : GeointersectrayMatrix) -> GeointersectrayMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_intersect_ray_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_intersect_ray_matrix_scale(m : GeointersectrayMatrix, s : Double) -> GeointersectrayMatrix {
  let result = geo_intersect_ray_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_intersect_ray_matrix_multiply(a : GeointersectrayMatrix, b : GeointersectrayMatrix) -> GeointersectrayMatrix {
  if a.cols != b.rows { return geo_intersect_ray_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_intersect_ray_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_intersect_ray_matrix_trace(m : GeointersectrayMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_intersect_ray_matrix_det(m : GeointersectrayMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_intersect_ray_matrix_norm(m : GeointersectrayMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_intersect_ray_matrix_to_string(m : GeointersectrayMatrix) -> String {
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

pub(all) struct GeointersectrayVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_ray_make_vector(comps : Array[Double]) -> GeointersectrayVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_ray_vector_zero(dim : Int) -> GeointersectrayVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_intersect_ray_vector_add(a : GeointersectrayVector, b : GeointersectrayVector) -> GeointersectrayVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_ray_vector_sub(a : GeointersectrayVector, b : GeointersectrayVector) -> GeointersectrayVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_ray_vector_scale(v : GeointersectrayVector, s : Double) -> GeointersectrayVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_intersect_ray_vector_dot(a : GeointersectrayVector, b : GeointersectrayVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_intersect_ray_vector_norm(v : GeointersectrayVector) -> Double { @_common.sqrt(geo_intersect_ray_vector_dot(v, v)) }

pub fn geo_intersect_ray_vector_normalize(v : GeointersectrayVector) -> GeointersectrayVector {
  let n = geo_intersect_ray_vector_norm(v)
  if n < 0.0000001 { v } else { geo_intersect_ray_vector_scale(v, 1.0 / n) }
}

pub fn geo_intersect_ray_vector_dist(a : GeointersectrayVector, b : GeointersectrayVector) -> Double {
  geo_intersect_ray_vector_norm(geo_intersect_ray_vector_sub(a, b))
}

pub fn geo_intersect_ray_vector_to_string(v : GeointersectrayVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_ray_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_intersect_ray_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_intersect_ray_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_intersect_ray_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_intersect_ray_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_intersect_ray_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_intersect_ray_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_intersect_ray_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_intersect_ray_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_intersect_ray_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_intersect_ray_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_intersect_ray_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_intersect_ray_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_intersect_ray_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_intersect_ray_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_intersect_ray_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_intersect_ray_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_intersect_ray_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_intersect_ray_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_intersect_ray_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_intersect_ray_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_intersect_ray_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_intersect_ray_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_intersect_ray_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_intersect_ray_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_intersect_ray_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_intersect_ray_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_intersect_ray_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_intersect_ray_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeointersectrayFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_frame_make(size : Int) -> GeointersectrayFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_frame_len(s : GeointersectrayFrame) -> Int { s.size }

pub fn geo_intersect_ray_frame_get(s : GeointersectrayFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_frame_set(s : GeointersectrayFrame, i : Int, v : Double) -> GeointersectrayFrame {
  let result = geo_intersect_ray_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_frame_sum(s : GeointersectrayFrame) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ray_frame_mean(s : GeointersectrayFrame) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ray_frame_scale(s : GeointersectrayFrame, f : Double) -> GeointersectrayFrame {
  let result = geo_intersect_ray_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_frame_add(a : GeointersectrayFrame, b : GeointersectrayFrame) -> GeointersectrayFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_frame_copy(s : GeointersectrayFrame) -> GeointersectrayFrame {
  let result = geo_intersect_ray_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_frame_fill(s : GeointersectrayFrame, v : Double) -> GeointersectrayFrame {
  let result = geo_intersect_ray_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_frame_min(s : GeointersectrayFrame) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ray_frame_max(s : GeointersectrayFrame) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ray_frame_to_string(s : GeointersectrayFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_table_make(size : Int) -> GeointersectrayTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_table_len(s : GeointersectrayTable) -> Int { s.size }

pub fn geo_intersect_ray_table_get(s : GeointersectrayTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_table_set(s : GeointersectrayTable, i : Int, v : Double) -> GeointersectrayTable {
  let result = geo_intersect_ray_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_table_sum(s : GeointersectrayTable) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ray_table_mean(s : GeointersectrayTable) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ray_table_scale(s : GeointersectrayTable, f : Double) -> GeointersectrayTable {
  let result = geo_intersect_ray_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_table_add(a : GeointersectrayTable, b : GeointersectrayTable) -> GeointersectrayTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_table_copy(s : GeointersectrayTable) -> GeointersectrayTable {
  let result = geo_intersect_ray_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_table_fill(s : GeointersectrayTable, v : Double) -> GeointersectrayTable {
  let result = geo_intersect_ray_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_table_min(s : GeointersectrayTable) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ray_table_max(s : GeointersectrayTable) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ray_table_to_string(s : GeointersectrayTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_graphn_make(size : Int) -> GeointersectrayGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_graphn_len(s : GeointersectrayGraphN) -> Int { s.size }

pub fn geo_intersect_ray_graphn_get(s : GeointersectrayGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_graphn_set(s : GeointersectrayGraphN, i : Int, v : Double) -> GeointersectrayGraphN {
  let result = geo_intersect_ray_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_graphn_sum(s : GeointersectrayGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ray_graphn_mean(s : GeointersectrayGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ray_graphn_scale(s : GeointersectrayGraphN, f : Double) -> GeointersectrayGraphN {
  let result = geo_intersect_ray_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_graphn_add(a : GeointersectrayGraphN, b : GeointersectrayGraphN) -> GeointersectrayGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_graphn_copy(s : GeointersectrayGraphN) -> GeointersectrayGraphN {
  let result = geo_intersect_ray_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_graphn_fill(s : GeointersectrayGraphN, v : Double) -> GeointersectrayGraphN {
  let result = geo_intersect_ray_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_graphn_min(s : GeointersectrayGraphN) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ray_graphn_max(s : GeointersectrayGraphN) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ray_graphn_to_string(s : GeointersectrayGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_node_make(size : Int) -> GeointersectrayNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_node_len(s : GeointersectrayNode) -> Int { s.size }

pub fn geo_intersect_ray_node_get(s : GeointersectrayNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_node_set(s : GeointersectrayNode, i : Int, v : Double) -> GeointersectrayNode {
  let result = geo_intersect_ray_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_node_sum(s : GeointersectrayNode) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ray_node_mean(s : GeointersectrayNode) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ray_node_scale(s : GeointersectrayNode, f : Double) -> GeointersectrayNode {
  let result = geo_intersect_ray_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_node_add(a : GeointersectrayNode, b : GeointersectrayNode) -> GeointersectrayNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_node_copy(s : GeointersectrayNode) -> GeointersectrayNode {
  let result = geo_intersect_ray_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_node_fill(s : GeointersectrayNode, v : Double) -> GeointersectrayNode {
  let result = geo_intersect_ray_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_node_min(s : GeointersectrayNode) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ray_node_max(s : GeointersectrayNode) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ray_node_to_string(s : GeointersectrayNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_edge_make(size : Int) -> GeointersectrayEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_edge_len(s : GeointersectrayEdge) -> Int { s.size }

pub fn geo_intersect_ray_edge_get(s : GeointersectrayEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_edge_set(s : GeointersectrayEdge, i : Int, v : Double) -> GeointersectrayEdge {
  let result = geo_intersect_ray_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_edge_sum(s : GeointersectrayEdge) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ray_edge_mean(s : GeointersectrayEdge) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ray_edge_scale(s : GeointersectrayEdge, f : Double) -> GeointersectrayEdge {
  let result = geo_intersect_ray_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_edge_add(a : GeointersectrayEdge, b : GeointersectrayEdge) -> GeointersectrayEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_edge_copy(s : GeointersectrayEdge) -> GeointersectrayEdge {
  let result = geo_intersect_ray_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_edge_fill(s : GeointersectrayEdge, v : Double) -> GeointersectrayEdge {
  let result = geo_intersect_ray_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_edge_min(s : GeointersectrayEdge) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ray_edge_max(s : GeointersectrayEdge) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ray_edge_to_string(s : GeointersectrayEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_path_make(size : Int) -> GeointersectrayPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_path_len(s : GeointersectrayPath) -> Int { s.size }

pub fn geo_intersect_ray_path_get(s : GeointersectrayPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_path_set(s : GeointersectrayPath, i : Int, v : Double) -> GeointersectrayPath {
  let result = geo_intersect_ray_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_path_sum(s : GeointersectrayPath) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ray_path_mean(s : GeointersectrayPath) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ray_path_scale(s : GeointersectrayPath, f : Double) -> GeointersectrayPath {
  let result = geo_intersect_ray_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_path_add(a : GeointersectrayPath, b : GeointersectrayPath) -> GeointersectrayPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_path_copy(s : GeointersectrayPath) -> GeointersectrayPath {
  let result = geo_intersect_ray_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_path_fill(s : GeointersectrayPath, v : Double) -> GeointersectrayPath {
  let result = geo_intersect_ray_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_path_min(s : GeointersectrayPath) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ray_path_max(s : GeointersectrayPath) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ray_path_to_string(s : GeointersectrayPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_cluster_make(size : Int) -> GeointersectrayCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_cluster_len(s : GeointersectrayCluster) -> Int { s.size }

pub fn geo_intersect_ray_cluster_get(s : GeointersectrayCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_cluster_set(s : GeointersectrayCluster, i : Int, v : Double) -> GeointersectrayCluster {
  let result = geo_intersect_ray_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_cluster_sum(s : GeointersectrayCluster) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ray_cluster_mean(s : GeointersectrayCluster) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ray_cluster_scale(s : GeointersectrayCluster, f : Double) -> GeointersectrayCluster {
  let result = geo_intersect_ray_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_cluster_add(a : GeointersectrayCluster, b : GeointersectrayCluster) -> GeointersectrayCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_cluster_copy(s : GeointersectrayCluster) -> GeointersectrayCluster {
  let result = geo_intersect_ray_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_cluster_fill(s : GeointersectrayCluster, v : Double) -> GeointersectrayCluster {
  let result = geo_intersect_ray_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_cluster_min(s : GeointersectrayCluster) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ray_cluster_max(s : GeointersectrayCluster) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ray_cluster_to_string(s : GeointersectrayCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_model_make(size : Int) -> GeointersectrayModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_model_len(s : GeointersectrayModel) -> Int { s.size }

pub fn geo_intersect_ray_model_get(s : GeointersectrayModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_model_set(s : GeointersectrayModel, i : Int, v : Double) -> GeointersectrayModel {
  let result = geo_intersect_ray_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_model_sum(s : GeointersectrayModel) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ray_model_mean(s : GeointersectrayModel) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ray_model_scale(s : GeointersectrayModel, f : Double) -> GeointersectrayModel {
  let result = geo_intersect_ray_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_model_add(a : GeointersectrayModel, b : GeointersectrayModel) -> GeointersectrayModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_model_copy(s : GeointersectrayModel) -> GeointersectrayModel {
  let result = geo_intersect_ray_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_model_fill(s : GeointersectrayModel, v : Double) -> GeointersectrayModel {
  let result = geo_intersect_ray_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_model_min(s : GeointersectrayModel) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ray_model_max(s : GeointersectrayModel) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ray_model_to_string(s : GeointersectrayModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_layer_make(size : Int) -> GeointersectrayLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_layer_len(s : GeointersectrayLayer) -> Int { s.size }

pub fn geo_intersect_ray_layer_get(s : GeointersectrayLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_layer_set(s : GeointersectrayLayer, i : Int, v : Double) -> GeointersectrayLayer {
  let result = geo_intersect_ray_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_layer_sum(s : GeointersectrayLayer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ray_layer_mean(s : GeointersectrayLayer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ray_layer_scale(s : GeointersectrayLayer, f : Double) -> GeointersectrayLayer {
  let result = geo_intersect_ray_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_layer_add(a : GeointersectrayLayer, b : GeointersectrayLayer) -> GeointersectrayLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_layer_copy(s : GeointersectrayLayer) -> GeointersectrayLayer {
  let result = geo_intersect_ray_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_layer_fill(s : GeointersectrayLayer, v : Double) -> GeointersectrayLayer {
  let result = geo_intersect_ray_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_layer_min(s : GeointersectrayLayer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ray_layer_max(s : GeointersectrayLayer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ray_layer_to_string(s : GeointersectrayLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_buffer_make(size : Int) -> GeointersectrayBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_buffer_len(s : GeointersectrayBuffer) -> Int { s.size }

pub fn geo_intersect_ray_buffer_get(s : GeointersectrayBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_buffer_set(s : GeointersectrayBuffer, i : Int, v : Double) -> GeointersectrayBuffer {
  let result = geo_intersect_ray_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_buffer_sum(s : GeointersectrayBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ray_buffer_mean(s : GeointersectrayBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ray_buffer_scale(s : GeointersectrayBuffer, f : Double) -> GeointersectrayBuffer {
  let result = geo_intersect_ray_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_buffer_add(a : GeointersectrayBuffer, b : GeointersectrayBuffer) -> GeointersectrayBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_buffer_copy(s : GeointersectrayBuffer) -> GeointersectrayBuffer {
  let result = geo_intersect_ray_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_buffer_fill(s : GeointersectrayBuffer, v : Double) -> GeointersectrayBuffer {
  let result = geo_intersect_ray_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_buffer_min(s : GeointersectrayBuffer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ray_buffer_max(s : GeointersectrayBuffer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ray_buffer_to_string(s : GeointersectrayBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_cursor_make(size : Int) -> GeointersectrayCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_cursor_len(s : GeointersectrayCursor) -> Int { s.size }

pub fn geo_intersect_ray_cursor_get(s : GeointersectrayCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_cursor_set(s : GeointersectrayCursor, i : Int, v : Double) -> GeointersectrayCursor {
  let result = geo_intersect_ray_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_cursor_sum(s : GeointersectrayCursor) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ray_cursor_mean(s : GeointersectrayCursor) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ray_cursor_scale(s : GeointersectrayCursor, f : Double) -> GeointersectrayCursor {
  let result = geo_intersect_ray_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_cursor_add(a : GeointersectrayCursor, b : GeointersectrayCursor) -> GeointersectrayCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_cursor_copy(s : GeointersectrayCursor) -> GeointersectrayCursor {
  let result = geo_intersect_ray_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_cursor_fill(s : GeointersectrayCursor, v : Double) -> GeointersectrayCursor {
  let result = geo_intersect_ray_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_cursor_min(s : GeointersectrayCursor) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ray_cursor_max(s : GeointersectrayCursor) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ray_cursor_to_string(s : GeointersectrayCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_view_make(size : Int) -> GeointersectrayView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_view_len(s : GeointersectrayView) -> Int { s.size }

pub fn geo_intersect_ray_view_get(s : GeointersectrayView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_view_set(s : GeointersectrayView, i : Int, v : Double) -> GeointersectrayView {
  let result = geo_intersect_ray_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_view_sum(s : GeointersectrayView) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ray_view_mean(s : GeointersectrayView) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ray_view_scale(s : GeointersectrayView, f : Double) -> GeointersectrayView {
  let result = geo_intersect_ray_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_view_add(a : GeointersectrayView, b : GeointersectrayView) -> GeointersectrayView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_view_copy(s : GeointersectrayView) -> GeointersectrayView {
  let result = geo_intersect_ray_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_view_fill(s : GeointersectrayView, v : Double) -> GeointersectrayView {
  let result = geo_intersect_ray_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_view_min(s : GeointersectrayView) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ray_view_max(s : GeointersectrayView) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ray_view_to_string(s : GeointersectrayView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectrayRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_range_make(size : Int) -> GeointersectrayRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_range_len(s : GeointersectrayRange) -> Int { s.size }

pub fn geo_intersect_ray_range_get(s : GeointersectrayRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_range_set(s : GeointersectrayRange, i : Int, v : Double) -> GeointersectrayRange {
  let result = geo_intersect_ray_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_range_sum(s : GeointersectrayRange) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ray_range_mean(s : GeointersectrayRange) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ray_range_scale(s : GeointersectrayRange, f : Double) -> GeointersectrayRange {
  let result = geo_intersect_ray_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_range_add(a : GeointersectrayRange, b : GeointersectrayRange) -> GeointersectrayRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_range_copy(s : GeointersectrayRange) -> GeointersectrayRange {
  let result = geo_intersect_ray_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_range_fill(s : GeointersectrayRange, v : Double) -> GeointersectrayRange {
  let result = geo_intersect_ray_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_range_min(s : GeointersectrayRange) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ray_range_max(s : GeointersectrayRange) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ray_range_to_string(s : GeointersectrayRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectraySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ray_slice_make(size : Int) -> GeointersectraySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ray_slice_len(s : GeointersectraySlice) -> Int { s.size }

pub fn geo_intersect_ray_slice_get(s : GeointersectraySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ray_slice_set(s : GeointersectraySlice, i : Int, v : Double) -> GeointersectraySlice {
  let result = geo_intersect_ray_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_slice_sum(s : GeointersectraySlice) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ray_slice_mean(s : GeointersectraySlice) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ray_slice_scale(s : GeointersectraySlice, f : Double) -> GeointersectraySlice {
  let result = geo_intersect_ray_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_ray_slice_add(a : GeointersectraySlice, b : GeointersectraySlice) -> GeointersectraySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_ray_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_ray_slice_copy(s : GeointersectraySlice) -> GeointersectraySlice {
  let result = geo_intersect_ray_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_ray_slice_fill(s : GeointersectraySlice, v : Double) -> GeointersectraySlice {
  let result = geo_intersect_ray_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_ray_slice_min(s : GeointersectraySlice) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ray_slice_max(s : GeointersectraySlice) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ray_slice_to_string(s : GeointersectraySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

