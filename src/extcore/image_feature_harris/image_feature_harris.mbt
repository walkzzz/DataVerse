///===
/// extcore/image_feature_harris

pub(all) struct ImagefeatureharrisPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_harris_make_point(x : Double, y : Double) -> ImagefeatureharrisPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_harris_make_point3(x : Double, y : Double, z : Double) -> ImagefeatureharrisPoint {
  { x, y, z, label: 0 }
}

pub fn image_feature_harris_point_x(pt : ImagefeatureharrisPoint) -> Double { pt.x }

pub fn image_feature_harris_point_y(pt : ImagefeatureharrisPoint) -> Double { pt.y }

pub fn image_feature_harris_point_z(pt : ImagefeatureharrisPoint) -> Double { pt.z }

pub fn image_feature_harris_point_label(pt : ImagefeatureharrisPoint) -> Int { pt.label }

pub fn image_feature_harris_point_dist(a : ImagefeatureharrisPoint, b : ImagefeatureharrisPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_feature_harris_point_add(a : ImagefeatureharrisPoint, b : ImagefeatureharrisPoint) -> ImagefeatureharrisPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_feature_harris_point_sub(a : ImagefeatureharrisPoint, b : ImagefeatureharrisPoint) -> ImagefeatureharrisPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_feature_harris_point_scale(pt : ImagefeatureharrisPoint, s : Double) -> ImagefeatureharrisPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_feature_harris_point_dot(a : ImagefeatureharrisPoint, b : ImagefeatureharrisPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_feature_harris_point_cross(a : ImagefeatureharrisPoint, b : ImagefeatureharrisPoint) -> ImagefeatureharrisPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_feature_harris_point_norm(pt : ImagefeatureharrisPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_feature_harris_point_normalize(pt : ImagefeatureharrisPoint) -> ImagefeatureharrisPoint {
  let n = image_feature_harris_point_norm(pt)
  if n < 0.0000001 { pt } else { image_feature_harris_point_scale(pt, 1.0 / n) }
}

pub fn image_feature_harris_point_negate(pt : ImagefeatureharrisPoint) -> ImagefeatureharrisPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_feature_harris_point_mid(a : ImagefeatureharrisPoint, b : ImagefeatureharrisPoint) -> ImagefeatureharrisPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_feature_harris_point_lerp(a : ImagefeatureharrisPoint, b : ImagefeatureharrisPoint, t : Double) -> ImagefeatureharrisPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_feature_harris_point_to_string(pt : ImagefeatureharrisPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefeatureharrisSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_harris_make_series(vals : Array[Double], name : String) -> ImagefeatureharrisSeries {
  { vals, name, meta: 0 }
}

pub fn image_feature_harris_series_len(s : ImagefeatureharrisSeries) -> Int { s.vals.length() }

pub fn image_feature_harris_series_sum(s : ImagefeatureharrisSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_feature_harris_series_mean(s : ImagefeatureharrisSeries) -> Double {
  let n = image_feature_harris_series_len(s)
  if n == 0 { 0.0 } else { image_feature_harris_series_sum(s) / n.to_double() }
}

pub fn image_feature_harris_series_min(s : ImagefeatureharrisSeries) -> Double {
  let n = image_feature_harris_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_feature_harris_series_max(s : ImagefeatureharrisSeries) -> Double {
  let n = image_feature_harris_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_feature_harris_series_range(s : ImagefeatureharrisSeries) -> Double {
  image_feature_harris_series_max(s) - image_feature_harris_series_min(s)
}

pub fn image_feature_harris_series_var(s : ImagefeatureharrisSeries) -> Double {
  let n = image_feature_harris_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_feature_harris_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_feature_harris_series_std(s : ImagefeatureharrisSeries) -> Double { @_common.sqrt(image_feature_harris_series_var(s)) }

pub fn image_feature_harris_series_median(s : ImagefeatureharrisSeries) -> Double {
  let n = image_feature_harris_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_feature_harris_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_feature_harris_series_scale(s : ImagefeatureharrisSeries, f : Double) -> ImagefeatureharrisSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_feature_harris_series_add(a : ImagefeatureharrisSeries, b : ImagefeatureharrisSeries) -> ImagefeatureharrisSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_feature_harris_series_sub(a : ImagefeatureharrisSeries, b : ImagefeatureharrisSeries) -> ImagefeatureharrisSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_feature_harris_series_normalize(s : ImagefeatureharrisSeries) -> ImagefeatureharrisSeries {
  let mn = image_feature_harris_series_min(s)
  let mx = image_feature_harris_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_feature_harris_series_cumsum(s : ImagefeatureharrisSeries) -> ImagefeatureharrisSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_feature_harris_series_to_string(s : ImagefeatureharrisSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeatureharrisMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_harris_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeatureharrisMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_harris_matrix_identity(n : Int) -> ImagefeatureharrisMatrix {
  let m = image_feature_harris_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_feature_harris_matrix_get(m : ImagefeatureharrisMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_feature_harris_matrix_transpose(m : ImagefeatureharrisMatrix) -> ImagefeatureharrisMatrix {
  let result = image_feature_harris_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_feature_harris_matrix_add(a : ImagefeatureharrisMatrix, b : ImagefeatureharrisMatrix) -> ImagefeatureharrisMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_feature_harris_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_feature_harris_matrix_scale(m : ImagefeatureharrisMatrix, s : Double) -> ImagefeatureharrisMatrix {
  let result = image_feature_harris_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_feature_harris_matrix_multiply(a : ImagefeatureharrisMatrix, b : ImagefeatureharrisMatrix) -> ImagefeatureharrisMatrix {
  if a.cols != b.rows { return image_feature_harris_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_feature_harris_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_feature_harris_matrix_trace(m : ImagefeatureharrisMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_feature_harris_matrix_det(m : ImagefeatureharrisMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_feature_harris_matrix_norm(m : ImagefeatureharrisMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_feature_harris_matrix_to_string(m : ImagefeatureharrisMatrix) -> String {
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

pub(all) struct ImagefeatureharrisVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_harris_make_vector(comps : Array[Double]) -> ImagefeatureharrisVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_harris_vector_zero(dim : Int) -> ImagefeatureharrisVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_feature_harris_vector_add(a : ImagefeatureharrisVector, b : ImagefeatureharrisVector) -> ImagefeatureharrisVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_harris_vector_sub(a : ImagefeatureharrisVector, b : ImagefeatureharrisVector) -> ImagefeatureharrisVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_harris_vector_scale(v : ImagefeatureharrisVector, s : Double) -> ImagefeatureharrisVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_feature_harris_vector_dot(a : ImagefeatureharrisVector, b : ImagefeatureharrisVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_feature_harris_vector_norm(v : ImagefeatureharrisVector) -> Double { @_common.sqrt(image_feature_harris_vector_dot(v, v)) }

pub fn image_feature_harris_vector_normalize(v : ImagefeatureharrisVector) -> ImagefeatureharrisVector {
  let n = image_feature_harris_vector_norm(v)
  if n < 0.0000001 { v } else { image_feature_harris_vector_scale(v, 1.0 / n) }
}

pub fn image_feature_harris_vector_dist(a : ImagefeatureharrisVector, b : ImagefeatureharrisVector) -> Double {
  image_feature_harris_vector_norm(image_feature_harris_vector_sub(a, b))
}

pub fn image_feature_harris_vector_to_string(v : ImagefeatureharrisVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_harris_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_feature_harris_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_feature_harris_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_feature_harris_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_feature_harris_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_feature_harris_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_feature_harris_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_feature_harris_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_feature_harris_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_feature_harris_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_feature_harris_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_feature_harris_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_feature_harris_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_feature_harris_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_feature_harris_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_feature_harris_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_feature_harris_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_feature_harris_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_feature_harris_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_feature_harris_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_feature_harris_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_feature_harris_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_feature_harris_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_feature_harris_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_feature_harris_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_feature_harris_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_feature_harris_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_feature_harris_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_feature_harris_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefeatureharrisFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_frame_make(size : Int) -> ImagefeatureharrisFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_frame_len(s : ImagefeatureharrisFrame) -> Int { s.size }

pub fn image_feature_harris_frame_get(s : ImagefeatureharrisFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_frame_set(s : ImagefeatureharrisFrame, i : Int, v : Double) -> ImagefeatureharrisFrame {
  let result = image_feature_harris_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_frame_sum(s : ImagefeatureharrisFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_harris_frame_mean(s : ImagefeatureharrisFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_harris_frame_sum(s) / s.size.to_double() }
}

pub fn image_feature_harris_frame_scale(s : ImagefeatureharrisFrame, f : Double) -> ImagefeatureharrisFrame {
  let result = image_feature_harris_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_harris_frame_add(a : ImagefeatureharrisFrame, b : ImagefeatureharrisFrame) -> ImagefeatureharrisFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_harris_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_harris_frame_copy(s : ImagefeatureharrisFrame) -> ImagefeatureharrisFrame {
  let result = image_feature_harris_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_harris_frame_fill(s : ImagefeatureharrisFrame, v : Double) -> ImagefeatureharrisFrame {
  let result = image_feature_harris_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_frame_min(s : ImagefeatureharrisFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_frame_max(s : ImagefeatureharrisFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_frame_to_string(s : ImagefeatureharrisFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_table_make(size : Int) -> ImagefeatureharrisTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_table_len(s : ImagefeatureharrisTable) -> Int { s.size }

pub fn image_feature_harris_table_get(s : ImagefeatureharrisTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_table_set(s : ImagefeatureharrisTable, i : Int, v : Double) -> ImagefeatureharrisTable {
  let result = image_feature_harris_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_table_sum(s : ImagefeatureharrisTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_harris_table_mean(s : ImagefeatureharrisTable) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_harris_table_sum(s) / s.size.to_double() }
}

pub fn image_feature_harris_table_scale(s : ImagefeatureharrisTable, f : Double) -> ImagefeatureharrisTable {
  let result = image_feature_harris_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_harris_table_add(a : ImagefeatureharrisTable, b : ImagefeatureharrisTable) -> ImagefeatureharrisTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_harris_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_harris_table_copy(s : ImagefeatureharrisTable) -> ImagefeatureharrisTable {
  let result = image_feature_harris_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_harris_table_fill(s : ImagefeatureharrisTable, v : Double) -> ImagefeatureharrisTable {
  let result = image_feature_harris_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_table_min(s : ImagefeatureharrisTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_table_max(s : ImagefeatureharrisTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_table_to_string(s : ImagefeatureharrisTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_graphn_make(size : Int) -> ImagefeatureharrisGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_graphn_len(s : ImagefeatureharrisGraphN) -> Int { s.size }

pub fn image_feature_harris_graphn_get(s : ImagefeatureharrisGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_graphn_set(s : ImagefeatureharrisGraphN, i : Int, v : Double) -> ImagefeatureharrisGraphN {
  let result = image_feature_harris_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_graphn_sum(s : ImagefeatureharrisGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_harris_graphn_mean(s : ImagefeatureharrisGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_harris_graphn_sum(s) / s.size.to_double() }
}

pub fn image_feature_harris_graphn_scale(s : ImagefeatureharrisGraphN, f : Double) -> ImagefeatureharrisGraphN {
  let result = image_feature_harris_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_harris_graphn_add(a : ImagefeatureharrisGraphN, b : ImagefeatureharrisGraphN) -> ImagefeatureharrisGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_harris_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_harris_graphn_copy(s : ImagefeatureharrisGraphN) -> ImagefeatureharrisGraphN {
  let result = image_feature_harris_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_harris_graphn_fill(s : ImagefeatureharrisGraphN, v : Double) -> ImagefeatureharrisGraphN {
  let result = image_feature_harris_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_graphn_min(s : ImagefeatureharrisGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_graphn_max(s : ImagefeatureharrisGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_graphn_to_string(s : ImagefeatureharrisGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_node_make(size : Int) -> ImagefeatureharrisNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_node_len(s : ImagefeatureharrisNode) -> Int { s.size }

pub fn image_feature_harris_node_get(s : ImagefeatureharrisNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_node_set(s : ImagefeatureharrisNode, i : Int, v : Double) -> ImagefeatureharrisNode {
  let result = image_feature_harris_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_node_sum(s : ImagefeatureharrisNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_harris_node_mean(s : ImagefeatureharrisNode) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_harris_node_sum(s) / s.size.to_double() }
}

pub fn image_feature_harris_node_scale(s : ImagefeatureharrisNode, f : Double) -> ImagefeatureharrisNode {
  let result = image_feature_harris_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_harris_node_add(a : ImagefeatureharrisNode, b : ImagefeatureharrisNode) -> ImagefeatureharrisNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_harris_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_harris_node_copy(s : ImagefeatureharrisNode) -> ImagefeatureharrisNode {
  let result = image_feature_harris_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_harris_node_fill(s : ImagefeatureharrisNode, v : Double) -> ImagefeatureharrisNode {
  let result = image_feature_harris_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_node_min(s : ImagefeatureharrisNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_node_max(s : ImagefeatureharrisNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_node_to_string(s : ImagefeatureharrisNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_edge_make(size : Int) -> ImagefeatureharrisEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_edge_len(s : ImagefeatureharrisEdge) -> Int { s.size }

pub fn image_feature_harris_edge_get(s : ImagefeatureharrisEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_edge_set(s : ImagefeatureharrisEdge, i : Int, v : Double) -> ImagefeatureharrisEdge {
  let result = image_feature_harris_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_edge_sum(s : ImagefeatureharrisEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_harris_edge_mean(s : ImagefeatureharrisEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_harris_edge_sum(s) / s.size.to_double() }
}

pub fn image_feature_harris_edge_scale(s : ImagefeatureharrisEdge, f : Double) -> ImagefeatureharrisEdge {
  let result = image_feature_harris_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_harris_edge_add(a : ImagefeatureharrisEdge, b : ImagefeatureharrisEdge) -> ImagefeatureharrisEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_harris_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_harris_edge_copy(s : ImagefeatureharrisEdge) -> ImagefeatureharrisEdge {
  let result = image_feature_harris_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_harris_edge_fill(s : ImagefeatureharrisEdge, v : Double) -> ImagefeatureharrisEdge {
  let result = image_feature_harris_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_edge_min(s : ImagefeatureharrisEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_edge_max(s : ImagefeatureharrisEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_edge_to_string(s : ImagefeatureharrisEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_path_make(size : Int) -> ImagefeatureharrisPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_path_len(s : ImagefeatureharrisPath) -> Int { s.size }

pub fn image_feature_harris_path_get(s : ImagefeatureharrisPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_path_set(s : ImagefeatureharrisPath, i : Int, v : Double) -> ImagefeatureharrisPath {
  let result = image_feature_harris_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_path_sum(s : ImagefeatureharrisPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_harris_path_mean(s : ImagefeatureharrisPath) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_harris_path_sum(s) / s.size.to_double() }
}

pub fn image_feature_harris_path_scale(s : ImagefeatureharrisPath, f : Double) -> ImagefeatureharrisPath {
  let result = image_feature_harris_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_harris_path_add(a : ImagefeatureharrisPath, b : ImagefeatureharrisPath) -> ImagefeatureharrisPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_harris_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_harris_path_copy(s : ImagefeatureharrisPath) -> ImagefeatureharrisPath {
  let result = image_feature_harris_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_harris_path_fill(s : ImagefeatureharrisPath, v : Double) -> ImagefeatureharrisPath {
  let result = image_feature_harris_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_path_min(s : ImagefeatureharrisPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_path_max(s : ImagefeatureharrisPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_path_to_string(s : ImagefeatureharrisPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_cluster_make(size : Int) -> ImagefeatureharrisCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_cluster_len(s : ImagefeatureharrisCluster) -> Int { s.size }

pub fn image_feature_harris_cluster_get(s : ImagefeatureharrisCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_cluster_set(s : ImagefeatureharrisCluster, i : Int, v : Double) -> ImagefeatureharrisCluster {
  let result = image_feature_harris_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_cluster_sum(s : ImagefeatureharrisCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_harris_cluster_mean(s : ImagefeatureharrisCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_harris_cluster_sum(s) / s.size.to_double() }
}

pub fn image_feature_harris_cluster_scale(s : ImagefeatureharrisCluster, f : Double) -> ImagefeatureharrisCluster {
  let result = image_feature_harris_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_harris_cluster_add(a : ImagefeatureharrisCluster, b : ImagefeatureharrisCluster) -> ImagefeatureharrisCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_harris_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_harris_cluster_copy(s : ImagefeatureharrisCluster) -> ImagefeatureharrisCluster {
  let result = image_feature_harris_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_harris_cluster_fill(s : ImagefeatureharrisCluster, v : Double) -> ImagefeatureharrisCluster {
  let result = image_feature_harris_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_cluster_min(s : ImagefeatureharrisCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_cluster_max(s : ImagefeatureharrisCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_cluster_to_string(s : ImagefeatureharrisCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_model_make(size : Int) -> ImagefeatureharrisModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_model_len(s : ImagefeatureharrisModel) -> Int { s.size }

pub fn image_feature_harris_model_get(s : ImagefeatureharrisModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_model_set(s : ImagefeatureharrisModel, i : Int, v : Double) -> ImagefeatureharrisModel {
  let result = image_feature_harris_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_model_sum(s : ImagefeatureharrisModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_harris_model_mean(s : ImagefeatureharrisModel) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_harris_model_sum(s) / s.size.to_double() }
}

pub fn image_feature_harris_model_scale(s : ImagefeatureharrisModel, f : Double) -> ImagefeatureharrisModel {
  let result = image_feature_harris_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_harris_model_add(a : ImagefeatureharrisModel, b : ImagefeatureharrisModel) -> ImagefeatureharrisModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_harris_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_harris_model_copy(s : ImagefeatureharrisModel) -> ImagefeatureharrisModel {
  let result = image_feature_harris_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_harris_model_fill(s : ImagefeatureharrisModel, v : Double) -> ImagefeatureharrisModel {
  let result = image_feature_harris_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_model_min(s : ImagefeatureharrisModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_model_max(s : ImagefeatureharrisModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_model_to_string(s : ImagefeatureharrisModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_layer_make(size : Int) -> ImagefeatureharrisLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_layer_len(s : ImagefeatureharrisLayer) -> Int { s.size }

pub fn image_feature_harris_layer_get(s : ImagefeatureharrisLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_layer_set(s : ImagefeatureharrisLayer, i : Int, v : Double) -> ImagefeatureharrisLayer {
  let result = image_feature_harris_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_layer_sum(s : ImagefeatureharrisLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_harris_layer_mean(s : ImagefeatureharrisLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_harris_layer_sum(s) / s.size.to_double() }
}

pub fn image_feature_harris_layer_scale(s : ImagefeatureharrisLayer, f : Double) -> ImagefeatureharrisLayer {
  let result = image_feature_harris_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_harris_layer_add(a : ImagefeatureharrisLayer, b : ImagefeatureharrisLayer) -> ImagefeatureharrisLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_harris_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_harris_layer_copy(s : ImagefeatureharrisLayer) -> ImagefeatureharrisLayer {
  let result = image_feature_harris_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_harris_layer_fill(s : ImagefeatureharrisLayer, v : Double) -> ImagefeatureharrisLayer {
  let result = image_feature_harris_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_layer_min(s : ImagefeatureharrisLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_layer_max(s : ImagefeatureharrisLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_layer_to_string(s : ImagefeatureharrisLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_buffer_make(size : Int) -> ImagefeatureharrisBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_buffer_len(s : ImagefeatureharrisBuffer) -> Int { s.size }

pub fn image_feature_harris_buffer_get(s : ImagefeatureharrisBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_buffer_set(s : ImagefeatureharrisBuffer, i : Int, v : Double) -> ImagefeatureharrisBuffer {
  let result = image_feature_harris_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_buffer_sum(s : ImagefeatureharrisBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_harris_buffer_mean(s : ImagefeatureharrisBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_harris_buffer_sum(s) / s.size.to_double() }
}

pub fn image_feature_harris_buffer_scale(s : ImagefeatureharrisBuffer, f : Double) -> ImagefeatureharrisBuffer {
  let result = image_feature_harris_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_harris_buffer_add(a : ImagefeatureharrisBuffer, b : ImagefeatureharrisBuffer) -> ImagefeatureharrisBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_harris_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_harris_buffer_copy(s : ImagefeatureharrisBuffer) -> ImagefeatureharrisBuffer {
  let result = image_feature_harris_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_harris_buffer_fill(s : ImagefeatureharrisBuffer, v : Double) -> ImagefeatureharrisBuffer {
  let result = image_feature_harris_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_buffer_min(s : ImagefeatureharrisBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_buffer_max(s : ImagefeatureharrisBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_buffer_to_string(s : ImagefeatureharrisBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_cursor_make(size : Int) -> ImagefeatureharrisCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_cursor_len(s : ImagefeatureharrisCursor) -> Int { s.size }

pub fn image_feature_harris_cursor_get(s : ImagefeatureharrisCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_cursor_set(s : ImagefeatureharrisCursor, i : Int, v : Double) -> ImagefeatureharrisCursor {
  let result = image_feature_harris_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_cursor_sum(s : ImagefeatureharrisCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_harris_cursor_mean(s : ImagefeatureharrisCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_harris_cursor_sum(s) / s.size.to_double() }
}

pub fn image_feature_harris_cursor_scale(s : ImagefeatureharrisCursor, f : Double) -> ImagefeatureharrisCursor {
  let result = image_feature_harris_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_harris_cursor_add(a : ImagefeatureharrisCursor, b : ImagefeatureharrisCursor) -> ImagefeatureharrisCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_harris_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_harris_cursor_copy(s : ImagefeatureharrisCursor) -> ImagefeatureharrisCursor {
  let result = image_feature_harris_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_harris_cursor_fill(s : ImagefeatureharrisCursor, v : Double) -> ImagefeatureharrisCursor {
  let result = image_feature_harris_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_cursor_min(s : ImagefeatureharrisCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_cursor_max(s : ImagefeatureharrisCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_cursor_to_string(s : ImagefeatureharrisCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_view_make(size : Int) -> ImagefeatureharrisView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_view_len(s : ImagefeatureharrisView) -> Int { s.size }

pub fn image_feature_harris_view_get(s : ImagefeatureharrisView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_view_set(s : ImagefeatureharrisView, i : Int, v : Double) -> ImagefeatureharrisView {
  let result = image_feature_harris_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_view_sum(s : ImagefeatureharrisView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_harris_view_mean(s : ImagefeatureharrisView) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_harris_view_sum(s) / s.size.to_double() }
}

pub fn image_feature_harris_view_scale(s : ImagefeatureharrisView, f : Double) -> ImagefeatureharrisView {
  let result = image_feature_harris_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_harris_view_add(a : ImagefeatureharrisView, b : ImagefeatureharrisView) -> ImagefeatureharrisView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_harris_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_harris_view_copy(s : ImagefeatureharrisView) -> ImagefeatureharrisView {
  let result = image_feature_harris_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_harris_view_fill(s : ImagefeatureharrisView, v : Double) -> ImagefeatureharrisView {
  let result = image_feature_harris_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_view_min(s : ImagefeatureharrisView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_view_max(s : ImagefeatureharrisView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_view_to_string(s : ImagefeatureharrisView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_range_make(size : Int) -> ImagefeatureharrisRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_range_len(s : ImagefeatureharrisRange) -> Int { s.size }

pub fn image_feature_harris_range_get(s : ImagefeatureharrisRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_range_set(s : ImagefeatureharrisRange, i : Int, v : Double) -> ImagefeatureharrisRange {
  let result = image_feature_harris_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_range_sum(s : ImagefeatureharrisRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_harris_range_mean(s : ImagefeatureharrisRange) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_harris_range_sum(s) / s.size.to_double() }
}

pub fn image_feature_harris_range_scale(s : ImagefeatureharrisRange, f : Double) -> ImagefeatureharrisRange {
  let result = image_feature_harris_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_harris_range_add(a : ImagefeatureharrisRange, b : ImagefeatureharrisRange) -> ImagefeatureharrisRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_harris_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_harris_range_copy(s : ImagefeatureharrisRange) -> ImagefeatureharrisRange {
  let result = image_feature_harris_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_harris_range_fill(s : ImagefeatureharrisRange, v : Double) -> ImagefeatureharrisRange {
  let result = image_feature_harris_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_range_min(s : ImagefeatureharrisRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_range_max(s : ImagefeatureharrisRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_range_to_string(s : ImagefeatureharrisRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureharrisSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_harris_slice_make(size : Int) -> ImagefeatureharrisSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_harris_slice_len(s : ImagefeatureharrisSlice) -> Int { s.size }

pub fn image_feature_harris_slice_get(s : ImagefeatureharrisSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_harris_slice_set(s : ImagefeatureharrisSlice, i : Int, v : Double) -> ImagefeatureharrisSlice {
  let result = image_feature_harris_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_slice_sum(s : ImagefeatureharrisSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_harris_slice_mean(s : ImagefeatureharrisSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_harris_slice_sum(s) / s.size.to_double() }
}

pub fn image_feature_harris_slice_scale(s : ImagefeatureharrisSlice, f : Double) -> ImagefeatureharrisSlice {
  let result = image_feature_harris_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_harris_slice_add(a : ImagefeatureharrisSlice, b : ImagefeatureharrisSlice) -> ImagefeatureharrisSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_harris_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_harris_slice_copy(s : ImagefeatureharrisSlice) -> ImagefeatureharrisSlice {
  let result = image_feature_harris_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_harris_slice_fill(s : ImagefeatureharrisSlice, v : Double) -> ImagefeatureharrisSlice {
  let result = image_feature_harris_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_harris_slice_min(s : ImagefeatureharrisSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_slice_max(s : ImagefeatureharrisSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_harris_slice_to_string(s : ImagefeatureharrisSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

