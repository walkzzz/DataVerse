///===
/// extcore/image_morph_gradient

pub(all) struct ImagemorphgradientPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_gradient_make_point(x : Double, y : Double) -> ImagemorphgradientPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_gradient_make_point3(x : Double, y : Double, z : Double) -> ImagemorphgradientPoint {
  { x, y, z, label: 0 }
}

pub fn image_morph_gradient_point_x(pt : ImagemorphgradientPoint) -> Double { pt.x }

pub fn image_morph_gradient_point_y(pt : ImagemorphgradientPoint) -> Double { pt.y }

pub fn image_morph_gradient_point_z(pt : ImagemorphgradientPoint) -> Double { pt.z }

pub fn image_morph_gradient_point_label(pt : ImagemorphgradientPoint) -> Int { pt.label }

pub fn image_morph_gradient_point_dist(a : ImagemorphgradientPoint, b : ImagemorphgradientPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_morph_gradient_point_add(a : ImagemorphgradientPoint, b : ImagemorphgradientPoint) -> ImagemorphgradientPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_morph_gradient_point_sub(a : ImagemorphgradientPoint, b : ImagemorphgradientPoint) -> ImagemorphgradientPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_morph_gradient_point_scale(pt : ImagemorphgradientPoint, s : Double) -> ImagemorphgradientPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_morph_gradient_point_dot(a : ImagemorphgradientPoint, b : ImagemorphgradientPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_morph_gradient_point_cross(a : ImagemorphgradientPoint, b : ImagemorphgradientPoint) -> ImagemorphgradientPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_morph_gradient_point_norm(pt : ImagemorphgradientPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_morph_gradient_point_normalize(pt : ImagemorphgradientPoint) -> ImagemorphgradientPoint {
  let n = image_morph_gradient_point_norm(pt)
  if n < 0.0000001 { pt } else { image_morph_gradient_point_scale(pt, 1.0 / n) }
}

pub fn image_morph_gradient_point_negate(pt : ImagemorphgradientPoint) -> ImagemorphgradientPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_morph_gradient_point_mid(a : ImagemorphgradientPoint, b : ImagemorphgradientPoint) -> ImagemorphgradientPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_morph_gradient_point_lerp(a : ImagemorphgradientPoint, b : ImagemorphgradientPoint, t : Double) -> ImagemorphgradientPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_morph_gradient_point_to_string(pt : ImagemorphgradientPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagemorphgradientSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_gradient_make_series(vals : Array[Double], name : String) -> ImagemorphgradientSeries {
  { vals, name, meta: 0 }
}

pub fn image_morph_gradient_series_len(s : ImagemorphgradientSeries) -> Int { s.vals.length() }

pub fn image_morph_gradient_series_sum(s : ImagemorphgradientSeries) -> Double { @_common.sum(s.vals) }

pub fn image_morph_gradient_series_mean(s : ImagemorphgradientSeries) -> Double { @_common.mean(s.vals) }

pub fn image_morph_gradient_series_min(s : ImagemorphgradientSeries) -> Double { @_common.min(s.vals) }

pub fn image_morph_gradient_series_max(s : ImagemorphgradientSeries) -> Double { @_common.max(s.vals) }

pub fn image_morph_gradient_series_range(s : ImagemorphgradientSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_morph_gradient_series_var(s : ImagemorphgradientSeries) -> Double { @_common.variance(s.vals) }

pub fn image_morph_gradient_series_std(s : ImagemorphgradientSeries) -> Double { @_common.std(s.vals) }

pub fn image_morph_gradient_series_median(s : ImagemorphgradientSeries) -> Double { @_common.median(s.vals) }

pub fn image_morph_gradient_series_scale(s : ImagemorphgradientSeries, f : Double) -> ImagemorphgradientSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn image_morph_gradient_series_add(a : ImagemorphgradientSeries, b : ImagemorphgradientSeries) -> ImagemorphgradientSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_morph_gradient_series_sub(a : ImagemorphgradientSeries, b : ImagemorphgradientSeries) -> ImagemorphgradientSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_morph_gradient_series_normalize(s : ImagemorphgradientSeries) -> ImagemorphgradientSeries {
  let mn = image_morph_gradient_series_min(s)
  let mx = image_morph_gradient_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_morph_gradient_series_cumsum(s : ImagemorphgradientSeries) -> ImagemorphgradientSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_morph_gradient_series_to_string(s : ImagemorphgradientSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphgradientMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_gradient_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphgradientMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_gradient_matrix_identity(n : Int) -> ImagemorphgradientMatrix {
  let m = image_morph_gradient_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_morph_gradient_matrix_get(m : ImagemorphgradientMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_morph_gradient_matrix_transpose(m : ImagemorphgradientMatrix) -> ImagemorphgradientMatrix {
  let result = image_morph_gradient_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_morph_gradient_matrix_add(a : ImagemorphgradientMatrix, b : ImagemorphgradientMatrix) -> ImagemorphgradientMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_morph_gradient_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_morph_gradient_matrix_scale(m : ImagemorphgradientMatrix, s : Double) -> ImagemorphgradientMatrix {
  let result = image_morph_gradient_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_morph_gradient_matrix_multiply(a : ImagemorphgradientMatrix, b : ImagemorphgradientMatrix) -> ImagemorphgradientMatrix {
  if a.cols != b.rows { return image_morph_gradient_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_morph_gradient_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_morph_gradient_matrix_trace(m : ImagemorphgradientMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_morph_gradient_matrix_det(m : ImagemorphgradientMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_morph_gradient_matrix_norm(m : ImagemorphgradientMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_morph_gradient_matrix_to_string(m : ImagemorphgradientMatrix) -> String {
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

pub(all) struct ImagemorphgradientVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_gradient_make_vector(comps : Array[Double]) -> ImagemorphgradientVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_gradient_vector_zero(dim : Int) -> ImagemorphgradientVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_morph_gradient_vector_add(a : ImagemorphgradientVector, b : ImagemorphgradientVector) -> ImagemorphgradientVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn image_morph_gradient_vector_sub(a : ImagemorphgradientVector, b : ImagemorphgradientVector) -> ImagemorphgradientVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn image_morph_gradient_vector_scale(v : ImagemorphgradientVector, s : Double) -> ImagemorphgradientVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn image_morph_gradient_vector_dot(a : ImagemorphgradientVector, b : ImagemorphgradientVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_morph_gradient_vector_norm(v : ImagemorphgradientVector) -> Double { @_common.sqrt(image_morph_gradient_vector_dot(v, v)) }

pub fn image_morph_gradient_vector_normalize(v : ImagemorphgradientVector) -> ImagemorphgradientVector {
  let n = image_morph_gradient_vector_norm(v)
  if n < 0.0000001 { v } else { image_morph_gradient_vector_scale(v, 1.0 / n) }
}

pub fn image_morph_gradient_vector_dist(a : ImagemorphgradientVector, b : ImagemorphgradientVector) -> Double {
  image_morph_gradient_vector_norm(image_morph_gradient_vector_sub(a, b))
}

pub fn image_morph_gradient_vector_to_string(v : ImagemorphgradientVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_gradient_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_morph_gradient_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_morph_gradient_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_morph_gradient_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_morph_gradient_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_morph_gradient_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_morph_gradient_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_morph_gradient_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_morph_gradient_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_morph_gradient_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_morph_gradient_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_morph_gradient_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_morph_gradient_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_morph_gradient_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_morph_gradient_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_morph_gradient_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_morph_gradient_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_morph_gradient_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_morph_gradient_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_morph_gradient_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_morph_gradient_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_morph_gradient_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_morph_gradient_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_morph_gradient_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_morph_gradient_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_morph_gradient_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_morph_gradient_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_morph_gradient_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_morph_gradient_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagemorphgradientFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_frame_make(size : Int) -> ImagemorphgradientFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_frame_len(s : ImagemorphgradientFrame) -> Int { s.size }

pub fn image_morph_gradient_frame_get(s : ImagemorphgradientFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_frame_set(s : ImagemorphgradientFrame, i : Int, v : Double) -> ImagemorphgradientFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_frame_sum(s : ImagemorphgradientFrame) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_frame_mean(s : ImagemorphgradientFrame) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_frame_scale(s : ImagemorphgradientFrame, f : Double) -> ImagemorphgradientFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_frame_add(a : ImagemorphgradientFrame, b : ImagemorphgradientFrame) -> ImagemorphgradientFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_frame_copy(s : ImagemorphgradientFrame) -> ImagemorphgradientFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_frame_fill(s : ImagemorphgradientFrame, v : Double) -> ImagemorphgradientFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_frame_min(s : ImagemorphgradientFrame) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_frame_max(s : ImagemorphgradientFrame) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_frame_to_string(s : ImagemorphgradientFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_table_make(size : Int) -> ImagemorphgradientTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_table_len(s : ImagemorphgradientTable) -> Int { s.size }

pub fn image_morph_gradient_table_get(s : ImagemorphgradientTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_table_set(s : ImagemorphgradientTable, i : Int, v : Double) -> ImagemorphgradientTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_table_sum(s : ImagemorphgradientTable) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_table_mean(s : ImagemorphgradientTable) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_table_scale(s : ImagemorphgradientTable, f : Double) -> ImagemorphgradientTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_table_add(a : ImagemorphgradientTable, b : ImagemorphgradientTable) -> ImagemorphgradientTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_table_copy(s : ImagemorphgradientTable) -> ImagemorphgradientTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_table_fill(s : ImagemorphgradientTable, v : Double) -> ImagemorphgradientTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_table_min(s : ImagemorphgradientTable) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_table_max(s : ImagemorphgradientTable) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_table_to_string(s : ImagemorphgradientTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_graphn_make(size : Int) -> ImagemorphgradientGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_graphn_len(s : ImagemorphgradientGraphN) -> Int { s.size }

pub fn image_morph_gradient_graphn_get(s : ImagemorphgradientGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_graphn_set(s : ImagemorphgradientGraphN, i : Int, v : Double) -> ImagemorphgradientGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_graphn_sum(s : ImagemorphgradientGraphN) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_graphn_mean(s : ImagemorphgradientGraphN) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_graphn_scale(s : ImagemorphgradientGraphN, f : Double) -> ImagemorphgradientGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_graphn_add(a : ImagemorphgradientGraphN, b : ImagemorphgradientGraphN) -> ImagemorphgradientGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_graphn_copy(s : ImagemorphgradientGraphN) -> ImagemorphgradientGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_graphn_fill(s : ImagemorphgradientGraphN, v : Double) -> ImagemorphgradientGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_graphn_min(s : ImagemorphgradientGraphN) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_graphn_max(s : ImagemorphgradientGraphN) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_graphn_to_string(s : ImagemorphgradientGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_node_make(size : Int) -> ImagemorphgradientNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_node_len(s : ImagemorphgradientNode) -> Int { s.size }

pub fn image_morph_gradient_node_get(s : ImagemorphgradientNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_node_set(s : ImagemorphgradientNode, i : Int, v : Double) -> ImagemorphgradientNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_node_sum(s : ImagemorphgradientNode) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_node_mean(s : ImagemorphgradientNode) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_node_scale(s : ImagemorphgradientNode, f : Double) -> ImagemorphgradientNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_node_add(a : ImagemorphgradientNode, b : ImagemorphgradientNode) -> ImagemorphgradientNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_node_copy(s : ImagemorphgradientNode) -> ImagemorphgradientNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_node_fill(s : ImagemorphgradientNode, v : Double) -> ImagemorphgradientNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_node_min(s : ImagemorphgradientNode) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_node_max(s : ImagemorphgradientNode) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_node_to_string(s : ImagemorphgradientNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_edge_make(size : Int) -> ImagemorphgradientEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_edge_len(s : ImagemorphgradientEdge) -> Int { s.size }

pub fn image_morph_gradient_edge_get(s : ImagemorphgradientEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_edge_set(s : ImagemorphgradientEdge, i : Int, v : Double) -> ImagemorphgradientEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_edge_sum(s : ImagemorphgradientEdge) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_edge_mean(s : ImagemorphgradientEdge) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_edge_scale(s : ImagemorphgradientEdge, f : Double) -> ImagemorphgradientEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_edge_add(a : ImagemorphgradientEdge, b : ImagemorphgradientEdge) -> ImagemorphgradientEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_edge_copy(s : ImagemorphgradientEdge) -> ImagemorphgradientEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_edge_fill(s : ImagemorphgradientEdge, v : Double) -> ImagemorphgradientEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_edge_min(s : ImagemorphgradientEdge) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_edge_max(s : ImagemorphgradientEdge) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_edge_to_string(s : ImagemorphgradientEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_path_make(size : Int) -> ImagemorphgradientPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_path_len(s : ImagemorphgradientPath) -> Int { s.size }

pub fn image_morph_gradient_path_get(s : ImagemorphgradientPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_path_set(s : ImagemorphgradientPath, i : Int, v : Double) -> ImagemorphgradientPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_path_sum(s : ImagemorphgradientPath) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_path_mean(s : ImagemorphgradientPath) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_path_scale(s : ImagemorphgradientPath, f : Double) -> ImagemorphgradientPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_path_add(a : ImagemorphgradientPath, b : ImagemorphgradientPath) -> ImagemorphgradientPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_path_copy(s : ImagemorphgradientPath) -> ImagemorphgradientPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_path_fill(s : ImagemorphgradientPath, v : Double) -> ImagemorphgradientPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_path_min(s : ImagemorphgradientPath) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_path_max(s : ImagemorphgradientPath) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_path_to_string(s : ImagemorphgradientPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_cluster_make(size : Int) -> ImagemorphgradientCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_cluster_len(s : ImagemorphgradientCluster) -> Int { s.size }

pub fn image_morph_gradient_cluster_get(s : ImagemorphgradientCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_cluster_set(s : ImagemorphgradientCluster, i : Int, v : Double) -> ImagemorphgradientCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_cluster_sum(s : ImagemorphgradientCluster) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_cluster_mean(s : ImagemorphgradientCluster) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_cluster_scale(s : ImagemorphgradientCluster, f : Double) -> ImagemorphgradientCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_cluster_add(a : ImagemorphgradientCluster, b : ImagemorphgradientCluster) -> ImagemorphgradientCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_cluster_copy(s : ImagemorphgradientCluster) -> ImagemorphgradientCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_cluster_fill(s : ImagemorphgradientCluster, v : Double) -> ImagemorphgradientCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_cluster_min(s : ImagemorphgradientCluster) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_cluster_max(s : ImagemorphgradientCluster) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_cluster_to_string(s : ImagemorphgradientCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_model_make(size : Int) -> ImagemorphgradientModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_model_len(s : ImagemorphgradientModel) -> Int { s.size }

pub fn image_morph_gradient_model_get(s : ImagemorphgradientModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_model_set(s : ImagemorphgradientModel, i : Int, v : Double) -> ImagemorphgradientModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_model_sum(s : ImagemorphgradientModel) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_model_mean(s : ImagemorphgradientModel) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_model_scale(s : ImagemorphgradientModel, f : Double) -> ImagemorphgradientModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_model_add(a : ImagemorphgradientModel, b : ImagemorphgradientModel) -> ImagemorphgradientModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_model_copy(s : ImagemorphgradientModel) -> ImagemorphgradientModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_model_fill(s : ImagemorphgradientModel, v : Double) -> ImagemorphgradientModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_model_min(s : ImagemorphgradientModel) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_model_max(s : ImagemorphgradientModel) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_model_to_string(s : ImagemorphgradientModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_layer_make(size : Int) -> ImagemorphgradientLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_layer_len(s : ImagemorphgradientLayer) -> Int { s.size }

pub fn image_morph_gradient_layer_get(s : ImagemorphgradientLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_layer_set(s : ImagemorphgradientLayer, i : Int, v : Double) -> ImagemorphgradientLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_layer_sum(s : ImagemorphgradientLayer) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_layer_mean(s : ImagemorphgradientLayer) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_layer_scale(s : ImagemorphgradientLayer, f : Double) -> ImagemorphgradientLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_layer_add(a : ImagemorphgradientLayer, b : ImagemorphgradientLayer) -> ImagemorphgradientLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_layer_copy(s : ImagemorphgradientLayer) -> ImagemorphgradientLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_layer_fill(s : ImagemorphgradientLayer, v : Double) -> ImagemorphgradientLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_layer_min(s : ImagemorphgradientLayer) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_layer_max(s : ImagemorphgradientLayer) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_layer_to_string(s : ImagemorphgradientLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_buffer_make(size : Int) -> ImagemorphgradientBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_buffer_len(s : ImagemorphgradientBuffer) -> Int { s.size }

pub fn image_morph_gradient_buffer_get(s : ImagemorphgradientBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_buffer_set(s : ImagemorphgradientBuffer, i : Int, v : Double) -> ImagemorphgradientBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_buffer_sum(s : ImagemorphgradientBuffer) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_buffer_mean(s : ImagemorphgradientBuffer) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_buffer_scale(s : ImagemorphgradientBuffer, f : Double) -> ImagemorphgradientBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_buffer_add(a : ImagemorphgradientBuffer, b : ImagemorphgradientBuffer) -> ImagemorphgradientBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_buffer_copy(s : ImagemorphgradientBuffer) -> ImagemorphgradientBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_buffer_fill(s : ImagemorphgradientBuffer, v : Double) -> ImagemorphgradientBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_buffer_min(s : ImagemorphgradientBuffer) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_buffer_max(s : ImagemorphgradientBuffer) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_buffer_to_string(s : ImagemorphgradientBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_cursor_make(size : Int) -> ImagemorphgradientCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_cursor_len(s : ImagemorphgradientCursor) -> Int { s.size }

pub fn image_morph_gradient_cursor_get(s : ImagemorphgradientCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_cursor_set(s : ImagemorphgradientCursor, i : Int, v : Double) -> ImagemorphgradientCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_cursor_sum(s : ImagemorphgradientCursor) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_cursor_mean(s : ImagemorphgradientCursor) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_cursor_scale(s : ImagemorphgradientCursor, f : Double) -> ImagemorphgradientCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_cursor_add(a : ImagemorphgradientCursor, b : ImagemorphgradientCursor) -> ImagemorphgradientCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_cursor_copy(s : ImagemorphgradientCursor) -> ImagemorphgradientCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_cursor_fill(s : ImagemorphgradientCursor, v : Double) -> ImagemorphgradientCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_cursor_min(s : ImagemorphgradientCursor) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_cursor_max(s : ImagemorphgradientCursor) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_cursor_to_string(s : ImagemorphgradientCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_view_make(size : Int) -> ImagemorphgradientView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_view_len(s : ImagemorphgradientView) -> Int { s.size }

pub fn image_morph_gradient_view_get(s : ImagemorphgradientView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_view_set(s : ImagemorphgradientView, i : Int, v : Double) -> ImagemorphgradientView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_view_sum(s : ImagemorphgradientView) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_view_mean(s : ImagemorphgradientView) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_view_scale(s : ImagemorphgradientView, f : Double) -> ImagemorphgradientView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_view_add(a : ImagemorphgradientView, b : ImagemorphgradientView) -> ImagemorphgradientView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_view_copy(s : ImagemorphgradientView) -> ImagemorphgradientView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_view_fill(s : ImagemorphgradientView, v : Double) -> ImagemorphgradientView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_view_min(s : ImagemorphgradientView) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_view_max(s : ImagemorphgradientView) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_view_to_string(s : ImagemorphgradientView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_range_make(size : Int) -> ImagemorphgradientRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_range_len(s : ImagemorphgradientRange) -> Int { s.size }

pub fn image_morph_gradient_range_get(s : ImagemorphgradientRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_range_set(s : ImagemorphgradientRange, i : Int, v : Double) -> ImagemorphgradientRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_range_sum(s : ImagemorphgradientRange) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_range_mean(s : ImagemorphgradientRange) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_range_scale(s : ImagemorphgradientRange, f : Double) -> ImagemorphgradientRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_range_add(a : ImagemorphgradientRange, b : ImagemorphgradientRange) -> ImagemorphgradientRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_range_copy(s : ImagemorphgradientRange) -> ImagemorphgradientRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_range_fill(s : ImagemorphgradientRange, v : Double) -> ImagemorphgradientRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_range_min(s : ImagemorphgradientRange) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_range_max(s : ImagemorphgradientRange) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_range_to_string(s : ImagemorphgradientRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphgradientSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_gradient_slice_make(size : Int) -> ImagemorphgradientSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_gradient_slice_len(s : ImagemorphgradientSlice) -> Int { s.size }

pub fn image_morph_gradient_slice_get(s : ImagemorphgradientSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_gradient_slice_set(s : ImagemorphgradientSlice, i : Int, v : Double) -> ImagemorphgradientSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_slice_sum(s : ImagemorphgradientSlice) -> Double { @_common.sum(s.data) }

pub fn image_morph_gradient_slice_mean(s : ImagemorphgradientSlice) -> Double { @_common.mean(s.data) }

pub fn image_morph_gradient_slice_scale(s : ImagemorphgradientSlice, f : Double) -> ImagemorphgradientSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_slice_add(a : ImagemorphgradientSlice, b : ImagemorphgradientSlice) -> ImagemorphgradientSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_gradient_slice_copy(s : ImagemorphgradientSlice) -> ImagemorphgradientSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_slice_fill(s : ImagemorphgradientSlice, v : Double) -> ImagemorphgradientSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_gradient_slice_min(s : ImagemorphgradientSlice) -> Double { @_common.min(s.data) }

pub fn image_morph_gradient_slice_max(s : ImagemorphgradientSlice) -> Double { @_common.max(s.data) }

pub fn image_morph_gradient_slice_to_string(s : ImagemorphgradientSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

