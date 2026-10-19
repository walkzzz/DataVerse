///===
/// extcore/image_transform_shear

pub(all) struct ImagetransformshearPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_shear_make_point(x : Double, y : Double) -> ImagetransformshearPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_shear_make_point3(x : Double, y : Double, z : Double) -> ImagetransformshearPoint {
  { x, y, z, label: 0 }
}

pub fn image_transform_shear_point_x(pt : ImagetransformshearPoint) -> Double { pt.x }

pub fn image_transform_shear_point_y(pt : ImagetransformshearPoint) -> Double { pt.y }

pub fn image_transform_shear_point_z(pt : ImagetransformshearPoint) -> Double { pt.z }

pub fn image_transform_shear_point_label(pt : ImagetransformshearPoint) -> Int { pt.label }

pub fn image_transform_shear_point_dist(a : ImagetransformshearPoint, b : ImagetransformshearPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_transform_shear_point_add(a : ImagetransformshearPoint, b : ImagetransformshearPoint) -> ImagetransformshearPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_transform_shear_point_sub(a : ImagetransformshearPoint, b : ImagetransformshearPoint) -> ImagetransformshearPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_transform_shear_point_scale(pt : ImagetransformshearPoint, s : Double) -> ImagetransformshearPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_transform_shear_point_dot(a : ImagetransformshearPoint, b : ImagetransformshearPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_transform_shear_point_cross(a : ImagetransformshearPoint, b : ImagetransformshearPoint) -> ImagetransformshearPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_transform_shear_point_norm(pt : ImagetransformshearPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_transform_shear_point_normalize(pt : ImagetransformshearPoint) -> ImagetransformshearPoint {
  let n = image_transform_shear_point_norm(pt)
  if n < 0.0000001 { pt } else { image_transform_shear_point_scale(pt, 1.0 / n) }
}

pub fn image_transform_shear_point_negate(pt : ImagetransformshearPoint) -> ImagetransformshearPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_transform_shear_point_mid(a : ImagetransformshearPoint, b : ImagetransformshearPoint) -> ImagetransformshearPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_transform_shear_point_lerp(a : ImagetransformshearPoint, b : ImagetransformshearPoint, t : Double) -> ImagetransformshearPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_transform_shear_point_to_string(pt : ImagetransformshearPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagetransformshearSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_shear_make_series(vals : Array[Double], name : String) -> ImagetransformshearSeries {
  { vals, name, meta: 0 }
}

pub fn image_transform_shear_series_len(s : ImagetransformshearSeries) -> Int { s.vals.length() }

pub fn image_transform_shear_series_sum(s : ImagetransformshearSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_transform_shear_series_mean(s : ImagetransformshearSeries) -> Double {
  let n = image_transform_shear_series_len(s)
  if n == 0 { 0.0 } else { image_transform_shear_series_sum(s) / n.to_double() }
}

pub fn image_transform_shear_series_min(s : ImagetransformshearSeries) -> Double {
  let n = image_transform_shear_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_transform_shear_series_max(s : ImagetransformshearSeries) -> Double {
  let n = image_transform_shear_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_transform_shear_series_range(s : ImagetransformshearSeries) -> Double {
  image_transform_shear_series_max(s) - image_transform_shear_series_min(s)
}

pub fn image_transform_shear_series_var(s : ImagetransformshearSeries) -> Double {
  let n = image_transform_shear_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_transform_shear_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_transform_shear_series_std(s : ImagetransformshearSeries) -> Double { @_common.sqrt(image_transform_shear_series_var(s)) }

pub fn image_transform_shear_series_median(s : ImagetransformshearSeries) -> Double {
  let n = image_transform_shear_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_transform_shear_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_transform_shear_series_scale(s : ImagetransformshearSeries, f : Double) -> ImagetransformshearSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_transform_shear_series_add(a : ImagetransformshearSeries, b : ImagetransformshearSeries) -> ImagetransformshearSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_transform_shear_series_sub(a : ImagetransformshearSeries, b : ImagetransformshearSeries) -> ImagetransformshearSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_transform_shear_series_normalize(s : ImagetransformshearSeries) -> ImagetransformshearSeries {
  let mn = image_transform_shear_series_min(s)
  let mx = image_transform_shear_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_transform_shear_series_cumsum(s : ImagetransformshearSeries) -> ImagetransformshearSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_transform_shear_series_to_string(s : ImagetransformshearSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformshearMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_shear_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformshearMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_shear_matrix_identity(n : Int) -> ImagetransformshearMatrix {
  let m = image_transform_shear_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_transform_shear_matrix_get(m : ImagetransformshearMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_transform_shear_matrix_transpose(m : ImagetransformshearMatrix) -> ImagetransformshearMatrix {
  let result = image_transform_shear_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_transform_shear_matrix_add(a : ImagetransformshearMatrix, b : ImagetransformshearMatrix) -> ImagetransformshearMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_transform_shear_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_transform_shear_matrix_scale(m : ImagetransformshearMatrix, s : Double) -> ImagetransformshearMatrix {
  let result = image_transform_shear_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_transform_shear_matrix_multiply(a : ImagetransformshearMatrix, b : ImagetransformshearMatrix) -> ImagetransformshearMatrix {
  if a.cols != b.rows { return image_transform_shear_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_transform_shear_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_transform_shear_matrix_trace(m : ImagetransformshearMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_transform_shear_matrix_det(m : ImagetransformshearMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_transform_shear_matrix_norm(m : ImagetransformshearMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_transform_shear_matrix_to_string(m : ImagetransformshearMatrix) -> String {
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

pub(all) struct ImagetransformshearVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_shear_make_vector(comps : Array[Double]) -> ImagetransformshearVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_shear_vector_zero(dim : Int) -> ImagetransformshearVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_transform_shear_vector_add(a : ImagetransformshearVector, b : ImagetransformshearVector) -> ImagetransformshearVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_shear_vector_sub(a : ImagetransformshearVector, b : ImagetransformshearVector) -> ImagetransformshearVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_shear_vector_scale(v : ImagetransformshearVector, s : Double) -> ImagetransformshearVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_transform_shear_vector_dot(a : ImagetransformshearVector, b : ImagetransformshearVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_transform_shear_vector_norm(v : ImagetransformshearVector) -> Double { @_common.sqrt(image_transform_shear_vector_dot(v, v)) }

pub fn image_transform_shear_vector_normalize(v : ImagetransformshearVector) -> ImagetransformshearVector {
  let n = image_transform_shear_vector_norm(v)
  if n < 0.0000001 { v } else { image_transform_shear_vector_scale(v, 1.0 / n) }
}

pub fn image_transform_shear_vector_dist(a : ImagetransformshearVector, b : ImagetransformshearVector) -> Double {
  image_transform_shear_vector_norm(image_transform_shear_vector_sub(a, b))
}

pub fn image_transform_shear_vector_to_string(v : ImagetransformshearVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_shear_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_shear_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_shear_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_shear_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_shear_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_shear_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_shear_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_shear_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_shear_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_shear_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_shear_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_shear_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_shear_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_shear_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_shear_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_shear_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_shear_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_shear_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_shear_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_shear_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_shear_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_shear_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_shear_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_shear_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_shear_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_shear_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_shear_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_shear_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_shear_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformshearFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_frame_make(size : Int) -> ImagetransformshearFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_frame_len(s : ImagetransformshearFrame) -> Int { s.size }

pub fn image_transform_shear_frame_get(s : ImagetransformshearFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_frame_set(s : ImagetransformshearFrame, i : Int, v : Double) -> ImagetransformshearFrame {
  let result = image_transform_shear_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_frame_sum(s : ImagetransformshearFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_shear_frame_mean(s : ImagetransformshearFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_shear_frame_sum(s) / s.size.to_double() }
}

pub fn image_transform_shear_frame_scale(s : ImagetransformshearFrame, f : Double) -> ImagetransformshearFrame {
  let result = image_transform_shear_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_shear_frame_add(a : ImagetransformshearFrame, b : ImagetransformshearFrame) -> ImagetransformshearFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_shear_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_shear_frame_copy(s : ImagetransformshearFrame) -> ImagetransformshearFrame {
  let result = image_transform_shear_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_shear_frame_fill(s : ImagetransformshearFrame, v : Double) -> ImagetransformshearFrame {
  let result = image_transform_shear_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_frame_min(s : ImagetransformshearFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_frame_max(s : ImagetransformshearFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_frame_to_string(s : ImagetransformshearFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_table_make(size : Int) -> ImagetransformshearTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_table_len(s : ImagetransformshearTable) -> Int { s.size }

pub fn image_transform_shear_table_get(s : ImagetransformshearTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_table_set(s : ImagetransformshearTable, i : Int, v : Double) -> ImagetransformshearTable {
  let result = image_transform_shear_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_table_sum(s : ImagetransformshearTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_shear_table_mean(s : ImagetransformshearTable) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_shear_table_sum(s) / s.size.to_double() }
}

pub fn image_transform_shear_table_scale(s : ImagetransformshearTable, f : Double) -> ImagetransformshearTable {
  let result = image_transform_shear_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_shear_table_add(a : ImagetransformshearTable, b : ImagetransformshearTable) -> ImagetransformshearTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_shear_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_shear_table_copy(s : ImagetransformshearTable) -> ImagetransformshearTable {
  let result = image_transform_shear_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_shear_table_fill(s : ImagetransformshearTable, v : Double) -> ImagetransformshearTable {
  let result = image_transform_shear_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_table_min(s : ImagetransformshearTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_table_max(s : ImagetransformshearTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_table_to_string(s : ImagetransformshearTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_graphn_make(size : Int) -> ImagetransformshearGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_graphn_len(s : ImagetransformshearGraphN) -> Int { s.size }

pub fn image_transform_shear_graphn_get(s : ImagetransformshearGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_graphn_set(s : ImagetransformshearGraphN, i : Int, v : Double) -> ImagetransformshearGraphN {
  let result = image_transform_shear_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_graphn_sum(s : ImagetransformshearGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_shear_graphn_mean(s : ImagetransformshearGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_shear_graphn_sum(s) / s.size.to_double() }
}

pub fn image_transform_shear_graphn_scale(s : ImagetransformshearGraphN, f : Double) -> ImagetransformshearGraphN {
  let result = image_transform_shear_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_shear_graphn_add(a : ImagetransformshearGraphN, b : ImagetransformshearGraphN) -> ImagetransformshearGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_shear_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_shear_graphn_copy(s : ImagetransformshearGraphN) -> ImagetransformshearGraphN {
  let result = image_transform_shear_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_shear_graphn_fill(s : ImagetransformshearGraphN, v : Double) -> ImagetransformshearGraphN {
  let result = image_transform_shear_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_graphn_min(s : ImagetransformshearGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_graphn_max(s : ImagetransformshearGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_graphn_to_string(s : ImagetransformshearGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_node_make(size : Int) -> ImagetransformshearNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_node_len(s : ImagetransformshearNode) -> Int { s.size }

pub fn image_transform_shear_node_get(s : ImagetransformshearNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_node_set(s : ImagetransformshearNode, i : Int, v : Double) -> ImagetransformshearNode {
  let result = image_transform_shear_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_node_sum(s : ImagetransformshearNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_shear_node_mean(s : ImagetransformshearNode) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_shear_node_sum(s) / s.size.to_double() }
}

pub fn image_transform_shear_node_scale(s : ImagetransformshearNode, f : Double) -> ImagetransformshearNode {
  let result = image_transform_shear_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_shear_node_add(a : ImagetransformshearNode, b : ImagetransformshearNode) -> ImagetransformshearNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_shear_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_shear_node_copy(s : ImagetransformshearNode) -> ImagetransformshearNode {
  let result = image_transform_shear_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_shear_node_fill(s : ImagetransformshearNode, v : Double) -> ImagetransformshearNode {
  let result = image_transform_shear_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_node_min(s : ImagetransformshearNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_node_max(s : ImagetransformshearNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_node_to_string(s : ImagetransformshearNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_edge_make(size : Int) -> ImagetransformshearEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_edge_len(s : ImagetransformshearEdge) -> Int { s.size }

pub fn image_transform_shear_edge_get(s : ImagetransformshearEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_edge_set(s : ImagetransformshearEdge, i : Int, v : Double) -> ImagetransformshearEdge {
  let result = image_transform_shear_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_edge_sum(s : ImagetransformshearEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_shear_edge_mean(s : ImagetransformshearEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_shear_edge_sum(s) / s.size.to_double() }
}

pub fn image_transform_shear_edge_scale(s : ImagetransformshearEdge, f : Double) -> ImagetransformshearEdge {
  let result = image_transform_shear_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_shear_edge_add(a : ImagetransformshearEdge, b : ImagetransformshearEdge) -> ImagetransformshearEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_shear_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_shear_edge_copy(s : ImagetransformshearEdge) -> ImagetransformshearEdge {
  let result = image_transform_shear_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_shear_edge_fill(s : ImagetransformshearEdge, v : Double) -> ImagetransformshearEdge {
  let result = image_transform_shear_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_edge_min(s : ImagetransformshearEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_edge_max(s : ImagetransformshearEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_edge_to_string(s : ImagetransformshearEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_path_make(size : Int) -> ImagetransformshearPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_path_len(s : ImagetransformshearPath) -> Int { s.size }

pub fn image_transform_shear_path_get(s : ImagetransformshearPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_path_set(s : ImagetransformshearPath, i : Int, v : Double) -> ImagetransformshearPath {
  let result = image_transform_shear_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_path_sum(s : ImagetransformshearPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_shear_path_mean(s : ImagetransformshearPath) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_shear_path_sum(s) / s.size.to_double() }
}

pub fn image_transform_shear_path_scale(s : ImagetransformshearPath, f : Double) -> ImagetransformshearPath {
  let result = image_transform_shear_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_shear_path_add(a : ImagetransformshearPath, b : ImagetransformshearPath) -> ImagetransformshearPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_shear_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_shear_path_copy(s : ImagetransformshearPath) -> ImagetransformshearPath {
  let result = image_transform_shear_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_shear_path_fill(s : ImagetransformshearPath, v : Double) -> ImagetransformshearPath {
  let result = image_transform_shear_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_path_min(s : ImagetransformshearPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_path_max(s : ImagetransformshearPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_path_to_string(s : ImagetransformshearPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_cluster_make(size : Int) -> ImagetransformshearCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_cluster_len(s : ImagetransformshearCluster) -> Int { s.size }

pub fn image_transform_shear_cluster_get(s : ImagetransformshearCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_cluster_set(s : ImagetransformshearCluster, i : Int, v : Double) -> ImagetransformshearCluster {
  let result = image_transform_shear_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_cluster_sum(s : ImagetransformshearCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_shear_cluster_mean(s : ImagetransformshearCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_shear_cluster_sum(s) / s.size.to_double() }
}

pub fn image_transform_shear_cluster_scale(s : ImagetransformshearCluster, f : Double) -> ImagetransformshearCluster {
  let result = image_transform_shear_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_shear_cluster_add(a : ImagetransformshearCluster, b : ImagetransformshearCluster) -> ImagetransformshearCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_shear_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_shear_cluster_copy(s : ImagetransformshearCluster) -> ImagetransformshearCluster {
  let result = image_transform_shear_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_shear_cluster_fill(s : ImagetransformshearCluster, v : Double) -> ImagetransformshearCluster {
  let result = image_transform_shear_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_cluster_min(s : ImagetransformshearCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_cluster_max(s : ImagetransformshearCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_cluster_to_string(s : ImagetransformshearCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_model_make(size : Int) -> ImagetransformshearModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_model_len(s : ImagetransformshearModel) -> Int { s.size }

pub fn image_transform_shear_model_get(s : ImagetransformshearModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_model_set(s : ImagetransformshearModel, i : Int, v : Double) -> ImagetransformshearModel {
  let result = image_transform_shear_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_model_sum(s : ImagetransformshearModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_shear_model_mean(s : ImagetransformshearModel) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_shear_model_sum(s) / s.size.to_double() }
}

pub fn image_transform_shear_model_scale(s : ImagetransformshearModel, f : Double) -> ImagetransformshearModel {
  let result = image_transform_shear_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_shear_model_add(a : ImagetransformshearModel, b : ImagetransformshearModel) -> ImagetransformshearModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_shear_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_shear_model_copy(s : ImagetransformshearModel) -> ImagetransformshearModel {
  let result = image_transform_shear_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_shear_model_fill(s : ImagetransformshearModel, v : Double) -> ImagetransformshearModel {
  let result = image_transform_shear_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_model_min(s : ImagetransformshearModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_model_max(s : ImagetransformshearModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_model_to_string(s : ImagetransformshearModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_layer_make(size : Int) -> ImagetransformshearLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_layer_len(s : ImagetransformshearLayer) -> Int { s.size }

pub fn image_transform_shear_layer_get(s : ImagetransformshearLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_layer_set(s : ImagetransformshearLayer, i : Int, v : Double) -> ImagetransformshearLayer {
  let result = image_transform_shear_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_layer_sum(s : ImagetransformshearLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_shear_layer_mean(s : ImagetransformshearLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_shear_layer_sum(s) / s.size.to_double() }
}

pub fn image_transform_shear_layer_scale(s : ImagetransformshearLayer, f : Double) -> ImagetransformshearLayer {
  let result = image_transform_shear_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_shear_layer_add(a : ImagetransformshearLayer, b : ImagetransformshearLayer) -> ImagetransformshearLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_shear_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_shear_layer_copy(s : ImagetransformshearLayer) -> ImagetransformshearLayer {
  let result = image_transform_shear_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_shear_layer_fill(s : ImagetransformshearLayer, v : Double) -> ImagetransformshearLayer {
  let result = image_transform_shear_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_layer_min(s : ImagetransformshearLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_layer_max(s : ImagetransformshearLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_layer_to_string(s : ImagetransformshearLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_buffer_make(size : Int) -> ImagetransformshearBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_buffer_len(s : ImagetransformshearBuffer) -> Int { s.size }

pub fn image_transform_shear_buffer_get(s : ImagetransformshearBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_buffer_set(s : ImagetransformshearBuffer, i : Int, v : Double) -> ImagetransformshearBuffer {
  let result = image_transform_shear_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_buffer_sum(s : ImagetransformshearBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_shear_buffer_mean(s : ImagetransformshearBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_shear_buffer_sum(s) / s.size.to_double() }
}

pub fn image_transform_shear_buffer_scale(s : ImagetransformshearBuffer, f : Double) -> ImagetransformshearBuffer {
  let result = image_transform_shear_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_shear_buffer_add(a : ImagetransformshearBuffer, b : ImagetransformshearBuffer) -> ImagetransformshearBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_shear_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_shear_buffer_copy(s : ImagetransformshearBuffer) -> ImagetransformshearBuffer {
  let result = image_transform_shear_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_shear_buffer_fill(s : ImagetransformshearBuffer, v : Double) -> ImagetransformshearBuffer {
  let result = image_transform_shear_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_buffer_min(s : ImagetransformshearBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_buffer_max(s : ImagetransformshearBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_buffer_to_string(s : ImagetransformshearBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_cursor_make(size : Int) -> ImagetransformshearCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_cursor_len(s : ImagetransformshearCursor) -> Int { s.size }

pub fn image_transform_shear_cursor_get(s : ImagetransformshearCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_cursor_set(s : ImagetransformshearCursor, i : Int, v : Double) -> ImagetransformshearCursor {
  let result = image_transform_shear_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_cursor_sum(s : ImagetransformshearCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_shear_cursor_mean(s : ImagetransformshearCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_shear_cursor_sum(s) / s.size.to_double() }
}

pub fn image_transform_shear_cursor_scale(s : ImagetransformshearCursor, f : Double) -> ImagetransformshearCursor {
  let result = image_transform_shear_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_shear_cursor_add(a : ImagetransformshearCursor, b : ImagetransformshearCursor) -> ImagetransformshearCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_shear_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_shear_cursor_copy(s : ImagetransformshearCursor) -> ImagetransformshearCursor {
  let result = image_transform_shear_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_shear_cursor_fill(s : ImagetransformshearCursor, v : Double) -> ImagetransformshearCursor {
  let result = image_transform_shear_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_cursor_min(s : ImagetransformshearCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_cursor_max(s : ImagetransformshearCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_cursor_to_string(s : ImagetransformshearCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_view_make(size : Int) -> ImagetransformshearView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_view_len(s : ImagetransformshearView) -> Int { s.size }

pub fn image_transform_shear_view_get(s : ImagetransformshearView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_view_set(s : ImagetransformshearView, i : Int, v : Double) -> ImagetransformshearView {
  let result = image_transform_shear_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_view_sum(s : ImagetransformshearView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_shear_view_mean(s : ImagetransformshearView) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_shear_view_sum(s) / s.size.to_double() }
}

pub fn image_transform_shear_view_scale(s : ImagetransformshearView, f : Double) -> ImagetransformshearView {
  let result = image_transform_shear_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_shear_view_add(a : ImagetransformshearView, b : ImagetransformshearView) -> ImagetransformshearView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_shear_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_shear_view_copy(s : ImagetransformshearView) -> ImagetransformshearView {
  let result = image_transform_shear_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_shear_view_fill(s : ImagetransformshearView, v : Double) -> ImagetransformshearView {
  let result = image_transform_shear_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_view_min(s : ImagetransformshearView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_view_max(s : ImagetransformshearView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_view_to_string(s : ImagetransformshearView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_range_make(size : Int) -> ImagetransformshearRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_range_len(s : ImagetransformshearRange) -> Int { s.size }

pub fn image_transform_shear_range_get(s : ImagetransformshearRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_range_set(s : ImagetransformshearRange, i : Int, v : Double) -> ImagetransformshearRange {
  let result = image_transform_shear_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_range_sum(s : ImagetransformshearRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_shear_range_mean(s : ImagetransformshearRange) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_shear_range_sum(s) / s.size.to_double() }
}

pub fn image_transform_shear_range_scale(s : ImagetransformshearRange, f : Double) -> ImagetransformshearRange {
  let result = image_transform_shear_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_shear_range_add(a : ImagetransformshearRange, b : ImagetransformshearRange) -> ImagetransformshearRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_shear_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_shear_range_copy(s : ImagetransformshearRange) -> ImagetransformshearRange {
  let result = image_transform_shear_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_shear_range_fill(s : ImagetransformshearRange, v : Double) -> ImagetransformshearRange {
  let result = image_transform_shear_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_range_min(s : ImagetransformshearRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_range_max(s : ImagetransformshearRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_range_to_string(s : ImagetransformshearRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformshearSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_shear_slice_make(size : Int) -> ImagetransformshearSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_shear_slice_len(s : ImagetransformshearSlice) -> Int { s.size }

pub fn image_transform_shear_slice_get(s : ImagetransformshearSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_shear_slice_set(s : ImagetransformshearSlice, i : Int, v : Double) -> ImagetransformshearSlice {
  let result = image_transform_shear_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_slice_sum(s : ImagetransformshearSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_shear_slice_mean(s : ImagetransformshearSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_shear_slice_sum(s) / s.size.to_double() }
}

pub fn image_transform_shear_slice_scale(s : ImagetransformshearSlice, f : Double) -> ImagetransformshearSlice {
  let result = image_transform_shear_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_shear_slice_add(a : ImagetransformshearSlice, b : ImagetransformshearSlice) -> ImagetransformshearSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_shear_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_shear_slice_copy(s : ImagetransformshearSlice) -> ImagetransformshearSlice {
  let result = image_transform_shear_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_shear_slice_fill(s : ImagetransformshearSlice, v : Double) -> ImagetransformshearSlice {
  let result = image_transform_shear_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_shear_slice_min(s : ImagetransformshearSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_slice_max(s : ImagetransformshearSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_shear_slice_to_string(s : ImagetransformshearSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

