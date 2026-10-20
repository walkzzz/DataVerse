///===
/// extcore/image_feature_fast

pub(all) struct ImagefeaturefastPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_fast_make_point(x : Double, y : Double) -> ImagefeaturefastPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_fast_make_point3(x : Double, y : Double, z : Double) -> ImagefeaturefastPoint {
  { x, y, z, label: 0 }
}

pub fn image_feature_fast_point_x(pt : ImagefeaturefastPoint) -> Double { pt.x }

pub fn image_feature_fast_point_y(pt : ImagefeaturefastPoint) -> Double { pt.y }

pub fn image_feature_fast_point_z(pt : ImagefeaturefastPoint) -> Double { pt.z }

pub fn image_feature_fast_point_label(pt : ImagefeaturefastPoint) -> Int { pt.label }

pub fn image_feature_fast_point_dist(a : ImagefeaturefastPoint, b : ImagefeaturefastPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_feature_fast_point_add(a : ImagefeaturefastPoint, b : ImagefeaturefastPoint) -> ImagefeaturefastPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_feature_fast_point_sub(a : ImagefeaturefastPoint, b : ImagefeaturefastPoint) -> ImagefeaturefastPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_feature_fast_point_scale(pt : ImagefeaturefastPoint, s : Double) -> ImagefeaturefastPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_feature_fast_point_dot(a : ImagefeaturefastPoint, b : ImagefeaturefastPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_feature_fast_point_cross(a : ImagefeaturefastPoint, b : ImagefeaturefastPoint) -> ImagefeaturefastPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_feature_fast_point_norm(pt : ImagefeaturefastPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_feature_fast_point_normalize(pt : ImagefeaturefastPoint) -> ImagefeaturefastPoint {
  let n = image_feature_fast_point_norm(pt)
  if n < 0.0000001 { pt } else { image_feature_fast_point_scale(pt, 1.0 / n) }
}

pub fn image_feature_fast_point_negate(pt : ImagefeaturefastPoint) -> ImagefeaturefastPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_feature_fast_point_mid(a : ImagefeaturefastPoint, b : ImagefeaturefastPoint) -> ImagefeaturefastPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_feature_fast_point_lerp(a : ImagefeaturefastPoint, b : ImagefeaturefastPoint, t : Double) -> ImagefeaturefastPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_feature_fast_point_to_string(pt : ImagefeaturefastPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefeaturefastSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_fast_make_series(vals : Array[Double], name : String) -> ImagefeaturefastSeries {
  { vals, name, meta: 0 }
}

pub fn image_feature_fast_series_len(s : ImagefeaturefastSeries) -> Int { s.vals.length() }

pub fn image_feature_fast_series_sum(s : ImagefeaturefastSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_feature_fast_series_mean(s : ImagefeaturefastSeries) -> Double { @_common.mean(s.vals) }

pub fn image_feature_fast_series_min(s : ImagefeaturefastSeries) -> Double { @_common.min(s.vals) }

pub fn image_feature_fast_series_max(s : ImagefeaturefastSeries) -> Double { @_common.max(s.vals) }

pub fn image_feature_fast_series_range(s : ImagefeaturefastSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_feature_fast_series_var(s : ImagefeaturefastSeries) -> Double { @_common.variance(s.vals) }

pub fn image_feature_fast_series_std(s : ImagefeaturefastSeries) -> Double { @_common.std(s.vals) }

pub fn image_feature_fast_series_median(s : ImagefeaturefastSeries) -> Double { @_common.median(s.vals) }

pub fn image_feature_fast_series_scale(s : ImagefeaturefastSeries, f : Double) -> ImagefeaturefastSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_feature_fast_series_add(a : ImagefeaturefastSeries, b : ImagefeaturefastSeries) -> ImagefeaturefastSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_feature_fast_series_sub(a : ImagefeaturefastSeries, b : ImagefeaturefastSeries) -> ImagefeaturefastSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_feature_fast_series_normalize(s : ImagefeaturefastSeries) -> ImagefeaturefastSeries {
  let mn = image_feature_fast_series_min(s)
  let mx = image_feature_fast_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_feature_fast_series_cumsum(s : ImagefeaturefastSeries) -> ImagefeaturefastSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_feature_fast_series_to_string(s : ImagefeaturefastSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturefastMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_fast_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeaturefastMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_fast_matrix_identity(n : Int) -> ImagefeaturefastMatrix {
  let m = image_feature_fast_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_feature_fast_matrix_get(m : ImagefeaturefastMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_feature_fast_matrix_transpose(m : ImagefeaturefastMatrix) -> ImagefeaturefastMatrix {
  let result = image_feature_fast_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_feature_fast_matrix_add(a : ImagefeaturefastMatrix, b : ImagefeaturefastMatrix) -> ImagefeaturefastMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_feature_fast_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_feature_fast_matrix_scale(m : ImagefeaturefastMatrix, s : Double) -> ImagefeaturefastMatrix {
  let result = image_feature_fast_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_feature_fast_matrix_multiply(a : ImagefeaturefastMatrix, b : ImagefeaturefastMatrix) -> ImagefeaturefastMatrix {
  if a.cols != b.rows { return image_feature_fast_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_feature_fast_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_feature_fast_matrix_trace(m : ImagefeaturefastMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_feature_fast_matrix_det(m : ImagefeaturefastMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_feature_fast_matrix_norm(m : ImagefeaturefastMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_feature_fast_matrix_to_string(m : ImagefeaturefastMatrix) -> String {
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

pub(all) struct ImagefeaturefastVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_fast_make_vector(comps : Array[Double]) -> ImagefeaturefastVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_fast_vector_zero(dim : Int) -> ImagefeaturefastVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_feature_fast_vector_add(a : ImagefeaturefastVector, b : ImagefeaturefastVector) -> ImagefeaturefastVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_fast_vector_sub(a : ImagefeaturefastVector, b : ImagefeaturefastVector) -> ImagefeaturefastVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_fast_vector_scale(v : ImagefeaturefastVector, s : Double) -> ImagefeaturefastVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_feature_fast_vector_dot(a : ImagefeaturefastVector, b : ImagefeaturefastVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_feature_fast_vector_norm(v : ImagefeaturefastVector) -> Double { @_common.sqrt(image_feature_fast_vector_dot(v, v)) }

pub fn image_feature_fast_vector_normalize(v : ImagefeaturefastVector) -> ImagefeaturefastVector {
  let n = image_feature_fast_vector_norm(v)
  if n < 0.0000001 { v } else { image_feature_fast_vector_scale(v, 1.0 / n) }
}

pub fn image_feature_fast_vector_dist(a : ImagefeaturefastVector, b : ImagefeaturefastVector) -> Double {
  image_feature_fast_vector_norm(image_feature_fast_vector_sub(a, b))
}

pub fn image_feature_fast_vector_to_string(v : ImagefeaturefastVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_fast_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_feature_fast_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_feature_fast_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_feature_fast_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_feature_fast_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_feature_fast_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_feature_fast_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_feature_fast_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_feature_fast_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_feature_fast_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_feature_fast_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_feature_fast_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_feature_fast_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_feature_fast_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_feature_fast_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_feature_fast_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_feature_fast_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_feature_fast_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_feature_fast_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_feature_fast_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_feature_fast_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_feature_fast_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_feature_fast_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_feature_fast_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_feature_fast_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_feature_fast_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_feature_fast_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_feature_fast_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_feature_fast_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefeaturefastFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_frame_make(size : Int) -> ImagefeaturefastFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_frame_len(s : ImagefeaturefastFrame) -> Int { s.size }

pub fn image_feature_fast_frame_get(s : ImagefeaturefastFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_frame_set(s : ImagefeaturefastFrame, i : Int, v : Double) -> ImagefeaturefastFrame {
  let result = image_feature_fast_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_frame_sum(s : ImagefeaturefastFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_fast_frame_mean(s : ImagefeaturefastFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_fast_frame_sum(s) / s.size.to_double() }
}

pub fn image_feature_fast_frame_scale(s : ImagefeaturefastFrame, f : Double) -> ImagefeaturefastFrame {
  let result = image_feature_fast_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_fast_frame_add(a : ImagefeaturefastFrame, b : ImagefeaturefastFrame) -> ImagefeaturefastFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_fast_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_fast_frame_copy(s : ImagefeaturefastFrame) -> ImagefeaturefastFrame {
  let result = image_feature_fast_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_fast_frame_fill(s : ImagefeaturefastFrame, v : Double) -> ImagefeaturefastFrame {
  let result = image_feature_fast_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_frame_min(s : ImagefeaturefastFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_frame_max(s : ImagefeaturefastFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_frame_to_string(s : ImagefeaturefastFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_table_make(size : Int) -> ImagefeaturefastTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_table_len(s : ImagefeaturefastTable) -> Int { s.size }

pub fn image_feature_fast_table_get(s : ImagefeaturefastTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_table_set(s : ImagefeaturefastTable, i : Int, v : Double) -> ImagefeaturefastTable {
  let result = image_feature_fast_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_table_sum(s : ImagefeaturefastTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_fast_table_mean(s : ImagefeaturefastTable) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_fast_table_sum(s) / s.size.to_double() }
}

pub fn image_feature_fast_table_scale(s : ImagefeaturefastTable, f : Double) -> ImagefeaturefastTable {
  let result = image_feature_fast_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_fast_table_add(a : ImagefeaturefastTable, b : ImagefeaturefastTable) -> ImagefeaturefastTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_fast_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_fast_table_copy(s : ImagefeaturefastTable) -> ImagefeaturefastTable {
  let result = image_feature_fast_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_fast_table_fill(s : ImagefeaturefastTable, v : Double) -> ImagefeaturefastTable {
  let result = image_feature_fast_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_table_min(s : ImagefeaturefastTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_table_max(s : ImagefeaturefastTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_table_to_string(s : ImagefeaturefastTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_graphn_make(size : Int) -> ImagefeaturefastGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_graphn_len(s : ImagefeaturefastGraphN) -> Int { s.size }

pub fn image_feature_fast_graphn_get(s : ImagefeaturefastGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_graphn_set(s : ImagefeaturefastGraphN, i : Int, v : Double) -> ImagefeaturefastGraphN {
  let result = image_feature_fast_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_graphn_sum(s : ImagefeaturefastGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_fast_graphn_mean(s : ImagefeaturefastGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_fast_graphn_sum(s) / s.size.to_double() }
}

pub fn image_feature_fast_graphn_scale(s : ImagefeaturefastGraphN, f : Double) -> ImagefeaturefastGraphN {
  let result = image_feature_fast_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_fast_graphn_add(a : ImagefeaturefastGraphN, b : ImagefeaturefastGraphN) -> ImagefeaturefastGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_fast_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_fast_graphn_copy(s : ImagefeaturefastGraphN) -> ImagefeaturefastGraphN {
  let result = image_feature_fast_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_fast_graphn_fill(s : ImagefeaturefastGraphN, v : Double) -> ImagefeaturefastGraphN {
  let result = image_feature_fast_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_graphn_min(s : ImagefeaturefastGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_graphn_max(s : ImagefeaturefastGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_graphn_to_string(s : ImagefeaturefastGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_node_make(size : Int) -> ImagefeaturefastNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_node_len(s : ImagefeaturefastNode) -> Int { s.size }

pub fn image_feature_fast_node_get(s : ImagefeaturefastNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_node_set(s : ImagefeaturefastNode, i : Int, v : Double) -> ImagefeaturefastNode {
  let result = image_feature_fast_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_node_sum(s : ImagefeaturefastNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_fast_node_mean(s : ImagefeaturefastNode) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_fast_node_sum(s) / s.size.to_double() }
}

pub fn image_feature_fast_node_scale(s : ImagefeaturefastNode, f : Double) -> ImagefeaturefastNode {
  let result = image_feature_fast_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_fast_node_add(a : ImagefeaturefastNode, b : ImagefeaturefastNode) -> ImagefeaturefastNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_fast_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_fast_node_copy(s : ImagefeaturefastNode) -> ImagefeaturefastNode {
  let result = image_feature_fast_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_fast_node_fill(s : ImagefeaturefastNode, v : Double) -> ImagefeaturefastNode {
  let result = image_feature_fast_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_node_min(s : ImagefeaturefastNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_node_max(s : ImagefeaturefastNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_node_to_string(s : ImagefeaturefastNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_edge_make(size : Int) -> ImagefeaturefastEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_edge_len(s : ImagefeaturefastEdge) -> Int { s.size }

pub fn image_feature_fast_edge_get(s : ImagefeaturefastEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_edge_set(s : ImagefeaturefastEdge, i : Int, v : Double) -> ImagefeaturefastEdge {
  let result = image_feature_fast_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_edge_sum(s : ImagefeaturefastEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_fast_edge_mean(s : ImagefeaturefastEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_fast_edge_sum(s) / s.size.to_double() }
}

pub fn image_feature_fast_edge_scale(s : ImagefeaturefastEdge, f : Double) -> ImagefeaturefastEdge {
  let result = image_feature_fast_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_fast_edge_add(a : ImagefeaturefastEdge, b : ImagefeaturefastEdge) -> ImagefeaturefastEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_fast_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_fast_edge_copy(s : ImagefeaturefastEdge) -> ImagefeaturefastEdge {
  let result = image_feature_fast_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_fast_edge_fill(s : ImagefeaturefastEdge, v : Double) -> ImagefeaturefastEdge {
  let result = image_feature_fast_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_edge_min(s : ImagefeaturefastEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_edge_max(s : ImagefeaturefastEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_edge_to_string(s : ImagefeaturefastEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_path_make(size : Int) -> ImagefeaturefastPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_path_len(s : ImagefeaturefastPath) -> Int { s.size }

pub fn image_feature_fast_path_get(s : ImagefeaturefastPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_path_set(s : ImagefeaturefastPath, i : Int, v : Double) -> ImagefeaturefastPath {
  let result = image_feature_fast_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_path_sum(s : ImagefeaturefastPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_fast_path_mean(s : ImagefeaturefastPath) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_fast_path_sum(s) / s.size.to_double() }
}

pub fn image_feature_fast_path_scale(s : ImagefeaturefastPath, f : Double) -> ImagefeaturefastPath {
  let result = image_feature_fast_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_fast_path_add(a : ImagefeaturefastPath, b : ImagefeaturefastPath) -> ImagefeaturefastPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_fast_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_fast_path_copy(s : ImagefeaturefastPath) -> ImagefeaturefastPath {
  let result = image_feature_fast_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_fast_path_fill(s : ImagefeaturefastPath, v : Double) -> ImagefeaturefastPath {
  let result = image_feature_fast_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_path_min(s : ImagefeaturefastPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_path_max(s : ImagefeaturefastPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_path_to_string(s : ImagefeaturefastPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_cluster_make(size : Int) -> ImagefeaturefastCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_cluster_len(s : ImagefeaturefastCluster) -> Int { s.size }

pub fn image_feature_fast_cluster_get(s : ImagefeaturefastCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_cluster_set(s : ImagefeaturefastCluster, i : Int, v : Double) -> ImagefeaturefastCluster {
  let result = image_feature_fast_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_cluster_sum(s : ImagefeaturefastCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_fast_cluster_mean(s : ImagefeaturefastCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_fast_cluster_sum(s) / s.size.to_double() }
}

pub fn image_feature_fast_cluster_scale(s : ImagefeaturefastCluster, f : Double) -> ImagefeaturefastCluster {
  let result = image_feature_fast_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_fast_cluster_add(a : ImagefeaturefastCluster, b : ImagefeaturefastCluster) -> ImagefeaturefastCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_fast_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_fast_cluster_copy(s : ImagefeaturefastCluster) -> ImagefeaturefastCluster {
  let result = image_feature_fast_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_fast_cluster_fill(s : ImagefeaturefastCluster, v : Double) -> ImagefeaturefastCluster {
  let result = image_feature_fast_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_cluster_min(s : ImagefeaturefastCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_cluster_max(s : ImagefeaturefastCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_cluster_to_string(s : ImagefeaturefastCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_model_make(size : Int) -> ImagefeaturefastModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_model_len(s : ImagefeaturefastModel) -> Int { s.size }

pub fn image_feature_fast_model_get(s : ImagefeaturefastModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_model_set(s : ImagefeaturefastModel, i : Int, v : Double) -> ImagefeaturefastModel {
  let result = image_feature_fast_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_model_sum(s : ImagefeaturefastModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_fast_model_mean(s : ImagefeaturefastModel) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_fast_model_sum(s) / s.size.to_double() }
}

pub fn image_feature_fast_model_scale(s : ImagefeaturefastModel, f : Double) -> ImagefeaturefastModel {
  let result = image_feature_fast_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_fast_model_add(a : ImagefeaturefastModel, b : ImagefeaturefastModel) -> ImagefeaturefastModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_fast_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_fast_model_copy(s : ImagefeaturefastModel) -> ImagefeaturefastModel {
  let result = image_feature_fast_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_fast_model_fill(s : ImagefeaturefastModel, v : Double) -> ImagefeaturefastModel {
  let result = image_feature_fast_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_model_min(s : ImagefeaturefastModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_model_max(s : ImagefeaturefastModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_model_to_string(s : ImagefeaturefastModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_layer_make(size : Int) -> ImagefeaturefastLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_layer_len(s : ImagefeaturefastLayer) -> Int { s.size }

pub fn image_feature_fast_layer_get(s : ImagefeaturefastLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_layer_set(s : ImagefeaturefastLayer, i : Int, v : Double) -> ImagefeaturefastLayer {
  let result = image_feature_fast_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_layer_sum(s : ImagefeaturefastLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_fast_layer_mean(s : ImagefeaturefastLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_fast_layer_sum(s) / s.size.to_double() }
}

pub fn image_feature_fast_layer_scale(s : ImagefeaturefastLayer, f : Double) -> ImagefeaturefastLayer {
  let result = image_feature_fast_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_fast_layer_add(a : ImagefeaturefastLayer, b : ImagefeaturefastLayer) -> ImagefeaturefastLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_fast_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_fast_layer_copy(s : ImagefeaturefastLayer) -> ImagefeaturefastLayer {
  let result = image_feature_fast_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_fast_layer_fill(s : ImagefeaturefastLayer, v : Double) -> ImagefeaturefastLayer {
  let result = image_feature_fast_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_layer_min(s : ImagefeaturefastLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_layer_max(s : ImagefeaturefastLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_layer_to_string(s : ImagefeaturefastLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_buffer_make(size : Int) -> ImagefeaturefastBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_buffer_len(s : ImagefeaturefastBuffer) -> Int { s.size }

pub fn image_feature_fast_buffer_get(s : ImagefeaturefastBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_buffer_set(s : ImagefeaturefastBuffer, i : Int, v : Double) -> ImagefeaturefastBuffer {
  let result = image_feature_fast_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_buffer_sum(s : ImagefeaturefastBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_fast_buffer_mean(s : ImagefeaturefastBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_fast_buffer_sum(s) / s.size.to_double() }
}

pub fn image_feature_fast_buffer_scale(s : ImagefeaturefastBuffer, f : Double) -> ImagefeaturefastBuffer {
  let result = image_feature_fast_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_fast_buffer_add(a : ImagefeaturefastBuffer, b : ImagefeaturefastBuffer) -> ImagefeaturefastBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_fast_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_fast_buffer_copy(s : ImagefeaturefastBuffer) -> ImagefeaturefastBuffer {
  let result = image_feature_fast_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_fast_buffer_fill(s : ImagefeaturefastBuffer, v : Double) -> ImagefeaturefastBuffer {
  let result = image_feature_fast_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_buffer_min(s : ImagefeaturefastBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_buffer_max(s : ImagefeaturefastBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_buffer_to_string(s : ImagefeaturefastBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_cursor_make(size : Int) -> ImagefeaturefastCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_cursor_len(s : ImagefeaturefastCursor) -> Int { s.size }

pub fn image_feature_fast_cursor_get(s : ImagefeaturefastCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_cursor_set(s : ImagefeaturefastCursor, i : Int, v : Double) -> ImagefeaturefastCursor {
  let result = image_feature_fast_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_cursor_sum(s : ImagefeaturefastCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_fast_cursor_mean(s : ImagefeaturefastCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_fast_cursor_sum(s) / s.size.to_double() }
}

pub fn image_feature_fast_cursor_scale(s : ImagefeaturefastCursor, f : Double) -> ImagefeaturefastCursor {
  let result = image_feature_fast_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_fast_cursor_add(a : ImagefeaturefastCursor, b : ImagefeaturefastCursor) -> ImagefeaturefastCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_fast_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_fast_cursor_copy(s : ImagefeaturefastCursor) -> ImagefeaturefastCursor {
  let result = image_feature_fast_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_fast_cursor_fill(s : ImagefeaturefastCursor, v : Double) -> ImagefeaturefastCursor {
  let result = image_feature_fast_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_cursor_min(s : ImagefeaturefastCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_cursor_max(s : ImagefeaturefastCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_cursor_to_string(s : ImagefeaturefastCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_view_make(size : Int) -> ImagefeaturefastView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_view_len(s : ImagefeaturefastView) -> Int { s.size }

pub fn image_feature_fast_view_get(s : ImagefeaturefastView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_view_set(s : ImagefeaturefastView, i : Int, v : Double) -> ImagefeaturefastView {
  let result = image_feature_fast_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_view_sum(s : ImagefeaturefastView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_fast_view_mean(s : ImagefeaturefastView) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_fast_view_sum(s) / s.size.to_double() }
}

pub fn image_feature_fast_view_scale(s : ImagefeaturefastView, f : Double) -> ImagefeaturefastView {
  let result = image_feature_fast_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_fast_view_add(a : ImagefeaturefastView, b : ImagefeaturefastView) -> ImagefeaturefastView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_fast_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_fast_view_copy(s : ImagefeaturefastView) -> ImagefeaturefastView {
  let result = image_feature_fast_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_fast_view_fill(s : ImagefeaturefastView, v : Double) -> ImagefeaturefastView {
  let result = image_feature_fast_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_view_min(s : ImagefeaturefastView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_view_max(s : ImagefeaturefastView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_view_to_string(s : ImagefeaturefastView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_range_make(size : Int) -> ImagefeaturefastRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_range_len(s : ImagefeaturefastRange) -> Int { s.size }

pub fn image_feature_fast_range_get(s : ImagefeaturefastRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_range_set(s : ImagefeaturefastRange, i : Int, v : Double) -> ImagefeaturefastRange {
  let result = image_feature_fast_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_range_sum(s : ImagefeaturefastRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_fast_range_mean(s : ImagefeaturefastRange) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_fast_range_sum(s) / s.size.to_double() }
}

pub fn image_feature_fast_range_scale(s : ImagefeaturefastRange, f : Double) -> ImagefeaturefastRange {
  let result = image_feature_fast_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_fast_range_add(a : ImagefeaturefastRange, b : ImagefeaturefastRange) -> ImagefeaturefastRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_fast_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_fast_range_copy(s : ImagefeaturefastRange) -> ImagefeaturefastRange {
  let result = image_feature_fast_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_fast_range_fill(s : ImagefeaturefastRange, v : Double) -> ImagefeaturefastRange {
  let result = image_feature_fast_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_range_min(s : ImagefeaturefastRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_range_max(s : ImagefeaturefastRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_range_to_string(s : ImagefeaturefastRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturefastSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_fast_slice_make(size : Int) -> ImagefeaturefastSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_fast_slice_len(s : ImagefeaturefastSlice) -> Int { s.size }

pub fn image_feature_fast_slice_get(s : ImagefeaturefastSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_fast_slice_set(s : ImagefeaturefastSlice, i : Int, v : Double) -> ImagefeaturefastSlice {
  let result = image_feature_fast_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_slice_sum(s : ImagefeaturefastSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_fast_slice_mean(s : ImagefeaturefastSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_fast_slice_sum(s) / s.size.to_double() }
}

pub fn image_feature_fast_slice_scale(s : ImagefeaturefastSlice, f : Double) -> ImagefeaturefastSlice {
  let result = image_feature_fast_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_fast_slice_add(a : ImagefeaturefastSlice, b : ImagefeaturefastSlice) -> ImagefeaturefastSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_fast_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_fast_slice_copy(s : ImagefeaturefastSlice) -> ImagefeaturefastSlice {
  let result = image_feature_fast_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_fast_slice_fill(s : ImagefeaturefastSlice, v : Double) -> ImagefeaturefastSlice {
  let result = image_feature_fast_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_fast_slice_min(s : ImagefeaturefastSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_slice_max(s : ImagefeaturefastSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_fast_slice_to_string(s : ImagefeaturefastSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

