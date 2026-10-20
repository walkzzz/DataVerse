///===
/// extcore/image_transform_flip

pub(all) struct ImagetransformflipPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_flip_make_point(x : Double, y : Double) -> ImagetransformflipPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_flip_make_point3(x : Double, y : Double, z : Double) -> ImagetransformflipPoint {
  { x, y, z, label: 0 }
}

pub fn image_transform_flip_point_x(pt : ImagetransformflipPoint) -> Double { pt.x }

pub fn image_transform_flip_point_y(pt : ImagetransformflipPoint) -> Double { pt.y }

pub fn image_transform_flip_point_z(pt : ImagetransformflipPoint) -> Double { pt.z }

pub fn image_transform_flip_point_label(pt : ImagetransformflipPoint) -> Int { pt.label }

pub fn image_transform_flip_point_dist(a : ImagetransformflipPoint, b : ImagetransformflipPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_transform_flip_point_add(a : ImagetransformflipPoint, b : ImagetransformflipPoint) -> ImagetransformflipPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_transform_flip_point_sub(a : ImagetransformflipPoint, b : ImagetransformflipPoint) -> ImagetransformflipPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_transform_flip_point_scale(pt : ImagetransformflipPoint, s : Double) -> ImagetransformflipPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_transform_flip_point_dot(a : ImagetransformflipPoint, b : ImagetransformflipPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_transform_flip_point_cross(a : ImagetransformflipPoint, b : ImagetransformflipPoint) -> ImagetransformflipPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_transform_flip_point_norm(pt : ImagetransformflipPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_transform_flip_point_normalize(pt : ImagetransformflipPoint) -> ImagetransformflipPoint {
  let n = image_transform_flip_point_norm(pt)
  if n < 0.0000001 { pt } else { image_transform_flip_point_scale(pt, 1.0 / n) }
}

pub fn image_transform_flip_point_negate(pt : ImagetransformflipPoint) -> ImagetransformflipPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_transform_flip_point_mid(a : ImagetransformflipPoint, b : ImagetransformflipPoint) -> ImagetransformflipPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_transform_flip_point_lerp(a : ImagetransformflipPoint, b : ImagetransformflipPoint, t : Double) -> ImagetransformflipPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_transform_flip_point_to_string(pt : ImagetransformflipPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagetransformflipSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_flip_make_series(vals : Array[Double], name : String) -> ImagetransformflipSeries {
  { vals, name, meta: 0 }
}

pub fn image_transform_flip_series_len(s : ImagetransformflipSeries) -> Int { s.vals.length() }

pub fn image_transform_flip_series_sum(s : ImagetransformflipSeries) -> Double { @_common.sum(s.vals) }

pub fn image_transform_flip_series_mean(s : ImagetransformflipSeries) -> Double { @_common.mean(s.vals) }

pub fn image_transform_flip_series_min(s : ImagetransformflipSeries) -> Double { @_common.min(s.vals) }

pub fn image_transform_flip_series_max(s : ImagetransformflipSeries) -> Double { @_common.max(s.vals) }

pub fn image_transform_flip_series_range(s : ImagetransformflipSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_transform_flip_series_var(s : ImagetransformflipSeries) -> Double { @_common.variance(s.vals) }

pub fn image_transform_flip_series_std(s : ImagetransformflipSeries) -> Double { @_common.std(s.vals) }

pub fn image_transform_flip_series_median(s : ImagetransformflipSeries) -> Double { @_common.median(s.vals) }

pub fn image_transform_flip_series_scale(s : ImagetransformflipSeries, f : Double) -> ImagetransformflipSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_transform_flip_series_add(a : ImagetransformflipSeries, b : ImagetransformflipSeries) -> ImagetransformflipSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_transform_flip_series_sub(a : ImagetransformflipSeries, b : ImagetransformflipSeries) -> ImagetransformflipSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_transform_flip_series_normalize(s : ImagetransformflipSeries) -> ImagetransformflipSeries {
  let mn = image_transform_flip_series_min(s)
  let mx = image_transform_flip_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_transform_flip_series_cumsum(s : ImagetransformflipSeries) -> ImagetransformflipSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_transform_flip_series_to_string(s : ImagetransformflipSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformflipMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_flip_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformflipMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_flip_matrix_identity(n : Int) -> ImagetransformflipMatrix {
  let m = image_transform_flip_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_transform_flip_matrix_get(m : ImagetransformflipMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_transform_flip_matrix_transpose(m : ImagetransformflipMatrix) -> ImagetransformflipMatrix {
  let result = image_transform_flip_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_transform_flip_matrix_add(a : ImagetransformflipMatrix, b : ImagetransformflipMatrix) -> ImagetransformflipMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_transform_flip_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_transform_flip_matrix_scale(m : ImagetransformflipMatrix, s : Double) -> ImagetransformflipMatrix {
  let result = image_transform_flip_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_transform_flip_matrix_multiply(a : ImagetransformflipMatrix, b : ImagetransformflipMatrix) -> ImagetransformflipMatrix {
  if a.cols != b.rows { return image_transform_flip_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_transform_flip_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_transform_flip_matrix_trace(m : ImagetransformflipMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_transform_flip_matrix_det(m : ImagetransformflipMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_transform_flip_matrix_norm(m : ImagetransformflipMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_transform_flip_matrix_to_string(m : ImagetransformflipMatrix) -> String {
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

pub(all) struct ImagetransformflipVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_flip_make_vector(comps : Array[Double]) -> ImagetransformflipVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_flip_vector_zero(dim : Int) -> ImagetransformflipVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_transform_flip_vector_add(a : ImagetransformflipVector, b : ImagetransformflipVector) -> ImagetransformflipVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_flip_vector_sub(a : ImagetransformflipVector, b : ImagetransformflipVector) -> ImagetransformflipVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_flip_vector_scale(v : ImagetransformflipVector, s : Double) -> ImagetransformflipVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_transform_flip_vector_dot(a : ImagetransformflipVector, b : ImagetransformflipVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_transform_flip_vector_norm(v : ImagetransformflipVector) -> Double { @_common.sqrt(image_transform_flip_vector_dot(v, v)) }

pub fn image_transform_flip_vector_normalize(v : ImagetransformflipVector) -> ImagetransformflipVector {
  let n = image_transform_flip_vector_norm(v)
  if n < 0.0000001 { v } else { image_transform_flip_vector_scale(v, 1.0 / n) }
}

pub fn image_transform_flip_vector_dist(a : ImagetransformflipVector, b : ImagetransformflipVector) -> Double {
  image_transform_flip_vector_norm(image_transform_flip_vector_sub(a, b))
}

pub fn image_transform_flip_vector_to_string(v : ImagetransformflipVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_flip_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_flip_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_flip_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_flip_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_flip_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_flip_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_flip_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_flip_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_flip_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_flip_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_flip_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_flip_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_flip_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_flip_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_flip_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_flip_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_flip_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_flip_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_flip_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_flip_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_flip_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_flip_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_flip_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_flip_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_flip_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_flip_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_flip_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_flip_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_flip_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformflipFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_frame_make(size : Int) -> ImagetransformflipFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_frame_len(s : ImagetransformflipFrame) -> Int { s.size }

pub fn image_transform_flip_frame_get(s : ImagetransformflipFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_frame_set(s : ImagetransformflipFrame, i : Int, v : Double) -> ImagetransformflipFrame {
  let result = image_transform_flip_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_frame_sum(s : ImagetransformflipFrame) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_frame_mean(s : ImagetransformflipFrame) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_frame_scale(s : ImagetransformflipFrame, f : Double) -> ImagetransformflipFrame {
  let result = image_transform_flip_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_flip_frame_add(a : ImagetransformflipFrame, b : ImagetransformflipFrame) -> ImagetransformflipFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_flip_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_flip_frame_copy(s : ImagetransformflipFrame) -> ImagetransformflipFrame {
  let result = image_transform_flip_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_flip_frame_fill(s : ImagetransformflipFrame, v : Double) -> ImagetransformflipFrame {
  let result = image_transform_flip_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_frame_min(s : ImagetransformflipFrame) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_frame_max(s : ImagetransformflipFrame) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_frame_to_string(s : ImagetransformflipFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_table_make(size : Int) -> ImagetransformflipTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_table_len(s : ImagetransformflipTable) -> Int { s.size }

pub fn image_transform_flip_table_get(s : ImagetransformflipTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_table_set(s : ImagetransformflipTable, i : Int, v : Double) -> ImagetransformflipTable {
  let result = image_transform_flip_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_table_sum(s : ImagetransformflipTable) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_table_mean(s : ImagetransformflipTable) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_table_scale(s : ImagetransformflipTable, f : Double) -> ImagetransformflipTable {
  let result = image_transform_flip_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_flip_table_add(a : ImagetransformflipTable, b : ImagetransformflipTable) -> ImagetransformflipTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_flip_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_flip_table_copy(s : ImagetransformflipTable) -> ImagetransformflipTable {
  let result = image_transform_flip_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_flip_table_fill(s : ImagetransformflipTable, v : Double) -> ImagetransformflipTable {
  let result = image_transform_flip_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_table_min(s : ImagetransformflipTable) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_table_max(s : ImagetransformflipTable) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_table_to_string(s : ImagetransformflipTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_graphn_make(size : Int) -> ImagetransformflipGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_graphn_len(s : ImagetransformflipGraphN) -> Int { s.size }

pub fn image_transform_flip_graphn_get(s : ImagetransformflipGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_graphn_set(s : ImagetransformflipGraphN, i : Int, v : Double) -> ImagetransformflipGraphN {
  let result = image_transform_flip_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_graphn_sum(s : ImagetransformflipGraphN) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_graphn_mean(s : ImagetransformflipGraphN) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_graphn_scale(s : ImagetransformflipGraphN, f : Double) -> ImagetransformflipGraphN {
  let result = image_transform_flip_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_flip_graphn_add(a : ImagetransformflipGraphN, b : ImagetransformflipGraphN) -> ImagetransformflipGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_flip_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_flip_graphn_copy(s : ImagetransformflipGraphN) -> ImagetransformflipGraphN {
  let result = image_transform_flip_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_flip_graphn_fill(s : ImagetransformflipGraphN, v : Double) -> ImagetransformflipGraphN {
  let result = image_transform_flip_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_graphn_min(s : ImagetransformflipGraphN) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_graphn_max(s : ImagetransformflipGraphN) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_graphn_to_string(s : ImagetransformflipGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_node_make(size : Int) -> ImagetransformflipNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_node_len(s : ImagetransformflipNode) -> Int { s.size }

pub fn image_transform_flip_node_get(s : ImagetransformflipNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_node_set(s : ImagetransformflipNode, i : Int, v : Double) -> ImagetransformflipNode {
  let result = image_transform_flip_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_node_sum(s : ImagetransformflipNode) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_node_mean(s : ImagetransformflipNode) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_node_scale(s : ImagetransformflipNode, f : Double) -> ImagetransformflipNode {
  let result = image_transform_flip_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_flip_node_add(a : ImagetransformflipNode, b : ImagetransformflipNode) -> ImagetransformflipNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_flip_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_flip_node_copy(s : ImagetransformflipNode) -> ImagetransformflipNode {
  let result = image_transform_flip_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_flip_node_fill(s : ImagetransformflipNode, v : Double) -> ImagetransformflipNode {
  let result = image_transform_flip_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_node_min(s : ImagetransformflipNode) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_node_max(s : ImagetransformflipNode) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_node_to_string(s : ImagetransformflipNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_edge_make(size : Int) -> ImagetransformflipEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_edge_len(s : ImagetransformflipEdge) -> Int { s.size }

pub fn image_transform_flip_edge_get(s : ImagetransformflipEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_edge_set(s : ImagetransformflipEdge, i : Int, v : Double) -> ImagetransformflipEdge {
  let result = image_transform_flip_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_edge_sum(s : ImagetransformflipEdge) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_edge_mean(s : ImagetransformflipEdge) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_edge_scale(s : ImagetransformflipEdge, f : Double) -> ImagetransformflipEdge {
  let result = image_transform_flip_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_flip_edge_add(a : ImagetransformflipEdge, b : ImagetransformflipEdge) -> ImagetransformflipEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_flip_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_flip_edge_copy(s : ImagetransformflipEdge) -> ImagetransformflipEdge {
  let result = image_transform_flip_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_flip_edge_fill(s : ImagetransformflipEdge, v : Double) -> ImagetransformflipEdge {
  let result = image_transform_flip_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_edge_min(s : ImagetransformflipEdge) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_edge_max(s : ImagetransformflipEdge) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_edge_to_string(s : ImagetransformflipEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_path_make(size : Int) -> ImagetransformflipPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_path_len(s : ImagetransformflipPath) -> Int { s.size }

pub fn image_transform_flip_path_get(s : ImagetransformflipPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_path_set(s : ImagetransformflipPath, i : Int, v : Double) -> ImagetransformflipPath {
  let result = image_transform_flip_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_path_sum(s : ImagetransformflipPath) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_path_mean(s : ImagetransformflipPath) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_path_scale(s : ImagetransformflipPath, f : Double) -> ImagetransformflipPath {
  let result = image_transform_flip_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_flip_path_add(a : ImagetransformflipPath, b : ImagetransformflipPath) -> ImagetransformflipPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_flip_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_flip_path_copy(s : ImagetransformflipPath) -> ImagetransformflipPath {
  let result = image_transform_flip_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_flip_path_fill(s : ImagetransformflipPath, v : Double) -> ImagetransformflipPath {
  let result = image_transform_flip_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_path_min(s : ImagetransformflipPath) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_path_max(s : ImagetransformflipPath) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_path_to_string(s : ImagetransformflipPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_cluster_make(size : Int) -> ImagetransformflipCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_cluster_len(s : ImagetransformflipCluster) -> Int { s.size }

pub fn image_transform_flip_cluster_get(s : ImagetransformflipCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_cluster_set(s : ImagetransformflipCluster, i : Int, v : Double) -> ImagetransformflipCluster {
  let result = image_transform_flip_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_cluster_sum(s : ImagetransformflipCluster) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_cluster_mean(s : ImagetransformflipCluster) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_cluster_scale(s : ImagetransformflipCluster, f : Double) -> ImagetransformflipCluster {
  let result = image_transform_flip_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_flip_cluster_add(a : ImagetransformflipCluster, b : ImagetransformflipCluster) -> ImagetransformflipCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_flip_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_flip_cluster_copy(s : ImagetransformflipCluster) -> ImagetransformflipCluster {
  let result = image_transform_flip_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_flip_cluster_fill(s : ImagetransformflipCluster, v : Double) -> ImagetransformflipCluster {
  let result = image_transform_flip_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_cluster_min(s : ImagetransformflipCluster) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_cluster_max(s : ImagetransformflipCluster) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_cluster_to_string(s : ImagetransformflipCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_model_make(size : Int) -> ImagetransformflipModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_model_len(s : ImagetransformflipModel) -> Int { s.size }

pub fn image_transform_flip_model_get(s : ImagetransformflipModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_model_set(s : ImagetransformflipModel, i : Int, v : Double) -> ImagetransformflipModel {
  let result = image_transform_flip_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_model_sum(s : ImagetransformflipModel) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_model_mean(s : ImagetransformflipModel) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_model_scale(s : ImagetransformflipModel, f : Double) -> ImagetransformflipModel {
  let result = image_transform_flip_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_flip_model_add(a : ImagetransformflipModel, b : ImagetransformflipModel) -> ImagetransformflipModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_flip_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_flip_model_copy(s : ImagetransformflipModel) -> ImagetransformflipModel {
  let result = image_transform_flip_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_flip_model_fill(s : ImagetransformflipModel, v : Double) -> ImagetransformflipModel {
  let result = image_transform_flip_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_model_min(s : ImagetransformflipModel) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_model_max(s : ImagetransformflipModel) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_model_to_string(s : ImagetransformflipModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_layer_make(size : Int) -> ImagetransformflipLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_layer_len(s : ImagetransformflipLayer) -> Int { s.size }

pub fn image_transform_flip_layer_get(s : ImagetransformflipLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_layer_set(s : ImagetransformflipLayer, i : Int, v : Double) -> ImagetransformflipLayer {
  let result = image_transform_flip_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_layer_sum(s : ImagetransformflipLayer) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_layer_mean(s : ImagetransformflipLayer) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_layer_scale(s : ImagetransformflipLayer, f : Double) -> ImagetransformflipLayer {
  let result = image_transform_flip_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_flip_layer_add(a : ImagetransformflipLayer, b : ImagetransformflipLayer) -> ImagetransformflipLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_flip_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_flip_layer_copy(s : ImagetransformflipLayer) -> ImagetransformflipLayer {
  let result = image_transform_flip_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_flip_layer_fill(s : ImagetransformflipLayer, v : Double) -> ImagetransformflipLayer {
  let result = image_transform_flip_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_layer_min(s : ImagetransformflipLayer) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_layer_max(s : ImagetransformflipLayer) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_layer_to_string(s : ImagetransformflipLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_buffer_make(size : Int) -> ImagetransformflipBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_buffer_len(s : ImagetransformflipBuffer) -> Int { s.size }

pub fn image_transform_flip_buffer_get(s : ImagetransformflipBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_buffer_set(s : ImagetransformflipBuffer, i : Int, v : Double) -> ImagetransformflipBuffer {
  let result = image_transform_flip_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_buffer_sum(s : ImagetransformflipBuffer) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_buffer_mean(s : ImagetransformflipBuffer) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_buffer_scale(s : ImagetransformflipBuffer, f : Double) -> ImagetransformflipBuffer {
  let result = image_transform_flip_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_flip_buffer_add(a : ImagetransformflipBuffer, b : ImagetransformflipBuffer) -> ImagetransformflipBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_flip_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_flip_buffer_copy(s : ImagetransformflipBuffer) -> ImagetransformflipBuffer {
  let result = image_transform_flip_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_flip_buffer_fill(s : ImagetransformflipBuffer, v : Double) -> ImagetransformflipBuffer {
  let result = image_transform_flip_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_buffer_min(s : ImagetransformflipBuffer) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_buffer_max(s : ImagetransformflipBuffer) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_buffer_to_string(s : ImagetransformflipBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_cursor_make(size : Int) -> ImagetransformflipCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_cursor_len(s : ImagetransformflipCursor) -> Int { s.size }

pub fn image_transform_flip_cursor_get(s : ImagetransformflipCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_cursor_set(s : ImagetransformflipCursor, i : Int, v : Double) -> ImagetransformflipCursor {
  let result = image_transform_flip_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_cursor_sum(s : ImagetransformflipCursor) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_cursor_mean(s : ImagetransformflipCursor) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_cursor_scale(s : ImagetransformflipCursor, f : Double) -> ImagetransformflipCursor {
  let result = image_transform_flip_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_flip_cursor_add(a : ImagetransformflipCursor, b : ImagetransformflipCursor) -> ImagetransformflipCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_flip_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_flip_cursor_copy(s : ImagetransformflipCursor) -> ImagetransformflipCursor {
  let result = image_transform_flip_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_flip_cursor_fill(s : ImagetransformflipCursor, v : Double) -> ImagetransformflipCursor {
  let result = image_transform_flip_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_cursor_min(s : ImagetransformflipCursor) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_cursor_max(s : ImagetransformflipCursor) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_cursor_to_string(s : ImagetransformflipCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_view_make(size : Int) -> ImagetransformflipView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_view_len(s : ImagetransformflipView) -> Int { s.size }

pub fn image_transform_flip_view_get(s : ImagetransformflipView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_view_set(s : ImagetransformflipView, i : Int, v : Double) -> ImagetransformflipView {
  let result = image_transform_flip_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_view_sum(s : ImagetransformflipView) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_view_mean(s : ImagetransformflipView) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_view_scale(s : ImagetransformflipView, f : Double) -> ImagetransformflipView {
  let result = image_transform_flip_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_flip_view_add(a : ImagetransformflipView, b : ImagetransformflipView) -> ImagetransformflipView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_flip_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_flip_view_copy(s : ImagetransformflipView) -> ImagetransformflipView {
  let result = image_transform_flip_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_flip_view_fill(s : ImagetransformflipView, v : Double) -> ImagetransformflipView {
  let result = image_transform_flip_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_view_min(s : ImagetransformflipView) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_view_max(s : ImagetransformflipView) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_view_to_string(s : ImagetransformflipView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_range_make(size : Int) -> ImagetransformflipRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_range_len(s : ImagetransformflipRange) -> Int { s.size }

pub fn image_transform_flip_range_get(s : ImagetransformflipRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_range_set(s : ImagetransformflipRange, i : Int, v : Double) -> ImagetransformflipRange {
  let result = image_transform_flip_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_range_sum(s : ImagetransformflipRange) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_range_mean(s : ImagetransformflipRange) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_range_scale(s : ImagetransformflipRange, f : Double) -> ImagetransformflipRange {
  let result = image_transform_flip_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_flip_range_add(a : ImagetransformflipRange, b : ImagetransformflipRange) -> ImagetransformflipRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_flip_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_flip_range_copy(s : ImagetransformflipRange) -> ImagetransformflipRange {
  let result = image_transform_flip_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_flip_range_fill(s : ImagetransformflipRange, v : Double) -> ImagetransformflipRange {
  let result = image_transform_flip_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_range_min(s : ImagetransformflipRange) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_range_max(s : ImagetransformflipRange) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_range_to_string(s : ImagetransformflipRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformflipSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_flip_slice_make(size : Int) -> ImagetransformflipSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_flip_slice_len(s : ImagetransformflipSlice) -> Int { s.size }

pub fn image_transform_flip_slice_get(s : ImagetransformflipSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_flip_slice_set(s : ImagetransformflipSlice, i : Int, v : Double) -> ImagetransformflipSlice {
  let result = image_transform_flip_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_slice_sum(s : ImagetransformflipSlice) -> Double { @_common.sum(s.data) }

pub fn image_transform_flip_slice_mean(s : ImagetransformflipSlice) -> Double { @_common.mean(s.data) }

pub fn image_transform_flip_slice_scale(s : ImagetransformflipSlice, f : Double) -> ImagetransformflipSlice {
  let result = image_transform_flip_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_flip_slice_add(a : ImagetransformflipSlice, b : ImagetransformflipSlice) -> ImagetransformflipSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_flip_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_flip_slice_copy(s : ImagetransformflipSlice) -> ImagetransformflipSlice {
  let result = image_transform_flip_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_flip_slice_fill(s : ImagetransformflipSlice, v : Double) -> ImagetransformflipSlice {
  let result = image_transform_flip_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_flip_slice_min(s : ImagetransformflipSlice) -> Double { @_common.min(s.data) }

pub fn image_transform_flip_slice_max(s : ImagetransformflipSlice) -> Double { @_common.max(s.data) }

pub fn image_transform_flip_slice_to_string(s : ImagetransformflipSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

