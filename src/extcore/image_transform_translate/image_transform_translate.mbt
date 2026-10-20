///===
/// extcore/image_transform_translate

pub(all) struct ImagetransformtranslatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_translate_make_point(x : Double, y : Double) -> ImagetransformtranslatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_translate_make_point3(x : Double, y : Double, z : Double) -> ImagetransformtranslatePoint {
  { x, y, z, label: 0 }
}

pub fn image_transform_translate_point_x(pt : ImagetransformtranslatePoint) -> Double { pt.x }

pub fn image_transform_translate_point_y(pt : ImagetransformtranslatePoint) -> Double { pt.y }

pub fn image_transform_translate_point_z(pt : ImagetransformtranslatePoint) -> Double { pt.z }

pub fn image_transform_translate_point_label(pt : ImagetransformtranslatePoint) -> Int { pt.label }

pub fn image_transform_translate_point_dist(a : ImagetransformtranslatePoint, b : ImagetransformtranslatePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_transform_translate_point_add(a : ImagetransformtranslatePoint, b : ImagetransformtranslatePoint) -> ImagetransformtranslatePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_transform_translate_point_sub(a : ImagetransformtranslatePoint, b : ImagetransformtranslatePoint) -> ImagetransformtranslatePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_transform_translate_point_scale(pt : ImagetransformtranslatePoint, s : Double) -> ImagetransformtranslatePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_transform_translate_point_dot(a : ImagetransformtranslatePoint, b : ImagetransformtranslatePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_transform_translate_point_cross(a : ImagetransformtranslatePoint, b : ImagetransformtranslatePoint) -> ImagetransformtranslatePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_transform_translate_point_norm(pt : ImagetransformtranslatePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_transform_translate_point_normalize(pt : ImagetransformtranslatePoint) -> ImagetransformtranslatePoint {
  let n = image_transform_translate_point_norm(pt)
  if n < 0.0000001 { pt } else { image_transform_translate_point_scale(pt, 1.0 / n) }
}

pub fn image_transform_translate_point_negate(pt : ImagetransformtranslatePoint) -> ImagetransformtranslatePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_transform_translate_point_mid(a : ImagetransformtranslatePoint, b : ImagetransformtranslatePoint) -> ImagetransformtranslatePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_transform_translate_point_lerp(a : ImagetransformtranslatePoint, b : ImagetransformtranslatePoint, t : Double) -> ImagetransformtranslatePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_transform_translate_point_to_string(pt : ImagetransformtranslatePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagetransformtranslateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_translate_make_series(vals : Array[Double], name : String) -> ImagetransformtranslateSeries {
  { vals, name, meta: 0 }
}

pub fn image_transform_translate_series_len(s : ImagetransformtranslateSeries) -> Int { s.vals.length() }

pub fn image_transform_translate_series_sum(s : ImagetransformtranslateSeries) -> Double { @_common.sum(s.vals) }

pub fn image_transform_translate_series_mean(s : ImagetransformtranslateSeries) -> Double { @_common.mean(s.vals) }

pub fn image_transform_translate_series_min(s : ImagetransformtranslateSeries) -> Double { @_common.min(s.vals) }

pub fn image_transform_translate_series_max(s : ImagetransformtranslateSeries) -> Double { @_common.max(s.vals) }

pub fn image_transform_translate_series_range(s : ImagetransformtranslateSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_transform_translate_series_var(s : ImagetransformtranslateSeries) -> Double { @_common.variance(s.vals) }

pub fn image_transform_translate_series_std(s : ImagetransformtranslateSeries) -> Double { @_common.std(s.vals) }

pub fn image_transform_translate_series_median(s : ImagetransformtranslateSeries) -> Double { @_common.median(s.vals) }

pub fn image_transform_translate_series_scale(s : ImagetransformtranslateSeries, f : Double) -> ImagetransformtranslateSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_transform_translate_series_add(a : ImagetransformtranslateSeries, b : ImagetransformtranslateSeries) -> ImagetransformtranslateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_transform_translate_series_sub(a : ImagetransformtranslateSeries, b : ImagetransformtranslateSeries) -> ImagetransformtranslateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_transform_translate_series_normalize(s : ImagetransformtranslateSeries) -> ImagetransformtranslateSeries {
  let mn = image_transform_translate_series_min(s)
  let mx = image_transform_translate_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_transform_translate_series_cumsum(s : ImagetransformtranslateSeries) -> ImagetransformtranslateSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_transform_translate_series_to_string(s : ImagetransformtranslateSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformtranslateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_translate_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformtranslateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_translate_matrix_identity(n : Int) -> ImagetransformtranslateMatrix {
  let m = image_transform_translate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_transform_translate_matrix_get(m : ImagetransformtranslateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_transform_translate_matrix_transpose(m : ImagetransformtranslateMatrix) -> ImagetransformtranslateMatrix {
  let result = image_transform_translate_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_transform_translate_matrix_add(a : ImagetransformtranslateMatrix, b : ImagetransformtranslateMatrix) -> ImagetransformtranslateMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_transform_translate_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_transform_translate_matrix_scale(m : ImagetransformtranslateMatrix, s : Double) -> ImagetransformtranslateMatrix {
  let result = image_transform_translate_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_transform_translate_matrix_multiply(a : ImagetransformtranslateMatrix, b : ImagetransformtranslateMatrix) -> ImagetransformtranslateMatrix {
  if a.cols != b.rows { return image_transform_translate_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_transform_translate_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_transform_translate_matrix_trace(m : ImagetransformtranslateMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_transform_translate_matrix_det(m : ImagetransformtranslateMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_transform_translate_matrix_norm(m : ImagetransformtranslateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_transform_translate_matrix_to_string(m : ImagetransformtranslateMatrix) -> String {
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

pub(all) struct ImagetransformtranslateVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_translate_make_vector(comps : Array[Double]) -> ImagetransformtranslateVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_translate_vector_zero(dim : Int) -> ImagetransformtranslateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_transform_translate_vector_add(a : ImagetransformtranslateVector, b : ImagetransformtranslateVector) -> ImagetransformtranslateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_translate_vector_sub(a : ImagetransformtranslateVector, b : ImagetransformtranslateVector) -> ImagetransformtranslateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_translate_vector_scale(v : ImagetransformtranslateVector, s : Double) -> ImagetransformtranslateVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_transform_translate_vector_dot(a : ImagetransformtranslateVector, b : ImagetransformtranslateVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_transform_translate_vector_norm(v : ImagetransformtranslateVector) -> Double { @_common.sqrt(image_transform_translate_vector_dot(v, v)) }

pub fn image_transform_translate_vector_normalize(v : ImagetransformtranslateVector) -> ImagetransformtranslateVector {
  let n = image_transform_translate_vector_norm(v)
  if n < 0.0000001 { v } else { image_transform_translate_vector_scale(v, 1.0 / n) }
}

pub fn image_transform_translate_vector_dist(a : ImagetransformtranslateVector, b : ImagetransformtranslateVector) -> Double {
  image_transform_translate_vector_norm(image_transform_translate_vector_sub(a, b))
}

pub fn image_transform_translate_vector_to_string(v : ImagetransformtranslateVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_translate_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_translate_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_translate_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_translate_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_translate_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_translate_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_translate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_translate_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_translate_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_translate_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_translate_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_translate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_translate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_translate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_translate_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_translate_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_translate_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_translate_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_translate_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_translate_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_translate_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_translate_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_translate_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_translate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_translate_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_translate_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_translate_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_translate_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_translate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformtranslateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_frame_make(size : Int) -> ImagetransformtranslateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_frame_len(s : ImagetransformtranslateFrame) -> Int { s.size }

pub fn image_transform_translate_frame_get(s : ImagetransformtranslateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_frame_set(s : ImagetransformtranslateFrame, i : Int, v : Double) -> ImagetransformtranslateFrame {
  let result = image_transform_translate_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_frame_sum(s : ImagetransformtranslateFrame) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_frame_mean(s : ImagetransformtranslateFrame) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_frame_scale(s : ImagetransformtranslateFrame, f : Double) -> ImagetransformtranslateFrame {
  let result = image_transform_translate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_translate_frame_add(a : ImagetransformtranslateFrame, b : ImagetransformtranslateFrame) -> ImagetransformtranslateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_translate_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_translate_frame_copy(s : ImagetransformtranslateFrame) -> ImagetransformtranslateFrame {
  let result = image_transform_translate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_translate_frame_fill(s : ImagetransformtranslateFrame, v : Double) -> ImagetransformtranslateFrame {
  let result = image_transform_translate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_frame_min(s : ImagetransformtranslateFrame) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_frame_max(s : ImagetransformtranslateFrame) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_frame_to_string(s : ImagetransformtranslateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_table_make(size : Int) -> ImagetransformtranslateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_table_len(s : ImagetransformtranslateTable) -> Int { s.size }

pub fn image_transform_translate_table_get(s : ImagetransformtranslateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_table_set(s : ImagetransformtranslateTable, i : Int, v : Double) -> ImagetransformtranslateTable {
  let result = image_transform_translate_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_table_sum(s : ImagetransformtranslateTable) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_table_mean(s : ImagetransformtranslateTable) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_table_scale(s : ImagetransformtranslateTable, f : Double) -> ImagetransformtranslateTable {
  let result = image_transform_translate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_translate_table_add(a : ImagetransformtranslateTable, b : ImagetransformtranslateTable) -> ImagetransformtranslateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_translate_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_translate_table_copy(s : ImagetransformtranslateTable) -> ImagetransformtranslateTable {
  let result = image_transform_translate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_translate_table_fill(s : ImagetransformtranslateTable, v : Double) -> ImagetransformtranslateTable {
  let result = image_transform_translate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_table_min(s : ImagetransformtranslateTable) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_table_max(s : ImagetransformtranslateTable) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_table_to_string(s : ImagetransformtranslateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_graphn_make(size : Int) -> ImagetransformtranslateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_graphn_len(s : ImagetransformtranslateGraphN) -> Int { s.size }

pub fn image_transform_translate_graphn_get(s : ImagetransformtranslateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_graphn_set(s : ImagetransformtranslateGraphN, i : Int, v : Double) -> ImagetransformtranslateGraphN {
  let result = image_transform_translate_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_graphn_sum(s : ImagetransformtranslateGraphN) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_graphn_mean(s : ImagetransformtranslateGraphN) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_graphn_scale(s : ImagetransformtranslateGraphN, f : Double) -> ImagetransformtranslateGraphN {
  let result = image_transform_translate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_translate_graphn_add(a : ImagetransformtranslateGraphN, b : ImagetransformtranslateGraphN) -> ImagetransformtranslateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_translate_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_translate_graphn_copy(s : ImagetransformtranslateGraphN) -> ImagetransformtranslateGraphN {
  let result = image_transform_translate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_translate_graphn_fill(s : ImagetransformtranslateGraphN, v : Double) -> ImagetransformtranslateGraphN {
  let result = image_transform_translate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_graphn_min(s : ImagetransformtranslateGraphN) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_graphn_max(s : ImagetransformtranslateGraphN) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_graphn_to_string(s : ImagetransformtranslateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_node_make(size : Int) -> ImagetransformtranslateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_node_len(s : ImagetransformtranslateNode) -> Int { s.size }

pub fn image_transform_translate_node_get(s : ImagetransformtranslateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_node_set(s : ImagetransformtranslateNode, i : Int, v : Double) -> ImagetransformtranslateNode {
  let result = image_transform_translate_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_node_sum(s : ImagetransformtranslateNode) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_node_mean(s : ImagetransformtranslateNode) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_node_scale(s : ImagetransformtranslateNode, f : Double) -> ImagetransformtranslateNode {
  let result = image_transform_translate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_translate_node_add(a : ImagetransformtranslateNode, b : ImagetransformtranslateNode) -> ImagetransformtranslateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_translate_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_translate_node_copy(s : ImagetransformtranslateNode) -> ImagetransformtranslateNode {
  let result = image_transform_translate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_translate_node_fill(s : ImagetransformtranslateNode, v : Double) -> ImagetransformtranslateNode {
  let result = image_transform_translate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_node_min(s : ImagetransformtranslateNode) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_node_max(s : ImagetransformtranslateNode) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_node_to_string(s : ImagetransformtranslateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_edge_make(size : Int) -> ImagetransformtranslateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_edge_len(s : ImagetransformtranslateEdge) -> Int { s.size }

pub fn image_transform_translate_edge_get(s : ImagetransformtranslateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_edge_set(s : ImagetransformtranslateEdge, i : Int, v : Double) -> ImagetransformtranslateEdge {
  let result = image_transform_translate_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_edge_sum(s : ImagetransformtranslateEdge) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_edge_mean(s : ImagetransformtranslateEdge) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_edge_scale(s : ImagetransformtranslateEdge, f : Double) -> ImagetransformtranslateEdge {
  let result = image_transform_translate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_translate_edge_add(a : ImagetransformtranslateEdge, b : ImagetransformtranslateEdge) -> ImagetransformtranslateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_translate_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_translate_edge_copy(s : ImagetransformtranslateEdge) -> ImagetransformtranslateEdge {
  let result = image_transform_translate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_translate_edge_fill(s : ImagetransformtranslateEdge, v : Double) -> ImagetransformtranslateEdge {
  let result = image_transform_translate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_edge_min(s : ImagetransformtranslateEdge) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_edge_max(s : ImagetransformtranslateEdge) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_edge_to_string(s : ImagetransformtranslateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_path_make(size : Int) -> ImagetransformtranslatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_path_len(s : ImagetransformtranslatePath) -> Int { s.size }

pub fn image_transform_translate_path_get(s : ImagetransformtranslatePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_path_set(s : ImagetransformtranslatePath, i : Int, v : Double) -> ImagetransformtranslatePath {
  let result = image_transform_translate_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_path_sum(s : ImagetransformtranslatePath) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_path_mean(s : ImagetransformtranslatePath) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_path_scale(s : ImagetransformtranslatePath, f : Double) -> ImagetransformtranslatePath {
  let result = image_transform_translate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_translate_path_add(a : ImagetransformtranslatePath, b : ImagetransformtranslatePath) -> ImagetransformtranslatePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_translate_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_translate_path_copy(s : ImagetransformtranslatePath) -> ImagetransformtranslatePath {
  let result = image_transform_translate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_translate_path_fill(s : ImagetransformtranslatePath, v : Double) -> ImagetransformtranslatePath {
  let result = image_transform_translate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_path_min(s : ImagetransformtranslatePath) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_path_max(s : ImagetransformtranslatePath) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_path_to_string(s : ImagetransformtranslatePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_cluster_make(size : Int) -> ImagetransformtranslateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_cluster_len(s : ImagetransformtranslateCluster) -> Int { s.size }

pub fn image_transform_translate_cluster_get(s : ImagetransformtranslateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_cluster_set(s : ImagetransformtranslateCluster, i : Int, v : Double) -> ImagetransformtranslateCluster {
  let result = image_transform_translate_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_cluster_sum(s : ImagetransformtranslateCluster) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_cluster_mean(s : ImagetransformtranslateCluster) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_cluster_scale(s : ImagetransformtranslateCluster, f : Double) -> ImagetransformtranslateCluster {
  let result = image_transform_translate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_translate_cluster_add(a : ImagetransformtranslateCluster, b : ImagetransformtranslateCluster) -> ImagetransformtranslateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_translate_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_translate_cluster_copy(s : ImagetransformtranslateCluster) -> ImagetransformtranslateCluster {
  let result = image_transform_translate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_translate_cluster_fill(s : ImagetransformtranslateCluster, v : Double) -> ImagetransformtranslateCluster {
  let result = image_transform_translate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_cluster_min(s : ImagetransformtranslateCluster) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_cluster_max(s : ImagetransformtranslateCluster) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_cluster_to_string(s : ImagetransformtranslateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_model_make(size : Int) -> ImagetransformtranslateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_model_len(s : ImagetransformtranslateModel) -> Int { s.size }

pub fn image_transform_translate_model_get(s : ImagetransformtranslateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_model_set(s : ImagetransformtranslateModel, i : Int, v : Double) -> ImagetransformtranslateModel {
  let result = image_transform_translate_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_model_sum(s : ImagetransformtranslateModel) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_model_mean(s : ImagetransformtranslateModel) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_model_scale(s : ImagetransformtranslateModel, f : Double) -> ImagetransformtranslateModel {
  let result = image_transform_translate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_translate_model_add(a : ImagetransformtranslateModel, b : ImagetransformtranslateModel) -> ImagetransformtranslateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_translate_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_translate_model_copy(s : ImagetransformtranslateModel) -> ImagetransformtranslateModel {
  let result = image_transform_translate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_translate_model_fill(s : ImagetransformtranslateModel, v : Double) -> ImagetransformtranslateModel {
  let result = image_transform_translate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_model_min(s : ImagetransformtranslateModel) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_model_max(s : ImagetransformtranslateModel) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_model_to_string(s : ImagetransformtranslateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_layer_make(size : Int) -> ImagetransformtranslateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_layer_len(s : ImagetransformtranslateLayer) -> Int { s.size }

pub fn image_transform_translate_layer_get(s : ImagetransformtranslateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_layer_set(s : ImagetransformtranslateLayer, i : Int, v : Double) -> ImagetransformtranslateLayer {
  let result = image_transform_translate_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_layer_sum(s : ImagetransformtranslateLayer) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_layer_mean(s : ImagetransformtranslateLayer) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_layer_scale(s : ImagetransformtranslateLayer, f : Double) -> ImagetransformtranslateLayer {
  let result = image_transform_translate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_translate_layer_add(a : ImagetransformtranslateLayer, b : ImagetransformtranslateLayer) -> ImagetransformtranslateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_translate_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_translate_layer_copy(s : ImagetransformtranslateLayer) -> ImagetransformtranslateLayer {
  let result = image_transform_translate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_translate_layer_fill(s : ImagetransformtranslateLayer, v : Double) -> ImagetransformtranslateLayer {
  let result = image_transform_translate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_layer_min(s : ImagetransformtranslateLayer) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_layer_max(s : ImagetransformtranslateLayer) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_layer_to_string(s : ImagetransformtranslateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_buffer_make(size : Int) -> ImagetransformtranslateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_buffer_len(s : ImagetransformtranslateBuffer) -> Int { s.size }

pub fn image_transform_translate_buffer_get(s : ImagetransformtranslateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_buffer_set(s : ImagetransformtranslateBuffer, i : Int, v : Double) -> ImagetransformtranslateBuffer {
  let result = image_transform_translate_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_buffer_sum(s : ImagetransformtranslateBuffer) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_buffer_mean(s : ImagetransformtranslateBuffer) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_buffer_scale(s : ImagetransformtranslateBuffer, f : Double) -> ImagetransformtranslateBuffer {
  let result = image_transform_translate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_translate_buffer_add(a : ImagetransformtranslateBuffer, b : ImagetransformtranslateBuffer) -> ImagetransformtranslateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_translate_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_translate_buffer_copy(s : ImagetransformtranslateBuffer) -> ImagetransformtranslateBuffer {
  let result = image_transform_translate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_translate_buffer_fill(s : ImagetransformtranslateBuffer, v : Double) -> ImagetransformtranslateBuffer {
  let result = image_transform_translate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_buffer_min(s : ImagetransformtranslateBuffer) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_buffer_max(s : ImagetransformtranslateBuffer) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_buffer_to_string(s : ImagetransformtranslateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_cursor_make(size : Int) -> ImagetransformtranslateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_cursor_len(s : ImagetransformtranslateCursor) -> Int { s.size }

pub fn image_transform_translate_cursor_get(s : ImagetransformtranslateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_cursor_set(s : ImagetransformtranslateCursor, i : Int, v : Double) -> ImagetransformtranslateCursor {
  let result = image_transform_translate_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_cursor_sum(s : ImagetransformtranslateCursor) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_cursor_mean(s : ImagetransformtranslateCursor) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_cursor_scale(s : ImagetransformtranslateCursor, f : Double) -> ImagetransformtranslateCursor {
  let result = image_transform_translate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_translate_cursor_add(a : ImagetransformtranslateCursor, b : ImagetransformtranslateCursor) -> ImagetransformtranslateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_translate_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_translate_cursor_copy(s : ImagetransformtranslateCursor) -> ImagetransformtranslateCursor {
  let result = image_transform_translate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_translate_cursor_fill(s : ImagetransformtranslateCursor, v : Double) -> ImagetransformtranslateCursor {
  let result = image_transform_translate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_cursor_min(s : ImagetransformtranslateCursor) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_cursor_max(s : ImagetransformtranslateCursor) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_cursor_to_string(s : ImagetransformtranslateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_view_make(size : Int) -> ImagetransformtranslateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_view_len(s : ImagetransformtranslateView) -> Int { s.size }

pub fn image_transform_translate_view_get(s : ImagetransformtranslateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_view_set(s : ImagetransformtranslateView, i : Int, v : Double) -> ImagetransformtranslateView {
  let result = image_transform_translate_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_view_sum(s : ImagetransformtranslateView) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_view_mean(s : ImagetransformtranslateView) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_view_scale(s : ImagetransformtranslateView, f : Double) -> ImagetransformtranslateView {
  let result = image_transform_translate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_translate_view_add(a : ImagetransformtranslateView, b : ImagetransformtranslateView) -> ImagetransformtranslateView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_translate_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_translate_view_copy(s : ImagetransformtranslateView) -> ImagetransformtranslateView {
  let result = image_transform_translate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_translate_view_fill(s : ImagetransformtranslateView, v : Double) -> ImagetransformtranslateView {
  let result = image_transform_translate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_view_min(s : ImagetransformtranslateView) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_view_max(s : ImagetransformtranslateView) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_view_to_string(s : ImagetransformtranslateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_range_make(size : Int) -> ImagetransformtranslateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_range_len(s : ImagetransformtranslateRange) -> Int { s.size }

pub fn image_transform_translate_range_get(s : ImagetransformtranslateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_range_set(s : ImagetransformtranslateRange, i : Int, v : Double) -> ImagetransformtranslateRange {
  let result = image_transform_translate_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_range_sum(s : ImagetransformtranslateRange) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_range_mean(s : ImagetransformtranslateRange) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_range_scale(s : ImagetransformtranslateRange, f : Double) -> ImagetransformtranslateRange {
  let result = image_transform_translate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_translate_range_add(a : ImagetransformtranslateRange, b : ImagetransformtranslateRange) -> ImagetransformtranslateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_translate_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_translate_range_copy(s : ImagetransformtranslateRange) -> ImagetransformtranslateRange {
  let result = image_transform_translate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_translate_range_fill(s : ImagetransformtranslateRange, v : Double) -> ImagetransformtranslateRange {
  let result = image_transform_translate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_range_min(s : ImagetransformtranslateRange) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_range_max(s : ImagetransformtranslateRange) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_range_to_string(s : ImagetransformtranslateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtranslateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_translate_slice_make(size : Int) -> ImagetransformtranslateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_translate_slice_len(s : ImagetransformtranslateSlice) -> Int { s.size }

pub fn image_transform_translate_slice_get(s : ImagetransformtranslateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_translate_slice_set(s : ImagetransformtranslateSlice, i : Int, v : Double) -> ImagetransformtranslateSlice {
  let result = image_transform_translate_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_slice_sum(s : ImagetransformtranslateSlice) -> Double { @_common.sum(s.data) }

pub fn image_transform_translate_slice_mean(s : ImagetransformtranslateSlice) -> Double { @_common.mean(s.data) }

pub fn image_transform_translate_slice_scale(s : ImagetransformtranslateSlice, f : Double) -> ImagetransformtranslateSlice {
  let result = image_transform_translate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_translate_slice_add(a : ImagetransformtranslateSlice, b : ImagetransformtranslateSlice) -> ImagetransformtranslateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_translate_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_translate_slice_copy(s : ImagetransformtranslateSlice) -> ImagetransformtranslateSlice {
  let result = image_transform_translate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_translate_slice_fill(s : ImagetransformtranslateSlice, v : Double) -> ImagetransformtranslateSlice {
  let result = image_transform_translate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_translate_slice_min(s : ImagetransformtranslateSlice) -> Double { @_common.min(s.data) }

pub fn image_transform_translate_slice_max(s : ImagetransformtranslateSlice) -> Double { @_common.max(s.data) }

pub fn image_transform_translate_slice_to_string(s : ImagetransformtranslateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

