///===
/// extcore/image_transform_rotate

pub(all) struct ImagetransformrotatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_transform_rotate_make_point(x : Double, y : Double) -> ImagetransformrotatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_transform_rotate_make_point3(x : Double, y : Double, z : Double) -> ImagetransformrotatePoint {
  { x, y, z, label: 0 }
}

pub fn image_transform_rotate_point_x(pt : ImagetransformrotatePoint) -> Double { pt.x }

pub fn image_transform_rotate_point_y(pt : ImagetransformrotatePoint) -> Double { pt.y }

pub fn image_transform_rotate_point_z(pt : ImagetransformrotatePoint) -> Double { pt.z }

pub fn image_transform_rotate_point_label(pt : ImagetransformrotatePoint) -> Int { pt.label }

pub fn image_transform_rotate_point_dist(a : ImagetransformrotatePoint, b : ImagetransformrotatePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_transform_rotate_point_add(a : ImagetransformrotatePoint, b : ImagetransformrotatePoint) -> ImagetransformrotatePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_transform_rotate_point_sub(a : ImagetransformrotatePoint, b : ImagetransformrotatePoint) -> ImagetransformrotatePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_transform_rotate_point_scale(pt : ImagetransformrotatePoint, s : Double) -> ImagetransformrotatePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_transform_rotate_point_dot(a : ImagetransformrotatePoint, b : ImagetransformrotatePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_transform_rotate_point_cross(a : ImagetransformrotatePoint, b : ImagetransformrotatePoint) -> ImagetransformrotatePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_transform_rotate_point_norm(pt : ImagetransformrotatePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_transform_rotate_point_normalize(pt : ImagetransformrotatePoint) -> ImagetransformrotatePoint {
  let n = image_transform_rotate_point_norm(pt)
  if n < 0.0000001 { pt } else { image_transform_rotate_point_scale(pt, 1.0 / n) }
}

pub fn image_transform_rotate_point_negate(pt : ImagetransformrotatePoint) -> ImagetransformrotatePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_transform_rotate_point_mid(a : ImagetransformrotatePoint, b : ImagetransformrotatePoint) -> ImagetransformrotatePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_transform_rotate_point_lerp(a : ImagetransformrotatePoint, b : ImagetransformrotatePoint, t : Double) -> ImagetransformrotatePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_transform_rotate_point_to_string(pt : ImagetransformrotatePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagetransformrotateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_transform_rotate_make_series(vals : Array[Double], name : String) -> ImagetransformrotateSeries {
  { vals, name, meta: 0 }
}

pub fn image_transform_rotate_series_len(s : ImagetransformrotateSeries) -> Int { s.vals.length() }

pub fn image_transform_rotate_series_sum(s : ImagetransformrotateSeries) -> Double { @_common.sum(s.vals) }

pub fn image_transform_rotate_series_mean(s : ImagetransformrotateSeries) -> Double { @_common.mean(s.vals) }

pub fn image_transform_rotate_series_min(s : ImagetransformrotateSeries) -> Double { @_common.min(s.vals) }

pub fn image_transform_rotate_series_max(s : ImagetransformrotateSeries) -> Double { @_common.max(s.vals) }

pub fn image_transform_rotate_series_range(s : ImagetransformrotateSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_transform_rotate_series_var(s : ImagetransformrotateSeries) -> Double { @_common.variance(s.vals) }

pub fn image_transform_rotate_series_std(s : ImagetransformrotateSeries) -> Double { @_common.std(s.vals) }

pub fn image_transform_rotate_series_median(s : ImagetransformrotateSeries) -> Double { @_common.median(s.vals) }

pub fn image_transform_rotate_series_scale(s : ImagetransformrotateSeries, f : Double) -> ImagetransformrotateSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn image_transform_rotate_series_add(a : ImagetransformrotateSeries, b : ImagetransformrotateSeries) -> ImagetransformrotateSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_transform_rotate_series_sub(a : ImagetransformrotateSeries, b : ImagetransformrotateSeries) -> ImagetransformrotateSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_transform_rotate_series_normalize(s : ImagetransformrotateSeries) -> ImagetransformrotateSeries {
  let mn = image_transform_rotate_series_min(s)
  let mx = image_transform_rotate_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_transform_rotate_series_cumsum(s : ImagetransformrotateSeries) -> ImagetransformrotateSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_transform_rotate_series_to_string(s : ImagetransformrotateSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagetransformrotateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_transform_rotate_make_matrix(rows : Int, cols : Int, val : Double) -> ImagetransformrotateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_transform_rotate_matrix_identity(n : Int) -> ImagetransformrotateMatrix {
  let m = image_transform_rotate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_transform_rotate_matrix_get(m : ImagetransformrotateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_transform_rotate_matrix_transpose(m : ImagetransformrotateMatrix) -> ImagetransformrotateMatrix {
  let result = image_transform_rotate_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_transform_rotate_matrix_add(a : ImagetransformrotateMatrix, b : ImagetransformrotateMatrix) -> ImagetransformrotateMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_transform_rotate_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_transform_rotate_matrix_scale(m : ImagetransformrotateMatrix, s : Double) -> ImagetransformrotateMatrix {
  let result = image_transform_rotate_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_transform_rotate_matrix_multiply(a : ImagetransformrotateMatrix, b : ImagetransformrotateMatrix) -> ImagetransformrotateMatrix {
  if a.cols != b.rows { return image_transform_rotate_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_transform_rotate_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_transform_rotate_matrix_trace(m : ImagetransformrotateMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_transform_rotate_matrix_det(m : ImagetransformrotateMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_transform_rotate_matrix_norm(m : ImagetransformrotateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_transform_rotate_matrix_to_string(m : ImagetransformrotateMatrix) -> String {
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

pub(all) struct ImagetransformrotateVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_transform_rotate_make_vector(comps : Array[Double]) -> ImagetransformrotateVector {
  { comps, dim: comps.length() }
}

pub fn image_transform_rotate_vector_zero(dim : Int) -> ImagetransformrotateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_transform_rotate_vector_add(a : ImagetransformrotateVector, b : ImagetransformrotateVector) -> ImagetransformrotateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn image_transform_rotate_vector_sub(a : ImagetransformrotateVector, b : ImagetransformrotateVector) -> ImagetransformrotateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn image_transform_rotate_vector_scale(v : ImagetransformrotateVector, s : Double) -> ImagetransformrotateVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn image_transform_rotate_vector_dot(a : ImagetransformrotateVector, b : ImagetransformrotateVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_transform_rotate_vector_norm(v : ImagetransformrotateVector) -> Double { @_common.sqrt(image_transform_rotate_vector_dot(v, v)) }

pub fn image_transform_rotate_vector_normalize(v : ImagetransformrotateVector) -> ImagetransformrotateVector {
  let n = image_transform_rotate_vector_norm(v)
  if n < 0.0000001 { v } else { image_transform_rotate_vector_scale(v, 1.0 / n) }
}

pub fn image_transform_rotate_vector_dist(a : ImagetransformrotateVector, b : ImagetransformrotateVector) -> Double {
  image_transform_rotate_vector_norm(image_transform_rotate_vector_sub(a, b))
}

pub fn image_transform_rotate_vector_to_string(v : ImagetransformrotateVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_transform_rotate_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_transform_rotate_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_transform_rotate_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_transform_rotate_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_transform_rotate_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_transform_rotate_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_transform_rotate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_transform_rotate_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_transform_rotate_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_transform_rotate_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_transform_rotate_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_transform_rotate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_transform_rotate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_transform_rotate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_transform_rotate_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_transform_rotate_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_transform_rotate_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_transform_rotate_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_transform_rotate_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_transform_rotate_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_transform_rotate_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_transform_rotate_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_transform_rotate_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_transform_rotate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_transform_rotate_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_transform_rotate_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_transform_rotate_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_transform_rotate_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_transform_rotate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagetransformrotateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_frame_make(size : Int) -> ImagetransformrotateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_frame_len(s : ImagetransformrotateFrame) -> Int { s.size }

pub fn image_transform_rotate_frame_get(s : ImagetransformrotateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_frame_set(s : ImagetransformrotateFrame, i : Int, v : Double) -> ImagetransformrotateFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_frame_sum(s : ImagetransformrotateFrame) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_frame_mean(s : ImagetransformrotateFrame) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_frame_scale(s : ImagetransformrotateFrame, f : Double) -> ImagetransformrotateFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_frame_add(a : ImagetransformrotateFrame, b : ImagetransformrotateFrame) -> ImagetransformrotateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_frame_copy(s : ImagetransformrotateFrame) -> ImagetransformrotateFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_frame_fill(s : ImagetransformrotateFrame, v : Double) -> ImagetransformrotateFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_frame_min(s : ImagetransformrotateFrame) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_frame_max(s : ImagetransformrotateFrame) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_frame_to_string(s : ImagetransformrotateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_table_make(size : Int) -> ImagetransformrotateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_table_len(s : ImagetransformrotateTable) -> Int { s.size }

pub fn image_transform_rotate_table_get(s : ImagetransformrotateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_table_set(s : ImagetransformrotateTable, i : Int, v : Double) -> ImagetransformrotateTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_table_sum(s : ImagetransformrotateTable) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_table_mean(s : ImagetransformrotateTable) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_table_scale(s : ImagetransformrotateTable, f : Double) -> ImagetransformrotateTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_table_add(a : ImagetransformrotateTable, b : ImagetransformrotateTable) -> ImagetransformrotateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_table_copy(s : ImagetransformrotateTable) -> ImagetransformrotateTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_table_fill(s : ImagetransformrotateTable, v : Double) -> ImagetransformrotateTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_table_min(s : ImagetransformrotateTable) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_table_max(s : ImagetransformrotateTable) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_table_to_string(s : ImagetransformrotateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_graphn_make(size : Int) -> ImagetransformrotateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_graphn_len(s : ImagetransformrotateGraphN) -> Int { s.size }

pub fn image_transform_rotate_graphn_get(s : ImagetransformrotateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_graphn_set(s : ImagetransformrotateGraphN, i : Int, v : Double) -> ImagetransformrotateGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_graphn_sum(s : ImagetransformrotateGraphN) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_graphn_mean(s : ImagetransformrotateGraphN) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_graphn_scale(s : ImagetransformrotateGraphN, f : Double) -> ImagetransformrotateGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_graphn_add(a : ImagetransformrotateGraphN, b : ImagetransformrotateGraphN) -> ImagetransformrotateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_graphn_copy(s : ImagetransformrotateGraphN) -> ImagetransformrotateGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_graphn_fill(s : ImagetransformrotateGraphN, v : Double) -> ImagetransformrotateGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_graphn_min(s : ImagetransformrotateGraphN) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_graphn_max(s : ImagetransformrotateGraphN) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_graphn_to_string(s : ImagetransformrotateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_node_make(size : Int) -> ImagetransformrotateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_node_len(s : ImagetransformrotateNode) -> Int { s.size }

pub fn image_transform_rotate_node_get(s : ImagetransformrotateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_node_set(s : ImagetransformrotateNode, i : Int, v : Double) -> ImagetransformrotateNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_node_sum(s : ImagetransformrotateNode) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_node_mean(s : ImagetransformrotateNode) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_node_scale(s : ImagetransformrotateNode, f : Double) -> ImagetransformrotateNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_node_add(a : ImagetransformrotateNode, b : ImagetransformrotateNode) -> ImagetransformrotateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_node_copy(s : ImagetransformrotateNode) -> ImagetransformrotateNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_node_fill(s : ImagetransformrotateNode, v : Double) -> ImagetransformrotateNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_node_min(s : ImagetransformrotateNode) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_node_max(s : ImagetransformrotateNode) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_node_to_string(s : ImagetransformrotateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_edge_make(size : Int) -> ImagetransformrotateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_edge_len(s : ImagetransformrotateEdge) -> Int { s.size }

pub fn image_transform_rotate_edge_get(s : ImagetransformrotateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_edge_set(s : ImagetransformrotateEdge, i : Int, v : Double) -> ImagetransformrotateEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_edge_sum(s : ImagetransformrotateEdge) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_edge_mean(s : ImagetransformrotateEdge) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_edge_scale(s : ImagetransformrotateEdge, f : Double) -> ImagetransformrotateEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_edge_add(a : ImagetransformrotateEdge, b : ImagetransformrotateEdge) -> ImagetransformrotateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_edge_copy(s : ImagetransformrotateEdge) -> ImagetransformrotateEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_edge_fill(s : ImagetransformrotateEdge, v : Double) -> ImagetransformrotateEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_edge_min(s : ImagetransformrotateEdge) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_edge_max(s : ImagetransformrotateEdge) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_edge_to_string(s : ImagetransformrotateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_path_make(size : Int) -> ImagetransformrotatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_path_len(s : ImagetransformrotatePath) -> Int { s.size }

pub fn image_transform_rotate_path_get(s : ImagetransformrotatePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_path_set(s : ImagetransformrotatePath, i : Int, v : Double) -> ImagetransformrotatePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_path_sum(s : ImagetransformrotatePath) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_path_mean(s : ImagetransformrotatePath) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_path_scale(s : ImagetransformrotatePath, f : Double) -> ImagetransformrotatePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_path_add(a : ImagetransformrotatePath, b : ImagetransformrotatePath) -> ImagetransformrotatePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_path_copy(s : ImagetransformrotatePath) -> ImagetransformrotatePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_path_fill(s : ImagetransformrotatePath, v : Double) -> ImagetransformrotatePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_path_min(s : ImagetransformrotatePath) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_path_max(s : ImagetransformrotatePath) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_path_to_string(s : ImagetransformrotatePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_cluster_make(size : Int) -> ImagetransformrotateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_cluster_len(s : ImagetransformrotateCluster) -> Int { s.size }

pub fn image_transform_rotate_cluster_get(s : ImagetransformrotateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_cluster_set(s : ImagetransformrotateCluster, i : Int, v : Double) -> ImagetransformrotateCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_cluster_sum(s : ImagetransformrotateCluster) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_cluster_mean(s : ImagetransformrotateCluster) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_cluster_scale(s : ImagetransformrotateCluster, f : Double) -> ImagetransformrotateCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_cluster_add(a : ImagetransformrotateCluster, b : ImagetransformrotateCluster) -> ImagetransformrotateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_cluster_copy(s : ImagetransformrotateCluster) -> ImagetransformrotateCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_cluster_fill(s : ImagetransformrotateCluster, v : Double) -> ImagetransformrotateCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_cluster_min(s : ImagetransformrotateCluster) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_cluster_max(s : ImagetransformrotateCluster) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_cluster_to_string(s : ImagetransformrotateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_model_make(size : Int) -> ImagetransformrotateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_model_len(s : ImagetransformrotateModel) -> Int { s.size }

pub fn image_transform_rotate_model_get(s : ImagetransformrotateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_model_set(s : ImagetransformrotateModel, i : Int, v : Double) -> ImagetransformrotateModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_model_sum(s : ImagetransformrotateModel) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_model_mean(s : ImagetransformrotateModel) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_model_scale(s : ImagetransformrotateModel, f : Double) -> ImagetransformrotateModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_model_add(a : ImagetransformrotateModel, b : ImagetransformrotateModel) -> ImagetransformrotateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_model_copy(s : ImagetransformrotateModel) -> ImagetransformrotateModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_model_fill(s : ImagetransformrotateModel, v : Double) -> ImagetransformrotateModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_model_min(s : ImagetransformrotateModel) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_model_max(s : ImagetransformrotateModel) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_model_to_string(s : ImagetransformrotateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_layer_make(size : Int) -> ImagetransformrotateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_layer_len(s : ImagetransformrotateLayer) -> Int { s.size }

pub fn image_transform_rotate_layer_get(s : ImagetransformrotateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_layer_set(s : ImagetransformrotateLayer, i : Int, v : Double) -> ImagetransformrotateLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_layer_sum(s : ImagetransformrotateLayer) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_layer_mean(s : ImagetransformrotateLayer) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_layer_scale(s : ImagetransformrotateLayer, f : Double) -> ImagetransformrotateLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_layer_add(a : ImagetransformrotateLayer, b : ImagetransformrotateLayer) -> ImagetransformrotateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_layer_copy(s : ImagetransformrotateLayer) -> ImagetransformrotateLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_layer_fill(s : ImagetransformrotateLayer, v : Double) -> ImagetransformrotateLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_layer_min(s : ImagetransformrotateLayer) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_layer_max(s : ImagetransformrotateLayer) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_layer_to_string(s : ImagetransformrotateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_buffer_make(size : Int) -> ImagetransformrotateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_buffer_len(s : ImagetransformrotateBuffer) -> Int { s.size }

pub fn image_transform_rotate_buffer_get(s : ImagetransformrotateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_buffer_set(s : ImagetransformrotateBuffer, i : Int, v : Double) -> ImagetransformrotateBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_buffer_sum(s : ImagetransformrotateBuffer) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_buffer_mean(s : ImagetransformrotateBuffer) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_buffer_scale(s : ImagetransformrotateBuffer, f : Double) -> ImagetransformrotateBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_buffer_add(a : ImagetransformrotateBuffer, b : ImagetransformrotateBuffer) -> ImagetransformrotateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_buffer_copy(s : ImagetransformrotateBuffer) -> ImagetransformrotateBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_buffer_fill(s : ImagetransformrotateBuffer, v : Double) -> ImagetransformrotateBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_buffer_min(s : ImagetransformrotateBuffer) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_buffer_max(s : ImagetransformrotateBuffer) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_buffer_to_string(s : ImagetransformrotateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_cursor_make(size : Int) -> ImagetransformrotateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_cursor_len(s : ImagetransformrotateCursor) -> Int { s.size }

pub fn image_transform_rotate_cursor_get(s : ImagetransformrotateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_cursor_set(s : ImagetransformrotateCursor, i : Int, v : Double) -> ImagetransformrotateCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_cursor_sum(s : ImagetransformrotateCursor) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_cursor_mean(s : ImagetransformrotateCursor) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_cursor_scale(s : ImagetransformrotateCursor, f : Double) -> ImagetransformrotateCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_cursor_add(a : ImagetransformrotateCursor, b : ImagetransformrotateCursor) -> ImagetransformrotateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_cursor_copy(s : ImagetransformrotateCursor) -> ImagetransformrotateCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_cursor_fill(s : ImagetransformrotateCursor, v : Double) -> ImagetransformrotateCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_cursor_min(s : ImagetransformrotateCursor) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_cursor_max(s : ImagetransformrotateCursor) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_cursor_to_string(s : ImagetransformrotateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_view_make(size : Int) -> ImagetransformrotateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_view_len(s : ImagetransformrotateView) -> Int { s.size }

pub fn image_transform_rotate_view_get(s : ImagetransformrotateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_view_set(s : ImagetransformrotateView, i : Int, v : Double) -> ImagetransformrotateView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_view_sum(s : ImagetransformrotateView) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_view_mean(s : ImagetransformrotateView) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_view_scale(s : ImagetransformrotateView, f : Double) -> ImagetransformrotateView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_view_add(a : ImagetransformrotateView, b : ImagetransformrotateView) -> ImagetransformrotateView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_view_copy(s : ImagetransformrotateView) -> ImagetransformrotateView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_view_fill(s : ImagetransformrotateView, v : Double) -> ImagetransformrotateView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_view_min(s : ImagetransformrotateView) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_view_max(s : ImagetransformrotateView) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_view_to_string(s : ImagetransformrotateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_range_make(size : Int) -> ImagetransformrotateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_range_len(s : ImagetransformrotateRange) -> Int { s.size }

pub fn image_transform_rotate_range_get(s : ImagetransformrotateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_range_set(s : ImagetransformrotateRange, i : Int, v : Double) -> ImagetransformrotateRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_range_sum(s : ImagetransformrotateRange) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_range_mean(s : ImagetransformrotateRange) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_range_scale(s : ImagetransformrotateRange, f : Double) -> ImagetransformrotateRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_range_add(a : ImagetransformrotateRange, b : ImagetransformrotateRange) -> ImagetransformrotateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_range_copy(s : ImagetransformrotateRange) -> ImagetransformrotateRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_range_fill(s : ImagetransformrotateRange, v : Double) -> ImagetransformrotateRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_range_min(s : ImagetransformrotateRange) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_range_max(s : ImagetransformrotateRange) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_range_to_string(s : ImagetransformrotateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagetransformrotateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_transform_rotate_slice_make(size : Int) -> ImagetransformrotateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_transform_rotate_slice_len(s : ImagetransformrotateSlice) -> Int { s.size }

pub fn image_transform_rotate_slice_get(s : ImagetransformrotateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_transform_rotate_slice_set(s : ImagetransformrotateSlice, i : Int, v : Double) -> ImagetransformrotateSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_slice_sum(s : ImagetransformrotateSlice) -> Double { @_common.sum(s.data) }

pub fn image_transform_rotate_slice_mean(s : ImagetransformrotateSlice) -> Double { @_common.mean(s.data) }

pub fn image_transform_rotate_slice_scale(s : ImagetransformrotateSlice, f : Double) -> ImagetransformrotateSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_slice_add(a : ImagetransformrotateSlice, b : ImagetransformrotateSlice) -> ImagetransformrotateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_transform_rotate_slice_copy(s : ImagetransformrotateSlice) -> ImagetransformrotateSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_slice_fill(s : ImagetransformrotateSlice, v : Double) -> ImagetransformrotateSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_transform_rotate_slice_min(s : ImagetransformrotateSlice) -> Double { @_common.min(s.data) }

pub fn image_transform_rotate_slice_max(s : ImagetransformrotateSlice) -> Double { @_common.max(s.data) }

pub fn image_transform_rotate_slice_to_string(s : ImagetransformrotateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

