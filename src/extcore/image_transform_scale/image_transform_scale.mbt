///===
/// extcore/image_transform_scale

pub(all) struct ImagetransformscalePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_scale_make_point(x : Double, y : Double) -> ImagetransformscalePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_scale_make_point3(x : Double, y : Double, z : Double) -> ImagetransformscalePoint {
  { x, y, z, label: 0 }
}

pub fn image_transform_scale_point_x(pt : ImagetransformscalePoint) -> Double { pt.x }

pub fn image_transform_scale_point_y(pt : ImagetransformscalePoint) -> Double { pt.y }

pub fn image_transform_scale_point_z(pt : ImagetransformscalePoint) -> Double { pt.z }

pub fn image_transform_scale_point_label(pt : ImagetransformscalePoint) -> Int { pt.label }

pub fn image_transform_scale_point_dist(a : ImagetransformscalePoint, b : ImagetransformscalePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_transform_scale_point_add(a : ImagetransformscalePoint, b : ImagetransformscalePoint) -> ImagetransformscalePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_transform_scale_point_sub(a : ImagetransformscalePoint, b : ImagetransformscalePoint) -> ImagetransformscalePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_transform_scale_point_scale(pt : ImagetransformscalePoint, s : Double) -> ImagetransformscalePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_transform_scale_point_dot(a : ImagetransformscalePoint, b : ImagetransformscalePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_transform_scale_point_cross(a : ImagetransformscalePoint, b : ImagetransformscalePoint) -> ImagetransformscalePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_transform_scale_point_norm(pt : ImagetransformscalePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_transform_scale_point_normalize(pt : ImagetransformscalePoint) -> ImagetransformscalePoint {
  let n = image_transform_scale_point_norm(pt)
  if n < 0.0000001 { pt } else { image_transform_scale_point_scale(pt, 1.0 / n) }
}

pub fn image_transform_scale_point_negate(pt : ImagetransformscalePoint) -> ImagetransformscalePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_transform_scale_point_mid(a : ImagetransformscalePoint, b : ImagetransformscalePoint) -> ImagetransformscalePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_transform_scale_point_lerp(a : ImagetransformscalePoint, b : ImagetransformscalePoint, t : Double) -> ImagetransformscalePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_transform_scale_point_to_string(pt : ImagetransformscalePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagetransformscaleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_scale_make_series(vals : Array[Double], name : String) -> ImagetransformscaleSeries {
  { vals, name, meta: 0 }
}

pub fn image_transform_scale_series_len(s : ImagetransformscaleSeries) -> Int { s.vals.length() }

pub fn image_transform_scale_series_sum(s : ImagetransformscaleSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_transform_scale_series_mean(s : ImagetransformscaleSeries) -> Double {
  let n = image_transform_scale_series_len(s)
  if n == 0 { 0.0 } else { image_transform_scale_series_sum(s) / n.to_double() }
}

pub fn image_transform_scale_series_min(s : ImagetransformscaleSeries) -> Double {
  let n = image_transform_scale_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_transform_scale_series_max(s : ImagetransformscaleSeries) -> Double {
  let n = image_transform_scale_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_transform_scale_series_range(s : ImagetransformscaleSeries) -> Double {
  image_transform_scale_series_max(s) - image_transform_scale_series_min(s)
}

pub fn image_transform_scale_series_var(s : ImagetransformscaleSeries) -> Double {
  let n = image_transform_scale_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_transform_scale_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_transform_scale_series_std(s : ImagetransformscaleSeries) -> Double { @_common.sqrt(image_transform_scale_series_var(s)) }

pub fn image_transform_scale_series_median(s : ImagetransformscaleSeries) -> Double {
  let n = image_transform_scale_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_transform_scale_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_transform_scale_series_scale(s : ImagetransformscaleSeries, f : Double) -> ImagetransformscaleSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_transform_scale_series_add(a : ImagetransformscaleSeries, b : ImagetransformscaleSeries) -> ImagetransformscaleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_transform_scale_series_sub(a : ImagetransformscaleSeries, b : ImagetransformscaleSeries) -> ImagetransformscaleSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_transform_scale_series_normalize(s : ImagetransformscaleSeries) -> ImagetransformscaleSeries {
  let mn = image_transform_scale_series_min(s)
  let mx = image_transform_scale_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_transform_scale_series_cumsum(s : ImagetransformscaleSeries) -> ImagetransformscaleSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_transform_scale_series_to_string(s : ImagetransformscaleSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformscaleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_scale_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformscaleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_scale_matrix_identity(n : Int) -> ImagetransformscaleMatrix {
  let m = image_transform_scale_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_transform_scale_matrix_get(m : ImagetransformscaleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_transform_scale_matrix_transpose(m : ImagetransformscaleMatrix) -> ImagetransformscaleMatrix {
  let result = image_transform_scale_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_transform_scale_matrix_add(a : ImagetransformscaleMatrix, b : ImagetransformscaleMatrix) -> ImagetransformscaleMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_transform_scale_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_transform_scale_matrix_scale(m : ImagetransformscaleMatrix, s : Double) -> ImagetransformscaleMatrix {
  let result = image_transform_scale_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_transform_scale_matrix_multiply(a : ImagetransformscaleMatrix, b : ImagetransformscaleMatrix) -> ImagetransformscaleMatrix {
  if a.cols != b.rows { return image_transform_scale_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_transform_scale_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_transform_scale_matrix_trace(m : ImagetransformscaleMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_transform_scale_matrix_det(m : ImagetransformscaleMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_transform_scale_matrix_norm(m : ImagetransformscaleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_transform_scale_matrix_to_string(m : ImagetransformscaleMatrix) -> String {
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

pub(all) struct ImagetransformscaleVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_scale_make_vector(comps : Array[Double]) -> ImagetransformscaleVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_scale_vector_zero(dim : Int) -> ImagetransformscaleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_transform_scale_vector_add(a : ImagetransformscaleVector, b : ImagetransformscaleVector) -> ImagetransformscaleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_scale_vector_sub(a : ImagetransformscaleVector, b : ImagetransformscaleVector) -> ImagetransformscaleVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_scale_vector_scale(v : ImagetransformscaleVector, s : Double) -> ImagetransformscaleVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_transform_scale_vector_dot(a : ImagetransformscaleVector, b : ImagetransformscaleVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_transform_scale_vector_norm(v : ImagetransformscaleVector) -> Double { @_common.sqrt(image_transform_scale_vector_dot(v, v)) }

pub fn image_transform_scale_vector_normalize(v : ImagetransformscaleVector) -> ImagetransformscaleVector {
  let n = image_transform_scale_vector_norm(v)
  if n < 0.0000001 { v } else { image_transform_scale_vector_scale(v, 1.0 / n) }
}

pub fn image_transform_scale_vector_dist(a : ImagetransformscaleVector, b : ImagetransformscaleVector) -> Double {
  image_transform_scale_vector_norm(image_transform_scale_vector_sub(a, b))
}

pub fn image_transform_scale_vector_to_string(v : ImagetransformscaleVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_scale_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_scale_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_scale_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_scale_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_scale_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_scale_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_scale_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_scale_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_scale_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_scale_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_scale_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_scale_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_scale_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_scale_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_scale_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_scale_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_scale_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_scale_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_scale_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_scale_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_scale_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_scale_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_scale_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_scale_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_scale_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_scale_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_scale_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_scale_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_scale_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformscaleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_frame_make(size : Int) -> ImagetransformscaleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_frame_len(s : ImagetransformscaleFrame) -> Int { s.size }

pub fn image_transform_scale_frame_get(s : ImagetransformscaleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_frame_set(s : ImagetransformscaleFrame, i : Int, v : Double) -> ImagetransformscaleFrame {
  let result = image_transform_scale_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_frame_sum(s : ImagetransformscaleFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_scale_frame_mean(s : ImagetransformscaleFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_scale_frame_sum(s) / s.size.to_double() }
}

pub fn image_transform_scale_frame_scale(s : ImagetransformscaleFrame, f : Double) -> ImagetransformscaleFrame {
  let result = image_transform_scale_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_scale_frame_add(a : ImagetransformscaleFrame, b : ImagetransformscaleFrame) -> ImagetransformscaleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_scale_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_scale_frame_copy(s : ImagetransformscaleFrame) -> ImagetransformscaleFrame {
  let result = image_transform_scale_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_scale_frame_fill(s : ImagetransformscaleFrame, v : Double) -> ImagetransformscaleFrame {
  let result = image_transform_scale_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_frame_min(s : ImagetransformscaleFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_frame_max(s : ImagetransformscaleFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_frame_to_string(s : ImagetransformscaleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_table_make(size : Int) -> ImagetransformscaleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_table_len(s : ImagetransformscaleTable) -> Int { s.size }

pub fn image_transform_scale_table_get(s : ImagetransformscaleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_table_set(s : ImagetransformscaleTable, i : Int, v : Double) -> ImagetransformscaleTable {
  let result = image_transform_scale_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_table_sum(s : ImagetransformscaleTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_scale_table_mean(s : ImagetransformscaleTable) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_scale_table_sum(s) / s.size.to_double() }
}

pub fn image_transform_scale_table_scale(s : ImagetransformscaleTable, f : Double) -> ImagetransformscaleTable {
  let result = image_transform_scale_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_scale_table_add(a : ImagetransformscaleTable, b : ImagetransformscaleTable) -> ImagetransformscaleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_scale_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_scale_table_copy(s : ImagetransformscaleTable) -> ImagetransformscaleTable {
  let result = image_transform_scale_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_scale_table_fill(s : ImagetransformscaleTable, v : Double) -> ImagetransformscaleTable {
  let result = image_transform_scale_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_table_min(s : ImagetransformscaleTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_table_max(s : ImagetransformscaleTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_table_to_string(s : ImagetransformscaleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_graphn_make(size : Int) -> ImagetransformscaleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_graphn_len(s : ImagetransformscaleGraphN) -> Int { s.size }

pub fn image_transform_scale_graphn_get(s : ImagetransformscaleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_graphn_set(s : ImagetransformscaleGraphN, i : Int, v : Double) -> ImagetransformscaleGraphN {
  let result = image_transform_scale_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_graphn_sum(s : ImagetransformscaleGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_scale_graphn_mean(s : ImagetransformscaleGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_scale_graphn_sum(s) / s.size.to_double() }
}

pub fn image_transform_scale_graphn_scale(s : ImagetransformscaleGraphN, f : Double) -> ImagetransformscaleGraphN {
  let result = image_transform_scale_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_scale_graphn_add(a : ImagetransformscaleGraphN, b : ImagetransformscaleGraphN) -> ImagetransformscaleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_scale_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_scale_graphn_copy(s : ImagetransformscaleGraphN) -> ImagetransformscaleGraphN {
  let result = image_transform_scale_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_scale_graphn_fill(s : ImagetransformscaleGraphN, v : Double) -> ImagetransformscaleGraphN {
  let result = image_transform_scale_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_graphn_min(s : ImagetransformscaleGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_graphn_max(s : ImagetransformscaleGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_graphn_to_string(s : ImagetransformscaleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_node_make(size : Int) -> ImagetransformscaleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_node_len(s : ImagetransformscaleNode) -> Int { s.size }

pub fn image_transform_scale_node_get(s : ImagetransformscaleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_node_set(s : ImagetransformscaleNode, i : Int, v : Double) -> ImagetransformscaleNode {
  let result = image_transform_scale_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_node_sum(s : ImagetransformscaleNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_scale_node_mean(s : ImagetransformscaleNode) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_scale_node_sum(s) / s.size.to_double() }
}

pub fn image_transform_scale_node_scale(s : ImagetransformscaleNode, f : Double) -> ImagetransformscaleNode {
  let result = image_transform_scale_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_scale_node_add(a : ImagetransformscaleNode, b : ImagetransformscaleNode) -> ImagetransformscaleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_scale_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_scale_node_copy(s : ImagetransformscaleNode) -> ImagetransformscaleNode {
  let result = image_transform_scale_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_scale_node_fill(s : ImagetransformscaleNode, v : Double) -> ImagetransformscaleNode {
  let result = image_transform_scale_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_node_min(s : ImagetransformscaleNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_node_max(s : ImagetransformscaleNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_node_to_string(s : ImagetransformscaleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_edge_make(size : Int) -> ImagetransformscaleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_edge_len(s : ImagetransformscaleEdge) -> Int { s.size }

pub fn image_transform_scale_edge_get(s : ImagetransformscaleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_edge_set(s : ImagetransformscaleEdge, i : Int, v : Double) -> ImagetransformscaleEdge {
  let result = image_transform_scale_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_edge_sum(s : ImagetransformscaleEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_scale_edge_mean(s : ImagetransformscaleEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_scale_edge_sum(s) / s.size.to_double() }
}

pub fn image_transform_scale_edge_scale(s : ImagetransformscaleEdge, f : Double) -> ImagetransformscaleEdge {
  let result = image_transform_scale_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_scale_edge_add(a : ImagetransformscaleEdge, b : ImagetransformscaleEdge) -> ImagetransformscaleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_scale_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_scale_edge_copy(s : ImagetransformscaleEdge) -> ImagetransformscaleEdge {
  let result = image_transform_scale_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_scale_edge_fill(s : ImagetransformscaleEdge, v : Double) -> ImagetransformscaleEdge {
  let result = image_transform_scale_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_edge_min(s : ImagetransformscaleEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_edge_max(s : ImagetransformscaleEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_edge_to_string(s : ImagetransformscaleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscalePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_path_make(size : Int) -> ImagetransformscalePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_path_len(s : ImagetransformscalePath) -> Int { s.size }

pub fn image_transform_scale_path_get(s : ImagetransformscalePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_path_set(s : ImagetransformscalePath, i : Int, v : Double) -> ImagetransformscalePath {
  let result = image_transform_scale_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_path_sum(s : ImagetransformscalePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_scale_path_mean(s : ImagetransformscalePath) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_scale_path_sum(s) / s.size.to_double() }
}

pub fn image_transform_scale_path_scale(s : ImagetransformscalePath, f : Double) -> ImagetransformscalePath {
  let result = image_transform_scale_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_scale_path_add(a : ImagetransformscalePath, b : ImagetransformscalePath) -> ImagetransformscalePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_scale_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_scale_path_copy(s : ImagetransformscalePath) -> ImagetransformscalePath {
  let result = image_transform_scale_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_scale_path_fill(s : ImagetransformscalePath, v : Double) -> ImagetransformscalePath {
  let result = image_transform_scale_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_path_min(s : ImagetransformscalePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_path_max(s : ImagetransformscalePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_path_to_string(s : ImagetransformscalePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_cluster_make(size : Int) -> ImagetransformscaleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_cluster_len(s : ImagetransformscaleCluster) -> Int { s.size }

pub fn image_transform_scale_cluster_get(s : ImagetransformscaleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_cluster_set(s : ImagetransformscaleCluster, i : Int, v : Double) -> ImagetransformscaleCluster {
  let result = image_transform_scale_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_cluster_sum(s : ImagetransformscaleCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_scale_cluster_mean(s : ImagetransformscaleCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_scale_cluster_sum(s) / s.size.to_double() }
}

pub fn image_transform_scale_cluster_scale(s : ImagetransformscaleCluster, f : Double) -> ImagetransformscaleCluster {
  let result = image_transform_scale_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_scale_cluster_add(a : ImagetransformscaleCluster, b : ImagetransformscaleCluster) -> ImagetransformscaleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_scale_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_scale_cluster_copy(s : ImagetransformscaleCluster) -> ImagetransformscaleCluster {
  let result = image_transform_scale_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_scale_cluster_fill(s : ImagetransformscaleCluster, v : Double) -> ImagetransformscaleCluster {
  let result = image_transform_scale_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_cluster_min(s : ImagetransformscaleCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_cluster_max(s : ImagetransformscaleCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_cluster_to_string(s : ImagetransformscaleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_model_make(size : Int) -> ImagetransformscaleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_model_len(s : ImagetransformscaleModel) -> Int { s.size }

pub fn image_transform_scale_model_get(s : ImagetransformscaleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_model_set(s : ImagetransformscaleModel, i : Int, v : Double) -> ImagetransformscaleModel {
  let result = image_transform_scale_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_model_sum(s : ImagetransformscaleModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_scale_model_mean(s : ImagetransformscaleModel) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_scale_model_sum(s) / s.size.to_double() }
}

pub fn image_transform_scale_model_scale(s : ImagetransformscaleModel, f : Double) -> ImagetransformscaleModel {
  let result = image_transform_scale_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_scale_model_add(a : ImagetransformscaleModel, b : ImagetransformscaleModel) -> ImagetransformscaleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_scale_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_scale_model_copy(s : ImagetransformscaleModel) -> ImagetransformscaleModel {
  let result = image_transform_scale_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_scale_model_fill(s : ImagetransformscaleModel, v : Double) -> ImagetransformscaleModel {
  let result = image_transform_scale_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_model_min(s : ImagetransformscaleModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_model_max(s : ImagetransformscaleModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_model_to_string(s : ImagetransformscaleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_layer_make(size : Int) -> ImagetransformscaleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_layer_len(s : ImagetransformscaleLayer) -> Int { s.size }

pub fn image_transform_scale_layer_get(s : ImagetransformscaleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_layer_set(s : ImagetransformscaleLayer, i : Int, v : Double) -> ImagetransformscaleLayer {
  let result = image_transform_scale_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_layer_sum(s : ImagetransformscaleLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_scale_layer_mean(s : ImagetransformscaleLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_scale_layer_sum(s) / s.size.to_double() }
}

pub fn image_transform_scale_layer_scale(s : ImagetransformscaleLayer, f : Double) -> ImagetransformscaleLayer {
  let result = image_transform_scale_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_scale_layer_add(a : ImagetransformscaleLayer, b : ImagetransformscaleLayer) -> ImagetransformscaleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_scale_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_scale_layer_copy(s : ImagetransformscaleLayer) -> ImagetransformscaleLayer {
  let result = image_transform_scale_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_scale_layer_fill(s : ImagetransformscaleLayer, v : Double) -> ImagetransformscaleLayer {
  let result = image_transform_scale_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_layer_min(s : ImagetransformscaleLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_layer_max(s : ImagetransformscaleLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_layer_to_string(s : ImagetransformscaleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_buffer_make(size : Int) -> ImagetransformscaleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_buffer_len(s : ImagetransformscaleBuffer) -> Int { s.size }

pub fn image_transform_scale_buffer_get(s : ImagetransformscaleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_buffer_set(s : ImagetransformscaleBuffer, i : Int, v : Double) -> ImagetransformscaleBuffer {
  let result = image_transform_scale_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_buffer_sum(s : ImagetransformscaleBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_scale_buffer_mean(s : ImagetransformscaleBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_scale_buffer_sum(s) / s.size.to_double() }
}

pub fn image_transform_scale_buffer_scale(s : ImagetransformscaleBuffer, f : Double) -> ImagetransformscaleBuffer {
  let result = image_transform_scale_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_scale_buffer_add(a : ImagetransformscaleBuffer, b : ImagetransformscaleBuffer) -> ImagetransformscaleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_scale_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_scale_buffer_copy(s : ImagetransformscaleBuffer) -> ImagetransformscaleBuffer {
  let result = image_transform_scale_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_scale_buffer_fill(s : ImagetransformscaleBuffer, v : Double) -> ImagetransformscaleBuffer {
  let result = image_transform_scale_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_buffer_min(s : ImagetransformscaleBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_buffer_max(s : ImagetransformscaleBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_buffer_to_string(s : ImagetransformscaleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_cursor_make(size : Int) -> ImagetransformscaleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_cursor_len(s : ImagetransformscaleCursor) -> Int { s.size }

pub fn image_transform_scale_cursor_get(s : ImagetransformscaleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_cursor_set(s : ImagetransformscaleCursor, i : Int, v : Double) -> ImagetransformscaleCursor {
  let result = image_transform_scale_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_cursor_sum(s : ImagetransformscaleCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_scale_cursor_mean(s : ImagetransformscaleCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_scale_cursor_sum(s) / s.size.to_double() }
}

pub fn image_transform_scale_cursor_scale(s : ImagetransformscaleCursor, f : Double) -> ImagetransformscaleCursor {
  let result = image_transform_scale_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_scale_cursor_add(a : ImagetransformscaleCursor, b : ImagetransformscaleCursor) -> ImagetransformscaleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_scale_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_scale_cursor_copy(s : ImagetransformscaleCursor) -> ImagetransformscaleCursor {
  let result = image_transform_scale_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_scale_cursor_fill(s : ImagetransformscaleCursor, v : Double) -> ImagetransformscaleCursor {
  let result = image_transform_scale_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_cursor_min(s : ImagetransformscaleCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_cursor_max(s : ImagetransformscaleCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_cursor_to_string(s : ImagetransformscaleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_view_make(size : Int) -> ImagetransformscaleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_view_len(s : ImagetransformscaleView) -> Int { s.size }

pub fn image_transform_scale_view_get(s : ImagetransformscaleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_view_set(s : ImagetransformscaleView, i : Int, v : Double) -> ImagetransformscaleView {
  let result = image_transform_scale_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_view_sum(s : ImagetransformscaleView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_scale_view_mean(s : ImagetransformscaleView) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_scale_view_sum(s) / s.size.to_double() }
}

pub fn image_transform_scale_view_scale(s : ImagetransformscaleView, f : Double) -> ImagetransformscaleView {
  let result = image_transform_scale_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_scale_view_add(a : ImagetransformscaleView, b : ImagetransformscaleView) -> ImagetransformscaleView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_scale_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_scale_view_copy(s : ImagetransformscaleView) -> ImagetransformscaleView {
  let result = image_transform_scale_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_scale_view_fill(s : ImagetransformscaleView, v : Double) -> ImagetransformscaleView {
  let result = image_transform_scale_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_view_min(s : ImagetransformscaleView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_view_max(s : ImagetransformscaleView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_view_to_string(s : ImagetransformscaleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_range_make(size : Int) -> ImagetransformscaleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_range_len(s : ImagetransformscaleRange) -> Int { s.size }

pub fn image_transform_scale_range_get(s : ImagetransformscaleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_range_set(s : ImagetransformscaleRange, i : Int, v : Double) -> ImagetransformscaleRange {
  let result = image_transform_scale_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_range_sum(s : ImagetransformscaleRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_scale_range_mean(s : ImagetransformscaleRange) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_scale_range_sum(s) / s.size.to_double() }
}

pub fn image_transform_scale_range_scale(s : ImagetransformscaleRange, f : Double) -> ImagetransformscaleRange {
  let result = image_transform_scale_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_scale_range_add(a : ImagetransformscaleRange, b : ImagetransformscaleRange) -> ImagetransformscaleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_scale_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_scale_range_copy(s : ImagetransformscaleRange) -> ImagetransformscaleRange {
  let result = image_transform_scale_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_scale_range_fill(s : ImagetransformscaleRange, v : Double) -> ImagetransformscaleRange {
  let result = image_transform_scale_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_range_min(s : ImagetransformscaleRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_range_max(s : ImagetransformscaleRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_range_to_string(s : ImagetransformscaleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformscaleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_scale_slice_make(size : Int) -> ImagetransformscaleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_scale_slice_len(s : ImagetransformscaleSlice) -> Int { s.size }

pub fn image_transform_scale_slice_get(s : ImagetransformscaleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_scale_slice_set(s : ImagetransformscaleSlice, i : Int, v : Double) -> ImagetransformscaleSlice {
  let result = image_transform_scale_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_slice_sum(s : ImagetransformscaleSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_transform_scale_slice_mean(s : ImagetransformscaleSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_transform_scale_slice_sum(s) / s.size.to_double() }
}

pub fn image_transform_scale_slice_scale(s : ImagetransformscaleSlice, f : Double) -> ImagetransformscaleSlice {
  let result = image_transform_scale_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_scale_slice_add(a : ImagetransformscaleSlice, b : ImagetransformscaleSlice) -> ImagetransformscaleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_scale_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_scale_slice_copy(s : ImagetransformscaleSlice) -> ImagetransformscaleSlice {
  let result = image_transform_scale_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_scale_slice_fill(s : ImagetransformscaleSlice, v : Double) -> ImagetransformscaleSlice {
  let result = image_transform_scale_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_scale_slice_min(s : ImagetransformscaleSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_slice_max(s : ImagetransformscaleSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_transform_scale_slice_to_string(s : ImagetransformscaleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

