///===
/// extcore/image_filter_laplacian

pub(all) struct ImagefilterlaplacianPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_laplacian_make_point(x : Double, y : Double) -> ImagefilterlaplacianPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_laplacian_make_point3(x : Double, y : Double, z : Double) -> ImagefilterlaplacianPoint {
  { x, y, z, label: 0 }
}

pub fn image_filter_laplacian_point_x(pt : ImagefilterlaplacianPoint) -> Double { pt.x }

pub fn image_filter_laplacian_point_y(pt : ImagefilterlaplacianPoint) -> Double { pt.y }

pub fn image_filter_laplacian_point_z(pt : ImagefilterlaplacianPoint) -> Double { pt.z }

pub fn image_filter_laplacian_point_label(pt : ImagefilterlaplacianPoint) -> Int { pt.label }

pub fn image_filter_laplacian_point_dist(a : ImagefilterlaplacianPoint, b : ImagefilterlaplacianPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_filter_laplacian_point_add(a : ImagefilterlaplacianPoint, b : ImagefilterlaplacianPoint) -> ImagefilterlaplacianPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_filter_laplacian_point_sub(a : ImagefilterlaplacianPoint, b : ImagefilterlaplacianPoint) -> ImagefilterlaplacianPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_filter_laplacian_point_scale(pt : ImagefilterlaplacianPoint, s : Double) -> ImagefilterlaplacianPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_filter_laplacian_point_dot(a : ImagefilterlaplacianPoint, b : ImagefilterlaplacianPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_filter_laplacian_point_cross(a : ImagefilterlaplacianPoint, b : ImagefilterlaplacianPoint) -> ImagefilterlaplacianPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_filter_laplacian_point_norm(pt : ImagefilterlaplacianPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_filter_laplacian_point_normalize(pt : ImagefilterlaplacianPoint) -> ImagefilterlaplacianPoint {
  let n = image_filter_laplacian_point_norm(pt)
  if n < 0.0000001 { pt } else { image_filter_laplacian_point_scale(pt, 1.0 / n) }
}

pub fn image_filter_laplacian_point_negate(pt : ImagefilterlaplacianPoint) -> ImagefilterlaplacianPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_filter_laplacian_point_mid(a : ImagefilterlaplacianPoint, b : ImagefilterlaplacianPoint) -> ImagefilterlaplacianPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_filter_laplacian_point_lerp(a : ImagefilterlaplacianPoint, b : ImagefilterlaplacianPoint, t : Double) -> ImagefilterlaplacianPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_filter_laplacian_point_to_string(pt : ImagefilterlaplacianPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_laplacian_make_series(vals : Array[Double], name : String) -> ImagefilterlaplacianSeries {
  { vals, name, meta: 0 }
}

pub fn image_filter_laplacian_series_len(s : ImagefilterlaplacianSeries) -> Int { s.vals.length() }

pub fn image_filter_laplacian_series_sum(s : ImagefilterlaplacianSeries) -> Double { @_common.sum(s.vals) }

pub fn image_filter_laplacian_series_mean(s : ImagefilterlaplacianSeries) -> Double { @_common.mean(s.vals) }

pub fn image_filter_laplacian_series_min(s : ImagefilterlaplacianSeries) -> Double { @_common.min(s.vals) }

pub fn image_filter_laplacian_series_max(s : ImagefilterlaplacianSeries) -> Double { @_common.max(s.vals) }

pub fn image_filter_laplacian_series_range(s : ImagefilterlaplacianSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_filter_laplacian_series_var(s : ImagefilterlaplacianSeries) -> Double { @_common.variance(s.vals) }

pub fn image_filter_laplacian_series_std(s : ImagefilterlaplacianSeries) -> Double { @_common.std(s.vals) }

pub fn image_filter_laplacian_series_median(s : ImagefilterlaplacianSeries) -> Double { @_common.median(s.vals) }

pub fn image_filter_laplacian_series_scale(s : ImagefilterlaplacianSeries, f : Double) -> ImagefilterlaplacianSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_filter_laplacian_series_add(a : ImagefilterlaplacianSeries, b : ImagefilterlaplacianSeries) -> ImagefilterlaplacianSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_filter_laplacian_series_sub(a : ImagefilterlaplacianSeries, b : ImagefilterlaplacianSeries) -> ImagefilterlaplacianSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_filter_laplacian_series_normalize(s : ImagefilterlaplacianSeries) -> ImagefilterlaplacianSeries {
  let mn = image_filter_laplacian_series_min(s)
  let mx = image_filter_laplacian_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_filter_laplacian_series_cumsum(s : ImagefilterlaplacianSeries) -> ImagefilterlaplacianSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_filter_laplacian_series_to_string(s : ImagefilterlaplacianSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefilterlaplacianMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_laplacian_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefilterlaplacianMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_laplacian_matrix_identity(n : Int) -> ImagefilterlaplacianMatrix {
  let m = image_filter_laplacian_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_filter_laplacian_matrix_get(m : ImagefilterlaplacianMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_filter_laplacian_matrix_transpose(m : ImagefilterlaplacianMatrix) -> ImagefilterlaplacianMatrix {
  let result = image_filter_laplacian_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_filter_laplacian_matrix_add(a : ImagefilterlaplacianMatrix, b : ImagefilterlaplacianMatrix) -> ImagefilterlaplacianMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_filter_laplacian_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_filter_laplacian_matrix_scale(m : ImagefilterlaplacianMatrix, s : Double) -> ImagefilterlaplacianMatrix {
  let result = image_filter_laplacian_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_filter_laplacian_matrix_multiply(a : ImagefilterlaplacianMatrix, b : ImagefilterlaplacianMatrix) -> ImagefilterlaplacianMatrix {
  if a.cols != b.rows { return image_filter_laplacian_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_filter_laplacian_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_filter_laplacian_matrix_trace(m : ImagefilterlaplacianMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_filter_laplacian_matrix_det(m : ImagefilterlaplacianMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_filter_laplacian_matrix_norm(m : ImagefilterlaplacianMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_filter_laplacian_matrix_to_string(m : ImagefilterlaplacianMatrix) -> String {
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

pub(all) struct ImagefilterlaplacianVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_laplacian_make_vector(comps : Array[Double]) -> ImagefilterlaplacianVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_laplacian_vector_zero(dim : Int) -> ImagefilterlaplacianVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_filter_laplacian_vector_add(a : ImagefilterlaplacianVector, b : ImagefilterlaplacianVector) -> ImagefilterlaplacianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_laplacian_vector_sub(a : ImagefilterlaplacianVector, b : ImagefilterlaplacianVector) -> ImagefilterlaplacianVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_laplacian_vector_scale(v : ImagefilterlaplacianVector, s : Double) -> ImagefilterlaplacianVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_filter_laplacian_vector_dot(a : ImagefilterlaplacianVector, b : ImagefilterlaplacianVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_filter_laplacian_vector_norm(v : ImagefilterlaplacianVector) -> Double { @_common.sqrt(image_filter_laplacian_vector_dot(v, v)) }

pub fn image_filter_laplacian_vector_normalize(v : ImagefilterlaplacianVector) -> ImagefilterlaplacianVector {
  let n = image_filter_laplacian_vector_norm(v)
  if n < 0.0000001 { v } else { image_filter_laplacian_vector_scale(v, 1.0 / n) }
}

pub fn image_filter_laplacian_vector_dist(a : ImagefilterlaplacianVector, b : ImagefilterlaplacianVector) -> Double {
  image_filter_laplacian_vector_norm(image_filter_laplacian_vector_sub(a, b))
}

pub fn image_filter_laplacian_vector_to_string(v : ImagefilterlaplacianVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_laplacian_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_filter_laplacian_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_filter_laplacian_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_filter_laplacian_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_filter_laplacian_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_filter_laplacian_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_filter_laplacian_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_filter_laplacian_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_filter_laplacian_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_filter_laplacian_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_filter_laplacian_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_filter_laplacian_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_filter_laplacian_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_filter_laplacian_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_filter_laplacian_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_filter_laplacian_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_filter_laplacian_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_filter_laplacian_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_filter_laplacian_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_filter_laplacian_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_filter_laplacian_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_filter_laplacian_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_filter_laplacian_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_filter_laplacian_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_filter_laplacian_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_filter_laplacian_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_filter_laplacian_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_filter_laplacian_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_filter_laplacian_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefilterlaplacianFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_frame_make(size : Int) -> ImagefilterlaplacianFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_frame_len(s : ImagefilterlaplacianFrame) -> Int { s.size }

pub fn image_filter_laplacian_frame_get(s : ImagefilterlaplacianFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_frame_set(s : ImagefilterlaplacianFrame, i : Int, v : Double) -> ImagefilterlaplacianFrame {
  let result = image_filter_laplacian_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_laplacian_frame_sum(s : ImagefilterlaplacianFrame) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_frame_mean(s : ImagefilterlaplacianFrame) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_frame_scale(s : ImagefilterlaplacianFrame, f : Double) -> ImagefilterlaplacianFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_frame_add(a : ImagefilterlaplacianFrame, b : ImagefilterlaplacianFrame) -> ImagefilterlaplacianFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_frame_copy(s : ImagefilterlaplacianFrame) -> ImagefilterlaplacianFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_frame_fill(s : ImagefilterlaplacianFrame, v : Double) -> ImagefilterlaplacianFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_frame_min(s : ImagefilterlaplacianFrame) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_frame_max(s : ImagefilterlaplacianFrame) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_frame_to_string(s : ImagefilterlaplacianFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_table_make(size : Int) -> ImagefilterlaplacianTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_table_len(s : ImagefilterlaplacianTable) -> Int { s.size }

pub fn image_filter_laplacian_table_get(s : ImagefilterlaplacianTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_table_set(s : ImagefilterlaplacianTable, i : Int, v : Double) -> ImagefilterlaplacianTable {
  let result = image_filter_laplacian_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_laplacian_table_sum(s : ImagefilterlaplacianTable) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_table_mean(s : ImagefilterlaplacianTable) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_table_scale(s : ImagefilterlaplacianTable, f : Double) -> ImagefilterlaplacianTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_table_add(a : ImagefilterlaplacianTable, b : ImagefilterlaplacianTable) -> ImagefilterlaplacianTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_table_copy(s : ImagefilterlaplacianTable) -> ImagefilterlaplacianTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_table_fill(s : ImagefilterlaplacianTable, v : Double) -> ImagefilterlaplacianTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_table_min(s : ImagefilterlaplacianTable) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_table_max(s : ImagefilterlaplacianTable) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_table_to_string(s : ImagefilterlaplacianTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_graphn_make(size : Int) -> ImagefilterlaplacianGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_graphn_len(s : ImagefilterlaplacianGraphN) -> Int { s.size }

pub fn image_filter_laplacian_graphn_get(s : ImagefilterlaplacianGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_graphn_set(s : ImagefilterlaplacianGraphN, i : Int, v : Double) -> ImagefilterlaplacianGraphN {
  let result = image_filter_laplacian_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_laplacian_graphn_sum(s : ImagefilterlaplacianGraphN) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_graphn_mean(s : ImagefilterlaplacianGraphN) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_graphn_scale(s : ImagefilterlaplacianGraphN, f : Double) -> ImagefilterlaplacianGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_graphn_add(a : ImagefilterlaplacianGraphN, b : ImagefilterlaplacianGraphN) -> ImagefilterlaplacianGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_graphn_copy(s : ImagefilterlaplacianGraphN) -> ImagefilterlaplacianGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_graphn_fill(s : ImagefilterlaplacianGraphN, v : Double) -> ImagefilterlaplacianGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_graphn_min(s : ImagefilterlaplacianGraphN) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_graphn_max(s : ImagefilterlaplacianGraphN) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_graphn_to_string(s : ImagefilterlaplacianGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_node_make(size : Int) -> ImagefilterlaplacianNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_node_len(s : ImagefilterlaplacianNode) -> Int { s.size }

pub fn image_filter_laplacian_node_get(s : ImagefilterlaplacianNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_node_set(s : ImagefilterlaplacianNode, i : Int, v : Double) -> ImagefilterlaplacianNode {
  let result = image_filter_laplacian_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_laplacian_node_sum(s : ImagefilterlaplacianNode) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_node_mean(s : ImagefilterlaplacianNode) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_node_scale(s : ImagefilterlaplacianNode, f : Double) -> ImagefilterlaplacianNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_node_add(a : ImagefilterlaplacianNode, b : ImagefilterlaplacianNode) -> ImagefilterlaplacianNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_node_copy(s : ImagefilterlaplacianNode) -> ImagefilterlaplacianNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_node_fill(s : ImagefilterlaplacianNode, v : Double) -> ImagefilterlaplacianNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_node_min(s : ImagefilterlaplacianNode) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_node_max(s : ImagefilterlaplacianNode) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_node_to_string(s : ImagefilterlaplacianNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_edge_make(size : Int) -> ImagefilterlaplacianEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_edge_len(s : ImagefilterlaplacianEdge) -> Int { s.size }

pub fn image_filter_laplacian_edge_get(s : ImagefilterlaplacianEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_edge_set(s : ImagefilterlaplacianEdge, i : Int, v : Double) -> ImagefilterlaplacianEdge {
  let result = image_filter_laplacian_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_laplacian_edge_sum(s : ImagefilterlaplacianEdge) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_edge_mean(s : ImagefilterlaplacianEdge) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_edge_scale(s : ImagefilterlaplacianEdge, f : Double) -> ImagefilterlaplacianEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_edge_add(a : ImagefilterlaplacianEdge, b : ImagefilterlaplacianEdge) -> ImagefilterlaplacianEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_edge_copy(s : ImagefilterlaplacianEdge) -> ImagefilterlaplacianEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_edge_fill(s : ImagefilterlaplacianEdge, v : Double) -> ImagefilterlaplacianEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_edge_min(s : ImagefilterlaplacianEdge) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_edge_max(s : ImagefilterlaplacianEdge) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_edge_to_string(s : ImagefilterlaplacianEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_path_make(size : Int) -> ImagefilterlaplacianPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_path_len(s : ImagefilterlaplacianPath) -> Int { s.size }

pub fn image_filter_laplacian_path_get(s : ImagefilterlaplacianPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_path_set(s : ImagefilterlaplacianPath, i : Int, v : Double) -> ImagefilterlaplacianPath {
  let result = image_filter_laplacian_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_laplacian_path_sum(s : ImagefilterlaplacianPath) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_path_mean(s : ImagefilterlaplacianPath) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_path_scale(s : ImagefilterlaplacianPath, f : Double) -> ImagefilterlaplacianPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_path_add(a : ImagefilterlaplacianPath, b : ImagefilterlaplacianPath) -> ImagefilterlaplacianPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_path_copy(s : ImagefilterlaplacianPath) -> ImagefilterlaplacianPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_path_fill(s : ImagefilterlaplacianPath, v : Double) -> ImagefilterlaplacianPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_path_min(s : ImagefilterlaplacianPath) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_path_max(s : ImagefilterlaplacianPath) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_path_to_string(s : ImagefilterlaplacianPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_cluster_make(size : Int) -> ImagefilterlaplacianCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_cluster_len(s : ImagefilterlaplacianCluster) -> Int { s.size }

pub fn image_filter_laplacian_cluster_get(s : ImagefilterlaplacianCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_cluster_set(s : ImagefilterlaplacianCluster, i : Int, v : Double) -> ImagefilterlaplacianCluster {
  let result = image_filter_laplacian_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_laplacian_cluster_sum(s : ImagefilterlaplacianCluster) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_cluster_mean(s : ImagefilterlaplacianCluster) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_cluster_scale(s : ImagefilterlaplacianCluster, f : Double) -> ImagefilterlaplacianCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_cluster_add(a : ImagefilterlaplacianCluster, b : ImagefilterlaplacianCluster) -> ImagefilterlaplacianCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_cluster_copy(s : ImagefilterlaplacianCluster) -> ImagefilterlaplacianCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_cluster_fill(s : ImagefilterlaplacianCluster, v : Double) -> ImagefilterlaplacianCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_cluster_min(s : ImagefilterlaplacianCluster) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_cluster_max(s : ImagefilterlaplacianCluster) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_cluster_to_string(s : ImagefilterlaplacianCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_model_make(size : Int) -> ImagefilterlaplacianModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_model_len(s : ImagefilterlaplacianModel) -> Int { s.size }

pub fn image_filter_laplacian_model_get(s : ImagefilterlaplacianModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_model_set(s : ImagefilterlaplacianModel, i : Int, v : Double) -> ImagefilterlaplacianModel {
  let result = image_filter_laplacian_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_laplacian_model_sum(s : ImagefilterlaplacianModel) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_model_mean(s : ImagefilterlaplacianModel) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_model_scale(s : ImagefilterlaplacianModel, f : Double) -> ImagefilterlaplacianModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_model_add(a : ImagefilterlaplacianModel, b : ImagefilterlaplacianModel) -> ImagefilterlaplacianModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_model_copy(s : ImagefilterlaplacianModel) -> ImagefilterlaplacianModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_model_fill(s : ImagefilterlaplacianModel, v : Double) -> ImagefilterlaplacianModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_model_min(s : ImagefilterlaplacianModel) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_model_max(s : ImagefilterlaplacianModel) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_model_to_string(s : ImagefilterlaplacianModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_layer_make(size : Int) -> ImagefilterlaplacianLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_layer_len(s : ImagefilterlaplacianLayer) -> Int { s.size }

pub fn image_filter_laplacian_layer_get(s : ImagefilterlaplacianLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_layer_set(s : ImagefilterlaplacianLayer, i : Int, v : Double) -> ImagefilterlaplacianLayer {
  let result = image_filter_laplacian_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_laplacian_layer_sum(s : ImagefilterlaplacianLayer) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_layer_mean(s : ImagefilterlaplacianLayer) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_layer_scale(s : ImagefilterlaplacianLayer, f : Double) -> ImagefilterlaplacianLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_layer_add(a : ImagefilterlaplacianLayer, b : ImagefilterlaplacianLayer) -> ImagefilterlaplacianLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_layer_copy(s : ImagefilterlaplacianLayer) -> ImagefilterlaplacianLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_layer_fill(s : ImagefilterlaplacianLayer, v : Double) -> ImagefilterlaplacianLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_layer_min(s : ImagefilterlaplacianLayer) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_layer_max(s : ImagefilterlaplacianLayer) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_layer_to_string(s : ImagefilterlaplacianLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_buffer_make(size : Int) -> ImagefilterlaplacianBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_buffer_len(s : ImagefilterlaplacianBuffer) -> Int { s.size }

pub fn image_filter_laplacian_buffer_get(s : ImagefilterlaplacianBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_buffer_set(s : ImagefilterlaplacianBuffer, i : Int, v : Double) -> ImagefilterlaplacianBuffer {
  let result = image_filter_laplacian_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_laplacian_buffer_sum(s : ImagefilterlaplacianBuffer) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_buffer_mean(s : ImagefilterlaplacianBuffer) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_buffer_scale(s : ImagefilterlaplacianBuffer, f : Double) -> ImagefilterlaplacianBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_buffer_add(a : ImagefilterlaplacianBuffer, b : ImagefilterlaplacianBuffer) -> ImagefilterlaplacianBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_buffer_copy(s : ImagefilterlaplacianBuffer) -> ImagefilterlaplacianBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_buffer_fill(s : ImagefilterlaplacianBuffer, v : Double) -> ImagefilterlaplacianBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_buffer_min(s : ImagefilterlaplacianBuffer) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_buffer_max(s : ImagefilterlaplacianBuffer) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_buffer_to_string(s : ImagefilterlaplacianBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_cursor_make(size : Int) -> ImagefilterlaplacianCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_cursor_len(s : ImagefilterlaplacianCursor) -> Int { s.size }

pub fn image_filter_laplacian_cursor_get(s : ImagefilterlaplacianCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_cursor_set(s : ImagefilterlaplacianCursor, i : Int, v : Double) -> ImagefilterlaplacianCursor {
  let result = image_filter_laplacian_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_laplacian_cursor_sum(s : ImagefilterlaplacianCursor) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_cursor_mean(s : ImagefilterlaplacianCursor) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_cursor_scale(s : ImagefilterlaplacianCursor, f : Double) -> ImagefilterlaplacianCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_cursor_add(a : ImagefilterlaplacianCursor, b : ImagefilterlaplacianCursor) -> ImagefilterlaplacianCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_cursor_copy(s : ImagefilterlaplacianCursor) -> ImagefilterlaplacianCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_cursor_fill(s : ImagefilterlaplacianCursor, v : Double) -> ImagefilterlaplacianCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_cursor_min(s : ImagefilterlaplacianCursor) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_cursor_max(s : ImagefilterlaplacianCursor) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_cursor_to_string(s : ImagefilterlaplacianCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_view_make(size : Int) -> ImagefilterlaplacianView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_view_len(s : ImagefilterlaplacianView) -> Int { s.size }

pub fn image_filter_laplacian_view_get(s : ImagefilterlaplacianView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_view_set(s : ImagefilterlaplacianView, i : Int, v : Double) -> ImagefilterlaplacianView {
  let result = image_filter_laplacian_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_laplacian_view_sum(s : ImagefilterlaplacianView) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_view_mean(s : ImagefilterlaplacianView) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_view_scale(s : ImagefilterlaplacianView, f : Double) -> ImagefilterlaplacianView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_view_add(a : ImagefilterlaplacianView, b : ImagefilterlaplacianView) -> ImagefilterlaplacianView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_view_copy(s : ImagefilterlaplacianView) -> ImagefilterlaplacianView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_view_fill(s : ImagefilterlaplacianView, v : Double) -> ImagefilterlaplacianView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_view_min(s : ImagefilterlaplacianView) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_view_max(s : ImagefilterlaplacianView) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_view_to_string(s : ImagefilterlaplacianView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_range_make(size : Int) -> ImagefilterlaplacianRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_range_len(s : ImagefilterlaplacianRange) -> Int { s.size }

pub fn image_filter_laplacian_range_get(s : ImagefilterlaplacianRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_range_set(s : ImagefilterlaplacianRange, i : Int, v : Double) -> ImagefilterlaplacianRange {
  let result = image_filter_laplacian_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_laplacian_range_sum(s : ImagefilterlaplacianRange) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_range_mean(s : ImagefilterlaplacianRange) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_range_scale(s : ImagefilterlaplacianRange, f : Double) -> ImagefilterlaplacianRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_range_add(a : ImagefilterlaplacianRange, b : ImagefilterlaplacianRange) -> ImagefilterlaplacianRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_range_copy(s : ImagefilterlaplacianRange) -> ImagefilterlaplacianRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_range_fill(s : ImagefilterlaplacianRange, v : Double) -> ImagefilterlaplacianRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_range_min(s : ImagefilterlaplacianRange) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_range_max(s : ImagefilterlaplacianRange) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_range_to_string(s : ImagefilterlaplacianRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterlaplacianSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_laplacian_slice_make(size : Int) -> ImagefilterlaplacianSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_laplacian_slice_len(s : ImagefilterlaplacianSlice) -> Int { s.size }

pub fn image_filter_laplacian_slice_get(s : ImagefilterlaplacianSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_laplacian_slice_set(s : ImagefilterlaplacianSlice, i : Int, v : Double) -> ImagefilterlaplacianSlice {
  let result = image_filter_laplacian_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_laplacian_slice_sum(s : ImagefilterlaplacianSlice) -> Double { @_common.sum(s.data) }

pub fn image_filter_laplacian_slice_mean(s : ImagefilterlaplacianSlice) -> Double { @_common.mean(s.data) }

pub fn image_filter_laplacian_slice_scale(s : ImagefilterlaplacianSlice, f : Double) -> ImagefilterlaplacianSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_slice_add(a : ImagefilterlaplacianSlice, b : ImagefilterlaplacianSlice) -> ImagefilterlaplacianSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_laplacian_slice_copy(s : ImagefilterlaplacianSlice) -> ImagefilterlaplacianSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_slice_fill(s : ImagefilterlaplacianSlice, v : Double) -> ImagefilterlaplacianSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_laplacian_slice_min(s : ImagefilterlaplacianSlice) -> Double { @_common.min(s.data) }

pub fn image_filter_laplacian_slice_max(s : ImagefilterlaplacianSlice) -> Double { @_common.max(s.data) }

pub fn image_filter_laplacian_slice_to_string(s : ImagefilterlaplacianSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

