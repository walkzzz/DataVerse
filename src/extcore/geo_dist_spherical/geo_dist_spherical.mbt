///===
/// extcore/geo_dist_spherical

pub(all) struct GeodistsphericalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_spherical_make_point(x : Double, y : Double) -> GeodistsphericalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_spherical_make_point3(x : Double, y : Double, z : Double) -> GeodistsphericalPoint {
  { x, y, z, label: 0 }
}

pub fn geo_dist_spherical_point_x(pt : GeodistsphericalPoint) -> Double { pt.x }

pub fn geo_dist_spherical_point_y(pt : GeodistsphericalPoint) -> Double { pt.y }

pub fn geo_dist_spherical_point_z(pt : GeodistsphericalPoint) -> Double { pt.z }

pub fn geo_dist_spherical_point_label(pt : GeodistsphericalPoint) -> Int { pt.label }

pub fn geo_dist_spherical_point_dist(a : GeodistsphericalPoint, b : GeodistsphericalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_dist_spherical_point_add(a : GeodistsphericalPoint, b : GeodistsphericalPoint) -> GeodistsphericalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_dist_spherical_point_sub(a : GeodistsphericalPoint, b : GeodistsphericalPoint) -> GeodistsphericalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_dist_spherical_point_scale(pt : GeodistsphericalPoint, s : Double) -> GeodistsphericalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_dist_spherical_point_dot(a : GeodistsphericalPoint, b : GeodistsphericalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_dist_spherical_point_cross(a : GeodistsphericalPoint, b : GeodistsphericalPoint) -> GeodistsphericalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_dist_spherical_point_norm(pt : GeodistsphericalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_dist_spherical_point_normalize(pt : GeodistsphericalPoint) -> GeodistsphericalPoint {
  let n = geo_dist_spherical_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_dist_spherical_point_scale(pt, 1.0 / n) }
}

pub fn geo_dist_spherical_point_negate(pt : GeodistsphericalPoint) -> GeodistsphericalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_dist_spherical_point_mid(a : GeodistsphericalPoint, b : GeodistsphericalPoint) -> GeodistsphericalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_dist_spherical_point_lerp(a : GeodistsphericalPoint, b : GeodistsphericalPoint, t : Double) -> GeodistsphericalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_dist_spherical_point_to_string(pt : GeodistsphericalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeodistsphericalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_spherical_make_series(vals : Array[Double], name : String) -> GeodistsphericalSeries {
  { vals, name, meta: 0 }
}

pub fn geo_dist_spherical_series_len(s : GeodistsphericalSeries) -> Int { s.vals.length() }

pub fn geo_dist_spherical_series_sum(s : GeodistsphericalSeries) -> Double { @_common.sum(s.vals) }

pub fn geo_dist_spherical_series_mean(s : GeodistsphericalSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_dist_spherical_series_min(s : GeodistsphericalSeries) -> Double { @_common.min(s.vals) }

pub fn geo_dist_spherical_series_max(s : GeodistsphericalSeries) -> Double { @_common.max(s.vals) }

pub fn geo_dist_spherical_series_range(s : GeodistsphericalSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_dist_spherical_series_var(s : GeodistsphericalSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_dist_spherical_series_std(s : GeodistsphericalSeries) -> Double { @_common.std(s.vals) }

pub fn geo_dist_spherical_series_median(s : GeodistsphericalSeries) -> Double { @_common.median(s.vals) }

pub fn geo_dist_spherical_series_scale(s : GeodistsphericalSeries, f : Double) -> GeodistsphericalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_dist_spherical_series_add(a : GeodistsphericalSeries, b : GeodistsphericalSeries) -> GeodistsphericalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_dist_spherical_series_sub(a : GeodistsphericalSeries, b : GeodistsphericalSeries) -> GeodistsphericalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_dist_spherical_series_normalize(s : GeodistsphericalSeries) -> GeodistsphericalSeries {
  let mn = geo_dist_spherical_series_min(s)
  let mx = geo_dist_spherical_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_dist_spherical_series_cumsum(s : GeodistsphericalSeries) -> GeodistsphericalSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_dist_spherical_series_to_string(s : GeodistsphericalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistsphericalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_spherical_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistsphericalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_spherical_matrix_identity(n : Int) -> GeodistsphericalMatrix {
  let m = geo_dist_spherical_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_dist_spherical_matrix_get(m : GeodistsphericalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_dist_spherical_matrix_transpose(m : GeodistsphericalMatrix) -> GeodistsphericalMatrix {
  let result = geo_dist_spherical_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_dist_spherical_matrix_add(a : GeodistsphericalMatrix, b : GeodistsphericalMatrix) -> GeodistsphericalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_dist_spherical_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_dist_spherical_matrix_scale(m : GeodistsphericalMatrix, s : Double) -> GeodistsphericalMatrix {
  let result = geo_dist_spherical_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_dist_spherical_matrix_multiply(a : GeodistsphericalMatrix, b : GeodistsphericalMatrix) -> GeodistsphericalMatrix {
  if a.cols != b.rows { return geo_dist_spherical_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_dist_spherical_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_dist_spherical_matrix_trace(m : GeodistsphericalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_dist_spherical_matrix_det(m : GeodistsphericalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_dist_spherical_matrix_norm(m : GeodistsphericalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_dist_spherical_matrix_to_string(m : GeodistsphericalMatrix) -> String {
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

pub(all) struct GeodistsphericalVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_spherical_make_vector(comps : Array[Double]) -> GeodistsphericalVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_spherical_vector_zero(dim : Int) -> GeodistsphericalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_dist_spherical_vector_add(a : GeodistsphericalVector, b : GeodistsphericalVector) -> GeodistsphericalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_spherical_vector_sub(a : GeodistsphericalVector, b : GeodistsphericalVector) -> GeodistsphericalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_spherical_vector_scale(v : GeodistsphericalVector, s : Double) -> GeodistsphericalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_dist_spherical_vector_dot(a : GeodistsphericalVector, b : GeodistsphericalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_dist_spherical_vector_norm(v : GeodistsphericalVector) -> Double { @_common.sqrt(geo_dist_spherical_vector_dot(v, v)) }

pub fn geo_dist_spherical_vector_normalize(v : GeodistsphericalVector) -> GeodistsphericalVector {
  let n = geo_dist_spherical_vector_norm(v)
  if n < 0.0000001 { v } else { geo_dist_spherical_vector_scale(v, 1.0 / n) }
}

pub fn geo_dist_spherical_vector_dist(a : GeodistsphericalVector, b : GeodistsphericalVector) -> Double {
  geo_dist_spherical_vector_norm(geo_dist_spherical_vector_sub(a, b))
}

pub fn geo_dist_spherical_vector_to_string(v : GeodistsphericalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_spherical_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_dist_spherical_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_dist_spherical_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_dist_spherical_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_dist_spherical_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_dist_spherical_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_dist_spherical_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_dist_spherical_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_dist_spherical_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_dist_spherical_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_dist_spherical_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_dist_spherical_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_dist_spherical_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_dist_spherical_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_dist_spherical_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_dist_spherical_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_dist_spherical_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_dist_spherical_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_dist_spherical_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_dist_spherical_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_dist_spherical_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_dist_spherical_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_dist_spherical_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_dist_spherical_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_dist_spherical_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_dist_spherical_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_dist_spherical_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_dist_spherical_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_dist_spherical_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeodistsphericalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_frame_make(size : Int) -> GeodistsphericalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_frame_len(s : GeodistsphericalFrame) -> Int { s.size }

pub fn geo_dist_spherical_frame_get(s : GeodistsphericalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_frame_set(s : GeodistsphericalFrame, i : Int, v : Double) -> GeodistsphericalFrame {
  let result = geo_dist_spherical_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_frame_sum(s : GeodistsphericalFrame) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_frame_mean(s : GeodistsphericalFrame) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_frame_scale(s : GeodistsphericalFrame, f : Double) -> GeodistsphericalFrame {
  let result = geo_dist_spherical_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_frame_add(a : GeodistsphericalFrame, b : GeodistsphericalFrame) -> GeodistsphericalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_frame_copy(s : GeodistsphericalFrame) -> GeodistsphericalFrame {
  let result = geo_dist_spherical_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_frame_fill(s : GeodistsphericalFrame, v : Double) -> GeodistsphericalFrame {
  let result = geo_dist_spherical_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_frame_min(s : GeodistsphericalFrame) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_frame_max(s : GeodistsphericalFrame) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_frame_to_string(s : GeodistsphericalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_table_make(size : Int) -> GeodistsphericalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_table_len(s : GeodistsphericalTable) -> Int { s.size }

pub fn geo_dist_spherical_table_get(s : GeodistsphericalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_table_set(s : GeodistsphericalTable, i : Int, v : Double) -> GeodistsphericalTable {
  let result = geo_dist_spherical_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_table_sum(s : GeodistsphericalTable) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_table_mean(s : GeodistsphericalTable) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_table_scale(s : GeodistsphericalTable, f : Double) -> GeodistsphericalTable {
  let result = geo_dist_spherical_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_table_add(a : GeodistsphericalTable, b : GeodistsphericalTable) -> GeodistsphericalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_table_copy(s : GeodistsphericalTable) -> GeodistsphericalTable {
  let result = geo_dist_spherical_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_table_fill(s : GeodistsphericalTable, v : Double) -> GeodistsphericalTable {
  let result = geo_dist_spherical_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_table_min(s : GeodistsphericalTable) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_table_max(s : GeodistsphericalTable) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_table_to_string(s : GeodistsphericalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_graphn_make(size : Int) -> GeodistsphericalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_graphn_len(s : GeodistsphericalGraphN) -> Int { s.size }

pub fn geo_dist_spherical_graphn_get(s : GeodistsphericalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_graphn_set(s : GeodistsphericalGraphN, i : Int, v : Double) -> GeodistsphericalGraphN {
  let result = geo_dist_spherical_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_graphn_sum(s : GeodistsphericalGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_graphn_mean(s : GeodistsphericalGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_graphn_scale(s : GeodistsphericalGraphN, f : Double) -> GeodistsphericalGraphN {
  let result = geo_dist_spherical_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_graphn_add(a : GeodistsphericalGraphN, b : GeodistsphericalGraphN) -> GeodistsphericalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_graphn_copy(s : GeodistsphericalGraphN) -> GeodistsphericalGraphN {
  let result = geo_dist_spherical_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_graphn_fill(s : GeodistsphericalGraphN, v : Double) -> GeodistsphericalGraphN {
  let result = geo_dist_spherical_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_graphn_min(s : GeodistsphericalGraphN) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_graphn_max(s : GeodistsphericalGraphN) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_graphn_to_string(s : GeodistsphericalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_node_make(size : Int) -> GeodistsphericalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_node_len(s : GeodistsphericalNode) -> Int { s.size }

pub fn geo_dist_spherical_node_get(s : GeodistsphericalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_node_set(s : GeodistsphericalNode, i : Int, v : Double) -> GeodistsphericalNode {
  let result = geo_dist_spherical_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_node_sum(s : GeodistsphericalNode) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_node_mean(s : GeodistsphericalNode) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_node_scale(s : GeodistsphericalNode, f : Double) -> GeodistsphericalNode {
  let result = geo_dist_spherical_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_node_add(a : GeodistsphericalNode, b : GeodistsphericalNode) -> GeodistsphericalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_node_copy(s : GeodistsphericalNode) -> GeodistsphericalNode {
  let result = geo_dist_spherical_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_node_fill(s : GeodistsphericalNode, v : Double) -> GeodistsphericalNode {
  let result = geo_dist_spherical_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_node_min(s : GeodistsphericalNode) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_node_max(s : GeodistsphericalNode) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_node_to_string(s : GeodistsphericalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_edge_make(size : Int) -> GeodistsphericalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_edge_len(s : GeodistsphericalEdge) -> Int { s.size }

pub fn geo_dist_spherical_edge_get(s : GeodistsphericalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_edge_set(s : GeodistsphericalEdge, i : Int, v : Double) -> GeodistsphericalEdge {
  let result = geo_dist_spherical_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_edge_sum(s : GeodistsphericalEdge) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_edge_mean(s : GeodistsphericalEdge) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_edge_scale(s : GeodistsphericalEdge, f : Double) -> GeodistsphericalEdge {
  let result = geo_dist_spherical_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_edge_add(a : GeodistsphericalEdge, b : GeodistsphericalEdge) -> GeodistsphericalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_edge_copy(s : GeodistsphericalEdge) -> GeodistsphericalEdge {
  let result = geo_dist_spherical_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_edge_fill(s : GeodistsphericalEdge, v : Double) -> GeodistsphericalEdge {
  let result = geo_dist_spherical_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_edge_min(s : GeodistsphericalEdge) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_edge_max(s : GeodistsphericalEdge) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_edge_to_string(s : GeodistsphericalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_path_make(size : Int) -> GeodistsphericalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_path_len(s : GeodistsphericalPath) -> Int { s.size }

pub fn geo_dist_spherical_path_get(s : GeodistsphericalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_path_set(s : GeodistsphericalPath, i : Int, v : Double) -> GeodistsphericalPath {
  let result = geo_dist_spherical_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_path_sum(s : GeodistsphericalPath) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_path_mean(s : GeodistsphericalPath) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_path_scale(s : GeodistsphericalPath, f : Double) -> GeodistsphericalPath {
  let result = geo_dist_spherical_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_path_add(a : GeodistsphericalPath, b : GeodistsphericalPath) -> GeodistsphericalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_path_copy(s : GeodistsphericalPath) -> GeodistsphericalPath {
  let result = geo_dist_spherical_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_path_fill(s : GeodistsphericalPath, v : Double) -> GeodistsphericalPath {
  let result = geo_dist_spherical_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_path_min(s : GeodistsphericalPath) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_path_max(s : GeodistsphericalPath) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_path_to_string(s : GeodistsphericalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_cluster_make(size : Int) -> GeodistsphericalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_cluster_len(s : GeodistsphericalCluster) -> Int { s.size }

pub fn geo_dist_spherical_cluster_get(s : GeodistsphericalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_cluster_set(s : GeodistsphericalCluster, i : Int, v : Double) -> GeodistsphericalCluster {
  let result = geo_dist_spherical_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_cluster_sum(s : GeodistsphericalCluster) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_cluster_mean(s : GeodistsphericalCluster) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_cluster_scale(s : GeodistsphericalCluster, f : Double) -> GeodistsphericalCluster {
  let result = geo_dist_spherical_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_cluster_add(a : GeodistsphericalCluster, b : GeodistsphericalCluster) -> GeodistsphericalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_cluster_copy(s : GeodistsphericalCluster) -> GeodistsphericalCluster {
  let result = geo_dist_spherical_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_cluster_fill(s : GeodistsphericalCluster, v : Double) -> GeodistsphericalCluster {
  let result = geo_dist_spherical_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_cluster_min(s : GeodistsphericalCluster) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_cluster_max(s : GeodistsphericalCluster) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_cluster_to_string(s : GeodistsphericalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_model_make(size : Int) -> GeodistsphericalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_model_len(s : GeodistsphericalModel) -> Int { s.size }

pub fn geo_dist_spherical_model_get(s : GeodistsphericalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_model_set(s : GeodistsphericalModel, i : Int, v : Double) -> GeodistsphericalModel {
  let result = geo_dist_spherical_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_model_sum(s : GeodistsphericalModel) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_model_mean(s : GeodistsphericalModel) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_model_scale(s : GeodistsphericalModel, f : Double) -> GeodistsphericalModel {
  let result = geo_dist_spherical_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_model_add(a : GeodistsphericalModel, b : GeodistsphericalModel) -> GeodistsphericalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_model_copy(s : GeodistsphericalModel) -> GeodistsphericalModel {
  let result = geo_dist_spherical_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_model_fill(s : GeodistsphericalModel, v : Double) -> GeodistsphericalModel {
  let result = geo_dist_spherical_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_model_min(s : GeodistsphericalModel) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_model_max(s : GeodistsphericalModel) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_model_to_string(s : GeodistsphericalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_layer_make(size : Int) -> GeodistsphericalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_layer_len(s : GeodistsphericalLayer) -> Int { s.size }

pub fn geo_dist_spherical_layer_get(s : GeodistsphericalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_layer_set(s : GeodistsphericalLayer, i : Int, v : Double) -> GeodistsphericalLayer {
  let result = geo_dist_spherical_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_layer_sum(s : GeodistsphericalLayer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_layer_mean(s : GeodistsphericalLayer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_layer_scale(s : GeodistsphericalLayer, f : Double) -> GeodistsphericalLayer {
  let result = geo_dist_spherical_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_layer_add(a : GeodistsphericalLayer, b : GeodistsphericalLayer) -> GeodistsphericalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_layer_copy(s : GeodistsphericalLayer) -> GeodistsphericalLayer {
  let result = geo_dist_spherical_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_layer_fill(s : GeodistsphericalLayer, v : Double) -> GeodistsphericalLayer {
  let result = geo_dist_spherical_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_layer_min(s : GeodistsphericalLayer) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_layer_max(s : GeodistsphericalLayer) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_layer_to_string(s : GeodistsphericalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_buffer_make(size : Int) -> GeodistsphericalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_buffer_len(s : GeodistsphericalBuffer) -> Int { s.size }

pub fn geo_dist_spherical_buffer_get(s : GeodistsphericalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_buffer_set(s : GeodistsphericalBuffer, i : Int, v : Double) -> GeodistsphericalBuffer {
  let result = geo_dist_spherical_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_buffer_sum(s : GeodistsphericalBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_buffer_mean(s : GeodistsphericalBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_buffer_scale(s : GeodistsphericalBuffer, f : Double) -> GeodistsphericalBuffer {
  let result = geo_dist_spherical_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_buffer_add(a : GeodistsphericalBuffer, b : GeodistsphericalBuffer) -> GeodistsphericalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_buffer_copy(s : GeodistsphericalBuffer) -> GeodistsphericalBuffer {
  let result = geo_dist_spherical_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_buffer_fill(s : GeodistsphericalBuffer, v : Double) -> GeodistsphericalBuffer {
  let result = geo_dist_spherical_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_buffer_min(s : GeodistsphericalBuffer) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_buffer_max(s : GeodistsphericalBuffer) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_buffer_to_string(s : GeodistsphericalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_cursor_make(size : Int) -> GeodistsphericalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_cursor_len(s : GeodistsphericalCursor) -> Int { s.size }

pub fn geo_dist_spherical_cursor_get(s : GeodistsphericalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_cursor_set(s : GeodistsphericalCursor, i : Int, v : Double) -> GeodistsphericalCursor {
  let result = geo_dist_spherical_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_cursor_sum(s : GeodistsphericalCursor) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_cursor_mean(s : GeodistsphericalCursor) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_cursor_scale(s : GeodistsphericalCursor, f : Double) -> GeodistsphericalCursor {
  let result = geo_dist_spherical_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_cursor_add(a : GeodistsphericalCursor, b : GeodistsphericalCursor) -> GeodistsphericalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_cursor_copy(s : GeodistsphericalCursor) -> GeodistsphericalCursor {
  let result = geo_dist_spherical_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_cursor_fill(s : GeodistsphericalCursor, v : Double) -> GeodistsphericalCursor {
  let result = geo_dist_spherical_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_cursor_min(s : GeodistsphericalCursor) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_cursor_max(s : GeodistsphericalCursor) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_cursor_to_string(s : GeodistsphericalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_view_make(size : Int) -> GeodistsphericalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_view_len(s : GeodistsphericalView) -> Int { s.size }

pub fn geo_dist_spherical_view_get(s : GeodistsphericalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_view_set(s : GeodistsphericalView, i : Int, v : Double) -> GeodistsphericalView {
  let result = geo_dist_spherical_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_view_sum(s : GeodistsphericalView) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_view_mean(s : GeodistsphericalView) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_view_scale(s : GeodistsphericalView, f : Double) -> GeodistsphericalView {
  let result = geo_dist_spherical_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_view_add(a : GeodistsphericalView, b : GeodistsphericalView) -> GeodistsphericalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_view_copy(s : GeodistsphericalView) -> GeodistsphericalView {
  let result = geo_dist_spherical_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_view_fill(s : GeodistsphericalView, v : Double) -> GeodistsphericalView {
  let result = geo_dist_spherical_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_view_min(s : GeodistsphericalView) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_view_max(s : GeodistsphericalView) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_view_to_string(s : GeodistsphericalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_range_make(size : Int) -> GeodistsphericalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_range_len(s : GeodistsphericalRange) -> Int { s.size }

pub fn geo_dist_spherical_range_get(s : GeodistsphericalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_range_set(s : GeodistsphericalRange, i : Int, v : Double) -> GeodistsphericalRange {
  let result = geo_dist_spherical_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_range_sum(s : GeodistsphericalRange) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_range_mean(s : GeodistsphericalRange) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_range_scale(s : GeodistsphericalRange, f : Double) -> GeodistsphericalRange {
  let result = geo_dist_spherical_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_range_add(a : GeodistsphericalRange, b : GeodistsphericalRange) -> GeodistsphericalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_range_copy(s : GeodistsphericalRange) -> GeodistsphericalRange {
  let result = geo_dist_spherical_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_range_fill(s : GeodistsphericalRange, v : Double) -> GeodistsphericalRange {
  let result = geo_dist_spherical_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_range_min(s : GeodistsphericalRange) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_range_max(s : GeodistsphericalRange) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_range_to_string(s : GeodistsphericalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_slice_make(size : Int) -> GeodistsphericalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_slice_len(s : GeodistsphericalSlice) -> Int { s.size }

pub fn geo_dist_spherical_slice_get(s : GeodistsphericalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_slice_set(s : GeodistsphericalSlice, i : Int, v : Double) -> GeodistsphericalSlice {
  let result = geo_dist_spherical_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_slice_sum(s : GeodistsphericalSlice) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_slice_mean(s : GeodistsphericalSlice) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_slice_scale(s : GeodistsphericalSlice, f : Double) -> GeodistsphericalSlice {
  let result = geo_dist_spherical_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_spherical_slice_add(a : GeodistsphericalSlice, b : GeodistsphericalSlice) -> GeodistsphericalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_spherical_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_spherical_slice_copy(s : GeodistsphericalSlice) -> GeodistsphericalSlice {
  let result = geo_dist_spherical_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_spherical_slice_fill(s : GeodistsphericalSlice, v : Double) -> GeodistsphericalSlice {
  let result = geo_dist_spherical_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_spherical_slice_min(s : GeodistsphericalSlice) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_slice_max(s : GeodistsphericalSlice) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_slice_to_string(s : GeodistsphericalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

