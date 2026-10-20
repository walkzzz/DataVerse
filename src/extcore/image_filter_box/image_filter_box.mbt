///===
/// extcore/image_filter_box

pub(all) struct ImagefilterboxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_filter_box_make_point(x : Double, y : Double) -> ImagefilterboxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_filter_box_make_point3(x : Double, y : Double, z : Double) -> ImagefilterboxPoint {
  { x, y, z, label: 0 }
}

pub fn image_filter_box_point_x(pt : ImagefilterboxPoint) -> Double { pt.x }

pub fn image_filter_box_point_y(pt : ImagefilterboxPoint) -> Double { pt.y }

pub fn image_filter_box_point_z(pt : ImagefilterboxPoint) -> Double { pt.z }

pub fn image_filter_box_point_label(pt : ImagefilterboxPoint) -> Int { pt.label }

pub fn image_filter_box_point_dist(a : ImagefilterboxPoint, b : ImagefilterboxPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_filter_box_point_add(a : ImagefilterboxPoint, b : ImagefilterboxPoint) -> ImagefilterboxPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_filter_box_point_sub(a : ImagefilterboxPoint, b : ImagefilterboxPoint) -> ImagefilterboxPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_filter_box_point_scale(pt : ImagefilterboxPoint, s : Double) -> ImagefilterboxPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_filter_box_point_dot(a : ImagefilterboxPoint, b : ImagefilterboxPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_filter_box_point_cross(a : ImagefilterboxPoint, b : ImagefilterboxPoint) -> ImagefilterboxPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_filter_box_point_norm(pt : ImagefilterboxPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_filter_box_point_normalize(pt : ImagefilterboxPoint) -> ImagefilterboxPoint {
  let n = image_filter_box_point_norm(pt)
  if n < 0.0000001 { pt } else { image_filter_box_point_scale(pt, 1.0 / n) }
}

pub fn image_filter_box_point_negate(pt : ImagefilterboxPoint) -> ImagefilterboxPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_filter_box_point_mid(a : ImagefilterboxPoint, b : ImagefilterboxPoint) -> ImagefilterboxPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_filter_box_point_lerp(a : ImagefilterboxPoint, b : ImagefilterboxPoint, t : Double) -> ImagefilterboxPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_filter_box_point_to_string(pt : ImagefilterboxPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefilterboxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_filter_box_make_series(vals : Array[Double], name : String) -> ImagefilterboxSeries {
  { vals, name, meta: 0 }
}

pub fn image_filter_box_series_len(s : ImagefilterboxSeries) -> Int { s.vals.length() }

pub fn image_filter_box_series_sum(s : ImagefilterboxSeries) -> Double { @_common.sum(s.vals) }

pub fn image_filter_box_series_mean(s : ImagefilterboxSeries) -> Double { @_common.mean(s.vals) }

pub fn image_filter_box_series_min(s : ImagefilterboxSeries) -> Double { @_common.min(s.vals) }

pub fn image_filter_box_series_max(s : ImagefilterboxSeries) -> Double { @_common.max(s.vals) }

pub fn image_filter_box_series_range(s : ImagefilterboxSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_filter_box_series_var(s : ImagefilterboxSeries) -> Double { @_common.variance(s.vals) }

pub fn image_filter_box_series_std(s : ImagefilterboxSeries) -> Double { @_common.std(s.vals) }

pub fn image_filter_box_series_median(s : ImagefilterboxSeries) -> Double { @_common.median(s.vals) }

pub fn image_filter_box_series_scale(s : ImagefilterboxSeries, f : Double) -> ImagefilterboxSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn image_filter_box_series_add(a : ImagefilterboxSeries, b : ImagefilterboxSeries) -> ImagefilterboxSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_filter_box_series_sub(a : ImagefilterboxSeries, b : ImagefilterboxSeries) -> ImagefilterboxSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_filter_box_series_normalize(s : ImagefilterboxSeries) -> ImagefilterboxSeries {
  let mn = image_filter_box_series_min(s)
  let mx = image_filter_box_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_filter_box_series_cumsum(s : ImagefilterboxSeries) -> ImagefilterboxSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_filter_box_series_to_string(s : ImagefilterboxSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefilterboxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_filter_box_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefilterboxMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_filter_box_matrix_identity(n : Int) -> ImagefilterboxMatrix {
  let m = image_filter_box_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_filter_box_matrix_get(m : ImagefilterboxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_filter_box_matrix_transpose(m : ImagefilterboxMatrix) -> ImagefilterboxMatrix {
  let result = image_filter_box_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_filter_box_matrix_add(a : ImagefilterboxMatrix, b : ImagefilterboxMatrix) -> ImagefilterboxMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_filter_box_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_filter_box_matrix_scale(m : ImagefilterboxMatrix, s : Double) -> ImagefilterboxMatrix {
  let result = image_filter_box_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_filter_box_matrix_multiply(a : ImagefilterboxMatrix, b : ImagefilterboxMatrix) -> ImagefilterboxMatrix {
  if a.cols != b.rows { return image_filter_box_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_filter_box_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_filter_box_matrix_trace(m : ImagefilterboxMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_filter_box_matrix_det(m : ImagefilterboxMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_filter_box_matrix_norm(m : ImagefilterboxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_filter_box_matrix_to_string(m : ImagefilterboxMatrix) -> String {
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

pub(all) struct ImagefilterboxVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_filter_box_make_vector(comps : Array[Double]) -> ImagefilterboxVector {
  { comps, dim: comps.length() }
}

pub fn image_filter_box_vector_zero(dim : Int) -> ImagefilterboxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_filter_box_vector_add(a : ImagefilterboxVector, b : ImagefilterboxVector) -> ImagefilterboxVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn image_filter_box_vector_sub(a : ImagefilterboxVector, b : ImagefilterboxVector) -> ImagefilterboxVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn image_filter_box_vector_scale(v : ImagefilterboxVector, s : Double) -> ImagefilterboxVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn image_filter_box_vector_dot(a : ImagefilterboxVector, b : ImagefilterboxVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_filter_box_vector_norm(v : ImagefilterboxVector) -> Double { @_common.sqrt(image_filter_box_vector_dot(v, v)) }

pub fn image_filter_box_vector_normalize(v : ImagefilterboxVector) -> ImagefilterboxVector {
  let n = image_filter_box_vector_norm(v)
  if n < 0.0000001 { v } else { image_filter_box_vector_scale(v, 1.0 / n) }
}

pub fn image_filter_box_vector_dist(a : ImagefilterboxVector, b : ImagefilterboxVector) -> Double {
  image_filter_box_vector_norm(image_filter_box_vector_sub(a, b))
}

pub fn image_filter_box_vector_to_string(v : ImagefilterboxVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_filter_box_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_filter_box_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_filter_box_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_filter_box_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_filter_box_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_filter_box_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_filter_box_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_filter_box_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_filter_box_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_filter_box_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_filter_box_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_filter_box_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_filter_box_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_filter_box_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_filter_box_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_filter_box_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_filter_box_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_filter_box_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_filter_box_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_filter_box_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_filter_box_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_filter_box_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_filter_box_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_filter_box_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_filter_box_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_filter_box_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_filter_box_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_filter_box_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_filter_box_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefilterboxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_frame_make(size : Int) -> ImagefilterboxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_frame_len(s : ImagefilterboxFrame) -> Int { s.size }

pub fn image_filter_box_frame_get(s : ImagefilterboxFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_frame_set(s : ImagefilterboxFrame, i : Int, v : Double) -> ImagefilterboxFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_box_frame_sum(s : ImagefilterboxFrame) -> Double { @_common.sum(s.data) }

pub fn image_filter_box_frame_mean(s : ImagefilterboxFrame) -> Double { @_common.mean(s.data) }

pub fn image_filter_box_frame_scale(s : ImagefilterboxFrame, f : Double) -> ImagefilterboxFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_box_frame_add(a : ImagefilterboxFrame, b : ImagefilterboxFrame) -> ImagefilterboxFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_box_frame_copy(s : ImagefilterboxFrame) -> ImagefilterboxFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_box_frame_fill(s : ImagefilterboxFrame, v : Double) -> ImagefilterboxFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_box_frame_min(s : ImagefilterboxFrame) -> Double { @_common.min(s.data) }

pub fn image_filter_box_frame_max(s : ImagefilterboxFrame) -> Double { @_common.max(s.data) }

pub fn image_filter_box_frame_to_string(s : ImagefilterboxFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_table_make(size : Int) -> ImagefilterboxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_table_len(s : ImagefilterboxTable) -> Int { s.size }

pub fn image_filter_box_table_get(s : ImagefilterboxTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_table_set(s : ImagefilterboxTable, i : Int, v : Double) -> ImagefilterboxTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_box_table_sum(s : ImagefilterboxTable) -> Double { @_common.sum(s.data) }

pub fn image_filter_box_table_mean(s : ImagefilterboxTable) -> Double { @_common.mean(s.data) }

pub fn image_filter_box_table_scale(s : ImagefilterboxTable, f : Double) -> ImagefilterboxTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_box_table_add(a : ImagefilterboxTable, b : ImagefilterboxTable) -> ImagefilterboxTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_box_table_copy(s : ImagefilterboxTable) -> ImagefilterboxTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_box_table_fill(s : ImagefilterboxTable, v : Double) -> ImagefilterboxTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_box_table_min(s : ImagefilterboxTable) -> Double { @_common.min(s.data) }

pub fn image_filter_box_table_max(s : ImagefilterboxTable) -> Double { @_common.max(s.data) }

pub fn image_filter_box_table_to_string(s : ImagefilterboxTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_graphn_make(size : Int) -> ImagefilterboxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_graphn_len(s : ImagefilterboxGraphN) -> Int { s.size }

pub fn image_filter_box_graphn_get(s : ImagefilterboxGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_graphn_set(s : ImagefilterboxGraphN, i : Int, v : Double) -> ImagefilterboxGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_box_graphn_sum(s : ImagefilterboxGraphN) -> Double { @_common.sum(s.data) }

pub fn image_filter_box_graphn_mean(s : ImagefilterboxGraphN) -> Double { @_common.mean(s.data) }

pub fn image_filter_box_graphn_scale(s : ImagefilterboxGraphN, f : Double) -> ImagefilterboxGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_box_graphn_add(a : ImagefilterboxGraphN, b : ImagefilterboxGraphN) -> ImagefilterboxGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_box_graphn_copy(s : ImagefilterboxGraphN) -> ImagefilterboxGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_box_graphn_fill(s : ImagefilterboxGraphN, v : Double) -> ImagefilterboxGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_box_graphn_min(s : ImagefilterboxGraphN) -> Double { @_common.min(s.data) }

pub fn image_filter_box_graphn_max(s : ImagefilterboxGraphN) -> Double { @_common.max(s.data) }

pub fn image_filter_box_graphn_to_string(s : ImagefilterboxGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_node_make(size : Int) -> ImagefilterboxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_node_len(s : ImagefilterboxNode) -> Int { s.size }

pub fn image_filter_box_node_get(s : ImagefilterboxNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_node_set(s : ImagefilterboxNode, i : Int, v : Double) -> ImagefilterboxNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_box_node_sum(s : ImagefilterboxNode) -> Double { @_common.sum(s.data) }

pub fn image_filter_box_node_mean(s : ImagefilterboxNode) -> Double { @_common.mean(s.data) }

pub fn image_filter_box_node_scale(s : ImagefilterboxNode, f : Double) -> ImagefilterboxNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_box_node_add(a : ImagefilterboxNode, b : ImagefilterboxNode) -> ImagefilterboxNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_box_node_copy(s : ImagefilterboxNode) -> ImagefilterboxNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_box_node_fill(s : ImagefilterboxNode, v : Double) -> ImagefilterboxNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_box_node_min(s : ImagefilterboxNode) -> Double { @_common.min(s.data) }

pub fn image_filter_box_node_max(s : ImagefilterboxNode) -> Double { @_common.max(s.data) }

pub fn image_filter_box_node_to_string(s : ImagefilterboxNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_edge_make(size : Int) -> ImagefilterboxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_edge_len(s : ImagefilterboxEdge) -> Int { s.size }

pub fn image_filter_box_edge_get(s : ImagefilterboxEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_edge_set(s : ImagefilterboxEdge, i : Int, v : Double) -> ImagefilterboxEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_box_edge_sum(s : ImagefilterboxEdge) -> Double { @_common.sum(s.data) }

pub fn image_filter_box_edge_mean(s : ImagefilterboxEdge) -> Double { @_common.mean(s.data) }

pub fn image_filter_box_edge_scale(s : ImagefilterboxEdge, f : Double) -> ImagefilterboxEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_box_edge_add(a : ImagefilterboxEdge, b : ImagefilterboxEdge) -> ImagefilterboxEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_box_edge_copy(s : ImagefilterboxEdge) -> ImagefilterboxEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_box_edge_fill(s : ImagefilterboxEdge, v : Double) -> ImagefilterboxEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_box_edge_min(s : ImagefilterboxEdge) -> Double { @_common.min(s.data) }

pub fn image_filter_box_edge_max(s : ImagefilterboxEdge) -> Double { @_common.max(s.data) }

pub fn image_filter_box_edge_to_string(s : ImagefilterboxEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_path_make(size : Int) -> ImagefilterboxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_path_len(s : ImagefilterboxPath) -> Int { s.size }

pub fn image_filter_box_path_get(s : ImagefilterboxPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_path_set(s : ImagefilterboxPath, i : Int, v : Double) -> ImagefilterboxPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_box_path_sum(s : ImagefilterboxPath) -> Double { @_common.sum(s.data) }

pub fn image_filter_box_path_mean(s : ImagefilterboxPath) -> Double { @_common.mean(s.data) }

pub fn image_filter_box_path_scale(s : ImagefilterboxPath, f : Double) -> ImagefilterboxPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_box_path_add(a : ImagefilterboxPath, b : ImagefilterboxPath) -> ImagefilterboxPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_box_path_copy(s : ImagefilterboxPath) -> ImagefilterboxPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_box_path_fill(s : ImagefilterboxPath, v : Double) -> ImagefilterboxPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_box_path_min(s : ImagefilterboxPath) -> Double { @_common.min(s.data) }

pub fn image_filter_box_path_max(s : ImagefilterboxPath) -> Double { @_common.max(s.data) }

pub fn image_filter_box_path_to_string(s : ImagefilterboxPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_cluster_make(size : Int) -> ImagefilterboxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_cluster_len(s : ImagefilterboxCluster) -> Int { s.size }

pub fn image_filter_box_cluster_get(s : ImagefilterboxCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_cluster_set(s : ImagefilterboxCluster, i : Int, v : Double) -> ImagefilterboxCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_box_cluster_sum(s : ImagefilterboxCluster) -> Double { @_common.sum(s.data) }

pub fn image_filter_box_cluster_mean(s : ImagefilterboxCluster) -> Double { @_common.mean(s.data) }

pub fn image_filter_box_cluster_scale(s : ImagefilterboxCluster, f : Double) -> ImagefilterboxCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_box_cluster_add(a : ImagefilterboxCluster, b : ImagefilterboxCluster) -> ImagefilterboxCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_box_cluster_copy(s : ImagefilterboxCluster) -> ImagefilterboxCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_box_cluster_fill(s : ImagefilterboxCluster, v : Double) -> ImagefilterboxCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_box_cluster_min(s : ImagefilterboxCluster) -> Double { @_common.min(s.data) }

pub fn image_filter_box_cluster_max(s : ImagefilterboxCluster) -> Double { @_common.max(s.data) }

pub fn image_filter_box_cluster_to_string(s : ImagefilterboxCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_model_make(size : Int) -> ImagefilterboxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_model_len(s : ImagefilterboxModel) -> Int { s.size }

pub fn image_filter_box_model_get(s : ImagefilterboxModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_model_set(s : ImagefilterboxModel, i : Int, v : Double) -> ImagefilterboxModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_box_model_sum(s : ImagefilterboxModel) -> Double { @_common.sum(s.data) }

pub fn image_filter_box_model_mean(s : ImagefilterboxModel) -> Double { @_common.mean(s.data) }

pub fn image_filter_box_model_scale(s : ImagefilterboxModel, f : Double) -> ImagefilterboxModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_box_model_add(a : ImagefilterboxModel, b : ImagefilterboxModel) -> ImagefilterboxModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_box_model_copy(s : ImagefilterboxModel) -> ImagefilterboxModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_box_model_fill(s : ImagefilterboxModel, v : Double) -> ImagefilterboxModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_box_model_min(s : ImagefilterboxModel) -> Double { @_common.min(s.data) }

pub fn image_filter_box_model_max(s : ImagefilterboxModel) -> Double { @_common.max(s.data) }

pub fn image_filter_box_model_to_string(s : ImagefilterboxModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_layer_make(size : Int) -> ImagefilterboxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_layer_len(s : ImagefilterboxLayer) -> Int { s.size }

pub fn image_filter_box_layer_get(s : ImagefilterboxLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_layer_set(s : ImagefilterboxLayer, i : Int, v : Double) -> ImagefilterboxLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_box_layer_sum(s : ImagefilterboxLayer) -> Double { @_common.sum(s.data) }

pub fn image_filter_box_layer_mean(s : ImagefilterboxLayer) -> Double { @_common.mean(s.data) }

pub fn image_filter_box_layer_scale(s : ImagefilterboxLayer, f : Double) -> ImagefilterboxLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_box_layer_add(a : ImagefilterboxLayer, b : ImagefilterboxLayer) -> ImagefilterboxLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_box_layer_copy(s : ImagefilterboxLayer) -> ImagefilterboxLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_box_layer_fill(s : ImagefilterboxLayer, v : Double) -> ImagefilterboxLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_box_layer_min(s : ImagefilterboxLayer) -> Double { @_common.min(s.data) }

pub fn image_filter_box_layer_max(s : ImagefilterboxLayer) -> Double { @_common.max(s.data) }

pub fn image_filter_box_layer_to_string(s : ImagefilterboxLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_buffer_make(size : Int) -> ImagefilterboxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_buffer_len(s : ImagefilterboxBuffer) -> Int { s.size }

pub fn image_filter_box_buffer_get(s : ImagefilterboxBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_buffer_set(s : ImagefilterboxBuffer, i : Int, v : Double) -> ImagefilterboxBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_box_buffer_sum(s : ImagefilterboxBuffer) -> Double { @_common.sum(s.data) }

pub fn image_filter_box_buffer_mean(s : ImagefilterboxBuffer) -> Double { @_common.mean(s.data) }

pub fn image_filter_box_buffer_scale(s : ImagefilterboxBuffer, f : Double) -> ImagefilterboxBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_box_buffer_add(a : ImagefilterboxBuffer, b : ImagefilterboxBuffer) -> ImagefilterboxBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_box_buffer_copy(s : ImagefilterboxBuffer) -> ImagefilterboxBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_box_buffer_fill(s : ImagefilterboxBuffer, v : Double) -> ImagefilterboxBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_box_buffer_min(s : ImagefilterboxBuffer) -> Double { @_common.min(s.data) }

pub fn image_filter_box_buffer_max(s : ImagefilterboxBuffer) -> Double { @_common.max(s.data) }

pub fn image_filter_box_buffer_to_string(s : ImagefilterboxBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_cursor_make(size : Int) -> ImagefilterboxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_cursor_len(s : ImagefilterboxCursor) -> Int { s.size }

pub fn image_filter_box_cursor_get(s : ImagefilterboxCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_cursor_set(s : ImagefilterboxCursor, i : Int, v : Double) -> ImagefilterboxCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_box_cursor_sum(s : ImagefilterboxCursor) -> Double { @_common.sum(s.data) }

pub fn image_filter_box_cursor_mean(s : ImagefilterboxCursor) -> Double { @_common.mean(s.data) }

pub fn image_filter_box_cursor_scale(s : ImagefilterboxCursor, f : Double) -> ImagefilterboxCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_box_cursor_add(a : ImagefilterboxCursor, b : ImagefilterboxCursor) -> ImagefilterboxCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_box_cursor_copy(s : ImagefilterboxCursor) -> ImagefilterboxCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_box_cursor_fill(s : ImagefilterboxCursor, v : Double) -> ImagefilterboxCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_box_cursor_min(s : ImagefilterboxCursor) -> Double { @_common.min(s.data) }

pub fn image_filter_box_cursor_max(s : ImagefilterboxCursor) -> Double { @_common.max(s.data) }

pub fn image_filter_box_cursor_to_string(s : ImagefilterboxCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_view_make(size : Int) -> ImagefilterboxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_view_len(s : ImagefilterboxView) -> Int { s.size }

pub fn image_filter_box_view_get(s : ImagefilterboxView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_view_set(s : ImagefilterboxView, i : Int, v : Double) -> ImagefilterboxView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_box_view_sum(s : ImagefilterboxView) -> Double { @_common.sum(s.data) }

pub fn image_filter_box_view_mean(s : ImagefilterboxView) -> Double { @_common.mean(s.data) }

pub fn image_filter_box_view_scale(s : ImagefilterboxView, f : Double) -> ImagefilterboxView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_box_view_add(a : ImagefilterboxView, b : ImagefilterboxView) -> ImagefilterboxView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_box_view_copy(s : ImagefilterboxView) -> ImagefilterboxView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_box_view_fill(s : ImagefilterboxView, v : Double) -> ImagefilterboxView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_box_view_min(s : ImagefilterboxView) -> Double { @_common.min(s.data) }

pub fn image_filter_box_view_max(s : ImagefilterboxView) -> Double { @_common.max(s.data) }

pub fn image_filter_box_view_to_string(s : ImagefilterboxView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_range_make(size : Int) -> ImagefilterboxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_range_len(s : ImagefilterboxRange) -> Int { s.size }

pub fn image_filter_box_range_get(s : ImagefilterboxRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_range_set(s : ImagefilterboxRange, i : Int, v : Double) -> ImagefilterboxRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_box_range_sum(s : ImagefilterboxRange) -> Double { @_common.sum(s.data) }

pub fn image_filter_box_range_mean(s : ImagefilterboxRange) -> Double { @_common.mean(s.data) }

pub fn image_filter_box_range_scale(s : ImagefilterboxRange, f : Double) -> ImagefilterboxRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_box_range_add(a : ImagefilterboxRange, b : ImagefilterboxRange) -> ImagefilterboxRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_box_range_copy(s : ImagefilterboxRange) -> ImagefilterboxRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_box_range_fill(s : ImagefilterboxRange, v : Double) -> ImagefilterboxRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_box_range_min(s : ImagefilterboxRange) -> Double { @_common.min(s.data) }

pub fn image_filter_box_range_max(s : ImagefilterboxRange) -> Double { @_common.max(s.data) }

pub fn image_filter_box_range_to_string(s : ImagefilterboxRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefilterboxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_filter_box_slice_make(size : Int) -> ImagefilterboxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_filter_box_slice_len(s : ImagefilterboxSlice) -> Int { s.size }

pub fn image_filter_box_slice_get(s : ImagefilterboxSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_filter_box_slice_set(s : ImagefilterboxSlice, i : Int, v : Double) -> ImagefilterboxSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_filter_box_slice_sum(s : ImagefilterboxSlice) -> Double { @_common.sum(s.data) }

pub fn image_filter_box_slice_mean(s : ImagefilterboxSlice) -> Double { @_common.mean(s.data) }

pub fn image_filter_box_slice_scale(s : ImagefilterboxSlice, f : Double) -> ImagefilterboxSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_filter_box_slice_add(a : ImagefilterboxSlice, b : ImagefilterboxSlice) -> ImagefilterboxSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_filter_box_slice_copy(s : ImagefilterboxSlice) -> ImagefilterboxSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_filter_box_slice_fill(s : ImagefilterboxSlice, v : Double) -> ImagefilterboxSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_filter_box_slice_min(s : ImagefilterboxSlice) -> Double { @_common.min(s.data) }

pub fn image_filter_box_slice_max(s : ImagefilterboxSlice) -> Double { @_common.max(s.data) }

pub fn image_filter_box_slice_to_string(s : ImagefilterboxSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

