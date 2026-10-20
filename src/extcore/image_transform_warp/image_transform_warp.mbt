///===
/// extcore/image_transform_warp

pub(all) struct ImagetransformwarpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_warp_make_point(x : Double, y : Double) -> ImagetransformwarpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_warp_make_point3(x : Double, y : Double, z : Double) -> ImagetransformwarpPoint {
  { x, y, z, label: 0 }
}

pub fn image_transform_warp_point_x(pt : ImagetransformwarpPoint) -> Double { pt.x }

pub fn image_transform_warp_point_y(pt : ImagetransformwarpPoint) -> Double { pt.y }

pub fn image_transform_warp_point_z(pt : ImagetransformwarpPoint) -> Double { pt.z }

pub fn image_transform_warp_point_label(pt : ImagetransformwarpPoint) -> Int { pt.label }

pub fn image_transform_warp_point_dist(a : ImagetransformwarpPoint, b : ImagetransformwarpPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_transform_warp_point_add(a : ImagetransformwarpPoint, b : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_transform_warp_point_sub(a : ImagetransformwarpPoint, b : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_transform_warp_point_scale(pt : ImagetransformwarpPoint, s : Double) -> ImagetransformwarpPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_transform_warp_point_dot(a : ImagetransformwarpPoint, b : ImagetransformwarpPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_transform_warp_point_cross(a : ImagetransformwarpPoint, b : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_transform_warp_point_norm(pt : ImagetransformwarpPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_transform_warp_point_normalize(pt : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  let n = image_transform_warp_point_norm(pt)
  if n < 0.0000001 { pt } else { image_transform_warp_point_scale(pt, 1.0 / n) }
}

pub fn image_transform_warp_point_negate(pt : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_transform_warp_point_mid(a : ImagetransformwarpPoint, b : ImagetransformwarpPoint) -> ImagetransformwarpPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_transform_warp_point_lerp(a : ImagetransformwarpPoint, b : ImagetransformwarpPoint, t : Double) -> ImagetransformwarpPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_transform_warp_point_to_string(pt : ImagetransformwarpPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagetransformwarpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_warp_make_series(vals : Array[Double], name : String) -> ImagetransformwarpSeries {
  { vals, name, meta: 0 }
}

pub fn image_transform_warp_series_len(s : ImagetransformwarpSeries) -> Int { s.vals.length() }

pub fn image_transform_warp_series_sum(s : ImagetransformwarpSeries) -> Double { @_common.sum(s.vals) }

pub fn image_transform_warp_series_mean(s : ImagetransformwarpSeries) -> Double { @_common.mean(s.vals) }

pub fn image_transform_warp_series_min(s : ImagetransformwarpSeries) -> Double { @_common.min(s.vals) }

pub fn image_transform_warp_series_max(s : ImagetransformwarpSeries) -> Double { @_common.max(s.vals) }

pub fn image_transform_warp_series_range(s : ImagetransformwarpSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_transform_warp_series_var(s : ImagetransformwarpSeries) -> Double { @_common.variance(s.vals) }

pub fn image_transform_warp_series_std(s : ImagetransformwarpSeries) -> Double { @_common.std(s.vals) }

pub fn image_transform_warp_series_median(s : ImagetransformwarpSeries) -> Double { @_common.median(s.vals) }

pub fn image_transform_warp_series_scale(s : ImagetransformwarpSeries, f : Double) -> ImagetransformwarpSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_transform_warp_series_add(a : ImagetransformwarpSeries, b : ImagetransformwarpSeries) -> ImagetransformwarpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_transform_warp_series_sub(a : ImagetransformwarpSeries, b : ImagetransformwarpSeries) -> ImagetransformwarpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_transform_warp_series_normalize(s : ImagetransformwarpSeries) -> ImagetransformwarpSeries {
  let mn = image_transform_warp_series_min(s)
  let mx = image_transform_warp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_transform_warp_series_cumsum(s : ImagetransformwarpSeries) -> ImagetransformwarpSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_transform_warp_series_to_string(s : ImagetransformwarpSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformwarpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_warp_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformwarpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_warp_matrix_identity(n : Int) -> ImagetransformwarpMatrix {
  let m = image_transform_warp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_transform_warp_matrix_get(m : ImagetransformwarpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_transform_warp_matrix_transpose(m : ImagetransformwarpMatrix) -> ImagetransformwarpMatrix {
  let result = image_transform_warp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_transform_warp_matrix_add(a : ImagetransformwarpMatrix, b : ImagetransformwarpMatrix) -> ImagetransformwarpMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_transform_warp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_transform_warp_matrix_scale(m : ImagetransformwarpMatrix, s : Double) -> ImagetransformwarpMatrix {
  let result = image_transform_warp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_transform_warp_matrix_multiply(a : ImagetransformwarpMatrix, b : ImagetransformwarpMatrix) -> ImagetransformwarpMatrix {
  if a.cols != b.rows { return image_transform_warp_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_transform_warp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_transform_warp_matrix_trace(m : ImagetransformwarpMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_transform_warp_matrix_det(m : ImagetransformwarpMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_transform_warp_matrix_norm(m : ImagetransformwarpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_transform_warp_matrix_to_string(m : ImagetransformwarpMatrix) -> String {
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

pub(all) struct ImagetransformwarpVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_warp_make_vector(comps : Array[Double]) -> ImagetransformwarpVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_warp_vector_zero(dim : Int) -> ImagetransformwarpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_transform_warp_vector_add(a : ImagetransformwarpVector, b : ImagetransformwarpVector) -> ImagetransformwarpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_warp_vector_sub(a : ImagetransformwarpVector, b : ImagetransformwarpVector) -> ImagetransformwarpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_transform_warp_vector_scale(v : ImagetransformwarpVector, s : Double) -> ImagetransformwarpVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_transform_warp_vector_dot(a : ImagetransformwarpVector, b : ImagetransformwarpVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_transform_warp_vector_norm(v : ImagetransformwarpVector) -> Double { @_common.sqrt(image_transform_warp_vector_dot(v, v)) }

pub fn image_transform_warp_vector_normalize(v : ImagetransformwarpVector) -> ImagetransformwarpVector {
  let n = image_transform_warp_vector_norm(v)
  if n < 0.0000001 { v } else { image_transform_warp_vector_scale(v, 1.0 / n) }
}

pub fn image_transform_warp_vector_dist(a : ImagetransformwarpVector, b : ImagetransformwarpVector) -> Double {
  image_transform_warp_vector_norm(image_transform_warp_vector_sub(a, b))
}

pub fn image_transform_warp_vector_to_string(v : ImagetransformwarpVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_warp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_warp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_warp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_warp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_warp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_warp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_warp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_warp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_warp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_warp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_warp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_warp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_warp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_warp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_warp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_warp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_warp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_warp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_warp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_warp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_warp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_warp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_warp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_warp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_warp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_warp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_warp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_warp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_warp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformwarpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_frame_make(size : Int) -> ImagetransformwarpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_frame_len(s : ImagetransformwarpFrame) -> Int { s.size }

pub fn image_transform_warp_frame_get(s : ImagetransformwarpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_frame_set(s : ImagetransformwarpFrame, i : Int, v : Double) -> ImagetransformwarpFrame {
  let result = image_transform_warp_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_frame_sum(s : ImagetransformwarpFrame) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_frame_mean(s : ImagetransformwarpFrame) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_frame_scale(s : ImagetransformwarpFrame, f : Double) -> ImagetransformwarpFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_frame_add(a : ImagetransformwarpFrame, b : ImagetransformwarpFrame) -> ImagetransformwarpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_frame_copy(s : ImagetransformwarpFrame) -> ImagetransformwarpFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_frame_fill(s : ImagetransformwarpFrame, v : Double) -> ImagetransformwarpFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_frame_min(s : ImagetransformwarpFrame) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_frame_max(s : ImagetransformwarpFrame) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_frame_to_string(s : ImagetransformwarpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_table_make(size : Int) -> ImagetransformwarpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_table_len(s : ImagetransformwarpTable) -> Int { s.size }

pub fn image_transform_warp_table_get(s : ImagetransformwarpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_table_set(s : ImagetransformwarpTable, i : Int, v : Double) -> ImagetransformwarpTable {
  let result = image_transform_warp_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_table_sum(s : ImagetransformwarpTable) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_table_mean(s : ImagetransformwarpTable) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_table_scale(s : ImagetransformwarpTable, f : Double) -> ImagetransformwarpTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_table_add(a : ImagetransformwarpTable, b : ImagetransformwarpTable) -> ImagetransformwarpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_table_copy(s : ImagetransformwarpTable) -> ImagetransformwarpTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_table_fill(s : ImagetransformwarpTable, v : Double) -> ImagetransformwarpTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_table_min(s : ImagetransformwarpTable) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_table_max(s : ImagetransformwarpTable) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_table_to_string(s : ImagetransformwarpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_graphn_make(size : Int) -> ImagetransformwarpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_graphn_len(s : ImagetransformwarpGraphN) -> Int { s.size }

pub fn image_transform_warp_graphn_get(s : ImagetransformwarpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_graphn_set(s : ImagetransformwarpGraphN, i : Int, v : Double) -> ImagetransformwarpGraphN {
  let result = image_transform_warp_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_graphn_sum(s : ImagetransformwarpGraphN) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_graphn_mean(s : ImagetransformwarpGraphN) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_graphn_scale(s : ImagetransformwarpGraphN, f : Double) -> ImagetransformwarpGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_graphn_add(a : ImagetransformwarpGraphN, b : ImagetransformwarpGraphN) -> ImagetransformwarpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_graphn_copy(s : ImagetransformwarpGraphN) -> ImagetransformwarpGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_graphn_fill(s : ImagetransformwarpGraphN, v : Double) -> ImagetransformwarpGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_graphn_min(s : ImagetransformwarpGraphN) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_graphn_max(s : ImagetransformwarpGraphN) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_graphn_to_string(s : ImagetransformwarpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_node_make(size : Int) -> ImagetransformwarpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_node_len(s : ImagetransformwarpNode) -> Int { s.size }

pub fn image_transform_warp_node_get(s : ImagetransformwarpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_node_set(s : ImagetransformwarpNode, i : Int, v : Double) -> ImagetransformwarpNode {
  let result = image_transform_warp_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_node_sum(s : ImagetransformwarpNode) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_node_mean(s : ImagetransformwarpNode) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_node_scale(s : ImagetransformwarpNode, f : Double) -> ImagetransformwarpNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_node_add(a : ImagetransformwarpNode, b : ImagetransformwarpNode) -> ImagetransformwarpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_node_copy(s : ImagetransformwarpNode) -> ImagetransformwarpNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_node_fill(s : ImagetransformwarpNode, v : Double) -> ImagetransformwarpNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_node_min(s : ImagetransformwarpNode) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_node_max(s : ImagetransformwarpNode) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_node_to_string(s : ImagetransformwarpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_edge_make(size : Int) -> ImagetransformwarpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_edge_len(s : ImagetransformwarpEdge) -> Int { s.size }

pub fn image_transform_warp_edge_get(s : ImagetransformwarpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_edge_set(s : ImagetransformwarpEdge, i : Int, v : Double) -> ImagetransformwarpEdge {
  let result = image_transform_warp_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_edge_sum(s : ImagetransformwarpEdge) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_edge_mean(s : ImagetransformwarpEdge) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_edge_scale(s : ImagetransformwarpEdge, f : Double) -> ImagetransformwarpEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_edge_add(a : ImagetransformwarpEdge, b : ImagetransformwarpEdge) -> ImagetransformwarpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_edge_copy(s : ImagetransformwarpEdge) -> ImagetransformwarpEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_edge_fill(s : ImagetransformwarpEdge, v : Double) -> ImagetransformwarpEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_edge_min(s : ImagetransformwarpEdge) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_edge_max(s : ImagetransformwarpEdge) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_edge_to_string(s : ImagetransformwarpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_path_make(size : Int) -> ImagetransformwarpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_path_len(s : ImagetransformwarpPath) -> Int { s.size }

pub fn image_transform_warp_path_get(s : ImagetransformwarpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_path_set(s : ImagetransformwarpPath, i : Int, v : Double) -> ImagetransformwarpPath {
  let result = image_transform_warp_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_path_sum(s : ImagetransformwarpPath) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_path_mean(s : ImagetransformwarpPath) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_path_scale(s : ImagetransformwarpPath, f : Double) -> ImagetransformwarpPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_path_add(a : ImagetransformwarpPath, b : ImagetransformwarpPath) -> ImagetransformwarpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_path_copy(s : ImagetransformwarpPath) -> ImagetransformwarpPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_path_fill(s : ImagetransformwarpPath, v : Double) -> ImagetransformwarpPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_path_min(s : ImagetransformwarpPath) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_path_max(s : ImagetransformwarpPath) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_path_to_string(s : ImagetransformwarpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_cluster_make(size : Int) -> ImagetransformwarpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_cluster_len(s : ImagetransformwarpCluster) -> Int { s.size }

pub fn image_transform_warp_cluster_get(s : ImagetransformwarpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_cluster_set(s : ImagetransformwarpCluster, i : Int, v : Double) -> ImagetransformwarpCluster {
  let result = image_transform_warp_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_cluster_sum(s : ImagetransformwarpCluster) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_cluster_mean(s : ImagetransformwarpCluster) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_cluster_scale(s : ImagetransformwarpCluster, f : Double) -> ImagetransformwarpCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_cluster_add(a : ImagetransformwarpCluster, b : ImagetransformwarpCluster) -> ImagetransformwarpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_cluster_copy(s : ImagetransformwarpCluster) -> ImagetransformwarpCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_cluster_fill(s : ImagetransformwarpCluster, v : Double) -> ImagetransformwarpCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_cluster_min(s : ImagetransformwarpCluster) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_cluster_max(s : ImagetransformwarpCluster) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_cluster_to_string(s : ImagetransformwarpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_model_make(size : Int) -> ImagetransformwarpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_model_len(s : ImagetransformwarpModel) -> Int { s.size }

pub fn image_transform_warp_model_get(s : ImagetransformwarpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_model_set(s : ImagetransformwarpModel, i : Int, v : Double) -> ImagetransformwarpModel {
  let result = image_transform_warp_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_model_sum(s : ImagetransformwarpModel) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_model_mean(s : ImagetransformwarpModel) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_model_scale(s : ImagetransformwarpModel, f : Double) -> ImagetransformwarpModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_model_add(a : ImagetransformwarpModel, b : ImagetransformwarpModel) -> ImagetransformwarpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_model_copy(s : ImagetransformwarpModel) -> ImagetransformwarpModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_model_fill(s : ImagetransformwarpModel, v : Double) -> ImagetransformwarpModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_model_min(s : ImagetransformwarpModel) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_model_max(s : ImagetransformwarpModel) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_model_to_string(s : ImagetransformwarpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_layer_make(size : Int) -> ImagetransformwarpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_layer_len(s : ImagetransformwarpLayer) -> Int { s.size }

pub fn image_transform_warp_layer_get(s : ImagetransformwarpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_layer_set(s : ImagetransformwarpLayer, i : Int, v : Double) -> ImagetransformwarpLayer {
  let result = image_transform_warp_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_layer_sum(s : ImagetransformwarpLayer) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_layer_mean(s : ImagetransformwarpLayer) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_layer_scale(s : ImagetransformwarpLayer, f : Double) -> ImagetransformwarpLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_layer_add(a : ImagetransformwarpLayer, b : ImagetransformwarpLayer) -> ImagetransformwarpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_layer_copy(s : ImagetransformwarpLayer) -> ImagetransformwarpLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_layer_fill(s : ImagetransformwarpLayer, v : Double) -> ImagetransformwarpLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_layer_min(s : ImagetransformwarpLayer) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_layer_max(s : ImagetransformwarpLayer) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_layer_to_string(s : ImagetransformwarpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_buffer_make(size : Int) -> ImagetransformwarpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_buffer_len(s : ImagetransformwarpBuffer) -> Int { s.size }

pub fn image_transform_warp_buffer_get(s : ImagetransformwarpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_buffer_set(s : ImagetransformwarpBuffer, i : Int, v : Double) -> ImagetransformwarpBuffer {
  let result = image_transform_warp_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_buffer_sum(s : ImagetransformwarpBuffer) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_buffer_mean(s : ImagetransformwarpBuffer) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_buffer_scale(s : ImagetransformwarpBuffer, f : Double) -> ImagetransformwarpBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_buffer_add(a : ImagetransformwarpBuffer, b : ImagetransformwarpBuffer) -> ImagetransformwarpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_buffer_copy(s : ImagetransformwarpBuffer) -> ImagetransformwarpBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_buffer_fill(s : ImagetransformwarpBuffer, v : Double) -> ImagetransformwarpBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_buffer_min(s : ImagetransformwarpBuffer) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_buffer_max(s : ImagetransformwarpBuffer) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_buffer_to_string(s : ImagetransformwarpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_cursor_make(size : Int) -> ImagetransformwarpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_cursor_len(s : ImagetransformwarpCursor) -> Int { s.size }

pub fn image_transform_warp_cursor_get(s : ImagetransformwarpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_cursor_set(s : ImagetransformwarpCursor, i : Int, v : Double) -> ImagetransformwarpCursor {
  let result = image_transform_warp_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_cursor_sum(s : ImagetransformwarpCursor) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_cursor_mean(s : ImagetransformwarpCursor) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_cursor_scale(s : ImagetransformwarpCursor, f : Double) -> ImagetransformwarpCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_cursor_add(a : ImagetransformwarpCursor, b : ImagetransformwarpCursor) -> ImagetransformwarpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_cursor_copy(s : ImagetransformwarpCursor) -> ImagetransformwarpCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_cursor_fill(s : ImagetransformwarpCursor, v : Double) -> ImagetransformwarpCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_cursor_min(s : ImagetransformwarpCursor) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_cursor_max(s : ImagetransformwarpCursor) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_cursor_to_string(s : ImagetransformwarpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_view_make(size : Int) -> ImagetransformwarpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_view_len(s : ImagetransformwarpView) -> Int { s.size }

pub fn image_transform_warp_view_get(s : ImagetransformwarpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_view_set(s : ImagetransformwarpView, i : Int, v : Double) -> ImagetransformwarpView {
  let result = image_transform_warp_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_view_sum(s : ImagetransformwarpView) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_view_mean(s : ImagetransformwarpView) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_view_scale(s : ImagetransformwarpView, f : Double) -> ImagetransformwarpView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_view_add(a : ImagetransformwarpView, b : ImagetransformwarpView) -> ImagetransformwarpView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_view_copy(s : ImagetransformwarpView) -> ImagetransformwarpView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_view_fill(s : ImagetransformwarpView, v : Double) -> ImagetransformwarpView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_view_min(s : ImagetransformwarpView) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_view_max(s : ImagetransformwarpView) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_view_to_string(s : ImagetransformwarpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_range_make(size : Int) -> ImagetransformwarpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_range_len(s : ImagetransformwarpRange) -> Int { s.size }

pub fn image_transform_warp_range_get(s : ImagetransformwarpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_range_set(s : ImagetransformwarpRange, i : Int, v : Double) -> ImagetransformwarpRange {
  let result = image_transform_warp_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_range_sum(s : ImagetransformwarpRange) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_range_mean(s : ImagetransformwarpRange) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_range_scale(s : ImagetransformwarpRange, f : Double) -> ImagetransformwarpRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_range_add(a : ImagetransformwarpRange, b : ImagetransformwarpRange) -> ImagetransformwarpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_range_copy(s : ImagetransformwarpRange) -> ImagetransformwarpRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_range_fill(s : ImagetransformwarpRange, v : Double) -> ImagetransformwarpRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_range_min(s : ImagetransformwarpRange) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_range_max(s : ImagetransformwarpRange) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_range_to_string(s : ImagetransformwarpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformwarpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_warp_slice_make(size : Int) -> ImagetransformwarpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_warp_slice_len(s : ImagetransformwarpSlice) -> Int { s.size }

pub fn image_transform_warp_slice_get(s : ImagetransformwarpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_warp_slice_set(s : ImagetransformwarpSlice, i : Int, v : Double) -> ImagetransformwarpSlice {
  let result = image_transform_warp_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_transform_warp_slice_sum(s : ImagetransformwarpSlice) -> Double { @_common.sum(s.data) }

pub fn image_transform_warp_slice_mean(s : ImagetransformwarpSlice) -> Double { @_common.mean(s.data) }

pub fn image_transform_warp_slice_scale(s : ImagetransformwarpSlice, f : Double) -> ImagetransformwarpSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_slice_add(a : ImagetransformwarpSlice, b : ImagetransformwarpSlice) -> ImagetransformwarpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_warp_slice_copy(s : ImagetransformwarpSlice) -> ImagetransformwarpSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_slice_fill(s : ImagetransformwarpSlice, v : Double) -> ImagetransformwarpSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_warp_slice_min(s : ImagetransformwarpSlice) -> Double { @_common.min(s.data) }

pub fn image_transform_warp_slice_max(s : ImagetransformwarpSlice) -> Double { @_common.max(s.data) }

pub fn image_transform_warp_slice_to_string(s : ImagetransformwarpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

