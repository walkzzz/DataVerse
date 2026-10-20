///===
/// extcore/image_feature_akaze

pub(all) struct ImagefeatureakazePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn image_feature_akaze_make_point(x : Double, y : Double) -> ImagefeatureakazePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn image_feature_akaze_make_point3(x : Double, y : Double, z : Double) -> ImagefeatureakazePoint {
  { x, y, z, label: 0 }
}

pub fn image_feature_akaze_point_x(pt : ImagefeatureakazePoint) -> Double { pt.x }

pub fn image_feature_akaze_point_y(pt : ImagefeatureakazePoint) -> Double { pt.y }

pub fn image_feature_akaze_point_z(pt : ImagefeatureakazePoint) -> Double { pt.z }

pub fn image_feature_akaze_point_label(pt : ImagefeatureakazePoint) -> Int { pt.label }

pub fn image_feature_akaze_point_dist(a : ImagefeatureakazePoint, b : ImagefeatureakazePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn image_feature_akaze_point_add(a : ImagefeatureakazePoint, b : ImagefeatureakazePoint) -> ImagefeatureakazePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn image_feature_akaze_point_sub(a : ImagefeatureakazePoint, b : ImagefeatureakazePoint) -> ImagefeatureakazePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn image_feature_akaze_point_scale(pt : ImagefeatureakazePoint, s : Double) -> ImagefeatureakazePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn image_feature_akaze_point_dot(a : ImagefeatureakazePoint, b : ImagefeatureakazePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn image_feature_akaze_point_cross(a : ImagefeatureakazePoint, b : ImagefeatureakazePoint) -> ImagefeatureakazePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn image_feature_akaze_point_norm(pt : ImagefeatureakazePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn image_feature_akaze_point_normalize(pt : ImagefeatureakazePoint) -> ImagefeatureakazePoint {
  let n = image_feature_akaze_point_norm(pt)
  if n < 0.0000001 { pt } else { image_feature_akaze_point_scale(pt, 1.0 / n) }
}

pub fn image_feature_akaze_point_negate(pt : ImagefeatureakazePoint) -> ImagefeatureakazePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn image_feature_akaze_point_mid(a : ImagefeatureakazePoint, b : ImagefeatureakazePoint) -> ImagefeatureakazePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn image_feature_akaze_point_lerp(a : ImagefeatureakazePoint, b : ImagefeatureakazePoint, t : Double) -> ImagefeatureakazePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn image_feature_akaze_point_to_string(pt : ImagefeatureakazePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ImagefeatureakazeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn image_feature_akaze_make_series(vals : Array[Double], name : String) -> ImagefeatureakazeSeries {
  { vals, name, meta: 0 }
}

pub fn image_feature_akaze_series_len(s : ImagefeatureakazeSeries) -> Int { s.vals.length() }

pub fn image_feature_akaze_series_sum(s : ImagefeatureakazeSeries) -> Double { @_common.sum(s.vals) }

pub fn image_feature_akaze_series_mean(s : ImagefeatureakazeSeries) -> Double { @_common.mean(s.vals) }

pub fn image_feature_akaze_series_min(s : ImagefeatureakazeSeries) -> Double { @_common.min(s.vals) }

pub fn image_feature_akaze_series_max(s : ImagefeatureakazeSeries) -> Double { @_common.max(s.vals) }

pub fn image_feature_akaze_series_range(s : ImagefeatureakazeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn image_feature_akaze_series_var(s : ImagefeatureakazeSeries) -> Double { @_common.variance(s.vals) }

pub fn image_feature_akaze_series_std(s : ImagefeatureakazeSeries) -> Double { @_common.std(s.vals) }

pub fn image_feature_akaze_series_median(s : ImagefeatureakazeSeries) -> Double { @_common.median(s.vals) }

pub fn image_feature_akaze_series_scale(s : ImagefeatureakazeSeries, f : Double) -> ImagefeatureakazeSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn image_feature_akaze_series_add(a : ImagefeatureakazeSeries, b : ImagefeatureakazeSeries) -> ImagefeatureakazeSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn image_feature_akaze_series_sub(a : ImagefeatureakazeSeries, b : ImagefeatureakazeSeries) -> ImagefeatureakazeSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn image_feature_akaze_series_normalize(s : ImagefeatureakazeSeries) -> ImagefeatureakazeSeries {
  let mn = image_feature_akaze_series_min(s)
  let mx = image_feature_akaze_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn image_feature_akaze_series_cumsum(s : ImagefeatureakazeSeries) -> ImagefeatureakazeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn image_feature_akaze_series_to_string(s : ImagefeatureakazeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ImagefeatureakazeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn image_feature_akaze_make_matrix(rows : Int, cols : Int, val : Double) -> ImagefeatureakazeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn image_feature_akaze_matrix_identity(n : Int) -> ImagefeatureakazeMatrix {
  let m = image_feature_akaze_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn image_feature_akaze_matrix_get(m : ImagefeatureakazeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn image_feature_akaze_matrix_transpose(m : ImagefeatureakazeMatrix) -> ImagefeatureakazeMatrix {
  let result = image_feature_akaze_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn image_feature_akaze_matrix_add(a : ImagefeatureakazeMatrix, b : ImagefeatureakazeMatrix) -> ImagefeatureakazeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = image_feature_akaze_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn image_feature_akaze_matrix_scale(m : ImagefeatureakazeMatrix, s : Double) -> ImagefeatureakazeMatrix {
  let result = image_feature_akaze_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn image_feature_akaze_matrix_multiply(a : ImagefeatureakazeMatrix, b : ImagefeatureakazeMatrix) -> ImagefeatureakazeMatrix {
  if a.cols != b.rows { return image_feature_akaze_make_matrix(a.rows, b.cols, 0.0) }
  let result = image_feature_akaze_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn image_feature_akaze_matrix_trace(m : ImagefeatureakazeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn image_feature_akaze_matrix_det(m : ImagefeatureakazeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn image_feature_akaze_matrix_norm(m : ImagefeatureakazeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn image_feature_akaze_matrix_to_string(m : ImagefeatureakazeMatrix) -> String {
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

pub(all) struct ImagefeatureakazeVector {
  comps : Array[Double]
  dim : Int
}

pub fn image_feature_akaze_make_vector(comps : Array[Double]) -> ImagefeatureakazeVector {
  { comps, dim: comps.length() }
}

pub fn image_feature_akaze_vector_zero(dim : Int) -> ImagefeatureakazeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn image_feature_akaze_vector_add(a : ImagefeatureakazeVector, b : ImagefeatureakazeVector) -> ImagefeatureakazeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn image_feature_akaze_vector_sub(a : ImagefeatureakazeVector, b : ImagefeatureakazeVector) -> ImagefeatureakazeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn image_feature_akaze_vector_scale(v : ImagefeatureakazeVector, s : Double) -> ImagefeatureakazeVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn image_feature_akaze_vector_dot(a : ImagefeatureakazeVector, b : ImagefeatureakazeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn image_feature_akaze_vector_norm(v : ImagefeatureakazeVector) -> Double { @_common.sqrt(image_feature_akaze_vector_dot(v, v)) }

pub fn image_feature_akaze_vector_normalize(v : ImagefeatureakazeVector) -> ImagefeatureakazeVector {
  let n = image_feature_akaze_vector_norm(v)
  if n < 0.0000001 { v } else { image_feature_akaze_vector_scale(v, 1.0 / n) }
}

pub fn image_feature_akaze_vector_dist(a : ImagefeatureakazeVector, b : ImagefeatureakazeVector) -> Double {
  image_feature_akaze_vector_norm(image_feature_akaze_vector_sub(a, b))
}

pub fn image_feature_akaze_vector_to_string(v : ImagefeatureakazeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn image_feature_akaze_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn image_feature_akaze_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn image_feature_akaze_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn image_feature_akaze_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn image_feature_akaze_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn image_feature_akaze_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn image_feature_akaze_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn image_feature_akaze_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn image_feature_akaze_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn image_feature_akaze_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn image_feature_akaze_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn image_feature_akaze_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn image_feature_akaze_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn image_feature_akaze_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn image_feature_akaze_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn image_feature_akaze_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn image_feature_akaze_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn image_feature_akaze_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn image_feature_akaze_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn image_feature_akaze_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn image_feature_akaze_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn image_feature_akaze_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn image_feature_akaze_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn image_feature_akaze_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn image_feature_akaze_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn image_feature_akaze_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn image_feature_akaze_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn image_feature_akaze_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn image_feature_akaze_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ImagefeatureakazeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_frame_make(size : Int) -> ImagefeatureakazeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_akaze_frame_len(s : ImagefeatureakazeFrame) -> Int { s.size }

pub fn image_feature_akaze_frame_get(s : ImagefeatureakazeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_akaze_frame_set(s : ImagefeatureakazeFrame, i : Int, v : Double) -> ImagefeatureakazeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_frame_sum(s : ImagefeatureakazeFrame) -> Double { @_common.sum(s.data) }

pub fn image_feature_akaze_frame_mean(s : ImagefeatureakazeFrame) -> Double { @_common.mean(s.data) }

pub fn image_feature_akaze_frame_scale(s : ImagefeatureakazeFrame, f : Double) -> ImagefeatureakazeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_frame_add(a : ImagefeatureakazeFrame, b : ImagefeatureakazeFrame) -> ImagefeatureakazeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_akaze_frame_copy(s : ImagefeatureakazeFrame) -> ImagefeatureakazeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_frame_fill(s : ImagefeatureakazeFrame, v : Double) -> ImagefeatureakazeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_frame_min(s : ImagefeatureakazeFrame) -> Double { @_common.min(s.data) }

pub fn image_feature_akaze_frame_max(s : ImagefeatureakazeFrame) -> Double { @_common.max(s.data) }

pub fn image_feature_akaze_frame_to_string(s : ImagefeatureakazeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_table_make(size : Int) -> ImagefeatureakazeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_akaze_table_len(s : ImagefeatureakazeTable) -> Int { s.size }

pub fn image_feature_akaze_table_get(s : ImagefeatureakazeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_akaze_table_set(s : ImagefeatureakazeTable, i : Int, v : Double) -> ImagefeatureakazeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_table_sum(s : ImagefeatureakazeTable) -> Double { @_common.sum(s.data) }

pub fn image_feature_akaze_table_mean(s : ImagefeatureakazeTable) -> Double { @_common.mean(s.data) }

pub fn image_feature_akaze_table_scale(s : ImagefeatureakazeTable, f : Double) -> ImagefeatureakazeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_table_add(a : ImagefeatureakazeTable, b : ImagefeatureakazeTable) -> ImagefeatureakazeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_akaze_table_copy(s : ImagefeatureakazeTable) -> ImagefeatureakazeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_table_fill(s : ImagefeatureakazeTable, v : Double) -> ImagefeatureakazeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_table_min(s : ImagefeatureakazeTable) -> Double { @_common.min(s.data) }

pub fn image_feature_akaze_table_max(s : ImagefeatureakazeTable) -> Double { @_common.max(s.data) }

pub fn image_feature_akaze_table_to_string(s : ImagefeatureakazeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_graphn_make(size : Int) -> ImagefeatureakazeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_akaze_graphn_len(s : ImagefeatureakazeGraphN) -> Int { s.size }

pub fn image_feature_akaze_graphn_get(s : ImagefeatureakazeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_akaze_graphn_set(s : ImagefeatureakazeGraphN, i : Int, v : Double) -> ImagefeatureakazeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_graphn_sum(s : ImagefeatureakazeGraphN) -> Double { @_common.sum(s.data) }

pub fn image_feature_akaze_graphn_mean(s : ImagefeatureakazeGraphN) -> Double { @_common.mean(s.data) }

pub fn image_feature_akaze_graphn_scale(s : ImagefeatureakazeGraphN, f : Double) -> ImagefeatureakazeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_graphn_add(a : ImagefeatureakazeGraphN, b : ImagefeatureakazeGraphN) -> ImagefeatureakazeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_akaze_graphn_copy(s : ImagefeatureakazeGraphN) -> ImagefeatureakazeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_graphn_fill(s : ImagefeatureakazeGraphN, v : Double) -> ImagefeatureakazeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_graphn_min(s : ImagefeatureakazeGraphN) -> Double { @_common.min(s.data) }

pub fn image_feature_akaze_graphn_max(s : ImagefeatureakazeGraphN) -> Double { @_common.max(s.data) }

pub fn image_feature_akaze_graphn_to_string(s : ImagefeatureakazeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_node_make(size : Int) -> ImagefeatureakazeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_akaze_node_len(s : ImagefeatureakazeNode) -> Int { s.size }

pub fn image_feature_akaze_node_get(s : ImagefeatureakazeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_akaze_node_set(s : ImagefeatureakazeNode, i : Int, v : Double) -> ImagefeatureakazeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_node_sum(s : ImagefeatureakazeNode) -> Double { @_common.sum(s.data) }

pub fn image_feature_akaze_node_mean(s : ImagefeatureakazeNode) -> Double { @_common.mean(s.data) }

pub fn image_feature_akaze_node_scale(s : ImagefeatureakazeNode, f : Double) -> ImagefeatureakazeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_node_add(a : ImagefeatureakazeNode, b : ImagefeatureakazeNode) -> ImagefeatureakazeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_akaze_node_copy(s : ImagefeatureakazeNode) -> ImagefeatureakazeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_node_fill(s : ImagefeatureakazeNode, v : Double) -> ImagefeatureakazeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_node_min(s : ImagefeatureakazeNode) -> Double { @_common.min(s.data) }

pub fn image_feature_akaze_node_max(s : ImagefeatureakazeNode) -> Double { @_common.max(s.data) }

pub fn image_feature_akaze_node_to_string(s : ImagefeatureakazeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_edge_make(size : Int) -> ImagefeatureakazeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_akaze_edge_len(s : ImagefeatureakazeEdge) -> Int { s.size }

pub fn image_feature_akaze_edge_get(s : ImagefeatureakazeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_akaze_edge_set(s : ImagefeatureakazeEdge, i : Int, v : Double) -> ImagefeatureakazeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_edge_sum(s : ImagefeatureakazeEdge) -> Double { @_common.sum(s.data) }

pub fn image_feature_akaze_edge_mean(s : ImagefeatureakazeEdge) -> Double { @_common.mean(s.data) }

pub fn image_feature_akaze_edge_scale(s : ImagefeatureakazeEdge, f : Double) -> ImagefeatureakazeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_edge_add(a : ImagefeatureakazeEdge, b : ImagefeatureakazeEdge) -> ImagefeatureakazeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_akaze_edge_copy(s : ImagefeatureakazeEdge) -> ImagefeatureakazeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_edge_fill(s : ImagefeatureakazeEdge, v : Double) -> ImagefeatureakazeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_edge_min(s : ImagefeatureakazeEdge) -> Double { @_common.min(s.data) }

pub fn image_feature_akaze_edge_max(s : ImagefeatureakazeEdge) -> Double { @_common.max(s.data) }

pub fn image_feature_akaze_edge_to_string(s : ImagefeatureakazeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_path_make(size : Int) -> ImagefeatureakazePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_akaze_path_len(s : ImagefeatureakazePath) -> Int { s.size }

pub fn image_feature_akaze_path_get(s : ImagefeatureakazePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_akaze_path_set(s : ImagefeatureakazePath, i : Int, v : Double) -> ImagefeatureakazePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_path_sum(s : ImagefeatureakazePath) -> Double { @_common.sum(s.data) }

pub fn image_feature_akaze_path_mean(s : ImagefeatureakazePath) -> Double { @_common.mean(s.data) }

pub fn image_feature_akaze_path_scale(s : ImagefeatureakazePath, f : Double) -> ImagefeatureakazePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_path_add(a : ImagefeatureakazePath, b : ImagefeatureakazePath) -> ImagefeatureakazePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_akaze_path_copy(s : ImagefeatureakazePath) -> ImagefeatureakazePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_path_fill(s : ImagefeatureakazePath, v : Double) -> ImagefeatureakazePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_path_min(s : ImagefeatureakazePath) -> Double { @_common.min(s.data) }

pub fn image_feature_akaze_path_max(s : ImagefeatureakazePath) -> Double { @_common.max(s.data) }

pub fn image_feature_akaze_path_to_string(s : ImagefeatureakazePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_cluster_make(size : Int) -> ImagefeatureakazeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_akaze_cluster_len(s : ImagefeatureakazeCluster) -> Int { s.size }

pub fn image_feature_akaze_cluster_get(s : ImagefeatureakazeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_akaze_cluster_set(s : ImagefeatureakazeCluster, i : Int, v : Double) -> ImagefeatureakazeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_cluster_sum(s : ImagefeatureakazeCluster) -> Double { @_common.sum(s.data) }

pub fn image_feature_akaze_cluster_mean(s : ImagefeatureakazeCluster) -> Double { @_common.mean(s.data) }

pub fn image_feature_akaze_cluster_scale(s : ImagefeatureakazeCluster, f : Double) -> ImagefeatureakazeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_cluster_add(a : ImagefeatureakazeCluster, b : ImagefeatureakazeCluster) -> ImagefeatureakazeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_akaze_cluster_copy(s : ImagefeatureakazeCluster) -> ImagefeatureakazeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_cluster_fill(s : ImagefeatureakazeCluster, v : Double) -> ImagefeatureakazeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_cluster_min(s : ImagefeatureakazeCluster) -> Double { @_common.min(s.data) }

pub fn image_feature_akaze_cluster_max(s : ImagefeatureakazeCluster) -> Double { @_common.max(s.data) }

pub fn image_feature_akaze_cluster_to_string(s : ImagefeatureakazeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_model_make(size : Int) -> ImagefeatureakazeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_akaze_model_len(s : ImagefeatureakazeModel) -> Int { s.size }

pub fn image_feature_akaze_model_get(s : ImagefeatureakazeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_akaze_model_set(s : ImagefeatureakazeModel, i : Int, v : Double) -> ImagefeatureakazeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_model_sum(s : ImagefeatureakazeModel) -> Double { @_common.sum(s.data) }

pub fn image_feature_akaze_model_mean(s : ImagefeatureakazeModel) -> Double { @_common.mean(s.data) }

pub fn image_feature_akaze_model_scale(s : ImagefeatureakazeModel, f : Double) -> ImagefeatureakazeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_model_add(a : ImagefeatureakazeModel, b : ImagefeatureakazeModel) -> ImagefeatureakazeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_akaze_model_copy(s : ImagefeatureakazeModel) -> ImagefeatureakazeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_model_fill(s : ImagefeatureakazeModel, v : Double) -> ImagefeatureakazeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_model_min(s : ImagefeatureakazeModel) -> Double { @_common.min(s.data) }

pub fn image_feature_akaze_model_max(s : ImagefeatureakazeModel) -> Double { @_common.max(s.data) }

pub fn image_feature_akaze_model_to_string(s : ImagefeatureakazeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_layer_make(size : Int) -> ImagefeatureakazeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_akaze_layer_len(s : ImagefeatureakazeLayer) -> Int { s.size }

pub fn image_feature_akaze_layer_get(s : ImagefeatureakazeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_akaze_layer_set(s : ImagefeatureakazeLayer, i : Int, v : Double) -> ImagefeatureakazeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_layer_sum(s : ImagefeatureakazeLayer) -> Double { @_common.sum(s.data) }

pub fn image_feature_akaze_layer_mean(s : ImagefeatureakazeLayer) -> Double { @_common.mean(s.data) }

pub fn image_feature_akaze_layer_scale(s : ImagefeatureakazeLayer, f : Double) -> ImagefeatureakazeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_layer_add(a : ImagefeatureakazeLayer, b : ImagefeatureakazeLayer) -> ImagefeatureakazeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_akaze_layer_copy(s : ImagefeatureakazeLayer) -> ImagefeatureakazeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_layer_fill(s : ImagefeatureakazeLayer, v : Double) -> ImagefeatureakazeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_layer_min(s : ImagefeatureakazeLayer) -> Double { @_common.min(s.data) }

pub fn image_feature_akaze_layer_max(s : ImagefeatureakazeLayer) -> Double { @_common.max(s.data) }

pub fn image_feature_akaze_layer_to_string(s : ImagefeatureakazeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_buffer_make(size : Int) -> ImagefeatureakazeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_akaze_buffer_len(s : ImagefeatureakazeBuffer) -> Int { s.size }

pub fn image_feature_akaze_buffer_get(s : ImagefeatureakazeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_akaze_buffer_set(s : ImagefeatureakazeBuffer, i : Int, v : Double) -> ImagefeatureakazeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_buffer_sum(s : ImagefeatureakazeBuffer) -> Double { @_common.sum(s.data) }

pub fn image_feature_akaze_buffer_mean(s : ImagefeatureakazeBuffer) -> Double { @_common.mean(s.data) }

pub fn image_feature_akaze_buffer_scale(s : ImagefeatureakazeBuffer, f : Double) -> ImagefeatureakazeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_buffer_add(a : ImagefeatureakazeBuffer, b : ImagefeatureakazeBuffer) -> ImagefeatureakazeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_akaze_buffer_copy(s : ImagefeatureakazeBuffer) -> ImagefeatureakazeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_buffer_fill(s : ImagefeatureakazeBuffer, v : Double) -> ImagefeatureakazeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_buffer_min(s : ImagefeatureakazeBuffer) -> Double { @_common.min(s.data) }

pub fn image_feature_akaze_buffer_max(s : ImagefeatureakazeBuffer) -> Double { @_common.max(s.data) }

pub fn image_feature_akaze_buffer_to_string(s : ImagefeatureakazeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_cursor_make(size : Int) -> ImagefeatureakazeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_akaze_cursor_len(s : ImagefeatureakazeCursor) -> Int { s.size }

pub fn image_feature_akaze_cursor_get(s : ImagefeatureakazeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_akaze_cursor_set(s : ImagefeatureakazeCursor, i : Int, v : Double) -> ImagefeatureakazeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_cursor_sum(s : ImagefeatureakazeCursor) -> Double { @_common.sum(s.data) }

pub fn image_feature_akaze_cursor_mean(s : ImagefeatureakazeCursor) -> Double { @_common.mean(s.data) }

pub fn image_feature_akaze_cursor_scale(s : ImagefeatureakazeCursor, f : Double) -> ImagefeatureakazeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_cursor_add(a : ImagefeatureakazeCursor, b : ImagefeatureakazeCursor) -> ImagefeatureakazeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_akaze_cursor_copy(s : ImagefeatureakazeCursor) -> ImagefeatureakazeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_cursor_fill(s : ImagefeatureakazeCursor, v : Double) -> ImagefeatureakazeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_cursor_min(s : ImagefeatureakazeCursor) -> Double { @_common.min(s.data) }

pub fn image_feature_akaze_cursor_max(s : ImagefeatureakazeCursor) -> Double { @_common.max(s.data) }

pub fn image_feature_akaze_cursor_to_string(s : ImagefeatureakazeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_view_make(size : Int) -> ImagefeatureakazeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_akaze_view_len(s : ImagefeatureakazeView) -> Int { s.size }

pub fn image_feature_akaze_view_get(s : ImagefeatureakazeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_akaze_view_set(s : ImagefeatureakazeView, i : Int, v : Double) -> ImagefeatureakazeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_view_sum(s : ImagefeatureakazeView) -> Double { @_common.sum(s.data) }

pub fn image_feature_akaze_view_mean(s : ImagefeatureakazeView) -> Double { @_common.mean(s.data) }

pub fn image_feature_akaze_view_scale(s : ImagefeatureakazeView, f : Double) -> ImagefeatureakazeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_view_add(a : ImagefeatureakazeView, b : ImagefeatureakazeView) -> ImagefeatureakazeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_akaze_view_copy(s : ImagefeatureakazeView) -> ImagefeatureakazeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_view_fill(s : ImagefeatureakazeView, v : Double) -> ImagefeatureakazeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_view_min(s : ImagefeatureakazeView) -> Double { @_common.min(s.data) }

pub fn image_feature_akaze_view_max(s : ImagefeatureakazeView) -> Double { @_common.max(s.data) }

pub fn image_feature_akaze_view_to_string(s : ImagefeatureakazeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_range_make(size : Int) -> ImagefeatureakazeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_akaze_range_len(s : ImagefeatureakazeRange) -> Int { s.size }

pub fn image_feature_akaze_range_get(s : ImagefeatureakazeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_akaze_range_set(s : ImagefeatureakazeRange, i : Int, v : Double) -> ImagefeatureakazeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_range_sum(s : ImagefeatureakazeRange) -> Double { @_common.sum(s.data) }

pub fn image_feature_akaze_range_mean(s : ImagefeatureakazeRange) -> Double { @_common.mean(s.data) }

pub fn image_feature_akaze_range_scale(s : ImagefeatureakazeRange, f : Double) -> ImagefeatureakazeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_range_add(a : ImagefeatureakazeRange, b : ImagefeatureakazeRange) -> ImagefeatureakazeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_akaze_range_copy(s : ImagefeatureakazeRange) -> ImagefeatureakazeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_range_fill(s : ImagefeatureakazeRange, v : Double) -> ImagefeatureakazeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_range_min(s : ImagefeatureakazeRange) -> Double { @_common.min(s.data) }

pub fn image_feature_akaze_range_max(s : ImagefeatureakazeRange) -> Double { @_common.max(s.data) }

pub fn image_feature_akaze_range_to_string(s : ImagefeatureakazeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ImagefeatureakazeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn image_feature_akaze_slice_make(size : Int) -> ImagefeatureakazeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn image_feature_akaze_slice_len(s : ImagefeatureakazeSlice) -> Int { s.size }

pub fn image_feature_akaze_slice_get(s : ImagefeatureakazeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn image_feature_akaze_slice_set(s : ImagefeatureakazeSlice, i : Int, v : Double) -> ImagefeatureakazeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_slice_sum(s : ImagefeatureakazeSlice) -> Double { @_common.sum(s.data) }

pub fn image_feature_akaze_slice_mean(s : ImagefeatureakazeSlice) -> Double { @_common.mean(s.data) }

pub fn image_feature_akaze_slice_scale(s : ImagefeatureakazeSlice, f : Double) -> ImagefeatureakazeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_slice_add(a : ImagefeatureakazeSlice, b : ImagefeatureakazeSlice) -> ImagefeatureakazeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn image_feature_akaze_slice_copy(s : ImagefeatureakazeSlice) -> ImagefeatureakazeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_slice_fill(s : ImagefeatureakazeSlice, v : Double) -> ImagefeatureakazeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn image_feature_akaze_slice_min(s : ImagefeatureakazeSlice) -> Double { @_common.min(s.data) }

pub fn image_feature_akaze_slice_max(s : ImagefeatureakazeSlice) -> Double { @_common.max(s.data) }

pub fn image_feature_akaze_slice_to_string(s : ImagefeatureakazeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

