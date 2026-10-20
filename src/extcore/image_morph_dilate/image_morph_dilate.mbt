///===
/// extcore/image_morph_dilate

pub(all) struct ImagemorphdilatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_dilate_make_point(x : Double, y : Double) -> ImagemorphdilatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_dilate_make_point3(x : Double, y : Double, z : Double) -> ImagemorphdilatePoint {
  { x, y, z, label: 0 }
}

pub fn image_morph_dilate_point_x(pt : ImagemorphdilatePoint) -> Double { pt.x }

pub fn image_morph_dilate_point_y(pt : ImagemorphdilatePoint) -> Double { pt.y }

pub fn image_morph_dilate_point_z(pt : ImagemorphdilatePoint) -> Double { pt.z }

pub fn image_morph_dilate_point_label(pt : ImagemorphdilatePoint) -> Int { pt.label }

pub fn image_morph_dilate_point_dist(a : ImagemorphdilatePoint, b : ImagemorphdilatePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_morph_dilate_point_add(a : ImagemorphdilatePoint, b : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_morph_dilate_point_sub(a : ImagemorphdilatePoint, b : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_morph_dilate_point_scale(pt : ImagemorphdilatePoint, s : Double) -> ImagemorphdilatePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_morph_dilate_point_dot(a : ImagemorphdilatePoint, b : ImagemorphdilatePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_morph_dilate_point_cross(a : ImagemorphdilatePoint, b : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_morph_dilate_point_norm(pt : ImagemorphdilatePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_morph_dilate_point_normalize(pt : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  let n = image_morph_dilate_point_norm(pt)
  if n < 0.0000001 { pt } else { image_morph_dilate_point_scale(pt, 1.0 / n) }
}

pub fn image_morph_dilate_point_negate(pt : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_morph_dilate_point_mid(a : ImagemorphdilatePoint, b : ImagemorphdilatePoint) -> ImagemorphdilatePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_morph_dilate_point_lerp(a : ImagemorphdilatePoint, b : ImagemorphdilatePoint, t : Double) -> ImagemorphdilatePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_morph_dilate_point_to_string(pt : ImagemorphdilatePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagemorphdilateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_dilate_make_series(vals : Array[Double], name : String) -> ImagemorphdilateSeries {
  { vals, name, meta: 0 }
}

pub fn image_morph_dilate_series_len(s : ImagemorphdilateSeries) -> Int { s.vals.length() }

pub fn image_morph_dilate_series_sum(s : ImagemorphdilateSeries) -> Double { @_common.sum(s.vals) }

pub fn image_morph_dilate_series_mean(s : ImagemorphdilateSeries) -> Double { @_common.mean(s.vals) }

pub fn image_morph_dilate_series_min(s : ImagemorphdilateSeries) -> Double { @_common.min(s.vals) }

pub fn image_morph_dilate_series_max(s : ImagemorphdilateSeries) -> Double { @_common.max(s.vals) }

pub fn image_morph_dilate_series_range(s : ImagemorphdilateSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_morph_dilate_series_var(s : ImagemorphdilateSeries) -> Double { @_common.variance(s.vals) }

pub fn image_morph_dilate_series_std(s : ImagemorphdilateSeries) -> Double { @_common.std(s.vals) }

pub fn image_morph_dilate_series_median(s : ImagemorphdilateSeries) -> Double { @_common.median(s.vals) }

pub fn image_morph_dilate_series_scale(s : ImagemorphdilateSeries, f : Double) -> ImagemorphdilateSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn image_morph_dilate_series_add(a : ImagemorphdilateSeries, b : ImagemorphdilateSeries) -> ImagemorphdilateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_morph_dilate_series_sub(a : ImagemorphdilateSeries, b : ImagemorphdilateSeries) -> ImagemorphdilateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_morph_dilate_series_normalize(s : ImagemorphdilateSeries) -> ImagemorphdilateSeries {
  let mn = image_morph_dilate_series_min(s)
  let mx = image_morph_dilate_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_morph_dilate_series_cumsum(s : ImagemorphdilateSeries) -> ImagemorphdilateSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_morph_dilate_series_to_string(s : ImagemorphdilateSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphdilateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_dilate_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphdilateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_dilate_matrix_identity(n : Int) -> ImagemorphdilateMatrix {
  let m = image_morph_dilate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_morph_dilate_matrix_get(m : ImagemorphdilateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_morph_dilate_matrix_transpose(m : ImagemorphdilateMatrix) -> ImagemorphdilateMatrix {
  let result = image_morph_dilate_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_morph_dilate_matrix_add(a : ImagemorphdilateMatrix, b : ImagemorphdilateMatrix) -> ImagemorphdilateMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_morph_dilate_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_morph_dilate_matrix_scale(m : ImagemorphdilateMatrix, s : Double) -> ImagemorphdilateMatrix {
  let result = image_morph_dilate_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_morph_dilate_matrix_multiply(a : ImagemorphdilateMatrix, b : ImagemorphdilateMatrix) -> ImagemorphdilateMatrix {
  if a.cols != b.rows { return image_morph_dilate_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_morph_dilate_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_morph_dilate_matrix_trace(m : ImagemorphdilateMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_morph_dilate_matrix_det(m : ImagemorphdilateMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_morph_dilate_matrix_norm(m : ImagemorphdilateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_morph_dilate_matrix_to_string(m : ImagemorphdilateMatrix) -> String {
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

pub(all) struct ImagemorphdilateVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_dilate_make_vector(comps : Array[Double]) -> ImagemorphdilateVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_dilate_vector_zero(dim : Int) -> ImagemorphdilateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_morph_dilate_vector_add(a : ImagemorphdilateVector, b : ImagemorphdilateVector) -> ImagemorphdilateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_morph_dilate_vector_sub(a : ImagemorphdilateVector, b : ImagemorphdilateVector) -> ImagemorphdilateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn image_morph_dilate_vector_scale(v : ImagemorphdilateVector, s : Double) -> ImagemorphdilateVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn image_morph_dilate_vector_dot(a : ImagemorphdilateVector, b : ImagemorphdilateVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_morph_dilate_vector_norm(v : ImagemorphdilateVector) -> Double { @_common.sqrt(image_morph_dilate_vector_dot(v, v)) }

pub fn image_morph_dilate_vector_normalize(v : ImagemorphdilateVector) -> ImagemorphdilateVector {
  let n = image_morph_dilate_vector_norm(v)
  if n < 0.0000001 { v } else { image_morph_dilate_vector_scale(v, 1.0 / n) }
}

pub fn image_morph_dilate_vector_dist(a : ImagemorphdilateVector, b : ImagemorphdilateVector) -> Double {
  image_morph_dilate_vector_norm(image_morph_dilate_vector_sub(a, b))
}

pub fn image_morph_dilate_vector_to_string(v : ImagemorphdilateVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_dilate_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_morph_dilate_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_morph_dilate_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_morph_dilate_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_morph_dilate_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_morph_dilate_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_morph_dilate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_morph_dilate_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_morph_dilate_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_morph_dilate_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_morph_dilate_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_morph_dilate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_morph_dilate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_morph_dilate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_morph_dilate_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_morph_dilate_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_morph_dilate_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_morph_dilate_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_morph_dilate_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_morph_dilate_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_morph_dilate_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_morph_dilate_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_morph_dilate_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_morph_dilate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_morph_dilate_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_morph_dilate_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_morph_dilate_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_morph_dilate_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_morph_dilate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagemorphdilateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_frame_make(size : Int) -> ImagemorphdilateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_frame_len(s : ImagemorphdilateFrame) -> Int { s.size }

pub fn image_morph_dilate_frame_get(s : ImagemorphdilateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_frame_set(s : ImagemorphdilateFrame, i : Int, v : Double) -> ImagemorphdilateFrame {
  let result = image_morph_dilate_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_frame_sum(s : ImagemorphdilateFrame) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_frame_mean(s : ImagemorphdilateFrame) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_frame_scale(s : ImagemorphdilateFrame, f : Double) -> ImagemorphdilateFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_frame_add(a : ImagemorphdilateFrame, b : ImagemorphdilateFrame) -> ImagemorphdilateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_frame_copy(s : ImagemorphdilateFrame) -> ImagemorphdilateFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_frame_fill(s : ImagemorphdilateFrame, v : Double) -> ImagemorphdilateFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_frame_min(s : ImagemorphdilateFrame) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_frame_max(s : ImagemorphdilateFrame) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_frame_to_string(s : ImagemorphdilateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_table_make(size : Int) -> ImagemorphdilateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_table_len(s : ImagemorphdilateTable) -> Int { s.size }

pub fn image_morph_dilate_table_get(s : ImagemorphdilateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_table_set(s : ImagemorphdilateTable, i : Int, v : Double) -> ImagemorphdilateTable {
  let result = image_morph_dilate_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_table_sum(s : ImagemorphdilateTable) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_table_mean(s : ImagemorphdilateTable) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_table_scale(s : ImagemorphdilateTable, f : Double) -> ImagemorphdilateTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_table_add(a : ImagemorphdilateTable, b : ImagemorphdilateTable) -> ImagemorphdilateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_table_copy(s : ImagemorphdilateTable) -> ImagemorphdilateTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_table_fill(s : ImagemorphdilateTable, v : Double) -> ImagemorphdilateTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_table_min(s : ImagemorphdilateTable) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_table_max(s : ImagemorphdilateTable) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_table_to_string(s : ImagemorphdilateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_graphn_make(size : Int) -> ImagemorphdilateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_graphn_len(s : ImagemorphdilateGraphN) -> Int { s.size }

pub fn image_morph_dilate_graphn_get(s : ImagemorphdilateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_graphn_set(s : ImagemorphdilateGraphN, i : Int, v : Double) -> ImagemorphdilateGraphN {
  let result = image_morph_dilate_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_graphn_sum(s : ImagemorphdilateGraphN) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_graphn_mean(s : ImagemorphdilateGraphN) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_graphn_scale(s : ImagemorphdilateGraphN, f : Double) -> ImagemorphdilateGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_graphn_add(a : ImagemorphdilateGraphN, b : ImagemorphdilateGraphN) -> ImagemorphdilateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_graphn_copy(s : ImagemorphdilateGraphN) -> ImagemorphdilateGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_graphn_fill(s : ImagemorphdilateGraphN, v : Double) -> ImagemorphdilateGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_graphn_min(s : ImagemorphdilateGraphN) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_graphn_max(s : ImagemorphdilateGraphN) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_graphn_to_string(s : ImagemorphdilateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_node_make(size : Int) -> ImagemorphdilateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_node_len(s : ImagemorphdilateNode) -> Int { s.size }

pub fn image_morph_dilate_node_get(s : ImagemorphdilateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_node_set(s : ImagemorphdilateNode, i : Int, v : Double) -> ImagemorphdilateNode {
  let result = image_morph_dilate_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_node_sum(s : ImagemorphdilateNode) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_node_mean(s : ImagemorphdilateNode) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_node_scale(s : ImagemorphdilateNode, f : Double) -> ImagemorphdilateNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_node_add(a : ImagemorphdilateNode, b : ImagemorphdilateNode) -> ImagemorphdilateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_node_copy(s : ImagemorphdilateNode) -> ImagemorphdilateNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_node_fill(s : ImagemorphdilateNode, v : Double) -> ImagemorphdilateNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_node_min(s : ImagemorphdilateNode) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_node_max(s : ImagemorphdilateNode) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_node_to_string(s : ImagemorphdilateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_edge_make(size : Int) -> ImagemorphdilateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_edge_len(s : ImagemorphdilateEdge) -> Int { s.size }

pub fn image_morph_dilate_edge_get(s : ImagemorphdilateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_edge_set(s : ImagemorphdilateEdge, i : Int, v : Double) -> ImagemorphdilateEdge {
  let result = image_morph_dilate_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_edge_sum(s : ImagemorphdilateEdge) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_edge_mean(s : ImagemorphdilateEdge) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_edge_scale(s : ImagemorphdilateEdge, f : Double) -> ImagemorphdilateEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_edge_add(a : ImagemorphdilateEdge, b : ImagemorphdilateEdge) -> ImagemorphdilateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_edge_copy(s : ImagemorphdilateEdge) -> ImagemorphdilateEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_edge_fill(s : ImagemorphdilateEdge, v : Double) -> ImagemorphdilateEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_edge_min(s : ImagemorphdilateEdge) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_edge_max(s : ImagemorphdilateEdge) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_edge_to_string(s : ImagemorphdilateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_path_make(size : Int) -> ImagemorphdilatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_path_len(s : ImagemorphdilatePath) -> Int { s.size }

pub fn image_morph_dilate_path_get(s : ImagemorphdilatePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_path_set(s : ImagemorphdilatePath, i : Int, v : Double) -> ImagemorphdilatePath {
  let result = image_morph_dilate_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_path_sum(s : ImagemorphdilatePath) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_path_mean(s : ImagemorphdilatePath) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_path_scale(s : ImagemorphdilatePath, f : Double) -> ImagemorphdilatePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_path_add(a : ImagemorphdilatePath, b : ImagemorphdilatePath) -> ImagemorphdilatePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_path_copy(s : ImagemorphdilatePath) -> ImagemorphdilatePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_path_fill(s : ImagemorphdilatePath, v : Double) -> ImagemorphdilatePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_path_min(s : ImagemorphdilatePath) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_path_max(s : ImagemorphdilatePath) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_path_to_string(s : ImagemorphdilatePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_cluster_make(size : Int) -> ImagemorphdilateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_cluster_len(s : ImagemorphdilateCluster) -> Int { s.size }

pub fn image_morph_dilate_cluster_get(s : ImagemorphdilateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_cluster_set(s : ImagemorphdilateCluster, i : Int, v : Double) -> ImagemorphdilateCluster {
  let result = image_morph_dilate_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_cluster_sum(s : ImagemorphdilateCluster) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_cluster_mean(s : ImagemorphdilateCluster) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_cluster_scale(s : ImagemorphdilateCluster, f : Double) -> ImagemorphdilateCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_cluster_add(a : ImagemorphdilateCluster, b : ImagemorphdilateCluster) -> ImagemorphdilateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_cluster_copy(s : ImagemorphdilateCluster) -> ImagemorphdilateCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_cluster_fill(s : ImagemorphdilateCluster, v : Double) -> ImagemorphdilateCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_cluster_min(s : ImagemorphdilateCluster) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_cluster_max(s : ImagemorphdilateCluster) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_cluster_to_string(s : ImagemorphdilateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_model_make(size : Int) -> ImagemorphdilateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_model_len(s : ImagemorphdilateModel) -> Int { s.size }

pub fn image_morph_dilate_model_get(s : ImagemorphdilateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_model_set(s : ImagemorphdilateModel, i : Int, v : Double) -> ImagemorphdilateModel {
  let result = image_morph_dilate_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_model_sum(s : ImagemorphdilateModel) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_model_mean(s : ImagemorphdilateModel) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_model_scale(s : ImagemorphdilateModel, f : Double) -> ImagemorphdilateModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_model_add(a : ImagemorphdilateModel, b : ImagemorphdilateModel) -> ImagemorphdilateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_model_copy(s : ImagemorphdilateModel) -> ImagemorphdilateModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_model_fill(s : ImagemorphdilateModel, v : Double) -> ImagemorphdilateModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_model_min(s : ImagemorphdilateModel) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_model_max(s : ImagemorphdilateModel) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_model_to_string(s : ImagemorphdilateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_layer_make(size : Int) -> ImagemorphdilateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_layer_len(s : ImagemorphdilateLayer) -> Int { s.size }

pub fn image_morph_dilate_layer_get(s : ImagemorphdilateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_layer_set(s : ImagemorphdilateLayer, i : Int, v : Double) -> ImagemorphdilateLayer {
  let result = image_morph_dilate_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_layer_sum(s : ImagemorphdilateLayer) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_layer_mean(s : ImagemorphdilateLayer) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_layer_scale(s : ImagemorphdilateLayer, f : Double) -> ImagemorphdilateLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_layer_add(a : ImagemorphdilateLayer, b : ImagemorphdilateLayer) -> ImagemorphdilateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_layer_copy(s : ImagemorphdilateLayer) -> ImagemorphdilateLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_layer_fill(s : ImagemorphdilateLayer, v : Double) -> ImagemorphdilateLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_layer_min(s : ImagemorphdilateLayer) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_layer_max(s : ImagemorphdilateLayer) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_layer_to_string(s : ImagemorphdilateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_buffer_make(size : Int) -> ImagemorphdilateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_buffer_len(s : ImagemorphdilateBuffer) -> Int { s.size }

pub fn image_morph_dilate_buffer_get(s : ImagemorphdilateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_buffer_set(s : ImagemorphdilateBuffer, i : Int, v : Double) -> ImagemorphdilateBuffer {
  let result = image_morph_dilate_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_buffer_sum(s : ImagemorphdilateBuffer) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_buffer_mean(s : ImagemorphdilateBuffer) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_buffer_scale(s : ImagemorphdilateBuffer, f : Double) -> ImagemorphdilateBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_buffer_add(a : ImagemorphdilateBuffer, b : ImagemorphdilateBuffer) -> ImagemorphdilateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_buffer_copy(s : ImagemorphdilateBuffer) -> ImagemorphdilateBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_buffer_fill(s : ImagemorphdilateBuffer, v : Double) -> ImagemorphdilateBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_buffer_min(s : ImagemorphdilateBuffer) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_buffer_max(s : ImagemorphdilateBuffer) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_buffer_to_string(s : ImagemorphdilateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_cursor_make(size : Int) -> ImagemorphdilateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_cursor_len(s : ImagemorphdilateCursor) -> Int { s.size }

pub fn image_morph_dilate_cursor_get(s : ImagemorphdilateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_cursor_set(s : ImagemorphdilateCursor, i : Int, v : Double) -> ImagemorphdilateCursor {
  let result = image_morph_dilate_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_cursor_sum(s : ImagemorphdilateCursor) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_cursor_mean(s : ImagemorphdilateCursor) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_cursor_scale(s : ImagemorphdilateCursor, f : Double) -> ImagemorphdilateCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_cursor_add(a : ImagemorphdilateCursor, b : ImagemorphdilateCursor) -> ImagemorphdilateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_cursor_copy(s : ImagemorphdilateCursor) -> ImagemorphdilateCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_cursor_fill(s : ImagemorphdilateCursor, v : Double) -> ImagemorphdilateCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_cursor_min(s : ImagemorphdilateCursor) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_cursor_max(s : ImagemorphdilateCursor) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_cursor_to_string(s : ImagemorphdilateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_view_make(size : Int) -> ImagemorphdilateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_view_len(s : ImagemorphdilateView) -> Int { s.size }

pub fn image_morph_dilate_view_get(s : ImagemorphdilateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_view_set(s : ImagemorphdilateView, i : Int, v : Double) -> ImagemorphdilateView {
  let result = image_morph_dilate_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_view_sum(s : ImagemorphdilateView) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_view_mean(s : ImagemorphdilateView) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_view_scale(s : ImagemorphdilateView, f : Double) -> ImagemorphdilateView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_view_add(a : ImagemorphdilateView, b : ImagemorphdilateView) -> ImagemorphdilateView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_view_copy(s : ImagemorphdilateView) -> ImagemorphdilateView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_view_fill(s : ImagemorphdilateView, v : Double) -> ImagemorphdilateView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_view_min(s : ImagemorphdilateView) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_view_max(s : ImagemorphdilateView) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_view_to_string(s : ImagemorphdilateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_range_make(size : Int) -> ImagemorphdilateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_range_len(s : ImagemorphdilateRange) -> Int { s.size }

pub fn image_morph_dilate_range_get(s : ImagemorphdilateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_range_set(s : ImagemorphdilateRange, i : Int, v : Double) -> ImagemorphdilateRange {
  let result = image_morph_dilate_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_range_sum(s : ImagemorphdilateRange) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_range_mean(s : ImagemorphdilateRange) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_range_scale(s : ImagemorphdilateRange, f : Double) -> ImagemorphdilateRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_range_add(a : ImagemorphdilateRange, b : ImagemorphdilateRange) -> ImagemorphdilateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_range_copy(s : ImagemorphdilateRange) -> ImagemorphdilateRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_range_fill(s : ImagemorphdilateRange, v : Double) -> ImagemorphdilateRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_range_min(s : ImagemorphdilateRange) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_range_max(s : ImagemorphdilateRange) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_range_to_string(s : ImagemorphdilateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphdilateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_dilate_slice_make(size : Int) -> ImagemorphdilateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_dilate_slice_len(s : ImagemorphdilateSlice) -> Int { s.size }

pub fn image_morph_dilate_slice_get(s : ImagemorphdilateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_dilate_slice_set(s : ImagemorphdilateSlice, i : Int, v : Double) -> ImagemorphdilateSlice {
  let result = image_morph_dilate_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn image_morph_dilate_slice_sum(s : ImagemorphdilateSlice) -> Double { @_common.sum(s.data) }

pub fn image_morph_dilate_slice_mean(s : ImagemorphdilateSlice) -> Double { @_common.mean(s.data) }

pub fn image_morph_dilate_slice_scale(s : ImagemorphdilateSlice, f : Double) -> ImagemorphdilateSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_slice_add(a : ImagemorphdilateSlice, b : ImagemorphdilateSlice) -> ImagemorphdilateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_dilate_slice_copy(s : ImagemorphdilateSlice) -> ImagemorphdilateSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_slice_fill(s : ImagemorphdilateSlice, v : Double) -> ImagemorphdilateSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_dilate_slice_min(s : ImagemorphdilateSlice) -> Double { @_common.min(s.data) }

pub fn image_morph_dilate_slice_max(s : ImagemorphdilateSlice) -> Double { @_common.max(s.data) }

pub fn image_morph_dilate_slice_to_string(s : ImagemorphdilateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

