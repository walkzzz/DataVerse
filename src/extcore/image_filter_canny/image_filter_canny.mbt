///===
/// extcore/image_filter_canny

pub(all) struct ImagefiltercannyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_canny_make_point(x : Double, y : Double) -> ImagefiltercannyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_canny_make_point3(x : Double, y : Double, z : Double) -> ImagefiltercannyPoint {
  { x, y, z, label: 0 }
}

pub fn image_filter_canny_point_x(pt : ImagefiltercannyPoint) -> Double { pt.x }

pub fn image_filter_canny_point_y(pt : ImagefiltercannyPoint) -> Double { pt.y }

pub fn image_filter_canny_point_z(pt : ImagefiltercannyPoint) -> Double { pt.z }

pub fn image_filter_canny_point_label(pt : ImagefiltercannyPoint) -> Int { pt.label }

pub fn image_filter_canny_point_dist(a : ImagefiltercannyPoint, b : ImagefiltercannyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_filter_canny_point_add(a : ImagefiltercannyPoint, b : ImagefiltercannyPoint) -> ImagefiltercannyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_filter_canny_point_sub(a : ImagefiltercannyPoint, b : ImagefiltercannyPoint) -> ImagefiltercannyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_filter_canny_point_scale(pt : ImagefiltercannyPoint, s : Double) -> ImagefiltercannyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_filter_canny_point_dot(a : ImagefiltercannyPoint, b : ImagefiltercannyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_filter_canny_point_cross(a : ImagefiltercannyPoint, b : ImagefiltercannyPoint) -> ImagefiltercannyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_filter_canny_point_norm(pt : ImagefiltercannyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_filter_canny_point_normalize(pt : ImagefiltercannyPoint) -> ImagefiltercannyPoint {
  let n = image_filter_canny_point_norm(pt)
  if n < 0.0000001 { pt } else { image_filter_canny_point_scale(pt, 1.0 / n) }
}

pub fn image_filter_canny_point_negate(pt : ImagefiltercannyPoint) -> ImagefiltercannyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_filter_canny_point_mid(a : ImagefiltercannyPoint, b : ImagefiltercannyPoint) -> ImagefiltercannyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_filter_canny_point_lerp(a : ImagefiltercannyPoint, b : ImagefiltercannyPoint, t : Double) -> ImagefiltercannyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_filter_canny_point_to_string(pt : ImagefiltercannyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefiltercannySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_canny_make_series(vals : Array[Double], name : String) -> ImagefiltercannySeries {
  { vals, name, meta: 0 }
}

pub fn image_filter_canny_series_len(s : ImagefiltercannySeries) -> Int { s.vals.length() }

pub fn image_filter_canny_series_sum(s : ImagefiltercannySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_filter_canny_series_mean(s : ImagefiltercannySeries) -> Double { @_common.mean(s.vals) }

pub fn image_filter_canny_series_min(s : ImagefiltercannySeries) -> Double { @_common.min(s.vals) }

pub fn image_filter_canny_series_max(s : ImagefiltercannySeries) -> Double { @_common.max(s.vals) }

pub fn image_filter_canny_series_range(s : ImagefiltercannySeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_filter_canny_series_var(s : ImagefiltercannySeries) -> Double { @_common.variance(s.vals) }

pub fn image_filter_canny_series_std(s : ImagefiltercannySeries) -> Double { @_common.std(s.vals) }

pub fn image_filter_canny_series_median(s : ImagefiltercannySeries) -> Double { @_common.median(s.vals) }

pub fn image_filter_canny_series_scale(s : ImagefiltercannySeries, f : Double) -> ImagefiltercannySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_filter_canny_series_add(a : ImagefiltercannySeries, b : ImagefiltercannySeries) -> ImagefiltercannySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_filter_canny_series_sub(a : ImagefiltercannySeries, b : ImagefiltercannySeries) -> ImagefiltercannySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_filter_canny_series_normalize(s : ImagefiltercannySeries) -> ImagefiltercannySeries {
  let mn = image_filter_canny_series_min(s)
  let mx = image_filter_canny_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_filter_canny_series_cumsum(s : ImagefiltercannySeries) -> ImagefiltercannySeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_filter_canny_series_to_string(s : ImagefiltercannySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefiltercannyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_canny_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefiltercannyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_canny_matrix_identity(n : Int) -> ImagefiltercannyMatrix {
  let m = image_filter_canny_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_filter_canny_matrix_get(m : ImagefiltercannyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_filter_canny_matrix_transpose(m : ImagefiltercannyMatrix) -> ImagefiltercannyMatrix {
  let result = image_filter_canny_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_filter_canny_matrix_add(a : ImagefiltercannyMatrix, b : ImagefiltercannyMatrix) -> ImagefiltercannyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_filter_canny_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_filter_canny_matrix_scale(m : ImagefiltercannyMatrix, s : Double) -> ImagefiltercannyMatrix {
  let result = image_filter_canny_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_filter_canny_matrix_multiply(a : ImagefiltercannyMatrix, b : ImagefiltercannyMatrix) -> ImagefiltercannyMatrix {
  if a.cols != b.rows { return image_filter_canny_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_filter_canny_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_filter_canny_matrix_trace(m : ImagefiltercannyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_filter_canny_matrix_det(m : ImagefiltercannyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_filter_canny_matrix_norm(m : ImagefiltercannyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_filter_canny_matrix_to_string(m : ImagefiltercannyMatrix) -> String {
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

pub(all) struct ImagefiltercannyVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_canny_make_vector(comps : Array[Double]) -> ImagefiltercannyVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_canny_vector_zero(dim : Int) -> ImagefiltercannyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_filter_canny_vector_add(a : ImagefiltercannyVector, b : ImagefiltercannyVector) -> ImagefiltercannyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_canny_vector_sub(a : ImagefiltercannyVector, b : ImagefiltercannyVector) -> ImagefiltercannyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_canny_vector_scale(v : ImagefiltercannyVector, s : Double) -> ImagefiltercannyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_filter_canny_vector_dot(a : ImagefiltercannyVector, b : ImagefiltercannyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_filter_canny_vector_norm(v : ImagefiltercannyVector) -> Double { @_common.sqrt(image_filter_canny_vector_dot(v, v)) }

pub fn image_filter_canny_vector_normalize(v : ImagefiltercannyVector) -> ImagefiltercannyVector {
  let n = image_filter_canny_vector_norm(v)
  if n < 0.0000001 { v } else { image_filter_canny_vector_scale(v, 1.0 / n) }
}

pub fn image_filter_canny_vector_dist(a : ImagefiltercannyVector, b : ImagefiltercannyVector) -> Double {
  image_filter_canny_vector_norm(image_filter_canny_vector_sub(a, b))
}

pub fn image_filter_canny_vector_to_string(v : ImagefiltercannyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_canny_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_filter_canny_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_filter_canny_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_filter_canny_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_filter_canny_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_filter_canny_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_filter_canny_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_filter_canny_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_filter_canny_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_filter_canny_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_filter_canny_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_filter_canny_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_filter_canny_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_filter_canny_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_filter_canny_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_filter_canny_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_filter_canny_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_filter_canny_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_filter_canny_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_filter_canny_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_filter_canny_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_filter_canny_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_filter_canny_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_filter_canny_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_filter_canny_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_filter_canny_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_filter_canny_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_filter_canny_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_filter_canny_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefiltercannyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_frame_make(size : Int) -> ImagefiltercannyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_frame_len(s : ImagefiltercannyFrame) -> Int { s.size }

pub fn image_filter_canny_frame_get(s : ImagefiltercannyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_frame_set(s : ImagefiltercannyFrame, i : Int, v : Double) -> ImagefiltercannyFrame {
  let result = image_filter_canny_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_frame_sum(s : ImagefiltercannyFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_canny_frame_mean(s : ImagefiltercannyFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_canny_frame_sum(s) / s.size.to_double() }
}

pub fn image_filter_canny_frame_scale(s : ImagefiltercannyFrame, f : Double) -> ImagefiltercannyFrame {
  let result = image_filter_canny_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_canny_frame_add(a : ImagefiltercannyFrame, b : ImagefiltercannyFrame) -> ImagefiltercannyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_canny_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_canny_frame_copy(s : ImagefiltercannyFrame) -> ImagefiltercannyFrame {
  let result = image_filter_canny_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_canny_frame_fill(s : ImagefiltercannyFrame, v : Double) -> ImagefiltercannyFrame {
  let result = image_filter_canny_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_frame_min(s : ImagefiltercannyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_frame_max(s : ImagefiltercannyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_frame_to_string(s : ImagefiltercannyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_table_make(size : Int) -> ImagefiltercannyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_table_len(s : ImagefiltercannyTable) -> Int { s.size }

pub fn image_filter_canny_table_get(s : ImagefiltercannyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_table_set(s : ImagefiltercannyTable, i : Int, v : Double) -> ImagefiltercannyTable {
  let result = image_filter_canny_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_table_sum(s : ImagefiltercannyTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_canny_table_mean(s : ImagefiltercannyTable) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_canny_table_sum(s) / s.size.to_double() }
}

pub fn image_filter_canny_table_scale(s : ImagefiltercannyTable, f : Double) -> ImagefiltercannyTable {
  let result = image_filter_canny_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_canny_table_add(a : ImagefiltercannyTable, b : ImagefiltercannyTable) -> ImagefiltercannyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_canny_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_canny_table_copy(s : ImagefiltercannyTable) -> ImagefiltercannyTable {
  let result = image_filter_canny_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_canny_table_fill(s : ImagefiltercannyTable, v : Double) -> ImagefiltercannyTable {
  let result = image_filter_canny_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_table_min(s : ImagefiltercannyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_table_max(s : ImagefiltercannyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_table_to_string(s : ImagefiltercannyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_graphn_make(size : Int) -> ImagefiltercannyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_graphn_len(s : ImagefiltercannyGraphN) -> Int { s.size }

pub fn image_filter_canny_graphn_get(s : ImagefiltercannyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_graphn_set(s : ImagefiltercannyGraphN, i : Int, v : Double) -> ImagefiltercannyGraphN {
  let result = image_filter_canny_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_graphn_sum(s : ImagefiltercannyGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_canny_graphn_mean(s : ImagefiltercannyGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_canny_graphn_sum(s) / s.size.to_double() }
}

pub fn image_filter_canny_graphn_scale(s : ImagefiltercannyGraphN, f : Double) -> ImagefiltercannyGraphN {
  let result = image_filter_canny_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_canny_graphn_add(a : ImagefiltercannyGraphN, b : ImagefiltercannyGraphN) -> ImagefiltercannyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_canny_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_canny_graphn_copy(s : ImagefiltercannyGraphN) -> ImagefiltercannyGraphN {
  let result = image_filter_canny_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_canny_graphn_fill(s : ImagefiltercannyGraphN, v : Double) -> ImagefiltercannyGraphN {
  let result = image_filter_canny_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_graphn_min(s : ImagefiltercannyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_graphn_max(s : ImagefiltercannyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_graphn_to_string(s : ImagefiltercannyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_node_make(size : Int) -> ImagefiltercannyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_node_len(s : ImagefiltercannyNode) -> Int { s.size }

pub fn image_filter_canny_node_get(s : ImagefiltercannyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_node_set(s : ImagefiltercannyNode, i : Int, v : Double) -> ImagefiltercannyNode {
  let result = image_filter_canny_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_node_sum(s : ImagefiltercannyNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_canny_node_mean(s : ImagefiltercannyNode) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_canny_node_sum(s) / s.size.to_double() }
}

pub fn image_filter_canny_node_scale(s : ImagefiltercannyNode, f : Double) -> ImagefiltercannyNode {
  let result = image_filter_canny_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_canny_node_add(a : ImagefiltercannyNode, b : ImagefiltercannyNode) -> ImagefiltercannyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_canny_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_canny_node_copy(s : ImagefiltercannyNode) -> ImagefiltercannyNode {
  let result = image_filter_canny_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_canny_node_fill(s : ImagefiltercannyNode, v : Double) -> ImagefiltercannyNode {
  let result = image_filter_canny_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_node_min(s : ImagefiltercannyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_node_max(s : ImagefiltercannyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_node_to_string(s : ImagefiltercannyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_edge_make(size : Int) -> ImagefiltercannyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_edge_len(s : ImagefiltercannyEdge) -> Int { s.size }

pub fn image_filter_canny_edge_get(s : ImagefiltercannyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_edge_set(s : ImagefiltercannyEdge, i : Int, v : Double) -> ImagefiltercannyEdge {
  let result = image_filter_canny_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_edge_sum(s : ImagefiltercannyEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_canny_edge_mean(s : ImagefiltercannyEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_canny_edge_sum(s) / s.size.to_double() }
}

pub fn image_filter_canny_edge_scale(s : ImagefiltercannyEdge, f : Double) -> ImagefiltercannyEdge {
  let result = image_filter_canny_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_canny_edge_add(a : ImagefiltercannyEdge, b : ImagefiltercannyEdge) -> ImagefiltercannyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_canny_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_canny_edge_copy(s : ImagefiltercannyEdge) -> ImagefiltercannyEdge {
  let result = image_filter_canny_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_canny_edge_fill(s : ImagefiltercannyEdge, v : Double) -> ImagefiltercannyEdge {
  let result = image_filter_canny_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_edge_min(s : ImagefiltercannyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_edge_max(s : ImagefiltercannyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_edge_to_string(s : ImagefiltercannyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_path_make(size : Int) -> ImagefiltercannyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_path_len(s : ImagefiltercannyPath) -> Int { s.size }

pub fn image_filter_canny_path_get(s : ImagefiltercannyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_path_set(s : ImagefiltercannyPath, i : Int, v : Double) -> ImagefiltercannyPath {
  let result = image_filter_canny_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_path_sum(s : ImagefiltercannyPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_canny_path_mean(s : ImagefiltercannyPath) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_canny_path_sum(s) / s.size.to_double() }
}

pub fn image_filter_canny_path_scale(s : ImagefiltercannyPath, f : Double) -> ImagefiltercannyPath {
  let result = image_filter_canny_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_canny_path_add(a : ImagefiltercannyPath, b : ImagefiltercannyPath) -> ImagefiltercannyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_canny_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_canny_path_copy(s : ImagefiltercannyPath) -> ImagefiltercannyPath {
  let result = image_filter_canny_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_canny_path_fill(s : ImagefiltercannyPath, v : Double) -> ImagefiltercannyPath {
  let result = image_filter_canny_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_path_min(s : ImagefiltercannyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_path_max(s : ImagefiltercannyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_path_to_string(s : ImagefiltercannyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_cluster_make(size : Int) -> ImagefiltercannyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_cluster_len(s : ImagefiltercannyCluster) -> Int { s.size }

pub fn image_filter_canny_cluster_get(s : ImagefiltercannyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_cluster_set(s : ImagefiltercannyCluster, i : Int, v : Double) -> ImagefiltercannyCluster {
  let result = image_filter_canny_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_cluster_sum(s : ImagefiltercannyCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_canny_cluster_mean(s : ImagefiltercannyCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_canny_cluster_sum(s) / s.size.to_double() }
}

pub fn image_filter_canny_cluster_scale(s : ImagefiltercannyCluster, f : Double) -> ImagefiltercannyCluster {
  let result = image_filter_canny_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_canny_cluster_add(a : ImagefiltercannyCluster, b : ImagefiltercannyCluster) -> ImagefiltercannyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_canny_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_canny_cluster_copy(s : ImagefiltercannyCluster) -> ImagefiltercannyCluster {
  let result = image_filter_canny_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_canny_cluster_fill(s : ImagefiltercannyCluster, v : Double) -> ImagefiltercannyCluster {
  let result = image_filter_canny_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_cluster_min(s : ImagefiltercannyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_cluster_max(s : ImagefiltercannyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_cluster_to_string(s : ImagefiltercannyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_model_make(size : Int) -> ImagefiltercannyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_model_len(s : ImagefiltercannyModel) -> Int { s.size }

pub fn image_filter_canny_model_get(s : ImagefiltercannyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_model_set(s : ImagefiltercannyModel, i : Int, v : Double) -> ImagefiltercannyModel {
  let result = image_filter_canny_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_model_sum(s : ImagefiltercannyModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_canny_model_mean(s : ImagefiltercannyModel) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_canny_model_sum(s) / s.size.to_double() }
}

pub fn image_filter_canny_model_scale(s : ImagefiltercannyModel, f : Double) -> ImagefiltercannyModel {
  let result = image_filter_canny_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_canny_model_add(a : ImagefiltercannyModel, b : ImagefiltercannyModel) -> ImagefiltercannyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_canny_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_canny_model_copy(s : ImagefiltercannyModel) -> ImagefiltercannyModel {
  let result = image_filter_canny_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_canny_model_fill(s : ImagefiltercannyModel, v : Double) -> ImagefiltercannyModel {
  let result = image_filter_canny_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_model_min(s : ImagefiltercannyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_model_max(s : ImagefiltercannyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_model_to_string(s : ImagefiltercannyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_layer_make(size : Int) -> ImagefiltercannyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_layer_len(s : ImagefiltercannyLayer) -> Int { s.size }

pub fn image_filter_canny_layer_get(s : ImagefiltercannyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_layer_set(s : ImagefiltercannyLayer, i : Int, v : Double) -> ImagefiltercannyLayer {
  let result = image_filter_canny_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_layer_sum(s : ImagefiltercannyLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_canny_layer_mean(s : ImagefiltercannyLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_canny_layer_sum(s) / s.size.to_double() }
}

pub fn image_filter_canny_layer_scale(s : ImagefiltercannyLayer, f : Double) -> ImagefiltercannyLayer {
  let result = image_filter_canny_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_canny_layer_add(a : ImagefiltercannyLayer, b : ImagefiltercannyLayer) -> ImagefiltercannyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_canny_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_canny_layer_copy(s : ImagefiltercannyLayer) -> ImagefiltercannyLayer {
  let result = image_filter_canny_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_canny_layer_fill(s : ImagefiltercannyLayer, v : Double) -> ImagefiltercannyLayer {
  let result = image_filter_canny_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_layer_min(s : ImagefiltercannyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_layer_max(s : ImagefiltercannyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_layer_to_string(s : ImagefiltercannyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_buffer_make(size : Int) -> ImagefiltercannyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_buffer_len(s : ImagefiltercannyBuffer) -> Int { s.size }

pub fn image_filter_canny_buffer_get(s : ImagefiltercannyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_buffer_set(s : ImagefiltercannyBuffer, i : Int, v : Double) -> ImagefiltercannyBuffer {
  let result = image_filter_canny_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_buffer_sum(s : ImagefiltercannyBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_canny_buffer_mean(s : ImagefiltercannyBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_canny_buffer_sum(s) / s.size.to_double() }
}

pub fn image_filter_canny_buffer_scale(s : ImagefiltercannyBuffer, f : Double) -> ImagefiltercannyBuffer {
  let result = image_filter_canny_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_canny_buffer_add(a : ImagefiltercannyBuffer, b : ImagefiltercannyBuffer) -> ImagefiltercannyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_canny_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_canny_buffer_copy(s : ImagefiltercannyBuffer) -> ImagefiltercannyBuffer {
  let result = image_filter_canny_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_canny_buffer_fill(s : ImagefiltercannyBuffer, v : Double) -> ImagefiltercannyBuffer {
  let result = image_filter_canny_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_buffer_min(s : ImagefiltercannyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_buffer_max(s : ImagefiltercannyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_buffer_to_string(s : ImagefiltercannyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_cursor_make(size : Int) -> ImagefiltercannyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_cursor_len(s : ImagefiltercannyCursor) -> Int { s.size }

pub fn image_filter_canny_cursor_get(s : ImagefiltercannyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_cursor_set(s : ImagefiltercannyCursor, i : Int, v : Double) -> ImagefiltercannyCursor {
  let result = image_filter_canny_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_cursor_sum(s : ImagefiltercannyCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_canny_cursor_mean(s : ImagefiltercannyCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_canny_cursor_sum(s) / s.size.to_double() }
}

pub fn image_filter_canny_cursor_scale(s : ImagefiltercannyCursor, f : Double) -> ImagefiltercannyCursor {
  let result = image_filter_canny_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_canny_cursor_add(a : ImagefiltercannyCursor, b : ImagefiltercannyCursor) -> ImagefiltercannyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_canny_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_canny_cursor_copy(s : ImagefiltercannyCursor) -> ImagefiltercannyCursor {
  let result = image_filter_canny_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_canny_cursor_fill(s : ImagefiltercannyCursor, v : Double) -> ImagefiltercannyCursor {
  let result = image_filter_canny_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_cursor_min(s : ImagefiltercannyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_cursor_max(s : ImagefiltercannyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_cursor_to_string(s : ImagefiltercannyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_view_make(size : Int) -> ImagefiltercannyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_view_len(s : ImagefiltercannyView) -> Int { s.size }

pub fn image_filter_canny_view_get(s : ImagefiltercannyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_view_set(s : ImagefiltercannyView, i : Int, v : Double) -> ImagefiltercannyView {
  let result = image_filter_canny_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_view_sum(s : ImagefiltercannyView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_canny_view_mean(s : ImagefiltercannyView) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_canny_view_sum(s) / s.size.to_double() }
}

pub fn image_filter_canny_view_scale(s : ImagefiltercannyView, f : Double) -> ImagefiltercannyView {
  let result = image_filter_canny_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_canny_view_add(a : ImagefiltercannyView, b : ImagefiltercannyView) -> ImagefiltercannyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_canny_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_canny_view_copy(s : ImagefiltercannyView) -> ImagefiltercannyView {
  let result = image_filter_canny_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_canny_view_fill(s : ImagefiltercannyView, v : Double) -> ImagefiltercannyView {
  let result = image_filter_canny_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_view_min(s : ImagefiltercannyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_view_max(s : ImagefiltercannyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_view_to_string(s : ImagefiltercannyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_range_make(size : Int) -> ImagefiltercannyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_range_len(s : ImagefiltercannyRange) -> Int { s.size }

pub fn image_filter_canny_range_get(s : ImagefiltercannyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_range_set(s : ImagefiltercannyRange, i : Int, v : Double) -> ImagefiltercannyRange {
  let result = image_filter_canny_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_range_sum(s : ImagefiltercannyRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_canny_range_mean(s : ImagefiltercannyRange) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_canny_range_sum(s) / s.size.to_double() }
}

pub fn image_filter_canny_range_scale(s : ImagefiltercannyRange, f : Double) -> ImagefiltercannyRange {
  let result = image_filter_canny_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_canny_range_add(a : ImagefiltercannyRange, b : ImagefiltercannyRange) -> ImagefiltercannyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_canny_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_canny_range_copy(s : ImagefiltercannyRange) -> ImagefiltercannyRange {
  let result = image_filter_canny_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_canny_range_fill(s : ImagefiltercannyRange, v : Double) -> ImagefiltercannyRange {
  let result = image_filter_canny_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_range_min(s : ImagefiltercannyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_range_max(s : ImagefiltercannyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_range_to_string(s : ImagefiltercannyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltercannySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_canny_slice_make(size : Int) -> ImagefiltercannySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_canny_slice_len(s : ImagefiltercannySlice) -> Int { s.size }

pub fn image_filter_canny_slice_get(s : ImagefiltercannySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_canny_slice_set(s : ImagefiltercannySlice, i : Int, v : Double) -> ImagefiltercannySlice {
  let result = image_filter_canny_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_slice_sum(s : ImagefiltercannySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_filter_canny_slice_mean(s : ImagefiltercannySlice) -> Double {
  if s.size == 0 { 0.0 } else { image_filter_canny_slice_sum(s) / s.size.to_double() }
}

pub fn image_filter_canny_slice_scale(s : ImagefiltercannySlice, f : Double) -> ImagefiltercannySlice {
  let result = image_filter_canny_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_filter_canny_slice_add(a : ImagefiltercannySlice, b : ImagefiltercannySlice) -> ImagefiltercannySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_filter_canny_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_filter_canny_slice_copy(s : ImagefiltercannySlice) -> ImagefiltercannySlice {
  let result = image_filter_canny_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_filter_canny_slice_fill(s : ImagefiltercannySlice, v : Double) -> ImagefiltercannySlice {
  let result = image_filter_canny_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_filter_canny_slice_min(s : ImagefiltercannySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_slice_max(s : ImagefiltercannySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_filter_canny_slice_to_string(s : ImagefiltercannySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

