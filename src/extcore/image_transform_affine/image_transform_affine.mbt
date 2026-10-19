///===
/// extcore/image_transform_affine

pub(all) struct ImagetransformaffinePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_affine_make_point(x : Double, y : Double) -> ImagetransformaffinePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_affine_make_point3(x : Double, y : Double, z : Double) -> ImagetransformaffinePoint {
  { x, y, z, label: 0 }
}

pub fn image_transform_affine_point_x(pt : ImagetransformaffinePoint) -> Double { pt.x }

pub fn image_transform_affine_point_y(pt : ImagetransformaffinePoint) -> Double { pt.y }

pub fn image_transform_affine_point_z(pt : ImagetransformaffinePoint) -> Double { pt.z }

pub fn image_transform_affine_point_label(pt : ImagetransformaffinePoint) -> Int { pt.label }

pub fn image_transform_affine_point_dist(a : ImagetransformaffinePoint, b : ImagetransformaffinePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_transform_affine_point_add(a : ImagetransformaffinePoint, b : ImagetransformaffinePoint) -> ImagetransformaffinePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_transform_affine_point_sub(a : ImagetransformaffinePoint, b : ImagetransformaffinePoint) -> ImagetransformaffinePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_transform_affine_point_scale(pt : ImagetransformaffinePoint, s : Double) -> ImagetransformaffinePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_transform_affine_point_dot(a : ImagetransformaffinePoint, b : ImagetransformaffinePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_transform_affine_point_cross(a : ImagetransformaffinePoint, b : ImagetransformaffinePoint) -> ImagetransformaffinePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_transform_affine_point_norm(pt : ImagetransformaffinePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_transform_affine_point_normalize(pt : ImagetransformaffinePoint) -> ImagetransformaffinePoint {
  let n = image_transform_affine_point_norm(pt)
  if n < 0.0000001 { pt } else { image_transform_affine_point_scale(pt, 1.0 / n) }
}

pub fn image_transform_affine_point_negate(pt : ImagetransformaffinePoint) -> ImagetransformaffinePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_transform_affine_point_mid(a : ImagetransformaffinePoint, b : ImagetransformaffinePoint) -> ImagetransformaffinePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_transform_affine_point_lerp(a : ImagetransformaffinePoint, b : ImagetransformaffinePoint, t : Double) -> ImagetransformaffinePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_transform_affine_point_to_string(pt : ImagetransformaffinePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagetransformaffineSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_affine_make_series(vals : Array[Double], name : String) -> ImagetransformaffineSeries {
  { vals, name, meta: 0 }
}

pub fn image_transform_affine_series_len(s : ImagetransformaffineSeries) -> Int { s.vals.length() }

pub fn image_transform_affine_series_sum(s : ImagetransformaffineSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_transform_affine_series_mean(s : ImagetransformaffineSeries) -> Double {
  let n = image_transform_affine_series_len(s)
  if n == 0 { 0.0 } else { image_transform_affine_series_sum(s) / n.to_double() }
}

pub fn image_transform_affine_series_min(s : ImagetransformaffineSeries) -> Double {
  let n = image_transform_affine_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_transform_affine_series_max(s : ImagetransformaffineSeries) -> Double {
  let n = image_transform_affine_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_transform_affine_series_range(s : ImagetransformaffineSeries) -> Double {
  image_transform_affine_series_max(s) - image_transform_affine_series_min(s)
}

pub fn image_transform_affine_series_var(s : ImagetransformaffineSeries) -> Double {
  let n = image_transform_affine_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_transform_affine_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_transform_affine_series_std(s : ImagetransformaffineSeries) -> Double { @_common.sqrt(image_transform_affine_series_var(s)) }

pub fn image_transform_affine_series_median(s : ImagetransformaffineSeries) -> Double {
  let n = image_transform_affine_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_transform_affine_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_transform_affine_series_scale(s : ImagetransformaffineSeries, f : Double) -> ImagetransformaffineSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_transform_affine_series_add(a : ImagetransformaffineSeries, b : ImagetransformaffineSeries) -> ImagetransformaffineSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_transform_affine_series_sub(a : ImagetransformaffineSeries, b : ImagetransformaffineSeries) -> ImagetransformaffineSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_transform_affine_series_normalize(s : ImagetransformaffineSeries) -> ImagetransformaffineSeries {
  let mn = image_transform_affine_series_min(s)
  let mx = image_transform_affine_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_transform_affine_series_cumsum(s : ImagetransformaffineSeries) -> ImagetransformaffineSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_transform_affine_series_to_string(s : ImagetransformaffineSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformaffineMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_affine_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformaffineMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_affine_matrix_identity(n : Int) -> ImagetransformaffineMatrix {
  let m = image_transform_affine_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_transform_affine_matrix_get(m : ImagetransformaffineMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_transform_affine_matrix_transpose(m : ImagetransformaffineMatrix) -> ImagetransformaffineMatrix {
  let result = image_transform_affine_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_transform_affine_matrix_add(a : ImagetransformaffineMatrix, b : ImagetransformaffineMatrix) -> ImagetransformaffineMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_transform_affine_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_transform_affine_matrix_scale(m : ImagetransformaffineMatrix, s : Double) -> ImagetransformaffineMatrix {
  let result = image_transform_affine_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_transform_affine_matrix_multiply(a : ImagetransformaffineMatrix, b : ImagetransformaffineMatrix) -> ImagetransformaffineMatrix {
  if a.cols != b.rows { return image_transform_affine_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_transform_affine_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_transform_affine_matrix_trace(m : ImagetransformaffineMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_transform_affine_matrix_det(m : ImagetransformaffineMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_transform_affine_matrix_norm(m : ImagetransformaffineMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_transform_affine_matrix_to_string(m : ImagetransformaffineMatrix) -> String {
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

pub(all) struct ImagetransformaffineVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_affine_make_vector(comps : Array[Double]) -> ImagetransformaffineVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_affine_vector_zero(dim : Int) -> ImagetransformaffineVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_transform_affine_vector_add(a : ImagetransformaffineVector, b : ImagetransformaffineVector) -> ImagetransformaffineVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_affine_vector_sub(a : ImagetransformaffineVector, b : ImagetransformaffineVector) -> ImagetransformaffineVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_affine_vector_scale(v : ImagetransformaffineVector, s : Double) -> ImagetransformaffineVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_transform_affine_vector_dot(a : ImagetransformaffineVector, b : ImagetransformaffineVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_transform_affine_vector_norm(v : ImagetransformaffineVector) -> Double { @_common.sqrt(image_transform_affine_vector_dot(v, v)) }

pub fn image_transform_affine_vector_normalize(v : ImagetransformaffineVector) -> ImagetransformaffineVector {
  let n = image_transform_affine_vector_norm(v)
  if n < 0.0000001 { v } else { image_transform_affine_vector_scale(v, 1.0 / n) }
}

pub fn image_transform_affine_vector_dist(a : ImagetransformaffineVector, b : ImagetransformaffineVector) -> Double {
  image_transform_affine_vector_norm(image_transform_affine_vector_sub(a, b))
}

pub fn image_transform_affine_vector_to_string(v : ImagetransformaffineVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_affine_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_affine_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_affine_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_affine_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_affine_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_affine_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_affine_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_affine_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_affine_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_affine_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_affine_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_affine_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_affine_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_affine_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_affine_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_affine_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_affine_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_affine_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_affine_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_affine_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_affine_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_affine_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_affine_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_affine_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_affine_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_affine_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_affine_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_affine_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_affine_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformaffineFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_frame_make(size : Int) -> ImagetransformaffineFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_frame_len(s : ImagetransformaffineFrame) -> Int { s.size }

pub fn image_transform_affine_frame_get(s : ImagetransformaffineFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_frame_set(s : ImagetransformaffineFrame, i : Int, v : Double) -> ImagetransformaffineFrame {
  let result = image_transform_affine_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_frame_sum(s : ImagetransformaffineFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_affine_frame_mean(s : ImagetransformaffineFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_affine_frame_sum(s) / s.size.to_double() }
}

pub fn image_transform_affine_frame_scale(s : ImagetransformaffineFrame, f : Double) -> ImagetransformaffineFrame {
  let result = image_transform_affine_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_affine_frame_add(a : ImagetransformaffineFrame, b : ImagetransformaffineFrame) -> ImagetransformaffineFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_affine_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_affine_frame_copy(s : ImagetransformaffineFrame) -> ImagetransformaffineFrame {
  let result = image_transform_affine_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_affine_frame_fill(s : ImagetransformaffineFrame, v : Double) -> ImagetransformaffineFrame {
  let result = image_transform_affine_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_frame_min(s : ImagetransformaffineFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_frame_max(s : ImagetransformaffineFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_frame_to_string(s : ImagetransformaffineFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_table_make(size : Int) -> ImagetransformaffineTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_table_len(s : ImagetransformaffineTable) -> Int { s.size }

pub fn image_transform_affine_table_get(s : ImagetransformaffineTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_table_set(s : ImagetransformaffineTable, i : Int, v : Double) -> ImagetransformaffineTable {
  let result = image_transform_affine_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_table_sum(s : ImagetransformaffineTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_affine_table_mean(s : ImagetransformaffineTable) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_affine_table_sum(s) / s.size.to_double() }
}

pub fn image_transform_affine_table_scale(s : ImagetransformaffineTable, f : Double) -> ImagetransformaffineTable {
  let result = image_transform_affine_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_affine_table_add(a : ImagetransformaffineTable, b : ImagetransformaffineTable) -> ImagetransformaffineTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_affine_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_affine_table_copy(s : ImagetransformaffineTable) -> ImagetransformaffineTable {
  let result = image_transform_affine_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_affine_table_fill(s : ImagetransformaffineTable, v : Double) -> ImagetransformaffineTable {
  let result = image_transform_affine_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_table_min(s : ImagetransformaffineTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_table_max(s : ImagetransformaffineTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_table_to_string(s : ImagetransformaffineTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_graphn_make(size : Int) -> ImagetransformaffineGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_graphn_len(s : ImagetransformaffineGraphN) -> Int { s.size }

pub fn image_transform_affine_graphn_get(s : ImagetransformaffineGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_graphn_set(s : ImagetransformaffineGraphN, i : Int, v : Double) -> ImagetransformaffineGraphN {
  let result = image_transform_affine_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_graphn_sum(s : ImagetransformaffineGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_affine_graphn_mean(s : ImagetransformaffineGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_affine_graphn_sum(s) / s.size.to_double() }
}

pub fn image_transform_affine_graphn_scale(s : ImagetransformaffineGraphN, f : Double) -> ImagetransformaffineGraphN {
  let result = image_transform_affine_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_affine_graphn_add(a : ImagetransformaffineGraphN, b : ImagetransformaffineGraphN) -> ImagetransformaffineGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_affine_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_affine_graphn_copy(s : ImagetransformaffineGraphN) -> ImagetransformaffineGraphN {
  let result = image_transform_affine_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_affine_graphn_fill(s : ImagetransformaffineGraphN, v : Double) -> ImagetransformaffineGraphN {
  let result = image_transform_affine_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_graphn_min(s : ImagetransformaffineGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_graphn_max(s : ImagetransformaffineGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_graphn_to_string(s : ImagetransformaffineGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_node_make(size : Int) -> ImagetransformaffineNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_node_len(s : ImagetransformaffineNode) -> Int { s.size }

pub fn image_transform_affine_node_get(s : ImagetransformaffineNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_node_set(s : ImagetransformaffineNode, i : Int, v : Double) -> ImagetransformaffineNode {
  let result = image_transform_affine_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_node_sum(s : ImagetransformaffineNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_affine_node_mean(s : ImagetransformaffineNode) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_affine_node_sum(s) / s.size.to_double() }
}

pub fn image_transform_affine_node_scale(s : ImagetransformaffineNode, f : Double) -> ImagetransformaffineNode {
  let result = image_transform_affine_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_affine_node_add(a : ImagetransformaffineNode, b : ImagetransformaffineNode) -> ImagetransformaffineNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_affine_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_affine_node_copy(s : ImagetransformaffineNode) -> ImagetransformaffineNode {
  let result = image_transform_affine_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_affine_node_fill(s : ImagetransformaffineNode, v : Double) -> ImagetransformaffineNode {
  let result = image_transform_affine_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_node_min(s : ImagetransformaffineNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_node_max(s : ImagetransformaffineNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_node_to_string(s : ImagetransformaffineNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_edge_make(size : Int) -> ImagetransformaffineEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_edge_len(s : ImagetransformaffineEdge) -> Int { s.size }

pub fn image_transform_affine_edge_get(s : ImagetransformaffineEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_edge_set(s : ImagetransformaffineEdge, i : Int, v : Double) -> ImagetransformaffineEdge {
  let result = image_transform_affine_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_edge_sum(s : ImagetransformaffineEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_affine_edge_mean(s : ImagetransformaffineEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_affine_edge_sum(s) / s.size.to_double() }
}

pub fn image_transform_affine_edge_scale(s : ImagetransformaffineEdge, f : Double) -> ImagetransformaffineEdge {
  let result = image_transform_affine_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_affine_edge_add(a : ImagetransformaffineEdge, b : ImagetransformaffineEdge) -> ImagetransformaffineEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_affine_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_affine_edge_copy(s : ImagetransformaffineEdge) -> ImagetransformaffineEdge {
  let result = image_transform_affine_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_affine_edge_fill(s : ImagetransformaffineEdge, v : Double) -> ImagetransformaffineEdge {
  let result = image_transform_affine_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_edge_min(s : ImagetransformaffineEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_edge_max(s : ImagetransformaffineEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_edge_to_string(s : ImagetransformaffineEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffinePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_path_make(size : Int) -> ImagetransformaffinePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_path_len(s : ImagetransformaffinePath) -> Int { s.size }

pub fn image_transform_affine_path_get(s : ImagetransformaffinePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_path_set(s : ImagetransformaffinePath, i : Int, v : Double) -> ImagetransformaffinePath {
  let result = image_transform_affine_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_path_sum(s : ImagetransformaffinePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_affine_path_mean(s : ImagetransformaffinePath) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_affine_path_sum(s) / s.size.to_double() }
}

pub fn image_transform_affine_path_scale(s : ImagetransformaffinePath, f : Double) -> ImagetransformaffinePath {
  let result = image_transform_affine_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_affine_path_add(a : ImagetransformaffinePath, b : ImagetransformaffinePath) -> ImagetransformaffinePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_affine_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_affine_path_copy(s : ImagetransformaffinePath) -> ImagetransformaffinePath {
  let result = image_transform_affine_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_affine_path_fill(s : ImagetransformaffinePath, v : Double) -> ImagetransformaffinePath {
  let result = image_transform_affine_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_path_min(s : ImagetransformaffinePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_path_max(s : ImagetransformaffinePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_path_to_string(s : ImagetransformaffinePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_cluster_make(size : Int) -> ImagetransformaffineCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_cluster_len(s : ImagetransformaffineCluster) -> Int { s.size }

pub fn image_transform_affine_cluster_get(s : ImagetransformaffineCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_cluster_set(s : ImagetransformaffineCluster, i : Int, v : Double) -> ImagetransformaffineCluster {
  let result = image_transform_affine_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_cluster_sum(s : ImagetransformaffineCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_affine_cluster_mean(s : ImagetransformaffineCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_affine_cluster_sum(s) / s.size.to_double() }
}

pub fn image_transform_affine_cluster_scale(s : ImagetransformaffineCluster, f : Double) -> ImagetransformaffineCluster {
  let result = image_transform_affine_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_affine_cluster_add(a : ImagetransformaffineCluster, b : ImagetransformaffineCluster) -> ImagetransformaffineCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_affine_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_affine_cluster_copy(s : ImagetransformaffineCluster) -> ImagetransformaffineCluster {
  let result = image_transform_affine_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_affine_cluster_fill(s : ImagetransformaffineCluster, v : Double) -> ImagetransformaffineCluster {
  let result = image_transform_affine_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_cluster_min(s : ImagetransformaffineCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_cluster_max(s : ImagetransformaffineCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_cluster_to_string(s : ImagetransformaffineCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_model_make(size : Int) -> ImagetransformaffineModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_model_len(s : ImagetransformaffineModel) -> Int { s.size }

pub fn image_transform_affine_model_get(s : ImagetransformaffineModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_model_set(s : ImagetransformaffineModel, i : Int, v : Double) -> ImagetransformaffineModel {
  let result = image_transform_affine_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_model_sum(s : ImagetransformaffineModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_affine_model_mean(s : ImagetransformaffineModel) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_affine_model_sum(s) / s.size.to_double() }
}

pub fn image_transform_affine_model_scale(s : ImagetransformaffineModel, f : Double) -> ImagetransformaffineModel {
  let result = image_transform_affine_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_affine_model_add(a : ImagetransformaffineModel, b : ImagetransformaffineModel) -> ImagetransformaffineModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_affine_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_affine_model_copy(s : ImagetransformaffineModel) -> ImagetransformaffineModel {
  let result = image_transform_affine_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_affine_model_fill(s : ImagetransformaffineModel, v : Double) -> ImagetransformaffineModel {
  let result = image_transform_affine_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_model_min(s : ImagetransformaffineModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_model_max(s : ImagetransformaffineModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_model_to_string(s : ImagetransformaffineModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_layer_make(size : Int) -> ImagetransformaffineLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_layer_len(s : ImagetransformaffineLayer) -> Int { s.size }

pub fn image_transform_affine_layer_get(s : ImagetransformaffineLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_layer_set(s : ImagetransformaffineLayer, i : Int, v : Double) -> ImagetransformaffineLayer {
  let result = image_transform_affine_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_layer_sum(s : ImagetransformaffineLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_affine_layer_mean(s : ImagetransformaffineLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_affine_layer_sum(s) / s.size.to_double() }
}

pub fn image_transform_affine_layer_scale(s : ImagetransformaffineLayer, f : Double) -> ImagetransformaffineLayer {
  let result = image_transform_affine_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_affine_layer_add(a : ImagetransformaffineLayer, b : ImagetransformaffineLayer) -> ImagetransformaffineLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_affine_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_affine_layer_copy(s : ImagetransformaffineLayer) -> ImagetransformaffineLayer {
  let result = image_transform_affine_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_affine_layer_fill(s : ImagetransformaffineLayer, v : Double) -> ImagetransformaffineLayer {
  let result = image_transform_affine_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_layer_min(s : ImagetransformaffineLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_layer_max(s : ImagetransformaffineLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_layer_to_string(s : ImagetransformaffineLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_buffer_make(size : Int) -> ImagetransformaffineBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_buffer_len(s : ImagetransformaffineBuffer) -> Int { s.size }

pub fn image_transform_affine_buffer_get(s : ImagetransformaffineBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_buffer_set(s : ImagetransformaffineBuffer, i : Int, v : Double) -> ImagetransformaffineBuffer {
  let result = image_transform_affine_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_buffer_sum(s : ImagetransformaffineBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_affine_buffer_mean(s : ImagetransformaffineBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_affine_buffer_sum(s) / s.size.to_double() }
}

pub fn image_transform_affine_buffer_scale(s : ImagetransformaffineBuffer, f : Double) -> ImagetransformaffineBuffer {
  let result = image_transform_affine_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_affine_buffer_add(a : ImagetransformaffineBuffer, b : ImagetransformaffineBuffer) -> ImagetransformaffineBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_affine_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_affine_buffer_copy(s : ImagetransformaffineBuffer) -> ImagetransformaffineBuffer {
  let result = image_transform_affine_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_affine_buffer_fill(s : ImagetransformaffineBuffer, v : Double) -> ImagetransformaffineBuffer {
  let result = image_transform_affine_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_buffer_min(s : ImagetransformaffineBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_buffer_max(s : ImagetransformaffineBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_buffer_to_string(s : ImagetransformaffineBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_cursor_make(size : Int) -> ImagetransformaffineCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_cursor_len(s : ImagetransformaffineCursor) -> Int { s.size }

pub fn image_transform_affine_cursor_get(s : ImagetransformaffineCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_cursor_set(s : ImagetransformaffineCursor, i : Int, v : Double) -> ImagetransformaffineCursor {
  let result = image_transform_affine_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_cursor_sum(s : ImagetransformaffineCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_affine_cursor_mean(s : ImagetransformaffineCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_affine_cursor_sum(s) / s.size.to_double() }
}

pub fn image_transform_affine_cursor_scale(s : ImagetransformaffineCursor, f : Double) -> ImagetransformaffineCursor {
  let result = image_transform_affine_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_affine_cursor_add(a : ImagetransformaffineCursor, b : ImagetransformaffineCursor) -> ImagetransformaffineCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_affine_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_affine_cursor_copy(s : ImagetransformaffineCursor) -> ImagetransformaffineCursor {
  let result = image_transform_affine_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_affine_cursor_fill(s : ImagetransformaffineCursor, v : Double) -> ImagetransformaffineCursor {
  let result = image_transform_affine_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_cursor_min(s : ImagetransformaffineCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_cursor_max(s : ImagetransformaffineCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_cursor_to_string(s : ImagetransformaffineCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_view_make(size : Int) -> ImagetransformaffineView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_view_len(s : ImagetransformaffineView) -> Int { s.size }

pub fn image_transform_affine_view_get(s : ImagetransformaffineView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_view_set(s : ImagetransformaffineView, i : Int, v : Double) -> ImagetransformaffineView {
  let result = image_transform_affine_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_view_sum(s : ImagetransformaffineView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_affine_view_mean(s : ImagetransformaffineView) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_affine_view_sum(s) / s.size.to_double() }
}

pub fn image_transform_affine_view_scale(s : ImagetransformaffineView, f : Double) -> ImagetransformaffineView {
  let result = image_transform_affine_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_affine_view_add(a : ImagetransformaffineView, b : ImagetransformaffineView) -> ImagetransformaffineView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_affine_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_affine_view_copy(s : ImagetransformaffineView) -> ImagetransformaffineView {
  let result = image_transform_affine_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_affine_view_fill(s : ImagetransformaffineView, v : Double) -> ImagetransformaffineView {
  let result = image_transform_affine_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_view_min(s : ImagetransformaffineView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_view_max(s : ImagetransformaffineView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_view_to_string(s : ImagetransformaffineView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_range_make(size : Int) -> ImagetransformaffineRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_range_len(s : ImagetransformaffineRange) -> Int { s.size }

pub fn image_transform_affine_range_get(s : ImagetransformaffineRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_range_set(s : ImagetransformaffineRange, i : Int, v : Double) -> ImagetransformaffineRange {
  let result = image_transform_affine_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_range_sum(s : ImagetransformaffineRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_affine_range_mean(s : ImagetransformaffineRange) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_affine_range_sum(s) / s.size.to_double() }
}

pub fn image_transform_affine_range_scale(s : ImagetransformaffineRange, f : Double) -> ImagetransformaffineRange {
  let result = image_transform_affine_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_affine_range_add(a : ImagetransformaffineRange, b : ImagetransformaffineRange) -> ImagetransformaffineRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_affine_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_affine_range_copy(s : ImagetransformaffineRange) -> ImagetransformaffineRange {
  let result = image_transform_affine_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_affine_range_fill(s : ImagetransformaffineRange, v : Double) -> ImagetransformaffineRange {
  let result = image_transform_affine_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_range_min(s : ImagetransformaffineRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_range_max(s : ImagetransformaffineRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_range_to_string(s : ImagetransformaffineRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformaffineSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_affine_slice_make(size : Int) -> ImagetransformaffineSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_affine_slice_len(s : ImagetransformaffineSlice) -> Int { s.size }

pub fn image_transform_affine_slice_get(s : ImagetransformaffineSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_affine_slice_set(s : ImagetransformaffineSlice, i : Int, v : Double) -> ImagetransformaffineSlice {
  let result = image_transform_affine_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_slice_sum(s : ImagetransformaffineSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_affine_slice_mean(s : ImagetransformaffineSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_affine_slice_sum(s) / s.size.to_double() }
}

pub fn image_transform_affine_slice_scale(s : ImagetransformaffineSlice, f : Double) -> ImagetransformaffineSlice {
  let result = image_transform_affine_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_affine_slice_add(a : ImagetransformaffineSlice, b : ImagetransformaffineSlice) -> ImagetransformaffineSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_affine_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_affine_slice_copy(s : ImagetransformaffineSlice) -> ImagetransformaffineSlice {
  let result = image_transform_affine_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_affine_slice_fill(s : ImagetransformaffineSlice, v : Double) -> ImagetransformaffineSlice {
  let result = image_transform_affine_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_affine_slice_min(s : ImagetransformaffineSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_slice_max(s : ImagetransformaffineSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_affine_slice_to_string(s : ImagetransformaffineSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

