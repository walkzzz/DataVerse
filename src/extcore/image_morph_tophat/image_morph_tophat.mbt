///===
/// extcore/image_morph_tophat

pub(all) struct ImagemorphtophatPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_tophat_make_point(x : Double, y : Double) -> ImagemorphtophatPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_tophat_make_point3(x : Double, y : Double, z : Double) -> ImagemorphtophatPoint {
  { x, y, z, label: 0 }
}

pub fn image_morph_tophat_point_x(pt : ImagemorphtophatPoint) -> Double { pt.x }

pub fn image_morph_tophat_point_y(pt : ImagemorphtophatPoint) -> Double { pt.y }

pub fn image_morph_tophat_point_z(pt : ImagemorphtophatPoint) -> Double { pt.z }

pub fn image_morph_tophat_point_label(pt : ImagemorphtophatPoint) -> Int { pt.label }

pub fn image_morph_tophat_point_dist(a : ImagemorphtophatPoint, b : ImagemorphtophatPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_morph_tophat_point_add(a : ImagemorphtophatPoint, b : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_morph_tophat_point_sub(a : ImagemorphtophatPoint, b : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_morph_tophat_point_scale(pt : ImagemorphtophatPoint, s : Double) -> ImagemorphtophatPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_morph_tophat_point_dot(a : ImagemorphtophatPoint, b : ImagemorphtophatPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_morph_tophat_point_cross(a : ImagemorphtophatPoint, b : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_morph_tophat_point_norm(pt : ImagemorphtophatPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_morph_tophat_point_normalize(pt : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  let n = image_morph_tophat_point_norm(pt)
  if n < 0.0000001 { pt } else { image_morph_tophat_point_scale(pt, 1.0 / n) }
}

pub fn image_morph_tophat_point_negate(pt : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_morph_tophat_point_mid(a : ImagemorphtophatPoint, b : ImagemorphtophatPoint) -> ImagemorphtophatPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_morph_tophat_point_lerp(a : ImagemorphtophatPoint, b : ImagemorphtophatPoint, t : Double) -> ImagemorphtophatPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_morph_tophat_point_to_string(pt : ImagemorphtophatPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagemorphtophatSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_tophat_make_series(vals : Array[Double], name : String) -> ImagemorphtophatSeries {
  { vals, name, meta: 0 }
}

pub fn image_morph_tophat_series_len(s : ImagemorphtophatSeries) -> Int { s.vals.length() }

pub fn image_morph_tophat_series_sum(s : ImagemorphtophatSeries) -> Double { @_common.sum(s.vals) }

pub fn image_morph_tophat_series_mean(s : ImagemorphtophatSeries) -> Double { @_common.mean(s.vals) }

pub fn image_morph_tophat_series_min(s : ImagemorphtophatSeries) -> Double { @_common.min(s.vals) }

pub fn image_morph_tophat_series_max(s : ImagemorphtophatSeries) -> Double { @_common.max(s.vals) }

pub fn image_morph_tophat_series_range(s : ImagemorphtophatSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_morph_tophat_series_var(s : ImagemorphtophatSeries) -> Double { @_common.variance(s.vals) }

pub fn image_morph_tophat_series_std(s : ImagemorphtophatSeries) -> Double { @_common.std(s.vals) }

pub fn image_morph_tophat_series_median(s : ImagemorphtophatSeries) -> Double { @_common.median(s.vals) }

pub fn image_morph_tophat_series_scale(s : ImagemorphtophatSeries, f : Double) -> ImagemorphtophatSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_morph_tophat_series_add(a : ImagemorphtophatSeries, b : ImagemorphtophatSeries) -> ImagemorphtophatSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_morph_tophat_series_sub(a : ImagemorphtophatSeries, b : ImagemorphtophatSeries) -> ImagemorphtophatSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_morph_tophat_series_normalize(s : ImagemorphtophatSeries) -> ImagemorphtophatSeries {
  let mn = image_morph_tophat_series_min(s)
  let mx = image_morph_tophat_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_morph_tophat_series_cumsum(s : ImagemorphtophatSeries) -> ImagemorphtophatSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_morph_tophat_series_to_string(s : ImagemorphtophatSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphtophatMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_tophat_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphtophatMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_tophat_matrix_identity(n : Int) -> ImagemorphtophatMatrix {
  let m = image_morph_tophat_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_morph_tophat_matrix_get(m : ImagemorphtophatMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_morph_tophat_matrix_transpose(m : ImagemorphtophatMatrix) -> ImagemorphtophatMatrix {
  let result = image_morph_tophat_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_morph_tophat_matrix_add(a : ImagemorphtophatMatrix, b : ImagemorphtophatMatrix) -> ImagemorphtophatMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_morph_tophat_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_morph_tophat_matrix_scale(m : ImagemorphtophatMatrix, s : Double) -> ImagemorphtophatMatrix {
  let result = image_morph_tophat_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_morph_tophat_matrix_multiply(a : ImagemorphtophatMatrix, b : ImagemorphtophatMatrix) -> ImagemorphtophatMatrix {
  if a.cols != b.rows { return image_morph_tophat_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_morph_tophat_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_morph_tophat_matrix_trace(m : ImagemorphtophatMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_morph_tophat_matrix_det(m : ImagemorphtophatMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_morph_tophat_matrix_norm(m : ImagemorphtophatMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_morph_tophat_matrix_to_string(m : ImagemorphtophatMatrix) -> String {
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

pub(all) struct ImagemorphtophatVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_tophat_make_vector(comps : Array[Double]) -> ImagemorphtophatVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_tophat_vector_zero(dim : Int) -> ImagemorphtophatVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_morph_tophat_vector_add(a : ImagemorphtophatVector, b : ImagemorphtophatVector) -> ImagemorphtophatVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_morph_tophat_vector_sub(a : ImagemorphtophatVector, b : ImagemorphtophatVector) -> ImagemorphtophatVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_morph_tophat_vector_scale(v : ImagemorphtophatVector, s : Double) -> ImagemorphtophatVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_morph_tophat_vector_dot(a : ImagemorphtophatVector, b : ImagemorphtophatVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_morph_tophat_vector_norm(v : ImagemorphtophatVector) -> Double { @_common.sqrt(image_morph_tophat_vector_dot(v, v)) }

pub fn image_morph_tophat_vector_normalize(v : ImagemorphtophatVector) -> ImagemorphtophatVector {
  let n = image_morph_tophat_vector_norm(v)
  if n < 0.0000001 { v } else { image_morph_tophat_vector_scale(v, 1.0 / n) }
}

pub fn image_morph_tophat_vector_dist(a : ImagemorphtophatVector, b : ImagemorphtophatVector) -> Double {
  image_morph_tophat_vector_norm(image_morph_tophat_vector_sub(a, b))
}

pub fn image_morph_tophat_vector_to_string(v : ImagemorphtophatVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_tophat_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_morph_tophat_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_morph_tophat_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_morph_tophat_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_morph_tophat_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_morph_tophat_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_morph_tophat_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_morph_tophat_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_morph_tophat_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_morph_tophat_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_morph_tophat_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_morph_tophat_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_morph_tophat_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_morph_tophat_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_morph_tophat_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_morph_tophat_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_morph_tophat_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_morph_tophat_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_morph_tophat_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_morph_tophat_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_morph_tophat_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_morph_tophat_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_morph_tophat_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_morph_tophat_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_morph_tophat_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_morph_tophat_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_morph_tophat_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_morph_tophat_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_morph_tophat_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagemorphtophatFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_frame_make(size : Int) -> ImagemorphtophatFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_frame_len(s : ImagemorphtophatFrame) -> Int { s.size }

pub fn image_morph_tophat_frame_get(s : ImagemorphtophatFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_frame_set(s : ImagemorphtophatFrame, i : Int, v : Double) -> ImagemorphtophatFrame {
  let result = image_morph_tophat_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_frame_sum(s : ImagemorphtophatFrame) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_frame_mean(s : ImagemorphtophatFrame) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_frame_scale(s : ImagemorphtophatFrame, f : Double) -> ImagemorphtophatFrame {
  let result = image_morph_tophat_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_frame_add(a : ImagemorphtophatFrame, b : ImagemorphtophatFrame) -> ImagemorphtophatFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_frame_copy(s : ImagemorphtophatFrame) -> ImagemorphtophatFrame {
  let result = image_morph_tophat_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_frame_fill(s : ImagemorphtophatFrame, v : Double) -> ImagemorphtophatFrame {
  let result = image_morph_tophat_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_frame_min(s : ImagemorphtophatFrame) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_frame_max(s : ImagemorphtophatFrame) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_frame_to_string(s : ImagemorphtophatFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_table_make(size : Int) -> ImagemorphtophatTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_table_len(s : ImagemorphtophatTable) -> Int { s.size }

pub fn image_morph_tophat_table_get(s : ImagemorphtophatTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_table_set(s : ImagemorphtophatTable, i : Int, v : Double) -> ImagemorphtophatTable {
  let result = image_morph_tophat_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_table_sum(s : ImagemorphtophatTable) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_table_mean(s : ImagemorphtophatTable) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_table_scale(s : ImagemorphtophatTable, f : Double) -> ImagemorphtophatTable {
  let result = image_morph_tophat_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_table_add(a : ImagemorphtophatTable, b : ImagemorphtophatTable) -> ImagemorphtophatTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_table_copy(s : ImagemorphtophatTable) -> ImagemorphtophatTable {
  let result = image_morph_tophat_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_table_fill(s : ImagemorphtophatTable, v : Double) -> ImagemorphtophatTable {
  let result = image_morph_tophat_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_table_min(s : ImagemorphtophatTable) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_table_max(s : ImagemorphtophatTable) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_table_to_string(s : ImagemorphtophatTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_graphn_make(size : Int) -> ImagemorphtophatGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_graphn_len(s : ImagemorphtophatGraphN) -> Int { s.size }

pub fn image_morph_tophat_graphn_get(s : ImagemorphtophatGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_graphn_set(s : ImagemorphtophatGraphN, i : Int, v : Double) -> ImagemorphtophatGraphN {
  let result = image_morph_tophat_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_graphn_sum(s : ImagemorphtophatGraphN) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_graphn_mean(s : ImagemorphtophatGraphN) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_graphn_scale(s : ImagemorphtophatGraphN, f : Double) -> ImagemorphtophatGraphN {
  let result = image_morph_tophat_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_graphn_add(a : ImagemorphtophatGraphN, b : ImagemorphtophatGraphN) -> ImagemorphtophatGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_graphn_copy(s : ImagemorphtophatGraphN) -> ImagemorphtophatGraphN {
  let result = image_morph_tophat_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_graphn_fill(s : ImagemorphtophatGraphN, v : Double) -> ImagemorphtophatGraphN {
  let result = image_morph_tophat_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_graphn_min(s : ImagemorphtophatGraphN) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_graphn_max(s : ImagemorphtophatGraphN) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_graphn_to_string(s : ImagemorphtophatGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_node_make(size : Int) -> ImagemorphtophatNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_node_len(s : ImagemorphtophatNode) -> Int { s.size }

pub fn image_morph_tophat_node_get(s : ImagemorphtophatNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_node_set(s : ImagemorphtophatNode, i : Int, v : Double) -> ImagemorphtophatNode {
  let result = image_morph_tophat_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_node_sum(s : ImagemorphtophatNode) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_node_mean(s : ImagemorphtophatNode) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_node_scale(s : ImagemorphtophatNode, f : Double) -> ImagemorphtophatNode {
  let result = image_morph_tophat_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_node_add(a : ImagemorphtophatNode, b : ImagemorphtophatNode) -> ImagemorphtophatNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_node_copy(s : ImagemorphtophatNode) -> ImagemorphtophatNode {
  let result = image_morph_tophat_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_node_fill(s : ImagemorphtophatNode, v : Double) -> ImagemorphtophatNode {
  let result = image_morph_tophat_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_node_min(s : ImagemorphtophatNode) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_node_max(s : ImagemorphtophatNode) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_node_to_string(s : ImagemorphtophatNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_edge_make(size : Int) -> ImagemorphtophatEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_edge_len(s : ImagemorphtophatEdge) -> Int { s.size }

pub fn image_morph_tophat_edge_get(s : ImagemorphtophatEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_edge_set(s : ImagemorphtophatEdge, i : Int, v : Double) -> ImagemorphtophatEdge {
  let result = image_morph_tophat_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_edge_sum(s : ImagemorphtophatEdge) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_edge_mean(s : ImagemorphtophatEdge) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_edge_scale(s : ImagemorphtophatEdge, f : Double) -> ImagemorphtophatEdge {
  let result = image_morph_tophat_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_edge_add(a : ImagemorphtophatEdge, b : ImagemorphtophatEdge) -> ImagemorphtophatEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_edge_copy(s : ImagemorphtophatEdge) -> ImagemorphtophatEdge {
  let result = image_morph_tophat_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_edge_fill(s : ImagemorphtophatEdge, v : Double) -> ImagemorphtophatEdge {
  let result = image_morph_tophat_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_edge_min(s : ImagemorphtophatEdge) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_edge_max(s : ImagemorphtophatEdge) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_edge_to_string(s : ImagemorphtophatEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_path_make(size : Int) -> ImagemorphtophatPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_path_len(s : ImagemorphtophatPath) -> Int { s.size }

pub fn image_morph_tophat_path_get(s : ImagemorphtophatPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_path_set(s : ImagemorphtophatPath, i : Int, v : Double) -> ImagemorphtophatPath {
  let result = image_morph_tophat_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_path_sum(s : ImagemorphtophatPath) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_path_mean(s : ImagemorphtophatPath) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_path_scale(s : ImagemorphtophatPath, f : Double) -> ImagemorphtophatPath {
  let result = image_morph_tophat_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_path_add(a : ImagemorphtophatPath, b : ImagemorphtophatPath) -> ImagemorphtophatPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_path_copy(s : ImagemorphtophatPath) -> ImagemorphtophatPath {
  let result = image_morph_tophat_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_path_fill(s : ImagemorphtophatPath, v : Double) -> ImagemorphtophatPath {
  let result = image_morph_tophat_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_path_min(s : ImagemorphtophatPath) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_path_max(s : ImagemorphtophatPath) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_path_to_string(s : ImagemorphtophatPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_cluster_make(size : Int) -> ImagemorphtophatCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_cluster_len(s : ImagemorphtophatCluster) -> Int { s.size }

pub fn image_morph_tophat_cluster_get(s : ImagemorphtophatCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_cluster_set(s : ImagemorphtophatCluster, i : Int, v : Double) -> ImagemorphtophatCluster {
  let result = image_morph_tophat_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_cluster_sum(s : ImagemorphtophatCluster) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_cluster_mean(s : ImagemorphtophatCluster) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_cluster_scale(s : ImagemorphtophatCluster, f : Double) -> ImagemorphtophatCluster {
  let result = image_morph_tophat_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_cluster_add(a : ImagemorphtophatCluster, b : ImagemorphtophatCluster) -> ImagemorphtophatCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_cluster_copy(s : ImagemorphtophatCluster) -> ImagemorphtophatCluster {
  let result = image_morph_tophat_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_cluster_fill(s : ImagemorphtophatCluster, v : Double) -> ImagemorphtophatCluster {
  let result = image_morph_tophat_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_cluster_min(s : ImagemorphtophatCluster) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_cluster_max(s : ImagemorphtophatCluster) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_cluster_to_string(s : ImagemorphtophatCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_model_make(size : Int) -> ImagemorphtophatModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_model_len(s : ImagemorphtophatModel) -> Int { s.size }

pub fn image_morph_tophat_model_get(s : ImagemorphtophatModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_model_set(s : ImagemorphtophatModel, i : Int, v : Double) -> ImagemorphtophatModel {
  let result = image_morph_tophat_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_model_sum(s : ImagemorphtophatModel) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_model_mean(s : ImagemorphtophatModel) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_model_scale(s : ImagemorphtophatModel, f : Double) -> ImagemorphtophatModel {
  let result = image_morph_tophat_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_model_add(a : ImagemorphtophatModel, b : ImagemorphtophatModel) -> ImagemorphtophatModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_model_copy(s : ImagemorphtophatModel) -> ImagemorphtophatModel {
  let result = image_morph_tophat_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_model_fill(s : ImagemorphtophatModel, v : Double) -> ImagemorphtophatModel {
  let result = image_morph_tophat_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_model_min(s : ImagemorphtophatModel) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_model_max(s : ImagemorphtophatModel) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_model_to_string(s : ImagemorphtophatModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_layer_make(size : Int) -> ImagemorphtophatLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_layer_len(s : ImagemorphtophatLayer) -> Int { s.size }

pub fn image_morph_tophat_layer_get(s : ImagemorphtophatLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_layer_set(s : ImagemorphtophatLayer, i : Int, v : Double) -> ImagemorphtophatLayer {
  let result = image_morph_tophat_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_layer_sum(s : ImagemorphtophatLayer) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_layer_mean(s : ImagemorphtophatLayer) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_layer_scale(s : ImagemorphtophatLayer, f : Double) -> ImagemorphtophatLayer {
  let result = image_morph_tophat_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_layer_add(a : ImagemorphtophatLayer, b : ImagemorphtophatLayer) -> ImagemorphtophatLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_layer_copy(s : ImagemorphtophatLayer) -> ImagemorphtophatLayer {
  let result = image_morph_tophat_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_layer_fill(s : ImagemorphtophatLayer, v : Double) -> ImagemorphtophatLayer {
  let result = image_morph_tophat_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_layer_min(s : ImagemorphtophatLayer) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_layer_max(s : ImagemorphtophatLayer) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_layer_to_string(s : ImagemorphtophatLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_buffer_make(size : Int) -> ImagemorphtophatBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_buffer_len(s : ImagemorphtophatBuffer) -> Int { s.size }

pub fn image_morph_tophat_buffer_get(s : ImagemorphtophatBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_buffer_set(s : ImagemorphtophatBuffer, i : Int, v : Double) -> ImagemorphtophatBuffer {
  let result = image_morph_tophat_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_buffer_sum(s : ImagemorphtophatBuffer) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_buffer_mean(s : ImagemorphtophatBuffer) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_buffer_scale(s : ImagemorphtophatBuffer, f : Double) -> ImagemorphtophatBuffer {
  let result = image_morph_tophat_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_buffer_add(a : ImagemorphtophatBuffer, b : ImagemorphtophatBuffer) -> ImagemorphtophatBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_buffer_copy(s : ImagemorphtophatBuffer) -> ImagemorphtophatBuffer {
  let result = image_morph_tophat_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_buffer_fill(s : ImagemorphtophatBuffer, v : Double) -> ImagemorphtophatBuffer {
  let result = image_morph_tophat_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_buffer_min(s : ImagemorphtophatBuffer) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_buffer_max(s : ImagemorphtophatBuffer) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_buffer_to_string(s : ImagemorphtophatBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_cursor_make(size : Int) -> ImagemorphtophatCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_cursor_len(s : ImagemorphtophatCursor) -> Int { s.size }

pub fn image_morph_tophat_cursor_get(s : ImagemorphtophatCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_cursor_set(s : ImagemorphtophatCursor, i : Int, v : Double) -> ImagemorphtophatCursor {
  let result = image_morph_tophat_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_cursor_sum(s : ImagemorphtophatCursor) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_cursor_mean(s : ImagemorphtophatCursor) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_cursor_scale(s : ImagemorphtophatCursor, f : Double) -> ImagemorphtophatCursor {
  let result = image_morph_tophat_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_cursor_add(a : ImagemorphtophatCursor, b : ImagemorphtophatCursor) -> ImagemorphtophatCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_cursor_copy(s : ImagemorphtophatCursor) -> ImagemorphtophatCursor {
  let result = image_morph_tophat_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_cursor_fill(s : ImagemorphtophatCursor, v : Double) -> ImagemorphtophatCursor {
  let result = image_morph_tophat_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_cursor_min(s : ImagemorphtophatCursor) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_cursor_max(s : ImagemorphtophatCursor) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_cursor_to_string(s : ImagemorphtophatCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_view_make(size : Int) -> ImagemorphtophatView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_view_len(s : ImagemorphtophatView) -> Int { s.size }

pub fn image_morph_tophat_view_get(s : ImagemorphtophatView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_view_set(s : ImagemorphtophatView, i : Int, v : Double) -> ImagemorphtophatView {
  let result = image_morph_tophat_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_view_sum(s : ImagemorphtophatView) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_view_mean(s : ImagemorphtophatView) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_view_scale(s : ImagemorphtophatView, f : Double) -> ImagemorphtophatView {
  let result = image_morph_tophat_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_view_add(a : ImagemorphtophatView, b : ImagemorphtophatView) -> ImagemorphtophatView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_view_copy(s : ImagemorphtophatView) -> ImagemorphtophatView {
  let result = image_morph_tophat_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_view_fill(s : ImagemorphtophatView, v : Double) -> ImagemorphtophatView {
  let result = image_morph_tophat_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_view_min(s : ImagemorphtophatView) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_view_max(s : ImagemorphtophatView) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_view_to_string(s : ImagemorphtophatView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_range_make(size : Int) -> ImagemorphtophatRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_range_len(s : ImagemorphtophatRange) -> Int { s.size }

pub fn image_morph_tophat_range_get(s : ImagemorphtophatRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_range_set(s : ImagemorphtophatRange, i : Int, v : Double) -> ImagemorphtophatRange {
  let result = image_morph_tophat_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_range_sum(s : ImagemorphtophatRange) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_range_mean(s : ImagemorphtophatRange) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_range_scale(s : ImagemorphtophatRange, f : Double) -> ImagemorphtophatRange {
  let result = image_morph_tophat_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_range_add(a : ImagemorphtophatRange, b : ImagemorphtophatRange) -> ImagemorphtophatRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_range_copy(s : ImagemorphtophatRange) -> ImagemorphtophatRange {
  let result = image_morph_tophat_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_range_fill(s : ImagemorphtophatRange, v : Double) -> ImagemorphtophatRange {
  let result = image_morph_tophat_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_range_min(s : ImagemorphtophatRange) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_range_max(s : ImagemorphtophatRange) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_range_to_string(s : ImagemorphtophatRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphtophatSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_tophat_slice_make(size : Int) -> ImagemorphtophatSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_tophat_slice_len(s : ImagemorphtophatSlice) -> Int { s.size }

pub fn image_morph_tophat_slice_get(s : ImagemorphtophatSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_tophat_slice_set(s : ImagemorphtophatSlice, i : Int, v : Double) -> ImagemorphtophatSlice {
  let result = image_morph_tophat_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_slice_sum(s : ImagemorphtophatSlice) -> Double { @_common.sum(s.data) }

pub fn image_morph_tophat_slice_mean(s : ImagemorphtophatSlice) -> Double { @_common.mean(s.data) }

pub fn image_morph_tophat_slice_scale(s : ImagemorphtophatSlice, f : Double) -> ImagemorphtophatSlice {
  let result = image_morph_tophat_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn image_morph_tophat_slice_add(a : ImagemorphtophatSlice, b : ImagemorphtophatSlice) -> ImagemorphtophatSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = image_morph_tophat_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn image_morph_tophat_slice_copy(s : ImagemorphtophatSlice) -> ImagemorphtophatSlice {
  let result = image_morph_tophat_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn image_morph_tophat_slice_fill(s : ImagemorphtophatSlice, v : Double) -> ImagemorphtophatSlice {
  let result = image_morph_tophat_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn image_morph_tophat_slice_min(s : ImagemorphtophatSlice) -> Double { @_common.min(s.data) }

pub fn image_morph_tophat_slice_max(s : ImagemorphtophatSlice) -> Double { @_common.max(s.data) }

pub fn image_morph_tophat_slice_to_string(s : ImagemorphtophatSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

