///===
/// extcore/image_morph_thickening

pub(all) struct ImagemorphthickeningPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_thickening_make_point(x : Double, y : Double) -> ImagemorphthickeningPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_thickening_make_point3(x : Double, y : Double, z : Double) -> ImagemorphthickeningPoint {
  { x, y, z, label: 0 }
}

pub fn image_morph_thickening_point_x(pt : ImagemorphthickeningPoint) -> Double { pt.x }

pub fn image_morph_thickening_point_y(pt : ImagemorphthickeningPoint) -> Double { pt.y }

pub fn image_morph_thickening_point_z(pt : ImagemorphthickeningPoint) -> Double { pt.z }

pub fn image_morph_thickening_point_label(pt : ImagemorphthickeningPoint) -> Int { pt.label }

pub fn image_morph_thickening_point_dist(a : ImagemorphthickeningPoint, b : ImagemorphthickeningPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_morph_thickening_point_add(a : ImagemorphthickeningPoint, b : ImagemorphthickeningPoint) -> ImagemorphthickeningPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_morph_thickening_point_sub(a : ImagemorphthickeningPoint, b : ImagemorphthickeningPoint) -> ImagemorphthickeningPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_morph_thickening_point_scale(pt : ImagemorphthickeningPoint, s : Double) -> ImagemorphthickeningPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_morph_thickening_point_dot(a : ImagemorphthickeningPoint, b : ImagemorphthickeningPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_morph_thickening_point_cross(a : ImagemorphthickeningPoint, b : ImagemorphthickeningPoint) -> ImagemorphthickeningPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_morph_thickening_point_norm(pt : ImagemorphthickeningPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_morph_thickening_point_normalize(pt : ImagemorphthickeningPoint) -> ImagemorphthickeningPoint {
  let n = image_morph_thickening_point_norm(pt)
  if n < 0.0000001 { pt } else { image_morph_thickening_point_scale(pt, 1.0 / n) }
}

pub fn image_morph_thickening_point_negate(pt : ImagemorphthickeningPoint) -> ImagemorphthickeningPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_morph_thickening_point_mid(a : ImagemorphthickeningPoint, b : ImagemorphthickeningPoint) -> ImagemorphthickeningPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_morph_thickening_point_lerp(a : ImagemorphthickeningPoint, b : ImagemorphthickeningPoint, t : Double) -> ImagemorphthickeningPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_morph_thickening_point_to_string(pt : ImagemorphthickeningPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagemorphthickeningSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_thickening_make_series(vals : Array[Double], name : String) -> ImagemorphthickeningSeries {
  { vals, name, meta: 0 }
}

pub fn image_morph_thickening_series_len(s : ImagemorphthickeningSeries) -> Int { s.vals.length() }

pub fn image_morph_thickening_series_sum(s : ImagemorphthickeningSeries) -> Double { @_common.sum(s.vals) }

pub fn image_morph_thickening_series_mean(s : ImagemorphthickeningSeries) -> Double { @_common.mean(s.vals) }

pub fn image_morph_thickening_series_min(s : ImagemorphthickeningSeries) -> Double { @_common.min(s.vals) }

pub fn image_morph_thickening_series_max(s : ImagemorphthickeningSeries) -> Double { @_common.max(s.vals) }

pub fn image_morph_thickening_series_range(s : ImagemorphthickeningSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_morph_thickening_series_var(s : ImagemorphthickeningSeries) -> Double { @_common.variance(s.vals) }

pub fn image_morph_thickening_series_std(s : ImagemorphthickeningSeries) -> Double { @_common.std(s.vals) }

pub fn image_morph_thickening_series_median(s : ImagemorphthickeningSeries) -> Double { @_common.median(s.vals) }

pub fn image_morph_thickening_series_scale(s : ImagemorphthickeningSeries, f : Double) -> ImagemorphthickeningSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn image_morph_thickening_series_add(a : ImagemorphthickeningSeries, b : ImagemorphthickeningSeries) -> ImagemorphthickeningSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_morph_thickening_series_sub(a : ImagemorphthickeningSeries, b : ImagemorphthickeningSeries) -> ImagemorphthickeningSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_morph_thickening_series_normalize(s : ImagemorphthickeningSeries) -> ImagemorphthickeningSeries {
  let mn = image_morph_thickening_series_min(s)
  let mx = image_morph_thickening_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_morph_thickening_series_cumsum(s : ImagemorphthickeningSeries) -> ImagemorphthickeningSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_morph_thickening_series_to_string(s : ImagemorphthickeningSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphthickeningMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_thickening_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphthickeningMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_thickening_matrix_identity(n : Int) -> ImagemorphthickeningMatrix {
  let m = image_morph_thickening_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_morph_thickening_matrix_get(m : ImagemorphthickeningMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_morph_thickening_matrix_transpose(m : ImagemorphthickeningMatrix) -> ImagemorphthickeningMatrix {
  let result = image_morph_thickening_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_morph_thickening_matrix_add(a : ImagemorphthickeningMatrix, b : ImagemorphthickeningMatrix) -> ImagemorphthickeningMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_morph_thickening_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_morph_thickening_matrix_scale(m : ImagemorphthickeningMatrix, s : Double) -> ImagemorphthickeningMatrix {
  let result = image_morph_thickening_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_morph_thickening_matrix_multiply(a : ImagemorphthickeningMatrix, b : ImagemorphthickeningMatrix) -> ImagemorphthickeningMatrix {
  if a.cols != b.rows { return image_morph_thickening_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_morph_thickening_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_morph_thickening_matrix_trace(m : ImagemorphthickeningMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_morph_thickening_matrix_det(m : ImagemorphthickeningMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_morph_thickening_matrix_norm(m : ImagemorphthickeningMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_morph_thickening_matrix_to_string(m : ImagemorphthickeningMatrix) -> String {
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

pub(all) struct ImagemorphthickeningVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_thickening_make_vector(comps : Array[Double]) -> ImagemorphthickeningVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_thickening_vector_zero(dim : Int) -> ImagemorphthickeningVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_morph_thickening_vector_add(a : ImagemorphthickeningVector, b : ImagemorphthickeningVector) -> ImagemorphthickeningVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn image_morph_thickening_vector_sub(a : ImagemorphthickeningVector, b : ImagemorphthickeningVector) -> ImagemorphthickeningVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn image_morph_thickening_vector_scale(v : ImagemorphthickeningVector, s : Double) -> ImagemorphthickeningVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn image_morph_thickening_vector_dot(a : ImagemorphthickeningVector, b : ImagemorphthickeningVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_morph_thickening_vector_norm(v : ImagemorphthickeningVector) -> Double { @_common.sqrt(image_morph_thickening_vector_dot(v, v)) }

pub fn image_morph_thickening_vector_normalize(v : ImagemorphthickeningVector) -> ImagemorphthickeningVector {
  let n = image_morph_thickening_vector_norm(v)
  if n < 0.0000001 { v } else { image_morph_thickening_vector_scale(v, 1.0 / n) }
}

pub fn image_morph_thickening_vector_dist(a : ImagemorphthickeningVector, b : ImagemorphthickeningVector) -> Double {
  image_morph_thickening_vector_norm(image_morph_thickening_vector_sub(a, b))
}

pub fn image_morph_thickening_vector_to_string(v : ImagemorphthickeningVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_thickening_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_morph_thickening_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_morph_thickening_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_morph_thickening_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_morph_thickening_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_morph_thickening_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_morph_thickening_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_morph_thickening_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_morph_thickening_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_morph_thickening_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_morph_thickening_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_morph_thickening_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_morph_thickening_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_morph_thickening_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_morph_thickening_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_morph_thickening_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_morph_thickening_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_morph_thickening_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_morph_thickening_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_morph_thickening_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_morph_thickening_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_morph_thickening_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_morph_thickening_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_morph_thickening_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_morph_thickening_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_morph_thickening_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_morph_thickening_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_morph_thickening_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_morph_thickening_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagemorphthickeningFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thickening_frame_make(size : Int) -> ImagemorphthickeningFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thickening_frame_len(s : ImagemorphthickeningFrame) -> Int { s.size }

pub fn image_morph_thickening_frame_get(s : ImagemorphthickeningFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thickening_frame_set(s : ImagemorphthickeningFrame, i : Int, v : Double) -> ImagemorphthickeningFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_frame_sum(s : ImagemorphthickeningFrame) -> Double { @_common.sum(s.data) }

pub fn image_morph_thickening_frame_mean(s : ImagemorphthickeningFrame) -> Double { @_common.mean(s.data) }

pub fn image_morph_thickening_frame_scale(s : ImagemorphthickeningFrame, f : Double) -> ImagemorphthickeningFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_frame_add(a : ImagemorphthickeningFrame, b : ImagemorphthickeningFrame) -> ImagemorphthickeningFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thickening_frame_copy(s : ImagemorphthickeningFrame) -> ImagemorphthickeningFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_frame_fill(s : ImagemorphthickeningFrame, v : Double) -> ImagemorphthickeningFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_frame_min(s : ImagemorphthickeningFrame) -> Double { @_common.min(s.data) }

pub fn image_morph_thickening_frame_max(s : ImagemorphthickeningFrame) -> Double { @_common.max(s.data) }

pub fn image_morph_thickening_frame_to_string(s : ImagemorphthickeningFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthickeningTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thickening_table_make(size : Int) -> ImagemorphthickeningTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thickening_table_len(s : ImagemorphthickeningTable) -> Int { s.size }

pub fn image_morph_thickening_table_get(s : ImagemorphthickeningTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thickening_table_set(s : ImagemorphthickeningTable, i : Int, v : Double) -> ImagemorphthickeningTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_table_sum(s : ImagemorphthickeningTable) -> Double { @_common.sum(s.data) }

pub fn image_morph_thickening_table_mean(s : ImagemorphthickeningTable) -> Double { @_common.mean(s.data) }

pub fn image_morph_thickening_table_scale(s : ImagemorphthickeningTable, f : Double) -> ImagemorphthickeningTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_table_add(a : ImagemorphthickeningTable, b : ImagemorphthickeningTable) -> ImagemorphthickeningTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thickening_table_copy(s : ImagemorphthickeningTable) -> ImagemorphthickeningTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_table_fill(s : ImagemorphthickeningTable, v : Double) -> ImagemorphthickeningTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_table_min(s : ImagemorphthickeningTable) -> Double { @_common.min(s.data) }

pub fn image_morph_thickening_table_max(s : ImagemorphthickeningTable) -> Double { @_common.max(s.data) }

pub fn image_morph_thickening_table_to_string(s : ImagemorphthickeningTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthickeningGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thickening_graphn_make(size : Int) -> ImagemorphthickeningGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thickening_graphn_len(s : ImagemorphthickeningGraphN) -> Int { s.size }

pub fn image_morph_thickening_graphn_get(s : ImagemorphthickeningGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thickening_graphn_set(s : ImagemorphthickeningGraphN, i : Int, v : Double) -> ImagemorphthickeningGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_graphn_sum(s : ImagemorphthickeningGraphN) -> Double { @_common.sum(s.data) }

pub fn image_morph_thickening_graphn_mean(s : ImagemorphthickeningGraphN) -> Double { @_common.mean(s.data) }

pub fn image_morph_thickening_graphn_scale(s : ImagemorphthickeningGraphN, f : Double) -> ImagemorphthickeningGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_graphn_add(a : ImagemorphthickeningGraphN, b : ImagemorphthickeningGraphN) -> ImagemorphthickeningGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thickening_graphn_copy(s : ImagemorphthickeningGraphN) -> ImagemorphthickeningGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_graphn_fill(s : ImagemorphthickeningGraphN, v : Double) -> ImagemorphthickeningGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_graphn_min(s : ImagemorphthickeningGraphN) -> Double { @_common.min(s.data) }

pub fn image_morph_thickening_graphn_max(s : ImagemorphthickeningGraphN) -> Double { @_common.max(s.data) }

pub fn image_morph_thickening_graphn_to_string(s : ImagemorphthickeningGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthickeningNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thickening_node_make(size : Int) -> ImagemorphthickeningNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thickening_node_len(s : ImagemorphthickeningNode) -> Int { s.size }

pub fn image_morph_thickening_node_get(s : ImagemorphthickeningNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thickening_node_set(s : ImagemorphthickeningNode, i : Int, v : Double) -> ImagemorphthickeningNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_node_sum(s : ImagemorphthickeningNode) -> Double { @_common.sum(s.data) }

pub fn image_morph_thickening_node_mean(s : ImagemorphthickeningNode) -> Double { @_common.mean(s.data) }

pub fn image_morph_thickening_node_scale(s : ImagemorphthickeningNode, f : Double) -> ImagemorphthickeningNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_node_add(a : ImagemorphthickeningNode, b : ImagemorphthickeningNode) -> ImagemorphthickeningNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thickening_node_copy(s : ImagemorphthickeningNode) -> ImagemorphthickeningNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_node_fill(s : ImagemorphthickeningNode, v : Double) -> ImagemorphthickeningNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_node_min(s : ImagemorphthickeningNode) -> Double { @_common.min(s.data) }

pub fn image_morph_thickening_node_max(s : ImagemorphthickeningNode) -> Double { @_common.max(s.data) }

pub fn image_morph_thickening_node_to_string(s : ImagemorphthickeningNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthickeningEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thickening_edge_make(size : Int) -> ImagemorphthickeningEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thickening_edge_len(s : ImagemorphthickeningEdge) -> Int { s.size }

pub fn image_morph_thickening_edge_get(s : ImagemorphthickeningEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thickening_edge_set(s : ImagemorphthickeningEdge, i : Int, v : Double) -> ImagemorphthickeningEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_edge_sum(s : ImagemorphthickeningEdge) -> Double { @_common.sum(s.data) }

pub fn image_morph_thickening_edge_mean(s : ImagemorphthickeningEdge) -> Double { @_common.mean(s.data) }

pub fn image_morph_thickening_edge_scale(s : ImagemorphthickeningEdge, f : Double) -> ImagemorphthickeningEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_edge_add(a : ImagemorphthickeningEdge, b : ImagemorphthickeningEdge) -> ImagemorphthickeningEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thickening_edge_copy(s : ImagemorphthickeningEdge) -> ImagemorphthickeningEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_edge_fill(s : ImagemorphthickeningEdge, v : Double) -> ImagemorphthickeningEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_edge_min(s : ImagemorphthickeningEdge) -> Double { @_common.min(s.data) }

pub fn image_morph_thickening_edge_max(s : ImagemorphthickeningEdge) -> Double { @_common.max(s.data) }

pub fn image_morph_thickening_edge_to_string(s : ImagemorphthickeningEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthickeningPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thickening_path_make(size : Int) -> ImagemorphthickeningPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thickening_path_len(s : ImagemorphthickeningPath) -> Int { s.size }

pub fn image_morph_thickening_path_get(s : ImagemorphthickeningPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thickening_path_set(s : ImagemorphthickeningPath, i : Int, v : Double) -> ImagemorphthickeningPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_path_sum(s : ImagemorphthickeningPath) -> Double { @_common.sum(s.data) }

pub fn image_morph_thickening_path_mean(s : ImagemorphthickeningPath) -> Double { @_common.mean(s.data) }

pub fn image_morph_thickening_path_scale(s : ImagemorphthickeningPath, f : Double) -> ImagemorphthickeningPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_path_add(a : ImagemorphthickeningPath, b : ImagemorphthickeningPath) -> ImagemorphthickeningPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thickening_path_copy(s : ImagemorphthickeningPath) -> ImagemorphthickeningPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_path_fill(s : ImagemorphthickeningPath, v : Double) -> ImagemorphthickeningPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_path_min(s : ImagemorphthickeningPath) -> Double { @_common.min(s.data) }

pub fn image_morph_thickening_path_max(s : ImagemorphthickeningPath) -> Double { @_common.max(s.data) }

pub fn image_morph_thickening_path_to_string(s : ImagemorphthickeningPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthickeningCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thickening_cluster_make(size : Int) -> ImagemorphthickeningCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thickening_cluster_len(s : ImagemorphthickeningCluster) -> Int { s.size }

pub fn image_morph_thickening_cluster_get(s : ImagemorphthickeningCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thickening_cluster_set(s : ImagemorphthickeningCluster, i : Int, v : Double) -> ImagemorphthickeningCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_cluster_sum(s : ImagemorphthickeningCluster) -> Double { @_common.sum(s.data) }

pub fn image_morph_thickening_cluster_mean(s : ImagemorphthickeningCluster) -> Double { @_common.mean(s.data) }

pub fn image_morph_thickening_cluster_scale(s : ImagemorphthickeningCluster, f : Double) -> ImagemorphthickeningCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_cluster_add(a : ImagemorphthickeningCluster, b : ImagemorphthickeningCluster) -> ImagemorphthickeningCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thickening_cluster_copy(s : ImagemorphthickeningCluster) -> ImagemorphthickeningCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_cluster_fill(s : ImagemorphthickeningCluster, v : Double) -> ImagemorphthickeningCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_cluster_min(s : ImagemorphthickeningCluster) -> Double { @_common.min(s.data) }

pub fn image_morph_thickening_cluster_max(s : ImagemorphthickeningCluster) -> Double { @_common.max(s.data) }

pub fn image_morph_thickening_cluster_to_string(s : ImagemorphthickeningCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthickeningModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thickening_model_make(size : Int) -> ImagemorphthickeningModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thickening_model_len(s : ImagemorphthickeningModel) -> Int { s.size }

pub fn image_morph_thickening_model_get(s : ImagemorphthickeningModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thickening_model_set(s : ImagemorphthickeningModel, i : Int, v : Double) -> ImagemorphthickeningModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_model_sum(s : ImagemorphthickeningModel) -> Double { @_common.sum(s.data) }

pub fn image_morph_thickening_model_mean(s : ImagemorphthickeningModel) -> Double { @_common.mean(s.data) }

pub fn image_morph_thickening_model_scale(s : ImagemorphthickeningModel, f : Double) -> ImagemorphthickeningModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_model_add(a : ImagemorphthickeningModel, b : ImagemorphthickeningModel) -> ImagemorphthickeningModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thickening_model_copy(s : ImagemorphthickeningModel) -> ImagemorphthickeningModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_model_fill(s : ImagemorphthickeningModel, v : Double) -> ImagemorphthickeningModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_model_min(s : ImagemorphthickeningModel) -> Double { @_common.min(s.data) }

pub fn image_morph_thickening_model_max(s : ImagemorphthickeningModel) -> Double { @_common.max(s.data) }

pub fn image_morph_thickening_model_to_string(s : ImagemorphthickeningModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthickeningLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thickening_layer_make(size : Int) -> ImagemorphthickeningLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thickening_layer_len(s : ImagemorphthickeningLayer) -> Int { s.size }

pub fn image_morph_thickening_layer_get(s : ImagemorphthickeningLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thickening_layer_set(s : ImagemorphthickeningLayer, i : Int, v : Double) -> ImagemorphthickeningLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_layer_sum(s : ImagemorphthickeningLayer) -> Double { @_common.sum(s.data) }

pub fn image_morph_thickening_layer_mean(s : ImagemorphthickeningLayer) -> Double { @_common.mean(s.data) }

pub fn image_morph_thickening_layer_scale(s : ImagemorphthickeningLayer, f : Double) -> ImagemorphthickeningLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_layer_add(a : ImagemorphthickeningLayer, b : ImagemorphthickeningLayer) -> ImagemorphthickeningLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thickening_layer_copy(s : ImagemorphthickeningLayer) -> ImagemorphthickeningLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_layer_fill(s : ImagemorphthickeningLayer, v : Double) -> ImagemorphthickeningLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_layer_min(s : ImagemorphthickeningLayer) -> Double { @_common.min(s.data) }

pub fn image_morph_thickening_layer_max(s : ImagemorphthickeningLayer) -> Double { @_common.max(s.data) }

pub fn image_morph_thickening_layer_to_string(s : ImagemorphthickeningLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthickeningBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thickening_buffer_make(size : Int) -> ImagemorphthickeningBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thickening_buffer_len(s : ImagemorphthickeningBuffer) -> Int { s.size }

pub fn image_morph_thickening_buffer_get(s : ImagemorphthickeningBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thickening_buffer_set(s : ImagemorphthickeningBuffer, i : Int, v : Double) -> ImagemorphthickeningBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_buffer_sum(s : ImagemorphthickeningBuffer) -> Double { @_common.sum(s.data) }

pub fn image_morph_thickening_buffer_mean(s : ImagemorphthickeningBuffer) -> Double { @_common.mean(s.data) }

pub fn image_morph_thickening_buffer_scale(s : ImagemorphthickeningBuffer, f : Double) -> ImagemorphthickeningBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_buffer_add(a : ImagemorphthickeningBuffer, b : ImagemorphthickeningBuffer) -> ImagemorphthickeningBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thickening_buffer_copy(s : ImagemorphthickeningBuffer) -> ImagemorphthickeningBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_buffer_fill(s : ImagemorphthickeningBuffer, v : Double) -> ImagemorphthickeningBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_buffer_min(s : ImagemorphthickeningBuffer) -> Double { @_common.min(s.data) }

pub fn image_morph_thickening_buffer_max(s : ImagemorphthickeningBuffer) -> Double { @_common.max(s.data) }

pub fn image_morph_thickening_buffer_to_string(s : ImagemorphthickeningBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthickeningCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thickening_cursor_make(size : Int) -> ImagemorphthickeningCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thickening_cursor_len(s : ImagemorphthickeningCursor) -> Int { s.size }

pub fn image_morph_thickening_cursor_get(s : ImagemorphthickeningCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thickening_cursor_set(s : ImagemorphthickeningCursor, i : Int, v : Double) -> ImagemorphthickeningCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_cursor_sum(s : ImagemorphthickeningCursor) -> Double { @_common.sum(s.data) }

pub fn image_morph_thickening_cursor_mean(s : ImagemorphthickeningCursor) -> Double { @_common.mean(s.data) }

pub fn image_morph_thickening_cursor_scale(s : ImagemorphthickeningCursor, f : Double) -> ImagemorphthickeningCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_cursor_add(a : ImagemorphthickeningCursor, b : ImagemorphthickeningCursor) -> ImagemorphthickeningCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thickening_cursor_copy(s : ImagemorphthickeningCursor) -> ImagemorphthickeningCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_cursor_fill(s : ImagemorphthickeningCursor, v : Double) -> ImagemorphthickeningCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_cursor_min(s : ImagemorphthickeningCursor) -> Double { @_common.min(s.data) }

pub fn image_morph_thickening_cursor_max(s : ImagemorphthickeningCursor) -> Double { @_common.max(s.data) }

pub fn image_morph_thickening_cursor_to_string(s : ImagemorphthickeningCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthickeningView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thickening_view_make(size : Int) -> ImagemorphthickeningView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thickening_view_len(s : ImagemorphthickeningView) -> Int { s.size }

pub fn image_morph_thickening_view_get(s : ImagemorphthickeningView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thickening_view_set(s : ImagemorphthickeningView, i : Int, v : Double) -> ImagemorphthickeningView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_view_sum(s : ImagemorphthickeningView) -> Double { @_common.sum(s.data) }

pub fn image_morph_thickening_view_mean(s : ImagemorphthickeningView) -> Double { @_common.mean(s.data) }

pub fn image_morph_thickening_view_scale(s : ImagemorphthickeningView, f : Double) -> ImagemorphthickeningView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_view_add(a : ImagemorphthickeningView, b : ImagemorphthickeningView) -> ImagemorphthickeningView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thickening_view_copy(s : ImagemorphthickeningView) -> ImagemorphthickeningView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_view_fill(s : ImagemorphthickeningView, v : Double) -> ImagemorphthickeningView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_view_min(s : ImagemorphthickeningView) -> Double { @_common.min(s.data) }

pub fn image_morph_thickening_view_max(s : ImagemorphthickeningView) -> Double { @_common.max(s.data) }

pub fn image_morph_thickening_view_to_string(s : ImagemorphthickeningView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthickeningRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thickening_range_make(size : Int) -> ImagemorphthickeningRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thickening_range_len(s : ImagemorphthickeningRange) -> Int { s.size }

pub fn image_morph_thickening_range_get(s : ImagemorphthickeningRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thickening_range_set(s : ImagemorphthickeningRange, i : Int, v : Double) -> ImagemorphthickeningRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_range_sum(s : ImagemorphthickeningRange) -> Double { @_common.sum(s.data) }

pub fn image_morph_thickening_range_mean(s : ImagemorphthickeningRange) -> Double { @_common.mean(s.data) }

pub fn image_morph_thickening_range_scale(s : ImagemorphthickeningRange, f : Double) -> ImagemorphthickeningRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_range_add(a : ImagemorphthickeningRange, b : ImagemorphthickeningRange) -> ImagemorphthickeningRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thickening_range_copy(s : ImagemorphthickeningRange) -> ImagemorphthickeningRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_range_fill(s : ImagemorphthickeningRange, v : Double) -> ImagemorphthickeningRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_range_min(s : ImagemorphthickeningRange) -> Double { @_common.min(s.data) }

pub fn image_morph_thickening_range_max(s : ImagemorphthickeningRange) -> Double { @_common.max(s.data) }

pub fn image_morph_thickening_range_to_string(s : ImagemorphthickeningRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphthickeningSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_thickening_slice_make(size : Int) -> ImagemorphthickeningSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_thickening_slice_len(s : ImagemorphthickeningSlice) -> Int { s.size }

pub fn image_morph_thickening_slice_get(s : ImagemorphthickeningSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_thickening_slice_set(s : ImagemorphthickeningSlice, i : Int, v : Double) -> ImagemorphthickeningSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_slice_sum(s : ImagemorphthickeningSlice) -> Double { @_common.sum(s.data) }

pub fn image_morph_thickening_slice_mean(s : ImagemorphthickeningSlice) -> Double { @_common.mean(s.data) }

pub fn image_morph_thickening_slice_scale(s : ImagemorphthickeningSlice, f : Double) -> ImagemorphthickeningSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_slice_add(a : ImagemorphthickeningSlice, b : ImagemorphthickeningSlice) -> ImagemorphthickeningSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_thickening_slice_copy(s : ImagemorphthickeningSlice) -> ImagemorphthickeningSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_slice_fill(s : ImagemorphthickeningSlice, v : Double) -> ImagemorphthickeningSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_thickening_slice_min(s : ImagemorphthickeningSlice) -> Double { @_common.min(s.data) }

pub fn image_morph_thickening_slice_max(s : ImagemorphthickeningSlice) -> Double { @_common.max(s.data) }

pub fn image_morph_thickening_slice_to_string(s : ImagemorphthickeningSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

