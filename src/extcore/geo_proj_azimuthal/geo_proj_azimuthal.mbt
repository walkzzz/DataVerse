///===
/// extcore/geo_proj_azimuthal

pub(all) struct GeoprojazimuthalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_azimuthal_make_point(x : Double, y : Double) -> GeoprojazimuthalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_azimuthal_make_point3(x : Double, y : Double, z : Double) -> GeoprojazimuthalPoint {
  { x, y, z, label: 0 }
}

pub fn geo_proj_azimuthal_point_x(pt : GeoprojazimuthalPoint) -> Double { pt.x }

pub fn geo_proj_azimuthal_point_y(pt : GeoprojazimuthalPoint) -> Double { pt.y }

pub fn geo_proj_azimuthal_point_z(pt : GeoprojazimuthalPoint) -> Double { pt.z }

pub fn geo_proj_azimuthal_point_label(pt : GeoprojazimuthalPoint) -> Int { pt.label }

pub fn geo_proj_azimuthal_point_dist(a : GeoprojazimuthalPoint, b : GeoprojazimuthalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_proj_azimuthal_point_add(a : GeoprojazimuthalPoint, b : GeoprojazimuthalPoint) -> GeoprojazimuthalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_proj_azimuthal_point_sub(a : GeoprojazimuthalPoint, b : GeoprojazimuthalPoint) -> GeoprojazimuthalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_proj_azimuthal_point_scale(pt : GeoprojazimuthalPoint, s : Double) -> GeoprojazimuthalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_proj_azimuthal_point_dot(a : GeoprojazimuthalPoint, b : GeoprojazimuthalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_proj_azimuthal_point_cross(a : GeoprojazimuthalPoint, b : GeoprojazimuthalPoint) -> GeoprojazimuthalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_proj_azimuthal_point_norm(pt : GeoprojazimuthalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_proj_azimuthal_point_normalize(pt : GeoprojazimuthalPoint) -> GeoprojazimuthalPoint {
  let n = geo_proj_azimuthal_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_proj_azimuthal_point_scale(pt, 1.0 / n) }
}

pub fn geo_proj_azimuthal_point_negate(pt : GeoprojazimuthalPoint) -> GeoprojazimuthalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_proj_azimuthal_point_mid(a : GeoprojazimuthalPoint, b : GeoprojazimuthalPoint) -> GeoprojazimuthalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_proj_azimuthal_point_lerp(a : GeoprojazimuthalPoint, b : GeoprojazimuthalPoint, t : Double) -> GeoprojazimuthalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_proj_azimuthal_point_to_string(pt : GeoprojazimuthalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeoprojazimuthalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_azimuthal_make_series(vals : Array[Double], name : String) -> GeoprojazimuthalSeries {
  { vals, name, meta: 0 }
}

pub fn geo_proj_azimuthal_series_len(s : GeoprojazimuthalSeries) -> Int { s.vals.length() }

pub fn geo_proj_azimuthal_series_sum(s : GeoprojazimuthalSeries) -> Double { @_common.sum(s.vals) }

pub fn geo_proj_azimuthal_series_mean(s : GeoprojazimuthalSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_proj_azimuthal_series_min(s : GeoprojazimuthalSeries) -> Double { @_common.min(s.vals) }

pub fn geo_proj_azimuthal_series_max(s : GeoprojazimuthalSeries) -> Double { @_common.max(s.vals) }

pub fn geo_proj_azimuthal_series_range(s : GeoprojazimuthalSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_proj_azimuthal_series_var(s : GeoprojazimuthalSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_proj_azimuthal_series_std(s : GeoprojazimuthalSeries) -> Double { @_common.std(s.vals) }

pub fn geo_proj_azimuthal_series_median(s : GeoprojazimuthalSeries) -> Double { @_common.median(s.vals) }

pub fn geo_proj_azimuthal_series_scale(s : GeoprojazimuthalSeries, f : Double) -> GeoprojazimuthalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_proj_azimuthal_series_add(a : GeoprojazimuthalSeries, b : GeoprojazimuthalSeries) -> GeoprojazimuthalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_proj_azimuthal_series_sub(a : GeoprojazimuthalSeries, b : GeoprojazimuthalSeries) -> GeoprojazimuthalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_proj_azimuthal_series_normalize(s : GeoprojazimuthalSeries) -> GeoprojazimuthalSeries {
  let mn = geo_proj_azimuthal_series_min(s)
  let mx = geo_proj_azimuthal_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_proj_azimuthal_series_cumsum(s : GeoprojazimuthalSeries) -> GeoprojazimuthalSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_proj_azimuthal_series_to_string(s : GeoprojazimuthalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojazimuthalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_azimuthal_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojazimuthalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_azimuthal_matrix_identity(n : Int) -> GeoprojazimuthalMatrix {
  let m = geo_proj_azimuthal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_proj_azimuthal_matrix_get(m : GeoprojazimuthalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_proj_azimuthal_matrix_transpose(m : GeoprojazimuthalMatrix) -> GeoprojazimuthalMatrix {
  let result = geo_proj_azimuthal_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_proj_azimuthal_matrix_add(a : GeoprojazimuthalMatrix, b : GeoprojazimuthalMatrix) -> GeoprojazimuthalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_proj_azimuthal_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_proj_azimuthal_matrix_scale(m : GeoprojazimuthalMatrix, s : Double) -> GeoprojazimuthalMatrix {
  let result = geo_proj_azimuthal_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_proj_azimuthal_matrix_multiply(a : GeoprojazimuthalMatrix, b : GeoprojazimuthalMatrix) -> GeoprojazimuthalMatrix {
  if a.cols != b.rows { return geo_proj_azimuthal_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_proj_azimuthal_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_proj_azimuthal_matrix_trace(m : GeoprojazimuthalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_proj_azimuthal_matrix_det(m : GeoprojazimuthalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_proj_azimuthal_matrix_norm(m : GeoprojazimuthalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_proj_azimuthal_matrix_to_string(m : GeoprojazimuthalMatrix) -> String {
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

pub(all) struct GeoprojazimuthalVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_azimuthal_make_vector(comps : Array[Double]) -> GeoprojazimuthalVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_azimuthal_vector_zero(dim : Int) -> GeoprojazimuthalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_proj_azimuthal_vector_add(a : GeoprojazimuthalVector, b : GeoprojazimuthalVector) -> GeoprojazimuthalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_proj_azimuthal_vector_sub(a : GeoprojazimuthalVector, b : GeoprojazimuthalVector) -> GeoprojazimuthalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_proj_azimuthal_vector_scale(v : GeoprojazimuthalVector, s : Double) -> GeoprojazimuthalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_proj_azimuthal_vector_dot(a : GeoprojazimuthalVector, b : GeoprojazimuthalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_proj_azimuthal_vector_norm(v : GeoprojazimuthalVector) -> Double { @_common.sqrt(geo_proj_azimuthal_vector_dot(v, v)) }

pub fn geo_proj_azimuthal_vector_normalize(v : GeoprojazimuthalVector) -> GeoprojazimuthalVector {
  let n = geo_proj_azimuthal_vector_norm(v)
  if n < 0.0000001 { v } else { geo_proj_azimuthal_vector_scale(v, 1.0 / n) }
}

pub fn geo_proj_azimuthal_vector_dist(a : GeoprojazimuthalVector, b : GeoprojazimuthalVector) -> Double {
  geo_proj_azimuthal_vector_norm(geo_proj_azimuthal_vector_sub(a, b))
}

pub fn geo_proj_azimuthal_vector_to_string(v : GeoprojazimuthalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_azimuthal_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_proj_azimuthal_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_proj_azimuthal_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_proj_azimuthal_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_proj_azimuthal_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_proj_azimuthal_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_proj_azimuthal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_proj_azimuthal_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_proj_azimuthal_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_proj_azimuthal_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_proj_azimuthal_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_proj_azimuthal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_proj_azimuthal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_proj_azimuthal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_proj_azimuthal_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_proj_azimuthal_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_proj_azimuthal_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_proj_azimuthal_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_proj_azimuthal_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_proj_azimuthal_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_proj_azimuthal_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_proj_azimuthal_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_proj_azimuthal_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_proj_azimuthal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_proj_azimuthal_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_proj_azimuthal_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_proj_azimuthal_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_proj_azimuthal_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_proj_azimuthal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeoprojazimuthalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_frame_make(size : Int) -> GeoprojazimuthalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_azimuthal_frame_len(s : GeoprojazimuthalFrame) -> Int { s.size }

pub fn geo_proj_azimuthal_frame_get(s : GeoprojazimuthalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_azimuthal_frame_set(s : GeoprojazimuthalFrame, i : Int, v : Double) -> GeoprojazimuthalFrame {
  let result = geo_proj_azimuthal_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_azimuthal_frame_sum(s : GeoprojazimuthalFrame) -> Double { @_common.sum(s.data) }

pub fn geo_proj_azimuthal_frame_mean(s : GeoprojazimuthalFrame) -> Double { @_common.mean(s.data) }

pub fn geo_proj_azimuthal_frame_scale(s : GeoprojazimuthalFrame, f : Double) -> GeoprojazimuthalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_frame_add(a : GeoprojazimuthalFrame, b : GeoprojazimuthalFrame) -> GeoprojazimuthalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_azimuthal_frame_copy(s : GeoprojazimuthalFrame) -> GeoprojazimuthalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_frame_fill(s : GeoprojazimuthalFrame, v : Double) -> GeoprojazimuthalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_frame_min(s : GeoprojazimuthalFrame) -> Double { @_common.min(s.data) }

pub fn geo_proj_azimuthal_frame_max(s : GeoprojazimuthalFrame) -> Double { @_common.max(s.data) }

pub fn geo_proj_azimuthal_frame_to_string(s : GeoprojazimuthalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_table_make(size : Int) -> GeoprojazimuthalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_azimuthal_table_len(s : GeoprojazimuthalTable) -> Int { s.size }

pub fn geo_proj_azimuthal_table_get(s : GeoprojazimuthalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_azimuthal_table_set(s : GeoprojazimuthalTable, i : Int, v : Double) -> GeoprojazimuthalTable {
  let result = geo_proj_azimuthal_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_azimuthal_table_sum(s : GeoprojazimuthalTable) -> Double { @_common.sum(s.data) }

pub fn geo_proj_azimuthal_table_mean(s : GeoprojazimuthalTable) -> Double { @_common.mean(s.data) }

pub fn geo_proj_azimuthal_table_scale(s : GeoprojazimuthalTable, f : Double) -> GeoprojazimuthalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_table_add(a : GeoprojazimuthalTable, b : GeoprojazimuthalTable) -> GeoprojazimuthalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_azimuthal_table_copy(s : GeoprojazimuthalTable) -> GeoprojazimuthalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_table_fill(s : GeoprojazimuthalTable, v : Double) -> GeoprojazimuthalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_table_min(s : GeoprojazimuthalTable) -> Double { @_common.min(s.data) }

pub fn geo_proj_azimuthal_table_max(s : GeoprojazimuthalTable) -> Double { @_common.max(s.data) }

pub fn geo_proj_azimuthal_table_to_string(s : GeoprojazimuthalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_graphn_make(size : Int) -> GeoprojazimuthalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_azimuthal_graphn_len(s : GeoprojazimuthalGraphN) -> Int { s.size }

pub fn geo_proj_azimuthal_graphn_get(s : GeoprojazimuthalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_azimuthal_graphn_set(s : GeoprojazimuthalGraphN, i : Int, v : Double) -> GeoprojazimuthalGraphN {
  let result = geo_proj_azimuthal_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_azimuthal_graphn_sum(s : GeoprojazimuthalGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_proj_azimuthal_graphn_mean(s : GeoprojazimuthalGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_proj_azimuthal_graphn_scale(s : GeoprojazimuthalGraphN, f : Double) -> GeoprojazimuthalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_graphn_add(a : GeoprojazimuthalGraphN, b : GeoprojazimuthalGraphN) -> GeoprojazimuthalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_azimuthal_graphn_copy(s : GeoprojazimuthalGraphN) -> GeoprojazimuthalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_graphn_fill(s : GeoprojazimuthalGraphN, v : Double) -> GeoprojazimuthalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_graphn_min(s : GeoprojazimuthalGraphN) -> Double { @_common.min(s.data) }

pub fn geo_proj_azimuthal_graphn_max(s : GeoprojazimuthalGraphN) -> Double { @_common.max(s.data) }

pub fn geo_proj_azimuthal_graphn_to_string(s : GeoprojazimuthalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_node_make(size : Int) -> GeoprojazimuthalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_azimuthal_node_len(s : GeoprojazimuthalNode) -> Int { s.size }

pub fn geo_proj_azimuthal_node_get(s : GeoprojazimuthalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_azimuthal_node_set(s : GeoprojazimuthalNode, i : Int, v : Double) -> GeoprojazimuthalNode {
  let result = geo_proj_azimuthal_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_azimuthal_node_sum(s : GeoprojazimuthalNode) -> Double { @_common.sum(s.data) }

pub fn geo_proj_azimuthal_node_mean(s : GeoprojazimuthalNode) -> Double { @_common.mean(s.data) }

pub fn geo_proj_azimuthal_node_scale(s : GeoprojazimuthalNode, f : Double) -> GeoprojazimuthalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_node_add(a : GeoprojazimuthalNode, b : GeoprojazimuthalNode) -> GeoprojazimuthalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_azimuthal_node_copy(s : GeoprojazimuthalNode) -> GeoprojazimuthalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_node_fill(s : GeoprojazimuthalNode, v : Double) -> GeoprojazimuthalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_node_min(s : GeoprojazimuthalNode) -> Double { @_common.min(s.data) }

pub fn geo_proj_azimuthal_node_max(s : GeoprojazimuthalNode) -> Double { @_common.max(s.data) }

pub fn geo_proj_azimuthal_node_to_string(s : GeoprojazimuthalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_edge_make(size : Int) -> GeoprojazimuthalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_azimuthal_edge_len(s : GeoprojazimuthalEdge) -> Int { s.size }

pub fn geo_proj_azimuthal_edge_get(s : GeoprojazimuthalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_azimuthal_edge_set(s : GeoprojazimuthalEdge, i : Int, v : Double) -> GeoprojazimuthalEdge {
  let result = geo_proj_azimuthal_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_azimuthal_edge_sum(s : GeoprojazimuthalEdge) -> Double { @_common.sum(s.data) }

pub fn geo_proj_azimuthal_edge_mean(s : GeoprojazimuthalEdge) -> Double { @_common.mean(s.data) }

pub fn geo_proj_azimuthal_edge_scale(s : GeoprojazimuthalEdge, f : Double) -> GeoprojazimuthalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_edge_add(a : GeoprojazimuthalEdge, b : GeoprojazimuthalEdge) -> GeoprojazimuthalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_azimuthal_edge_copy(s : GeoprojazimuthalEdge) -> GeoprojazimuthalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_edge_fill(s : GeoprojazimuthalEdge, v : Double) -> GeoprojazimuthalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_edge_min(s : GeoprojazimuthalEdge) -> Double { @_common.min(s.data) }

pub fn geo_proj_azimuthal_edge_max(s : GeoprojazimuthalEdge) -> Double { @_common.max(s.data) }

pub fn geo_proj_azimuthal_edge_to_string(s : GeoprojazimuthalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_path_make(size : Int) -> GeoprojazimuthalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_azimuthal_path_len(s : GeoprojazimuthalPath) -> Int { s.size }

pub fn geo_proj_azimuthal_path_get(s : GeoprojazimuthalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_azimuthal_path_set(s : GeoprojazimuthalPath, i : Int, v : Double) -> GeoprojazimuthalPath {
  let result = geo_proj_azimuthal_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_azimuthal_path_sum(s : GeoprojazimuthalPath) -> Double { @_common.sum(s.data) }

pub fn geo_proj_azimuthal_path_mean(s : GeoprojazimuthalPath) -> Double { @_common.mean(s.data) }

pub fn geo_proj_azimuthal_path_scale(s : GeoprojazimuthalPath, f : Double) -> GeoprojazimuthalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_path_add(a : GeoprojazimuthalPath, b : GeoprojazimuthalPath) -> GeoprojazimuthalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_azimuthal_path_copy(s : GeoprojazimuthalPath) -> GeoprojazimuthalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_path_fill(s : GeoprojazimuthalPath, v : Double) -> GeoprojazimuthalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_path_min(s : GeoprojazimuthalPath) -> Double { @_common.min(s.data) }

pub fn geo_proj_azimuthal_path_max(s : GeoprojazimuthalPath) -> Double { @_common.max(s.data) }

pub fn geo_proj_azimuthal_path_to_string(s : GeoprojazimuthalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_cluster_make(size : Int) -> GeoprojazimuthalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_azimuthal_cluster_len(s : GeoprojazimuthalCluster) -> Int { s.size }

pub fn geo_proj_azimuthal_cluster_get(s : GeoprojazimuthalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_azimuthal_cluster_set(s : GeoprojazimuthalCluster, i : Int, v : Double) -> GeoprojazimuthalCluster {
  let result = geo_proj_azimuthal_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_azimuthal_cluster_sum(s : GeoprojazimuthalCluster) -> Double { @_common.sum(s.data) }

pub fn geo_proj_azimuthal_cluster_mean(s : GeoprojazimuthalCluster) -> Double { @_common.mean(s.data) }

pub fn geo_proj_azimuthal_cluster_scale(s : GeoprojazimuthalCluster, f : Double) -> GeoprojazimuthalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_cluster_add(a : GeoprojazimuthalCluster, b : GeoprojazimuthalCluster) -> GeoprojazimuthalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_azimuthal_cluster_copy(s : GeoprojazimuthalCluster) -> GeoprojazimuthalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_cluster_fill(s : GeoprojazimuthalCluster, v : Double) -> GeoprojazimuthalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_cluster_min(s : GeoprojazimuthalCluster) -> Double { @_common.min(s.data) }

pub fn geo_proj_azimuthal_cluster_max(s : GeoprojazimuthalCluster) -> Double { @_common.max(s.data) }

pub fn geo_proj_azimuthal_cluster_to_string(s : GeoprojazimuthalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_model_make(size : Int) -> GeoprojazimuthalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_azimuthal_model_len(s : GeoprojazimuthalModel) -> Int { s.size }

pub fn geo_proj_azimuthal_model_get(s : GeoprojazimuthalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_azimuthal_model_set(s : GeoprojazimuthalModel, i : Int, v : Double) -> GeoprojazimuthalModel {
  let result = geo_proj_azimuthal_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_azimuthal_model_sum(s : GeoprojazimuthalModel) -> Double { @_common.sum(s.data) }

pub fn geo_proj_azimuthal_model_mean(s : GeoprojazimuthalModel) -> Double { @_common.mean(s.data) }

pub fn geo_proj_azimuthal_model_scale(s : GeoprojazimuthalModel, f : Double) -> GeoprojazimuthalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_model_add(a : GeoprojazimuthalModel, b : GeoprojazimuthalModel) -> GeoprojazimuthalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_azimuthal_model_copy(s : GeoprojazimuthalModel) -> GeoprojazimuthalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_model_fill(s : GeoprojazimuthalModel, v : Double) -> GeoprojazimuthalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_model_min(s : GeoprojazimuthalModel) -> Double { @_common.min(s.data) }

pub fn geo_proj_azimuthal_model_max(s : GeoprojazimuthalModel) -> Double { @_common.max(s.data) }

pub fn geo_proj_azimuthal_model_to_string(s : GeoprojazimuthalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_layer_make(size : Int) -> GeoprojazimuthalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_azimuthal_layer_len(s : GeoprojazimuthalLayer) -> Int { s.size }

pub fn geo_proj_azimuthal_layer_get(s : GeoprojazimuthalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_azimuthal_layer_set(s : GeoprojazimuthalLayer, i : Int, v : Double) -> GeoprojazimuthalLayer {
  let result = geo_proj_azimuthal_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_azimuthal_layer_sum(s : GeoprojazimuthalLayer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_azimuthal_layer_mean(s : GeoprojazimuthalLayer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_azimuthal_layer_scale(s : GeoprojazimuthalLayer, f : Double) -> GeoprojazimuthalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_layer_add(a : GeoprojazimuthalLayer, b : GeoprojazimuthalLayer) -> GeoprojazimuthalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_azimuthal_layer_copy(s : GeoprojazimuthalLayer) -> GeoprojazimuthalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_layer_fill(s : GeoprojazimuthalLayer, v : Double) -> GeoprojazimuthalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_layer_min(s : GeoprojazimuthalLayer) -> Double { @_common.min(s.data) }

pub fn geo_proj_azimuthal_layer_max(s : GeoprojazimuthalLayer) -> Double { @_common.max(s.data) }

pub fn geo_proj_azimuthal_layer_to_string(s : GeoprojazimuthalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_buffer_make(size : Int) -> GeoprojazimuthalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_azimuthal_buffer_len(s : GeoprojazimuthalBuffer) -> Int { s.size }

pub fn geo_proj_azimuthal_buffer_get(s : GeoprojazimuthalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_azimuthal_buffer_set(s : GeoprojazimuthalBuffer, i : Int, v : Double) -> GeoprojazimuthalBuffer {
  let result = geo_proj_azimuthal_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_azimuthal_buffer_sum(s : GeoprojazimuthalBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_azimuthal_buffer_mean(s : GeoprojazimuthalBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_azimuthal_buffer_scale(s : GeoprojazimuthalBuffer, f : Double) -> GeoprojazimuthalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_buffer_add(a : GeoprojazimuthalBuffer, b : GeoprojazimuthalBuffer) -> GeoprojazimuthalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_azimuthal_buffer_copy(s : GeoprojazimuthalBuffer) -> GeoprojazimuthalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_buffer_fill(s : GeoprojazimuthalBuffer, v : Double) -> GeoprojazimuthalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_buffer_min(s : GeoprojazimuthalBuffer) -> Double { @_common.min(s.data) }

pub fn geo_proj_azimuthal_buffer_max(s : GeoprojazimuthalBuffer) -> Double { @_common.max(s.data) }

pub fn geo_proj_azimuthal_buffer_to_string(s : GeoprojazimuthalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_cursor_make(size : Int) -> GeoprojazimuthalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_azimuthal_cursor_len(s : GeoprojazimuthalCursor) -> Int { s.size }

pub fn geo_proj_azimuthal_cursor_get(s : GeoprojazimuthalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_azimuthal_cursor_set(s : GeoprojazimuthalCursor, i : Int, v : Double) -> GeoprojazimuthalCursor {
  let result = geo_proj_azimuthal_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_azimuthal_cursor_sum(s : GeoprojazimuthalCursor) -> Double { @_common.sum(s.data) }

pub fn geo_proj_azimuthal_cursor_mean(s : GeoprojazimuthalCursor) -> Double { @_common.mean(s.data) }

pub fn geo_proj_azimuthal_cursor_scale(s : GeoprojazimuthalCursor, f : Double) -> GeoprojazimuthalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_cursor_add(a : GeoprojazimuthalCursor, b : GeoprojazimuthalCursor) -> GeoprojazimuthalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_azimuthal_cursor_copy(s : GeoprojazimuthalCursor) -> GeoprojazimuthalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_cursor_fill(s : GeoprojazimuthalCursor, v : Double) -> GeoprojazimuthalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_cursor_min(s : GeoprojazimuthalCursor) -> Double { @_common.min(s.data) }

pub fn geo_proj_azimuthal_cursor_max(s : GeoprojazimuthalCursor) -> Double { @_common.max(s.data) }

pub fn geo_proj_azimuthal_cursor_to_string(s : GeoprojazimuthalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_view_make(size : Int) -> GeoprojazimuthalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_azimuthal_view_len(s : GeoprojazimuthalView) -> Int { s.size }

pub fn geo_proj_azimuthal_view_get(s : GeoprojazimuthalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_azimuthal_view_set(s : GeoprojazimuthalView, i : Int, v : Double) -> GeoprojazimuthalView {
  let result = geo_proj_azimuthal_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_azimuthal_view_sum(s : GeoprojazimuthalView) -> Double { @_common.sum(s.data) }

pub fn geo_proj_azimuthal_view_mean(s : GeoprojazimuthalView) -> Double { @_common.mean(s.data) }

pub fn geo_proj_azimuthal_view_scale(s : GeoprojazimuthalView, f : Double) -> GeoprojazimuthalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_view_add(a : GeoprojazimuthalView, b : GeoprojazimuthalView) -> GeoprojazimuthalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_azimuthal_view_copy(s : GeoprojazimuthalView) -> GeoprojazimuthalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_view_fill(s : GeoprojazimuthalView, v : Double) -> GeoprojazimuthalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_view_min(s : GeoprojazimuthalView) -> Double { @_common.min(s.data) }

pub fn geo_proj_azimuthal_view_max(s : GeoprojazimuthalView) -> Double { @_common.max(s.data) }

pub fn geo_proj_azimuthal_view_to_string(s : GeoprojazimuthalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_range_make(size : Int) -> GeoprojazimuthalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_azimuthal_range_len(s : GeoprojazimuthalRange) -> Int { s.size }

pub fn geo_proj_azimuthal_range_get(s : GeoprojazimuthalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_azimuthal_range_set(s : GeoprojazimuthalRange, i : Int, v : Double) -> GeoprojazimuthalRange {
  let result = geo_proj_azimuthal_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_azimuthal_range_sum(s : GeoprojazimuthalRange) -> Double { @_common.sum(s.data) }

pub fn geo_proj_azimuthal_range_mean(s : GeoprojazimuthalRange) -> Double { @_common.mean(s.data) }

pub fn geo_proj_azimuthal_range_scale(s : GeoprojazimuthalRange, f : Double) -> GeoprojazimuthalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_range_add(a : GeoprojazimuthalRange, b : GeoprojazimuthalRange) -> GeoprojazimuthalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_azimuthal_range_copy(s : GeoprojazimuthalRange) -> GeoprojazimuthalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_range_fill(s : GeoprojazimuthalRange, v : Double) -> GeoprojazimuthalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_range_min(s : GeoprojazimuthalRange) -> Double { @_common.min(s.data) }

pub fn geo_proj_azimuthal_range_max(s : GeoprojazimuthalRange) -> Double { @_common.max(s.data) }

pub fn geo_proj_azimuthal_range_to_string(s : GeoprojazimuthalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojazimuthalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_azimuthal_slice_make(size : Int) -> GeoprojazimuthalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_azimuthal_slice_len(s : GeoprojazimuthalSlice) -> Int { s.size }

pub fn geo_proj_azimuthal_slice_get(s : GeoprojazimuthalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_azimuthal_slice_set(s : GeoprojazimuthalSlice, i : Int, v : Double) -> GeoprojazimuthalSlice {
  let result = geo_proj_azimuthal_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_azimuthal_slice_sum(s : GeoprojazimuthalSlice) -> Double { @_common.sum(s.data) }

pub fn geo_proj_azimuthal_slice_mean(s : GeoprojazimuthalSlice) -> Double { @_common.mean(s.data) }

pub fn geo_proj_azimuthal_slice_scale(s : GeoprojazimuthalSlice, f : Double) -> GeoprojazimuthalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_slice_add(a : GeoprojazimuthalSlice, b : GeoprojazimuthalSlice) -> GeoprojazimuthalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_azimuthal_slice_copy(s : GeoprojazimuthalSlice) -> GeoprojazimuthalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_slice_fill(s : GeoprojazimuthalSlice, v : Double) -> GeoprojazimuthalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_azimuthal_slice_min(s : GeoprojazimuthalSlice) -> Double { @_common.min(s.data) }

pub fn geo_proj_azimuthal_slice_max(s : GeoprojazimuthalSlice) -> Double { @_common.max(s.data) }

pub fn geo_proj_azimuthal_slice_to_string(s : GeoprojazimuthalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

