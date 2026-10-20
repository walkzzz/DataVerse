///===
/// extcore/image_filter_mean

pub(all) struct ImagefiltermeanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_mean_make_point(x : Double, y : Double) -> ImagefiltermeanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_mean_make_point3(x : Double, y : Double, z : Double) -> ImagefiltermeanPoint {
  { x, y, z, label: 0 }
}

pub fn image_filter_mean_point_x(pt : ImagefiltermeanPoint) -> Double { pt.x }

pub fn image_filter_mean_point_y(pt : ImagefiltermeanPoint) -> Double { pt.y }

pub fn image_filter_mean_point_z(pt : ImagefiltermeanPoint) -> Double { pt.z }

pub fn image_filter_mean_point_label(pt : ImagefiltermeanPoint) -> Int { pt.label }

pub fn image_filter_mean_point_dist(a : ImagefiltermeanPoint, b : ImagefiltermeanPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_filter_mean_point_add(a : ImagefiltermeanPoint, b : ImagefiltermeanPoint) -> ImagefiltermeanPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_filter_mean_point_sub(a : ImagefiltermeanPoint, b : ImagefiltermeanPoint) -> ImagefiltermeanPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_filter_mean_point_scale(pt : ImagefiltermeanPoint, s : Double) -> ImagefiltermeanPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_filter_mean_point_dot(a : ImagefiltermeanPoint, b : ImagefiltermeanPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_filter_mean_point_cross(a : ImagefiltermeanPoint, b : ImagefiltermeanPoint) -> ImagefiltermeanPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_filter_mean_point_norm(pt : ImagefiltermeanPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_filter_mean_point_normalize(pt : ImagefiltermeanPoint) -> ImagefiltermeanPoint {
  let n = image_filter_mean_point_norm(pt)
  if n < 0.0000001 { pt } else { image_filter_mean_point_scale(pt, 1.0 / n) }
}

pub fn image_filter_mean_point_negate(pt : ImagefiltermeanPoint) -> ImagefiltermeanPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_filter_mean_point_mid(a : ImagefiltermeanPoint, b : ImagefiltermeanPoint) -> ImagefiltermeanPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_filter_mean_point_lerp(a : ImagefiltermeanPoint, b : ImagefiltermeanPoint, t : Double) -> ImagefiltermeanPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_filter_mean_point_to_string(pt : ImagefiltermeanPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefiltermeanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_mean_make_series(vals : Array[Double], name : String) -> ImagefiltermeanSeries {
  { vals, name, meta: 0 }
}

pub fn image_filter_mean_series_len(s : ImagefiltermeanSeries) -> Int { s.vals.length() }

pub fn image_filter_mean_series_sum(s : ImagefiltermeanSeries) -> Double { @_common.sum(s.vals) }

pub fn image_filter_mean_series_mean(s : ImagefiltermeanSeries) -> Double { @_common.mean(s.vals) }

pub fn image_filter_mean_series_min(s : ImagefiltermeanSeries) -> Double { @_common.min(s.vals) }

pub fn image_filter_mean_series_max(s : ImagefiltermeanSeries) -> Double { @_common.max(s.vals) }

pub fn image_filter_mean_series_range(s : ImagefiltermeanSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_filter_mean_series_var(s : ImagefiltermeanSeries) -> Double { @_common.variance(s.vals) }

pub fn image_filter_mean_series_std(s : ImagefiltermeanSeries) -> Double { @_common.std(s.vals) }

pub fn image_filter_mean_series_median(s : ImagefiltermeanSeries) -> Double { @_common.median(s.vals) }

pub fn image_filter_mean_series_scale(s : ImagefiltermeanSeries, f : Double) -> ImagefiltermeanSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_filter_mean_series_add(a : ImagefiltermeanSeries, b : ImagefiltermeanSeries) -> ImagefiltermeanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_filter_mean_series_sub(a : ImagefiltermeanSeries, b : ImagefiltermeanSeries) -> ImagefiltermeanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_filter_mean_series_normalize(s : ImagefiltermeanSeries) -> ImagefiltermeanSeries {
  let mn = image_filter_mean_series_min(s)
  let mx = image_filter_mean_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_filter_mean_series_cumsum(s : ImagefiltermeanSeries) -> ImagefiltermeanSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_filter_mean_series_to_string(s : ImagefiltermeanSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefiltermeanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_mean_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefiltermeanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_mean_matrix_identity(n : Int) -> ImagefiltermeanMatrix {
  let m = image_filter_mean_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_filter_mean_matrix_get(m : ImagefiltermeanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_filter_mean_matrix_transpose(m : ImagefiltermeanMatrix) -> ImagefiltermeanMatrix {
  let result = image_filter_mean_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_filter_mean_matrix_add(a : ImagefiltermeanMatrix, b : ImagefiltermeanMatrix) -> ImagefiltermeanMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_filter_mean_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_filter_mean_matrix_scale(m : ImagefiltermeanMatrix, s : Double) -> ImagefiltermeanMatrix {
  let result = image_filter_mean_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_filter_mean_matrix_multiply(a : ImagefiltermeanMatrix, b : ImagefiltermeanMatrix) -> ImagefiltermeanMatrix {
  if a.cols != b.rows { return image_filter_mean_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_filter_mean_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_filter_mean_matrix_trace(m : ImagefiltermeanMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_filter_mean_matrix_det(m : ImagefiltermeanMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_filter_mean_matrix_norm(m : ImagefiltermeanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_filter_mean_matrix_to_string(m : ImagefiltermeanMatrix) -> String {
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

pub(all) struct ImagefiltermeanVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_mean_make_vector(comps : Array[Double]) -> ImagefiltermeanVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_mean_vector_zero(dim : Int) -> ImagefiltermeanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_filter_mean_vector_add(a : ImagefiltermeanVector, b : ImagefiltermeanVector) -> ImagefiltermeanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_mean_vector_sub(a : ImagefiltermeanVector, b : ImagefiltermeanVector) -> ImagefiltermeanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_filter_mean_vector_scale(v : ImagefiltermeanVector, s : Double) -> ImagefiltermeanVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_filter_mean_vector_dot(a : ImagefiltermeanVector, b : ImagefiltermeanVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_filter_mean_vector_norm(v : ImagefiltermeanVector) -> Double { @_common.sqrt(image_filter_mean_vector_dot(v, v)) }

pub fn image_filter_mean_vector_normalize(v : ImagefiltermeanVector) -> ImagefiltermeanVector {
  let n = image_filter_mean_vector_norm(v)
  if n < 0.0000001 { v } else { image_filter_mean_vector_scale(v, 1.0 / n) }
}

pub fn image_filter_mean_vector_dist(a : ImagefiltermeanVector, b : ImagefiltermeanVector) -> Double {
  image_filter_mean_vector_norm(image_filter_mean_vector_sub(a, b))
}

pub fn image_filter_mean_vector_to_string(v : ImagefiltermeanVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_mean_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_filter_mean_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_filter_mean_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_filter_mean_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_filter_mean_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_filter_mean_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_filter_mean_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_filter_mean_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_filter_mean_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_filter_mean_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_filter_mean_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_filter_mean_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_filter_mean_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_filter_mean_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_filter_mean_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_filter_mean_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_filter_mean_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_filter_mean_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_filter_mean_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_filter_mean_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_filter_mean_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_filter_mean_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_filter_mean_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_filter_mean_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_filter_mean_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_filter_mean_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_filter_mean_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_filter_mean_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_filter_mean_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefiltermeanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_frame_make(size : Int) -> ImagefiltermeanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_frame_len(s : ImagefiltermeanFrame) -> Int { s.size }

pub fn image_filter_mean_frame_get(s : ImagefiltermeanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_frame_set(s : ImagefiltermeanFrame, i : Int, v : Double) -> ImagefiltermeanFrame {
  let result = image_filter_mean_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_frame_sum(s : ImagefiltermeanFrame) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_frame_mean(s : ImagefiltermeanFrame) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_frame_scale(s : ImagefiltermeanFrame, f : Double) -> ImagefiltermeanFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_frame_add(a : ImagefiltermeanFrame, b : ImagefiltermeanFrame) -> ImagefiltermeanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_frame_copy(s : ImagefiltermeanFrame) -> ImagefiltermeanFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_frame_fill(s : ImagefiltermeanFrame, v : Double) -> ImagefiltermeanFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_frame_min(s : ImagefiltermeanFrame) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_frame_max(s : ImagefiltermeanFrame) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_frame_to_string(s : ImagefiltermeanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_table_make(size : Int) -> ImagefiltermeanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_table_len(s : ImagefiltermeanTable) -> Int { s.size }

pub fn image_filter_mean_table_get(s : ImagefiltermeanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_table_set(s : ImagefiltermeanTable, i : Int, v : Double) -> ImagefiltermeanTable {
  let result = image_filter_mean_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_table_sum(s : ImagefiltermeanTable) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_table_mean(s : ImagefiltermeanTable) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_table_scale(s : ImagefiltermeanTable, f : Double) -> ImagefiltermeanTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_table_add(a : ImagefiltermeanTable, b : ImagefiltermeanTable) -> ImagefiltermeanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_table_copy(s : ImagefiltermeanTable) -> ImagefiltermeanTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_table_fill(s : ImagefiltermeanTable, v : Double) -> ImagefiltermeanTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_table_min(s : ImagefiltermeanTable) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_table_max(s : ImagefiltermeanTable) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_table_to_string(s : ImagefiltermeanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_graphn_make(size : Int) -> ImagefiltermeanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_graphn_len(s : ImagefiltermeanGraphN) -> Int { s.size }

pub fn image_filter_mean_graphn_get(s : ImagefiltermeanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_graphn_set(s : ImagefiltermeanGraphN, i : Int, v : Double) -> ImagefiltermeanGraphN {
  let result = image_filter_mean_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_graphn_sum(s : ImagefiltermeanGraphN) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_graphn_mean(s : ImagefiltermeanGraphN) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_graphn_scale(s : ImagefiltermeanGraphN, f : Double) -> ImagefiltermeanGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_graphn_add(a : ImagefiltermeanGraphN, b : ImagefiltermeanGraphN) -> ImagefiltermeanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_graphn_copy(s : ImagefiltermeanGraphN) -> ImagefiltermeanGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_graphn_fill(s : ImagefiltermeanGraphN, v : Double) -> ImagefiltermeanGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_graphn_min(s : ImagefiltermeanGraphN) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_graphn_max(s : ImagefiltermeanGraphN) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_graphn_to_string(s : ImagefiltermeanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_node_make(size : Int) -> ImagefiltermeanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_node_len(s : ImagefiltermeanNode) -> Int { s.size }

pub fn image_filter_mean_node_get(s : ImagefiltermeanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_node_set(s : ImagefiltermeanNode, i : Int, v : Double) -> ImagefiltermeanNode {
  let result = image_filter_mean_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_node_sum(s : ImagefiltermeanNode) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_node_mean(s : ImagefiltermeanNode) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_node_scale(s : ImagefiltermeanNode, f : Double) -> ImagefiltermeanNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_node_add(a : ImagefiltermeanNode, b : ImagefiltermeanNode) -> ImagefiltermeanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_node_copy(s : ImagefiltermeanNode) -> ImagefiltermeanNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_node_fill(s : ImagefiltermeanNode, v : Double) -> ImagefiltermeanNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_node_min(s : ImagefiltermeanNode) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_node_max(s : ImagefiltermeanNode) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_node_to_string(s : ImagefiltermeanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_edge_make(size : Int) -> ImagefiltermeanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_edge_len(s : ImagefiltermeanEdge) -> Int { s.size }

pub fn image_filter_mean_edge_get(s : ImagefiltermeanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_edge_set(s : ImagefiltermeanEdge, i : Int, v : Double) -> ImagefiltermeanEdge {
  let result = image_filter_mean_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_edge_sum(s : ImagefiltermeanEdge) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_edge_mean(s : ImagefiltermeanEdge) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_edge_scale(s : ImagefiltermeanEdge, f : Double) -> ImagefiltermeanEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_edge_add(a : ImagefiltermeanEdge, b : ImagefiltermeanEdge) -> ImagefiltermeanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_edge_copy(s : ImagefiltermeanEdge) -> ImagefiltermeanEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_edge_fill(s : ImagefiltermeanEdge, v : Double) -> ImagefiltermeanEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_edge_min(s : ImagefiltermeanEdge) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_edge_max(s : ImagefiltermeanEdge) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_edge_to_string(s : ImagefiltermeanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_path_make(size : Int) -> ImagefiltermeanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_path_len(s : ImagefiltermeanPath) -> Int { s.size }

pub fn image_filter_mean_path_get(s : ImagefiltermeanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_path_set(s : ImagefiltermeanPath, i : Int, v : Double) -> ImagefiltermeanPath {
  let result = image_filter_mean_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_path_sum(s : ImagefiltermeanPath) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_path_mean(s : ImagefiltermeanPath) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_path_scale(s : ImagefiltermeanPath, f : Double) -> ImagefiltermeanPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_path_add(a : ImagefiltermeanPath, b : ImagefiltermeanPath) -> ImagefiltermeanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_path_copy(s : ImagefiltermeanPath) -> ImagefiltermeanPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_path_fill(s : ImagefiltermeanPath, v : Double) -> ImagefiltermeanPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_path_min(s : ImagefiltermeanPath) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_path_max(s : ImagefiltermeanPath) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_path_to_string(s : ImagefiltermeanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_cluster_make(size : Int) -> ImagefiltermeanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_cluster_len(s : ImagefiltermeanCluster) -> Int { s.size }

pub fn image_filter_mean_cluster_get(s : ImagefiltermeanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_cluster_set(s : ImagefiltermeanCluster, i : Int, v : Double) -> ImagefiltermeanCluster {
  let result = image_filter_mean_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_cluster_sum(s : ImagefiltermeanCluster) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_cluster_mean(s : ImagefiltermeanCluster) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_cluster_scale(s : ImagefiltermeanCluster, f : Double) -> ImagefiltermeanCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_cluster_add(a : ImagefiltermeanCluster, b : ImagefiltermeanCluster) -> ImagefiltermeanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_cluster_copy(s : ImagefiltermeanCluster) -> ImagefiltermeanCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_cluster_fill(s : ImagefiltermeanCluster, v : Double) -> ImagefiltermeanCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_cluster_min(s : ImagefiltermeanCluster) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_cluster_max(s : ImagefiltermeanCluster) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_cluster_to_string(s : ImagefiltermeanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_model_make(size : Int) -> ImagefiltermeanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_model_len(s : ImagefiltermeanModel) -> Int { s.size }

pub fn image_filter_mean_model_get(s : ImagefiltermeanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_model_set(s : ImagefiltermeanModel, i : Int, v : Double) -> ImagefiltermeanModel {
  let result = image_filter_mean_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_model_sum(s : ImagefiltermeanModel) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_model_mean(s : ImagefiltermeanModel) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_model_scale(s : ImagefiltermeanModel, f : Double) -> ImagefiltermeanModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_model_add(a : ImagefiltermeanModel, b : ImagefiltermeanModel) -> ImagefiltermeanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_model_copy(s : ImagefiltermeanModel) -> ImagefiltermeanModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_model_fill(s : ImagefiltermeanModel, v : Double) -> ImagefiltermeanModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_model_min(s : ImagefiltermeanModel) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_model_max(s : ImagefiltermeanModel) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_model_to_string(s : ImagefiltermeanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_layer_make(size : Int) -> ImagefiltermeanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_layer_len(s : ImagefiltermeanLayer) -> Int { s.size }

pub fn image_filter_mean_layer_get(s : ImagefiltermeanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_layer_set(s : ImagefiltermeanLayer, i : Int, v : Double) -> ImagefiltermeanLayer {
  let result = image_filter_mean_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_layer_sum(s : ImagefiltermeanLayer) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_layer_mean(s : ImagefiltermeanLayer) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_layer_scale(s : ImagefiltermeanLayer, f : Double) -> ImagefiltermeanLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_layer_add(a : ImagefiltermeanLayer, b : ImagefiltermeanLayer) -> ImagefiltermeanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_layer_copy(s : ImagefiltermeanLayer) -> ImagefiltermeanLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_layer_fill(s : ImagefiltermeanLayer, v : Double) -> ImagefiltermeanLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_layer_min(s : ImagefiltermeanLayer) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_layer_max(s : ImagefiltermeanLayer) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_layer_to_string(s : ImagefiltermeanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_buffer_make(size : Int) -> ImagefiltermeanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_buffer_len(s : ImagefiltermeanBuffer) -> Int { s.size }

pub fn image_filter_mean_buffer_get(s : ImagefiltermeanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_buffer_set(s : ImagefiltermeanBuffer, i : Int, v : Double) -> ImagefiltermeanBuffer {
  let result = image_filter_mean_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_buffer_sum(s : ImagefiltermeanBuffer) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_buffer_mean(s : ImagefiltermeanBuffer) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_buffer_scale(s : ImagefiltermeanBuffer, f : Double) -> ImagefiltermeanBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_buffer_add(a : ImagefiltermeanBuffer, b : ImagefiltermeanBuffer) -> ImagefiltermeanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_buffer_copy(s : ImagefiltermeanBuffer) -> ImagefiltermeanBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_buffer_fill(s : ImagefiltermeanBuffer, v : Double) -> ImagefiltermeanBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_buffer_min(s : ImagefiltermeanBuffer) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_buffer_max(s : ImagefiltermeanBuffer) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_buffer_to_string(s : ImagefiltermeanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_cursor_make(size : Int) -> ImagefiltermeanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_cursor_len(s : ImagefiltermeanCursor) -> Int { s.size }

pub fn image_filter_mean_cursor_get(s : ImagefiltermeanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_cursor_set(s : ImagefiltermeanCursor, i : Int, v : Double) -> ImagefiltermeanCursor {
  let result = image_filter_mean_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_cursor_sum(s : ImagefiltermeanCursor) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_cursor_mean(s : ImagefiltermeanCursor) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_cursor_scale(s : ImagefiltermeanCursor, f : Double) -> ImagefiltermeanCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_cursor_add(a : ImagefiltermeanCursor, b : ImagefiltermeanCursor) -> ImagefiltermeanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_cursor_copy(s : ImagefiltermeanCursor) -> ImagefiltermeanCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_cursor_fill(s : ImagefiltermeanCursor, v : Double) -> ImagefiltermeanCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_cursor_min(s : ImagefiltermeanCursor) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_cursor_max(s : ImagefiltermeanCursor) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_cursor_to_string(s : ImagefiltermeanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_view_make(size : Int) -> ImagefiltermeanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_view_len(s : ImagefiltermeanView) -> Int { s.size }

pub fn image_filter_mean_view_get(s : ImagefiltermeanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_view_set(s : ImagefiltermeanView, i : Int, v : Double) -> ImagefiltermeanView {
  let result = image_filter_mean_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_view_sum(s : ImagefiltermeanView) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_view_mean(s : ImagefiltermeanView) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_view_scale(s : ImagefiltermeanView, f : Double) -> ImagefiltermeanView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_view_add(a : ImagefiltermeanView, b : ImagefiltermeanView) -> ImagefiltermeanView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_view_copy(s : ImagefiltermeanView) -> ImagefiltermeanView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_view_fill(s : ImagefiltermeanView, v : Double) -> ImagefiltermeanView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_view_min(s : ImagefiltermeanView) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_view_max(s : ImagefiltermeanView) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_view_to_string(s : ImagefiltermeanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_range_make(size : Int) -> ImagefiltermeanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_range_len(s : ImagefiltermeanRange) -> Int { s.size }

pub fn image_filter_mean_range_get(s : ImagefiltermeanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_range_set(s : ImagefiltermeanRange, i : Int, v : Double) -> ImagefiltermeanRange {
  let result = image_filter_mean_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_range_sum(s : ImagefiltermeanRange) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_range_mean(s : ImagefiltermeanRange) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_range_scale(s : ImagefiltermeanRange, f : Double) -> ImagefiltermeanRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_range_add(a : ImagefiltermeanRange, b : ImagefiltermeanRange) -> ImagefiltermeanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_range_copy(s : ImagefiltermeanRange) -> ImagefiltermeanRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_range_fill(s : ImagefiltermeanRange, v : Double) -> ImagefiltermeanRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_range_min(s : ImagefiltermeanRange) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_range_max(s : ImagefiltermeanRange) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_range_to_string(s : ImagefiltermeanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefiltermeanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_mean_slice_make(size : Int) -> ImagefiltermeanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_mean_slice_len(s : ImagefiltermeanSlice) -> Int { s.size }

pub fn image_filter_mean_slice_get(s : ImagefiltermeanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_mean_slice_set(s : ImagefiltermeanSlice, i : Int, v : Double) -> ImagefiltermeanSlice {
  let result = image_filter_mean_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_filter_mean_slice_sum(s : ImagefiltermeanSlice) -> Double { @_common.sum(s.data) }

pub fn image_filter_mean_slice_mean(s : ImagefiltermeanSlice) -> Double { @_common.mean(s.data) }

pub fn image_filter_mean_slice_scale(s : ImagefiltermeanSlice, f : Double) -> ImagefiltermeanSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_slice_add(a : ImagefiltermeanSlice, b : ImagefiltermeanSlice) -> ImagefiltermeanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_mean_slice_copy(s : ImagefiltermeanSlice) -> ImagefiltermeanSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_slice_fill(s : ImagefiltermeanSlice, v : Double) -> ImagefiltermeanSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_mean_slice_min(s : ImagefiltermeanSlice) -> Double { @_common.min(s.data) }

pub fn image_filter_mean_slice_max(s : ImagefiltermeanSlice) -> Double { @_common.max(s.data) }

pub fn image_filter_mean_slice_to_string(s : ImagefiltermeanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

