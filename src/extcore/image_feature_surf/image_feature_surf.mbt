///===
/// extcore/image_feature_surf

pub(all) struct ImagefeaturesurfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_surf_make_point(x : Double, y : Double) -> ImagefeaturesurfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_surf_make_point3(x : Double, y : Double, z : Double) -> ImagefeaturesurfPoint {
  { x, y, z, label: 0 }
}

pub fn image_feature_surf_point_x(pt : ImagefeaturesurfPoint) -> Double { pt.x }

pub fn image_feature_surf_point_y(pt : ImagefeaturesurfPoint) -> Double { pt.y }

pub fn image_feature_surf_point_z(pt : ImagefeaturesurfPoint) -> Double { pt.z }

pub fn image_feature_surf_point_label(pt : ImagefeaturesurfPoint) -> Int { pt.label }

pub fn image_feature_surf_point_dist(a : ImagefeaturesurfPoint, b : ImagefeaturesurfPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_feature_surf_point_add(a : ImagefeaturesurfPoint, b : ImagefeaturesurfPoint) -> ImagefeaturesurfPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_feature_surf_point_sub(a : ImagefeaturesurfPoint, b : ImagefeaturesurfPoint) -> ImagefeaturesurfPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_feature_surf_point_scale(pt : ImagefeaturesurfPoint, s : Double) -> ImagefeaturesurfPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_feature_surf_point_dot(a : ImagefeaturesurfPoint, b : ImagefeaturesurfPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_feature_surf_point_cross(a : ImagefeaturesurfPoint, b : ImagefeaturesurfPoint) -> ImagefeaturesurfPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_feature_surf_point_norm(pt : ImagefeaturesurfPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_feature_surf_point_normalize(pt : ImagefeaturesurfPoint) -> ImagefeaturesurfPoint {
  let n = image_feature_surf_point_norm(pt)
  if n < 0.0000001 { pt } else { image_feature_surf_point_scale(pt, 1.0 / n) }
}

pub fn image_feature_surf_point_negate(pt : ImagefeaturesurfPoint) -> ImagefeaturesurfPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_feature_surf_point_mid(a : ImagefeaturesurfPoint, b : ImagefeaturesurfPoint) -> ImagefeaturesurfPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_feature_surf_point_lerp(a : ImagefeaturesurfPoint, b : ImagefeaturesurfPoint, t : Double) -> ImagefeaturesurfPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_feature_surf_point_to_string(pt : ImagefeaturesurfPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefeaturesurfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_surf_make_series(vals : Array[Double], name : String) -> ImagefeaturesurfSeries {
  { vals, name, meta: 0 }
}

pub fn image_feature_surf_series_len(s : ImagefeaturesurfSeries) -> Int { s.vals.length() }

pub fn image_feature_surf_series_sum(s : ImagefeaturesurfSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_feature_surf_series_mean(s : ImagefeaturesurfSeries) -> Double {
  let n = image_feature_surf_series_len(s)
  if n == 0 { 0.0 } else { image_feature_surf_series_sum(s) / n.to_double() }
}

pub fn image_feature_surf_series_min(s : ImagefeaturesurfSeries) -> Double {
  let n = image_feature_surf_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_feature_surf_series_max(s : ImagefeaturesurfSeries) -> Double {
  let n = image_feature_surf_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_feature_surf_series_range(s : ImagefeaturesurfSeries) -> Double {
  image_feature_surf_series_max(s) - image_feature_surf_series_min(s)
}

pub fn image_feature_surf_series_var(s : ImagefeaturesurfSeries) -> Double {
  let n = image_feature_surf_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_feature_surf_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_feature_surf_series_std(s : ImagefeaturesurfSeries) -> Double { @_common.sqrt(image_feature_surf_series_var(s)) }

pub fn image_feature_surf_series_median(s : ImagefeaturesurfSeries) -> Double {
  let n = image_feature_surf_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_feature_surf_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_feature_surf_series_scale(s : ImagefeaturesurfSeries, f : Double) -> ImagefeaturesurfSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_feature_surf_series_add(a : ImagefeaturesurfSeries, b : ImagefeaturesurfSeries) -> ImagefeaturesurfSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_feature_surf_series_sub(a : ImagefeaturesurfSeries, b : ImagefeaturesurfSeries) -> ImagefeaturesurfSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_feature_surf_series_normalize(s : ImagefeaturesurfSeries) -> ImagefeaturesurfSeries {
  let mn = image_feature_surf_series_min(s)
  let mx = image_feature_surf_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_feature_surf_series_cumsum(s : ImagefeaturesurfSeries) -> ImagefeaturesurfSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_feature_surf_series_to_string(s : ImagefeaturesurfSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturesurfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_surf_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeaturesurfMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_surf_matrix_identity(n : Int) -> ImagefeaturesurfMatrix {
  let m = image_feature_surf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_feature_surf_matrix_get(m : ImagefeaturesurfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_feature_surf_matrix_transpose(m : ImagefeaturesurfMatrix) -> ImagefeaturesurfMatrix {
  let result = image_feature_surf_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_feature_surf_matrix_add(a : ImagefeaturesurfMatrix, b : ImagefeaturesurfMatrix) -> ImagefeaturesurfMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_feature_surf_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_feature_surf_matrix_scale(m : ImagefeaturesurfMatrix, s : Double) -> ImagefeaturesurfMatrix {
  let result = image_feature_surf_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_feature_surf_matrix_multiply(a : ImagefeaturesurfMatrix, b : ImagefeaturesurfMatrix) -> ImagefeaturesurfMatrix {
  if a.cols != b.rows { return image_feature_surf_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_feature_surf_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_feature_surf_matrix_trace(m : ImagefeaturesurfMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_feature_surf_matrix_det(m : ImagefeaturesurfMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_feature_surf_matrix_norm(m : ImagefeaturesurfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_feature_surf_matrix_to_string(m : ImagefeaturesurfMatrix) -> String {
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

pub(all) struct ImagefeaturesurfVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_surf_make_vector(comps : Array[Double]) -> ImagefeaturesurfVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_surf_vector_zero(dim : Int) -> ImagefeaturesurfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_feature_surf_vector_add(a : ImagefeaturesurfVector, b : ImagefeaturesurfVector) -> ImagefeaturesurfVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_surf_vector_sub(a : ImagefeaturesurfVector, b : ImagefeaturesurfVector) -> ImagefeaturesurfVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_surf_vector_scale(v : ImagefeaturesurfVector, s : Double) -> ImagefeaturesurfVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_feature_surf_vector_dot(a : ImagefeaturesurfVector, b : ImagefeaturesurfVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_feature_surf_vector_norm(v : ImagefeaturesurfVector) -> Double { @_common.sqrt(image_feature_surf_vector_dot(v, v)) }

pub fn image_feature_surf_vector_normalize(v : ImagefeaturesurfVector) -> ImagefeaturesurfVector {
  let n = image_feature_surf_vector_norm(v)
  if n < 0.0000001 { v } else { image_feature_surf_vector_scale(v, 1.0 / n) }
}

pub fn image_feature_surf_vector_dist(a : ImagefeaturesurfVector, b : ImagefeaturesurfVector) -> Double {
  image_feature_surf_vector_norm(image_feature_surf_vector_sub(a, b))
}

pub fn image_feature_surf_vector_to_string(v : ImagefeaturesurfVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_surf_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_feature_surf_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_feature_surf_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_feature_surf_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_feature_surf_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_feature_surf_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_feature_surf_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_feature_surf_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_feature_surf_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_feature_surf_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_feature_surf_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_feature_surf_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_feature_surf_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_feature_surf_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_feature_surf_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_feature_surf_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_feature_surf_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_feature_surf_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_feature_surf_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_feature_surf_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_feature_surf_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_feature_surf_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_feature_surf_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_feature_surf_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_feature_surf_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_feature_surf_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_feature_surf_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_feature_surf_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_feature_surf_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefeaturesurfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_frame_make(size : Int) -> ImagefeaturesurfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_frame_len(s : ImagefeaturesurfFrame) -> Int { s.size }

pub fn image_feature_surf_frame_get(s : ImagefeaturesurfFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_frame_set(s : ImagefeaturesurfFrame, i : Int, v : Double) -> ImagefeaturesurfFrame {
  let result = image_feature_surf_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_frame_sum(s : ImagefeaturesurfFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_surf_frame_mean(s : ImagefeaturesurfFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_surf_frame_sum(s) / s.size.to_double() }
}

pub fn image_feature_surf_frame_scale(s : ImagefeaturesurfFrame, f : Double) -> ImagefeaturesurfFrame {
  let result = image_feature_surf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_surf_frame_add(a : ImagefeaturesurfFrame, b : ImagefeaturesurfFrame) -> ImagefeaturesurfFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_surf_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_surf_frame_copy(s : ImagefeaturesurfFrame) -> ImagefeaturesurfFrame {
  let result = image_feature_surf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_surf_frame_fill(s : ImagefeaturesurfFrame, v : Double) -> ImagefeaturesurfFrame {
  let result = image_feature_surf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_frame_min(s : ImagefeaturesurfFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_frame_max(s : ImagefeaturesurfFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_frame_to_string(s : ImagefeaturesurfFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_table_make(size : Int) -> ImagefeaturesurfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_table_len(s : ImagefeaturesurfTable) -> Int { s.size }

pub fn image_feature_surf_table_get(s : ImagefeaturesurfTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_table_set(s : ImagefeaturesurfTable, i : Int, v : Double) -> ImagefeaturesurfTable {
  let result = image_feature_surf_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_table_sum(s : ImagefeaturesurfTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_surf_table_mean(s : ImagefeaturesurfTable) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_surf_table_sum(s) / s.size.to_double() }
}

pub fn image_feature_surf_table_scale(s : ImagefeaturesurfTable, f : Double) -> ImagefeaturesurfTable {
  let result = image_feature_surf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_surf_table_add(a : ImagefeaturesurfTable, b : ImagefeaturesurfTable) -> ImagefeaturesurfTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_surf_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_surf_table_copy(s : ImagefeaturesurfTable) -> ImagefeaturesurfTable {
  let result = image_feature_surf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_surf_table_fill(s : ImagefeaturesurfTable, v : Double) -> ImagefeaturesurfTable {
  let result = image_feature_surf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_table_min(s : ImagefeaturesurfTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_table_max(s : ImagefeaturesurfTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_table_to_string(s : ImagefeaturesurfTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_graphn_make(size : Int) -> ImagefeaturesurfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_graphn_len(s : ImagefeaturesurfGraphN) -> Int { s.size }

pub fn image_feature_surf_graphn_get(s : ImagefeaturesurfGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_graphn_set(s : ImagefeaturesurfGraphN, i : Int, v : Double) -> ImagefeaturesurfGraphN {
  let result = image_feature_surf_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_graphn_sum(s : ImagefeaturesurfGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_surf_graphn_mean(s : ImagefeaturesurfGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_surf_graphn_sum(s) / s.size.to_double() }
}

pub fn image_feature_surf_graphn_scale(s : ImagefeaturesurfGraphN, f : Double) -> ImagefeaturesurfGraphN {
  let result = image_feature_surf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_surf_graphn_add(a : ImagefeaturesurfGraphN, b : ImagefeaturesurfGraphN) -> ImagefeaturesurfGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_surf_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_surf_graphn_copy(s : ImagefeaturesurfGraphN) -> ImagefeaturesurfGraphN {
  let result = image_feature_surf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_surf_graphn_fill(s : ImagefeaturesurfGraphN, v : Double) -> ImagefeaturesurfGraphN {
  let result = image_feature_surf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_graphn_min(s : ImagefeaturesurfGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_graphn_max(s : ImagefeaturesurfGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_graphn_to_string(s : ImagefeaturesurfGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_node_make(size : Int) -> ImagefeaturesurfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_node_len(s : ImagefeaturesurfNode) -> Int { s.size }

pub fn image_feature_surf_node_get(s : ImagefeaturesurfNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_node_set(s : ImagefeaturesurfNode, i : Int, v : Double) -> ImagefeaturesurfNode {
  let result = image_feature_surf_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_node_sum(s : ImagefeaturesurfNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_surf_node_mean(s : ImagefeaturesurfNode) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_surf_node_sum(s) / s.size.to_double() }
}

pub fn image_feature_surf_node_scale(s : ImagefeaturesurfNode, f : Double) -> ImagefeaturesurfNode {
  let result = image_feature_surf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_surf_node_add(a : ImagefeaturesurfNode, b : ImagefeaturesurfNode) -> ImagefeaturesurfNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_surf_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_surf_node_copy(s : ImagefeaturesurfNode) -> ImagefeaturesurfNode {
  let result = image_feature_surf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_surf_node_fill(s : ImagefeaturesurfNode, v : Double) -> ImagefeaturesurfNode {
  let result = image_feature_surf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_node_min(s : ImagefeaturesurfNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_node_max(s : ImagefeaturesurfNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_node_to_string(s : ImagefeaturesurfNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_edge_make(size : Int) -> ImagefeaturesurfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_edge_len(s : ImagefeaturesurfEdge) -> Int { s.size }

pub fn image_feature_surf_edge_get(s : ImagefeaturesurfEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_edge_set(s : ImagefeaturesurfEdge, i : Int, v : Double) -> ImagefeaturesurfEdge {
  let result = image_feature_surf_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_edge_sum(s : ImagefeaturesurfEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_surf_edge_mean(s : ImagefeaturesurfEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_surf_edge_sum(s) / s.size.to_double() }
}

pub fn image_feature_surf_edge_scale(s : ImagefeaturesurfEdge, f : Double) -> ImagefeaturesurfEdge {
  let result = image_feature_surf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_surf_edge_add(a : ImagefeaturesurfEdge, b : ImagefeaturesurfEdge) -> ImagefeaturesurfEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_surf_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_surf_edge_copy(s : ImagefeaturesurfEdge) -> ImagefeaturesurfEdge {
  let result = image_feature_surf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_surf_edge_fill(s : ImagefeaturesurfEdge, v : Double) -> ImagefeaturesurfEdge {
  let result = image_feature_surf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_edge_min(s : ImagefeaturesurfEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_edge_max(s : ImagefeaturesurfEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_edge_to_string(s : ImagefeaturesurfEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_path_make(size : Int) -> ImagefeaturesurfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_path_len(s : ImagefeaturesurfPath) -> Int { s.size }

pub fn image_feature_surf_path_get(s : ImagefeaturesurfPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_path_set(s : ImagefeaturesurfPath, i : Int, v : Double) -> ImagefeaturesurfPath {
  let result = image_feature_surf_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_path_sum(s : ImagefeaturesurfPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_surf_path_mean(s : ImagefeaturesurfPath) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_surf_path_sum(s) / s.size.to_double() }
}

pub fn image_feature_surf_path_scale(s : ImagefeaturesurfPath, f : Double) -> ImagefeaturesurfPath {
  let result = image_feature_surf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_surf_path_add(a : ImagefeaturesurfPath, b : ImagefeaturesurfPath) -> ImagefeaturesurfPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_surf_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_surf_path_copy(s : ImagefeaturesurfPath) -> ImagefeaturesurfPath {
  let result = image_feature_surf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_surf_path_fill(s : ImagefeaturesurfPath, v : Double) -> ImagefeaturesurfPath {
  let result = image_feature_surf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_path_min(s : ImagefeaturesurfPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_path_max(s : ImagefeaturesurfPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_path_to_string(s : ImagefeaturesurfPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_cluster_make(size : Int) -> ImagefeaturesurfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_cluster_len(s : ImagefeaturesurfCluster) -> Int { s.size }

pub fn image_feature_surf_cluster_get(s : ImagefeaturesurfCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_cluster_set(s : ImagefeaturesurfCluster, i : Int, v : Double) -> ImagefeaturesurfCluster {
  let result = image_feature_surf_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_cluster_sum(s : ImagefeaturesurfCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_surf_cluster_mean(s : ImagefeaturesurfCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_surf_cluster_sum(s) / s.size.to_double() }
}

pub fn image_feature_surf_cluster_scale(s : ImagefeaturesurfCluster, f : Double) -> ImagefeaturesurfCluster {
  let result = image_feature_surf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_surf_cluster_add(a : ImagefeaturesurfCluster, b : ImagefeaturesurfCluster) -> ImagefeaturesurfCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_surf_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_surf_cluster_copy(s : ImagefeaturesurfCluster) -> ImagefeaturesurfCluster {
  let result = image_feature_surf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_surf_cluster_fill(s : ImagefeaturesurfCluster, v : Double) -> ImagefeaturesurfCluster {
  let result = image_feature_surf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_cluster_min(s : ImagefeaturesurfCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_cluster_max(s : ImagefeaturesurfCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_cluster_to_string(s : ImagefeaturesurfCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_model_make(size : Int) -> ImagefeaturesurfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_model_len(s : ImagefeaturesurfModel) -> Int { s.size }

pub fn image_feature_surf_model_get(s : ImagefeaturesurfModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_model_set(s : ImagefeaturesurfModel, i : Int, v : Double) -> ImagefeaturesurfModel {
  let result = image_feature_surf_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_model_sum(s : ImagefeaturesurfModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_surf_model_mean(s : ImagefeaturesurfModel) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_surf_model_sum(s) / s.size.to_double() }
}

pub fn image_feature_surf_model_scale(s : ImagefeaturesurfModel, f : Double) -> ImagefeaturesurfModel {
  let result = image_feature_surf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_surf_model_add(a : ImagefeaturesurfModel, b : ImagefeaturesurfModel) -> ImagefeaturesurfModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_surf_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_surf_model_copy(s : ImagefeaturesurfModel) -> ImagefeaturesurfModel {
  let result = image_feature_surf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_surf_model_fill(s : ImagefeaturesurfModel, v : Double) -> ImagefeaturesurfModel {
  let result = image_feature_surf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_model_min(s : ImagefeaturesurfModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_model_max(s : ImagefeaturesurfModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_model_to_string(s : ImagefeaturesurfModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_layer_make(size : Int) -> ImagefeaturesurfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_layer_len(s : ImagefeaturesurfLayer) -> Int { s.size }

pub fn image_feature_surf_layer_get(s : ImagefeaturesurfLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_layer_set(s : ImagefeaturesurfLayer, i : Int, v : Double) -> ImagefeaturesurfLayer {
  let result = image_feature_surf_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_layer_sum(s : ImagefeaturesurfLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_surf_layer_mean(s : ImagefeaturesurfLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_surf_layer_sum(s) / s.size.to_double() }
}

pub fn image_feature_surf_layer_scale(s : ImagefeaturesurfLayer, f : Double) -> ImagefeaturesurfLayer {
  let result = image_feature_surf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_surf_layer_add(a : ImagefeaturesurfLayer, b : ImagefeaturesurfLayer) -> ImagefeaturesurfLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_surf_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_surf_layer_copy(s : ImagefeaturesurfLayer) -> ImagefeaturesurfLayer {
  let result = image_feature_surf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_surf_layer_fill(s : ImagefeaturesurfLayer, v : Double) -> ImagefeaturesurfLayer {
  let result = image_feature_surf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_layer_min(s : ImagefeaturesurfLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_layer_max(s : ImagefeaturesurfLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_layer_to_string(s : ImagefeaturesurfLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_buffer_make(size : Int) -> ImagefeaturesurfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_buffer_len(s : ImagefeaturesurfBuffer) -> Int { s.size }

pub fn image_feature_surf_buffer_get(s : ImagefeaturesurfBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_buffer_set(s : ImagefeaturesurfBuffer, i : Int, v : Double) -> ImagefeaturesurfBuffer {
  let result = image_feature_surf_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_buffer_sum(s : ImagefeaturesurfBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_surf_buffer_mean(s : ImagefeaturesurfBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_surf_buffer_sum(s) / s.size.to_double() }
}

pub fn image_feature_surf_buffer_scale(s : ImagefeaturesurfBuffer, f : Double) -> ImagefeaturesurfBuffer {
  let result = image_feature_surf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_surf_buffer_add(a : ImagefeaturesurfBuffer, b : ImagefeaturesurfBuffer) -> ImagefeaturesurfBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_surf_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_surf_buffer_copy(s : ImagefeaturesurfBuffer) -> ImagefeaturesurfBuffer {
  let result = image_feature_surf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_surf_buffer_fill(s : ImagefeaturesurfBuffer, v : Double) -> ImagefeaturesurfBuffer {
  let result = image_feature_surf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_buffer_min(s : ImagefeaturesurfBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_buffer_max(s : ImagefeaturesurfBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_buffer_to_string(s : ImagefeaturesurfBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_cursor_make(size : Int) -> ImagefeaturesurfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_cursor_len(s : ImagefeaturesurfCursor) -> Int { s.size }

pub fn image_feature_surf_cursor_get(s : ImagefeaturesurfCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_cursor_set(s : ImagefeaturesurfCursor, i : Int, v : Double) -> ImagefeaturesurfCursor {
  let result = image_feature_surf_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_cursor_sum(s : ImagefeaturesurfCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_surf_cursor_mean(s : ImagefeaturesurfCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_surf_cursor_sum(s) / s.size.to_double() }
}

pub fn image_feature_surf_cursor_scale(s : ImagefeaturesurfCursor, f : Double) -> ImagefeaturesurfCursor {
  let result = image_feature_surf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_surf_cursor_add(a : ImagefeaturesurfCursor, b : ImagefeaturesurfCursor) -> ImagefeaturesurfCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_surf_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_surf_cursor_copy(s : ImagefeaturesurfCursor) -> ImagefeaturesurfCursor {
  let result = image_feature_surf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_surf_cursor_fill(s : ImagefeaturesurfCursor, v : Double) -> ImagefeaturesurfCursor {
  let result = image_feature_surf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_cursor_min(s : ImagefeaturesurfCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_cursor_max(s : ImagefeaturesurfCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_cursor_to_string(s : ImagefeaturesurfCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_view_make(size : Int) -> ImagefeaturesurfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_view_len(s : ImagefeaturesurfView) -> Int { s.size }

pub fn image_feature_surf_view_get(s : ImagefeaturesurfView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_view_set(s : ImagefeaturesurfView, i : Int, v : Double) -> ImagefeaturesurfView {
  let result = image_feature_surf_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_view_sum(s : ImagefeaturesurfView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_surf_view_mean(s : ImagefeaturesurfView) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_surf_view_sum(s) / s.size.to_double() }
}

pub fn image_feature_surf_view_scale(s : ImagefeaturesurfView, f : Double) -> ImagefeaturesurfView {
  let result = image_feature_surf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_surf_view_add(a : ImagefeaturesurfView, b : ImagefeaturesurfView) -> ImagefeaturesurfView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_surf_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_surf_view_copy(s : ImagefeaturesurfView) -> ImagefeaturesurfView {
  let result = image_feature_surf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_surf_view_fill(s : ImagefeaturesurfView, v : Double) -> ImagefeaturesurfView {
  let result = image_feature_surf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_view_min(s : ImagefeaturesurfView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_view_max(s : ImagefeaturesurfView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_view_to_string(s : ImagefeaturesurfView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_range_make(size : Int) -> ImagefeaturesurfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_range_len(s : ImagefeaturesurfRange) -> Int { s.size }

pub fn image_feature_surf_range_get(s : ImagefeaturesurfRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_range_set(s : ImagefeaturesurfRange, i : Int, v : Double) -> ImagefeaturesurfRange {
  let result = image_feature_surf_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_range_sum(s : ImagefeaturesurfRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_surf_range_mean(s : ImagefeaturesurfRange) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_surf_range_sum(s) / s.size.to_double() }
}

pub fn image_feature_surf_range_scale(s : ImagefeaturesurfRange, f : Double) -> ImagefeaturesurfRange {
  let result = image_feature_surf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_surf_range_add(a : ImagefeaturesurfRange, b : ImagefeaturesurfRange) -> ImagefeaturesurfRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_surf_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_surf_range_copy(s : ImagefeaturesurfRange) -> ImagefeaturesurfRange {
  let result = image_feature_surf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_surf_range_fill(s : ImagefeaturesurfRange, v : Double) -> ImagefeaturesurfRange {
  let result = image_feature_surf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_range_min(s : ImagefeaturesurfRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_range_max(s : ImagefeaturesurfRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_range_to_string(s : ImagefeaturesurfRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturesurfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_surf_slice_make(size : Int) -> ImagefeaturesurfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_surf_slice_len(s : ImagefeaturesurfSlice) -> Int { s.size }

pub fn image_feature_surf_slice_get(s : ImagefeaturesurfSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_surf_slice_set(s : ImagefeaturesurfSlice, i : Int, v : Double) -> ImagefeaturesurfSlice {
  let result = image_feature_surf_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_slice_sum(s : ImagefeaturesurfSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_feature_surf_slice_mean(s : ImagefeaturesurfSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_feature_surf_slice_sum(s) / s.size.to_double() }
}

pub fn image_feature_surf_slice_scale(s : ImagefeaturesurfSlice, f : Double) -> ImagefeaturesurfSlice {
  let result = image_feature_surf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_feature_surf_slice_add(a : ImagefeaturesurfSlice, b : ImagefeaturesurfSlice) -> ImagefeaturesurfSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_feature_surf_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_feature_surf_slice_copy(s : ImagefeaturesurfSlice) -> ImagefeaturesurfSlice {
  let result = image_feature_surf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_feature_surf_slice_fill(s : ImagefeaturesurfSlice, v : Double) -> ImagefeaturesurfSlice {
  let result = image_feature_surf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_feature_surf_slice_min(s : ImagefeaturesurfSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_slice_max(s : ImagefeaturesurfSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_feature_surf_slice_to_string(s : ImagefeaturesurfSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

