///===
/// extcore/image_feature_sift

pub(all) struct ImagefeaturesiftPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_sift_make_point(x : Double, y : Double) -> ImagefeaturesiftPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_sift_make_point3(x : Double, y : Double, z : Double) -> ImagefeaturesiftPoint {
  { x, y, z, label: 0 }
}

pub fn image_feature_sift_point_x(pt : ImagefeaturesiftPoint) -> Double { pt.x }

pub fn image_feature_sift_point_y(pt : ImagefeaturesiftPoint) -> Double { pt.y }

pub fn image_feature_sift_point_z(pt : ImagefeaturesiftPoint) -> Double { pt.z }

pub fn image_feature_sift_point_label(pt : ImagefeaturesiftPoint) -> Int { pt.label }

pub fn image_feature_sift_point_dist(a : ImagefeaturesiftPoint, b : ImagefeaturesiftPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_feature_sift_point_add(a : ImagefeaturesiftPoint, b : ImagefeaturesiftPoint) -> ImagefeaturesiftPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_feature_sift_point_sub(a : ImagefeaturesiftPoint, b : ImagefeaturesiftPoint) -> ImagefeaturesiftPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_feature_sift_point_scale(pt : ImagefeaturesiftPoint, s : Double) -> ImagefeaturesiftPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_feature_sift_point_dot(a : ImagefeaturesiftPoint, b : ImagefeaturesiftPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_feature_sift_point_cross(a : ImagefeaturesiftPoint, b : ImagefeaturesiftPoint) -> ImagefeaturesiftPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_feature_sift_point_norm(pt : ImagefeaturesiftPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_feature_sift_point_normalize(pt : ImagefeaturesiftPoint) -> ImagefeaturesiftPoint {
  let n = image_feature_sift_point_norm(pt)
  if n < 0.0000001 { pt } else { image_feature_sift_point_scale(pt, 1.0 / n) }
}

pub fn image_feature_sift_point_negate(pt : ImagefeaturesiftPoint) -> ImagefeaturesiftPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_feature_sift_point_mid(a : ImagefeaturesiftPoint, b : ImagefeaturesiftPoint) -> ImagefeaturesiftPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_feature_sift_point_lerp(a : ImagefeaturesiftPoint, b : ImagefeaturesiftPoint, t : Double) -> ImagefeaturesiftPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_feature_sift_point_to_string(pt : ImagefeaturesiftPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefeaturesiftSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_sift_make_series(vals : Array[Double], name : String) -> ImagefeaturesiftSeries {
  { vals, name, meta: 0 }
}

pub fn image_feature_sift_series_len(s : ImagefeaturesiftSeries) -> Int { s.vals.length() }

pub fn image_feature_sift_series_sum(s : ImagefeaturesiftSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_feature_sift_series_mean(s : ImagefeaturesiftSeries) -> Double {
  let n = image_feature_sift_series_len(s)
  if n == 0 { 0.0 } else { image_feature_sift_series_sum(s) / n.to_double() }
}

pub fn image_feature_sift_series_min(s : ImagefeaturesiftSeries) -> Double {
  let n = image_feature_sift_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_feature_sift_series_max(s : ImagefeaturesiftSeries) -> Double {
  let n = image_feature_sift_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_feature_sift_series_range(s : ImagefeaturesiftSeries) -> Double {
  image_feature_sift_series_max(s) - image_feature_sift_series_min(s)
}

pub fn image_feature_sift_series_var(s : ImagefeaturesiftSeries) -> Double {
  let n = image_feature_sift_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_feature_sift_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_feature_sift_series_std(s : ImagefeaturesiftSeries) -> Double { @_common.sqrt(image_feature_sift_series_var(s)) }

pub fn image_feature_sift_series_median(s : ImagefeaturesiftSeries) -> Double {
  let n = image_feature_sift_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_feature_sift_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_feature_sift_series_scale(s : ImagefeaturesiftSeries, f : Double) -> ImagefeaturesiftSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_feature_sift_series_add(a : ImagefeaturesiftSeries, b : ImagefeaturesiftSeries) -> ImagefeaturesiftSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_feature_sift_series_sub(a : ImagefeaturesiftSeries, b : ImagefeaturesiftSeries) -> ImagefeaturesiftSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_feature_sift_series_normalize(s : ImagefeaturesiftSeries) -> ImagefeaturesiftSeries {
  let mn = image_feature_sift_series_min(s)
  let mx = image_feature_sift_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_feature_sift_series_cumsum(s : ImagefeaturesiftSeries) -> ImagefeaturesiftSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_feature_sift_series_to_string(s : ImagefeaturesiftSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturesiftMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_sift_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeaturesiftMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_sift_matrix_identity(n : Int) -> ImagefeaturesiftMatrix {
  let m = image_feature_sift_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_feature_sift_matrix_get(m : ImagefeaturesiftMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_feature_sift_matrix_transpose(m : ImagefeaturesiftMatrix) -> ImagefeaturesiftMatrix {
  let result = image_feature_sift_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_feature_sift_matrix_add(a : ImagefeaturesiftMatrix, b : ImagefeaturesiftMatrix) -> ImagefeaturesiftMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_feature_sift_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_feature_sift_matrix_scale(m : ImagefeaturesiftMatrix, s : Double) -> ImagefeaturesiftMatrix {
  let result = image_feature_sift_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_feature_sift_matrix_multiply(a : ImagefeaturesiftMatrix, b : ImagefeaturesiftMatrix) -> ImagefeaturesiftMatrix {
  if a.cols != b.rows { return image_feature_sift_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_feature_sift_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_feature_sift_matrix_trace(m : ImagefeaturesiftMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_feature_sift_matrix_det(m : ImagefeaturesiftMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_feature_sift_matrix_norm(m : ImagefeaturesiftMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_feature_sift_matrix_to_string(m : ImagefeaturesiftMatrix) -> String {
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

pub(all) struct ImagefeaturesiftVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_sift_make_vector(comps : Array[Double]) -> ImagefeaturesiftVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_sift_vector_zero(dim : Int) -> ImagefeaturesiftVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_feature_sift_vector_add(a : ImagefeaturesiftVector, b : ImagefeaturesiftVector) -> ImagefeaturesiftVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_sift_vector_sub(a : ImagefeaturesiftVector, b : ImagefeaturesiftVector) -> ImagefeaturesiftVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_sift_vector_scale(v : ImagefeaturesiftVector, s : Double) -> ImagefeaturesiftVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_feature_sift_vector_dot(a : ImagefeaturesiftVector, b : ImagefeaturesiftVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_feature_sift_vector_norm(v : ImagefeaturesiftVector) -> Double { @_common.sqrt(image_feature_sift_vector_dot(v, v)) }

pub fn image_feature_sift_vector_normalize(v : ImagefeaturesiftVector) -> ImagefeaturesiftVector {
  let n = image_feature_sift_vector_norm(v)
  if n < 0.0000001 { v } else { image_feature_sift_vector_scale(v, 1.0 / n) }
}

pub fn image_feature_sift_vector_dist(a : ImagefeaturesiftVector, b : ImagefeaturesiftVector) -> Double {
  image_feature_sift_vector_norm(image_feature_sift_vector_sub(a, b))
}

pub fn image_feature_sift_vector_to_string(v : ImagefeaturesiftVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_sift_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_feature_sift_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_feature_sift_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_feature_sift_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_feature_sift_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_feature_sift_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_feature_sift_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_feature_sift_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_feature_sift_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_feature_sift_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_feature_sift_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_feature_sift_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_feature_sift_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_feature_sift_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_feature_sift_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_feature_sift_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_feature_sift_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_feature_sift_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_feature_sift_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_feature_sift_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_feature_sift_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_feature_sift_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_feature_sift_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_feature_sift_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_feature_sift_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_feature_sift_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_feature_sift_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_feature_sift_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_feature_sift_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefeaturesiftFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_frame_make(size : Int) -> ImagefeaturesiftFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_frame_len(s : ImagefeaturesiftFrame) -> Int { s.size }

pub fn image_feature_sift_frame_get(s : ImagefeaturesiftFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_frame_set(s : ImagefeaturesiftFrame, i : Int, v : Double) -> ImagefeaturesiftFrame {
  let result = image_feature_sift_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_frame_sum(s : ImagefeaturesiftFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_sift_frame_mean(s : ImagefeaturesiftFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_sift_frame_sum(s) / s.size.to_double() }
}

pub fn image_feature_sift_frame_scale(s : ImagefeaturesiftFrame, f : Double) -> ImagefeaturesiftFrame {
  let result = image_feature_sift_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_sift_frame_add(a : ImagefeaturesiftFrame, b : ImagefeaturesiftFrame) -> ImagefeaturesiftFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_sift_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_sift_frame_copy(s : ImagefeaturesiftFrame) -> ImagefeaturesiftFrame {
  let result = image_feature_sift_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_sift_frame_fill(s : ImagefeaturesiftFrame, v : Double) -> ImagefeaturesiftFrame {
  let result = image_feature_sift_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_frame_min(s : ImagefeaturesiftFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_frame_max(s : ImagefeaturesiftFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_frame_to_string(s : ImagefeaturesiftFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_table_make(size : Int) -> ImagefeaturesiftTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_table_len(s : ImagefeaturesiftTable) -> Int { s.size }

pub fn image_feature_sift_table_get(s : ImagefeaturesiftTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_table_set(s : ImagefeaturesiftTable, i : Int, v : Double) -> ImagefeaturesiftTable {
  let result = image_feature_sift_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_table_sum(s : ImagefeaturesiftTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_sift_table_mean(s : ImagefeaturesiftTable) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_sift_table_sum(s) / s.size.to_double() }
}

pub fn image_feature_sift_table_scale(s : ImagefeaturesiftTable, f : Double) -> ImagefeaturesiftTable {
  let result = image_feature_sift_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_sift_table_add(a : ImagefeaturesiftTable, b : ImagefeaturesiftTable) -> ImagefeaturesiftTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_sift_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_sift_table_copy(s : ImagefeaturesiftTable) -> ImagefeaturesiftTable {
  let result = image_feature_sift_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_sift_table_fill(s : ImagefeaturesiftTable, v : Double) -> ImagefeaturesiftTable {
  let result = image_feature_sift_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_table_min(s : ImagefeaturesiftTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_table_max(s : ImagefeaturesiftTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_table_to_string(s : ImagefeaturesiftTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_graphn_make(size : Int) -> ImagefeaturesiftGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_graphn_len(s : ImagefeaturesiftGraphN) -> Int { s.size }

pub fn image_feature_sift_graphn_get(s : ImagefeaturesiftGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_graphn_set(s : ImagefeaturesiftGraphN, i : Int, v : Double) -> ImagefeaturesiftGraphN {
  let result = image_feature_sift_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_graphn_sum(s : ImagefeaturesiftGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_sift_graphn_mean(s : ImagefeaturesiftGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_sift_graphn_sum(s) / s.size.to_double() }
}

pub fn image_feature_sift_graphn_scale(s : ImagefeaturesiftGraphN, f : Double) -> ImagefeaturesiftGraphN {
  let result = image_feature_sift_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_sift_graphn_add(a : ImagefeaturesiftGraphN, b : ImagefeaturesiftGraphN) -> ImagefeaturesiftGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_sift_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_sift_graphn_copy(s : ImagefeaturesiftGraphN) -> ImagefeaturesiftGraphN {
  let result = image_feature_sift_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_sift_graphn_fill(s : ImagefeaturesiftGraphN, v : Double) -> ImagefeaturesiftGraphN {
  let result = image_feature_sift_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_graphn_min(s : ImagefeaturesiftGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_graphn_max(s : ImagefeaturesiftGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_graphn_to_string(s : ImagefeaturesiftGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_node_make(size : Int) -> ImagefeaturesiftNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_node_len(s : ImagefeaturesiftNode) -> Int { s.size }

pub fn image_feature_sift_node_get(s : ImagefeaturesiftNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_node_set(s : ImagefeaturesiftNode, i : Int, v : Double) -> ImagefeaturesiftNode {
  let result = image_feature_sift_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_node_sum(s : ImagefeaturesiftNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_sift_node_mean(s : ImagefeaturesiftNode) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_sift_node_sum(s) / s.size.to_double() }
}

pub fn image_feature_sift_node_scale(s : ImagefeaturesiftNode, f : Double) -> ImagefeaturesiftNode {
  let result = image_feature_sift_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_sift_node_add(a : ImagefeaturesiftNode, b : ImagefeaturesiftNode) -> ImagefeaturesiftNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_sift_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_sift_node_copy(s : ImagefeaturesiftNode) -> ImagefeaturesiftNode {
  let result = image_feature_sift_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_sift_node_fill(s : ImagefeaturesiftNode, v : Double) -> ImagefeaturesiftNode {
  let result = image_feature_sift_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_node_min(s : ImagefeaturesiftNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_node_max(s : ImagefeaturesiftNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_node_to_string(s : ImagefeaturesiftNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_edge_make(size : Int) -> ImagefeaturesiftEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_edge_len(s : ImagefeaturesiftEdge) -> Int { s.size }

pub fn image_feature_sift_edge_get(s : ImagefeaturesiftEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_edge_set(s : ImagefeaturesiftEdge, i : Int, v : Double) -> ImagefeaturesiftEdge {
  let result = image_feature_sift_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_edge_sum(s : ImagefeaturesiftEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_sift_edge_mean(s : ImagefeaturesiftEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_sift_edge_sum(s) / s.size.to_double() }
}

pub fn image_feature_sift_edge_scale(s : ImagefeaturesiftEdge, f : Double) -> ImagefeaturesiftEdge {
  let result = image_feature_sift_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_sift_edge_add(a : ImagefeaturesiftEdge, b : ImagefeaturesiftEdge) -> ImagefeaturesiftEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_sift_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_sift_edge_copy(s : ImagefeaturesiftEdge) -> ImagefeaturesiftEdge {
  let result = image_feature_sift_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_sift_edge_fill(s : ImagefeaturesiftEdge, v : Double) -> ImagefeaturesiftEdge {
  let result = image_feature_sift_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_edge_min(s : ImagefeaturesiftEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_edge_max(s : ImagefeaturesiftEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_edge_to_string(s : ImagefeaturesiftEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_path_make(size : Int) -> ImagefeaturesiftPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_path_len(s : ImagefeaturesiftPath) -> Int { s.size }

pub fn image_feature_sift_path_get(s : ImagefeaturesiftPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_path_set(s : ImagefeaturesiftPath, i : Int, v : Double) -> ImagefeaturesiftPath {
  let result = image_feature_sift_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_path_sum(s : ImagefeaturesiftPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_sift_path_mean(s : ImagefeaturesiftPath) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_sift_path_sum(s) / s.size.to_double() }
}

pub fn image_feature_sift_path_scale(s : ImagefeaturesiftPath, f : Double) -> ImagefeaturesiftPath {
  let result = image_feature_sift_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_sift_path_add(a : ImagefeaturesiftPath, b : ImagefeaturesiftPath) -> ImagefeaturesiftPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_sift_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_sift_path_copy(s : ImagefeaturesiftPath) -> ImagefeaturesiftPath {
  let result = image_feature_sift_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_sift_path_fill(s : ImagefeaturesiftPath, v : Double) -> ImagefeaturesiftPath {
  let result = image_feature_sift_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_path_min(s : ImagefeaturesiftPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_path_max(s : ImagefeaturesiftPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_path_to_string(s : ImagefeaturesiftPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_cluster_make(size : Int) -> ImagefeaturesiftCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_cluster_len(s : ImagefeaturesiftCluster) -> Int { s.size }

pub fn image_feature_sift_cluster_get(s : ImagefeaturesiftCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_cluster_set(s : ImagefeaturesiftCluster, i : Int, v : Double) -> ImagefeaturesiftCluster {
  let result = image_feature_sift_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_cluster_sum(s : ImagefeaturesiftCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_sift_cluster_mean(s : ImagefeaturesiftCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_sift_cluster_sum(s) / s.size.to_double() }
}

pub fn image_feature_sift_cluster_scale(s : ImagefeaturesiftCluster, f : Double) -> ImagefeaturesiftCluster {
  let result = image_feature_sift_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_sift_cluster_add(a : ImagefeaturesiftCluster, b : ImagefeaturesiftCluster) -> ImagefeaturesiftCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_sift_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_sift_cluster_copy(s : ImagefeaturesiftCluster) -> ImagefeaturesiftCluster {
  let result = image_feature_sift_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_sift_cluster_fill(s : ImagefeaturesiftCluster, v : Double) -> ImagefeaturesiftCluster {
  let result = image_feature_sift_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_cluster_min(s : ImagefeaturesiftCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_cluster_max(s : ImagefeaturesiftCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_cluster_to_string(s : ImagefeaturesiftCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_model_make(size : Int) -> ImagefeaturesiftModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_model_len(s : ImagefeaturesiftModel) -> Int { s.size }

pub fn image_feature_sift_model_get(s : ImagefeaturesiftModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_model_set(s : ImagefeaturesiftModel, i : Int, v : Double) -> ImagefeaturesiftModel {
  let result = image_feature_sift_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_model_sum(s : ImagefeaturesiftModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_sift_model_mean(s : ImagefeaturesiftModel) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_sift_model_sum(s) / s.size.to_double() }
}

pub fn image_feature_sift_model_scale(s : ImagefeaturesiftModel, f : Double) -> ImagefeaturesiftModel {
  let result = image_feature_sift_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_sift_model_add(a : ImagefeaturesiftModel, b : ImagefeaturesiftModel) -> ImagefeaturesiftModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_sift_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_sift_model_copy(s : ImagefeaturesiftModel) -> ImagefeaturesiftModel {
  let result = image_feature_sift_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_sift_model_fill(s : ImagefeaturesiftModel, v : Double) -> ImagefeaturesiftModel {
  let result = image_feature_sift_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_model_min(s : ImagefeaturesiftModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_model_max(s : ImagefeaturesiftModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_model_to_string(s : ImagefeaturesiftModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_layer_make(size : Int) -> ImagefeaturesiftLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_layer_len(s : ImagefeaturesiftLayer) -> Int { s.size }

pub fn image_feature_sift_layer_get(s : ImagefeaturesiftLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_layer_set(s : ImagefeaturesiftLayer, i : Int, v : Double) -> ImagefeaturesiftLayer {
  let result = image_feature_sift_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_layer_sum(s : ImagefeaturesiftLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_sift_layer_mean(s : ImagefeaturesiftLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_sift_layer_sum(s) / s.size.to_double() }
}

pub fn image_feature_sift_layer_scale(s : ImagefeaturesiftLayer, f : Double) -> ImagefeaturesiftLayer {
  let result = image_feature_sift_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_sift_layer_add(a : ImagefeaturesiftLayer, b : ImagefeaturesiftLayer) -> ImagefeaturesiftLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_sift_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_sift_layer_copy(s : ImagefeaturesiftLayer) -> ImagefeaturesiftLayer {
  let result = image_feature_sift_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_sift_layer_fill(s : ImagefeaturesiftLayer, v : Double) -> ImagefeaturesiftLayer {
  let result = image_feature_sift_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_layer_min(s : ImagefeaturesiftLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_layer_max(s : ImagefeaturesiftLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_layer_to_string(s : ImagefeaturesiftLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_buffer_make(size : Int) -> ImagefeaturesiftBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_buffer_len(s : ImagefeaturesiftBuffer) -> Int { s.size }

pub fn image_feature_sift_buffer_get(s : ImagefeaturesiftBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_buffer_set(s : ImagefeaturesiftBuffer, i : Int, v : Double) -> ImagefeaturesiftBuffer {
  let result = image_feature_sift_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_buffer_sum(s : ImagefeaturesiftBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_sift_buffer_mean(s : ImagefeaturesiftBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_sift_buffer_sum(s) / s.size.to_double() }
}

pub fn image_feature_sift_buffer_scale(s : ImagefeaturesiftBuffer, f : Double) -> ImagefeaturesiftBuffer {
  let result = image_feature_sift_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_sift_buffer_add(a : ImagefeaturesiftBuffer, b : ImagefeaturesiftBuffer) -> ImagefeaturesiftBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_sift_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_sift_buffer_copy(s : ImagefeaturesiftBuffer) -> ImagefeaturesiftBuffer {
  let result = image_feature_sift_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_sift_buffer_fill(s : ImagefeaturesiftBuffer, v : Double) -> ImagefeaturesiftBuffer {
  let result = image_feature_sift_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_buffer_min(s : ImagefeaturesiftBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_buffer_max(s : ImagefeaturesiftBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_buffer_to_string(s : ImagefeaturesiftBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_cursor_make(size : Int) -> ImagefeaturesiftCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_cursor_len(s : ImagefeaturesiftCursor) -> Int { s.size }

pub fn image_feature_sift_cursor_get(s : ImagefeaturesiftCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_cursor_set(s : ImagefeaturesiftCursor, i : Int, v : Double) -> ImagefeaturesiftCursor {
  let result = image_feature_sift_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_cursor_sum(s : ImagefeaturesiftCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_sift_cursor_mean(s : ImagefeaturesiftCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_sift_cursor_sum(s) / s.size.to_double() }
}

pub fn image_feature_sift_cursor_scale(s : ImagefeaturesiftCursor, f : Double) -> ImagefeaturesiftCursor {
  let result = image_feature_sift_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_sift_cursor_add(a : ImagefeaturesiftCursor, b : ImagefeaturesiftCursor) -> ImagefeaturesiftCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_sift_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_sift_cursor_copy(s : ImagefeaturesiftCursor) -> ImagefeaturesiftCursor {
  let result = image_feature_sift_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_sift_cursor_fill(s : ImagefeaturesiftCursor, v : Double) -> ImagefeaturesiftCursor {
  let result = image_feature_sift_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_cursor_min(s : ImagefeaturesiftCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_cursor_max(s : ImagefeaturesiftCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_cursor_to_string(s : ImagefeaturesiftCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_view_make(size : Int) -> ImagefeaturesiftView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_view_len(s : ImagefeaturesiftView) -> Int { s.size }

pub fn image_feature_sift_view_get(s : ImagefeaturesiftView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_view_set(s : ImagefeaturesiftView, i : Int, v : Double) -> ImagefeaturesiftView {
  let result = image_feature_sift_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_view_sum(s : ImagefeaturesiftView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_sift_view_mean(s : ImagefeaturesiftView) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_sift_view_sum(s) / s.size.to_double() }
}

pub fn image_feature_sift_view_scale(s : ImagefeaturesiftView, f : Double) -> ImagefeaturesiftView {
  let result = image_feature_sift_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_sift_view_add(a : ImagefeaturesiftView, b : ImagefeaturesiftView) -> ImagefeaturesiftView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_sift_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_sift_view_copy(s : ImagefeaturesiftView) -> ImagefeaturesiftView {
  let result = image_feature_sift_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_sift_view_fill(s : ImagefeaturesiftView, v : Double) -> ImagefeaturesiftView {
  let result = image_feature_sift_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_view_min(s : ImagefeaturesiftView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_view_max(s : ImagefeaturesiftView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_view_to_string(s : ImagefeaturesiftView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_range_make(size : Int) -> ImagefeaturesiftRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_range_len(s : ImagefeaturesiftRange) -> Int { s.size }

pub fn image_feature_sift_range_get(s : ImagefeaturesiftRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_range_set(s : ImagefeaturesiftRange, i : Int, v : Double) -> ImagefeaturesiftRange {
  let result = image_feature_sift_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_range_sum(s : ImagefeaturesiftRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_sift_range_mean(s : ImagefeaturesiftRange) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_sift_range_sum(s) / s.size.to_double() }
}

pub fn image_feature_sift_range_scale(s : ImagefeaturesiftRange, f : Double) -> ImagefeaturesiftRange {
  let result = image_feature_sift_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_sift_range_add(a : ImagefeaturesiftRange, b : ImagefeaturesiftRange) -> ImagefeaturesiftRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_sift_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_sift_range_copy(s : ImagefeaturesiftRange) -> ImagefeaturesiftRange {
  let result = image_feature_sift_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_sift_range_fill(s : ImagefeaturesiftRange, v : Double) -> ImagefeaturesiftRange {
  let result = image_feature_sift_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_range_min(s : ImagefeaturesiftRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_range_max(s : ImagefeaturesiftRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_range_to_string(s : ImagefeaturesiftRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesiftSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_sift_slice_make(size : Int) -> ImagefeaturesiftSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_sift_slice_len(s : ImagefeaturesiftSlice) -> Int { s.size }

pub fn image_feature_sift_slice_get(s : ImagefeaturesiftSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_sift_slice_set(s : ImagefeaturesiftSlice, i : Int, v : Double) -> ImagefeaturesiftSlice {
  let result = image_feature_sift_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_slice_sum(s : ImagefeaturesiftSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_sift_slice_mean(s : ImagefeaturesiftSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_sift_slice_sum(s) / s.size.to_double() }
}

pub fn image_feature_sift_slice_scale(s : ImagefeaturesiftSlice, f : Double) -> ImagefeaturesiftSlice {
  let result = image_feature_sift_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_sift_slice_add(a : ImagefeaturesiftSlice, b : ImagefeaturesiftSlice) -> ImagefeaturesiftSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_sift_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_sift_slice_copy(s : ImagefeaturesiftSlice) -> ImagefeaturesiftSlice {
  let result = image_feature_sift_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_sift_slice_fill(s : ImagefeaturesiftSlice, v : Double) -> ImagefeaturesiftSlice {
  let result = image_feature_sift_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_sift_slice_min(s : ImagefeaturesiftSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_slice_max(s : ImagefeaturesiftSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_sift_slice_to_string(s : ImagefeaturesiftSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

