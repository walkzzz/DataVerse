///===
/// extcore/image_morph_bothat

pub(all) struct ImagemorphbothatPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_bothat_make_point(x : Double, y : Double) -> ImagemorphbothatPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_bothat_make_point3(x : Double, y : Double, z : Double) -> ImagemorphbothatPoint {
  { x, y, z, label: 0 }
}

pub fn image_morph_bothat_point_x(pt : ImagemorphbothatPoint) -> Double { pt.x }

pub fn image_morph_bothat_point_y(pt : ImagemorphbothatPoint) -> Double { pt.y }

pub fn image_morph_bothat_point_z(pt : ImagemorphbothatPoint) -> Double { pt.z }

pub fn image_morph_bothat_point_label(pt : ImagemorphbothatPoint) -> Int { pt.label }

pub fn image_morph_bothat_point_dist(a : ImagemorphbothatPoint, b : ImagemorphbothatPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_morph_bothat_point_add(a : ImagemorphbothatPoint, b : ImagemorphbothatPoint) -> ImagemorphbothatPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_morph_bothat_point_sub(a : ImagemorphbothatPoint, b : ImagemorphbothatPoint) -> ImagemorphbothatPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_morph_bothat_point_scale(pt : ImagemorphbothatPoint, s : Double) -> ImagemorphbothatPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_morph_bothat_point_dot(a : ImagemorphbothatPoint, b : ImagemorphbothatPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_morph_bothat_point_cross(a : ImagemorphbothatPoint, b : ImagemorphbothatPoint) -> ImagemorphbothatPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_morph_bothat_point_norm(pt : ImagemorphbothatPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_morph_bothat_point_normalize(pt : ImagemorphbothatPoint) -> ImagemorphbothatPoint {
  let n = image_morph_bothat_point_norm(pt)
  if n < 0.0000001 { pt } else { image_morph_bothat_point_scale(pt, 1.0 / n) }
}

pub fn image_morph_bothat_point_negate(pt : ImagemorphbothatPoint) -> ImagemorphbothatPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_morph_bothat_point_mid(a : ImagemorphbothatPoint, b : ImagemorphbothatPoint) -> ImagemorphbothatPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_morph_bothat_point_lerp(a : ImagemorphbothatPoint, b : ImagemorphbothatPoint, t : Double) -> ImagemorphbothatPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_morph_bothat_point_to_string(pt : ImagemorphbothatPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagemorphbothatSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_bothat_make_series(vals : Array[Double], name : String) -> ImagemorphbothatSeries {
  { vals, name, meta: 0 }
}

pub fn image_morph_bothat_series_len(s : ImagemorphbothatSeries) -> Int { s.vals.length() }

pub fn image_morph_bothat_series_sum(s : ImagemorphbothatSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn image_morph_bothat_series_mean(s : ImagemorphbothatSeries) -> Double {
  let n = image_morph_bothat_series_len(s)
  if n == 0 { 0.0 } else { image_morph_bothat_series_sum(s) / n.to_double() }
}

pub fn image_morph_bothat_series_min(s : ImagemorphbothatSeries) -> Double {
  let n = image_morph_bothat_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn image_morph_bothat_series_max(s : ImagemorphbothatSeries) -> Double {
  let n = image_morph_bothat_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn image_morph_bothat_series_range(s : ImagemorphbothatSeries) -> Double {
  image_morph_bothat_series_max(s) - image_morph_bothat_series_min(s)
}

pub fn image_morph_bothat_series_var(s : ImagemorphbothatSeries) -> Double {
  let n = image_morph_bothat_series_len(s)
  if n == 0 { 0.0 } else {
    let m = image_morph_bothat_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn image_morph_bothat_series_std(s : ImagemorphbothatSeries) -> Double { @_common.sqrt(image_morph_bothat_series_var(s)) }

pub fn image_morph_bothat_series_median(s : ImagemorphbothatSeries) -> Double {
  let n = image_morph_bothat_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = image_morph_bothat_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn image_morph_bothat_series_scale(s : ImagemorphbothatSeries, f : Double) -> ImagemorphbothatSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_morph_bothat_series_add(a : ImagemorphbothatSeries, b : ImagemorphbothatSeries) -> ImagemorphbothatSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_morph_bothat_series_sub(a : ImagemorphbothatSeries, b : ImagemorphbothatSeries) -> ImagemorphbothatSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_morph_bothat_series_normalize(s : ImagemorphbothatSeries) -> ImagemorphbothatSeries {
  let mn = image_morph_bothat_series_min(s)
  let mx = image_morph_bothat_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_morph_bothat_series_cumsum(s : ImagemorphbothatSeries) -> ImagemorphbothatSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_morph_bothat_series_to_string(s : ImagemorphbothatSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphbothatMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_bothat_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphbothatMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_bothat_matrix_identity(n : Int) -> ImagemorphbothatMatrix {
  let m = image_morph_bothat_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_morph_bothat_matrix_get(m : ImagemorphbothatMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_morph_bothat_matrix_transpose(m : ImagemorphbothatMatrix) -> ImagemorphbothatMatrix {
  let result = image_morph_bothat_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_morph_bothat_matrix_add(a : ImagemorphbothatMatrix, b : ImagemorphbothatMatrix) -> ImagemorphbothatMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_morph_bothat_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_morph_bothat_matrix_scale(m : ImagemorphbothatMatrix, s : Double) -> ImagemorphbothatMatrix {
  let result = image_morph_bothat_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_morph_bothat_matrix_multiply(a : ImagemorphbothatMatrix, b : ImagemorphbothatMatrix) -> ImagemorphbothatMatrix {
  if a.cols != b.rows { return image_morph_bothat_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_morph_bothat_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_morph_bothat_matrix_trace(m : ImagemorphbothatMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_morph_bothat_matrix_det(m : ImagemorphbothatMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_morph_bothat_matrix_norm(m : ImagemorphbothatMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_morph_bothat_matrix_to_string(m : ImagemorphbothatMatrix) -> String {
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

pub(all) struct ImagemorphbothatVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_bothat_make_vector(comps : Array[Double]) -> ImagemorphbothatVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_bothat_vector_zero(dim : Int) -> ImagemorphbothatVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_morph_bothat_vector_add(a : ImagemorphbothatVector, b : ImagemorphbothatVector) -> ImagemorphbothatVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_morph_bothat_vector_sub(a : ImagemorphbothatVector, b : ImagemorphbothatVector) -> ImagemorphbothatVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_morph_bothat_vector_scale(v : ImagemorphbothatVector, s : Double) -> ImagemorphbothatVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_morph_bothat_vector_dot(a : ImagemorphbothatVector, b : ImagemorphbothatVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_morph_bothat_vector_norm(v : ImagemorphbothatVector) -> Double { @_common.sqrt(image_morph_bothat_vector_dot(v, v)) }

pub fn image_morph_bothat_vector_normalize(v : ImagemorphbothatVector) -> ImagemorphbothatVector {
  let n = image_morph_bothat_vector_norm(v)
  if n < 0.0000001 { v } else { image_morph_bothat_vector_scale(v, 1.0 / n) }
}

pub fn image_morph_bothat_vector_dist(a : ImagemorphbothatVector, b : ImagemorphbothatVector) -> Double {
  image_morph_bothat_vector_norm(image_morph_bothat_vector_sub(a, b))
}

pub fn image_morph_bothat_vector_to_string(v : ImagemorphbothatVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_bothat_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_morph_bothat_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_morph_bothat_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_morph_bothat_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_morph_bothat_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_morph_bothat_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_morph_bothat_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_morph_bothat_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_morph_bothat_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_morph_bothat_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_morph_bothat_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_morph_bothat_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_morph_bothat_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_morph_bothat_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_morph_bothat_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_morph_bothat_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_morph_bothat_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_morph_bothat_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_morph_bothat_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_morph_bothat_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_morph_bothat_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_morph_bothat_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_morph_bothat_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_morph_bothat_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_morph_bothat_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_morph_bothat_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_morph_bothat_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_morph_bothat_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_morph_bothat_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagemorphbothatFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_frame_make(size : Int) -> ImagemorphbothatFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_frame_len(s : ImagemorphbothatFrame) -> Int { s.size }

pub fn image_morph_bothat_frame_get(s : ImagemorphbothatFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_frame_set(s : ImagemorphbothatFrame, i : Int, v : Double) -> ImagemorphbothatFrame {
  let result = image_morph_bothat_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_frame_sum(s : ImagemorphbothatFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_bothat_frame_mean(s : ImagemorphbothatFrame) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_bothat_frame_sum(s) / s.size.to_double() }
}

pub fn image_morph_bothat_frame_scale(s : ImagemorphbothatFrame, f : Double) -> ImagemorphbothatFrame {
  let result = image_morph_bothat_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_bothat_frame_add(a : ImagemorphbothatFrame, b : ImagemorphbothatFrame) -> ImagemorphbothatFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_bothat_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_bothat_frame_copy(s : ImagemorphbothatFrame) -> ImagemorphbothatFrame {
  let result = image_morph_bothat_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_bothat_frame_fill(s : ImagemorphbothatFrame, v : Double) -> ImagemorphbothatFrame {
  let result = image_morph_bothat_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_frame_min(s : ImagemorphbothatFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_frame_max(s : ImagemorphbothatFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_frame_to_string(s : ImagemorphbothatFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_table_make(size : Int) -> ImagemorphbothatTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_table_len(s : ImagemorphbothatTable) -> Int { s.size }

pub fn image_morph_bothat_table_get(s : ImagemorphbothatTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_table_set(s : ImagemorphbothatTable, i : Int, v : Double) -> ImagemorphbothatTable {
  let result = image_morph_bothat_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_table_sum(s : ImagemorphbothatTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_bothat_table_mean(s : ImagemorphbothatTable) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_bothat_table_sum(s) / s.size.to_double() }
}

pub fn image_morph_bothat_table_scale(s : ImagemorphbothatTable, f : Double) -> ImagemorphbothatTable {
  let result = image_morph_bothat_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_bothat_table_add(a : ImagemorphbothatTable, b : ImagemorphbothatTable) -> ImagemorphbothatTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_bothat_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_bothat_table_copy(s : ImagemorphbothatTable) -> ImagemorphbothatTable {
  let result = image_morph_bothat_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_bothat_table_fill(s : ImagemorphbothatTable, v : Double) -> ImagemorphbothatTable {
  let result = image_morph_bothat_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_table_min(s : ImagemorphbothatTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_table_max(s : ImagemorphbothatTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_table_to_string(s : ImagemorphbothatTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_graphn_make(size : Int) -> ImagemorphbothatGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_graphn_len(s : ImagemorphbothatGraphN) -> Int { s.size }

pub fn image_morph_bothat_graphn_get(s : ImagemorphbothatGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_graphn_set(s : ImagemorphbothatGraphN, i : Int, v : Double) -> ImagemorphbothatGraphN {
  let result = image_morph_bothat_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_graphn_sum(s : ImagemorphbothatGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_bothat_graphn_mean(s : ImagemorphbothatGraphN) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_bothat_graphn_sum(s) / s.size.to_double() }
}

pub fn image_morph_bothat_graphn_scale(s : ImagemorphbothatGraphN, f : Double) -> ImagemorphbothatGraphN {
  let result = image_morph_bothat_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_bothat_graphn_add(a : ImagemorphbothatGraphN, b : ImagemorphbothatGraphN) -> ImagemorphbothatGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_bothat_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_bothat_graphn_copy(s : ImagemorphbothatGraphN) -> ImagemorphbothatGraphN {
  let result = image_morph_bothat_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_bothat_graphn_fill(s : ImagemorphbothatGraphN, v : Double) -> ImagemorphbothatGraphN {
  let result = image_morph_bothat_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_graphn_min(s : ImagemorphbothatGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_graphn_max(s : ImagemorphbothatGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_graphn_to_string(s : ImagemorphbothatGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_node_make(size : Int) -> ImagemorphbothatNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_node_len(s : ImagemorphbothatNode) -> Int { s.size }

pub fn image_morph_bothat_node_get(s : ImagemorphbothatNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_node_set(s : ImagemorphbothatNode, i : Int, v : Double) -> ImagemorphbothatNode {
  let result = image_morph_bothat_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_node_sum(s : ImagemorphbothatNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_bothat_node_mean(s : ImagemorphbothatNode) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_bothat_node_sum(s) / s.size.to_double() }
}

pub fn image_morph_bothat_node_scale(s : ImagemorphbothatNode, f : Double) -> ImagemorphbothatNode {
  let result = image_morph_bothat_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_bothat_node_add(a : ImagemorphbothatNode, b : ImagemorphbothatNode) -> ImagemorphbothatNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_bothat_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_bothat_node_copy(s : ImagemorphbothatNode) -> ImagemorphbothatNode {
  let result = image_morph_bothat_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_bothat_node_fill(s : ImagemorphbothatNode, v : Double) -> ImagemorphbothatNode {
  let result = image_morph_bothat_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_node_min(s : ImagemorphbothatNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_node_max(s : ImagemorphbothatNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_node_to_string(s : ImagemorphbothatNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_edge_make(size : Int) -> ImagemorphbothatEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_edge_len(s : ImagemorphbothatEdge) -> Int { s.size }

pub fn image_morph_bothat_edge_get(s : ImagemorphbothatEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_edge_set(s : ImagemorphbothatEdge, i : Int, v : Double) -> ImagemorphbothatEdge {
  let result = image_morph_bothat_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_edge_sum(s : ImagemorphbothatEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_bothat_edge_mean(s : ImagemorphbothatEdge) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_bothat_edge_sum(s) / s.size.to_double() }
}

pub fn image_morph_bothat_edge_scale(s : ImagemorphbothatEdge, f : Double) -> ImagemorphbothatEdge {
  let result = image_morph_bothat_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_bothat_edge_add(a : ImagemorphbothatEdge, b : ImagemorphbothatEdge) -> ImagemorphbothatEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_bothat_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_bothat_edge_copy(s : ImagemorphbothatEdge) -> ImagemorphbothatEdge {
  let result = image_morph_bothat_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_bothat_edge_fill(s : ImagemorphbothatEdge, v : Double) -> ImagemorphbothatEdge {
  let result = image_morph_bothat_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_edge_min(s : ImagemorphbothatEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_edge_max(s : ImagemorphbothatEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_edge_to_string(s : ImagemorphbothatEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_path_make(size : Int) -> ImagemorphbothatPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_path_len(s : ImagemorphbothatPath) -> Int { s.size }

pub fn image_morph_bothat_path_get(s : ImagemorphbothatPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_path_set(s : ImagemorphbothatPath, i : Int, v : Double) -> ImagemorphbothatPath {
  let result = image_morph_bothat_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_path_sum(s : ImagemorphbothatPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_bothat_path_mean(s : ImagemorphbothatPath) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_bothat_path_sum(s) / s.size.to_double() }
}

pub fn image_morph_bothat_path_scale(s : ImagemorphbothatPath, f : Double) -> ImagemorphbothatPath {
  let result = image_morph_bothat_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_bothat_path_add(a : ImagemorphbothatPath, b : ImagemorphbothatPath) -> ImagemorphbothatPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_bothat_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_bothat_path_copy(s : ImagemorphbothatPath) -> ImagemorphbothatPath {
  let result = image_morph_bothat_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_bothat_path_fill(s : ImagemorphbothatPath, v : Double) -> ImagemorphbothatPath {
  let result = image_morph_bothat_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_path_min(s : ImagemorphbothatPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_path_max(s : ImagemorphbothatPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_path_to_string(s : ImagemorphbothatPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_cluster_make(size : Int) -> ImagemorphbothatCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_cluster_len(s : ImagemorphbothatCluster) -> Int { s.size }

pub fn image_morph_bothat_cluster_get(s : ImagemorphbothatCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_cluster_set(s : ImagemorphbothatCluster, i : Int, v : Double) -> ImagemorphbothatCluster {
  let result = image_morph_bothat_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_cluster_sum(s : ImagemorphbothatCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_bothat_cluster_mean(s : ImagemorphbothatCluster) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_bothat_cluster_sum(s) / s.size.to_double() }
}

pub fn image_morph_bothat_cluster_scale(s : ImagemorphbothatCluster, f : Double) -> ImagemorphbothatCluster {
  let result = image_morph_bothat_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_bothat_cluster_add(a : ImagemorphbothatCluster, b : ImagemorphbothatCluster) -> ImagemorphbothatCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_bothat_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_bothat_cluster_copy(s : ImagemorphbothatCluster) -> ImagemorphbothatCluster {
  let result = image_morph_bothat_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_bothat_cluster_fill(s : ImagemorphbothatCluster, v : Double) -> ImagemorphbothatCluster {
  let result = image_morph_bothat_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_cluster_min(s : ImagemorphbothatCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_cluster_max(s : ImagemorphbothatCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_cluster_to_string(s : ImagemorphbothatCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_model_make(size : Int) -> ImagemorphbothatModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_model_len(s : ImagemorphbothatModel) -> Int { s.size }

pub fn image_morph_bothat_model_get(s : ImagemorphbothatModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_model_set(s : ImagemorphbothatModel, i : Int, v : Double) -> ImagemorphbothatModel {
  let result = image_morph_bothat_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_model_sum(s : ImagemorphbothatModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_bothat_model_mean(s : ImagemorphbothatModel) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_bothat_model_sum(s) / s.size.to_double() }
}

pub fn image_morph_bothat_model_scale(s : ImagemorphbothatModel, f : Double) -> ImagemorphbothatModel {
  let result = image_morph_bothat_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_bothat_model_add(a : ImagemorphbothatModel, b : ImagemorphbothatModel) -> ImagemorphbothatModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_bothat_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_bothat_model_copy(s : ImagemorphbothatModel) -> ImagemorphbothatModel {
  let result = image_morph_bothat_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_bothat_model_fill(s : ImagemorphbothatModel, v : Double) -> ImagemorphbothatModel {
  let result = image_morph_bothat_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_model_min(s : ImagemorphbothatModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_model_max(s : ImagemorphbothatModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_model_to_string(s : ImagemorphbothatModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_layer_make(size : Int) -> ImagemorphbothatLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_layer_len(s : ImagemorphbothatLayer) -> Int { s.size }

pub fn image_morph_bothat_layer_get(s : ImagemorphbothatLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_layer_set(s : ImagemorphbothatLayer, i : Int, v : Double) -> ImagemorphbothatLayer {
  let result = image_morph_bothat_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_layer_sum(s : ImagemorphbothatLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_bothat_layer_mean(s : ImagemorphbothatLayer) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_bothat_layer_sum(s) / s.size.to_double() }
}

pub fn image_morph_bothat_layer_scale(s : ImagemorphbothatLayer, f : Double) -> ImagemorphbothatLayer {
  let result = image_morph_bothat_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_bothat_layer_add(a : ImagemorphbothatLayer, b : ImagemorphbothatLayer) -> ImagemorphbothatLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_bothat_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_bothat_layer_copy(s : ImagemorphbothatLayer) -> ImagemorphbothatLayer {
  let result = image_morph_bothat_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_bothat_layer_fill(s : ImagemorphbothatLayer, v : Double) -> ImagemorphbothatLayer {
  let result = image_morph_bothat_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_layer_min(s : ImagemorphbothatLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_layer_max(s : ImagemorphbothatLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_layer_to_string(s : ImagemorphbothatLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_buffer_make(size : Int) -> ImagemorphbothatBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_buffer_len(s : ImagemorphbothatBuffer) -> Int { s.size }

pub fn image_morph_bothat_buffer_get(s : ImagemorphbothatBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_buffer_set(s : ImagemorphbothatBuffer, i : Int, v : Double) -> ImagemorphbothatBuffer {
  let result = image_morph_bothat_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_buffer_sum(s : ImagemorphbothatBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_bothat_buffer_mean(s : ImagemorphbothatBuffer) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_bothat_buffer_sum(s) / s.size.to_double() }
}

pub fn image_morph_bothat_buffer_scale(s : ImagemorphbothatBuffer, f : Double) -> ImagemorphbothatBuffer {
  let result = image_morph_bothat_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_bothat_buffer_add(a : ImagemorphbothatBuffer, b : ImagemorphbothatBuffer) -> ImagemorphbothatBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_bothat_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_bothat_buffer_copy(s : ImagemorphbothatBuffer) -> ImagemorphbothatBuffer {
  let result = image_morph_bothat_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_bothat_buffer_fill(s : ImagemorphbothatBuffer, v : Double) -> ImagemorphbothatBuffer {
  let result = image_morph_bothat_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_buffer_min(s : ImagemorphbothatBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_buffer_max(s : ImagemorphbothatBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_buffer_to_string(s : ImagemorphbothatBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_cursor_make(size : Int) -> ImagemorphbothatCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_cursor_len(s : ImagemorphbothatCursor) -> Int { s.size }

pub fn image_morph_bothat_cursor_get(s : ImagemorphbothatCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_cursor_set(s : ImagemorphbothatCursor, i : Int, v : Double) -> ImagemorphbothatCursor {
  let result = image_morph_bothat_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_cursor_sum(s : ImagemorphbothatCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_bothat_cursor_mean(s : ImagemorphbothatCursor) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_bothat_cursor_sum(s) / s.size.to_double() }
}

pub fn image_morph_bothat_cursor_scale(s : ImagemorphbothatCursor, f : Double) -> ImagemorphbothatCursor {
  let result = image_morph_bothat_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_bothat_cursor_add(a : ImagemorphbothatCursor, b : ImagemorphbothatCursor) -> ImagemorphbothatCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_bothat_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_bothat_cursor_copy(s : ImagemorphbothatCursor) -> ImagemorphbothatCursor {
  let result = image_morph_bothat_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_bothat_cursor_fill(s : ImagemorphbothatCursor, v : Double) -> ImagemorphbothatCursor {
  let result = image_morph_bothat_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_cursor_min(s : ImagemorphbothatCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_cursor_max(s : ImagemorphbothatCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_cursor_to_string(s : ImagemorphbothatCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_view_make(size : Int) -> ImagemorphbothatView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_view_len(s : ImagemorphbothatView) -> Int { s.size }

pub fn image_morph_bothat_view_get(s : ImagemorphbothatView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_view_set(s : ImagemorphbothatView, i : Int, v : Double) -> ImagemorphbothatView {
  let result = image_morph_bothat_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_view_sum(s : ImagemorphbothatView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_bothat_view_mean(s : ImagemorphbothatView) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_bothat_view_sum(s) / s.size.to_double() }
}

pub fn image_morph_bothat_view_scale(s : ImagemorphbothatView, f : Double) -> ImagemorphbothatView {
  let result = image_morph_bothat_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_bothat_view_add(a : ImagemorphbothatView, b : ImagemorphbothatView) -> ImagemorphbothatView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_bothat_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_bothat_view_copy(s : ImagemorphbothatView) -> ImagemorphbothatView {
  let result = image_morph_bothat_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_bothat_view_fill(s : ImagemorphbothatView, v : Double) -> ImagemorphbothatView {
  let result = image_morph_bothat_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_view_min(s : ImagemorphbothatView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_view_max(s : ImagemorphbothatView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_view_to_string(s : ImagemorphbothatView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_range_make(size : Int) -> ImagemorphbothatRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_range_len(s : ImagemorphbothatRange) -> Int { s.size }

pub fn image_morph_bothat_range_get(s : ImagemorphbothatRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_range_set(s : ImagemorphbothatRange, i : Int, v : Double) -> ImagemorphbothatRange {
  let result = image_morph_bothat_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_range_sum(s : ImagemorphbothatRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_bothat_range_mean(s : ImagemorphbothatRange) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_bothat_range_sum(s) / s.size.to_double() }
}

pub fn image_morph_bothat_range_scale(s : ImagemorphbothatRange, f : Double) -> ImagemorphbothatRange {
  let result = image_morph_bothat_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_bothat_range_add(a : ImagemorphbothatRange, b : ImagemorphbothatRange) -> ImagemorphbothatRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_bothat_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_bothat_range_copy(s : ImagemorphbothatRange) -> ImagemorphbothatRange {
  let result = image_morph_bothat_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_bothat_range_fill(s : ImagemorphbothatRange, v : Double) -> ImagemorphbothatRange {
  let result = image_morph_bothat_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_range_min(s : ImagemorphbothatRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_range_max(s : ImagemorphbothatRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_range_to_string(s : ImagemorphbothatRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphbothatSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_bothat_slice_make(size : Int) -> ImagemorphbothatSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_bothat_slice_len(s : ImagemorphbothatSlice) -> Int { s.size }

pub fn image_morph_bothat_slice_get(s : ImagemorphbothatSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_bothat_slice_set(s : ImagemorphbothatSlice, i : Int, v : Double) -> ImagemorphbothatSlice {
  let result = image_morph_bothat_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_slice_sum(s : ImagemorphbothatSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn image_morph_bothat_slice_mean(s : ImagemorphbothatSlice) -> Double {
  if s.size == 0 { 0.0 } else { image_morph_bothat_slice_sum(s) / s.size.to_double() }
}

pub fn image_morph_bothat_slice_scale(s : ImagemorphbothatSlice, f : Double) -> ImagemorphbothatSlice {
  let result = image_morph_bothat_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_bothat_slice_add(a : ImagemorphbothatSlice, b : ImagemorphbothatSlice) -> ImagemorphbothatSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_bothat_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_bothat_slice_copy(s : ImagemorphbothatSlice) -> ImagemorphbothatSlice {
  let result = image_morph_bothat_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_bothat_slice_fill(s : ImagemorphbothatSlice, v : Double) -> ImagemorphbothatSlice {
  let result = image_morph_bothat_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_bothat_slice_min(s : ImagemorphbothatSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_slice_max(s : ImagemorphbothatSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn image_morph_bothat_slice_to_string(s : ImagemorphbothatSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

