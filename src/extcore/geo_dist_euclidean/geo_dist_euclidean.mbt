///===
/// extcore/geo_dist_euclidean

pub(all) struct GeodisteuclideanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_euclidean_make_point(x : Double, y : Double) -> GeodisteuclideanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_euclidean_make_point3(x : Double, y : Double, z : Double) -> GeodisteuclideanPoint {
  { x, y, z, label: 0 }
}

pub fn geo_dist_euclidean_point_x(pt : GeodisteuclideanPoint) -> Double { pt.x }

pub fn geo_dist_euclidean_point_y(pt : GeodisteuclideanPoint) -> Double { pt.y }

pub fn geo_dist_euclidean_point_z(pt : GeodisteuclideanPoint) -> Double { pt.z }

pub fn geo_dist_euclidean_point_label(pt : GeodisteuclideanPoint) -> Int { pt.label }

pub fn geo_dist_euclidean_point_dist(a : GeodisteuclideanPoint, b : GeodisteuclideanPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_dist_euclidean_point_add(a : GeodisteuclideanPoint, b : GeodisteuclideanPoint) -> GeodisteuclideanPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_dist_euclidean_point_sub(a : GeodisteuclideanPoint, b : GeodisteuclideanPoint) -> GeodisteuclideanPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_dist_euclidean_point_scale(pt : GeodisteuclideanPoint, s : Double) -> GeodisteuclideanPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_dist_euclidean_point_dot(a : GeodisteuclideanPoint, b : GeodisteuclideanPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_dist_euclidean_point_cross(a : GeodisteuclideanPoint, b : GeodisteuclideanPoint) -> GeodisteuclideanPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_dist_euclidean_point_norm(pt : GeodisteuclideanPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_dist_euclidean_point_normalize(pt : GeodisteuclideanPoint) -> GeodisteuclideanPoint {
  let n = geo_dist_euclidean_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_dist_euclidean_point_scale(pt, 1.0 / n) }
}

pub fn geo_dist_euclidean_point_negate(pt : GeodisteuclideanPoint) -> GeodisteuclideanPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_dist_euclidean_point_mid(a : GeodisteuclideanPoint, b : GeodisteuclideanPoint) -> GeodisteuclideanPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_dist_euclidean_point_lerp(a : GeodisteuclideanPoint, b : GeodisteuclideanPoint, t : Double) -> GeodisteuclideanPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_dist_euclidean_point_to_string(pt : GeodisteuclideanPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeodisteuclideanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_euclidean_make_series(vals : Array[Double], name : String) -> GeodisteuclideanSeries {
  { vals, name, meta: 0 }
}

pub fn geo_dist_euclidean_series_len(s : GeodisteuclideanSeries) -> Int { s.vals.length() }

pub fn geo_dist_euclidean_series_sum(s : GeodisteuclideanSeries) -> Double { @_common.sum(s.vals) }

pub fn geo_dist_euclidean_series_mean(s : GeodisteuclideanSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_dist_euclidean_series_min(s : GeodisteuclideanSeries) -> Double { @_common.min(s.vals) }

pub fn geo_dist_euclidean_series_max(s : GeodisteuclideanSeries) -> Double { @_common.max(s.vals) }

pub fn geo_dist_euclidean_series_range(s : GeodisteuclideanSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_dist_euclidean_series_var(s : GeodisteuclideanSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_dist_euclidean_series_std(s : GeodisteuclideanSeries) -> Double { @_common.std(s.vals) }

pub fn geo_dist_euclidean_series_median(s : GeodisteuclideanSeries) -> Double { @_common.median(s.vals) }

pub fn geo_dist_euclidean_series_scale(s : GeodisteuclideanSeries, f : Double) -> GeodisteuclideanSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn geo_dist_euclidean_series_add(a : GeodisteuclideanSeries, b : GeodisteuclideanSeries) -> GeodisteuclideanSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_dist_euclidean_series_sub(a : GeodisteuclideanSeries, b : GeodisteuclideanSeries) -> GeodisteuclideanSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_dist_euclidean_series_normalize(s : GeodisteuclideanSeries) -> GeodisteuclideanSeries {
  let mn = geo_dist_euclidean_series_min(s)
  let mx = geo_dist_euclidean_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_dist_euclidean_series_cumsum(s : GeodisteuclideanSeries) -> GeodisteuclideanSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_dist_euclidean_series_to_string(s : GeodisteuclideanSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodisteuclideanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_euclidean_make_matrix(rows : Int, cols : Int, val : Double) -> GeodisteuclideanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_euclidean_matrix_identity(n : Int) -> GeodisteuclideanMatrix {
  let m = geo_dist_euclidean_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_dist_euclidean_matrix_get(m : GeodisteuclideanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_dist_euclidean_matrix_transpose(m : GeodisteuclideanMatrix) -> GeodisteuclideanMatrix {
  let result = geo_dist_euclidean_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_dist_euclidean_matrix_add(a : GeodisteuclideanMatrix, b : GeodisteuclideanMatrix) -> GeodisteuclideanMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_dist_euclidean_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_dist_euclidean_matrix_scale(m : GeodisteuclideanMatrix, s : Double) -> GeodisteuclideanMatrix {
  let result = geo_dist_euclidean_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_dist_euclidean_matrix_multiply(a : GeodisteuclideanMatrix, b : GeodisteuclideanMatrix) -> GeodisteuclideanMatrix {
  if a.cols != b.rows { return geo_dist_euclidean_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_dist_euclidean_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_dist_euclidean_matrix_trace(m : GeodisteuclideanMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_dist_euclidean_matrix_det(m : GeodisteuclideanMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_dist_euclidean_matrix_norm(m : GeodisteuclideanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_dist_euclidean_matrix_to_string(m : GeodisteuclideanMatrix) -> String {
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

pub(all) struct GeodisteuclideanVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_euclidean_make_vector(comps : Array[Double]) -> GeodisteuclideanVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_euclidean_vector_zero(dim : Int) -> GeodisteuclideanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_dist_euclidean_vector_add(a : GeodisteuclideanVector, b : GeodisteuclideanVector) -> GeodisteuclideanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn geo_dist_euclidean_vector_sub(a : GeodisteuclideanVector, b : GeodisteuclideanVector) -> GeodisteuclideanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn geo_dist_euclidean_vector_scale(v : GeodisteuclideanVector, s : Double) -> GeodisteuclideanVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn geo_dist_euclidean_vector_dot(a : GeodisteuclideanVector, b : GeodisteuclideanVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_dist_euclidean_vector_norm(v : GeodisteuclideanVector) -> Double { @_common.sqrt(geo_dist_euclidean_vector_dot(v, v)) }

pub fn geo_dist_euclidean_vector_normalize(v : GeodisteuclideanVector) -> GeodisteuclideanVector {
  let n = geo_dist_euclidean_vector_norm(v)
  if n < 0.0000001 { v } else { geo_dist_euclidean_vector_scale(v, 1.0 / n) }
}

pub fn geo_dist_euclidean_vector_dist(a : GeodisteuclideanVector, b : GeodisteuclideanVector) -> Double {
  geo_dist_euclidean_vector_norm(geo_dist_euclidean_vector_sub(a, b))
}

pub fn geo_dist_euclidean_vector_to_string(v : GeodisteuclideanVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_euclidean_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_dist_euclidean_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_dist_euclidean_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_dist_euclidean_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_dist_euclidean_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_dist_euclidean_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_dist_euclidean_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_dist_euclidean_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_dist_euclidean_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_dist_euclidean_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_dist_euclidean_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_dist_euclidean_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_dist_euclidean_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_dist_euclidean_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_dist_euclidean_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_dist_euclidean_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_dist_euclidean_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_dist_euclidean_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_dist_euclidean_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_dist_euclidean_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_dist_euclidean_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_dist_euclidean_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_dist_euclidean_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_dist_euclidean_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_dist_euclidean_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_dist_euclidean_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_dist_euclidean_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_dist_euclidean_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_dist_euclidean_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeodisteuclideanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_frame_make(size : Int) -> GeodisteuclideanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_frame_len(s : GeodisteuclideanFrame) -> Int { s.size }

pub fn geo_dist_euclidean_frame_get(s : GeodisteuclideanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_frame_set(s : GeodisteuclideanFrame, i : Int, v : Double) -> GeodisteuclideanFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_frame_sum(s : GeodisteuclideanFrame) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_frame_mean(s : GeodisteuclideanFrame) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_frame_scale(s : GeodisteuclideanFrame, f : Double) -> GeodisteuclideanFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_frame_add(a : GeodisteuclideanFrame, b : GeodisteuclideanFrame) -> GeodisteuclideanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_frame_copy(s : GeodisteuclideanFrame) -> GeodisteuclideanFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_frame_fill(s : GeodisteuclideanFrame, v : Double) -> GeodisteuclideanFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_frame_min(s : GeodisteuclideanFrame) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_frame_max(s : GeodisteuclideanFrame) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_frame_to_string(s : GeodisteuclideanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_table_make(size : Int) -> GeodisteuclideanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_table_len(s : GeodisteuclideanTable) -> Int { s.size }

pub fn geo_dist_euclidean_table_get(s : GeodisteuclideanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_table_set(s : GeodisteuclideanTable, i : Int, v : Double) -> GeodisteuclideanTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_table_sum(s : GeodisteuclideanTable) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_table_mean(s : GeodisteuclideanTable) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_table_scale(s : GeodisteuclideanTable, f : Double) -> GeodisteuclideanTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_table_add(a : GeodisteuclideanTable, b : GeodisteuclideanTable) -> GeodisteuclideanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_table_copy(s : GeodisteuclideanTable) -> GeodisteuclideanTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_table_fill(s : GeodisteuclideanTable, v : Double) -> GeodisteuclideanTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_table_min(s : GeodisteuclideanTable) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_table_max(s : GeodisteuclideanTable) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_table_to_string(s : GeodisteuclideanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_graphn_make(size : Int) -> GeodisteuclideanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_graphn_len(s : GeodisteuclideanGraphN) -> Int { s.size }

pub fn geo_dist_euclidean_graphn_get(s : GeodisteuclideanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_graphn_set(s : GeodisteuclideanGraphN, i : Int, v : Double) -> GeodisteuclideanGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_graphn_sum(s : GeodisteuclideanGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_graphn_mean(s : GeodisteuclideanGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_graphn_scale(s : GeodisteuclideanGraphN, f : Double) -> GeodisteuclideanGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_graphn_add(a : GeodisteuclideanGraphN, b : GeodisteuclideanGraphN) -> GeodisteuclideanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_graphn_copy(s : GeodisteuclideanGraphN) -> GeodisteuclideanGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_graphn_fill(s : GeodisteuclideanGraphN, v : Double) -> GeodisteuclideanGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_graphn_min(s : GeodisteuclideanGraphN) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_graphn_max(s : GeodisteuclideanGraphN) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_graphn_to_string(s : GeodisteuclideanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_node_make(size : Int) -> GeodisteuclideanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_node_len(s : GeodisteuclideanNode) -> Int { s.size }

pub fn geo_dist_euclidean_node_get(s : GeodisteuclideanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_node_set(s : GeodisteuclideanNode, i : Int, v : Double) -> GeodisteuclideanNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_node_sum(s : GeodisteuclideanNode) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_node_mean(s : GeodisteuclideanNode) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_node_scale(s : GeodisteuclideanNode, f : Double) -> GeodisteuclideanNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_node_add(a : GeodisteuclideanNode, b : GeodisteuclideanNode) -> GeodisteuclideanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_node_copy(s : GeodisteuclideanNode) -> GeodisteuclideanNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_node_fill(s : GeodisteuclideanNode, v : Double) -> GeodisteuclideanNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_node_min(s : GeodisteuclideanNode) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_node_max(s : GeodisteuclideanNode) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_node_to_string(s : GeodisteuclideanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_edge_make(size : Int) -> GeodisteuclideanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_edge_len(s : GeodisteuclideanEdge) -> Int { s.size }

pub fn geo_dist_euclidean_edge_get(s : GeodisteuclideanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_edge_set(s : GeodisteuclideanEdge, i : Int, v : Double) -> GeodisteuclideanEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_edge_sum(s : GeodisteuclideanEdge) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_edge_mean(s : GeodisteuclideanEdge) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_edge_scale(s : GeodisteuclideanEdge, f : Double) -> GeodisteuclideanEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_edge_add(a : GeodisteuclideanEdge, b : GeodisteuclideanEdge) -> GeodisteuclideanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_edge_copy(s : GeodisteuclideanEdge) -> GeodisteuclideanEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_edge_fill(s : GeodisteuclideanEdge, v : Double) -> GeodisteuclideanEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_edge_min(s : GeodisteuclideanEdge) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_edge_max(s : GeodisteuclideanEdge) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_edge_to_string(s : GeodisteuclideanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_path_make(size : Int) -> GeodisteuclideanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_path_len(s : GeodisteuclideanPath) -> Int { s.size }

pub fn geo_dist_euclidean_path_get(s : GeodisteuclideanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_path_set(s : GeodisteuclideanPath, i : Int, v : Double) -> GeodisteuclideanPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_path_sum(s : GeodisteuclideanPath) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_path_mean(s : GeodisteuclideanPath) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_path_scale(s : GeodisteuclideanPath, f : Double) -> GeodisteuclideanPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_path_add(a : GeodisteuclideanPath, b : GeodisteuclideanPath) -> GeodisteuclideanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_path_copy(s : GeodisteuclideanPath) -> GeodisteuclideanPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_path_fill(s : GeodisteuclideanPath, v : Double) -> GeodisteuclideanPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_path_min(s : GeodisteuclideanPath) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_path_max(s : GeodisteuclideanPath) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_path_to_string(s : GeodisteuclideanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_cluster_make(size : Int) -> GeodisteuclideanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_cluster_len(s : GeodisteuclideanCluster) -> Int { s.size }

pub fn geo_dist_euclidean_cluster_get(s : GeodisteuclideanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_cluster_set(s : GeodisteuclideanCluster, i : Int, v : Double) -> GeodisteuclideanCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_cluster_sum(s : GeodisteuclideanCluster) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_cluster_mean(s : GeodisteuclideanCluster) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_cluster_scale(s : GeodisteuclideanCluster, f : Double) -> GeodisteuclideanCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_cluster_add(a : GeodisteuclideanCluster, b : GeodisteuclideanCluster) -> GeodisteuclideanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_cluster_copy(s : GeodisteuclideanCluster) -> GeodisteuclideanCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_cluster_fill(s : GeodisteuclideanCluster, v : Double) -> GeodisteuclideanCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_cluster_min(s : GeodisteuclideanCluster) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_cluster_max(s : GeodisteuclideanCluster) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_cluster_to_string(s : GeodisteuclideanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_model_make(size : Int) -> GeodisteuclideanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_model_len(s : GeodisteuclideanModel) -> Int { s.size }

pub fn geo_dist_euclidean_model_get(s : GeodisteuclideanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_model_set(s : GeodisteuclideanModel, i : Int, v : Double) -> GeodisteuclideanModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_model_sum(s : GeodisteuclideanModel) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_model_mean(s : GeodisteuclideanModel) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_model_scale(s : GeodisteuclideanModel, f : Double) -> GeodisteuclideanModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_model_add(a : GeodisteuclideanModel, b : GeodisteuclideanModel) -> GeodisteuclideanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_model_copy(s : GeodisteuclideanModel) -> GeodisteuclideanModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_model_fill(s : GeodisteuclideanModel, v : Double) -> GeodisteuclideanModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_model_min(s : GeodisteuclideanModel) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_model_max(s : GeodisteuclideanModel) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_model_to_string(s : GeodisteuclideanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_layer_make(size : Int) -> GeodisteuclideanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_layer_len(s : GeodisteuclideanLayer) -> Int { s.size }

pub fn geo_dist_euclidean_layer_get(s : GeodisteuclideanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_layer_set(s : GeodisteuclideanLayer, i : Int, v : Double) -> GeodisteuclideanLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_layer_sum(s : GeodisteuclideanLayer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_layer_mean(s : GeodisteuclideanLayer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_layer_scale(s : GeodisteuclideanLayer, f : Double) -> GeodisteuclideanLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_layer_add(a : GeodisteuclideanLayer, b : GeodisteuclideanLayer) -> GeodisteuclideanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_layer_copy(s : GeodisteuclideanLayer) -> GeodisteuclideanLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_layer_fill(s : GeodisteuclideanLayer, v : Double) -> GeodisteuclideanLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_layer_min(s : GeodisteuclideanLayer) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_layer_max(s : GeodisteuclideanLayer) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_layer_to_string(s : GeodisteuclideanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_buffer_make(size : Int) -> GeodisteuclideanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_buffer_len(s : GeodisteuclideanBuffer) -> Int { s.size }

pub fn geo_dist_euclidean_buffer_get(s : GeodisteuclideanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_buffer_set(s : GeodisteuclideanBuffer, i : Int, v : Double) -> GeodisteuclideanBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_buffer_sum(s : GeodisteuclideanBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_buffer_mean(s : GeodisteuclideanBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_buffer_scale(s : GeodisteuclideanBuffer, f : Double) -> GeodisteuclideanBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_buffer_add(a : GeodisteuclideanBuffer, b : GeodisteuclideanBuffer) -> GeodisteuclideanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_buffer_copy(s : GeodisteuclideanBuffer) -> GeodisteuclideanBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_buffer_fill(s : GeodisteuclideanBuffer, v : Double) -> GeodisteuclideanBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_buffer_min(s : GeodisteuclideanBuffer) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_buffer_max(s : GeodisteuclideanBuffer) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_buffer_to_string(s : GeodisteuclideanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_cursor_make(size : Int) -> GeodisteuclideanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_cursor_len(s : GeodisteuclideanCursor) -> Int { s.size }

pub fn geo_dist_euclidean_cursor_get(s : GeodisteuclideanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_cursor_set(s : GeodisteuclideanCursor, i : Int, v : Double) -> GeodisteuclideanCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_cursor_sum(s : GeodisteuclideanCursor) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_cursor_mean(s : GeodisteuclideanCursor) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_cursor_scale(s : GeodisteuclideanCursor, f : Double) -> GeodisteuclideanCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_cursor_add(a : GeodisteuclideanCursor, b : GeodisteuclideanCursor) -> GeodisteuclideanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_cursor_copy(s : GeodisteuclideanCursor) -> GeodisteuclideanCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_cursor_fill(s : GeodisteuclideanCursor, v : Double) -> GeodisteuclideanCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_cursor_min(s : GeodisteuclideanCursor) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_cursor_max(s : GeodisteuclideanCursor) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_cursor_to_string(s : GeodisteuclideanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_view_make(size : Int) -> GeodisteuclideanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_view_len(s : GeodisteuclideanView) -> Int { s.size }

pub fn geo_dist_euclidean_view_get(s : GeodisteuclideanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_view_set(s : GeodisteuclideanView, i : Int, v : Double) -> GeodisteuclideanView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_view_sum(s : GeodisteuclideanView) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_view_mean(s : GeodisteuclideanView) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_view_scale(s : GeodisteuclideanView, f : Double) -> GeodisteuclideanView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_view_add(a : GeodisteuclideanView, b : GeodisteuclideanView) -> GeodisteuclideanView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_view_copy(s : GeodisteuclideanView) -> GeodisteuclideanView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_view_fill(s : GeodisteuclideanView, v : Double) -> GeodisteuclideanView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_view_min(s : GeodisteuclideanView) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_view_max(s : GeodisteuclideanView) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_view_to_string(s : GeodisteuclideanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_range_make(size : Int) -> GeodisteuclideanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_range_len(s : GeodisteuclideanRange) -> Int { s.size }

pub fn geo_dist_euclidean_range_get(s : GeodisteuclideanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_range_set(s : GeodisteuclideanRange, i : Int, v : Double) -> GeodisteuclideanRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_range_sum(s : GeodisteuclideanRange) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_range_mean(s : GeodisteuclideanRange) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_range_scale(s : GeodisteuclideanRange, f : Double) -> GeodisteuclideanRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_range_add(a : GeodisteuclideanRange, b : GeodisteuclideanRange) -> GeodisteuclideanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_range_copy(s : GeodisteuclideanRange) -> GeodisteuclideanRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_range_fill(s : GeodisteuclideanRange, v : Double) -> GeodisteuclideanRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_range_min(s : GeodisteuclideanRange) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_range_max(s : GeodisteuclideanRange) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_range_to_string(s : GeodisteuclideanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisteuclideanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_euclidean_slice_make(size : Int) -> GeodisteuclideanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_euclidean_slice_len(s : GeodisteuclideanSlice) -> Int { s.size }

pub fn geo_dist_euclidean_slice_get(s : GeodisteuclideanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_euclidean_slice_set(s : GeodisteuclideanSlice, i : Int, v : Double) -> GeodisteuclideanSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_slice_sum(s : GeodisteuclideanSlice) -> Double { @_common.sum(s.data) }

pub fn geo_dist_euclidean_slice_mean(s : GeodisteuclideanSlice) -> Double { @_common.mean(s.data) }

pub fn geo_dist_euclidean_slice_scale(s : GeodisteuclideanSlice, f : Double) -> GeodisteuclideanSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_slice_add(a : GeodisteuclideanSlice, b : GeodisteuclideanSlice) -> GeodisteuclideanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_euclidean_slice_copy(s : GeodisteuclideanSlice) -> GeodisteuclideanSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_slice_fill(s : GeodisteuclideanSlice, v : Double) -> GeodisteuclideanSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_euclidean_slice_min(s : GeodisteuclideanSlice) -> Double { @_common.min(s.data) }

pub fn geo_dist_euclidean_slice_max(s : GeodisteuclideanSlice) -> Double { @_common.max(s.data) }

pub fn geo_dist_euclidean_slice_to_string(s : GeodisteuclideanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

