///===
/// extcore/image_morph_open

pub(all) struct ImagemorphopenPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_morph_open_make_point(x : Double, y : Double) -> ImagemorphopenPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_morph_open_make_point3(x : Double, y : Double, z : Double) -> ImagemorphopenPoint {
  { x, y, z, label: 0 }
}

pub fn image_morph_open_point_x(pt : ImagemorphopenPoint) -> Double { pt.x }

pub fn image_morph_open_point_y(pt : ImagemorphopenPoint) -> Double { pt.y }

pub fn image_morph_open_point_z(pt : ImagemorphopenPoint) -> Double { pt.z }

pub fn image_morph_open_point_label(pt : ImagemorphopenPoint) -> Int { pt.label }

pub fn image_morph_open_point_dist(a : ImagemorphopenPoint, b : ImagemorphopenPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_morph_open_point_add(a : ImagemorphopenPoint, b : ImagemorphopenPoint) -> ImagemorphopenPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_morph_open_point_sub(a : ImagemorphopenPoint, b : ImagemorphopenPoint) -> ImagemorphopenPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_morph_open_point_scale(pt : ImagemorphopenPoint, s : Double) -> ImagemorphopenPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_morph_open_point_dot(a : ImagemorphopenPoint, b : ImagemorphopenPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_morph_open_point_cross(a : ImagemorphopenPoint, b : ImagemorphopenPoint) -> ImagemorphopenPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_morph_open_point_norm(pt : ImagemorphopenPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_morph_open_point_normalize(pt : ImagemorphopenPoint) -> ImagemorphopenPoint {
  let n = image_morph_open_point_norm(pt)
  if n < 0.0000001 { pt } else { image_morph_open_point_scale(pt, 1.0 / n) }
}

pub fn image_morph_open_point_negate(pt : ImagemorphopenPoint) -> ImagemorphopenPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_morph_open_point_mid(a : ImagemorphopenPoint, b : ImagemorphopenPoint) -> ImagemorphopenPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_morph_open_point_lerp(a : ImagemorphopenPoint, b : ImagemorphopenPoint, t : Double) -> ImagemorphopenPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_morph_open_point_to_string(pt : ImagemorphopenPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagemorphopenSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_morph_open_make_series(vals : Array[Double], name : String) -> ImagemorphopenSeries {
  { vals, name, meta: 0 }
}

pub fn image_morph_open_series_len(s : ImagemorphopenSeries) -> Int { s.vals.length() }

pub fn image_morph_open_series_sum(s : ImagemorphopenSeries) -> Double { @_common.sum(s.vals) }

pub fn image_morph_open_series_mean(s : ImagemorphopenSeries) -> Double { @_common.mean(s.vals) }

pub fn image_morph_open_series_min(s : ImagemorphopenSeries) -> Double { @_common.min(s.vals) }

pub fn image_morph_open_series_max(s : ImagemorphopenSeries) -> Double { @_common.max(s.vals) }

pub fn image_morph_open_series_range(s : ImagemorphopenSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_morph_open_series_var(s : ImagemorphopenSeries) -> Double { @_common.variance(s.vals) }

pub fn image_morph_open_series_std(s : ImagemorphopenSeries) -> Double { @_common.std(s.vals) }

pub fn image_morph_open_series_median(s : ImagemorphopenSeries) -> Double { @_common.median(s.vals) }

pub fn image_morph_open_series_scale(s : ImagemorphopenSeries, f : Double) -> ImagemorphopenSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn image_morph_open_series_add(a : ImagemorphopenSeries, b : ImagemorphopenSeries) -> ImagemorphopenSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_morph_open_series_sub(a : ImagemorphopenSeries, b : ImagemorphopenSeries) -> ImagemorphopenSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_morph_open_series_normalize(s : ImagemorphopenSeries) -> ImagemorphopenSeries {
  let mn = image_morph_open_series_min(s)
  let mx = image_morph_open_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_morph_open_series_cumsum(s : ImagemorphopenSeries) -> ImagemorphopenSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_morph_open_series_to_string(s : ImagemorphopenSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagemorphopenMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_morph_open_make_matrix(rows : Int, cols : Int, val : Double) -> ImagemorphopenMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_morph_open_matrix_identity(n : Int) -> ImagemorphopenMatrix {
  let m = image_morph_open_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_morph_open_matrix_get(m : ImagemorphopenMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_morph_open_matrix_transpose(m : ImagemorphopenMatrix) -> ImagemorphopenMatrix {
  let result = image_morph_open_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_morph_open_matrix_add(a : ImagemorphopenMatrix, b : ImagemorphopenMatrix) -> ImagemorphopenMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_morph_open_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_morph_open_matrix_scale(m : ImagemorphopenMatrix, s : Double) -> ImagemorphopenMatrix {
  let result = image_morph_open_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_morph_open_matrix_multiply(a : ImagemorphopenMatrix, b : ImagemorphopenMatrix) -> ImagemorphopenMatrix {
  if a.cols != b.rows { return image_morph_open_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_morph_open_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_morph_open_matrix_trace(m : ImagemorphopenMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_morph_open_matrix_det(m : ImagemorphopenMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_morph_open_matrix_norm(m : ImagemorphopenMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_morph_open_matrix_to_string(m : ImagemorphopenMatrix) -> String {
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

pub(all) struct ImagemorphopenVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_morph_open_make_vector(comps : Array[Double]) -> ImagemorphopenVector {
  { comps, dim: comps.length() }
}

pub fn image_morph_open_vector_zero(dim : Int) -> ImagemorphopenVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_morph_open_vector_add(a : ImagemorphopenVector, b : ImagemorphopenVector) -> ImagemorphopenVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn image_morph_open_vector_sub(a : ImagemorphopenVector, b : ImagemorphopenVector) -> ImagemorphopenVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn image_morph_open_vector_scale(v : ImagemorphopenVector, s : Double) -> ImagemorphopenVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn image_morph_open_vector_dot(a : ImagemorphopenVector, b : ImagemorphopenVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_morph_open_vector_norm(v : ImagemorphopenVector) -> Double { @_common.sqrt(image_morph_open_vector_dot(v, v)) }

pub fn image_morph_open_vector_normalize(v : ImagemorphopenVector) -> ImagemorphopenVector {
  let n = image_morph_open_vector_norm(v)
  if n < 0.0000001 { v } else { image_morph_open_vector_scale(v, 1.0 / n) }
}

pub fn image_morph_open_vector_dist(a : ImagemorphopenVector, b : ImagemorphopenVector) -> Double {
  image_morph_open_vector_norm(image_morph_open_vector_sub(a, b))
}

pub fn image_morph_open_vector_to_string(v : ImagemorphopenVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_morph_open_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_morph_open_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_morph_open_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_morph_open_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_morph_open_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_morph_open_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_morph_open_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_morph_open_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_morph_open_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_morph_open_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_morph_open_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_morph_open_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_morph_open_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_morph_open_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_morph_open_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_morph_open_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_morph_open_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_morph_open_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_morph_open_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_morph_open_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_morph_open_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_morph_open_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_morph_open_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_morph_open_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_morph_open_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_morph_open_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_morph_open_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_morph_open_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_morph_open_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagemorphopenFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_frame_make(size : Int) -> ImagemorphopenFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_frame_len(s : ImagemorphopenFrame) -> Int { s.size }

pub fn image_morph_open_frame_get(s : ImagemorphopenFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_frame_set(s : ImagemorphopenFrame, i : Int, v : Double) -> ImagemorphopenFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_frame_sum(s : ImagemorphopenFrame) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_frame_mean(s : ImagemorphopenFrame) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_frame_scale(s : ImagemorphopenFrame, f : Double) -> ImagemorphopenFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_frame_add(a : ImagemorphopenFrame, b : ImagemorphopenFrame) -> ImagemorphopenFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_frame_copy(s : ImagemorphopenFrame) -> ImagemorphopenFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_frame_fill(s : ImagemorphopenFrame, v : Double) -> ImagemorphopenFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_frame_min(s : ImagemorphopenFrame) -> Double { @_common.min(s.data) }

pub fn image_morph_open_frame_max(s : ImagemorphopenFrame) -> Double { @_common.max(s.data) }

pub fn image_morph_open_frame_to_string(s : ImagemorphopenFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_table_make(size : Int) -> ImagemorphopenTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_table_len(s : ImagemorphopenTable) -> Int { s.size }

pub fn image_morph_open_table_get(s : ImagemorphopenTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_table_set(s : ImagemorphopenTable, i : Int, v : Double) -> ImagemorphopenTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_table_sum(s : ImagemorphopenTable) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_table_mean(s : ImagemorphopenTable) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_table_scale(s : ImagemorphopenTable, f : Double) -> ImagemorphopenTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_table_add(a : ImagemorphopenTable, b : ImagemorphopenTable) -> ImagemorphopenTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_table_copy(s : ImagemorphopenTable) -> ImagemorphopenTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_table_fill(s : ImagemorphopenTable, v : Double) -> ImagemorphopenTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_table_min(s : ImagemorphopenTable) -> Double { @_common.min(s.data) }

pub fn image_morph_open_table_max(s : ImagemorphopenTable) -> Double { @_common.max(s.data) }

pub fn image_morph_open_table_to_string(s : ImagemorphopenTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_graphn_make(size : Int) -> ImagemorphopenGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_graphn_len(s : ImagemorphopenGraphN) -> Int { s.size }

pub fn image_morph_open_graphn_get(s : ImagemorphopenGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_graphn_set(s : ImagemorphopenGraphN, i : Int, v : Double) -> ImagemorphopenGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_graphn_sum(s : ImagemorphopenGraphN) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_graphn_mean(s : ImagemorphopenGraphN) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_graphn_scale(s : ImagemorphopenGraphN, f : Double) -> ImagemorphopenGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_graphn_add(a : ImagemorphopenGraphN, b : ImagemorphopenGraphN) -> ImagemorphopenGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_graphn_copy(s : ImagemorphopenGraphN) -> ImagemorphopenGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_graphn_fill(s : ImagemorphopenGraphN, v : Double) -> ImagemorphopenGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_graphn_min(s : ImagemorphopenGraphN) -> Double { @_common.min(s.data) }

pub fn image_morph_open_graphn_max(s : ImagemorphopenGraphN) -> Double { @_common.max(s.data) }

pub fn image_morph_open_graphn_to_string(s : ImagemorphopenGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_node_make(size : Int) -> ImagemorphopenNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_node_len(s : ImagemorphopenNode) -> Int { s.size }

pub fn image_morph_open_node_get(s : ImagemorphopenNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_node_set(s : ImagemorphopenNode, i : Int, v : Double) -> ImagemorphopenNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_node_sum(s : ImagemorphopenNode) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_node_mean(s : ImagemorphopenNode) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_node_scale(s : ImagemorphopenNode, f : Double) -> ImagemorphopenNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_node_add(a : ImagemorphopenNode, b : ImagemorphopenNode) -> ImagemorphopenNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_node_copy(s : ImagemorphopenNode) -> ImagemorphopenNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_node_fill(s : ImagemorphopenNode, v : Double) -> ImagemorphopenNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_node_min(s : ImagemorphopenNode) -> Double { @_common.min(s.data) }

pub fn image_morph_open_node_max(s : ImagemorphopenNode) -> Double { @_common.max(s.data) }

pub fn image_morph_open_node_to_string(s : ImagemorphopenNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_edge_make(size : Int) -> ImagemorphopenEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_edge_len(s : ImagemorphopenEdge) -> Int { s.size }

pub fn image_morph_open_edge_get(s : ImagemorphopenEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_edge_set(s : ImagemorphopenEdge, i : Int, v : Double) -> ImagemorphopenEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_edge_sum(s : ImagemorphopenEdge) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_edge_mean(s : ImagemorphopenEdge) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_edge_scale(s : ImagemorphopenEdge, f : Double) -> ImagemorphopenEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_edge_add(a : ImagemorphopenEdge, b : ImagemorphopenEdge) -> ImagemorphopenEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_edge_copy(s : ImagemorphopenEdge) -> ImagemorphopenEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_edge_fill(s : ImagemorphopenEdge, v : Double) -> ImagemorphopenEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_edge_min(s : ImagemorphopenEdge) -> Double { @_common.min(s.data) }

pub fn image_morph_open_edge_max(s : ImagemorphopenEdge) -> Double { @_common.max(s.data) }

pub fn image_morph_open_edge_to_string(s : ImagemorphopenEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_path_make(size : Int) -> ImagemorphopenPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_path_len(s : ImagemorphopenPath) -> Int { s.size }

pub fn image_morph_open_path_get(s : ImagemorphopenPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_path_set(s : ImagemorphopenPath, i : Int, v : Double) -> ImagemorphopenPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_path_sum(s : ImagemorphopenPath) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_path_mean(s : ImagemorphopenPath) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_path_scale(s : ImagemorphopenPath, f : Double) -> ImagemorphopenPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_path_add(a : ImagemorphopenPath, b : ImagemorphopenPath) -> ImagemorphopenPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_path_copy(s : ImagemorphopenPath) -> ImagemorphopenPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_path_fill(s : ImagemorphopenPath, v : Double) -> ImagemorphopenPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_path_min(s : ImagemorphopenPath) -> Double { @_common.min(s.data) }

pub fn image_morph_open_path_max(s : ImagemorphopenPath) -> Double { @_common.max(s.data) }

pub fn image_morph_open_path_to_string(s : ImagemorphopenPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_cluster_make(size : Int) -> ImagemorphopenCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_cluster_len(s : ImagemorphopenCluster) -> Int { s.size }

pub fn image_morph_open_cluster_get(s : ImagemorphopenCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_cluster_set(s : ImagemorphopenCluster, i : Int, v : Double) -> ImagemorphopenCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_cluster_sum(s : ImagemorphopenCluster) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_cluster_mean(s : ImagemorphopenCluster) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_cluster_scale(s : ImagemorphopenCluster, f : Double) -> ImagemorphopenCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_cluster_add(a : ImagemorphopenCluster, b : ImagemorphopenCluster) -> ImagemorphopenCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_cluster_copy(s : ImagemorphopenCluster) -> ImagemorphopenCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_cluster_fill(s : ImagemorphopenCluster, v : Double) -> ImagemorphopenCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_cluster_min(s : ImagemorphopenCluster) -> Double { @_common.min(s.data) }

pub fn image_morph_open_cluster_max(s : ImagemorphopenCluster) -> Double { @_common.max(s.data) }

pub fn image_morph_open_cluster_to_string(s : ImagemorphopenCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_model_make(size : Int) -> ImagemorphopenModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_model_len(s : ImagemorphopenModel) -> Int { s.size }

pub fn image_morph_open_model_get(s : ImagemorphopenModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_model_set(s : ImagemorphopenModel, i : Int, v : Double) -> ImagemorphopenModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_model_sum(s : ImagemorphopenModel) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_model_mean(s : ImagemorphopenModel) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_model_scale(s : ImagemorphopenModel, f : Double) -> ImagemorphopenModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_model_add(a : ImagemorphopenModel, b : ImagemorphopenModel) -> ImagemorphopenModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_model_copy(s : ImagemorphopenModel) -> ImagemorphopenModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_model_fill(s : ImagemorphopenModel, v : Double) -> ImagemorphopenModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_model_min(s : ImagemorphopenModel) -> Double { @_common.min(s.data) }

pub fn image_morph_open_model_max(s : ImagemorphopenModel) -> Double { @_common.max(s.data) }

pub fn image_morph_open_model_to_string(s : ImagemorphopenModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_layer_make(size : Int) -> ImagemorphopenLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_layer_len(s : ImagemorphopenLayer) -> Int { s.size }

pub fn image_morph_open_layer_get(s : ImagemorphopenLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_layer_set(s : ImagemorphopenLayer, i : Int, v : Double) -> ImagemorphopenLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_layer_sum(s : ImagemorphopenLayer) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_layer_mean(s : ImagemorphopenLayer) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_layer_scale(s : ImagemorphopenLayer, f : Double) -> ImagemorphopenLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_layer_add(a : ImagemorphopenLayer, b : ImagemorphopenLayer) -> ImagemorphopenLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_layer_copy(s : ImagemorphopenLayer) -> ImagemorphopenLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_layer_fill(s : ImagemorphopenLayer, v : Double) -> ImagemorphopenLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_layer_min(s : ImagemorphopenLayer) -> Double { @_common.min(s.data) }

pub fn image_morph_open_layer_max(s : ImagemorphopenLayer) -> Double { @_common.max(s.data) }

pub fn image_morph_open_layer_to_string(s : ImagemorphopenLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_buffer_make(size : Int) -> ImagemorphopenBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_buffer_len(s : ImagemorphopenBuffer) -> Int { s.size }

pub fn image_morph_open_buffer_get(s : ImagemorphopenBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_buffer_set(s : ImagemorphopenBuffer, i : Int, v : Double) -> ImagemorphopenBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_buffer_sum(s : ImagemorphopenBuffer) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_buffer_mean(s : ImagemorphopenBuffer) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_buffer_scale(s : ImagemorphopenBuffer, f : Double) -> ImagemorphopenBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_buffer_add(a : ImagemorphopenBuffer, b : ImagemorphopenBuffer) -> ImagemorphopenBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_buffer_copy(s : ImagemorphopenBuffer) -> ImagemorphopenBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_buffer_fill(s : ImagemorphopenBuffer, v : Double) -> ImagemorphopenBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_buffer_min(s : ImagemorphopenBuffer) -> Double { @_common.min(s.data) }

pub fn image_morph_open_buffer_max(s : ImagemorphopenBuffer) -> Double { @_common.max(s.data) }

pub fn image_morph_open_buffer_to_string(s : ImagemorphopenBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_cursor_make(size : Int) -> ImagemorphopenCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_cursor_len(s : ImagemorphopenCursor) -> Int { s.size }

pub fn image_morph_open_cursor_get(s : ImagemorphopenCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_cursor_set(s : ImagemorphopenCursor, i : Int, v : Double) -> ImagemorphopenCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_cursor_sum(s : ImagemorphopenCursor) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_cursor_mean(s : ImagemorphopenCursor) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_cursor_scale(s : ImagemorphopenCursor, f : Double) -> ImagemorphopenCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_cursor_add(a : ImagemorphopenCursor, b : ImagemorphopenCursor) -> ImagemorphopenCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_cursor_copy(s : ImagemorphopenCursor) -> ImagemorphopenCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_cursor_fill(s : ImagemorphopenCursor, v : Double) -> ImagemorphopenCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_cursor_min(s : ImagemorphopenCursor) -> Double { @_common.min(s.data) }

pub fn image_morph_open_cursor_max(s : ImagemorphopenCursor) -> Double { @_common.max(s.data) }

pub fn image_morph_open_cursor_to_string(s : ImagemorphopenCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_view_make(size : Int) -> ImagemorphopenView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_view_len(s : ImagemorphopenView) -> Int { s.size }

pub fn image_morph_open_view_get(s : ImagemorphopenView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_view_set(s : ImagemorphopenView, i : Int, v : Double) -> ImagemorphopenView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_view_sum(s : ImagemorphopenView) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_view_mean(s : ImagemorphopenView) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_view_scale(s : ImagemorphopenView, f : Double) -> ImagemorphopenView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_view_add(a : ImagemorphopenView, b : ImagemorphopenView) -> ImagemorphopenView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_view_copy(s : ImagemorphopenView) -> ImagemorphopenView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_view_fill(s : ImagemorphopenView, v : Double) -> ImagemorphopenView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_view_min(s : ImagemorphopenView) -> Double { @_common.min(s.data) }

pub fn image_morph_open_view_max(s : ImagemorphopenView) -> Double { @_common.max(s.data) }

pub fn image_morph_open_view_to_string(s : ImagemorphopenView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_range_make(size : Int) -> ImagemorphopenRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_range_len(s : ImagemorphopenRange) -> Int { s.size }

pub fn image_morph_open_range_get(s : ImagemorphopenRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_range_set(s : ImagemorphopenRange, i : Int, v : Double) -> ImagemorphopenRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_range_sum(s : ImagemorphopenRange) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_range_mean(s : ImagemorphopenRange) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_range_scale(s : ImagemorphopenRange, f : Double) -> ImagemorphopenRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_range_add(a : ImagemorphopenRange, b : ImagemorphopenRange) -> ImagemorphopenRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_range_copy(s : ImagemorphopenRange) -> ImagemorphopenRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_range_fill(s : ImagemorphopenRange, v : Double) -> ImagemorphopenRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_range_min(s : ImagemorphopenRange) -> Double { @_common.min(s.data) }

pub fn image_morph_open_range_max(s : ImagemorphopenRange) -> Double { @_common.max(s.data) }

pub fn image_morph_open_range_to_string(s : ImagemorphopenRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagemorphopenSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_morph_open_slice_make(size : Int) -> ImagemorphopenSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_morph_open_slice_len(s : ImagemorphopenSlice) -> Int { s.size }

pub fn image_morph_open_slice_get(s : ImagemorphopenSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_morph_open_slice_set(s : ImagemorphopenSlice, i : Int, v : Double) -> ImagemorphopenSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_morph_open_slice_sum(s : ImagemorphopenSlice) -> Double { @_common.sum(s.data) }

pub fn image_morph_open_slice_mean(s : ImagemorphopenSlice) -> Double { @_common.mean(s.data) }

pub fn image_morph_open_slice_scale(s : ImagemorphopenSlice, f : Double) -> ImagemorphopenSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_morph_open_slice_add(a : ImagemorphopenSlice, b : ImagemorphopenSlice) -> ImagemorphopenSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_morph_open_slice_copy(s : ImagemorphopenSlice) -> ImagemorphopenSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_morph_open_slice_fill(s : ImagemorphopenSlice, v : Double) -> ImagemorphopenSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_morph_open_slice_min(s : ImagemorphopenSlice) -> Double { @_common.min(s.data) }

pub fn image_morph_open_slice_max(s : ImagemorphopenSlice) -> Double { @_common.max(s.data) }

pub fn image_morph_open_slice_to_string(s : ImagemorphopenSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

