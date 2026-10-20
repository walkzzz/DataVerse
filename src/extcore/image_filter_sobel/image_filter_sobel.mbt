///===
/// extcore/image_filter_sobel

pub(all) struct ImagefiltersobelPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_sobel_make_point(x : Double, y : Double) -> ImagefiltersobelPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_sobel_make_point3(x : Double, y : Double, z : Double) -> ImagefiltersobelPoint {
  { x, y, z, label: 0 }
}

pub fn image_filter_sobel_point_x(pt : ImagefiltersobelPoint) -> Double { pt.x }

pub fn image_filter_sobel_point_y(pt : ImagefiltersobelPoint) -> Double { pt.y }

pub fn image_filter_sobel_point_z(pt : ImagefiltersobelPoint) -> Double { pt.z }

pub fn image_filter_sobel_point_label(pt : ImagefiltersobelPoint) -> Int { pt.label }

pub fn image_filter_sobel_point_dist(a : ImagefiltersobelPoint, b : ImagefiltersobelPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_filter_sobel_point_add(a : ImagefiltersobelPoint, b : ImagefiltersobelPoint) -> ImagefiltersobelPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_filter_sobel_point_sub(a : ImagefiltersobelPoint, b : ImagefiltersobelPoint) -> ImagefiltersobelPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_filter_sobel_point_scale(pt : ImagefiltersobelPoint, s : Double) -> ImagefiltersobelPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_filter_sobel_point_dot(a : ImagefiltersobelPoint, b : ImagefiltersobelPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_filter_sobel_point_cross(a : ImagefiltersobelPoint, b : ImagefiltersobelPoint) -> ImagefiltersobelPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_filter_sobel_point_norm(pt : ImagefiltersobelPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_filter_sobel_point_normalize(pt : ImagefiltersobelPoint) -> ImagefiltersobelPoint {
  let n = image_filter_sobel_point_norm(pt)
  if n < 0.0000001 { pt } else { image_filter_sobel_point_scale(pt, 1.0 / n) }
}

pub fn image_filter_sobel_point_negate(pt : ImagefiltersobelPoint) -> ImagefiltersobelPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_filter_sobel_point_mid(a : ImagefiltersobelPoint, b : ImagefiltersobelPoint) -> ImagefiltersobelPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_filter_sobel_point_lerp(a : ImagefiltersobelPoint, b : ImagefiltersobelPoint, t : Double) -> ImagefiltersobelPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_filter_sobel_point_to_string(pt : ImagefiltersobelPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefiltersobelSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_sobel_make_series(vals : Array[Double], name : String) -> ImagefiltersobelSeries {
  { vals, name, meta: 0 }
}

pub fn image_filter_sobel_series_len(s : ImagefiltersobelSeries) -> Int { s.vals.length() }

pub fn image_filter_sobel_series_sum(s : ImagefiltersobelSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_filter_sobel_series_mean(s : ImagefiltersobelSeries) -> Double { @_common.mean(s.vals) }

pub fn image_filter_sobel_series_min(s : ImagefiltersobelSeries) -> Double { @_common.min(s.vals) }

pub fn image_filter_sobel_series_max(s : ImagefiltersobelSeries) -> Double { @_common.max(s.vals) }

pub fn image_filter_sobel_series_range(s : ImagefiltersobelSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_filter_sobel_series_var(s : ImagefiltersobelSeries) -> Double { @_common.variance(s.vals) }

pub fn image_filter_sobel_series_std(s : ImagefiltersobelSeries) -> Double { @_common.std(s.vals) }

pub fn image_filter_sobel_series_median(s : ImagefiltersobelSeries) -> Double { @_common.median(s.vals) }

pub fn image_filter_sobel_series_scale(s : ImagefiltersobelSeries, f : Double) -> ImagefiltersobelSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_filter_sobel_series_add(a : ImagefiltersobelSeries, b : ImagefiltersobelSeries) -> ImagefiltersobelSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_filter_sobel_series_sub(a : ImagefiltersobelSeries, b : ImagefiltersobelSeries) -> ImagefiltersobelSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_filter_sobel_series_normalize(s : ImagefiltersobelSeries) -> ImagefiltersobelSeries {
  let mn = image_filter_sobel_series_min(s)
  let mx = image_filter_sobel_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_filter_sobel_series_cumsum(s : ImagefiltersobelSeries) -> ImagefiltersobelSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_filter_sobel_series_to_string(s : ImagefiltersobelSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefiltersobelMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_sobel_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefiltersobelMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_sobel_matrix_identity(n : Int) -> ImagefiltersobelMatrix {
  let m = image_filter_sobel_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_filter_sobel_matrix_get(m : ImagefiltersobelMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_filter_sobel_matrix_transpose(m : ImagefiltersobelMatrix) -> ImagefiltersobelMatrix {
  let result = image_filter_sobel_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_filter_sobel_matrix_add(a : ImagefiltersobelMatrix, b : ImagefiltersobelMatrix) -> ImagefiltersobelMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_filter_sobel_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_filter_sobel_matrix_scale(m : ImagefiltersobelMatrix, s : Double) -> ImagefiltersobelMatrix {
  let result = image_filter_sobel_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_filter_sobel_matrix_multiply(a : ImagefiltersobelMatrix, b : ImagefiltersobelMatrix) -> ImagefiltersobelMatrix {
  if a.cols != b.rows { return image_filter_sobel_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_filter_sobel_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_filter_sobel_matrix_trace(m : ImagefiltersobelMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_filter_sobel_matrix_det(m : ImagefiltersobelMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_filter_sobel_matrix_norm(m : ImagefiltersobelMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_filter_sobel_matrix_to_string(m : ImagefiltersobelMatrix) -> String {
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

pub(all) struct ImagefiltersobelVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_sobel_make_vector(comps : Array[Double]) -> ImagefiltersobelVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_sobel_vector_zero(dim : Int) -> ImagefiltersobelVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_filter_sobel_vector_add(a : ImagefiltersobelVector, b : ImagefiltersobelVector) -> ImagefiltersobelVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_sobel_vector_sub(a : ImagefiltersobelVector, b : ImagefiltersobelVector) -> ImagefiltersobelVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_sobel_vector_scale(v : ImagefiltersobelVector, s : Double) -> ImagefiltersobelVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_filter_sobel_vector_dot(a : ImagefiltersobelVector, b : ImagefiltersobelVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_filter_sobel_vector_norm(v : ImagefiltersobelVector) -> Double { @_common.sqrt(image_filter_sobel_vector_dot(v, v)) }

pub fn image_filter_sobel_vector_normalize(v : ImagefiltersobelVector) -> ImagefiltersobelVector {
  let n = image_filter_sobel_vector_norm(v)
  if n < 0.0000001 { v } else { image_filter_sobel_vector_scale(v, 1.0 / n) }
}

pub fn image_filter_sobel_vector_dist(a : ImagefiltersobelVector, b : ImagefiltersobelVector) -> Double {
  image_filter_sobel_vector_norm(image_filter_sobel_vector_sub(a, b))
}

pub fn image_filter_sobel_vector_to_string(v : ImagefiltersobelVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_sobel_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_filter_sobel_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_filter_sobel_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_filter_sobel_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_filter_sobel_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_filter_sobel_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_filter_sobel_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_filter_sobel_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_filter_sobel_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_filter_sobel_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_filter_sobel_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_filter_sobel_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_filter_sobel_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_filter_sobel_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_filter_sobel_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_filter_sobel_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_filter_sobel_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_filter_sobel_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_filter_sobel_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_filter_sobel_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_filter_sobel_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_filter_sobel_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_filter_sobel_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_filter_sobel_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_filter_sobel_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_filter_sobel_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_filter_sobel_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_filter_sobel_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_filter_sobel_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefiltersobelFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_frame_make(size : Int) -> ImagefiltersobelFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_frame_len(s : ImagefiltersobelFrame) -> Int { s.size }

pub fn image_filter_sobel_frame_get(s : ImagefiltersobelFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_frame_set(s : ImagefiltersobelFrame, i : Int, v : Double) -> ImagefiltersobelFrame {
  let result = image_filter_sobel_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_frame_sum(s : ImagefiltersobelFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_sobel_frame_mean(s : ImagefiltersobelFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_sobel_frame_sum(s) / s.size.to_double() }
}

pub fn image_filter_sobel_frame_scale(s : ImagefiltersobelFrame, f : Double) -> ImagefiltersobelFrame {
  let result = image_filter_sobel_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_sobel_frame_add(a : ImagefiltersobelFrame, b : ImagefiltersobelFrame) -> ImagefiltersobelFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_sobel_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_sobel_frame_copy(s : ImagefiltersobelFrame) -> ImagefiltersobelFrame {
  let result = image_filter_sobel_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_sobel_frame_fill(s : ImagefiltersobelFrame, v : Double) -> ImagefiltersobelFrame {
  let result = image_filter_sobel_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_frame_min(s : ImagefiltersobelFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_frame_max(s : ImagefiltersobelFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_frame_to_string(s : ImagefiltersobelFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_table_make(size : Int) -> ImagefiltersobelTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_table_len(s : ImagefiltersobelTable) -> Int { s.size }

pub fn image_filter_sobel_table_get(s : ImagefiltersobelTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_table_set(s : ImagefiltersobelTable, i : Int, v : Double) -> ImagefiltersobelTable {
  let result = image_filter_sobel_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_table_sum(s : ImagefiltersobelTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_sobel_table_mean(s : ImagefiltersobelTable) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_sobel_table_sum(s) / s.size.to_double() }
}

pub fn image_filter_sobel_table_scale(s : ImagefiltersobelTable, f : Double) -> ImagefiltersobelTable {
  let result = image_filter_sobel_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_sobel_table_add(a : ImagefiltersobelTable, b : ImagefiltersobelTable) -> ImagefiltersobelTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_sobel_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_sobel_table_copy(s : ImagefiltersobelTable) -> ImagefiltersobelTable {
  let result = image_filter_sobel_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_sobel_table_fill(s : ImagefiltersobelTable, v : Double) -> ImagefiltersobelTable {
  let result = image_filter_sobel_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_table_min(s : ImagefiltersobelTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_table_max(s : ImagefiltersobelTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_table_to_string(s : ImagefiltersobelTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_graphn_make(size : Int) -> ImagefiltersobelGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_graphn_len(s : ImagefiltersobelGraphN) -> Int { s.size }

pub fn image_filter_sobel_graphn_get(s : ImagefiltersobelGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_graphn_set(s : ImagefiltersobelGraphN, i : Int, v : Double) -> ImagefiltersobelGraphN {
  let result = image_filter_sobel_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_graphn_sum(s : ImagefiltersobelGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_sobel_graphn_mean(s : ImagefiltersobelGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_sobel_graphn_sum(s) / s.size.to_double() }
}

pub fn image_filter_sobel_graphn_scale(s : ImagefiltersobelGraphN, f : Double) -> ImagefiltersobelGraphN {
  let result = image_filter_sobel_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_sobel_graphn_add(a : ImagefiltersobelGraphN, b : ImagefiltersobelGraphN) -> ImagefiltersobelGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_sobel_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_sobel_graphn_copy(s : ImagefiltersobelGraphN) -> ImagefiltersobelGraphN {
  let result = image_filter_sobel_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_sobel_graphn_fill(s : ImagefiltersobelGraphN, v : Double) -> ImagefiltersobelGraphN {
  let result = image_filter_sobel_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_graphn_min(s : ImagefiltersobelGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_graphn_max(s : ImagefiltersobelGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_graphn_to_string(s : ImagefiltersobelGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_node_make(size : Int) -> ImagefiltersobelNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_node_len(s : ImagefiltersobelNode) -> Int { s.size }

pub fn image_filter_sobel_node_get(s : ImagefiltersobelNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_node_set(s : ImagefiltersobelNode, i : Int, v : Double) -> ImagefiltersobelNode {
  let result = image_filter_sobel_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_node_sum(s : ImagefiltersobelNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_sobel_node_mean(s : ImagefiltersobelNode) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_sobel_node_sum(s) / s.size.to_double() }
}

pub fn image_filter_sobel_node_scale(s : ImagefiltersobelNode, f : Double) -> ImagefiltersobelNode {
  let result = image_filter_sobel_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_sobel_node_add(a : ImagefiltersobelNode, b : ImagefiltersobelNode) -> ImagefiltersobelNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_sobel_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_sobel_node_copy(s : ImagefiltersobelNode) -> ImagefiltersobelNode {
  let result = image_filter_sobel_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_sobel_node_fill(s : ImagefiltersobelNode, v : Double) -> ImagefiltersobelNode {
  let result = image_filter_sobel_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_node_min(s : ImagefiltersobelNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_node_max(s : ImagefiltersobelNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_node_to_string(s : ImagefiltersobelNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_edge_make(size : Int) -> ImagefiltersobelEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_edge_len(s : ImagefiltersobelEdge) -> Int { s.size }

pub fn image_filter_sobel_edge_get(s : ImagefiltersobelEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_edge_set(s : ImagefiltersobelEdge, i : Int, v : Double) -> ImagefiltersobelEdge {
  let result = image_filter_sobel_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_edge_sum(s : ImagefiltersobelEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_sobel_edge_mean(s : ImagefiltersobelEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_sobel_edge_sum(s) / s.size.to_double() }
}

pub fn image_filter_sobel_edge_scale(s : ImagefiltersobelEdge, f : Double) -> ImagefiltersobelEdge {
  let result = image_filter_sobel_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_sobel_edge_add(a : ImagefiltersobelEdge, b : ImagefiltersobelEdge) -> ImagefiltersobelEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_sobel_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_sobel_edge_copy(s : ImagefiltersobelEdge) -> ImagefiltersobelEdge {
  let result = image_filter_sobel_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_sobel_edge_fill(s : ImagefiltersobelEdge, v : Double) -> ImagefiltersobelEdge {
  let result = image_filter_sobel_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_edge_min(s : ImagefiltersobelEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_edge_max(s : ImagefiltersobelEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_edge_to_string(s : ImagefiltersobelEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_path_make(size : Int) -> ImagefiltersobelPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_path_len(s : ImagefiltersobelPath) -> Int { s.size }

pub fn image_filter_sobel_path_get(s : ImagefiltersobelPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_path_set(s : ImagefiltersobelPath, i : Int, v : Double) -> ImagefiltersobelPath {
  let result = image_filter_sobel_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_path_sum(s : ImagefiltersobelPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_sobel_path_mean(s : ImagefiltersobelPath) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_sobel_path_sum(s) / s.size.to_double() }
}

pub fn image_filter_sobel_path_scale(s : ImagefiltersobelPath, f : Double) -> ImagefiltersobelPath {
  let result = image_filter_sobel_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_sobel_path_add(a : ImagefiltersobelPath, b : ImagefiltersobelPath) -> ImagefiltersobelPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_sobel_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_sobel_path_copy(s : ImagefiltersobelPath) -> ImagefiltersobelPath {
  let result = image_filter_sobel_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_sobel_path_fill(s : ImagefiltersobelPath, v : Double) -> ImagefiltersobelPath {
  let result = image_filter_sobel_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_path_min(s : ImagefiltersobelPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_path_max(s : ImagefiltersobelPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_path_to_string(s : ImagefiltersobelPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_cluster_make(size : Int) -> ImagefiltersobelCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_cluster_len(s : ImagefiltersobelCluster) -> Int { s.size }

pub fn image_filter_sobel_cluster_get(s : ImagefiltersobelCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_cluster_set(s : ImagefiltersobelCluster, i : Int, v : Double) -> ImagefiltersobelCluster {
  let result = image_filter_sobel_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_cluster_sum(s : ImagefiltersobelCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_sobel_cluster_mean(s : ImagefiltersobelCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_sobel_cluster_sum(s) / s.size.to_double() }
}

pub fn image_filter_sobel_cluster_scale(s : ImagefiltersobelCluster, f : Double) -> ImagefiltersobelCluster {
  let result = image_filter_sobel_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_sobel_cluster_add(a : ImagefiltersobelCluster, b : ImagefiltersobelCluster) -> ImagefiltersobelCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_sobel_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_sobel_cluster_copy(s : ImagefiltersobelCluster) -> ImagefiltersobelCluster {
  let result = image_filter_sobel_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_sobel_cluster_fill(s : ImagefiltersobelCluster, v : Double) -> ImagefiltersobelCluster {
  let result = image_filter_sobel_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_cluster_min(s : ImagefiltersobelCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_cluster_max(s : ImagefiltersobelCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_cluster_to_string(s : ImagefiltersobelCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_model_make(size : Int) -> ImagefiltersobelModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_model_len(s : ImagefiltersobelModel) -> Int { s.size }

pub fn image_filter_sobel_model_get(s : ImagefiltersobelModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_model_set(s : ImagefiltersobelModel, i : Int, v : Double) -> ImagefiltersobelModel {
  let result = image_filter_sobel_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_model_sum(s : ImagefiltersobelModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_sobel_model_mean(s : ImagefiltersobelModel) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_sobel_model_sum(s) / s.size.to_double() }
}

pub fn image_filter_sobel_model_scale(s : ImagefiltersobelModel, f : Double) -> ImagefiltersobelModel {
  let result = image_filter_sobel_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_sobel_model_add(a : ImagefiltersobelModel, b : ImagefiltersobelModel) -> ImagefiltersobelModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_sobel_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_sobel_model_copy(s : ImagefiltersobelModel) -> ImagefiltersobelModel {
  let result = image_filter_sobel_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_sobel_model_fill(s : ImagefiltersobelModel, v : Double) -> ImagefiltersobelModel {
  let result = image_filter_sobel_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_model_min(s : ImagefiltersobelModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_model_max(s : ImagefiltersobelModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_model_to_string(s : ImagefiltersobelModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_layer_make(size : Int) -> ImagefiltersobelLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_layer_len(s : ImagefiltersobelLayer) -> Int { s.size }

pub fn image_filter_sobel_layer_get(s : ImagefiltersobelLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_layer_set(s : ImagefiltersobelLayer, i : Int, v : Double) -> ImagefiltersobelLayer {
  let result = image_filter_sobel_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_layer_sum(s : ImagefiltersobelLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_sobel_layer_mean(s : ImagefiltersobelLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_sobel_layer_sum(s) / s.size.to_double() }
}

pub fn image_filter_sobel_layer_scale(s : ImagefiltersobelLayer, f : Double) -> ImagefiltersobelLayer {
  let result = image_filter_sobel_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_sobel_layer_add(a : ImagefiltersobelLayer, b : ImagefiltersobelLayer) -> ImagefiltersobelLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_sobel_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_sobel_layer_copy(s : ImagefiltersobelLayer) -> ImagefiltersobelLayer {
  let result = image_filter_sobel_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_sobel_layer_fill(s : ImagefiltersobelLayer, v : Double) -> ImagefiltersobelLayer {
  let result = image_filter_sobel_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_layer_min(s : ImagefiltersobelLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_layer_max(s : ImagefiltersobelLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_layer_to_string(s : ImagefiltersobelLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_buffer_make(size : Int) -> ImagefiltersobelBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_buffer_len(s : ImagefiltersobelBuffer) -> Int { s.size }

pub fn image_filter_sobel_buffer_get(s : ImagefiltersobelBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_buffer_set(s : ImagefiltersobelBuffer, i : Int, v : Double) -> ImagefiltersobelBuffer {
  let result = image_filter_sobel_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_buffer_sum(s : ImagefiltersobelBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_sobel_buffer_mean(s : ImagefiltersobelBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_sobel_buffer_sum(s) / s.size.to_double() }
}

pub fn image_filter_sobel_buffer_scale(s : ImagefiltersobelBuffer, f : Double) -> ImagefiltersobelBuffer {
  let result = image_filter_sobel_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_sobel_buffer_add(a : ImagefiltersobelBuffer, b : ImagefiltersobelBuffer) -> ImagefiltersobelBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_sobel_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_sobel_buffer_copy(s : ImagefiltersobelBuffer) -> ImagefiltersobelBuffer {
  let result = image_filter_sobel_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_sobel_buffer_fill(s : ImagefiltersobelBuffer, v : Double) -> ImagefiltersobelBuffer {
  let result = image_filter_sobel_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_buffer_min(s : ImagefiltersobelBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_buffer_max(s : ImagefiltersobelBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_buffer_to_string(s : ImagefiltersobelBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_cursor_make(size : Int) -> ImagefiltersobelCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_cursor_len(s : ImagefiltersobelCursor) -> Int { s.size }

pub fn image_filter_sobel_cursor_get(s : ImagefiltersobelCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_cursor_set(s : ImagefiltersobelCursor, i : Int, v : Double) -> ImagefiltersobelCursor {
  let result = image_filter_sobel_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_cursor_sum(s : ImagefiltersobelCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_sobel_cursor_mean(s : ImagefiltersobelCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_sobel_cursor_sum(s) / s.size.to_double() }
}

pub fn image_filter_sobel_cursor_scale(s : ImagefiltersobelCursor, f : Double) -> ImagefiltersobelCursor {
  let result = image_filter_sobel_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_sobel_cursor_add(a : ImagefiltersobelCursor, b : ImagefiltersobelCursor) -> ImagefiltersobelCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_sobel_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_sobel_cursor_copy(s : ImagefiltersobelCursor) -> ImagefiltersobelCursor {
  let result = image_filter_sobel_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_sobel_cursor_fill(s : ImagefiltersobelCursor, v : Double) -> ImagefiltersobelCursor {
  let result = image_filter_sobel_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_cursor_min(s : ImagefiltersobelCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_cursor_max(s : ImagefiltersobelCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_cursor_to_string(s : ImagefiltersobelCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_view_make(size : Int) -> ImagefiltersobelView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_view_len(s : ImagefiltersobelView) -> Int { s.size }

pub fn image_filter_sobel_view_get(s : ImagefiltersobelView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_view_set(s : ImagefiltersobelView, i : Int, v : Double) -> ImagefiltersobelView {
  let result = image_filter_sobel_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_view_sum(s : ImagefiltersobelView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_sobel_view_mean(s : ImagefiltersobelView) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_sobel_view_sum(s) / s.size.to_double() }
}

pub fn image_filter_sobel_view_scale(s : ImagefiltersobelView, f : Double) -> ImagefiltersobelView {
  let result = image_filter_sobel_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_sobel_view_add(a : ImagefiltersobelView, b : ImagefiltersobelView) -> ImagefiltersobelView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_sobel_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_sobel_view_copy(s : ImagefiltersobelView) -> ImagefiltersobelView {
  let result = image_filter_sobel_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_sobel_view_fill(s : ImagefiltersobelView, v : Double) -> ImagefiltersobelView {
  let result = image_filter_sobel_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_view_min(s : ImagefiltersobelView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_view_max(s : ImagefiltersobelView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_view_to_string(s : ImagefiltersobelView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_range_make(size : Int) -> ImagefiltersobelRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_range_len(s : ImagefiltersobelRange) -> Int { s.size }

pub fn image_filter_sobel_range_get(s : ImagefiltersobelRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_range_set(s : ImagefiltersobelRange, i : Int, v : Double) -> ImagefiltersobelRange {
  let result = image_filter_sobel_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_range_sum(s : ImagefiltersobelRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_sobel_range_mean(s : ImagefiltersobelRange) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_sobel_range_sum(s) / s.size.to_double() }
}

pub fn image_filter_sobel_range_scale(s : ImagefiltersobelRange, f : Double) -> ImagefiltersobelRange {
  let result = image_filter_sobel_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_sobel_range_add(a : ImagefiltersobelRange, b : ImagefiltersobelRange) -> ImagefiltersobelRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_sobel_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_sobel_range_copy(s : ImagefiltersobelRange) -> ImagefiltersobelRange {
  let result = image_filter_sobel_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_sobel_range_fill(s : ImagefiltersobelRange, v : Double) -> ImagefiltersobelRange {
  let result = image_filter_sobel_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_range_min(s : ImagefiltersobelRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_range_max(s : ImagefiltersobelRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_range_to_string(s : ImagefiltersobelRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltersobelSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_sobel_slice_make(size : Int) -> ImagefiltersobelSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_sobel_slice_len(s : ImagefiltersobelSlice) -> Int { s.size }

pub fn image_filter_sobel_slice_get(s : ImagefiltersobelSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_sobel_slice_set(s : ImagefiltersobelSlice, i : Int, v : Double) -> ImagefiltersobelSlice {
  let result = image_filter_sobel_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_slice_sum(s : ImagefiltersobelSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_sobel_slice_mean(s : ImagefiltersobelSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_sobel_slice_sum(s) / s.size.to_double() }
}

pub fn image_filter_sobel_slice_scale(s : ImagefiltersobelSlice, f : Double) -> ImagefiltersobelSlice {
  let result = image_filter_sobel_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_sobel_slice_add(a : ImagefiltersobelSlice, b : ImagefiltersobelSlice) -> ImagefiltersobelSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_sobel_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_sobel_slice_copy(s : ImagefiltersobelSlice) -> ImagefiltersobelSlice {
  let result = image_filter_sobel_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_sobel_slice_fill(s : ImagefiltersobelSlice, v : Double) -> ImagefiltersobelSlice {
  let result = image_filter_sobel_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_sobel_slice_min(s : ImagefiltersobelSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_slice_max(s : ImagefiltersobelSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_sobel_slice_to_string(s : ImagefiltersobelSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

