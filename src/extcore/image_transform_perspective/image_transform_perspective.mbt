///===
/// extcore/image_transform_perspective

pub(all) struct ImagetransformperspectivePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_perspective_make_point(x : Double, y : Double) -> ImagetransformperspectivePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_perspective_make_point3(x : Double, y : Double, z : Double) -> ImagetransformperspectivePoint {
  { x, y, z, label: 0 }
}

pub fn image_transform_perspective_point_x(pt : ImagetransformperspectivePoint) -> Double { pt.x }

pub fn image_transform_perspective_point_y(pt : ImagetransformperspectivePoint) -> Double { pt.y }

pub fn image_transform_perspective_point_z(pt : ImagetransformperspectivePoint) -> Double { pt.z }

pub fn image_transform_perspective_point_label(pt : ImagetransformperspectivePoint) -> Int { pt.label }

pub fn image_transform_perspective_point_dist(a : ImagetransformperspectivePoint, b : ImagetransformperspectivePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_transform_perspective_point_add(a : ImagetransformperspectivePoint, b : ImagetransformperspectivePoint) -> ImagetransformperspectivePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_transform_perspective_point_sub(a : ImagetransformperspectivePoint, b : ImagetransformperspectivePoint) -> ImagetransformperspectivePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_transform_perspective_point_scale(pt : ImagetransformperspectivePoint, s : Double) -> ImagetransformperspectivePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_transform_perspective_point_dot(a : ImagetransformperspectivePoint, b : ImagetransformperspectivePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_transform_perspective_point_cross(a : ImagetransformperspectivePoint, b : ImagetransformperspectivePoint) -> ImagetransformperspectivePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_transform_perspective_point_norm(pt : ImagetransformperspectivePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_transform_perspective_point_normalize(pt : ImagetransformperspectivePoint) -> ImagetransformperspectivePoint {
  let n = image_transform_perspective_point_norm(pt)
  if n < 0.0000001 { pt } else { image_transform_perspective_point_scale(pt, 1.0 / n) }
}

pub fn image_transform_perspective_point_negate(pt : ImagetransformperspectivePoint) -> ImagetransformperspectivePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_transform_perspective_point_mid(a : ImagetransformperspectivePoint, b : ImagetransformperspectivePoint) -> ImagetransformperspectivePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_transform_perspective_point_lerp(a : ImagetransformperspectivePoint, b : ImagetransformperspectivePoint, t : Double) -> ImagetransformperspectivePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_transform_perspective_point_to_string(pt : ImagetransformperspectivePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_perspective_make_series(vals : Array[Double], name : String) -> ImagetransformperspectiveSeries {
  { vals, name, meta: 0 }
}

pub fn image_transform_perspective_series_len(s : ImagetransformperspectiveSeries) -> Int { s.vals.length() }

pub fn image_transform_perspective_series_sum(s : ImagetransformperspectiveSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_transform_perspective_series_mean(s : ImagetransformperspectiveSeries) -> Double { @_common.mean(s.vals) }

pub fn image_transform_perspective_series_min(s : ImagetransformperspectiveSeries) -> Double { @_common.min(s.vals) }

pub fn image_transform_perspective_series_max(s : ImagetransformperspectiveSeries) -> Double { @_common.max(s.vals) }

pub fn image_transform_perspective_series_range(s : ImagetransformperspectiveSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_transform_perspective_series_var(s : ImagetransformperspectiveSeries) -> Double { @_common.variance(s.vals) }

pub fn image_transform_perspective_series_std(s : ImagetransformperspectiveSeries) -> Double { @_common.std(s.vals) }

pub fn image_transform_perspective_series_median(s : ImagetransformperspectiveSeries) -> Double { @_common.median(s.vals) }

pub fn image_transform_perspective_series_scale(s : ImagetransformperspectiveSeries, f : Double) -> ImagetransformperspectiveSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_transform_perspective_series_add(a : ImagetransformperspectiveSeries, b : ImagetransformperspectiveSeries) -> ImagetransformperspectiveSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_transform_perspective_series_sub(a : ImagetransformperspectiveSeries, b : ImagetransformperspectiveSeries) -> ImagetransformperspectiveSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_transform_perspective_series_normalize(s : ImagetransformperspectiveSeries) -> ImagetransformperspectiveSeries {
  let mn = image_transform_perspective_series_min(s)
  let mx = image_transform_perspective_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_transform_perspective_series_cumsum(s : ImagetransformperspectiveSeries) -> ImagetransformperspectiveSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_transform_perspective_series_to_string(s : ImagetransformperspectiveSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformperspectiveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_perspective_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformperspectiveMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_perspective_matrix_identity(n : Int) -> ImagetransformperspectiveMatrix {
  let m = image_transform_perspective_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_transform_perspective_matrix_get(m : ImagetransformperspectiveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_transform_perspective_matrix_transpose(m : ImagetransformperspectiveMatrix) -> ImagetransformperspectiveMatrix {
  let result = image_transform_perspective_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_transform_perspective_matrix_add(a : ImagetransformperspectiveMatrix, b : ImagetransformperspectiveMatrix) -> ImagetransformperspectiveMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_transform_perspective_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_transform_perspective_matrix_scale(m : ImagetransformperspectiveMatrix, s : Double) -> ImagetransformperspectiveMatrix {
  let result = image_transform_perspective_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_transform_perspective_matrix_multiply(a : ImagetransformperspectiveMatrix, b : ImagetransformperspectiveMatrix) -> ImagetransformperspectiveMatrix {
  if a.cols != b.rows { return image_transform_perspective_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_transform_perspective_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_transform_perspective_matrix_trace(m : ImagetransformperspectiveMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_transform_perspective_matrix_det(m : ImagetransformperspectiveMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_transform_perspective_matrix_norm(m : ImagetransformperspectiveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_transform_perspective_matrix_to_string(m : ImagetransformperspectiveMatrix) -> String {
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

pub(all) struct ImagetransformperspectiveVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_perspective_make_vector(comps : Array[Double]) -> ImagetransformperspectiveVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_perspective_vector_zero(dim : Int) -> ImagetransformperspectiveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_transform_perspective_vector_add(a : ImagetransformperspectiveVector, b : ImagetransformperspectiveVector) -> ImagetransformperspectiveVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_perspective_vector_sub(a : ImagetransformperspectiveVector, b : ImagetransformperspectiveVector) -> ImagetransformperspectiveVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_perspective_vector_scale(v : ImagetransformperspectiveVector, s : Double) -> ImagetransformperspectiveVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_transform_perspective_vector_dot(a : ImagetransformperspectiveVector, b : ImagetransformperspectiveVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_transform_perspective_vector_norm(v : ImagetransformperspectiveVector) -> Double { @_common.sqrt(image_transform_perspective_vector_dot(v, v)) }

pub fn image_transform_perspective_vector_normalize(v : ImagetransformperspectiveVector) -> ImagetransformperspectiveVector {
  let n = image_transform_perspective_vector_norm(v)
  if n < 0.0000001 { v } else { image_transform_perspective_vector_scale(v, 1.0 / n) }
}

pub fn image_transform_perspective_vector_dist(a : ImagetransformperspectiveVector, b : ImagetransformperspectiveVector) -> Double {
  image_transform_perspective_vector_norm(image_transform_perspective_vector_sub(a, b))
}

pub fn image_transform_perspective_vector_to_string(v : ImagetransformperspectiveVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_perspective_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_perspective_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_perspective_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_perspective_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_perspective_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_perspective_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_perspective_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_perspective_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_perspective_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_perspective_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_perspective_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_perspective_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_perspective_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_perspective_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_perspective_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_perspective_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_perspective_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_perspective_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_perspective_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_perspective_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_perspective_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_perspective_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_perspective_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_perspective_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_perspective_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_perspective_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_perspective_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_perspective_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_perspective_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformperspectiveFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_frame_make(size : Int) -> ImagetransformperspectiveFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_frame_len(s : ImagetransformperspectiveFrame) -> Int { s.size }

pub fn image_transform_perspective_frame_get(s : ImagetransformperspectiveFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_frame_set(s : ImagetransformperspectiveFrame, i : Int, v : Double) -> ImagetransformperspectiveFrame {
  let result = image_transform_perspective_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_frame_sum(s : ImagetransformperspectiveFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_perspective_frame_mean(s : ImagetransformperspectiveFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_perspective_frame_sum(s) / s.size.to_double() }
}

pub fn image_transform_perspective_frame_scale(s : ImagetransformperspectiveFrame, f : Double) -> ImagetransformperspectiveFrame {
  let result = image_transform_perspective_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_perspective_frame_add(a : ImagetransformperspectiveFrame, b : ImagetransformperspectiveFrame) -> ImagetransformperspectiveFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_perspective_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_perspective_frame_copy(s : ImagetransformperspectiveFrame) -> ImagetransformperspectiveFrame {
  let result = image_transform_perspective_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_perspective_frame_fill(s : ImagetransformperspectiveFrame, v : Double) -> ImagetransformperspectiveFrame {
  let result = image_transform_perspective_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_frame_min(s : ImagetransformperspectiveFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_frame_max(s : ImagetransformperspectiveFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_frame_to_string(s : ImagetransformperspectiveFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_table_make(size : Int) -> ImagetransformperspectiveTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_table_len(s : ImagetransformperspectiveTable) -> Int { s.size }

pub fn image_transform_perspective_table_get(s : ImagetransformperspectiveTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_table_set(s : ImagetransformperspectiveTable, i : Int, v : Double) -> ImagetransformperspectiveTable {
  let result = image_transform_perspective_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_table_sum(s : ImagetransformperspectiveTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_perspective_table_mean(s : ImagetransformperspectiveTable) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_perspective_table_sum(s) / s.size.to_double() }
}

pub fn image_transform_perspective_table_scale(s : ImagetransformperspectiveTable, f : Double) -> ImagetransformperspectiveTable {
  let result = image_transform_perspective_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_perspective_table_add(a : ImagetransformperspectiveTable, b : ImagetransformperspectiveTable) -> ImagetransformperspectiveTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_perspective_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_perspective_table_copy(s : ImagetransformperspectiveTable) -> ImagetransformperspectiveTable {
  let result = image_transform_perspective_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_perspective_table_fill(s : ImagetransformperspectiveTable, v : Double) -> ImagetransformperspectiveTable {
  let result = image_transform_perspective_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_table_min(s : ImagetransformperspectiveTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_table_max(s : ImagetransformperspectiveTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_table_to_string(s : ImagetransformperspectiveTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_graphn_make(size : Int) -> ImagetransformperspectiveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_graphn_len(s : ImagetransformperspectiveGraphN) -> Int { s.size }

pub fn image_transform_perspective_graphn_get(s : ImagetransformperspectiveGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_graphn_set(s : ImagetransformperspectiveGraphN, i : Int, v : Double) -> ImagetransformperspectiveGraphN {
  let result = image_transform_perspective_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_graphn_sum(s : ImagetransformperspectiveGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_perspective_graphn_mean(s : ImagetransformperspectiveGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_perspective_graphn_sum(s) / s.size.to_double() }
}

pub fn image_transform_perspective_graphn_scale(s : ImagetransformperspectiveGraphN, f : Double) -> ImagetransformperspectiveGraphN {
  let result = image_transform_perspective_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_perspective_graphn_add(a : ImagetransformperspectiveGraphN, b : ImagetransformperspectiveGraphN) -> ImagetransformperspectiveGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_perspective_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_perspective_graphn_copy(s : ImagetransformperspectiveGraphN) -> ImagetransformperspectiveGraphN {
  let result = image_transform_perspective_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_perspective_graphn_fill(s : ImagetransformperspectiveGraphN, v : Double) -> ImagetransformperspectiveGraphN {
  let result = image_transform_perspective_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_graphn_min(s : ImagetransformperspectiveGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_graphn_max(s : ImagetransformperspectiveGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_graphn_to_string(s : ImagetransformperspectiveGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_node_make(size : Int) -> ImagetransformperspectiveNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_node_len(s : ImagetransformperspectiveNode) -> Int { s.size }

pub fn image_transform_perspective_node_get(s : ImagetransformperspectiveNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_node_set(s : ImagetransformperspectiveNode, i : Int, v : Double) -> ImagetransformperspectiveNode {
  let result = image_transform_perspective_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_node_sum(s : ImagetransformperspectiveNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_perspective_node_mean(s : ImagetransformperspectiveNode) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_perspective_node_sum(s) / s.size.to_double() }
}

pub fn image_transform_perspective_node_scale(s : ImagetransformperspectiveNode, f : Double) -> ImagetransformperspectiveNode {
  let result = image_transform_perspective_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_perspective_node_add(a : ImagetransformperspectiveNode, b : ImagetransformperspectiveNode) -> ImagetransformperspectiveNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_perspective_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_perspective_node_copy(s : ImagetransformperspectiveNode) -> ImagetransformperspectiveNode {
  let result = image_transform_perspective_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_perspective_node_fill(s : ImagetransformperspectiveNode, v : Double) -> ImagetransformperspectiveNode {
  let result = image_transform_perspective_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_node_min(s : ImagetransformperspectiveNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_node_max(s : ImagetransformperspectiveNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_node_to_string(s : ImagetransformperspectiveNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_edge_make(size : Int) -> ImagetransformperspectiveEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_edge_len(s : ImagetransformperspectiveEdge) -> Int { s.size }

pub fn image_transform_perspective_edge_get(s : ImagetransformperspectiveEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_edge_set(s : ImagetransformperspectiveEdge, i : Int, v : Double) -> ImagetransformperspectiveEdge {
  let result = image_transform_perspective_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_edge_sum(s : ImagetransformperspectiveEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_perspective_edge_mean(s : ImagetransformperspectiveEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_perspective_edge_sum(s) / s.size.to_double() }
}

pub fn image_transform_perspective_edge_scale(s : ImagetransformperspectiveEdge, f : Double) -> ImagetransformperspectiveEdge {
  let result = image_transform_perspective_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_perspective_edge_add(a : ImagetransformperspectiveEdge, b : ImagetransformperspectiveEdge) -> ImagetransformperspectiveEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_perspective_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_perspective_edge_copy(s : ImagetransformperspectiveEdge) -> ImagetransformperspectiveEdge {
  let result = image_transform_perspective_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_perspective_edge_fill(s : ImagetransformperspectiveEdge, v : Double) -> ImagetransformperspectiveEdge {
  let result = image_transform_perspective_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_edge_min(s : ImagetransformperspectiveEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_edge_max(s : ImagetransformperspectiveEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_edge_to_string(s : ImagetransformperspectiveEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectivePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_path_make(size : Int) -> ImagetransformperspectivePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_path_len(s : ImagetransformperspectivePath) -> Int { s.size }

pub fn image_transform_perspective_path_get(s : ImagetransformperspectivePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_path_set(s : ImagetransformperspectivePath, i : Int, v : Double) -> ImagetransformperspectivePath {
  let result = image_transform_perspective_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_path_sum(s : ImagetransformperspectivePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_perspective_path_mean(s : ImagetransformperspectivePath) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_perspective_path_sum(s) / s.size.to_double() }
}

pub fn image_transform_perspective_path_scale(s : ImagetransformperspectivePath, f : Double) -> ImagetransformperspectivePath {
  let result = image_transform_perspective_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_perspective_path_add(a : ImagetransformperspectivePath, b : ImagetransformperspectivePath) -> ImagetransformperspectivePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_perspective_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_perspective_path_copy(s : ImagetransformperspectivePath) -> ImagetransformperspectivePath {
  let result = image_transform_perspective_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_perspective_path_fill(s : ImagetransformperspectivePath, v : Double) -> ImagetransformperspectivePath {
  let result = image_transform_perspective_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_path_min(s : ImagetransformperspectivePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_path_max(s : ImagetransformperspectivePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_path_to_string(s : ImagetransformperspectivePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_cluster_make(size : Int) -> ImagetransformperspectiveCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_cluster_len(s : ImagetransformperspectiveCluster) -> Int { s.size }

pub fn image_transform_perspective_cluster_get(s : ImagetransformperspectiveCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_cluster_set(s : ImagetransformperspectiveCluster, i : Int, v : Double) -> ImagetransformperspectiveCluster {
  let result = image_transform_perspective_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_cluster_sum(s : ImagetransformperspectiveCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_perspective_cluster_mean(s : ImagetransformperspectiveCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_perspective_cluster_sum(s) / s.size.to_double() }
}

pub fn image_transform_perspective_cluster_scale(s : ImagetransformperspectiveCluster, f : Double) -> ImagetransformperspectiveCluster {
  let result = image_transform_perspective_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_perspective_cluster_add(a : ImagetransformperspectiveCluster, b : ImagetransformperspectiveCluster) -> ImagetransformperspectiveCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_perspective_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_perspective_cluster_copy(s : ImagetransformperspectiveCluster) -> ImagetransformperspectiveCluster {
  let result = image_transform_perspective_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_perspective_cluster_fill(s : ImagetransformperspectiveCluster, v : Double) -> ImagetransformperspectiveCluster {
  let result = image_transform_perspective_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_cluster_min(s : ImagetransformperspectiveCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_cluster_max(s : ImagetransformperspectiveCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_cluster_to_string(s : ImagetransformperspectiveCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_model_make(size : Int) -> ImagetransformperspectiveModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_model_len(s : ImagetransformperspectiveModel) -> Int { s.size }

pub fn image_transform_perspective_model_get(s : ImagetransformperspectiveModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_model_set(s : ImagetransformperspectiveModel, i : Int, v : Double) -> ImagetransformperspectiveModel {
  let result = image_transform_perspective_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_model_sum(s : ImagetransformperspectiveModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_perspective_model_mean(s : ImagetransformperspectiveModel) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_perspective_model_sum(s) / s.size.to_double() }
}

pub fn image_transform_perspective_model_scale(s : ImagetransformperspectiveModel, f : Double) -> ImagetransformperspectiveModel {
  let result = image_transform_perspective_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_perspective_model_add(a : ImagetransformperspectiveModel, b : ImagetransformperspectiveModel) -> ImagetransformperspectiveModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_perspective_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_perspective_model_copy(s : ImagetransformperspectiveModel) -> ImagetransformperspectiveModel {
  let result = image_transform_perspective_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_perspective_model_fill(s : ImagetransformperspectiveModel, v : Double) -> ImagetransformperspectiveModel {
  let result = image_transform_perspective_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_model_min(s : ImagetransformperspectiveModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_model_max(s : ImagetransformperspectiveModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_model_to_string(s : ImagetransformperspectiveModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_layer_make(size : Int) -> ImagetransformperspectiveLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_layer_len(s : ImagetransformperspectiveLayer) -> Int { s.size }

pub fn image_transform_perspective_layer_get(s : ImagetransformperspectiveLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_layer_set(s : ImagetransformperspectiveLayer, i : Int, v : Double) -> ImagetransformperspectiveLayer {
  let result = image_transform_perspective_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_layer_sum(s : ImagetransformperspectiveLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_perspective_layer_mean(s : ImagetransformperspectiveLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_perspective_layer_sum(s) / s.size.to_double() }
}

pub fn image_transform_perspective_layer_scale(s : ImagetransformperspectiveLayer, f : Double) -> ImagetransformperspectiveLayer {
  let result = image_transform_perspective_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_perspective_layer_add(a : ImagetransformperspectiveLayer, b : ImagetransformperspectiveLayer) -> ImagetransformperspectiveLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_perspective_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_perspective_layer_copy(s : ImagetransformperspectiveLayer) -> ImagetransformperspectiveLayer {
  let result = image_transform_perspective_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_perspective_layer_fill(s : ImagetransformperspectiveLayer, v : Double) -> ImagetransformperspectiveLayer {
  let result = image_transform_perspective_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_layer_min(s : ImagetransformperspectiveLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_layer_max(s : ImagetransformperspectiveLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_layer_to_string(s : ImagetransformperspectiveLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_buffer_make(size : Int) -> ImagetransformperspectiveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_buffer_len(s : ImagetransformperspectiveBuffer) -> Int { s.size }

pub fn image_transform_perspective_buffer_get(s : ImagetransformperspectiveBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_buffer_set(s : ImagetransformperspectiveBuffer, i : Int, v : Double) -> ImagetransformperspectiveBuffer {
  let result = image_transform_perspective_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_buffer_sum(s : ImagetransformperspectiveBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_perspective_buffer_mean(s : ImagetransformperspectiveBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_perspective_buffer_sum(s) / s.size.to_double() }
}

pub fn image_transform_perspective_buffer_scale(s : ImagetransformperspectiveBuffer, f : Double) -> ImagetransformperspectiveBuffer {
  let result = image_transform_perspective_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_perspective_buffer_add(a : ImagetransformperspectiveBuffer, b : ImagetransformperspectiveBuffer) -> ImagetransformperspectiveBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_perspective_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_perspective_buffer_copy(s : ImagetransformperspectiveBuffer) -> ImagetransformperspectiveBuffer {
  let result = image_transform_perspective_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_perspective_buffer_fill(s : ImagetransformperspectiveBuffer, v : Double) -> ImagetransformperspectiveBuffer {
  let result = image_transform_perspective_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_buffer_min(s : ImagetransformperspectiveBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_buffer_max(s : ImagetransformperspectiveBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_buffer_to_string(s : ImagetransformperspectiveBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_cursor_make(size : Int) -> ImagetransformperspectiveCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_cursor_len(s : ImagetransformperspectiveCursor) -> Int { s.size }

pub fn image_transform_perspective_cursor_get(s : ImagetransformperspectiveCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_cursor_set(s : ImagetransformperspectiveCursor, i : Int, v : Double) -> ImagetransformperspectiveCursor {
  let result = image_transform_perspective_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_cursor_sum(s : ImagetransformperspectiveCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_perspective_cursor_mean(s : ImagetransformperspectiveCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_perspective_cursor_sum(s) / s.size.to_double() }
}

pub fn image_transform_perspective_cursor_scale(s : ImagetransformperspectiveCursor, f : Double) -> ImagetransformperspectiveCursor {
  let result = image_transform_perspective_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_perspective_cursor_add(a : ImagetransformperspectiveCursor, b : ImagetransformperspectiveCursor) -> ImagetransformperspectiveCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_perspective_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_perspective_cursor_copy(s : ImagetransformperspectiveCursor) -> ImagetransformperspectiveCursor {
  let result = image_transform_perspective_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_perspective_cursor_fill(s : ImagetransformperspectiveCursor, v : Double) -> ImagetransformperspectiveCursor {
  let result = image_transform_perspective_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_cursor_min(s : ImagetransformperspectiveCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_cursor_max(s : ImagetransformperspectiveCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_cursor_to_string(s : ImagetransformperspectiveCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_view_make(size : Int) -> ImagetransformperspectiveView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_view_len(s : ImagetransformperspectiveView) -> Int { s.size }

pub fn image_transform_perspective_view_get(s : ImagetransformperspectiveView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_view_set(s : ImagetransformperspectiveView, i : Int, v : Double) -> ImagetransformperspectiveView {
  let result = image_transform_perspective_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_view_sum(s : ImagetransformperspectiveView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_perspective_view_mean(s : ImagetransformperspectiveView) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_perspective_view_sum(s) / s.size.to_double() }
}

pub fn image_transform_perspective_view_scale(s : ImagetransformperspectiveView, f : Double) -> ImagetransformperspectiveView {
  let result = image_transform_perspective_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_perspective_view_add(a : ImagetransformperspectiveView, b : ImagetransformperspectiveView) -> ImagetransformperspectiveView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_perspective_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_perspective_view_copy(s : ImagetransformperspectiveView) -> ImagetransformperspectiveView {
  let result = image_transform_perspective_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_perspective_view_fill(s : ImagetransformperspectiveView, v : Double) -> ImagetransformperspectiveView {
  let result = image_transform_perspective_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_view_min(s : ImagetransformperspectiveView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_view_max(s : ImagetransformperspectiveView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_view_to_string(s : ImagetransformperspectiveView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_range_make(size : Int) -> ImagetransformperspectiveRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_range_len(s : ImagetransformperspectiveRange) -> Int { s.size }

pub fn image_transform_perspective_range_get(s : ImagetransformperspectiveRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_range_set(s : ImagetransformperspectiveRange, i : Int, v : Double) -> ImagetransformperspectiveRange {
  let result = image_transform_perspective_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_range_sum(s : ImagetransformperspectiveRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_perspective_range_mean(s : ImagetransformperspectiveRange) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_perspective_range_sum(s) / s.size.to_double() }
}

pub fn image_transform_perspective_range_scale(s : ImagetransformperspectiveRange, f : Double) -> ImagetransformperspectiveRange {
  let result = image_transform_perspective_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_perspective_range_add(a : ImagetransformperspectiveRange, b : ImagetransformperspectiveRange) -> ImagetransformperspectiveRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_perspective_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_perspective_range_copy(s : ImagetransformperspectiveRange) -> ImagetransformperspectiveRange {
  let result = image_transform_perspective_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_perspective_range_fill(s : ImagetransformperspectiveRange, v : Double) -> ImagetransformperspectiveRange {
  let result = image_transform_perspective_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_range_min(s : ImagetransformperspectiveRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_range_max(s : ImagetransformperspectiveRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_range_to_string(s : ImagetransformperspectiveRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformperspectiveSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_perspective_slice_make(size : Int) -> ImagetransformperspectiveSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_perspective_slice_len(s : ImagetransformperspectiveSlice) -> Int { s.size }

pub fn image_transform_perspective_slice_get(s : ImagetransformperspectiveSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_perspective_slice_set(s : ImagetransformperspectiveSlice, i : Int, v : Double) -> ImagetransformperspectiveSlice {
  let result = image_transform_perspective_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_slice_sum(s : ImagetransformperspectiveSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_perspective_slice_mean(s : ImagetransformperspectiveSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_perspective_slice_sum(s) / s.size.to_double() }
}

pub fn image_transform_perspective_slice_scale(s : ImagetransformperspectiveSlice, f : Double) -> ImagetransformperspectiveSlice {
  let result = image_transform_perspective_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_perspective_slice_add(a : ImagetransformperspectiveSlice, b : ImagetransformperspectiveSlice) -> ImagetransformperspectiveSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_perspective_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_perspective_slice_copy(s : ImagetransformperspectiveSlice) -> ImagetransformperspectiveSlice {
  let result = image_transform_perspective_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_perspective_slice_fill(s : ImagetransformperspectiveSlice, v : Double) -> ImagetransformperspectiveSlice {
  let result = image_transform_perspective_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_perspective_slice_min(s : ImagetransformperspectiveSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_slice_max(s : ImagetransformperspectiveSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_perspective_slice_to_string(s : ImagetransformperspectiveSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

