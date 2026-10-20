///===
/// extcore/image_filter_bilateral

pub(all) struct ImagefilterbilateralPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_bilateral_make_point(x : Double, y : Double) -> ImagefilterbilateralPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_bilateral_make_point3(x : Double, y : Double, z : Double) -> ImagefilterbilateralPoint {
  { x, y, z, label: 0 }
}

pub fn image_filter_bilateral_point_x(pt : ImagefilterbilateralPoint) -> Double { pt.x }

pub fn image_filter_bilateral_point_y(pt : ImagefilterbilateralPoint) -> Double { pt.y }

pub fn image_filter_bilateral_point_z(pt : ImagefilterbilateralPoint) -> Double { pt.z }

pub fn image_filter_bilateral_point_label(pt : ImagefilterbilateralPoint) -> Int { pt.label }

pub fn image_filter_bilateral_point_dist(a : ImagefilterbilateralPoint, b : ImagefilterbilateralPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_filter_bilateral_point_add(a : ImagefilterbilateralPoint, b : ImagefilterbilateralPoint) -> ImagefilterbilateralPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_filter_bilateral_point_sub(a : ImagefilterbilateralPoint, b : ImagefilterbilateralPoint) -> ImagefilterbilateralPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_filter_bilateral_point_scale(pt : ImagefilterbilateralPoint, s : Double) -> ImagefilterbilateralPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_filter_bilateral_point_dot(a : ImagefilterbilateralPoint, b : ImagefilterbilateralPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_filter_bilateral_point_cross(a : ImagefilterbilateralPoint, b : ImagefilterbilateralPoint) -> ImagefilterbilateralPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_filter_bilateral_point_norm(pt : ImagefilterbilateralPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_filter_bilateral_point_normalize(pt : ImagefilterbilateralPoint) -> ImagefilterbilateralPoint {
  let n = image_filter_bilateral_point_norm(pt)
  if n < 0.0000001 { pt } else { image_filter_bilateral_point_scale(pt, 1.0 / n) }
}

pub fn image_filter_bilateral_point_negate(pt : ImagefilterbilateralPoint) -> ImagefilterbilateralPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_filter_bilateral_point_mid(a : ImagefilterbilateralPoint, b : ImagefilterbilateralPoint) -> ImagefilterbilateralPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_filter_bilateral_point_lerp(a : ImagefilterbilateralPoint, b : ImagefilterbilateralPoint, t : Double) -> ImagefilterbilateralPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_filter_bilateral_point_to_string(pt : ImagefilterbilateralPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefilterbilateralSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_bilateral_make_series(vals : Array[Double], name : String) -> ImagefilterbilateralSeries {
  { vals, name, meta: 0 }
}

pub fn image_filter_bilateral_series_len(s : ImagefilterbilateralSeries) -> Int { s.vals.length() }

pub fn image_filter_bilateral_series_sum(s : ImagefilterbilateralSeries) -> Double { @_common.sum(s.vals) }

pub fn image_filter_bilateral_series_mean(s : ImagefilterbilateralSeries) -> Double { @_common.mean(s.vals) }

pub fn image_filter_bilateral_series_min(s : ImagefilterbilateralSeries) -> Double { @_common.min(s.vals) }

pub fn image_filter_bilateral_series_max(s : ImagefilterbilateralSeries) -> Double { @_common.max(s.vals) }

pub fn image_filter_bilateral_series_range(s : ImagefilterbilateralSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_filter_bilateral_series_var(s : ImagefilterbilateralSeries) -> Double { @_common.variance(s.vals) }

pub fn image_filter_bilateral_series_std(s : ImagefilterbilateralSeries) -> Double { @_common.std(s.vals) }

pub fn image_filter_bilateral_series_median(s : ImagefilterbilateralSeries) -> Double { @_common.median(s.vals) }

pub fn image_filter_bilateral_series_scale(s : ImagefilterbilateralSeries, f : Double) -> ImagefilterbilateralSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn image_filter_bilateral_series_add(a : ImagefilterbilateralSeries, b : ImagefilterbilateralSeries) -> ImagefilterbilateralSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_filter_bilateral_series_sub(a : ImagefilterbilateralSeries, b : ImagefilterbilateralSeries) -> ImagefilterbilateralSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_filter_bilateral_series_normalize(s : ImagefilterbilateralSeries) -> ImagefilterbilateralSeries {
  let mn = image_filter_bilateral_series_min(s)
  let mx = image_filter_bilateral_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_filter_bilateral_series_cumsum(s : ImagefilterbilateralSeries) -> ImagefilterbilateralSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_filter_bilateral_series_to_string(s : ImagefilterbilateralSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefilterbilateralMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_bilateral_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefilterbilateralMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_bilateral_matrix_identity(n : Int) -> ImagefilterbilateralMatrix {
  let m = image_filter_bilateral_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_filter_bilateral_matrix_get(m : ImagefilterbilateralMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_filter_bilateral_matrix_transpose(m : ImagefilterbilateralMatrix) -> ImagefilterbilateralMatrix {
  let result = image_filter_bilateral_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_filter_bilateral_matrix_add(a : ImagefilterbilateralMatrix, b : ImagefilterbilateralMatrix) -> ImagefilterbilateralMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_filter_bilateral_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_filter_bilateral_matrix_scale(m : ImagefilterbilateralMatrix, s : Double) -> ImagefilterbilateralMatrix {
  let result = image_filter_bilateral_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_filter_bilateral_matrix_multiply(a : ImagefilterbilateralMatrix, b : ImagefilterbilateralMatrix) -> ImagefilterbilateralMatrix {
  if a.cols != b.rows { return image_filter_bilateral_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_filter_bilateral_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_filter_bilateral_matrix_trace(m : ImagefilterbilateralMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_filter_bilateral_matrix_det(m : ImagefilterbilateralMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_filter_bilateral_matrix_norm(m : ImagefilterbilateralMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_filter_bilateral_matrix_to_string(m : ImagefilterbilateralMatrix) -> String {
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

pub(all) struct ImagefilterbilateralVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_bilateral_make_vector(comps : Array[Double]) -> ImagefilterbilateralVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_bilateral_vector_zero(dim : Int) -> ImagefilterbilateralVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_filter_bilateral_vector_add(a : ImagefilterbilateralVector, b : ImagefilterbilateralVector) -> ImagefilterbilateralVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn image_filter_bilateral_vector_sub(a : ImagefilterbilateralVector, b : ImagefilterbilateralVector) -> ImagefilterbilateralVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn image_filter_bilateral_vector_scale(v : ImagefilterbilateralVector, s : Double) -> ImagefilterbilateralVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn image_filter_bilateral_vector_dot(a : ImagefilterbilateralVector, b : ImagefilterbilateralVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_filter_bilateral_vector_norm(v : ImagefilterbilateralVector) -> Double { @_common.sqrt(image_filter_bilateral_vector_dot(v, v)) }

pub fn image_filter_bilateral_vector_normalize(v : ImagefilterbilateralVector) -> ImagefilterbilateralVector {
  let n = image_filter_bilateral_vector_norm(v)
  if n < 0.0000001 { v } else { image_filter_bilateral_vector_scale(v, 1.0 / n) }
}

pub fn image_filter_bilateral_vector_dist(a : ImagefilterbilateralVector, b : ImagefilterbilateralVector) -> Double {
  image_filter_bilateral_vector_norm(image_filter_bilateral_vector_sub(a, b))
}

pub fn image_filter_bilateral_vector_to_string(v : ImagefilterbilateralVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_bilateral_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_filter_bilateral_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_filter_bilateral_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_filter_bilateral_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_filter_bilateral_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_filter_bilateral_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_filter_bilateral_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_filter_bilateral_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_filter_bilateral_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_filter_bilateral_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_filter_bilateral_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_filter_bilateral_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_filter_bilateral_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_filter_bilateral_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_filter_bilateral_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_filter_bilateral_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_filter_bilateral_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_filter_bilateral_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_filter_bilateral_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_filter_bilateral_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_filter_bilateral_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_filter_bilateral_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_filter_bilateral_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_filter_bilateral_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_filter_bilateral_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_filter_bilateral_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_filter_bilateral_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_filter_bilateral_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_filter_bilateral_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefilterbilateralFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_frame_make(size : Int) -> ImagefilterbilateralFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_frame_len(s : ImagefilterbilateralFrame) -> Int { s.size }

pub fn image_filter_bilateral_frame_get(s : ImagefilterbilateralFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_frame_set(s : ImagefilterbilateralFrame, i : Int, v : Double) -> ImagefilterbilateralFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_frame_sum(s : ImagefilterbilateralFrame) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_frame_mean(s : ImagefilterbilateralFrame) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_frame_scale(s : ImagefilterbilateralFrame, f : Double) -> ImagefilterbilateralFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_frame_add(a : ImagefilterbilateralFrame, b : ImagefilterbilateralFrame) -> ImagefilterbilateralFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_frame_copy(s : ImagefilterbilateralFrame) -> ImagefilterbilateralFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_frame_fill(s : ImagefilterbilateralFrame, v : Double) -> ImagefilterbilateralFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_frame_min(s : ImagefilterbilateralFrame) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_frame_max(s : ImagefilterbilateralFrame) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_frame_to_string(s : ImagefilterbilateralFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_table_make(size : Int) -> ImagefilterbilateralTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_table_len(s : ImagefilterbilateralTable) -> Int { s.size }

pub fn image_filter_bilateral_table_get(s : ImagefilterbilateralTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_table_set(s : ImagefilterbilateralTable, i : Int, v : Double) -> ImagefilterbilateralTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_table_sum(s : ImagefilterbilateralTable) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_table_mean(s : ImagefilterbilateralTable) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_table_scale(s : ImagefilterbilateralTable, f : Double) -> ImagefilterbilateralTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_table_add(a : ImagefilterbilateralTable, b : ImagefilterbilateralTable) -> ImagefilterbilateralTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_table_copy(s : ImagefilterbilateralTable) -> ImagefilterbilateralTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_table_fill(s : ImagefilterbilateralTable, v : Double) -> ImagefilterbilateralTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_table_min(s : ImagefilterbilateralTable) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_table_max(s : ImagefilterbilateralTable) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_table_to_string(s : ImagefilterbilateralTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_graphn_make(size : Int) -> ImagefilterbilateralGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_graphn_len(s : ImagefilterbilateralGraphN) -> Int { s.size }

pub fn image_filter_bilateral_graphn_get(s : ImagefilterbilateralGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_graphn_set(s : ImagefilterbilateralGraphN, i : Int, v : Double) -> ImagefilterbilateralGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_graphn_sum(s : ImagefilterbilateralGraphN) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_graphn_mean(s : ImagefilterbilateralGraphN) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_graphn_scale(s : ImagefilterbilateralGraphN, f : Double) -> ImagefilterbilateralGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_graphn_add(a : ImagefilterbilateralGraphN, b : ImagefilterbilateralGraphN) -> ImagefilterbilateralGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_graphn_copy(s : ImagefilterbilateralGraphN) -> ImagefilterbilateralGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_graphn_fill(s : ImagefilterbilateralGraphN, v : Double) -> ImagefilterbilateralGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_graphn_min(s : ImagefilterbilateralGraphN) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_graphn_max(s : ImagefilterbilateralGraphN) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_graphn_to_string(s : ImagefilterbilateralGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_node_make(size : Int) -> ImagefilterbilateralNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_node_len(s : ImagefilterbilateralNode) -> Int { s.size }

pub fn image_filter_bilateral_node_get(s : ImagefilterbilateralNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_node_set(s : ImagefilterbilateralNode, i : Int, v : Double) -> ImagefilterbilateralNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_node_sum(s : ImagefilterbilateralNode) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_node_mean(s : ImagefilterbilateralNode) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_node_scale(s : ImagefilterbilateralNode, f : Double) -> ImagefilterbilateralNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_node_add(a : ImagefilterbilateralNode, b : ImagefilterbilateralNode) -> ImagefilterbilateralNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_node_copy(s : ImagefilterbilateralNode) -> ImagefilterbilateralNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_node_fill(s : ImagefilterbilateralNode, v : Double) -> ImagefilterbilateralNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_node_min(s : ImagefilterbilateralNode) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_node_max(s : ImagefilterbilateralNode) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_node_to_string(s : ImagefilterbilateralNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_edge_make(size : Int) -> ImagefilterbilateralEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_edge_len(s : ImagefilterbilateralEdge) -> Int { s.size }

pub fn image_filter_bilateral_edge_get(s : ImagefilterbilateralEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_edge_set(s : ImagefilterbilateralEdge, i : Int, v : Double) -> ImagefilterbilateralEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_edge_sum(s : ImagefilterbilateralEdge) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_edge_mean(s : ImagefilterbilateralEdge) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_edge_scale(s : ImagefilterbilateralEdge, f : Double) -> ImagefilterbilateralEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_edge_add(a : ImagefilterbilateralEdge, b : ImagefilterbilateralEdge) -> ImagefilterbilateralEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_edge_copy(s : ImagefilterbilateralEdge) -> ImagefilterbilateralEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_edge_fill(s : ImagefilterbilateralEdge, v : Double) -> ImagefilterbilateralEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_edge_min(s : ImagefilterbilateralEdge) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_edge_max(s : ImagefilterbilateralEdge) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_edge_to_string(s : ImagefilterbilateralEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_path_make(size : Int) -> ImagefilterbilateralPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_path_len(s : ImagefilterbilateralPath) -> Int { s.size }

pub fn image_filter_bilateral_path_get(s : ImagefilterbilateralPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_path_set(s : ImagefilterbilateralPath, i : Int, v : Double) -> ImagefilterbilateralPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_path_sum(s : ImagefilterbilateralPath) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_path_mean(s : ImagefilterbilateralPath) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_path_scale(s : ImagefilterbilateralPath, f : Double) -> ImagefilterbilateralPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_path_add(a : ImagefilterbilateralPath, b : ImagefilterbilateralPath) -> ImagefilterbilateralPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_path_copy(s : ImagefilterbilateralPath) -> ImagefilterbilateralPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_path_fill(s : ImagefilterbilateralPath, v : Double) -> ImagefilterbilateralPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_path_min(s : ImagefilterbilateralPath) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_path_max(s : ImagefilterbilateralPath) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_path_to_string(s : ImagefilterbilateralPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_cluster_make(size : Int) -> ImagefilterbilateralCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_cluster_len(s : ImagefilterbilateralCluster) -> Int { s.size }

pub fn image_filter_bilateral_cluster_get(s : ImagefilterbilateralCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_cluster_set(s : ImagefilterbilateralCluster, i : Int, v : Double) -> ImagefilterbilateralCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_cluster_sum(s : ImagefilterbilateralCluster) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_cluster_mean(s : ImagefilterbilateralCluster) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_cluster_scale(s : ImagefilterbilateralCluster, f : Double) -> ImagefilterbilateralCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_cluster_add(a : ImagefilterbilateralCluster, b : ImagefilterbilateralCluster) -> ImagefilterbilateralCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_cluster_copy(s : ImagefilterbilateralCluster) -> ImagefilterbilateralCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_cluster_fill(s : ImagefilterbilateralCluster, v : Double) -> ImagefilterbilateralCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_cluster_min(s : ImagefilterbilateralCluster) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_cluster_max(s : ImagefilterbilateralCluster) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_cluster_to_string(s : ImagefilterbilateralCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_model_make(size : Int) -> ImagefilterbilateralModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_model_len(s : ImagefilterbilateralModel) -> Int { s.size }

pub fn image_filter_bilateral_model_get(s : ImagefilterbilateralModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_model_set(s : ImagefilterbilateralModel, i : Int, v : Double) -> ImagefilterbilateralModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_model_sum(s : ImagefilterbilateralModel) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_model_mean(s : ImagefilterbilateralModel) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_model_scale(s : ImagefilterbilateralModel, f : Double) -> ImagefilterbilateralModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_model_add(a : ImagefilterbilateralModel, b : ImagefilterbilateralModel) -> ImagefilterbilateralModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_model_copy(s : ImagefilterbilateralModel) -> ImagefilterbilateralModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_model_fill(s : ImagefilterbilateralModel, v : Double) -> ImagefilterbilateralModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_model_min(s : ImagefilterbilateralModel) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_model_max(s : ImagefilterbilateralModel) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_model_to_string(s : ImagefilterbilateralModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_layer_make(size : Int) -> ImagefilterbilateralLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_layer_len(s : ImagefilterbilateralLayer) -> Int { s.size }

pub fn image_filter_bilateral_layer_get(s : ImagefilterbilateralLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_layer_set(s : ImagefilterbilateralLayer, i : Int, v : Double) -> ImagefilterbilateralLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_layer_sum(s : ImagefilterbilateralLayer) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_layer_mean(s : ImagefilterbilateralLayer) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_layer_scale(s : ImagefilterbilateralLayer, f : Double) -> ImagefilterbilateralLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_layer_add(a : ImagefilterbilateralLayer, b : ImagefilterbilateralLayer) -> ImagefilterbilateralLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_layer_copy(s : ImagefilterbilateralLayer) -> ImagefilterbilateralLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_layer_fill(s : ImagefilterbilateralLayer, v : Double) -> ImagefilterbilateralLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_layer_min(s : ImagefilterbilateralLayer) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_layer_max(s : ImagefilterbilateralLayer) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_layer_to_string(s : ImagefilterbilateralLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_buffer_make(size : Int) -> ImagefilterbilateralBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_buffer_len(s : ImagefilterbilateralBuffer) -> Int { s.size }

pub fn image_filter_bilateral_buffer_get(s : ImagefilterbilateralBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_buffer_set(s : ImagefilterbilateralBuffer, i : Int, v : Double) -> ImagefilterbilateralBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_buffer_sum(s : ImagefilterbilateralBuffer) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_buffer_mean(s : ImagefilterbilateralBuffer) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_buffer_scale(s : ImagefilterbilateralBuffer, f : Double) -> ImagefilterbilateralBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_buffer_add(a : ImagefilterbilateralBuffer, b : ImagefilterbilateralBuffer) -> ImagefilterbilateralBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_buffer_copy(s : ImagefilterbilateralBuffer) -> ImagefilterbilateralBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_buffer_fill(s : ImagefilterbilateralBuffer, v : Double) -> ImagefilterbilateralBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_buffer_min(s : ImagefilterbilateralBuffer) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_buffer_max(s : ImagefilterbilateralBuffer) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_buffer_to_string(s : ImagefilterbilateralBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_cursor_make(size : Int) -> ImagefilterbilateralCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_cursor_len(s : ImagefilterbilateralCursor) -> Int { s.size }

pub fn image_filter_bilateral_cursor_get(s : ImagefilterbilateralCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_cursor_set(s : ImagefilterbilateralCursor, i : Int, v : Double) -> ImagefilterbilateralCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_cursor_sum(s : ImagefilterbilateralCursor) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_cursor_mean(s : ImagefilterbilateralCursor) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_cursor_scale(s : ImagefilterbilateralCursor, f : Double) -> ImagefilterbilateralCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_cursor_add(a : ImagefilterbilateralCursor, b : ImagefilterbilateralCursor) -> ImagefilterbilateralCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_cursor_copy(s : ImagefilterbilateralCursor) -> ImagefilterbilateralCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_cursor_fill(s : ImagefilterbilateralCursor, v : Double) -> ImagefilterbilateralCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_cursor_min(s : ImagefilterbilateralCursor) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_cursor_max(s : ImagefilterbilateralCursor) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_cursor_to_string(s : ImagefilterbilateralCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_view_make(size : Int) -> ImagefilterbilateralView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_view_len(s : ImagefilterbilateralView) -> Int { s.size }

pub fn image_filter_bilateral_view_get(s : ImagefilterbilateralView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_view_set(s : ImagefilterbilateralView, i : Int, v : Double) -> ImagefilterbilateralView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_view_sum(s : ImagefilterbilateralView) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_view_mean(s : ImagefilterbilateralView) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_view_scale(s : ImagefilterbilateralView, f : Double) -> ImagefilterbilateralView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_view_add(a : ImagefilterbilateralView, b : ImagefilterbilateralView) -> ImagefilterbilateralView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_view_copy(s : ImagefilterbilateralView) -> ImagefilterbilateralView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_view_fill(s : ImagefilterbilateralView, v : Double) -> ImagefilterbilateralView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_view_min(s : ImagefilterbilateralView) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_view_max(s : ImagefilterbilateralView) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_view_to_string(s : ImagefilterbilateralView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_range_make(size : Int) -> ImagefilterbilateralRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_range_len(s : ImagefilterbilateralRange) -> Int { s.size }

pub fn image_filter_bilateral_range_get(s : ImagefilterbilateralRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_range_set(s : ImagefilterbilateralRange, i : Int, v : Double) -> ImagefilterbilateralRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_range_sum(s : ImagefilterbilateralRange) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_range_mean(s : ImagefilterbilateralRange) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_range_scale(s : ImagefilterbilateralRange, f : Double) -> ImagefilterbilateralRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_range_add(a : ImagefilterbilateralRange, b : ImagefilterbilateralRange) -> ImagefilterbilateralRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_range_copy(s : ImagefilterbilateralRange) -> ImagefilterbilateralRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_range_fill(s : ImagefilterbilateralRange, v : Double) -> ImagefilterbilateralRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_range_min(s : ImagefilterbilateralRange) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_range_max(s : ImagefilterbilateralRange) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_range_to_string(s : ImagefilterbilateralRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterbilateralSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_bilateral_slice_make(size : Int) -> ImagefilterbilateralSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_bilateral_slice_len(s : ImagefilterbilateralSlice) -> Int { s.size }

pub fn image_filter_bilateral_slice_get(s : ImagefilterbilateralSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_bilateral_slice_set(s : ImagefilterbilateralSlice, i : Int, v : Double) -> ImagefilterbilateralSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_slice_sum(s : ImagefilterbilateralSlice) -> Double { @_common.sum(s.data) }

pub fn image_filter_bilateral_slice_mean(s : ImagefilterbilateralSlice) -> Double { @_common.mean(s.data) }

pub fn image_filter_bilateral_slice_scale(s : ImagefilterbilateralSlice, f : Double) -> ImagefilterbilateralSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_slice_add(a : ImagefilterbilateralSlice, b : ImagefilterbilateralSlice) -> ImagefilterbilateralSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_bilateral_slice_copy(s : ImagefilterbilateralSlice) -> ImagefilterbilateralSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_slice_fill(s : ImagefilterbilateralSlice, v : Double) -> ImagefilterbilateralSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_bilateral_slice_min(s : ImagefilterbilateralSlice) -> Double { @_common.min(s.data) }

pub fn image_filter_bilateral_slice_max(s : ImagefilterbilateralSlice) -> Double { @_common.max(s.data) }

pub fn image_filter_bilateral_slice_to_string(s : ImagefilterbilateralSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

