///===
/// extcore/image_feature_brief

pub(all) struct ImagefeaturebriefPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_brief_make_point(x : Double, y : Double) -> ImagefeaturebriefPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_brief_make_point3(x : Double, y : Double, z : Double) -> ImagefeaturebriefPoint {
  { x, y, z, label: 0 }
}

pub fn image_feature_brief_point_x(pt : ImagefeaturebriefPoint) -> Double { pt.x }

pub fn image_feature_brief_point_y(pt : ImagefeaturebriefPoint) -> Double { pt.y }

pub fn image_feature_brief_point_z(pt : ImagefeaturebriefPoint) -> Double { pt.z }

pub fn image_feature_brief_point_label(pt : ImagefeaturebriefPoint) -> Int { pt.label }

pub fn image_feature_brief_point_dist(a : ImagefeaturebriefPoint, b : ImagefeaturebriefPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_feature_brief_point_add(a : ImagefeaturebriefPoint, b : ImagefeaturebriefPoint) -> ImagefeaturebriefPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_feature_brief_point_sub(a : ImagefeaturebriefPoint, b : ImagefeaturebriefPoint) -> ImagefeaturebriefPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_feature_brief_point_scale(pt : ImagefeaturebriefPoint, s : Double) -> ImagefeaturebriefPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_feature_brief_point_dot(a : ImagefeaturebriefPoint, b : ImagefeaturebriefPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_feature_brief_point_cross(a : ImagefeaturebriefPoint, b : ImagefeaturebriefPoint) -> ImagefeaturebriefPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_feature_brief_point_norm(pt : ImagefeaturebriefPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_feature_brief_point_normalize(pt : ImagefeaturebriefPoint) -> ImagefeaturebriefPoint {
  let n = image_feature_brief_point_norm(pt)
  if n < 0.0000001 { pt } else { image_feature_brief_point_scale(pt, 1.0 / n) }
}

pub fn image_feature_brief_point_negate(pt : ImagefeaturebriefPoint) -> ImagefeaturebriefPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_feature_brief_point_mid(a : ImagefeaturebriefPoint, b : ImagefeaturebriefPoint) -> ImagefeaturebriefPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_feature_brief_point_lerp(a : ImagefeaturebriefPoint, b : ImagefeaturebriefPoint, t : Double) -> ImagefeaturebriefPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_feature_brief_point_to_string(pt : ImagefeaturebriefPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefeaturebriefSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_brief_make_series(vals : Array[Double], name : String) -> ImagefeaturebriefSeries {
  { vals, name, meta: 0 }
}

pub fn image_feature_brief_series_len(s : ImagefeaturebriefSeries) -> Int { s.vals.length() }

pub fn image_feature_brief_series_sum(s : ImagefeaturebriefSeries) -> Double { @_common.sum(s.vals) }

pub fn image_feature_brief_series_mean(s : ImagefeaturebriefSeries) -> Double { @_common.mean(s.vals) }

pub fn image_feature_brief_series_min(s : ImagefeaturebriefSeries) -> Double { @_common.min(s.vals) }

pub fn image_feature_brief_series_max(s : ImagefeaturebriefSeries) -> Double { @_common.max(s.vals) }

pub fn image_feature_brief_series_range(s : ImagefeaturebriefSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_feature_brief_series_var(s : ImagefeaturebriefSeries) -> Double { @_common.variance(s.vals) }

pub fn image_feature_brief_series_std(s : ImagefeaturebriefSeries) -> Double { @_common.std(s.vals) }

pub fn image_feature_brief_series_median(s : ImagefeaturebriefSeries) -> Double { @_common.median(s.vals) }

pub fn image_feature_brief_series_scale(s : ImagefeaturebriefSeries, f : Double) -> ImagefeaturebriefSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_feature_brief_series_add(a : ImagefeaturebriefSeries, b : ImagefeaturebriefSeries) -> ImagefeaturebriefSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_feature_brief_series_sub(a : ImagefeaturebriefSeries, b : ImagefeaturebriefSeries) -> ImagefeaturebriefSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_feature_brief_series_normalize(s : ImagefeaturebriefSeries) -> ImagefeaturebriefSeries {
  let mn = image_feature_brief_series_min(s)
  let mx = image_feature_brief_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_feature_brief_series_cumsum(s : ImagefeaturebriefSeries) -> ImagefeaturebriefSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_feature_brief_series_to_string(s : ImagefeaturebriefSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeaturebriefMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_brief_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeaturebriefMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_brief_matrix_identity(n : Int) -> ImagefeaturebriefMatrix {
  let m = image_feature_brief_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_feature_brief_matrix_get(m : ImagefeaturebriefMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_feature_brief_matrix_transpose(m : ImagefeaturebriefMatrix) -> ImagefeaturebriefMatrix {
  let result = image_feature_brief_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_feature_brief_matrix_add(a : ImagefeaturebriefMatrix, b : ImagefeaturebriefMatrix) -> ImagefeaturebriefMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_feature_brief_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_feature_brief_matrix_scale(m : ImagefeaturebriefMatrix, s : Double) -> ImagefeaturebriefMatrix {
  let result = image_feature_brief_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_feature_brief_matrix_multiply(a : ImagefeaturebriefMatrix, b : ImagefeaturebriefMatrix) -> ImagefeaturebriefMatrix {
  if a.cols != b.rows { return image_feature_brief_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_feature_brief_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_feature_brief_matrix_trace(m : ImagefeaturebriefMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_feature_brief_matrix_det(m : ImagefeaturebriefMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_feature_brief_matrix_norm(m : ImagefeaturebriefMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_feature_brief_matrix_to_string(m : ImagefeaturebriefMatrix) -> String {
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

pub(all) struct ImagefeaturebriefVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_brief_make_vector(comps : Array[Double]) -> ImagefeaturebriefVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_brief_vector_zero(dim : Int) -> ImagefeaturebriefVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_feature_brief_vector_add(a : ImagefeaturebriefVector, b : ImagefeaturebriefVector) -> ImagefeaturebriefVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_brief_vector_sub(a : ImagefeaturebriefVector, b : ImagefeaturebriefVector) -> ImagefeaturebriefVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_feature_brief_vector_scale(v : ImagefeaturebriefVector, s : Double) -> ImagefeaturebriefVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_feature_brief_vector_dot(a : ImagefeaturebriefVector, b : ImagefeaturebriefVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_feature_brief_vector_norm(v : ImagefeaturebriefVector) -> Double { @_common.sqrt(image_feature_brief_vector_dot(v, v)) }

pub fn image_feature_brief_vector_normalize(v : ImagefeaturebriefVector) -> ImagefeaturebriefVector {
  let n = image_feature_brief_vector_norm(v)
  if n < 0.0000001 { v } else { image_feature_brief_vector_scale(v, 1.0 / n) }
}

pub fn image_feature_brief_vector_dist(a : ImagefeaturebriefVector, b : ImagefeaturebriefVector) -> Double {
  image_feature_brief_vector_norm(image_feature_brief_vector_sub(a, b))
}

pub fn image_feature_brief_vector_to_string(v : ImagefeaturebriefVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_brief_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_feature_brief_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_feature_brief_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_feature_brief_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_feature_brief_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_feature_brief_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_feature_brief_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_feature_brief_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_feature_brief_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_feature_brief_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_feature_brief_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_feature_brief_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_feature_brief_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_feature_brief_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_feature_brief_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_feature_brief_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_feature_brief_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_feature_brief_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_feature_brief_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_feature_brief_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_feature_brief_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_feature_brief_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_feature_brief_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_feature_brief_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_feature_brief_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_feature_brief_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_feature_brief_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_feature_brief_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_feature_brief_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefeaturebriefFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_frame_make(size : Int) -> ImagefeaturebriefFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_frame_len(s : ImagefeaturebriefFrame) -> Int { s.size }

pub fn image_feature_brief_frame_get(s : ImagefeaturebriefFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_frame_set(s : ImagefeaturebriefFrame, i : Int, v : Double) -> ImagefeaturebriefFrame {
  let result = image_feature_brief_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_frame_sum(s : ImagefeaturebriefFrame) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_frame_mean(s : ImagefeaturebriefFrame) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_frame_scale(s : ImagefeaturebriefFrame, f : Double) -> ImagefeaturebriefFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_frame_add(a : ImagefeaturebriefFrame, b : ImagefeaturebriefFrame) -> ImagefeaturebriefFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_frame_copy(s : ImagefeaturebriefFrame) -> ImagefeaturebriefFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_frame_fill(s : ImagefeaturebriefFrame, v : Double) -> ImagefeaturebriefFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_frame_min(s : ImagefeaturebriefFrame) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_frame_max(s : ImagefeaturebriefFrame) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_frame_to_string(s : ImagefeaturebriefFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_table_make(size : Int) -> ImagefeaturebriefTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_table_len(s : ImagefeaturebriefTable) -> Int { s.size }

pub fn image_feature_brief_table_get(s : ImagefeaturebriefTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_table_set(s : ImagefeaturebriefTable, i : Int, v : Double) -> ImagefeaturebriefTable {
  let result = image_feature_brief_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_table_sum(s : ImagefeaturebriefTable) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_table_mean(s : ImagefeaturebriefTable) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_table_scale(s : ImagefeaturebriefTable, f : Double) -> ImagefeaturebriefTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_table_add(a : ImagefeaturebriefTable, b : ImagefeaturebriefTable) -> ImagefeaturebriefTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_table_copy(s : ImagefeaturebriefTable) -> ImagefeaturebriefTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_table_fill(s : ImagefeaturebriefTable, v : Double) -> ImagefeaturebriefTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_table_min(s : ImagefeaturebriefTable) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_table_max(s : ImagefeaturebriefTable) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_table_to_string(s : ImagefeaturebriefTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_graphn_make(size : Int) -> ImagefeaturebriefGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_graphn_len(s : ImagefeaturebriefGraphN) -> Int { s.size }

pub fn image_feature_brief_graphn_get(s : ImagefeaturebriefGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_graphn_set(s : ImagefeaturebriefGraphN, i : Int, v : Double) -> ImagefeaturebriefGraphN {
  let result = image_feature_brief_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_graphn_sum(s : ImagefeaturebriefGraphN) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_graphn_mean(s : ImagefeaturebriefGraphN) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_graphn_scale(s : ImagefeaturebriefGraphN, f : Double) -> ImagefeaturebriefGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_graphn_add(a : ImagefeaturebriefGraphN, b : ImagefeaturebriefGraphN) -> ImagefeaturebriefGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_graphn_copy(s : ImagefeaturebriefGraphN) -> ImagefeaturebriefGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_graphn_fill(s : ImagefeaturebriefGraphN, v : Double) -> ImagefeaturebriefGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_graphn_min(s : ImagefeaturebriefGraphN) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_graphn_max(s : ImagefeaturebriefGraphN) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_graphn_to_string(s : ImagefeaturebriefGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_node_make(size : Int) -> ImagefeaturebriefNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_node_len(s : ImagefeaturebriefNode) -> Int { s.size }

pub fn image_feature_brief_node_get(s : ImagefeaturebriefNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_node_set(s : ImagefeaturebriefNode, i : Int, v : Double) -> ImagefeaturebriefNode {
  let result = image_feature_brief_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_node_sum(s : ImagefeaturebriefNode) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_node_mean(s : ImagefeaturebriefNode) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_node_scale(s : ImagefeaturebriefNode, f : Double) -> ImagefeaturebriefNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_node_add(a : ImagefeaturebriefNode, b : ImagefeaturebriefNode) -> ImagefeaturebriefNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_node_copy(s : ImagefeaturebriefNode) -> ImagefeaturebriefNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_node_fill(s : ImagefeaturebriefNode, v : Double) -> ImagefeaturebriefNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_node_min(s : ImagefeaturebriefNode) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_node_max(s : ImagefeaturebriefNode) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_node_to_string(s : ImagefeaturebriefNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_edge_make(size : Int) -> ImagefeaturebriefEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_edge_len(s : ImagefeaturebriefEdge) -> Int { s.size }

pub fn image_feature_brief_edge_get(s : ImagefeaturebriefEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_edge_set(s : ImagefeaturebriefEdge, i : Int, v : Double) -> ImagefeaturebriefEdge {
  let result = image_feature_brief_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_edge_sum(s : ImagefeaturebriefEdge) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_edge_mean(s : ImagefeaturebriefEdge) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_edge_scale(s : ImagefeaturebriefEdge, f : Double) -> ImagefeaturebriefEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_edge_add(a : ImagefeaturebriefEdge, b : ImagefeaturebriefEdge) -> ImagefeaturebriefEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_edge_copy(s : ImagefeaturebriefEdge) -> ImagefeaturebriefEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_edge_fill(s : ImagefeaturebriefEdge, v : Double) -> ImagefeaturebriefEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_edge_min(s : ImagefeaturebriefEdge) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_edge_max(s : ImagefeaturebriefEdge) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_edge_to_string(s : ImagefeaturebriefEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_path_make(size : Int) -> ImagefeaturebriefPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_path_len(s : ImagefeaturebriefPath) -> Int { s.size }

pub fn image_feature_brief_path_get(s : ImagefeaturebriefPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_path_set(s : ImagefeaturebriefPath, i : Int, v : Double) -> ImagefeaturebriefPath {
  let result = image_feature_brief_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_path_sum(s : ImagefeaturebriefPath) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_path_mean(s : ImagefeaturebriefPath) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_path_scale(s : ImagefeaturebriefPath, f : Double) -> ImagefeaturebriefPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_path_add(a : ImagefeaturebriefPath, b : ImagefeaturebriefPath) -> ImagefeaturebriefPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_path_copy(s : ImagefeaturebriefPath) -> ImagefeaturebriefPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_path_fill(s : ImagefeaturebriefPath, v : Double) -> ImagefeaturebriefPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_path_min(s : ImagefeaturebriefPath) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_path_max(s : ImagefeaturebriefPath) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_path_to_string(s : ImagefeaturebriefPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_cluster_make(size : Int) -> ImagefeaturebriefCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_cluster_len(s : ImagefeaturebriefCluster) -> Int { s.size }

pub fn image_feature_brief_cluster_get(s : ImagefeaturebriefCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_cluster_set(s : ImagefeaturebriefCluster, i : Int, v : Double) -> ImagefeaturebriefCluster {
  let result = image_feature_brief_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_cluster_sum(s : ImagefeaturebriefCluster) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_cluster_mean(s : ImagefeaturebriefCluster) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_cluster_scale(s : ImagefeaturebriefCluster, f : Double) -> ImagefeaturebriefCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_cluster_add(a : ImagefeaturebriefCluster, b : ImagefeaturebriefCluster) -> ImagefeaturebriefCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_cluster_copy(s : ImagefeaturebriefCluster) -> ImagefeaturebriefCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_cluster_fill(s : ImagefeaturebriefCluster, v : Double) -> ImagefeaturebriefCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_cluster_min(s : ImagefeaturebriefCluster) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_cluster_max(s : ImagefeaturebriefCluster) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_cluster_to_string(s : ImagefeaturebriefCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_model_make(size : Int) -> ImagefeaturebriefModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_model_len(s : ImagefeaturebriefModel) -> Int { s.size }

pub fn image_feature_brief_model_get(s : ImagefeaturebriefModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_model_set(s : ImagefeaturebriefModel, i : Int, v : Double) -> ImagefeaturebriefModel {
  let result = image_feature_brief_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_model_sum(s : ImagefeaturebriefModel) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_model_mean(s : ImagefeaturebriefModel) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_model_scale(s : ImagefeaturebriefModel, f : Double) -> ImagefeaturebriefModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_model_add(a : ImagefeaturebriefModel, b : ImagefeaturebriefModel) -> ImagefeaturebriefModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_model_copy(s : ImagefeaturebriefModel) -> ImagefeaturebriefModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_model_fill(s : ImagefeaturebriefModel, v : Double) -> ImagefeaturebriefModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_model_min(s : ImagefeaturebriefModel) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_model_max(s : ImagefeaturebriefModel) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_model_to_string(s : ImagefeaturebriefModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_layer_make(size : Int) -> ImagefeaturebriefLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_layer_len(s : ImagefeaturebriefLayer) -> Int { s.size }

pub fn image_feature_brief_layer_get(s : ImagefeaturebriefLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_layer_set(s : ImagefeaturebriefLayer, i : Int, v : Double) -> ImagefeaturebriefLayer {
  let result = image_feature_brief_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_layer_sum(s : ImagefeaturebriefLayer) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_layer_mean(s : ImagefeaturebriefLayer) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_layer_scale(s : ImagefeaturebriefLayer, f : Double) -> ImagefeaturebriefLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_layer_add(a : ImagefeaturebriefLayer, b : ImagefeaturebriefLayer) -> ImagefeaturebriefLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_layer_copy(s : ImagefeaturebriefLayer) -> ImagefeaturebriefLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_layer_fill(s : ImagefeaturebriefLayer, v : Double) -> ImagefeaturebriefLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_layer_min(s : ImagefeaturebriefLayer) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_layer_max(s : ImagefeaturebriefLayer) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_layer_to_string(s : ImagefeaturebriefLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_buffer_make(size : Int) -> ImagefeaturebriefBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_buffer_len(s : ImagefeaturebriefBuffer) -> Int { s.size }

pub fn image_feature_brief_buffer_get(s : ImagefeaturebriefBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_buffer_set(s : ImagefeaturebriefBuffer, i : Int, v : Double) -> ImagefeaturebriefBuffer {
  let result = image_feature_brief_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_buffer_sum(s : ImagefeaturebriefBuffer) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_buffer_mean(s : ImagefeaturebriefBuffer) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_buffer_scale(s : ImagefeaturebriefBuffer, f : Double) -> ImagefeaturebriefBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_buffer_add(a : ImagefeaturebriefBuffer, b : ImagefeaturebriefBuffer) -> ImagefeaturebriefBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_buffer_copy(s : ImagefeaturebriefBuffer) -> ImagefeaturebriefBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_buffer_fill(s : ImagefeaturebriefBuffer, v : Double) -> ImagefeaturebriefBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_buffer_min(s : ImagefeaturebriefBuffer) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_buffer_max(s : ImagefeaturebriefBuffer) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_buffer_to_string(s : ImagefeaturebriefBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_cursor_make(size : Int) -> ImagefeaturebriefCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_cursor_len(s : ImagefeaturebriefCursor) -> Int { s.size }

pub fn image_feature_brief_cursor_get(s : ImagefeaturebriefCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_cursor_set(s : ImagefeaturebriefCursor, i : Int, v : Double) -> ImagefeaturebriefCursor {
  let result = image_feature_brief_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_cursor_sum(s : ImagefeaturebriefCursor) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_cursor_mean(s : ImagefeaturebriefCursor) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_cursor_scale(s : ImagefeaturebriefCursor, f : Double) -> ImagefeaturebriefCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_cursor_add(a : ImagefeaturebriefCursor, b : ImagefeaturebriefCursor) -> ImagefeaturebriefCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_cursor_copy(s : ImagefeaturebriefCursor) -> ImagefeaturebriefCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_cursor_fill(s : ImagefeaturebriefCursor, v : Double) -> ImagefeaturebriefCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_cursor_min(s : ImagefeaturebriefCursor) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_cursor_max(s : ImagefeaturebriefCursor) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_cursor_to_string(s : ImagefeaturebriefCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_view_make(size : Int) -> ImagefeaturebriefView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_view_len(s : ImagefeaturebriefView) -> Int { s.size }

pub fn image_feature_brief_view_get(s : ImagefeaturebriefView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_view_set(s : ImagefeaturebriefView, i : Int, v : Double) -> ImagefeaturebriefView {
  let result = image_feature_brief_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_view_sum(s : ImagefeaturebriefView) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_view_mean(s : ImagefeaturebriefView) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_view_scale(s : ImagefeaturebriefView, f : Double) -> ImagefeaturebriefView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_view_add(a : ImagefeaturebriefView, b : ImagefeaturebriefView) -> ImagefeaturebriefView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_view_copy(s : ImagefeaturebriefView) -> ImagefeaturebriefView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_view_fill(s : ImagefeaturebriefView, v : Double) -> ImagefeaturebriefView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_view_min(s : ImagefeaturebriefView) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_view_max(s : ImagefeaturebriefView) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_view_to_string(s : ImagefeaturebriefView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_range_make(size : Int) -> ImagefeaturebriefRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_range_len(s : ImagefeaturebriefRange) -> Int { s.size }

pub fn image_feature_brief_range_get(s : ImagefeaturebriefRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_range_set(s : ImagefeaturebriefRange, i : Int, v : Double) -> ImagefeaturebriefRange {
  let result = image_feature_brief_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_range_sum(s : ImagefeaturebriefRange) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_range_mean(s : ImagefeaturebriefRange) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_range_scale(s : ImagefeaturebriefRange, f : Double) -> ImagefeaturebriefRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_range_add(a : ImagefeaturebriefRange, b : ImagefeaturebriefRange) -> ImagefeaturebriefRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_range_copy(s : ImagefeaturebriefRange) -> ImagefeaturebriefRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_range_fill(s : ImagefeaturebriefRange, v : Double) -> ImagefeaturebriefRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_range_min(s : ImagefeaturebriefRange) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_range_max(s : ImagefeaturebriefRange) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_range_to_string(s : ImagefeaturebriefRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeaturebriefSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_brief_slice_make(size : Int) -> ImagefeaturebriefSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_brief_slice_len(s : ImagefeaturebriefSlice) -> Int { s.size }

pub fn image_feature_brief_slice_get(s : ImagefeaturebriefSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_brief_slice_set(s : ImagefeaturebriefSlice, i : Int, v : Double) -> ImagefeaturebriefSlice {
  let result = image_feature_brief_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_feature_brief_slice_sum(s : ImagefeaturebriefSlice) -> Double { @_common.sum(s.data) }

pub fn image_feature_brief_slice_mean(s : ImagefeaturebriefSlice) -> Double { @_common.mean(s.data) }

pub fn image_feature_brief_slice_scale(s : ImagefeaturebriefSlice, f : Double) -> ImagefeaturebriefSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_slice_add(a : ImagefeaturebriefSlice, b : ImagefeaturebriefSlice) -> ImagefeaturebriefSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_brief_slice_copy(s : ImagefeaturebriefSlice) -> ImagefeaturebriefSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_slice_fill(s : ImagefeaturebriefSlice, v : Double) -> ImagefeaturebriefSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_brief_slice_min(s : ImagefeaturebriefSlice) -> Double { @_common.min(s.data) }

pub fn image_feature_brief_slice_max(s : ImagefeaturebriefSlice) -> Double { @_common.max(s.data) }

pub fn image_feature_brief_slice_to_string(s : ImagefeaturebriefSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

