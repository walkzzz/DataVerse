///===
/// extcore/geo_dist_ellipsoidal

pub(all) struct GeodistellipsoidalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_ellipsoidal_make_point(x : Double, y : Double) -> GeodistellipsoidalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_ellipsoidal_make_point3(x : Double, y : Double, z : Double) -> GeodistellipsoidalPoint {
  { x, y, z, label: 0 }
}

pub fn geo_dist_ellipsoidal_point_x(pt : GeodistellipsoidalPoint) -> Double { pt.x }

pub fn geo_dist_ellipsoidal_point_y(pt : GeodistellipsoidalPoint) -> Double { pt.y }

pub fn geo_dist_ellipsoidal_point_z(pt : GeodistellipsoidalPoint) -> Double { pt.z }

pub fn geo_dist_ellipsoidal_point_label(pt : GeodistellipsoidalPoint) -> Int { pt.label }

pub fn geo_dist_ellipsoidal_point_dist(a : GeodistellipsoidalPoint, b : GeodistellipsoidalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_dist_ellipsoidal_point_add(a : GeodistellipsoidalPoint, b : GeodistellipsoidalPoint) -> GeodistellipsoidalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_dist_ellipsoidal_point_sub(a : GeodistellipsoidalPoint, b : GeodistellipsoidalPoint) -> GeodistellipsoidalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_dist_ellipsoidal_point_scale(pt : GeodistellipsoidalPoint, s : Double) -> GeodistellipsoidalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_dist_ellipsoidal_point_dot(a : GeodistellipsoidalPoint, b : GeodistellipsoidalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_dist_ellipsoidal_point_cross(a : GeodistellipsoidalPoint, b : GeodistellipsoidalPoint) -> GeodistellipsoidalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_dist_ellipsoidal_point_norm(pt : GeodistellipsoidalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_dist_ellipsoidal_point_normalize(pt : GeodistellipsoidalPoint) -> GeodistellipsoidalPoint {
  let n = geo_dist_ellipsoidal_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_dist_ellipsoidal_point_scale(pt, 1.0 / n) }
}

pub fn geo_dist_ellipsoidal_point_negate(pt : GeodistellipsoidalPoint) -> GeodistellipsoidalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_dist_ellipsoidal_point_mid(a : GeodistellipsoidalPoint, b : GeodistellipsoidalPoint) -> GeodistellipsoidalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_dist_ellipsoidal_point_lerp(a : GeodistellipsoidalPoint, b : GeodistellipsoidalPoint, t : Double) -> GeodistellipsoidalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_dist_ellipsoidal_point_to_string(pt : GeodistellipsoidalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeodistellipsoidalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_ellipsoidal_make_series(vals : Array[Double], name : String) -> GeodistellipsoidalSeries {
  { vals, name, meta: 0 }
}

pub fn geo_dist_ellipsoidal_series_len(s : GeodistellipsoidalSeries) -> Int { s.vals.length() }

pub fn geo_dist_ellipsoidal_series_sum(s : GeodistellipsoidalSeries) -> Double { @_common.sum(s.vals) }

pub fn geo_dist_ellipsoidal_series_mean(s : GeodistellipsoidalSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_dist_ellipsoidal_series_min(s : GeodistellipsoidalSeries) -> Double { @_common.min(s.vals) }

pub fn geo_dist_ellipsoidal_series_max(s : GeodistellipsoidalSeries) -> Double { @_common.max(s.vals) }

pub fn geo_dist_ellipsoidal_series_range(s : GeodistellipsoidalSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_dist_ellipsoidal_series_var(s : GeodistellipsoidalSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_dist_ellipsoidal_series_std(s : GeodistellipsoidalSeries) -> Double { @_common.std(s.vals) }

pub fn geo_dist_ellipsoidal_series_median(s : GeodistellipsoidalSeries) -> Double { @_common.median(s.vals) }

pub fn geo_dist_ellipsoidal_series_scale(s : GeodistellipsoidalSeries, f : Double) -> GeodistellipsoidalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_dist_ellipsoidal_series_add(a : GeodistellipsoidalSeries, b : GeodistellipsoidalSeries) -> GeodistellipsoidalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_dist_ellipsoidal_series_sub(a : GeodistellipsoidalSeries, b : GeodistellipsoidalSeries) -> GeodistellipsoidalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_dist_ellipsoidal_series_normalize(s : GeodistellipsoidalSeries) -> GeodistellipsoidalSeries {
  let mn = geo_dist_ellipsoidal_series_min(s)
  let mx = geo_dist_ellipsoidal_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_dist_ellipsoidal_series_cumsum(s : GeodistellipsoidalSeries) -> GeodistellipsoidalSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_dist_ellipsoidal_series_to_string(s : GeodistellipsoidalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistellipsoidalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_ellipsoidal_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistellipsoidalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_ellipsoidal_matrix_identity(n : Int) -> GeodistellipsoidalMatrix {
  let m = geo_dist_ellipsoidal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_dist_ellipsoidal_matrix_get(m : GeodistellipsoidalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_dist_ellipsoidal_matrix_transpose(m : GeodistellipsoidalMatrix) -> GeodistellipsoidalMatrix {
  let result = geo_dist_ellipsoidal_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_dist_ellipsoidal_matrix_add(a : GeodistellipsoidalMatrix, b : GeodistellipsoidalMatrix) -> GeodistellipsoidalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_dist_ellipsoidal_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_dist_ellipsoidal_matrix_scale(m : GeodistellipsoidalMatrix, s : Double) -> GeodistellipsoidalMatrix {
  let result = geo_dist_ellipsoidal_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_dist_ellipsoidal_matrix_multiply(a : GeodistellipsoidalMatrix, b : GeodistellipsoidalMatrix) -> GeodistellipsoidalMatrix {
  if a.cols != b.rows { return geo_dist_ellipsoidal_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_dist_ellipsoidal_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_dist_ellipsoidal_matrix_trace(m : GeodistellipsoidalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_dist_ellipsoidal_matrix_det(m : GeodistellipsoidalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_dist_ellipsoidal_matrix_norm(m : GeodistellipsoidalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_dist_ellipsoidal_matrix_to_string(m : GeodistellipsoidalMatrix) -> String {
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

pub(all) struct GeodistellipsoidalVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_ellipsoidal_make_vector(comps : Array[Double]) -> GeodistellipsoidalVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_ellipsoidal_vector_zero(dim : Int) -> GeodistellipsoidalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_dist_ellipsoidal_vector_add(a : GeodistellipsoidalVector, b : GeodistellipsoidalVector) -> GeodistellipsoidalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_ellipsoidal_vector_sub(a : GeodistellipsoidalVector, b : GeodistellipsoidalVector) -> GeodistellipsoidalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_ellipsoidal_vector_scale(v : GeodistellipsoidalVector, s : Double) -> GeodistellipsoidalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_dist_ellipsoidal_vector_dot(a : GeodistellipsoidalVector, b : GeodistellipsoidalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_dist_ellipsoidal_vector_norm(v : GeodistellipsoidalVector) -> Double { @_common.sqrt(geo_dist_ellipsoidal_vector_dot(v, v)) }

pub fn geo_dist_ellipsoidal_vector_normalize(v : GeodistellipsoidalVector) -> GeodistellipsoidalVector {
  let n = geo_dist_ellipsoidal_vector_norm(v)
  if n < 0.0000001 { v } else { geo_dist_ellipsoidal_vector_scale(v, 1.0 / n) }
}

pub fn geo_dist_ellipsoidal_vector_dist(a : GeodistellipsoidalVector, b : GeodistellipsoidalVector) -> Double {
  geo_dist_ellipsoidal_vector_norm(geo_dist_ellipsoidal_vector_sub(a, b))
}

pub fn geo_dist_ellipsoidal_vector_to_string(v : GeodistellipsoidalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_ellipsoidal_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_dist_ellipsoidal_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_dist_ellipsoidal_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_dist_ellipsoidal_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_dist_ellipsoidal_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_dist_ellipsoidal_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_dist_ellipsoidal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_dist_ellipsoidal_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_dist_ellipsoidal_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_dist_ellipsoidal_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_dist_ellipsoidal_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_dist_ellipsoidal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_dist_ellipsoidal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_dist_ellipsoidal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_dist_ellipsoidal_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_dist_ellipsoidal_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_dist_ellipsoidal_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_dist_ellipsoidal_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_dist_ellipsoidal_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_dist_ellipsoidal_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_dist_ellipsoidal_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_dist_ellipsoidal_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_dist_ellipsoidal_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_dist_ellipsoidal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_dist_ellipsoidal_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_dist_ellipsoidal_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_dist_ellipsoidal_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_dist_ellipsoidal_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_dist_ellipsoidal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeodistellipsoidalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_frame_make(size : Int) -> GeodistellipsoidalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_frame_len(s : GeodistellipsoidalFrame) -> Int { s.size }

pub fn geo_dist_ellipsoidal_frame_get(s : GeodistellipsoidalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_frame_set(s : GeodistellipsoidalFrame, i : Int, v : Double) -> GeodistellipsoidalFrame {
  let result = geo_dist_ellipsoidal_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_ellipsoidal_frame_sum(s : GeodistellipsoidalFrame) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_frame_mean(s : GeodistellipsoidalFrame) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_frame_scale(s : GeodistellipsoidalFrame, f : Double) -> GeodistellipsoidalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_frame_add(a : GeodistellipsoidalFrame, b : GeodistellipsoidalFrame) -> GeodistellipsoidalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_frame_copy(s : GeodistellipsoidalFrame) -> GeodistellipsoidalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_frame_fill(s : GeodistellipsoidalFrame, v : Double) -> GeodistellipsoidalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_frame_min(s : GeodistellipsoidalFrame) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_frame_max(s : GeodistellipsoidalFrame) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_frame_to_string(s : GeodistellipsoidalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_table_make(size : Int) -> GeodistellipsoidalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_table_len(s : GeodistellipsoidalTable) -> Int { s.size }

pub fn geo_dist_ellipsoidal_table_get(s : GeodistellipsoidalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_table_set(s : GeodistellipsoidalTable, i : Int, v : Double) -> GeodistellipsoidalTable {
  let result = geo_dist_ellipsoidal_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_ellipsoidal_table_sum(s : GeodistellipsoidalTable) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_table_mean(s : GeodistellipsoidalTable) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_table_scale(s : GeodistellipsoidalTable, f : Double) -> GeodistellipsoidalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_table_add(a : GeodistellipsoidalTable, b : GeodistellipsoidalTable) -> GeodistellipsoidalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_table_copy(s : GeodistellipsoidalTable) -> GeodistellipsoidalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_table_fill(s : GeodistellipsoidalTable, v : Double) -> GeodistellipsoidalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_table_min(s : GeodistellipsoidalTable) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_table_max(s : GeodistellipsoidalTable) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_table_to_string(s : GeodistellipsoidalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_graphn_make(size : Int) -> GeodistellipsoidalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_graphn_len(s : GeodistellipsoidalGraphN) -> Int { s.size }

pub fn geo_dist_ellipsoidal_graphn_get(s : GeodistellipsoidalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_graphn_set(s : GeodistellipsoidalGraphN, i : Int, v : Double) -> GeodistellipsoidalGraphN {
  let result = geo_dist_ellipsoidal_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_ellipsoidal_graphn_sum(s : GeodistellipsoidalGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_graphn_mean(s : GeodistellipsoidalGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_graphn_scale(s : GeodistellipsoidalGraphN, f : Double) -> GeodistellipsoidalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_graphn_add(a : GeodistellipsoidalGraphN, b : GeodistellipsoidalGraphN) -> GeodistellipsoidalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_graphn_copy(s : GeodistellipsoidalGraphN) -> GeodistellipsoidalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_graphn_fill(s : GeodistellipsoidalGraphN, v : Double) -> GeodistellipsoidalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_graphn_min(s : GeodistellipsoidalGraphN) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_graphn_max(s : GeodistellipsoidalGraphN) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_graphn_to_string(s : GeodistellipsoidalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_node_make(size : Int) -> GeodistellipsoidalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_node_len(s : GeodistellipsoidalNode) -> Int { s.size }

pub fn geo_dist_ellipsoidal_node_get(s : GeodistellipsoidalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_node_set(s : GeodistellipsoidalNode, i : Int, v : Double) -> GeodistellipsoidalNode {
  let result = geo_dist_ellipsoidal_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_ellipsoidal_node_sum(s : GeodistellipsoidalNode) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_node_mean(s : GeodistellipsoidalNode) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_node_scale(s : GeodistellipsoidalNode, f : Double) -> GeodistellipsoidalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_node_add(a : GeodistellipsoidalNode, b : GeodistellipsoidalNode) -> GeodistellipsoidalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_node_copy(s : GeodistellipsoidalNode) -> GeodistellipsoidalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_node_fill(s : GeodistellipsoidalNode, v : Double) -> GeodistellipsoidalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_node_min(s : GeodistellipsoidalNode) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_node_max(s : GeodistellipsoidalNode) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_node_to_string(s : GeodistellipsoidalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_edge_make(size : Int) -> GeodistellipsoidalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_edge_len(s : GeodistellipsoidalEdge) -> Int { s.size }

pub fn geo_dist_ellipsoidal_edge_get(s : GeodistellipsoidalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_edge_set(s : GeodistellipsoidalEdge, i : Int, v : Double) -> GeodistellipsoidalEdge {
  let result = geo_dist_ellipsoidal_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_ellipsoidal_edge_sum(s : GeodistellipsoidalEdge) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_edge_mean(s : GeodistellipsoidalEdge) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_edge_scale(s : GeodistellipsoidalEdge, f : Double) -> GeodistellipsoidalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_edge_add(a : GeodistellipsoidalEdge, b : GeodistellipsoidalEdge) -> GeodistellipsoidalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_edge_copy(s : GeodistellipsoidalEdge) -> GeodistellipsoidalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_edge_fill(s : GeodistellipsoidalEdge, v : Double) -> GeodistellipsoidalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_edge_min(s : GeodistellipsoidalEdge) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_edge_max(s : GeodistellipsoidalEdge) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_edge_to_string(s : GeodistellipsoidalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_path_make(size : Int) -> GeodistellipsoidalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_path_len(s : GeodistellipsoidalPath) -> Int { s.size }

pub fn geo_dist_ellipsoidal_path_get(s : GeodistellipsoidalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_path_set(s : GeodistellipsoidalPath, i : Int, v : Double) -> GeodistellipsoidalPath {
  let result = geo_dist_ellipsoidal_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_ellipsoidal_path_sum(s : GeodistellipsoidalPath) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_path_mean(s : GeodistellipsoidalPath) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_path_scale(s : GeodistellipsoidalPath, f : Double) -> GeodistellipsoidalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_path_add(a : GeodistellipsoidalPath, b : GeodistellipsoidalPath) -> GeodistellipsoidalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_path_copy(s : GeodistellipsoidalPath) -> GeodistellipsoidalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_path_fill(s : GeodistellipsoidalPath, v : Double) -> GeodistellipsoidalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_path_min(s : GeodistellipsoidalPath) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_path_max(s : GeodistellipsoidalPath) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_path_to_string(s : GeodistellipsoidalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_cluster_make(size : Int) -> GeodistellipsoidalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_cluster_len(s : GeodistellipsoidalCluster) -> Int { s.size }

pub fn geo_dist_ellipsoidal_cluster_get(s : GeodistellipsoidalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_cluster_set(s : GeodistellipsoidalCluster, i : Int, v : Double) -> GeodistellipsoidalCluster {
  let result = geo_dist_ellipsoidal_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_ellipsoidal_cluster_sum(s : GeodistellipsoidalCluster) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_cluster_mean(s : GeodistellipsoidalCluster) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_cluster_scale(s : GeodistellipsoidalCluster, f : Double) -> GeodistellipsoidalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_cluster_add(a : GeodistellipsoidalCluster, b : GeodistellipsoidalCluster) -> GeodistellipsoidalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_cluster_copy(s : GeodistellipsoidalCluster) -> GeodistellipsoidalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_cluster_fill(s : GeodistellipsoidalCluster, v : Double) -> GeodistellipsoidalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_cluster_min(s : GeodistellipsoidalCluster) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_cluster_max(s : GeodistellipsoidalCluster) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_cluster_to_string(s : GeodistellipsoidalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_model_make(size : Int) -> GeodistellipsoidalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_model_len(s : GeodistellipsoidalModel) -> Int { s.size }

pub fn geo_dist_ellipsoidal_model_get(s : GeodistellipsoidalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_model_set(s : GeodistellipsoidalModel, i : Int, v : Double) -> GeodistellipsoidalModel {
  let result = geo_dist_ellipsoidal_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_ellipsoidal_model_sum(s : GeodistellipsoidalModel) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_model_mean(s : GeodistellipsoidalModel) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_model_scale(s : GeodistellipsoidalModel, f : Double) -> GeodistellipsoidalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_model_add(a : GeodistellipsoidalModel, b : GeodistellipsoidalModel) -> GeodistellipsoidalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_model_copy(s : GeodistellipsoidalModel) -> GeodistellipsoidalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_model_fill(s : GeodistellipsoidalModel, v : Double) -> GeodistellipsoidalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_model_min(s : GeodistellipsoidalModel) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_model_max(s : GeodistellipsoidalModel) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_model_to_string(s : GeodistellipsoidalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_layer_make(size : Int) -> GeodistellipsoidalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_layer_len(s : GeodistellipsoidalLayer) -> Int { s.size }

pub fn geo_dist_ellipsoidal_layer_get(s : GeodistellipsoidalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_layer_set(s : GeodistellipsoidalLayer, i : Int, v : Double) -> GeodistellipsoidalLayer {
  let result = geo_dist_ellipsoidal_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_ellipsoidal_layer_sum(s : GeodistellipsoidalLayer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_layer_mean(s : GeodistellipsoidalLayer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_layer_scale(s : GeodistellipsoidalLayer, f : Double) -> GeodistellipsoidalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_layer_add(a : GeodistellipsoidalLayer, b : GeodistellipsoidalLayer) -> GeodistellipsoidalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_layer_copy(s : GeodistellipsoidalLayer) -> GeodistellipsoidalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_layer_fill(s : GeodistellipsoidalLayer, v : Double) -> GeodistellipsoidalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_layer_min(s : GeodistellipsoidalLayer) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_layer_max(s : GeodistellipsoidalLayer) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_layer_to_string(s : GeodistellipsoidalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_buffer_make(size : Int) -> GeodistellipsoidalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_buffer_len(s : GeodistellipsoidalBuffer) -> Int { s.size }

pub fn geo_dist_ellipsoidal_buffer_get(s : GeodistellipsoidalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_buffer_set(s : GeodistellipsoidalBuffer, i : Int, v : Double) -> GeodistellipsoidalBuffer {
  let result = geo_dist_ellipsoidal_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_ellipsoidal_buffer_sum(s : GeodistellipsoidalBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_buffer_mean(s : GeodistellipsoidalBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_buffer_scale(s : GeodistellipsoidalBuffer, f : Double) -> GeodistellipsoidalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_buffer_add(a : GeodistellipsoidalBuffer, b : GeodistellipsoidalBuffer) -> GeodistellipsoidalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_buffer_copy(s : GeodistellipsoidalBuffer) -> GeodistellipsoidalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_buffer_fill(s : GeodistellipsoidalBuffer, v : Double) -> GeodistellipsoidalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_buffer_min(s : GeodistellipsoidalBuffer) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_buffer_max(s : GeodistellipsoidalBuffer) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_buffer_to_string(s : GeodistellipsoidalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_cursor_make(size : Int) -> GeodistellipsoidalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_cursor_len(s : GeodistellipsoidalCursor) -> Int { s.size }

pub fn geo_dist_ellipsoidal_cursor_get(s : GeodistellipsoidalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_cursor_set(s : GeodistellipsoidalCursor, i : Int, v : Double) -> GeodistellipsoidalCursor {
  let result = geo_dist_ellipsoidal_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_ellipsoidal_cursor_sum(s : GeodistellipsoidalCursor) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_cursor_mean(s : GeodistellipsoidalCursor) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_cursor_scale(s : GeodistellipsoidalCursor, f : Double) -> GeodistellipsoidalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_cursor_add(a : GeodistellipsoidalCursor, b : GeodistellipsoidalCursor) -> GeodistellipsoidalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_cursor_copy(s : GeodistellipsoidalCursor) -> GeodistellipsoidalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_cursor_fill(s : GeodistellipsoidalCursor, v : Double) -> GeodistellipsoidalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_cursor_min(s : GeodistellipsoidalCursor) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_cursor_max(s : GeodistellipsoidalCursor) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_cursor_to_string(s : GeodistellipsoidalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_view_make(size : Int) -> GeodistellipsoidalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_view_len(s : GeodistellipsoidalView) -> Int { s.size }

pub fn geo_dist_ellipsoidal_view_get(s : GeodistellipsoidalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_view_set(s : GeodistellipsoidalView, i : Int, v : Double) -> GeodistellipsoidalView {
  let result = geo_dist_ellipsoidal_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_ellipsoidal_view_sum(s : GeodistellipsoidalView) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_view_mean(s : GeodistellipsoidalView) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_view_scale(s : GeodistellipsoidalView, f : Double) -> GeodistellipsoidalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_view_add(a : GeodistellipsoidalView, b : GeodistellipsoidalView) -> GeodistellipsoidalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_view_copy(s : GeodistellipsoidalView) -> GeodistellipsoidalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_view_fill(s : GeodistellipsoidalView, v : Double) -> GeodistellipsoidalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_view_min(s : GeodistellipsoidalView) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_view_max(s : GeodistellipsoidalView) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_view_to_string(s : GeodistellipsoidalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_range_make(size : Int) -> GeodistellipsoidalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_range_len(s : GeodistellipsoidalRange) -> Int { s.size }

pub fn geo_dist_ellipsoidal_range_get(s : GeodistellipsoidalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_range_set(s : GeodistellipsoidalRange, i : Int, v : Double) -> GeodistellipsoidalRange {
  let result = geo_dist_ellipsoidal_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_ellipsoidal_range_sum(s : GeodistellipsoidalRange) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_range_mean(s : GeodistellipsoidalRange) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_range_scale(s : GeodistellipsoidalRange, f : Double) -> GeodistellipsoidalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_range_add(a : GeodistellipsoidalRange, b : GeodistellipsoidalRange) -> GeodistellipsoidalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_range_copy(s : GeodistellipsoidalRange) -> GeodistellipsoidalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_range_fill(s : GeodistellipsoidalRange, v : Double) -> GeodistellipsoidalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_range_min(s : GeodistellipsoidalRange) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_range_max(s : GeodistellipsoidalRange) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_range_to_string(s : GeodistellipsoidalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistellipsoidalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_ellipsoidal_slice_make(size : Int) -> GeodistellipsoidalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_ellipsoidal_slice_len(s : GeodistellipsoidalSlice) -> Int { s.size }

pub fn geo_dist_ellipsoidal_slice_get(s : GeodistellipsoidalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_ellipsoidal_slice_set(s : GeodistellipsoidalSlice, i : Int, v : Double) -> GeodistellipsoidalSlice {
  let result = geo_dist_ellipsoidal_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_ellipsoidal_slice_sum(s : GeodistellipsoidalSlice) -> Double { @_common.sum(s.data) }

pub fn geo_dist_ellipsoidal_slice_mean(s : GeodistellipsoidalSlice) -> Double { @_common.mean(s.data) }

pub fn geo_dist_ellipsoidal_slice_scale(s : GeodistellipsoidalSlice, f : Double) -> GeodistellipsoidalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_slice_add(a : GeodistellipsoidalSlice, b : GeodistellipsoidalSlice) -> GeodistellipsoidalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_ellipsoidal_slice_copy(s : GeodistellipsoidalSlice) -> GeodistellipsoidalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_slice_fill(s : GeodistellipsoidalSlice, v : Double) -> GeodistellipsoidalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_ellipsoidal_slice_min(s : GeodistellipsoidalSlice) -> Double { @_common.min(s.data) }

pub fn geo_dist_ellipsoidal_slice_max(s : GeodistellipsoidalSlice) -> Double { @_common.max(s.data) }

pub fn geo_dist_ellipsoidal_slice_to_string(s : GeodistellipsoidalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

