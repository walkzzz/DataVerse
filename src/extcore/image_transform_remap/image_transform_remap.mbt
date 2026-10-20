///===
/// extcore/image_transform_remap

pub(all) struct ImagetransformremapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_remap_make_point(x : Double, y : Double) -> ImagetransformremapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_remap_make_point3(x : Double, y : Double, z : Double) -> ImagetransformremapPoint {
  { x, y, z, label: 0 }
}

pub fn image_transform_remap_point_x(pt : ImagetransformremapPoint) -> Double { pt.x }

pub fn image_transform_remap_point_y(pt : ImagetransformremapPoint) -> Double { pt.y }

pub fn image_transform_remap_point_z(pt : ImagetransformremapPoint) -> Double { pt.z }

pub fn image_transform_remap_point_label(pt : ImagetransformremapPoint) -> Int { pt.label }

pub fn image_transform_remap_point_dist(a : ImagetransformremapPoint, b : ImagetransformremapPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_transform_remap_point_add(a : ImagetransformremapPoint, b : ImagetransformremapPoint) -> ImagetransformremapPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_transform_remap_point_sub(a : ImagetransformremapPoint, b : ImagetransformremapPoint) -> ImagetransformremapPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_transform_remap_point_scale(pt : ImagetransformremapPoint, s : Double) -> ImagetransformremapPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_transform_remap_point_dot(a : ImagetransformremapPoint, b : ImagetransformremapPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_transform_remap_point_cross(a : ImagetransformremapPoint, b : ImagetransformremapPoint) -> ImagetransformremapPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_transform_remap_point_norm(pt : ImagetransformremapPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_transform_remap_point_normalize(pt : ImagetransformremapPoint) -> ImagetransformremapPoint {
  let n = image_transform_remap_point_norm(pt)
  if n < 0.0000001 { pt } else { image_transform_remap_point_scale(pt, 1.0 / n) }
}

pub fn image_transform_remap_point_negate(pt : ImagetransformremapPoint) -> ImagetransformremapPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_transform_remap_point_mid(a : ImagetransformremapPoint, b : ImagetransformremapPoint) -> ImagetransformremapPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_transform_remap_point_lerp(a : ImagetransformremapPoint, b : ImagetransformremapPoint, t : Double) -> ImagetransformremapPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_transform_remap_point_to_string(pt : ImagetransformremapPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagetransformremapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_remap_make_series(vals : Array[Double], name : String) -> ImagetransformremapSeries {
  { vals, name, meta: 0 }
}

pub fn image_transform_remap_series_len(s : ImagetransformremapSeries) -> Int { s.vals.length() }

pub fn image_transform_remap_series_sum(s : ImagetransformremapSeries) -> Double { @_common.sum(s.vals) }

pub fn image_transform_remap_series_mean(s : ImagetransformremapSeries) -> Double { @_common.mean(s.vals) }

pub fn image_transform_remap_series_min(s : ImagetransformremapSeries) -> Double { @_common.min(s.vals) }

pub fn image_transform_remap_series_max(s : ImagetransformremapSeries) -> Double { @_common.max(s.vals) }

pub fn image_transform_remap_series_range(s : ImagetransformremapSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_transform_remap_series_var(s : ImagetransformremapSeries) -> Double { @_common.variance(s.vals) }

pub fn image_transform_remap_series_std(s : ImagetransformremapSeries) -> Double { @_common.std(s.vals) }

pub fn image_transform_remap_series_median(s : ImagetransformremapSeries) -> Double { @_common.median(s.vals) }

pub fn image_transform_remap_series_scale(s : ImagetransformremapSeries, f : Double) -> ImagetransformremapSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_transform_remap_series_add(a : ImagetransformremapSeries, b : ImagetransformremapSeries) -> ImagetransformremapSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_transform_remap_series_sub(a : ImagetransformremapSeries, b : ImagetransformremapSeries) -> ImagetransformremapSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_transform_remap_series_normalize(s : ImagetransformremapSeries) -> ImagetransformremapSeries {
  let mn = image_transform_remap_series_min(s)
  let mx = image_transform_remap_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_transform_remap_series_cumsum(s : ImagetransformremapSeries) -> ImagetransformremapSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_transform_remap_series_to_string(s : ImagetransformremapSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformremapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_remap_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformremapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_remap_matrix_identity(n : Int) -> ImagetransformremapMatrix {
  let m = image_transform_remap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_transform_remap_matrix_get(m : ImagetransformremapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_transform_remap_matrix_transpose(m : ImagetransformremapMatrix) -> ImagetransformremapMatrix {
  let result = image_transform_remap_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_transform_remap_matrix_add(a : ImagetransformremapMatrix, b : ImagetransformremapMatrix) -> ImagetransformremapMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_transform_remap_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_transform_remap_matrix_scale(m : ImagetransformremapMatrix, s : Double) -> ImagetransformremapMatrix {
  let result = image_transform_remap_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_transform_remap_matrix_multiply(a : ImagetransformremapMatrix, b : ImagetransformremapMatrix) -> ImagetransformremapMatrix {
  if a.cols != b.rows { return image_transform_remap_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_transform_remap_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_transform_remap_matrix_trace(m : ImagetransformremapMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_transform_remap_matrix_det(m : ImagetransformremapMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_transform_remap_matrix_norm(m : ImagetransformremapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_transform_remap_matrix_to_string(m : ImagetransformremapMatrix) -> String {
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

pub(all) struct ImagetransformremapVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_remap_make_vector(comps : Array[Double]) -> ImagetransformremapVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_remap_vector_zero(dim : Int) -> ImagetransformremapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_transform_remap_vector_add(a : ImagetransformremapVector, b : ImagetransformremapVector) -> ImagetransformremapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_remap_vector_sub(a : ImagetransformremapVector, b : ImagetransformremapVector) -> ImagetransformremapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_remap_vector_scale(v : ImagetransformremapVector, s : Double) -> ImagetransformremapVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_transform_remap_vector_dot(a : ImagetransformremapVector, b : ImagetransformremapVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_transform_remap_vector_norm(v : ImagetransformremapVector) -> Double { @_common.sqrt(image_transform_remap_vector_dot(v, v)) }

pub fn image_transform_remap_vector_normalize(v : ImagetransformremapVector) -> ImagetransformremapVector {
  let n = image_transform_remap_vector_norm(v)
  if n < 0.0000001 { v } else { image_transform_remap_vector_scale(v, 1.0 / n) }
}

pub fn image_transform_remap_vector_dist(a : ImagetransformremapVector, b : ImagetransformremapVector) -> Double {
  image_transform_remap_vector_norm(image_transform_remap_vector_sub(a, b))
}

pub fn image_transform_remap_vector_to_string(v : ImagetransformremapVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_remap_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_remap_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_remap_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_remap_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_remap_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_remap_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_remap_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_remap_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_remap_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_remap_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_remap_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_remap_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_remap_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_remap_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_remap_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_remap_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_remap_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_remap_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_remap_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_remap_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_remap_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_remap_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_remap_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_remap_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_remap_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_remap_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_remap_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_remap_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_remap_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformremapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_frame_make(size : Int) -> ImagetransformremapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_frame_len(s : ImagetransformremapFrame) -> Int { s.size }

pub fn image_transform_remap_frame_get(s : ImagetransformremapFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_frame_set(s : ImagetransformremapFrame, i : Int, v : Double) -> ImagetransformremapFrame {
  let result = image_transform_remap_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_frame_sum(s : ImagetransformremapFrame) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_frame_mean(s : ImagetransformremapFrame) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_frame_scale(s : ImagetransformremapFrame, f : Double) -> ImagetransformremapFrame {
  let result = image_transform_remap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_remap_frame_add(a : ImagetransformremapFrame, b : ImagetransformremapFrame) -> ImagetransformremapFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_remap_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_remap_frame_copy(s : ImagetransformremapFrame) -> ImagetransformremapFrame {
  let result = image_transform_remap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_remap_frame_fill(s : ImagetransformremapFrame, v : Double) -> ImagetransformremapFrame {
  let result = image_transform_remap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_frame_min(s : ImagetransformremapFrame) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_frame_max(s : ImagetransformremapFrame) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_frame_to_string(s : ImagetransformremapFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_table_make(size : Int) -> ImagetransformremapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_table_len(s : ImagetransformremapTable) -> Int { s.size }

pub fn image_transform_remap_table_get(s : ImagetransformremapTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_table_set(s : ImagetransformremapTable, i : Int, v : Double) -> ImagetransformremapTable {
  let result = image_transform_remap_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_table_sum(s : ImagetransformremapTable) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_table_mean(s : ImagetransformremapTable) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_table_scale(s : ImagetransformremapTable, f : Double) -> ImagetransformremapTable {
  let result = image_transform_remap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_remap_table_add(a : ImagetransformremapTable, b : ImagetransformremapTable) -> ImagetransformremapTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_remap_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_remap_table_copy(s : ImagetransformremapTable) -> ImagetransformremapTable {
  let result = image_transform_remap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_remap_table_fill(s : ImagetransformremapTable, v : Double) -> ImagetransformremapTable {
  let result = image_transform_remap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_table_min(s : ImagetransformremapTable) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_table_max(s : ImagetransformremapTable) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_table_to_string(s : ImagetransformremapTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_graphn_make(size : Int) -> ImagetransformremapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_graphn_len(s : ImagetransformremapGraphN) -> Int { s.size }

pub fn image_transform_remap_graphn_get(s : ImagetransformremapGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_graphn_set(s : ImagetransformremapGraphN, i : Int, v : Double) -> ImagetransformremapGraphN {
  let result = image_transform_remap_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_graphn_sum(s : ImagetransformremapGraphN) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_graphn_mean(s : ImagetransformremapGraphN) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_graphn_scale(s : ImagetransformremapGraphN, f : Double) -> ImagetransformremapGraphN {
  let result = image_transform_remap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_remap_graphn_add(a : ImagetransformremapGraphN, b : ImagetransformremapGraphN) -> ImagetransformremapGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_remap_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_remap_graphn_copy(s : ImagetransformremapGraphN) -> ImagetransformremapGraphN {
  let result = image_transform_remap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_remap_graphn_fill(s : ImagetransformremapGraphN, v : Double) -> ImagetransformremapGraphN {
  let result = image_transform_remap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_graphn_min(s : ImagetransformremapGraphN) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_graphn_max(s : ImagetransformremapGraphN) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_graphn_to_string(s : ImagetransformremapGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_node_make(size : Int) -> ImagetransformremapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_node_len(s : ImagetransformremapNode) -> Int { s.size }

pub fn image_transform_remap_node_get(s : ImagetransformremapNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_node_set(s : ImagetransformremapNode, i : Int, v : Double) -> ImagetransformremapNode {
  let result = image_transform_remap_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_node_sum(s : ImagetransformremapNode) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_node_mean(s : ImagetransformremapNode) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_node_scale(s : ImagetransformremapNode, f : Double) -> ImagetransformremapNode {
  let result = image_transform_remap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_remap_node_add(a : ImagetransformremapNode, b : ImagetransformremapNode) -> ImagetransformremapNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_remap_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_remap_node_copy(s : ImagetransformremapNode) -> ImagetransformremapNode {
  let result = image_transform_remap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_remap_node_fill(s : ImagetransformremapNode, v : Double) -> ImagetransformremapNode {
  let result = image_transform_remap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_node_min(s : ImagetransformremapNode) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_node_max(s : ImagetransformremapNode) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_node_to_string(s : ImagetransformremapNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_edge_make(size : Int) -> ImagetransformremapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_edge_len(s : ImagetransformremapEdge) -> Int { s.size }

pub fn image_transform_remap_edge_get(s : ImagetransformremapEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_edge_set(s : ImagetransformremapEdge, i : Int, v : Double) -> ImagetransformremapEdge {
  let result = image_transform_remap_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_edge_sum(s : ImagetransformremapEdge) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_edge_mean(s : ImagetransformremapEdge) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_edge_scale(s : ImagetransformremapEdge, f : Double) -> ImagetransformremapEdge {
  let result = image_transform_remap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_remap_edge_add(a : ImagetransformremapEdge, b : ImagetransformremapEdge) -> ImagetransformremapEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_remap_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_remap_edge_copy(s : ImagetransformremapEdge) -> ImagetransformremapEdge {
  let result = image_transform_remap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_remap_edge_fill(s : ImagetransformremapEdge, v : Double) -> ImagetransformremapEdge {
  let result = image_transform_remap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_edge_min(s : ImagetransformremapEdge) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_edge_max(s : ImagetransformremapEdge) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_edge_to_string(s : ImagetransformremapEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_path_make(size : Int) -> ImagetransformremapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_path_len(s : ImagetransformremapPath) -> Int { s.size }

pub fn image_transform_remap_path_get(s : ImagetransformremapPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_path_set(s : ImagetransformremapPath, i : Int, v : Double) -> ImagetransformremapPath {
  let result = image_transform_remap_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_path_sum(s : ImagetransformremapPath) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_path_mean(s : ImagetransformremapPath) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_path_scale(s : ImagetransformremapPath, f : Double) -> ImagetransformremapPath {
  let result = image_transform_remap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_remap_path_add(a : ImagetransformremapPath, b : ImagetransformremapPath) -> ImagetransformremapPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_remap_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_remap_path_copy(s : ImagetransformremapPath) -> ImagetransformremapPath {
  let result = image_transform_remap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_remap_path_fill(s : ImagetransformremapPath, v : Double) -> ImagetransformremapPath {
  let result = image_transform_remap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_path_min(s : ImagetransformremapPath) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_path_max(s : ImagetransformremapPath) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_path_to_string(s : ImagetransformremapPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_cluster_make(size : Int) -> ImagetransformremapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_cluster_len(s : ImagetransformremapCluster) -> Int { s.size }

pub fn image_transform_remap_cluster_get(s : ImagetransformremapCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_cluster_set(s : ImagetransformremapCluster, i : Int, v : Double) -> ImagetransformremapCluster {
  let result = image_transform_remap_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_cluster_sum(s : ImagetransformremapCluster) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_cluster_mean(s : ImagetransformremapCluster) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_cluster_scale(s : ImagetransformremapCluster, f : Double) -> ImagetransformremapCluster {
  let result = image_transform_remap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_remap_cluster_add(a : ImagetransformremapCluster, b : ImagetransformremapCluster) -> ImagetransformremapCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_remap_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_remap_cluster_copy(s : ImagetransformremapCluster) -> ImagetransformremapCluster {
  let result = image_transform_remap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_remap_cluster_fill(s : ImagetransformremapCluster, v : Double) -> ImagetransformremapCluster {
  let result = image_transform_remap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_cluster_min(s : ImagetransformremapCluster) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_cluster_max(s : ImagetransformremapCluster) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_cluster_to_string(s : ImagetransformremapCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_model_make(size : Int) -> ImagetransformremapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_model_len(s : ImagetransformremapModel) -> Int { s.size }

pub fn image_transform_remap_model_get(s : ImagetransformremapModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_model_set(s : ImagetransformremapModel, i : Int, v : Double) -> ImagetransformremapModel {
  let result = image_transform_remap_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_model_sum(s : ImagetransformremapModel) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_model_mean(s : ImagetransformremapModel) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_model_scale(s : ImagetransformremapModel, f : Double) -> ImagetransformremapModel {
  let result = image_transform_remap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_remap_model_add(a : ImagetransformremapModel, b : ImagetransformremapModel) -> ImagetransformremapModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_remap_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_remap_model_copy(s : ImagetransformremapModel) -> ImagetransformremapModel {
  let result = image_transform_remap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_remap_model_fill(s : ImagetransformremapModel, v : Double) -> ImagetransformremapModel {
  let result = image_transform_remap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_model_min(s : ImagetransformremapModel) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_model_max(s : ImagetransformremapModel) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_model_to_string(s : ImagetransformremapModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_layer_make(size : Int) -> ImagetransformremapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_layer_len(s : ImagetransformremapLayer) -> Int { s.size }

pub fn image_transform_remap_layer_get(s : ImagetransformremapLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_layer_set(s : ImagetransformremapLayer, i : Int, v : Double) -> ImagetransformremapLayer {
  let result = image_transform_remap_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_layer_sum(s : ImagetransformremapLayer) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_layer_mean(s : ImagetransformremapLayer) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_layer_scale(s : ImagetransformremapLayer, f : Double) -> ImagetransformremapLayer {
  let result = image_transform_remap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_remap_layer_add(a : ImagetransformremapLayer, b : ImagetransformremapLayer) -> ImagetransformremapLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_remap_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_remap_layer_copy(s : ImagetransformremapLayer) -> ImagetransformremapLayer {
  let result = image_transform_remap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_remap_layer_fill(s : ImagetransformremapLayer, v : Double) -> ImagetransformremapLayer {
  let result = image_transform_remap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_layer_min(s : ImagetransformremapLayer) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_layer_max(s : ImagetransformremapLayer) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_layer_to_string(s : ImagetransformremapLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_buffer_make(size : Int) -> ImagetransformremapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_buffer_len(s : ImagetransformremapBuffer) -> Int { s.size }

pub fn image_transform_remap_buffer_get(s : ImagetransformremapBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_buffer_set(s : ImagetransformremapBuffer, i : Int, v : Double) -> ImagetransformremapBuffer {
  let result = image_transform_remap_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_buffer_sum(s : ImagetransformremapBuffer) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_buffer_mean(s : ImagetransformremapBuffer) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_buffer_scale(s : ImagetransformremapBuffer, f : Double) -> ImagetransformremapBuffer {
  let result = image_transform_remap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_remap_buffer_add(a : ImagetransformremapBuffer, b : ImagetransformremapBuffer) -> ImagetransformremapBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_remap_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_remap_buffer_copy(s : ImagetransformremapBuffer) -> ImagetransformremapBuffer {
  let result = image_transform_remap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_remap_buffer_fill(s : ImagetransformremapBuffer, v : Double) -> ImagetransformremapBuffer {
  let result = image_transform_remap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_buffer_min(s : ImagetransformremapBuffer) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_buffer_max(s : ImagetransformremapBuffer) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_buffer_to_string(s : ImagetransformremapBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_cursor_make(size : Int) -> ImagetransformremapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_cursor_len(s : ImagetransformremapCursor) -> Int { s.size }

pub fn image_transform_remap_cursor_get(s : ImagetransformremapCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_cursor_set(s : ImagetransformremapCursor, i : Int, v : Double) -> ImagetransformremapCursor {
  let result = image_transform_remap_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_cursor_sum(s : ImagetransformremapCursor) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_cursor_mean(s : ImagetransformremapCursor) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_cursor_scale(s : ImagetransformremapCursor, f : Double) -> ImagetransformremapCursor {
  let result = image_transform_remap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_remap_cursor_add(a : ImagetransformremapCursor, b : ImagetransformremapCursor) -> ImagetransformremapCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_remap_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_remap_cursor_copy(s : ImagetransformremapCursor) -> ImagetransformremapCursor {
  let result = image_transform_remap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_remap_cursor_fill(s : ImagetransformremapCursor, v : Double) -> ImagetransformremapCursor {
  let result = image_transform_remap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_cursor_min(s : ImagetransformremapCursor) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_cursor_max(s : ImagetransformremapCursor) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_cursor_to_string(s : ImagetransformremapCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_view_make(size : Int) -> ImagetransformremapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_view_len(s : ImagetransformremapView) -> Int { s.size }

pub fn image_transform_remap_view_get(s : ImagetransformremapView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_view_set(s : ImagetransformremapView, i : Int, v : Double) -> ImagetransformremapView {
  let result = image_transform_remap_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_view_sum(s : ImagetransformremapView) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_view_mean(s : ImagetransformremapView) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_view_scale(s : ImagetransformremapView, f : Double) -> ImagetransformremapView {
  let result = image_transform_remap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_remap_view_add(a : ImagetransformremapView, b : ImagetransformremapView) -> ImagetransformremapView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_remap_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_remap_view_copy(s : ImagetransformremapView) -> ImagetransformremapView {
  let result = image_transform_remap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_remap_view_fill(s : ImagetransformremapView, v : Double) -> ImagetransformremapView {
  let result = image_transform_remap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_view_min(s : ImagetransformremapView) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_view_max(s : ImagetransformremapView) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_view_to_string(s : ImagetransformremapView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_range_make(size : Int) -> ImagetransformremapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_range_len(s : ImagetransformremapRange) -> Int { s.size }

pub fn image_transform_remap_range_get(s : ImagetransformremapRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_range_set(s : ImagetransformremapRange, i : Int, v : Double) -> ImagetransformremapRange {
  let result = image_transform_remap_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_range_sum(s : ImagetransformremapRange) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_range_mean(s : ImagetransformremapRange) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_range_scale(s : ImagetransformremapRange, f : Double) -> ImagetransformremapRange {
  let result = image_transform_remap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_remap_range_add(a : ImagetransformremapRange, b : ImagetransformremapRange) -> ImagetransformremapRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_remap_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_remap_range_copy(s : ImagetransformremapRange) -> ImagetransformremapRange {
  let result = image_transform_remap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_remap_range_fill(s : ImagetransformremapRange, v : Double) -> ImagetransformremapRange {
  let result = image_transform_remap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_range_min(s : ImagetransformremapRange) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_range_max(s : ImagetransformremapRange) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_range_to_string(s : ImagetransformremapRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformremapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_remap_slice_make(size : Int) -> ImagetransformremapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_remap_slice_len(s : ImagetransformremapSlice) -> Int { s.size }

pub fn image_transform_remap_slice_get(s : ImagetransformremapSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_remap_slice_set(s : ImagetransformremapSlice, i : Int, v : Double) -> ImagetransformremapSlice {
  let result = image_transform_remap_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_slice_sum(s : ImagetransformremapSlice) -> Double { @_common.sum(s.data) }

pub fn image_transform_remap_slice_mean(s : ImagetransformremapSlice) -> Double { @_common.mean(s.data) }

pub fn image_transform_remap_slice_scale(s : ImagetransformremapSlice, f : Double) -> ImagetransformremapSlice {
  let result = image_transform_remap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_transform_remap_slice_add(a : ImagetransformremapSlice, b : ImagetransformremapSlice) -> ImagetransformremapSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_transform_remap_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_transform_remap_slice_copy(s : ImagetransformremapSlice) -> ImagetransformremapSlice {
  let result = image_transform_remap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_transform_remap_slice_fill(s : ImagetransformremapSlice, v : Double) -> ImagetransformremapSlice {
  let result = image_transform_remap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_transform_remap_slice_min(s : ImagetransformremapSlice) -> Double { @_common.min(s.data) }

pub fn image_transform_remap_slice_max(s : ImagetransformremapSlice) -> Double { @_common.max(s.data) }

pub fn image_transform_remap_slice_to_string(s : ImagetransformremapSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

