///===
/// extcore/image_transform_transpose

pub(all) struct ImagetransformtransposePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_transpose_make_point(x : Double, y : Double) -> ImagetransformtransposePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_transpose_make_point3(x : Double, y : Double, z : Double) -> ImagetransformtransposePoint {
  { x, y, z, label: 0 }
}

pub fn image_transform_transpose_point_x(pt : ImagetransformtransposePoint) -> Double { pt.x }

pub fn image_transform_transpose_point_y(pt : ImagetransformtransposePoint) -> Double { pt.y }

pub fn image_transform_transpose_point_z(pt : ImagetransformtransposePoint) -> Double { pt.z }

pub fn image_transform_transpose_point_label(pt : ImagetransformtransposePoint) -> Int { pt.label }

pub fn image_transform_transpose_point_dist(a : ImagetransformtransposePoint, b : ImagetransformtransposePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_transform_transpose_point_add(a : ImagetransformtransposePoint, b : ImagetransformtransposePoint) -> ImagetransformtransposePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_transform_transpose_point_sub(a : ImagetransformtransposePoint, b : ImagetransformtransposePoint) -> ImagetransformtransposePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_transform_transpose_point_scale(pt : ImagetransformtransposePoint, s : Double) -> ImagetransformtransposePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_transform_transpose_point_dot(a : ImagetransformtransposePoint, b : ImagetransformtransposePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_transform_transpose_point_cross(a : ImagetransformtransposePoint, b : ImagetransformtransposePoint) -> ImagetransformtransposePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_transform_transpose_point_norm(pt : ImagetransformtransposePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_transform_transpose_point_normalize(pt : ImagetransformtransposePoint) -> ImagetransformtransposePoint {
  let n = image_transform_transpose_point_norm(pt)
  if n < 0.0000001 { pt } else { image_transform_transpose_point_scale(pt, 1.0 / n) }
}

pub fn image_transform_transpose_point_negate(pt : ImagetransformtransposePoint) -> ImagetransformtransposePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_transform_transpose_point_mid(a : ImagetransformtransposePoint, b : ImagetransformtransposePoint) -> ImagetransformtransposePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_transform_transpose_point_lerp(a : ImagetransformtransposePoint, b : ImagetransformtransposePoint, t : Double) -> ImagetransformtransposePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_transform_transpose_point_to_string(pt : ImagetransformtransposePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagetransformtransposeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_transpose_make_series(vals : Array[Double], name : String) -> ImagetransformtransposeSeries {
  { vals, name, meta: 0 }
}

pub fn image_transform_transpose_series_len(s : ImagetransformtransposeSeries) -> Int { s.vals.length() }

pub fn image_transform_transpose_series_sum(s : ImagetransformtransposeSeries) -> Double { @_common.sum(s.vals) }

pub fn image_transform_transpose_series_mean(s : ImagetransformtransposeSeries) -> Double { @_common.mean(s.vals) }

pub fn image_transform_transpose_series_min(s : ImagetransformtransposeSeries) -> Double { @_common.min(s.vals) }

pub fn image_transform_transpose_series_max(s : ImagetransformtransposeSeries) -> Double { @_common.max(s.vals) }

pub fn image_transform_transpose_series_range(s : ImagetransformtransposeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_transform_transpose_series_var(s : ImagetransformtransposeSeries) -> Double { @_common.variance(s.vals) }

pub fn image_transform_transpose_series_std(s : ImagetransformtransposeSeries) -> Double { @_common.std(s.vals) }

pub fn image_transform_transpose_series_median(s : ImagetransformtransposeSeries) -> Double { @_common.median(s.vals) }

pub fn image_transform_transpose_series_scale(s : ImagetransformtransposeSeries, f : Double) -> ImagetransformtransposeSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn image_transform_transpose_series_add(a : ImagetransformtransposeSeries, b : ImagetransformtransposeSeries) -> ImagetransformtransposeSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_transform_transpose_series_sub(a : ImagetransformtransposeSeries, b : ImagetransformtransposeSeries) -> ImagetransformtransposeSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_transform_transpose_series_normalize(s : ImagetransformtransposeSeries) -> ImagetransformtransposeSeries {
  let mn = image_transform_transpose_series_min(s)
  let mx = image_transform_transpose_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_transform_transpose_series_cumsum(s : ImagetransformtransposeSeries) -> ImagetransformtransposeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_transform_transpose_series_to_string(s : ImagetransformtransposeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformtransposeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_transpose_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformtransposeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_transpose_matrix_identity(n : Int) -> ImagetransformtransposeMatrix {
  let m = image_transform_transpose_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_transform_transpose_matrix_get(m : ImagetransformtransposeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_transform_transpose_matrix_transpose(m : ImagetransformtransposeMatrix) -> ImagetransformtransposeMatrix {
  let result = image_transform_transpose_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_transform_transpose_matrix_add(a : ImagetransformtransposeMatrix, b : ImagetransformtransposeMatrix) -> ImagetransformtransposeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_transform_transpose_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_transform_transpose_matrix_scale(m : ImagetransformtransposeMatrix, s : Double) -> ImagetransformtransposeMatrix {
  let result = image_transform_transpose_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_transform_transpose_matrix_multiply(a : ImagetransformtransposeMatrix, b : ImagetransformtransposeMatrix) -> ImagetransformtransposeMatrix {
  if a.cols != b.rows { return image_transform_transpose_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_transform_transpose_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_transform_transpose_matrix_trace(m : ImagetransformtransposeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_transform_transpose_matrix_det(m : ImagetransformtransposeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_transform_transpose_matrix_norm(m : ImagetransformtransposeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_transform_transpose_matrix_to_string(m : ImagetransformtransposeMatrix) -> String {
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

pub(all) struct ImagetransformtransposeVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_transpose_make_vector(comps : Array[Double]) -> ImagetransformtransposeVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_transpose_vector_zero(dim : Int) -> ImagetransformtransposeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_transform_transpose_vector_add(a : ImagetransformtransposeVector, b : ImagetransformtransposeVector) -> ImagetransformtransposeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn image_transform_transpose_vector_sub(a : ImagetransformtransposeVector, b : ImagetransformtransposeVector) -> ImagetransformtransposeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn image_transform_transpose_vector_scale(v : ImagetransformtransposeVector, s : Double) -> ImagetransformtransposeVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn image_transform_transpose_vector_dot(a : ImagetransformtransposeVector, b : ImagetransformtransposeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_transform_transpose_vector_norm(v : ImagetransformtransposeVector) -> Double { @_common.sqrt(image_transform_transpose_vector_dot(v, v)) }

pub fn image_transform_transpose_vector_normalize(v : ImagetransformtransposeVector) -> ImagetransformtransposeVector {
  let n = image_transform_transpose_vector_norm(v)
  if n < 0.0000001 { v } else { image_transform_transpose_vector_scale(v, 1.0 / n) }
}

pub fn image_transform_transpose_vector_dist(a : ImagetransformtransposeVector, b : ImagetransformtransposeVector) -> Double {
  image_transform_transpose_vector_norm(image_transform_transpose_vector_sub(a, b))
}

pub fn image_transform_transpose_vector_to_string(v : ImagetransformtransposeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_transpose_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_transpose_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_transpose_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_transpose_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_transpose_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_transpose_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_transpose_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_transpose_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_transpose_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_transpose_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_transpose_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_transpose_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_transpose_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_transpose_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_transpose_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_transpose_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_transpose_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_transpose_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_transpose_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_transpose_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_transpose_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_transpose_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_transpose_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_transpose_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_transpose_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_transpose_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_transpose_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_transpose_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_transpose_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformtransposeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_frame_make(size : Int) -> ImagetransformtransposeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_frame_len(s : ImagetransformtransposeFrame) -> Int { s.size }

pub fn image_transform_transpose_frame_get(s : ImagetransformtransposeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_frame_set(s : ImagetransformtransposeFrame, i : Int, v : Double) -> ImagetransformtransposeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_frame_sum(s : ImagetransformtransposeFrame) -> Double { @_common.sum(s.data) }

pub fn image_transform_transpose_frame_mean(s : ImagetransformtransposeFrame) -> Double { @_common.mean(s.data) }

pub fn image_transform_transpose_frame_scale(s : ImagetransformtransposeFrame, f : Double) -> ImagetransformtransposeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_frame_add(a : ImagetransformtransposeFrame, b : ImagetransformtransposeFrame) -> ImagetransformtransposeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_transpose_frame_copy(s : ImagetransformtransposeFrame) -> ImagetransformtransposeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_frame_fill(s : ImagetransformtransposeFrame, v : Double) -> ImagetransformtransposeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_frame_min(s : ImagetransformtransposeFrame) -> Double { @_common.min(s.data) }

pub fn image_transform_transpose_frame_max(s : ImagetransformtransposeFrame) -> Double { @_common.max(s.data) }

pub fn image_transform_transpose_frame_to_string(s : ImagetransformtransposeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_table_make(size : Int) -> ImagetransformtransposeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_table_len(s : ImagetransformtransposeTable) -> Int { s.size }

pub fn image_transform_transpose_table_get(s : ImagetransformtransposeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_table_set(s : ImagetransformtransposeTable, i : Int, v : Double) -> ImagetransformtransposeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_table_sum(s : ImagetransformtransposeTable) -> Double { @_common.sum(s.data) }

pub fn image_transform_transpose_table_mean(s : ImagetransformtransposeTable) -> Double { @_common.mean(s.data) }

pub fn image_transform_transpose_table_scale(s : ImagetransformtransposeTable, f : Double) -> ImagetransformtransposeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_table_add(a : ImagetransformtransposeTable, b : ImagetransformtransposeTable) -> ImagetransformtransposeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_transpose_table_copy(s : ImagetransformtransposeTable) -> ImagetransformtransposeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_table_fill(s : ImagetransformtransposeTable, v : Double) -> ImagetransformtransposeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_table_min(s : ImagetransformtransposeTable) -> Double { @_common.min(s.data) }

pub fn image_transform_transpose_table_max(s : ImagetransformtransposeTable) -> Double { @_common.max(s.data) }

pub fn image_transform_transpose_table_to_string(s : ImagetransformtransposeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_graphn_make(size : Int) -> ImagetransformtransposeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_graphn_len(s : ImagetransformtransposeGraphN) -> Int { s.size }

pub fn image_transform_transpose_graphn_get(s : ImagetransformtransposeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_graphn_set(s : ImagetransformtransposeGraphN, i : Int, v : Double) -> ImagetransformtransposeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_graphn_sum(s : ImagetransformtransposeGraphN) -> Double { @_common.sum(s.data) }

pub fn image_transform_transpose_graphn_mean(s : ImagetransformtransposeGraphN) -> Double { @_common.mean(s.data) }

pub fn image_transform_transpose_graphn_scale(s : ImagetransformtransposeGraphN, f : Double) -> ImagetransformtransposeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_graphn_add(a : ImagetransformtransposeGraphN, b : ImagetransformtransposeGraphN) -> ImagetransformtransposeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_transpose_graphn_copy(s : ImagetransformtransposeGraphN) -> ImagetransformtransposeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_graphn_fill(s : ImagetransformtransposeGraphN, v : Double) -> ImagetransformtransposeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_graphn_min(s : ImagetransformtransposeGraphN) -> Double { @_common.min(s.data) }

pub fn image_transform_transpose_graphn_max(s : ImagetransformtransposeGraphN) -> Double { @_common.max(s.data) }

pub fn image_transform_transpose_graphn_to_string(s : ImagetransformtransposeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_node_make(size : Int) -> ImagetransformtransposeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_node_len(s : ImagetransformtransposeNode) -> Int { s.size }

pub fn image_transform_transpose_node_get(s : ImagetransformtransposeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_node_set(s : ImagetransformtransposeNode, i : Int, v : Double) -> ImagetransformtransposeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_node_sum(s : ImagetransformtransposeNode) -> Double { @_common.sum(s.data) }

pub fn image_transform_transpose_node_mean(s : ImagetransformtransposeNode) -> Double { @_common.mean(s.data) }

pub fn image_transform_transpose_node_scale(s : ImagetransformtransposeNode, f : Double) -> ImagetransformtransposeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_node_add(a : ImagetransformtransposeNode, b : ImagetransformtransposeNode) -> ImagetransformtransposeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_transpose_node_copy(s : ImagetransformtransposeNode) -> ImagetransformtransposeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_node_fill(s : ImagetransformtransposeNode, v : Double) -> ImagetransformtransposeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_node_min(s : ImagetransformtransposeNode) -> Double { @_common.min(s.data) }

pub fn image_transform_transpose_node_max(s : ImagetransformtransposeNode) -> Double { @_common.max(s.data) }

pub fn image_transform_transpose_node_to_string(s : ImagetransformtransposeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_edge_make(size : Int) -> ImagetransformtransposeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_edge_len(s : ImagetransformtransposeEdge) -> Int { s.size }

pub fn image_transform_transpose_edge_get(s : ImagetransformtransposeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_edge_set(s : ImagetransformtransposeEdge, i : Int, v : Double) -> ImagetransformtransposeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_edge_sum(s : ImagetransformtransposeEdge) -> Double { @_common.sum(s.data) }

pub fn image_transform_transpose_edge_mean(s : ImagetransformtransposeEdge) -> Double { @_common.mean(s.data) }

pub fn image_transform_transpose_edge_scale(s : ImagetransformtransposeEdge, f : Double) -> ImagetransformtransposeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_edge_add(a : ImagetransformtransposeEdge, b : ImagetransformtransposeEdge) -> ImagetransformtransposeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_transpose_edge_copy(s : ImagetransformtransposeEdge) -> ImagetransformtransposeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_edge_fill(s : ImagetransformtransposeEdge, v : Double) -> ImagetransformtransposeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_edge_min(s : ImagetransformtransposeEdge) -> Double { @_common.min(s.data) }

pub fn image_transform_transpose_edge_max(s : ImagetransformtransposeEdge) -> Double { @_common.max(s.data) }

pub fn image_transform_transpose_edge_to_string(s : ImagetransformtransposeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_path_make(size : Int) -> ImagetransformtransposePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_path_len(s : ImagetransformtransposePath) -> Int { s.size }

pub fn image_transform_transpose_path_get(s : ImagetransformtransposePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_path_set(s : ImagetransformtransposePath, i : Int, v : Double) -> ImagetransformtransposePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_path_sum(s : ImagetransformtransposePath) -> Double { @_common.sum(s.data) }

pub fn image_transform_transpose_path_mean(s : ImagetransformtransposePath) -> Double { @_common.mean(s.data) }

pub fn image_transform_transpose_path_scale(s : ImagetransformtransposePath, f : Double) -> ImagetransformtransposePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_path_add(a : ImagetransformtransposePath, b : ImagetransformtransposePath) -> ImagetransformtransposePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_transpose_path_copy(s : ImagetransformtransposePath) -> ImagetransformtransposePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_path_fill(s : ImagetransformtransposePath, v : Double) -> ImagetransformtransposePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_path_min(s : ImagetransformtransposePath) -> Double { @_common.min(s.data) }

pub fn image_transform_transpose_path_max(s : ImagetransformtransposePath) -> Double { @_common.max(s.data) }

pub fn image_transform_transpose_path_to_string(s : ImagetransformtransposePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_cluster_make(size : Int) -> ImagetransformtransposeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_cluster_len(s : ImagetransformtransposeCluster) -> Int { s.size }

pub fn image_transform_transpose_cluster_get(s : ImagetransformtransposeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_cluster_set(s : ImagetransformtransposeCluster, i : Int, v : Double) -> ImagetransformtransposeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_cluster_sum(s : ImagetransformtransposeCluster) -> Double { @_common.sum(s.data) }

pub fn image_transform_transpose_cluster_mean(s : ImagetransformtransposeCluster) -> Double { @_common.mean(s.data) }

pub fn image_transform_transpose_cluster_scale(s : ImagetransformtransposeCluster, f : Double) -> ImagetransformtransposeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_cluster_add(a : ImagetransformtransposeCluster, b : ImagetransformtransposeCluster) -> ImagetransformtransposeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_transpose_cluster_copy(s : ImagetransformtransposeCluster) -> ImagetransformtransposeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_cluster_fill(s : ImagetransformtransposeCluster, v : Double) -> ImagetransformtransposeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_cluster_min(s : ImagetransformtransposeCluster) -> Double { @_common.min(s.data) }

pub fn image_transform_transpose_cluster_max(s : ImagetransformtransposeCluster) -> Double { @_common.max(s.data) }

pub fn image_transform_transpose_cluster_to_string(s : ImagetransformtransposeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_model_make(size : Int) -> ImagetransformtransposeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_model_len(s : ImagetransformtransposeModel) -> Int { s.size }

pub fn image_transform_transpose_model_get(s : ImagetransformtransposeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_model_set(s : ImagetransformtransposeModel, i : Int, v : Double) -> ImagetransformtransposeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_model_sum(s : ImagetransformtransposeModel) -> Double { @_common.sum(s.data) }

pub fn image_transform_transpose_model_mean(s : ImagetransformtransposeModel) -> Double { @_common.mean(s.data) }

pub fn image_transform_transpose_model_scale(s : ImagetransformtransposeModel, f : Double) -> ImagetransformtransposeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_model_add(a : ImagetransformtransposeModel, b : ImagetransformtransposeModel) -> ImagetransformtransposeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_transpose_model_copy(s : ImagetransformtransposeModel) -> ImagetransformtransposeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_model_fill(s : ImagetransformtransposeModel, v : Double) -> ImagetransformtransposeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_model_min(s : ImagetransformtransposeModel) -> Double { @_common.min(s.data) }

pub fn image_transform_transpose_model_max(s : ImagetransformtransposeModel) -> Double { @_common.max(s.data) }

pub fn image_transform_transpose_model_to_string(s : ImagetransformtransposeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_layer_make(size : Int) -> ImagetransformtransposeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_layer_len(s : ImagetransformtransposeLayer) -> Int { s.size }

pub fn image_transform_transpose_layer_get(s : ImagetransformtransposeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_layer_set(s : ImagetransformtransposeLayer, i : Int, v : Double) -> ImagetransformtransposeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_layer_sum(s : ImagetransformtransposeLayer) -> Double { @_common.sum(s.data) }

pub fn image_transform_transpose_layer_mean(s : ImagetransformtransposeLayer) -> Double { @_common.mean(s.data) }

pub fn image_transform_transpose_layer_scale(s : ImagetransformtransposeLayer, f : Double) -> ImagetransformtransposeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_layer_add(a : ImagetransformtransposeLayer, b : ImagetransformtransposeLayer) -> ImagetransformtransposeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_transpose_layer_copy(s : ImagetransformtransposeLayer) -> ImagetransformtransposeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_layer_fill(s : ImagetransformtransposeLayer, v : Double) -> ImagetransformtransposeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_layer_min(s : ImagetransformtransposeLayer) -> Double { @_common.min(s.data) }

pub fn image_transform_transpose_layer_max(s : ImagetransformtransposeLayer) -> Double { @_common.max(s.data) }

pub fn image_transform_transpose_layer_to_string(s : ImagetransformtransposeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_buffer_make(size : Int) -> ImagetransformtransposeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_buffer_len(s : ImagetransformtransposeBuffer) -> Int { s.size }

pub fn image_transform_transpose_buffer_get(s : ImagetransformtransposeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_buffer_set(s : ImagetransformtransposeBuffer, i : Int, v : Double) -> ImagetransformtransposeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_buffer_sum(s : ImagetransformtransposeBuffer) -> Double { @_common.sum(s.data) }

pub fn image_transform_transpose_buffer_mean(s : ImagetransformtransposeBuffer) -> Double { @_common.mean(s.data) }

pub fn image_transform_transpose_buffer_scale(s : ImagetransformtransposeBuffer, f : Double) -> ImagetransformtransposeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_buffer_add(a : ImagetransformtransposeBuffer, b : ImagetransformtransposeBuffer) -> ImagetransformtransposeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_transpose_buffer_copy(s : ImagetransformtransposeBuffer) -> ImagetransformtransposeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_buffer_fill(s : ImagetransformtransposeBuffer, v : Double) -> ImagetransformtransposeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_buffer_min(s : ImagetransformtransposeBuffer) -> Double { @_common.min(s.data) }

pub fn image_transform_transpose_buffer_max(s : ImagetransformtransposeBuffer) -> Double { @_common.max(s.data) }

pub fn image_transform_transpose_buffer_to_string(s : ImagetransformtransposeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_cursor_make(size : Int) -> ImagetransformtransposeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_cursor_len(s : ImagetransformtransposeCursor) -> Int { s.size }

pub fn image_transform_transpose_cursor_get(s : ImagetransformtransposeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_cursor_set(s : ImagetransformtransposeCursor, i : Int, v : Double) -> ImagetransformtransposeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_cursor_sum(s : ImagetransformtransposeCursor) -> Double { @_common.sum(s.data) }

pub fn image_transform_transpose_cursor_mean(s : ImagetransformtransposeCursor) -> Double { @_common.mean(s.data) }

pub fn image_transform_transpose_cursor_scale(s : ImagetransformtransposeCursor, f : Double) -> ImagetransformtransposeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_cursor_add(a : ImagetransformtransposeCursor, b : ImagetransformtransposeCursor) -> ImagetransformtransposeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_transpose_cursor_copy(s : ImagetransformtransposeCursor) -> ImagetransformtransposeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_cursor_fill(s : ImagetransformtransposeCursor, v : Double) -> ImagetransformtransposeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_cursor_min(s : ImagetransformtransposeCursor) -> Double { @_common.min(s.data) }

pub fn image_transform_transpose_cursor_max(s : ImagetransformtransposeCursor) -> Double { @_common.max(s.data) }

pub fn image_transform_transpose_cursor_to_string(s : ImagetransformtransposeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_view_make(size : Int) -> ImagetransformtransposeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_view_len(s : ImagetransformtransposeView) -> Int { s.size }

pub fn image_transform_transpose_view_get(s : ImagetransformtransposeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_view_set(s : ImagetransformtransposeView, i : Int, v : Double) -> ImagetransformtransposeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_view_sum(s : ImagetransformtransposeView) -> Double { @_common.sum(s.data) }

pub fn image_transform_transpose_view_mean(s : ImagetransformtransposeView) -> Double { @_common.mean(s.data) }

pub fn image_transform_transpose_view_scale(s : ImagetransformtransposeView, f : Double) -> ImagetransformtransposeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_view_add(a : ImagetransformtransposeView, b : ImagetransformtransposeView) -> ImagetransformtransposeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_transpose_view_copy(s : ImagetransformtransposeView) -> ImagetransformtransposeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_view_fill(s : ImagetransformtransposeView, v : Double) -> ImagetransformtransposeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_view_min(s : ImagetransformtransposeView) -> Double { @_common.min(s.data) }

pub fn image_transform_transpose_view_max(s : ImagetransformtransposeView) -> Double { @_common.max(s.data) }

pub fn image_transform_transpose_view_to_string(s : ImagetransformtransposeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_range_make(size : Int) -> ImagetransformtransposeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_range_len(s : ImagetransformtransposeRange) -> Int { s.size }

pub fn image_transform_transpose_range_get(s : ImagetransformtransposeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_range_set(s : ImagetransformtransposeRange, i : Int, v : Double) -> ImagetransformtransposeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_range_sum(s : ImagetransformtransposeRange) -> Double { @_common.sum(s.data) }

pub fn image_transform_transpose_range_mean(s : ImagetransformtransposeRange) -> Double { @_common.mean(s.data) }

pub fn image_transform_transpose_range_scale(s : ImagetransformtransposeRange, f : Double) -> ImagetransformtransposeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_range_add(a : ImagetransformtransposeRange, b : ImagetransformtransposeRange) -> ImagetransformtransposeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_transpose_range_copy(s : ImagetransformtransposeRange) -> ImagetransformtransposeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_range_fill(s : ImagetransformtransposeRange, v : Double) -> ImagetransformtransposeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_range_min(s : ImagetransformtransposeRange) -> Double { @_common.min(s.data) }

pub fn image_transform_transpose_range_max(s : ImagetransformtransposeRange) -> Double { @_common.max(s.data) }

pub fn image_transform_transpose_range_to_string(s : ImagetransformtransposeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformtransposeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_transpose_slice_make(size : Int) -> ImagetransformtransposeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_transpose_slice_len(s : ImagetransformtransposeSlice) -> Int { s.size }

pub fn image_transform_transpose_slice_get(s : ImagetransformtransposeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_transpose_slice_set(s : ImagetransformtransposeSlice, i : Int, v : Double) -> ImagetransformtransposeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_slice_sum(s : ImagetransformtransposeSlice) -> Double { @_common.sum(s.data) }

pub fn image_transform_transpose_slice_mean(s : ImagetransformtransposeSlice) -> Double { @_common.mean(s.data) }

pub fn image_transform_transpose_slice_scale(s : ImagetransformtransposeSlice, f : Double) -> ImagetransformtransposeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_slice_add(a : ImagetransformtransposeSlice, b : ImagetransformtransposeSlice) -> ImagetransformtransposeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_transpose_slice_copy(s : ImagetransformtransposeSlice) -> ImagetransformtransposeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_slice_fill(s : ImagetransformtransposeSlice, v : Double) -> ImagetransformtransposeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_transpose_slice_min(s : ImagetransformtransposeSlice) -> Double { @_common.min(s.data) }

pub fn image_transform_transpose_slice_max(s : ImagetransformtransposeSlice) -> Double { @_common.max(s.data) }

pub fn image_transform_transpose_slice_to_string(s : ImagetransformtransposeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

