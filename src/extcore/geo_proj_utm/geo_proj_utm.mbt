///===
/// extcore/geo_proj_utm

pub(all) struct GeoprojutmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_utm_make_point(x : Double, y : Double) -> GeoprojutmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_utm_make_point3(x : Double, y : Double, z : Double) -> GeoprojutmPoint {
  { x, y, z, label: 0 }
}

pub fn geo_proj_utm_point_x(pt : GeoprojutmPoint) -> Double { pt.x }

pub fn geo_proj_utm_point_y(pt : GeoprojutmPoint) -> Double { pt.y }

pub fn geo_proj_utm_point_z(pt : GeoprojutmPoint) -> Double { pt.z }

pub fn geo_proj_utm_point_label(pt : GeoprojutmPoint) -> Int { pt.label }

pub fn geo_proj_utm_point_dist(a : GeoprojutmPoint, b : GeoprojutmPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_proj_utm_point_add(a : GeoprojutmPoint, b : GeoprojutmPoint) -> GeoprojutmPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_proj_utm_point_sub(a : GeoprojutmPoint, b : GeoprojutmPoint) -> GeoprojutmPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_proj_utm_point_scale(pt : GeoprojutmPoint, s : Double) -> GeoprojutmPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_proj_utm_point_dot(a : GeoprojutmPoint, b : GeoprojutmPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_proj_utm_point_cross(a : GeoprojutmPoint, b : GeoprojutmPoint) -> GeoprojutmPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_proj_utm_point_norm(pt : GeoprojutmPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_proj_utm_point_normalize(pt : GeoprojutmPoint) -> GeoprojutmPoint {
  let n = geo_proj_utm_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_proj_utm_point_scale(pt, 1.0 / n) }
}

pub fn geo_proj_utm_point_negate(pt : GeoprojutmPoint) -> GeoprojutmPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_proj_utm_point_mid(a : GeoprojutmPoint, b : GeoprojutmPoint) -> GeoprojutmPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_proj_utm_point_lerp(a : GeoprojutmPoint, b : GeoprojutmPoint, t : Double) -> GeoprojutmPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_proj_utm_point_to_string(pt : GeoprojutmPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeoprojutmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_utm_make_series(vals : Array[Double], name : String) -> GeoprojutmSeries {
  { vals, name, meta: 0 }
}

pub fn geo_proj_utm_series_len(s : GeoprojutmSeries) -> Int { s.vals.length() }

pub fn geo_proj_utm_series_sum(s : GeoprojutmSeries) -> Double { @_common.sum(s.vals) }

pub fn geo_proj_utm_series_mean(s : GeoprojutmSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_proj_utm_series_min(s : GeoprojutmSeries) -> Double { @_common.min(s.vals) }

pub fn geo_proj_utm_series_max(s : GeoprojutmSeries) -> Double { @_common.max(s.vals) }

pub fn geo_proj_utm_series_range(s : GeoprojutmSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_proj_utm_series_var(s : GeoprojutmSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_proj_utm_series_std(s : GeoprojutmSeries) -> Double { @_common.std(s.vals) }

pub fn geo_proj_utm_series_median(s : GeoprojutmSeries) -> Double { @_common.median(s.vals) }

pub fn geo_proj_utm_series_scale(s : GeoprojutmSeries, f : Double) -> GeoprojutmSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_proj_utm_series_add(a : GeoprojutmSeries, b : GeoprojutmSeries) -> GeoprojutmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_proj_utm_series_sub(a : GeoprojutmSeries, b : GeoprojutmSeries) -> GeoprojutmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_proj_utm_series_normalize(s : GeoprojutmSeries) -> GeoprojutmSeries {
  let mn = geo_proj_utm_series_min(s)
  let mx = geo_proj_utm_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_proj_utm_series_cumsum(s : GeoprojutmSeries) -> GeoprojutmSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_proj_utm_series_to_string(s : GeoprojutmSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojutmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_utm_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojutmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_utm_matrix_identity(n : Int) -> GeoprojutmMatrix {
  let m = geo_proj_utm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_proj_utm_matrix_get(m : GeoprojutmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_proj_utm_matrix_transpose(m : GeoprojutmMatrix) -> GeoprojutmMatrix {
  let result = geo_proj_utm_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_proj_utm_matrix_add(a : GeoprojutmMatrix, b : GeoprojutmMatrix) -> GeoprojutmMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_proj_utm_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_proj_utm_matrix_scale(m : GeoprojutmMatrix, s : Double) -> GeoprojutmMatrix {
  let result = geo_proj_utm_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_proj_utm_matrix_multiply(a : GeoprojutmMatrix, b : GeoprojutmMatrix) -> GeoprojutmMatrix {
  if a.cols != b.rows { return geo_proj_utm_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_proj_utm_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_proj_utm_matrix_trace(m : GeoprojutmMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_proj_utm_matrix_det(m : GeoprojutmMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_proj_utm_matrix_norm(m : GeoprojutmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_proj_utm_matrix_to_string(m : GeoprojutmMatrix) -> String {
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

pub(all) struct GeoprojutmVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_utm_make_vector(comps : Array[Double]) -> GeoprojutmVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_utm_vector_zero(dim : Int) -> GeoprojutmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_proj_utm_vector_add(a : GeoprojutmVector, b : GeoprojutmVector) -> GeoprojutmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_proj_utm_vector_sub(a : GeoprojutmVector, b : GeoprojutmVector) -> GeoprojutmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_proj_utm_vector_scale(v : GeoprojutmVector, s : Double) -> GeoprojutmVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_proj_utm_vector_dot(a : GeoprojutmVector, b : GeoprojutmVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_proj_utm_vector_norm(v : GeoprojutmVector) -> Double { @_common.sqrt(geo_proj_utm_vector_dot(v, v)) }

pub fn geo_proj_utm_vector_normalize(v : GeoprojutmVector) -> GeoprojutmVector {
  let n = geo_proj_utm_vector_norm(v)
  if n < 0.0000001 { v } else { geo_proj_utm_vector_scale(v, 1.0 / n) }
}

pub fn geo_proj_utm_vector_dist(a : GeoprojutmVector, b : GeoprojutmVector) -> Double {
  geo_proj_utm_vector_norm(geo_proj_utm_vector_sub(a, b))
}

pub fn geo_proj_utm_vector_to_string(v : GeoprojutmVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_utm_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_proj_utm_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_proj_utm_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_proj_utm_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_proj_utm_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_proj_utm_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_proj_utm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_proj_utm_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_proj_utm_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_proj_utm_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_proj_utm_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_proj_utm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_proj_utm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_proj_utm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_proj_utm_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_proj_utm_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_proj_utm_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_proj_utm_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_proj_utm_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_proj_utm_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_proj_utm_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_proj_utm_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_proj_utm_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_proj_utm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_proj_utm_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_proj_utm_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_proj_utm_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_proj_utm_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_proj_utm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeoprojutmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_frame_make(size : Int) -> GeoprojutmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_frame_len(s : GeoprojutmFrame) -> Int { s.size }

pub fn geo_proj_utm_frame_get(s : GeoprojutmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_frame_set(s : GeoprojutmFrame, i : Int, v : Double) -> GeoprojutmFrame {
  let result = geo_proj_utm_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_utm_frame_sum(s : GeoprojutmFrame) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_frame_mean(s : GeoprojutmFrame) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_frame_scale(s : GeoprojutmFrame, f : Double) -> GeoprojutmFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_frame_add(a : GeoprojutmFrame, b : GeoprojutmFrame) -> GeoprojutmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_frame_copy(s : GeoprojutmFrame) -> GeoprojutmFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_frame_fill(s : GeoprojutmFrame, v : Double) -> GeoprojutmFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_frame_min(s : GeoprojutmFrame) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_frame_max(s : GeoprojutmFrame) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_frame_to_string(s : GeoprojutmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_table_make(size : Int) -> GeoprojutmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_table_len(s : GeoprojutmTable) -> Int { s.size }

pub fn geo_proj_utm_table_get(s : GeoprojutmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_table_set(s : GeoprojutmTable, i : Int, v : Double) -> GeoprojutmTable {
  let result = geo_proj_utm_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_utm_table_sum(s : GeoprojutmTable) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_table_mean(s : GeoprojutmTable) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_table_scale(s : GeoprojutmTable, f : Double) -> GeoprojutmTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_table_add(a : GeoprojutmTable, b : GeoprojutmTable) -> GeoprojutmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_table_copy(s : GeoprojutmTable) -> GeoprojutmTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_table_fill(s : GeoprojutmTable, v : Double) -> GeoprojutmTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_table_min(s : GeoprojutmTable) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_table_max(s : GeoprojutmTable) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_table_to_string(s : GeoprojutmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_graphn_make(size : Int) -> GeoprojutmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_graphn_len(s : GeoprojutmGraphN) -> Int { s.size }

pub fn geo_proj_utm_graphn_get(s : GeoprojutmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_graphn_set(s : GeoprojutmGraphN, i : Int, v : Double) -> GeoprojutmGraphN {
  let result = geo_proj_utm_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_utm_graphn_sum(s : GeoprojutmGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_graphn_mean(s : GeoprojutmGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_graphn_scale(s : GeoprojutmGraphN, f : Double) -> GeoprojutmGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_graphn_add(a : GeoprojutmGraphN, b : GeoprojutmGraphN) -> GeoprojutmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_graphn_copy(s : GeoprojutmGraphN) -> GeoprojutmGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_graphn_fill(s : GeoprojutmGraphN, v : Double) -> GeoprojutmGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_graphn_min(s : GeoprojutmGraphN) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_graphn_max(s : GeoprojutmGraphN) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_graphn_to_string(s : GeoprojutmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_node_make(size : Int) -> GeoprojutmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_node_len(s : GeoprojutmNode) -> Int { s.size }

pub fn geo_proj_utm_node_get(s : GeoprojutmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_node_set(s : GeoprojutmNode, i : Int, v : Double) -> GeoprojutmNode {
  let result = geo_proj_utm_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_utm_node_sum(s : GeoprojutmNode) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_node_mean(s : GeoprojutmNode) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_node_scale(s : GeoprojutmNode, f : Double) -> GeoprojutmNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_node_add(a : GeoprojutmNode, b : GeoprojutmNode) -> GeoprojutmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_node_copy(s : GeoprojutmNode) -> GeoprojutmNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_node_fill(s : GeoprojutmNode, v : Double) -> GeoprojutmNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_node_min(s : GeoprojutmNode) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_node_max(s : GeoprojutmNode) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_node_to_string(s : GeoprojutmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_edge_make(size : Int) -> GeoprojutmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_edge_len(s : GeoprojutmEdge) -> Int { s.size }

pub fn geo_proj_utm_edge_get(s : GeoprojutmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_edge_set(s : GeoprojutmEdge, i : Int, v : Double) -> GeoprojutmEdge {
  let result = geo_proj_utm_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_utm_edge_sum(s : GeoprojutmEdge) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_edge_mean(s : GeoprojutmEdge) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_edge_scale(s : GeoprojutmEdge, f : Double) -> GeoprojutmEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_edge_add(a : GeoprojutmEdge, b : GeoprojutmEdge) -> GeoprojutmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_edge_copy(s : GeoprojutmEdge) -> GeoprojutmEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_edge_fill(s : GeoprojutmEdge, v : Double) -> GeoprojutmEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_edge_min(s : GeoprojutmEdge) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_edge_max(s : GeoprojutmEdge) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_edge_to_string(s : GeoprojutmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_path_make(size : Int) -> GeoprojutmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_path_len(s : GeoprojutmPath) -> Int { s.size }

pub fn geo_proj_utm_path_get(s : GeoprojutmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_path_set(s : GeoprojutmPath, i : Int, v : Double) -> GeoprojutmPath {
  let result = geo_proj_utm_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_utm_path_sum(s : GeoprojutmPath) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_path_mean(s : GeoprojutmPath) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_path_scale(s : GeoprojutmPath, f : Double) -> GeoprojutmPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_path_add(a : GeoprojutmPath, b : GeoprojutmPath) -> GeoprojutmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_path_copy(s : GeoprojutmPath) -> GeoprojutmPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_path_fill(s : GeoprojutmPath, v : Double) -> GeoprojutmPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_path_min(s : GeoprojutmPath) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_path_max(s : GeoprojutmPath) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_path_to_string(s : GeoprojutmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_cluster_make(size : Int) -> GeoprojutmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_cluster_len(s : GeoprojutmCluster) -> Int { s.size }

pub fn geo_proj_utm_cluster_get(s : GeoprojutmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_cluster_set(s : GeoprojutmCluster, i : Int, v : Double) -> GeoprojutmCluster {
  let result = geo_proj_utm_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_utm_cluster_sum(s : GeoprojutmCluster) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_cluster_mean(s : GeoprojutmCluster) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_cluster_scale(s : GeoprojutmCluster, f : Double) -> GeoprojutmCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_cluster_add(a : GeoprojutmCluster, b : GeoprojutmCluster) -> GeoprojutmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_cluster_copy(s : GeoprojutmCluster) -> GeoprojutmCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_cluster_fill(s : GeoprojutmCluster, v : Double) -> GeoprojutmCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_cluster_min(s : GeoprojutmCluster) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_cluster_max(s : GeoprojutmCluster) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_cluster_to_string(s : GeoprojutmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_model_make(size : Int) -> GeoprojutmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_model_len(s : GeoprojutmModel) -> Int { s.size }

pub fn geo_proj_utm_model_get(s : GeoprojutmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_model_set(s : GeoprojutmModel, i : Int, v : Double) -> GeoprojutmModel {
  let result = geo_proj_utm_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_utm_model_sum(s : GeoprojutmModel) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_model_mean(s : GeoprojutmModel) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_model_scale(s : GeoprojutmModel, f : Double) -> GeoprojutmModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_model_add(a : GeoprojutmModel, b : GeoprojutmModel) -> GeoprojutmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_model_copy(s : GeoprojutmModel) -> GeoprojutmModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_model_fill(s : GeoprojutmModel, v : Double) -> GeoprojutmModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_model_min(s : GeoprojutmModel) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_model_max(s : GeoprojutmModel) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_model_to_string(s : GeoprojutmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_layer_make(size : Int) -> GeoprojutmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_layer_len(s : GeoprojutmLayer) -> Int { s.size }

pub fn geo_proj_utm_layer_get(s : GeoprojutmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_layer_set(s : GeoprojutmLayer, i : Int, v : Double) -> GeoprojutmLayer {
  let result = geo_proj_utm_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_utm_layer_sum(s : GeoprojutmLayer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_layer_mean(s : GeoprojutmLayer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_layer_scale(s : GeoprojutmLayer, f : Double) -> GeoprojutmLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_layer_add(a : GeoprojutmLayer, b : GeoprojutmLayer) -> GeoprojutmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_layer_copy(s : GeoprojutmLayer) -> GeoprojutmLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_layer_fill(s : GeoprojutmLayer, v : Double) -> GeoprojutmLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_layer_min(s : GeoprojutmLayer) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_layer_max(s : GeoprojutmLayer) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_layer_to_string(s : GeoprojutmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_buffer_make(size : Int) -> GeoprojutmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_buffer_len(s : GeoprojutmBuffer) -> Int { s.size }

pub fn geo_proj_utm_buffer_get(s : GeoprojutmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_buffer_set(s : GeoprojutmBuffer, i : Int, v : Double) -> GeoprojutmBuffer {
  let result = geo_proj_utm_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_utm_buffer_sum(s : GeoprojutmBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_buffer_mean(s : GeoprojutmBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_buffer_scale(s : GeoprojutmBuffer, f : Double) -> GeoprojutmBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_buffer_add(a : GeoprojutmBuffer, b : GeoprojutmBuffer) -> GeoprojutmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_buffer_copy(s : GeoprojutmBuffer) -> GeoprojutmBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_buffer_fill(s : GeoprojutmBuffer, v : Double) -> GeoprojutmBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_buffer_min(s : GeoprojutmBuffer) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_buffer_max(s : GeoprojutmBuffer) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_buffer_to_string(s : GeoprojutmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_cursor_make(size : Int) -> GeoprojutmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_cursor_len(s : GeoprojutmCursor) -> Int { s.size }

pub fn geo_proj_utm_cursor_get(s : GeoprojutmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_cursor_set(s : GeoprojutmCursor, i : Int, v : Double) -> GeoprojutmCursor {
  let result = geo_proj_utm_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_utm_cursor_sum(s : GeoprojutmCursor) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_cursor_mean(s : GeoprojutmCursor) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_cursor_scale(s : GeoprojutmCursor, f : Double) -> GeoprojutmCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_cursor_add(a : GeoprojutmCursor, b : GeoprojutmCursor) -> GeoprojutmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_cursor_copy(s : GeoprojutmCursor) -> GeoprojutmCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_cursor_fill(s : GeoprojutmCursor, v : Double) -> GeoprojutmCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_cursor_min(s : GeoprojutmCursor) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_cursor_max(s : GeoprojutmCursor) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_cursor_to_string(s : GeoprojutmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_view_make(size : Int) -> GeoprojutmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_view_len(s : GeoprojutmView) -> Int { s.size }

pub fn geo_proj_utm_view_get(s : GeoprojutmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_view_set(s : GeoprojutmView, i : Int, v : Double) -> GeoprojutmView {
  let result = geo_proj_utm_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_utm_view_sum(s : GeoprojutmView) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_view_mean(s : GeoprojutmView) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_view_scale(s : GeoprojutmView, f : Double) -> GeoprojutmView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_view_add(a : GeoprojutmView, b : GeoprojutmView) -> GeoprojutmView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_view_copy(s : GeoprojutmView) -> GeoprojutmView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_view_fill(s : GeoprojutmView, v : Double) -> GeoprojutmView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_view_min(s : GeoprojutmView) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_view_max(s : GeoprojutmView) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_view_to_string(s : GeoprojutmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_range_make(size : Int) -> GeoprojutmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_range_len(s : GeoprojutmRange) -> Int { s.size }

pub fn geo_proj_utm_range_get(s : GeoprojutmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_range_set(s : GeoprojutmRange, i : Int, v : Double) -> GeoprojutmRange {
  let result = geo_proj_utm_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_utm_range_sum(s : GeoprojutmRange) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_range_mean(s : GeoprojutmRange) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_range_scale(s : GeoprojutmRange, f : Double) -> GeoprojutmRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_range_add(a : GeoprojutmRange, b : GeoprojutmRange) -> GeoprojutmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_range_copy(s : GeoprojutmRange) -> GeoprojutmRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_range_fill(s : GeoprojutmRange, v : Double) -> GeoprojutmRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_range_min(s : GeoprojutmRange) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_range_max(s : GeoprojutmRange) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_range_to_string(s : GeoprojutmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojutmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_utm_slice_make(size : Int) -> GeoprojutmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_utm_slice_len(s : GeoprojutmSlice) -> Int { s.size }

pub fn geo_proj_utm_slice_get(s : GeoprojutmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_utm_slice_set(s : GeoprojutmSlice, i : Int, v : Double) -> GeoprojutmSlice {
  let result = geo_proj_utm_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_utm_slice_sum(s : GeoprojutmSlice) -> Double { @_common.sum(s.data) }

pub fn geo_proj_utm_slice_mean(s : GeoprojutmSlice) -> Double { @_common.mean(s.data) }

pub fn geo_proj_utm_slice_scale(s : GeoprojutmSlice, f : Double) -> GeoprojutmSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_slice_add(a : GeoprojutmSlice, b : GeoprojutmSlice) -> GeoprojutmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_utm_slice_copy(s : GeoprojutmSlice) -> GeoprojutmSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_slice_fill(s : GeoprojutmSlice, v : Double) -> GeoprojutmSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_utm_slice_min(s : GeoprojutmSlice) -> Double { @_common.min(s.data) }

pub fn geo_proj_utm_slice_max(s : GeoprojutmSlice) -> Double { @_common.max(s.data) }

pub fn geo_proj_utm_slice_to_string(s : GeoprojutmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

