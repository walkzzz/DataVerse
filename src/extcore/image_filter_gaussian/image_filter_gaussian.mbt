///===
/// extcore/image_filter_gaussian

pub(all) struct ImagefiltergaussianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_gaussian_make_point(x : Double, y : Double) -> ImagefiltergaussianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_gaussian_make_point3(x : Double, y : Double, z : Double) -> ImagefiltergaussianPoint {
  { x, y, z, label: 0 }
}

pub fn image_filter_gaussian_point_x(pt : ImagefiltergaussianPoint) -> Double { pt.x }

pub fn image_filter_gaussian_point_y(pt : ImagefiltergaussianPoint) -> Double { pt.y }

pub fn image_filter_gaussian_point_z(pt : ImagefiltergaussianPoint) -> Double { pt.z }

pub fn image_filter_gaussian_point_label(pt : ImagefiltergaussianPoint) -> Int { pt.label }

pub fn image_filter_gaussian_point_dist(a : ImagefiltergaussianPoint, b : ImagefiltergaussianPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_filter_gaussian_point_add(a : ImagefiltergaussianPoint, b : ImagefiltergaussianPoint) -> ImagefiltergaussianPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_filter_gaussian_point_sub(a : ImagefiltergaussianPoint, b : ImagefiltergaussianPoint) -> ImagefiltergaussianPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_filter_gaussian_point_scale(pt : ImagefiltergaussianPoint, s : Double) -> ImagefiltergaussianPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_filter_gaussian_point_dot(a : ImagefiltergaussianPoint, b : ImagefiltergaussianPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_filter_gaussian_point_cross(a : ImagefiltergaussianPoint, b : ImagefiltergaussianPoint) -> ImagefiltergaussianPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_filter_gaussian_point_norm(pt : ImagefiltergaussianPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_filter_gaussian_point_normalize(pt : ImagefiltergaussianPoint) -> ImagefiltergaussianPoint {
  let n = image_filter_gaussian_point_norm(pt)
  if n < 0.0000001 { pt } else { image_filter_gaussian_point_scale(pt, 1.0 / n) }
}

pub fn image_filter_gaussian_point_negate(pt : ImagefiltergaussianPoint) -> ImagefiltergaussianPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_filter_gaussian_point_mid(a : ImagefiltergaussianPoint, b : ImagefiltergaussianPoint) -> ImagefiltergaussianPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_filter_gaussian_point_lerp(a : ImagefiltergaussianPoint, b : ImagefiltergaussianPoint, t : Double) -> ImagefiltergaussianPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_filter_gaussian_point_to_string(pt : ImagefiltergaussianPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefiltergaussianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_gaussian_make_series(vals : Array[Double], name : String) -> ImagefiltergaussianSeries {
  { vals, name, meta: 0 }
}

pub fn image_filter_gaussian_series_len(s : ImagefiltergaussianSeries) -> Int { s.vals.length() }

pub fn image_filter_gaussian_series_sum(s : ImagefiltergaussianSeries) -> Double { @_common.sum(s.vals) }

pub fn image_filter_gaussian_series_mean(s : ImagefiltergaussianSeries) -> Double { @_common.mean(s.vals) }

pub fn image_filter_gaussian_series_min(s : ImagefiltergaussianSeries) -> Double { @_common.min(s.vals) }

pub fn image_filter_gaussian_series_max(s : ImagefiltergaussianSeries) -> Double { @_common.max(s.vals) }

pub fn image_filter_gaussian_series_range(s : ImagefiltergaussianSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_filter_gaussian_series_var(s : ImagefiltergaussianSeries) -> Double { @_common.variance(s.vals) }

pub fn image_filter_gaussian_series_std(s : ImagefiltergaussianSeries) -> Double { @_common.std(s.vals) }

pub fn image_filter_gaussian_series_median(s : ImagefiltergaussianSeries) -> Double { @_common.median(s.vals) }

pub fn image_filter_gaussian_series_scale(s : ImagefiltergaussianSeries, f : Double) -> ImagefiltergaussianSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_filter_gaussian_series_add(a : ImagefiltergaussianSeries, b : ImagefiltergaussianSeries) -> ImagefiltergaussianSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_filter_gaussian_series_sub(a : ImagefiltergaussianSeries, b : ImagefiltergaussianSeries) -> ImagefiltergaussianSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_filter_gaussian_series_normalize(s : ImagefiltergaussianSeries) -> ImagefiltergaussianSeries {
  let mn = image_filter_gaussian_series_min(s)
  let mx = image_filter_gaussian_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_filter_gaussian_series_cumsum(s : ImagefiltergaussianSeries) -> ImagefiltergaussianSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_filter_gaussian_series_to_string(s : ImagefiltergaussianSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefiltergaussianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_gaussian_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefiltergaussianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_gaussian_matrix_identity(n : Int) -> ImagefiltergaussianMatrix {
  let m = image_filter_gaussian_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_filter_gaussian_matrix_get(m : ImagefiltergaussianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_filter_gaussian_matrix_transpose(m : ImagefiltergaussianMatrix) -> ImagefiltergaussianMatrix {
  let result = image_filter_gaussian_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_filter_gaussian_matrix_add(a : ImagefiltergaussianMatrix, b : ImagefiltergaussianMatrix) -> ImagefiltergaussianMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_filter_gaussian_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_filter_gaussian_matrix_scale(m : ImagefiltergaussianMatrix, s : Double) -> ImagefiltergaussianMatrix {
  let result = image_filter_gaussian_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_filter_gaussian_matrix_multiply(a : ImagefiltergaussianMatrix, b : ImagefiltergaussianMatrix) -> ImagefiltergaussianMatrix {
  if a.cols != b.rows { return image_filter_gaussian_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_filter_gaussian_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_filter_gaussian_matrix_trace(m : ImagefiltergaussianMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_filter_gaussian_matrix_det(m : ImagefiltergaussianMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_filter_gaussian_matrix_norm(m : ImagefiltergaussianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_filter_gaussian_matrix_to_string(m : ImagefiltergaussianMatrix) -> String {
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

pub(all) struct ImagefiltergaussianVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_gaussian_make_vector(comps : Array[Double]) -> ImagefiltergaussianVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_gaussian_vector_zero(dim : Int) -> ImagefiltergaussianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_filter_gaussian_vector_add(a : ImagefiltergaussianVector, b : ImagefiltergaussianVector) -> ImagefiltergaussianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_gaussian_vector_sub(a : ImagefiltergaussianVector, b : ImagefiltergaussianVector) -> ImagefiltergaussianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_gaussian_vector_scale(v : ImagefiltergaussianVector, s : Double) -> ImagefiltergaussianVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_filter_gaussian_vector_dot(a : ImagefiltergaussianVector, b : ImagefiltergaussianVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_filter_gaussian_vector_norm(v : ImagefiltergaussianVector) -> Double { @_common.sqrt(image_filter_gaussian_vector_dot(v, v)) }

pub fn image_filter_gaussian_vector_normalize(v : ImagefiltergaussianVector) -> ImagefiltergaussianVector {
  let n = image_filter_gaussian_vector_norm(v)
  if n < 0.0000001 { v } else { image_filter_gaussian_vector_scale(v, 1.0 / n) }
}

pub fn image_filter_gaussian_vector_dist(a : ImagefiltergaussianVector, b : ImagefiltergaussianVector) -> Double {
  image_filter_gaussian_vector_norm(image_filter_gaussian_vector_sub(a, b))
}

pub fn image_filter_gaussian_vector_to_string(v : ImagefiltergaussianVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_gaussian_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_filter_gaussian_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_filter_gaussian_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_filter_gaussian_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_filter_gaussian_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_filter_gaussian_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_filter_gaussian_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_filter_gaussian_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_filter_gaussian_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_filter_gaussian_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_filter_gaussian_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_filter_gaussian_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_filter_gaussian_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_filter_gaussian_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_filter_gaussian_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_filter_gaussian_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_filter_gaussian_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_filter_gaussian_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_filter_gaussian_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_filter_gaussian_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_filter_gaussian_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_filter_gaussian_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_filter_gaussian_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_filter_gaussian_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_filter_gaussian_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_filter_gaussian_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_filter_gaussian_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_filter_gaussian_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_filter_gaussian_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefiltergaussianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_frame_make(size : Int) -> ImagefiltergaussianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_frame_len(s : ImagefiltergaussianFrame) -> Int { s.size }

pub fn image_filter_gaussian_frame_get(s : ImagefiltergaussianFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_frame_set(s : ImagefiltergaussianFrame, i : Int, v : Double) -> ImagefiltergaussianFrame {
  let result = image_filter_gaussian_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_frame_sum(s : ImagefiltergaussianFrame) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_frame_mean(s : ImagefiltergaussianFrame) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_frame_scale(s : ImagefiltergaussianFrame, f : Double) -> ImagefiltergaussianFrame {
  let result = image_filter_gaussian_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gaussian_frame_add(a : ImagefiltergaussianFrame, b : ImagefiltergaussianFrame) -> ImagefiltergaussianFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gaussian_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gaussian_frame_copy(s : ImagefiltergaussianFrame) -> ImagefiltergaussianFrame {
  let result = image_filter_gaussian_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gaussian_frame_fill(s : ImagefiltergaussianFrame, v : Double) -> ImagefiltergaussianFrame {
  let result = image_filter_gaussian_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_frame_min(s : ImagefiltergaussianFrame) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_frame_max(s : ImagefiltergaussianFrame) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_frame_to_string(s : ImagefiltergaussianFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_table_make(size : Int) -> ImagefiltergaussianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_table_len(s : ImagefiltergaussianTable) -> Int { s.size }

pub fn image_filter_gaussian_table_get(s : ImagefiltergaussianTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_table_set(s : ImagefiltergaussianTable, i : Int, v : Double) -> ImagefiltergaussianTable {
  let result = image_filter_gaussian_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_table_sum(s : ImagefiltergaussianTable) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_table_mean(s : ImagefiltergaussianTable) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_table_scale(s : ImagefiltergaussianTable, f : Double) -> ImagefiltergaussianTable {
  let result = image_filter_gaussian_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gaussian_table_add(a : ImagefiltergaussianTable, b : ImagefiltergaussianTable) -> ImagefiltergaussianTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gaussian_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gaussian_table_copy(s : ImagefiltergaussianTable) -> ImagefiltergaussianTable {
  let result = image_filter_gaussian_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gaussian_table_fill(s : ImagefiltergaussianTable, v : Double) -> ImagefiltergaussianTable {
  let result = image_filter_gaussian_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_table_min(s : ImagefiltergaussianTable) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_table_max(s : ImagefiltergaussianTable) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_table_to_string(s : ImagefiltergaussianTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_graphn_make(size : Int) -> ImagefiltergaussianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_graphn_len(s : ImagefiltergaussianGraphN) -> Int { s.size }

pub fn image_filter_gaussian_graphn_get(s : ImagefiltergaussianGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_graphn_set(s : ImagefiltergaussianGraphN, i : Int, v : Double) -> ImagefiltergaussianGraphN {
  let result = image_filter_gaussian_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_graphn_sum(s : ImagefiltergaussianGraphN) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_graphn_mean(s : ImagefiltergaussianGraphN) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_graphn_scale(s : ImagefiltergaussianGraphN, f : Double) -> ImagefiltergaussianGraphN {
  let result = image_filter_gaussian_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gaussian_graphn_add(a : ImagefiltergaussianGraphN, b : ImagefiltergaussianGraphN) -> ImagefiltergaussianGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gaussian_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gaussian_graphn_copy(s : ImagefiltergaussianGraphN) -> ImagefiltergaussianGraphN {
  let result = image_filter_gaussian_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gaussian_graphn_fill(s : ImagefiltergaussianGraphN, v : Double) -> ImagefiltergaussianGraphN {
  let result = image_filter_gaussian_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_graphn_min(s : ImagefiltergaussianGraphN) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_graphn_max(s : ImagefiltergaussianGraphN) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_graphn_to_string(s : ImagefiltergaussianGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_node_make(size : Int) -> ImagefiltergaussianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_node_len(s : ImagefiltergaussianNode) -> Int { s.size }

pub fn image_filter_gaussian_node_get(s : ImagefiltergaussianNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_node_set(s : ImagefiltergaussianNode, i : Int, v : Double) -> ImagefiltergaussianNode {
  let result = image_filter_gaussian_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_node_sum(s : ImagefiltergaussianNode) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_node_mean(s : ImagefiltergaussianNode) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_node_scale(s : ImagefiltergaussianNode, f : Double) -> ImagefiltergaussianNode {
  let result = image_filter_gaussian_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gaussian_node_add(a : ImagefiltergaussianNode, b : ImagefiltergaussianNode) -> ImagefiltergaussianNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gaussian_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gaussian_node_copy(s : ImagefiltergaussianNode) -> ImagefiltergaussianNode {
  let result = image_filter_gaussian_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gaussian_node_fill(s : ImagefiltergaussianNode, v : Double) -> ImagefiltergaussianNode {
  let result = image_filter_gaussian_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_node_min(s : ImagefiltergaussianNode) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_node_max(s : ImagefiltergaussianNode) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_node_to_string(s : ImagefiltergaussianNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_edge_make(size : Int) -> ImagefiltergaussianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_edge_len(s : ImagefiltergaussianEdge) -> Int { s.size }

pub fn image_filter_gaussian_edge_get(s : ImagefiltergaussianEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_edge_set(s : ImagefiltergaussianEdge, i : Int, v : Double) -> ImagefiltergaussianEdge {
  let result = image_filter_gaussian_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_edge_sum(s : ImagefiltergaussianEdge) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_edge_mean(s : ImagefiltergaussianEdge) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_edge_scale(s : ImagefiltergaussianEdge, f : Double) -> ImagefiltergaussianEdge {
  let result = image_filter_gaussian_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gaussian_edge_add(a : ImagefiltergaussianEdge, b : ImagefiltergaussianEdge) -> ImagefiltergaussianEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gaussian_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gaussian_edge_copy(s : ImagefiltergaussianEdge) -> ImagefiltergaussianEdge {
  let result = image_filter_gaussian_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gaussian_edge_fill(s : ImagefiltergaussianEdge, v : Double) -> ImagefiltergaussianEdge {
  let result = image_filter_gaussian_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_edge_min(s : ImagefiltergaussianEdge) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_edge_max(s : ImagefiltergaussianEdge) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_edge_to_string(s : ImagefiltergaussianEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_path_make(size : Int) -> ImagefiltergaussianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_path_len(s : ImagefiltergaussianPath) -> Int { s.size }

pub fn image_filter_gaussian_path_get(s : ImagefiltergaussianPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_path_set(s : ImagefiltergaussianPath, i : Int, v : Double) -> ImagefiltergaussianPath {
  let result = image_filter_gaussian_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_path_sum(s : ImagefiltergaussianPath) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_path_mean(s : ImagefiltergaussianPath) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_path_scale(s : ImagefiltergaussianPath, f : Double) -> ImagefiltergaussianPath {
  let result = image_filter_gaussian_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gaussian_path_add(a : ImagefiltergaussianPath, b : ImagefiltergaussianPath) -> ImagefiltergaussianPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gaussian_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gaussian_path_copy(s : ImagefiltergaussianPath) -> ImagefiltergaussianPath {
  let result = image_filter_gaussian_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gaussian_path_fill(s : ImagefiltergaussianPath, v : Double) -> ImagefiltergaussianPath {
  let result = image_filter_gaussian_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_path_min(s : ImagefiltergaussianPath) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_path_max(s : ImagefiltergaussianPath) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_path_to_string(s : ImagefiltergaussianPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_cluster_make(size : Int) -> ImagefiltergaussianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_cluster_len(s : ImagefiltergaussianCluster) -> Int { s.size }

pub fn image_filter_gaussian_cluster_get(s : ImagefiltergaussianCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_cluster_set(s : ImagefiltergaussianCluster, i : Int, v : Double) -> ImagefiltergaussianCluster {
  let result = image_filter_gaussian_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_cluster_sum(s : ImagefiltergaussianCluster) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_cluster_mean(s : ImagefiltergaussianCluster) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_cluster_scale(s : ImagefiltergaussianCluster, f : Double) -> ImagefiltergaussianCluster {
  let result = image_filter_gaussian_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gaussian_cluster_add(a : ImagefiltergaussianCluster, b : ImagefiltergaussianCluster) -> ImagefiltergaussianCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gaussian_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gaussian_cluster_copy(s : ImagefiltergaussianCluster) -> ImagefiltergaussianCluster {
  let result = image_filter_gaussian_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gaussian_cluster_fill(s : ImagefiltergaussianCluster, v : Double) -> ImagefiltergaussianCluster {
  let result = image_filter_gaussian_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_cluster_min(s : ImagefiltergaussianCluster) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_cluster_max(s : ImagefiltergaussianCluster) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_cluster_to_string(s : ImagefiltergaussianCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_model_make(size : Int) -> ImagefiltergaussianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_model_len(s : ImagefiltergaussianModel) -> Int { s.size }

pub fn image_filter_gaussian_model_get(s : ImagefiltergaussianModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_model_set(s : ImagefiltergaussianModel, i : Int, v : Double) -> ImagefiltergaussianModel {
  let result = image_filter_gaussian_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_model_sum(s : ImagefiltergaussianModel) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_model_mean(s : ImagefiltergaussianModel) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_model_scale(s : ImagefiltergaussianModel, f : Double) -> ImagefiltergaussianModel {
  let result = image_filter_gaussian_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gaussian_model_add(a : ImagefiltergaussianModel, b : ImagefiltergaussianModel) -> ImagefiltergaussianModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gaussian_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gaussian_model_copy(s : ImagefiltergaussianModel) -> ImagefiltergaussianModel {
  let result = image_filter_gaussian_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gaussian_model_fill(s : ImagefiltergaussianModel, v : Double) -> ImagefiltergaussianModel {
  let result = image_filter_gaussian_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_model_min(s : ImagefiltergaussianModel) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_model_max(s : ImagefiltergaussianModel) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_model_to_string(s : ImagefiltergaussianModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_layer_make(size : Int) -> ImagefiltergaussianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_layer_len(s : ImagefiltergaussianLayer) -> Int { s.size }

pub fn image_filter_gaussian_layer_get(s : ImagefiltergaussianLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_layer_set(s : ImagefiltergaussianLayer, i : Int, v : Double) -> ImagefiltergaussianLayer {
  let result = image_filter_gaussian_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_layer_sum(s : ImagefiltergaussianLayer) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_layer_mean(s : ImagefiltergaussianLayer) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_layer_scale(s : ImagefiltergaussianLayer, f : Double) -> ImagefiltergaussianLayer {
  let result = image_filter_gaussian_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gaussian_layer_add(a : ImagefiltergaussianLayer, b : ImagefiltergaussianLayer) -> ImagefiltergaussianLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gaussian_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gaussian_layer_copy(s : ImagefiltergaussianLayer) -> ImagefiltergaussianLayer {
  let result = image_filter_gaussian_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gaussian_layer_fill(s : ImagefiltergaussianLayer, v : Double) -> ImagefiltergaussianLayer {
  let result = image_filter_gaussian_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_layer_min(s : ImagefiltergaussianLayer) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_layer_max(s : ImagefiltergaussianLayer) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_layer_to_string(s : ImagefiltergaussianLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_buffer_make(size : Int) -> ImagefiltergaussianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_buffer_len(s : ImagefiltergaussianBuffer) -> Int { s.size }

pub fn image_filter_gaussian_buffer_get(s : ImagefiltergaussianBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_buffer_set(s : ImagefiltergaussianBuffer, i : Int, v : Double) -> ImagefiltergaussianBuffer {
  let result = image_filter_gaussian_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_buffer_sum(s : ImagefiltergaussianBuffer) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_buffer_mean(s : ImagefiltergaussianBuffer) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_buffer_scale(s : ImagefiltergaussianBuffer, f : Double) -> ImagefiltergaussianBuffer {
  let result = image_filter_gaussian_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gaussian_buffer_add(a : ImagefiltergaussianBuffer, b : ImagefiltergaussianBuffer) -> ImagefiltergaussianBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gaussian_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gaussian_buffer_copy(s : ImagefiltergaussianBuffer) -> ImagefiltergaussianBuffer {
  let result = image_filter_gaussian_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gaussian_buffer_fill(s : ImagefiltergaussianBuffer, v : Double) -> ImagefiltergaussianBuffer {
  let result = image_filter_gaussian_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_buffer_min(s : ImagefiltergaussianBuffer) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_buffer_max(s : ImagefiltergaussianBuffer) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_buffer_to_string(s : ImagefiltergaussianBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_cursor_make(size : Int) -> ImagefiltergaussianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_cursor_len(s : ImagefiltergaussianCursor) -> Int { s.size }

pub fn image_filter_gaussian_cursor_get(s : ImagefiltergaussianCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_cursor_set(s : ImagefiltergaussianCursor, i : Int, v : Double) -> ImagefiltergaussianCursor {
  let result = image_filter_gaussian_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_cursor_sum(s : ImagefiltergaussianCursor) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_cursor_mean(s : ImagefiltergaussianCursor) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_cursor_scale(s : ImagefiltergaussianCursor, f : Double) -> ImagefiltergaussianCursor {
  let result = image_filter_gaussian_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gaussian_cursor_add(a : ImagefiltergaussianCursor, b : ImagefiltergaussianCursor) -> ImagefiltergaussianCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gaussian_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gaussian_cursor_copy(s : ImagefiltergaussianCursor) -> ImagefiltergaussianCursor {
  let result = image_filter_gaussian_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gaussian_cursor_fill(s : ImagefiltergaussianCursor, v : Double) -> ImagefiltergaussianCursor {
  let result = image_filter_gaussian_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_cursor_min(s : ImagefiltergaussianCursor) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_cursor_max(s : ImagefiltergaussianCursor) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_cursor_to_string(s : ImagefiltergaussianCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_view_make(size : Int) -> ImagefiltergaussianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_view_len(s : ImagefiltergaussianView) -> Int { s.size }

pub fn image_filter_gaussian_view_get(s : ImagefiltergaussianView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_view_set(s : ImagefiltergaussianView, i : Int, v : Double) -> ImagefiltergaussianView {
  let result = image_filter_gaussian_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_view_sum(s : ImagefiltergaussianView) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_view_mean(s : ImagefiltergaussianView) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_view_scale(s : ImagefiltergaussianView, f : Double) -> ImagefiltergaussianView {
  let result = image_filter_gaussian_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gaussian_view_add(a : ImagefiltergaussianView, b : ImagefiltergaussianView) -> ImagefiltergaussianView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gaussian_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gaussian_view_copy(s : ImagefiltergaussianView) -> ImagefiltergaussianView {
  let result = image_filter_gaussian_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gaussian_view_fill(s : ImagefiltergaussianView, v : Double) -> ImagefiltergaussianView {
  let result = image_filter_gaussian_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_view_min(s : ImagefiltergaussianView) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_view_max(s : ImagefiltergaussianView) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_view_to_string(s : ImagefiltergaussianView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_range_make(size : Int) -> ImagefiltergaussianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_range_len(s : ImagefiltergaussianRange) -> Int { s.size }

pub fn image_filter_gaussian_range_get(s : ImagefiltergaussianRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_range_set(s : ImagefiltergaussianRange, i : Int, v : Double) -> ImagefiltergaussianRange {
  let result = image_filter_gaussian_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_range_sum(s : ImagefiltergaussianRange) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_range_mean(s : ImagefiltergaussianRange) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_range_scale(s : ImagefiltergaussianRange, f : Double) -> ImagefiltergaussianRange {
  let result = image_filter_gaussian_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gaussian_range_add(a : ImagefiltergaussianRange, b : ImagefiltergaussianRange) -> ImagefiltergaussianRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gaussian_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gaussian_range_copy(s : ImagefiltergaussianRange) -> ImagefiltergaussianRange {
  let result = image_filter_gaussian_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gaussian_range_fill(s : ImagefiltergaussianRange, v : Double) -> ImagefiltergaussianRange {
  let result = image_filter_gaussian_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_range_min(s : ImagefiltergaussianRange) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_range_max(s : ImagefiltergaussianRange) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_range_to_string(s : ImagefiltergaussianRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltergaussianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_gaussian_slice_make(size : Int) -> ImagefiltergaussianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_gaussian_slice_len(s : ImagefiltergaussianSlice) -> Int { s.size }

pub fn image_filter_gaussian_slice_get(s : ImagefiltergaussianSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_gaussian_slice_set(s : ImagefiltergaussianSlice, i : Int, v : Double) -> ImagefiltergaussianSlice {
  let result = image_filter_gaussian_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_slice_sum(s : ImagefiltergaussianSlice) -> Double { @_common.sum(s.data) }

pub fn image_filter_gaussian_slice_mean(s : ImagefiltergaussianSlice) -> Double { @_common.mean(s.data) }

pub fn image_filter_gaussian_slice_scale(s : ImagefiltergaussianSlice, f : Double) -> ImagefiltergaussianSlice {
  let result = image_filter_gaussian_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_gaussian_slice_add(a : ImagefiltergaussianSlice, b : ImagefiltergaussianSlice) -> ImagefiltergaussianSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_gaussian_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_gaussian_slice_copy(s : ImagefiltergaussianSlice) -> ImagefiltergaussianSlice {
  let result = image_filter_gaussian_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_gaussian_slice_fill(s : ImagefiltergaussianSlice, v : Double) -> ImagefiltergaussianSlice {
  let result = image_filter_gaussian_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_gaussian_slice_min(s : ImagefiltergaussianSlice) -> Double { @_common.min(s.data) }

pub fn image_filter_gaussian_slice_max(s : ImagefiltergaussianSlice) -> Double { @_common.max(s.data) }

pub fn image_filter_gaussian_slice_to_string(s : ImagefiltergaussianSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

