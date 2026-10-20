///===
/// extcore/geo_proj_conic

pub(all) struct GeoprojconicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_conic_make_point(x : Double, y : Double) -> GeoprojconicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_conic_make_point3(x : Double, y : Double, z : Double) -> GeoprojconicPoint {
  { x, y, z, label: 0 }
}

pub fn geo_proj_conic_point_x(pt : GeoprojconicPoint) -> Double { pt.x }

pub fn geo_proj_conic_point_y(pt : GeoprojconicPoint) -> Double { pt.y }

pub fn geo_proj_conic_point_z(pt : GeoprojconicPoint) -> Double { pt.z }

pub fn geo_proj_conic_point_label(pt : GeoprojconicPoint) -> Int { pt.label }

pub fn geo_proj_conic_point_dist(a : GeoprojconicPoint, b : GeoprojconicPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_proj_conic_point_add(a : GeoprojconicPoint, b : GeoprojconicPoint) -> GeoprojconicPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_proj_conic_point_sub(a : GeoprojconicPoint, b : GeoprojconicPoint) -> GeoprojconicPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_proj_conic_point_scale(pt : GeoprojconicPoint, s : Double) -> GeoprojconicPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_proj_conic_point_dot(a : GeoprojconicPoint, b : GeoprojconicPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_proj_conic_point_cross(a : GeoprojconicPoint, b : GeoprojconicPoint) -> GeoprojconicPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_proj_conic_point_norm(pt : GeoprojconicPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_proj_conic_point_normalize(pt : GeoprojconicPoint) -> GeoprojconicPoint {
  let n = geo_proj_conic_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_proj_conic_point_scale(pt, 1.0 / n) }
}

pub fn geo_proj_conic_point_negate(pt : GeoprojconicPoint) -> GeoprojconicPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_proj_conic_point_mid(a : GeoprojconicPoint, b : GeoprojconicPoint) -> GeoprojconicPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_proj_conic_point_lerp(a : GeoprojconicPoint, b : GeoprojconicPoint, t : Double) -> GeoprojconicPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_proj_conic_point_to_string(pt : GeoprojconicPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeoprojconicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_conic_make_series(vals : Array[Double], name : String) -> GeoprojconicSeries {
  { vals, name, meta: 0 }
}

pub fn geo_proj_conic_series_len(s : GeoprojconicSeries) -> Int { s.vals.length() }

pub fn geo_proj_conic_series_sum(s : GeoprojconicSeries) -> Double { @_common.sum(s.vals) }

pub fn geo_proj_conic_series_mean(s : GeoprojconicSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_proj_conic_series_min(s : GeoprojconicSeries) -> Double { @_common.min(s.vals) }

pub fn geo_proj_conic_series_max(s : GeoprojconicSeries) -> Double { @_common.max(s.vals) }

pub fn geo_proj_conic_series_range(s : GeoprojconicSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_proj_conic_series_var(s : GeoprojconicSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_proj_conic_series_std(s : GeoprojconicSeries) -> Double { @_common.std(s.vals) }

pub fn geo_proj_conic_series_median(s : GeoprojconicSeries) -> Double { @_common.median(s.vals) }

pub fn geo_proj_conic_series_scale(s : GeoprojconicSeries, f : Double) -> GeoprojconicSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_proj_conic_series_add(a : GeoprojconicSeries, b : GeoprojconicSeries) -> GeoprojconicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_proj_conic_series_sub(a : GeoprojconicSeries, b : GeoprojconicSeries) -> GeoprojconicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_proj_conic_series_normalize(s : GeoprojconicSeries) -> GeoprojconicSeries {
  let mn = geo_proj_conic_series_min(s)
  let mx = geo_proj_conic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_proj_conic_series_cumsum(s : GeoprojconicSeries) -> GeoprojconicSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_proj_conic_series_to_string(s : GeoprojconicSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojconicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_conic_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojconicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_conic_matrix_identity(n : Int) -> GeoprojconicMatrix {
  let m = geo_proj_conic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_proj_conic_matrix_get(m : GeoprojconicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_proj_conic_matrix_transpose(m : GeoprojconicMatrix) -> GeoprojconicMatrix {
  let result = geo_proj_conic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_proj_conic_matrix_add(a : GeoprojconicMatrix, b : GeoprojconicMatrix) -> GeoprojconicMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_proj_conic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_proj_conic_matrix_scale(m : GeoprojconicMatrix, s : Double) -> GeoprojconicMatrix {
  let result = geo_proj_conic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_proj_conic_matrix_multiply(a : GeoprojconicMatrix, b : GeoprojconicMatrix) -> GeoprojconicMatrix {
  if a.cols != b.rows { return geo_proj_conic_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_proj_conic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_proj_conic_matrix_trace(m : GeoprojconicMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_proj_conic_matrix_det(m : GeoprojconicMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_proj_conic_matrix_norm(m : GeoprojconicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_proj_conic_matrix_to_string(m : GeoprojconicMatrix) -> String {
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

pub(all) struct GeoprojconicVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_conic_make_vector(comps : Array[Double]) -> GeoprojconicVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_conic_vector_zero(dim : Int) -> GeoprojconicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_proj_conic_vector_add(a : GeoprojconicVector, b : GeoprojconicVector) -> GeoprojconicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_proj_conic_vector_sub(a : GeoprojconicVector, b : GeoprojconicVector) -> GeoprojconicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_proj_conic_vector_scale(v : GeoprojconicVector, s : Double) -> GeoprojconicVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_proj_conic_vector_dot(a : GeoprojconicVector, b : GeoprojconicVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_proj_conic_vector_norm(v : GeoprojconicVector) -> Double { @_common.sqrt(geo_proj_conic_vector_dot(v, v)) }

pub fn geo_proj_conic_vector_normalize(v : GeoprojconicVector) -> GeoprojconicVector {
  let n = geo_proj_conic_vector_norm(v)
  if n < 0.0000001 { v } else { geo_proj_conic_vector_scale(v, 1.0 / n) }
}

pub fn geo_proj_conic_vector_dist(a : GeoprojconicVector, b : GeoprojconicVector) -> Double {
  geo_proj_conic_vector_norm(geo_proj_conic_vector_sub(a, b))
}

pub fn geo_proj_conic_vector_to_string(v : GeoprojconicVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_conic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_proj_conic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_proj_conic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_proj_conic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_proj_conic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_proj_conic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_proj_conic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_proj_conic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_proj_conic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_proj_conic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_proj_conic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_proj_conic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_proj_conic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_proj_conic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_proj_conic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_proj_conic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_proj_conic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_proj_conic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_proj_conic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_proj_conic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_proj_conic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_proj_conic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_proj_conic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_proj_conic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_proj_conic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_proj_conic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_proj_conic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_proj_conic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_proj_conic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeoprojconicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_frame_make(size : Int) -> GeoprojconicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_frame_len(s : GeoprojconicFrame) -> Int { s.size }

pub fn geo_proj_conic_frame_get(s : GeoprojconicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_frame_set(s : GeoprojconicFrame, i : Int, v : Double) -> GeoprojconicFrame {
  let result = geo_proj_conic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_frame_sum(s : GeoprojconicFrame) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_frame_mean(s : GeoprojconicFrame) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_frame_scale(s : GeoprojconicFrame, f : Double) -> GeoprojconicFrame {
  let result = geo_proj_conic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_conic_frame_add(a : GeoprojconicFrame, b : GeoprojconicFrame) -> GeoprojconicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_conic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_conic_frame_copy(s : GeoprojconicFrame) -> GeoprojconicFrame {
  let result = geo_proj_conic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_conic_frame_fill(s : GeoprojconicFrame, v : Double) -> GeoprojconicFrame {
  let result = geo_proj_conic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_frame_min(s : GeoprojconicFrame) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_frame_max(s : GeoprojconicFrame) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_frame_to_string(s : GeoprojconicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_table_make(size : Int) -> GeoprojconicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_table_len(s : GeoprojconicTable) -> Int { s.size }

pub fn geo_proj_conic_table_get(s : GeoprojconicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_table_set(s : GeoprojconicTable, i : Int, v : Double) -> GeoprojconicTable {
  let result = geo_proj_conic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_table_sum(s : GeoprojconicTable) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_table_mean(s : GeoprojconicTable) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_table_scale(s : GeoprojconicTable, f : Double) -> GeoprojconicTable {
  let result = geo_proj_conic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_conic_table_add(a : GeoprojconicTable, b : GeoprojconicTable) -> GeoprojconicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_conic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_conic_table_copy(s : GeoprojconicTable) -> GeoprojconicTable {
  let result = geo_proj_conic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_conic_table_fill(s : GeoprojconicTable, v : Double) -> GeoprojconicTable {
  let result = geo_proj_conic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_table_min(s : GeoprojconicTable) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_table_max(s : GeoprojconicTable) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_table_to_string(s : GeoprojconicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_graphn_make(size : Int) -> GeoprojconicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_graphn_len(s : GeoprojconicGraphN) -> Int { s.size }

pub fn geo_proj_conic_graphn_get(s : GeoprojconicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_graphn_set(s : GeoprojconicGraphN, i : Int, v : Double) -> GeoprojconicGraphN {
  let result = geo_proj_conic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_graphn_sum(s : GeoprojconicGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_graphn_mean(s : GeoprojconicGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_graphn_scale(s : GeoprojconicGraphN, f : Double) -> GeoprojconicGraphN {
  let result = geo_proj_conic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_conic_graphn_add(a : GeoprojconicGraphN, b : GeoprojconicGraphN) -> GeoprojconicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_conic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_conic_graphn_copy(s : GeoprojconicGraphN) -> GeoprojconicGraphN {
  let result = geo_proj_conic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_conic_graphn_fill(s : GeoprojconicGraphN, v : Double) -> GeoprojconicGraphN {
  let result = geo_proj_conic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_graphn_min(s : GeoprojconicGraphN) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_graphn_max(s : GeoprojconicGraphN) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_graphn_to_string(s : GeoprojconicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_node_make(size : Int) -> GeoprojconicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_node_len(s : GeoprojconicNode) -> Int { s.size }

pub fn geo_proj_conic_node_get(s : GeoprojconicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_node_set(s : GeoprojconicNode, i : Int, v : Double) -> GeoprojconicNode {
  let result = geo_proj_conic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_node_sum(s : GeoprojconicNode) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_node_mean(s : GeoprojconicNode) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_node_scale(s : GeoprojconicNode, f : Double) -> GeoprojconicNode {
  let result = geo_proj_conic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_conic_node_add(a : GeoprojconicNode, b : GeoprojconicNode) -> GeoprojconicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_conic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_conic_node_copy(s : GeoprojconicNode) -> GeoprojconicNode {
  let result = geo_proj_conic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_conic_node_fill(s : GeoprojconicNode, v : Double) -> GeoprojconicNode {
  let result = geo_proj_conic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_node_min(s : GeoprojconicNode) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_node_max(s : GeoprojconicNode) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_node_to_string(s : GeoprojconicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_edge_make(size : Int) -> GeoprojconicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_edge_len(s : GeoprojconicEdge) -> Int { s.size }

pub fn geo_proj_conic_edge_get(s : GeoprojconicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_edge_set(s : GeoprojconicEdge, i : Int, v : Double) -> GeoprojconicEdge {
  let result = geo_proj_conic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_edge_sum(s : GeoprojconicEdge) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_edge_mean(s : GeoprojconicEdge) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_edge_scale(s : GeoprojconicEdge, f : Double) -> GeoprojconicEdge {
  let result = geo_proj_conic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_conic_edge_add(a : GeoprojconicEdge, b : GeoprojconicEdge) -> GeoprojconicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_conic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_conic_edge_copy(s : GeoprojconicEdge) -> GeoprojconicEdge {
  let result = geo_proj_conic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_conic_edge_fill(s : GeoprojconicEdge, v : Double) -> GeoprojconicEdge {
  let result = geo_proj_conic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_edge_min(s : GeoprojconicEdge) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_edge_max(s : GeoprojconicEdge) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_edge_to_string(s : GeoprojconicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_path_make(size : Int) -> GeoprojconicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_path_len(s : GeoprojconicPath) -> Int { s.size }

pub fn geo_proj_conic_path_get(s : GeoprojconicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_path_set(s : GeoprojconicPath, i : Int, v : Double) -> GeoprojconicPath {
  let result = geo_proj_conic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_path_sum(s : GeoprojconicPath) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_path_mean(s : GeoprojconicPath) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_path_scale(s : GeoprojconicPath, f : Double) -> GeoprojconicPath {
  let result = geo_proj_conic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_conic_path_add(a : GeoprojconicPath, b : GeoprojconicPath) -> GeoprojconicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_conic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_conic_path_copy(s : GeoprojconicPath) -> GeoprojconicPath {
  let result = geo_proj_conic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_conic_path_fill(s : GeoprojconicPath, v : Double) -> GeoprojconicPath {
  let result = geo_proj_conic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_path_min(s : GeoprojconicPath) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_path_max(s : GeoprojconicPath) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_path_to_string(s : GeoprojconicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_cluster_make(size : Int) -> GeoprojconicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_cluster_len(s : GeoprojconicCluster) -> Int { s.size }

pub fn geo_proj_conic_cluster_get(s : GeoprojconicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_cluster_set(s : GeoprojconicCluster, i : Int, v : Double) -> GeoprojconicCluster {
  let result = geo_proj_conic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_cluster_sum(s : GeoprojconicCluster) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_cluster_mean(s : GeoprojconicCluster) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_cluster_scale(s : GeoprojconicCluster, f : Double) -> GeoprojconicCluster {
  let result = geo_proj_conic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_conic_cluster_add(a : GeoprojconicCluster, b : GeoprojconicCluster) -> GeoprojconicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_conic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_conic_cluster_copy(s : GeoprojconicCluster) -> GeoprojconicCluster {
  let result = geo_proj_conic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_conic_cluster_fill(s : GeoprojconicCluster, v : Double) -> GeoprojconicCluster {
  let result = geo_proj_conic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_cluster_min(s : GeoprojconicCluster) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_cluster_max(s : GeoprojconicCluster) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_cluster_to_string(s : GeoprojconicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_model_make(size : Int) -> GeoprojconicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_model_len(s : GeoprojconicModel) -> Int { s.size }

pub fn geo_proj_conic_model_get(s : GeoprojconicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_model_set(s : GeoprojconicModel, i : Int, v : Double) -> GeoprojconicModel {
  let result = geo_proj_conic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_model_sum(s : GeoprojconicModel) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_model_mean(s : GeoprojconicModel) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_model_scale(s : GeoprojconicModel, f : Double) -> GeoprojconicModel {
  let result = geo_proj_conic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_conic_model_add(a : GeoprojconicModel, b : GeoprojconicModel) -> GeoprojconicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_conic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_conic_model_copy(s : GeoprojconicModel) -> GeoprojconicModel {
  let result = geo_proj_conic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_conic_model_fill(s : GeoprojconicModel, v : Double) -> GeoprojconicModel {
  let result = geo_proj_conic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_model_min(s : GeoprojconicModel) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_model_max(s : GeoprojconicModel) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_model_to_string(s : GeoprojconicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_layer_make(size : Int) -> GeoprojconicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_layer_len(s : GeoprojconicLayer) -> Int { s.size }

pub fn geo_proj_conic_layer_get(s : GeoprojconicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_layer_set(s : GeoprojconicLayer, i : Int, v : Double) -> GeoprojconicLayer {
  let result = geo_proj_conic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_layer_sum(s : GeoprojconicLayer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_layer_mean(s : GeoprojconicLayer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_layer_scale(s : GeoprojconicLayer, f : Double) -> GeoprojconicLayer {
  let result = geo_proj_conic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_conic_layer_add(a : GeoprojconicLayer, b : GeoprojconicLayer) -> GeoprojconicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_conic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_conic_layer_copy(s : GeoprojconicLayer) -> GeoprojconicLayer {
  let result = geo_proj_conic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_conic_layer_fill(s : GeoprojconicLayer, v : Double) -> GeoprojconicLayer {
  let result = geo_proj_conic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_layer_min(s : GeoprojconicLayer) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_layer_max(s : GeoprojconicLayer) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_layer_to_string(s : GeoprojconicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_buffer_make(size : Int) -> GeoprojconicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_buffer_len(s : GeoprojconicBuffer) -> Int { s.size }

pub fn geo_proj_conic_buffer_get(s : GeoprojconicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_buffer_set(s : GeoprojconicBuffer, i : Int, v : Double) -> GeoprojconicBuffer {
  let result = geo_proj_conic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_buffer_sum(s : GeoprojconicBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_buffer_mean(s : GeoprojconicBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_buffer_scale(s : GeoprojconicBuffer, f : Double) -> GeoprojconicBuffer {
  let result = geo_proj_conic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_conic_buffer_add(a : GeoprojconicBuffer, b : GeoprojconicBuffer) -> GeoprojconicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_conic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_conic_buffer_copy(s : GeoprojconicBuffer) -> GeoprojconicBuffer {
  let result = geo_proj_conic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_conic_buffer_fill(s : GeoprojconicBuffer, v : Double) -> GeoprojconicBuffer {
  let result = geo_proj_conic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_buffer_min(s : GeoprojconicBuffer) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_buffer_max(s : GeoprojconicBuffer) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_buffer_to_string(s : GeoprojconicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_cursor_make(size : Int) -> GeoprojconicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_cursor_len(s : GeoprojconicCursor) -> Int { s.size }

pub fn geo_proj_conic_cursor_get(s : GeoprojconicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_cursor_set(s : GeoprojconicCursor, i : Int, v : Double) -> GeoprojconicCursor {
  let result = geo_proj_conic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_cursor_sum(s : GeoprojconicCursor) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_cursor_mean(s : GeoprojconicCursor) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_cursor_scale(s : GeoprojconicCursor, f : Double) -> GeoprojconicCursor {
  let result = geo_proj_conic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_conic_cursor_add(a : GeoprojconicCursor, b : GeoprojconicCursor) -> GeoprojconicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_conic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_conic_cursor_copy(s : GeoprojconicCursor) -> GeoprojconicCursor {
  let result = geo_proj_conic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_conic_cursor_fill(s : GeoprojconicCursor, v : Double) -> GeoprojconicCursor {
  let result = geo_proj_conic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_cursor_min(s : GeoprojconicCursor) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_cursor_max(s : GeoprojconicCursor) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_cursor_to_string(s : GeoprojconicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_view_make(size : Int) -> GeoprojconicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_view_len(s : GeoprojconicView) -> Int { s.size }

pub fn geo_proj_conic_view_get(s : GeoprojconicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_view_set(s : GeoprojconicView, i : Int, v : Double) -> GeoprojconicView {
  let result = geo_proj_conic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_view_sum(s : GeoprojconicView) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_view_mean(s : GeoprojconicView) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_view_scale(s : GeoprojconicView, f : Double) -> GeoprojconicView {
  let result = geo_proj_conic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_conic_view_add(a : GeoprojconicView, b : GeoprojconicView) -> GeoprojconicView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_conic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_conic_view_copy(s : GeoprojconicView) -> GeoprojconicView {
  let result = geo_proj_conic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_conic_view_fill(s : GeoprojconicView, v : Double) -> GeoprojconicView {
  let result = geo_proj_conic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_view_min(s : GeoprojconicView) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_view_max(s : GeoprojconicView) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_view_to_string(s : GeoprojconicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_range_make(size : Int) -> GeoprojconicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_range_len(s : GeoprojconicRange) -> Int { s.size }

pub fn geo_proj_conic_range_get(s : GeoprojconicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_range_set(s : GeoprojconicRange, i : Int, v : Double) -> GeoprojconicRange {
  let result = geo_proj_conic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_range_sum(s : GeoprojconicRange) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_range_mean(s : GeoprojconicRange) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_range_scale(s : GeoprojconicRange, f : Double) -> GeoprojconicRange {
  let result = geo_proj_conic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_conic_range_add(a : GeoprojconicRange, b : GeoprojconicRange) -> GeoprojconicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_conic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_conic_range_copy(s : GeoprojconicRange) -> GeoprojconicRange {
  let result = geo_proj_conic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_conic_range_fill(s : GeoprojconicRange, v : Double) -> GeoprojconicRange {
  let result = geo_proj_conic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_range_min(s : GeoprojconicRange) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_range_max(s : GeoprojconicRange) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_range_to_string(s : GeoprojconicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_slice_make(size : Int) -> GeoprojconicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_slice_len(s : GeoprojconicSlice) -> Int { s.size }

pub fn geo_proj_conic_slice_get(s : GeoprojconicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_slice_set(s : GeoprojconicSlice, i : Int, v : Double) -> GeoprojconicSlice {
  let result = geo_proj_conic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_slice_sum(s : GeoprojconicSlice) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_slice_mean(s : GeoprojconicSlice) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_slice_scale(s : GeoprojconicSlice, f : Double) -> GeoprojconicSlice {
  let result = geo_proj_conic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_conic_slice_add(a : GeoprojconicSlice, b : GeoprojconicSlice) -> GeoprojconicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_conic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_conic_slice_copy(s : GeoprojconicSlice) -> GeoprojconicSlice {
  let result = geo_proj_conic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_conic_slice_fill(s : GeoprojconicSlice, v : Double) -> GeoprojconicSlice {
  let result = geo_proj_conic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_conic_slice_min(s : GeoprojconicSlice) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_slice_max(s : GeoprojconicSlice) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_slice_to_string(s : GeoprojconicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

