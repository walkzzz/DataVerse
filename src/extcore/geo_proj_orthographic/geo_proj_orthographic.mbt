///===
/// extcore/geo_proj_orthographic

pub(all) struct GeoprojorthographicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_orthographic_make_point(x : Double, y : Double) -> GeoprojorthographicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_orthographic_make_point3(x : Double, y : Double, z : Double) -> GeoprojorthographicPoint {
  { x, y, z, label: 0 }
}

pub fn geo_proj_orthographic_point_x(pt : GeoprojorthographicPoint) -> Double { pt.x }

pub fn geo_proj_orthographic_point_y(pt : GeoprojorthographicPoint) -> Double { pt.y }

pub fn geo_proj_orthographic_point_z(pt : GeoprojorthographicPoint) -> Double { pt.z }

pub fn geo_proj_orthographic_point_label(pt : GeoprojorthographicPoint) -> Int { pt.label }

pub fn geo_proj_orthographic_point_dist(a : GeoprojorthographicPoint, b : GeoprojorthographicPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_proj_orthographic_point_add(a : GeoprojorthographicPoint, b : GeoprojorthographicPoint) -> GeoprojorthographicPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_proj_orthographic_point_sub(a : GeoprojorthographicPoint, b : GeoprojorthographicPoint) -> GeoprojorthographicPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_proj_orthographic_point_scale(pt : GeoprojorthographicPoint, s : Double) -> GeoprojorthographicPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_proj_orthographic_point_dot(a : GeoprojorthographicPoint, b : GeoprojorthographicPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_proj_orthographic_point_cross(a : GeoprojorthographicPoint, b : GeoprojorthographicPoint) -> GeoprojorthographicPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_proj_orthographic_point_norm(pt : GeoprojorthographicPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_proj_orthographic_point_normalize(pt : GeoprojorthographicPoint) -> GeoprojorthographicPoint {
  let n = geo_proj_orthographic_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_proj_orthographic_point_scale(pt, 1.0 / n) }
}

pub fn geo_proj_orthographic_point_negate(pt : GeoprojorthographicPoint) -> GeoprojorthographicPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_proj_orthographic_point_mid(a : GeoprojorthographicPoint, b : GeoprojorthographicPoint) -> GeoprojorthographicPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_proj_orthographic_point_lerp(a : GeoprojorthographicPoint, b : GeoprojorthographicPoint, t : Double) -> GeoprojorthographicPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_proj_orthographic_point_to_string(pt : GeoprojorthographicPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeoprojorthographicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_orthographic_make_series(vals : Array[Double], name : String) -> GeoprojorthographicSeries {
  { vals, name, meta: 0 }
}

pub fn geo_proj_orthographic_series_len(s : GeoprojorthographicSeries) -> Int { s.vals.length() }

pub fn geo_proj_orthographic_series_sum(s : GeoprojorthographicSeries) -> Double { @_common.sum(s.vals) }

pub fn geo_proj_orthographic_series_mean(s : GeoprojorthographicSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_proj_orthographic_series_min(s : GeoprojorthographicSeries) -> Double { @_common.min(s.vals) }

pub fn geo_proj_orthographic_series_max(s : GeoprojorthographicSeries) -> Double { @_common.max(s.vals) }

pub fn geo_proj_orthographic_series_range(s : GeoprojorthographicSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_proj_orthographic_series_var(s : GeoprojorthographicSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_proj_orthographic_series_std(s : GeoprojorthographicSeries) -> Double { @_common.std(s.vals) }

pub fn geo_proj_orthographic_series_median(s : GeoprojorthographicSeries) -> Double { @_common.median(s.vals) }

pub fn geo_proj_orthographic_series_scale(s : GeoprojorthographicSeries, f : Double) -> GeoprojorthographicSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn geo_proj_orthographic_series_add(a : GeoprojorthographicSeries, b : GeoprojorthographicSeries) -> GeoprojorthographicSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_proj_orthographic_series_sub(a : GeoprojorthographicSeries, b : GeoprojorthographicSeries) -> GeoprojorthographicSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_proj_orthographic_series_normalize(s : GeoprojorthographicSeries) -> GeoprojorthographicSeries {
  let mn = geo_proj_orthographic_series_min(s)
  let mx = geo_proj_orthographic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_proj_orthographic_series_cumsum(s : GeoprojorthographicSeries) -> GeoprojorthographicSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_proj_orthographic_series_to_string(s : GeoprojorthographicSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojorthographicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_orthographic_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojorthographicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_orthographic_matrix_identity(n : Int) -> GeoprojorthographicMatrix {
  let m = geo_proj_orthographic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_proj_orthographic_matrix_get(m : GeoprojorthographicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_proj_orthographic_matrix_transpose(m : GeoprojorthographicMatrix) -> GeoprojorthographicMatrix {
  let result = geo_proj_orthographic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_proj_orthographic_matrix_add(a : GeoprojorthographicMatrix, b : GeoprojorthographicMatrix) -> GeoprojorthographicMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_proj_orthographic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_proj_orthographic_matrix_scale(m : GeoprojorthographicMatrix, s : Double) -> GeoprojorthographicMatrix {
  let result = geo_proj_orthographic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_proj_orthographic_matrix_multiply(a : GeoprojorthographicMatrix, b : GeoprojorthographicMatrix) -> GeoprojorthographicMatrix {
  if a.cols != b.rows { return geo_proj_orthographic_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_proj_orthographic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_proj_orthographic_matrix_trace(m : GeoprojorthographicMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_proj_orthographic_matrix_det(m : GeoprojorthographicMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_proj_orthographic_matrix_norm(m : GeoprojorthographicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_proj_orthographic_matrix_to_string(m : GeoprojorthographicMatrix) -> String {
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

pub(all) struct GeoprojorthographicVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_orthographic_make_vector(comps : Array[Double]) -> GeoprojorthographicVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_orthographic_vector_zero(dim : Int) -> GeoprojorthographicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_proj_orthographic_vector_add(a : GeoprojorthographicVector, b : GeoprojorthographicVector) -> GeoprojorthographicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn geo_proj_orthographic_vector_sub(a : GeoprojorthographicVector, b : GeoprojorthographicVector) -> GeoprojorthographicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn geo_proj_orthographic_vector_scale(v : GeoprojorthographicVector, s : Double) -> GeoprojorthographicVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn geo_proj_orthographic_vector_dot(a : GeoprojorthographicVector, b : GeoprojorthographicVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_proj_orthographic_vector_norm(v : GeoprojorthographicVector) -> Double { @_common.sqrt(geo_proj_orthographic_vector_dot(v, v)) }

pub fn geo_proj_orthographic_vector_normalize(v : GeoprojorthographicVector) -> GeoprojorthographicVector {
  let n = geo_proj_orthographic_vector_norm(v)
  if n < 0.0000001 { v } else { geo_proj_orthographic_vector_scale(v, 1.0 / n) }
}

pub fn geo_proj_orthographic_vector_dist(a : GeoprojorthographicVector, b : GeoprojorthographicVector) -> Double {
  geo_proj_orthographic_vector_norm(geo_proj_orthographic_vector_sub(a, b))
}

pub fn geo_proj_orthographic_vector_to_string(v : GeoprojorthographicVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_orthographic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_proj_orthographic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_proj_orthographic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_proj_orthographic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_proj_orthographic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_proj_orthographic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_proj_orthographic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_proj_orthographic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_proj_orthographic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_proj_orthographic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_proj_orthographic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_proj_orthographic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_proj_orthographic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_proj_orthographic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_proj_orthographic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_proj_orthographic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_proj_orthographic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_proj_orthographic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_proj_orthographic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_proj_orthographic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_proj_orthographic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_proj_orthographic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_proj_orthographic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_proj_orthographic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_proj_orthographic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_proj_orthographic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_proj_orthographic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_proj_orthographic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_proj_orthographic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeoprojorthographicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_frame_make(size : Int) -> GeoprojorthographicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_orthographic_frame_len(s : GeoprojorthographicFrame) -> Int { s.size }

pub fn geo_proj_orthographic_frame_get(s : GeoprojorthographicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_orthographic_frame_set(s : GeoprojorthographicFrame, i : Int, v : Double) -> GeoprojorthographicFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_frame_sum(s : GeoprojorthographicFrame) -> Double { @_common.sum(s.data) }

pub fn geo_proj_orthographic_frame_mean(s : GeoprojorthographicFrame) -> Double { @_common.mean(s.data) }

pub fn geo_proj_orthographic_frame_scale(s : GeoprojorthographicFrame, f : Double) -> GeoprojorthographicFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_frame_add(a : GeoprojorthographicFrame, b : GeoprojorthographicFrame) -> GeoprojorthographicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_orthographic_frame_copy(s : GeoprojorthographicFrame) -> GeoprojorthographicFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_frame_fill(s : GeoprojorthographicFrame, v : Double) -> GeoprojorthographicFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_frame_min(s : GeoprojorthographicFrame) -> Double { @_common.min(s.data) }

pub fn geo_proj_orthographic_frame_max(s : GeoprojorthographicFrame) -> Double { @_common.max(s.data) }

pub fn geo_proj_orthographic_frame_to_string(s : GeoprojorthographicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_table_make(size : Int) -> GeoprojorthographicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_orthographic_table_len(s : GeoprojorthographicTable) -> Int { s.size }

pub fn geo_proj_orthographic_table_get(s : GeoprojorthographicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_orthographic_table_set(s : GeoprojorthographicTable, i : Int, v : Double) -> GeoprojorthographicTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_table_sum(s : GeoprojorthographicTable) -> Double { @_common.sum(s.data) }

pub fn geo_proj_orthographic_table_mean(s : GeoprojorthographicTable) -> Double { @_common.mean(s.data) }

pub fn geo_proj_orthographic_table_scale(s : GeoprojorthographicTable, f : Double) -> GeoprojorthographicTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_table_add(a : GeoprojorthographicTable, b : GeoprojorthographicTable) -> GeoprojorthographicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_orthographic_table_copy(s : GeoprojorthographicTable) -> GeoprojorthographicTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_table_fill(s : GeoprojorthographicTable, v : Double) -> GeoprojorthographicTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_table_min(s : GeoprojorthographicTable) -> Double { @_common.min(s.data) }

pub fn geo_proj_orthographic_table_max(s : GeoprojorthographicTable) -> Double { @_common.max(s.data) }

pub fn geo_proj_orthographic_table_to_string(s : GeoprojorthographicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_graphn_make(size : Int) -> GeoprojorthographicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_orthographic_graphn_len(s : GeoprojorthographicGraphN) -> Int { s.size }

pub fn geo_proj_orthographic_graphn_get(s : GeoprojorthographicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_orthographic_graphn_set(s : GeoprojorthographicGraphN, i : Int, v : Double) -> GeoprojorthographicGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_graphn_sum(s : GeoprojorthographicGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_proj_orthographic_graphn_mean(s : GeoprojorthographicGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_proj_orthographic_graphn_scale(s : GeoprojorthographicGraphN, f : Double) -> GeoprojorthographicGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_graphn_add(a : GeoprojorthographicGraphN, b : GeoprojorthographicGraphN) -> GeoprojorthographicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_orthographic_graphn_copy(s : GeoprojorthographicGraphN) -> GeoprojorthographicGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_graphn_fill(s : GeoprojorthographicGraphN, v : Double) -> GeoprojorthographicGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_graphn_min(s : GeoprojorthographicGraphN) -> Double { @_common.min(s.data) }

pub fn geo_proj_orthographic_graphn_max(s : GeoprojorthographicGraphN) -> Double { @_common.max(s.data) }

pub fn geo_proj_orthographic_graphn_to_string(s : GeoprojorthographicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_node_make(size : Int) -> GeoprojorthographicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_orthographic_node_len(s : GeoprojorthographicNode) -> Int { s.size }

pub fn geo_proj_orthographic_node_get(s : GeoprojorthographicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_orthographic_node_set(s : GeoprojorthographicNode, i : Int, v : Double) -> GeoprojorthographicNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_node_sum(s : GeoprojorthographicNode) -> Double { @_common.sum(s.data) }

pub fn geo_proj_orthographic_node_mean(s : GeoprojorthographicNode) -> Double { @_common.mean(s.data) }

pub fn geo_proj_orthographic_node_scale(s : GeoprojorthographicNode, f : Double) -> GeoprojorthographicNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_node_add(a : GeoprojorthographicNode, b : GeoprojorthographicNode) -> GeoprojorthographicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_orthographic_node_copy(s : GeoprojorthographicNode) -> GeoprojorthographicNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_node_fill(s : GeoprojorthographicNode, v : Double) -> GeoprojorthographicNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_node_min(s : GeoprojorthographicNode) -> Double { @_common.min(s.data) }

pub fn geo_proj_orthographic_node_max(s : GeoprojorthographicNode) -> Double { @_common.max(s.data) }

pub fn geo_proj_orthographic_node_to_string(s : GeoprojorthographicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_edge_make(size : Int) -> GeoprojorthographicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_orthographic_edge_len(s : GeoprojorthographicEdge) -> Int { s.size }

pub fn geo_proj_orthographic_edge_get(s : GeoprojorthographicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_orthographic_edge_set(s : GeoprojorthographicEdge, i : Int, v : Double) -> GeoprojorthographicEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_edge_sum(s : GeoprojorthographicEdge) -> Double { @_common.sum(s.data) }

pub fn geo_proj_orthographic_edge_mean(s : GeoprojorthographicEdge) -> Double { @_common.mean(s.data) }

pub fn geo_proj_orthographic_edge_scale(s : GeoprojorthographicEdge, f : Double) -> GeoprojorthographicEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_edge_add(a : GeoprojorthographicEdge, b : GeoprojorthographicEdge) -> GeoprojorthographicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_orthographic_edge_copy(s : GeoprojorthographicEdge) -> GeoprojorthographicEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_edge_fill(s : GeoprojorthographicEdge, v : Double) -> GeoprojorthographicEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_edge_min(s : GeoprojorthographicEdge) -> Double { @_common.min(s.data) }

pub fn geo_proj_orthographic_edge_max(s : GeoprojorthographicEdge) -> Double { @_common.max(s.data) }

pub fn geo_proj_orthographic_edge_to_string(s : GeoprojorthographicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_path_make(size : Int) -> GeoprojorthographicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_orthographic_path_len(s : GeoprojorthographicPath) -> Int { s.size }

pub fn geo_proj_orthographic_path_get(s : GeoprojorthographicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_orthographic_path_set(s : GeoprojorthographicPath, i : Int, v : Double) -> GeoprojorthographicPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_path_sum(s : GeoprojorthographicPath) -> Double { @_common.sum(s.data) }

pub fn geo_proj_orthographic_path_mean(s : GeoprojorthographicPath) -> Double { @_common.mean(s.data) }

pub fn geo_proj_orthographic_path_scale(s : GeoprojorthographicPath, f : Double) -> GeoprojorthographicPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_path_add(a : GeoprojorthographicPath, b : GeoprojorthographicPath) -> GeoprojorthographicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_orthographic_path_copy(s : GeoprojorthographicPath) -> GeoprojorthographicPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_path_fill(s : GeoprojorthographicPath, v : Double) -> GeoprojorthographicPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_path_min(s : GeoprojorthographicPath) -> Double { @_common.min(s.data) }

pub fn geo_proj_orthographic_path_max(s : GeoprojorthographicPath) -> Double { @_common.max(s.data) }

pub fn geo_proj_orthographic_path_to_string(s : GeoprojorthographicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_cluster_make(size : Int) -> GeoprojorthographicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_orthographic_cluster_len(s : GeoprojorthographicCluster) -> Int { s.size }

pub fn geo_proj_orthographic_cluster_get(s : GeoprojorthographicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_orthographic_cluster_set(s : GeoprojorthographicCluster, i : Int, v : Double) -> GeoprojorthographicCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_cluster_sum(s : GeoprojorthographicCluster) -> Double { @_common.sum(s.data) }

pub fn geo_proj_orthographic_cluster_mean(s : GeoprojorthographicCluster) -> Double { @_common.mean(s.data) }

pub fn geo_proj_orthographic_cluster_scale(s : GeoprojorthographicCluster, f : Double) -> GeoprojorthographicCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_cluster_add(a : GeoprojorthographicCluster, b : GeoprojorthographicCluster) -> GeoprojorthographicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_orthographic_cluster_copy(s : GeoprojorthographicCluster) -> GeoprojorthographicCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_cluster_fill(s : GeoprojorthographicCluster, v : Double) -> GeoprojorthographicCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_cluster_min(s : GeoprojorthographicCluster) -> Double { @_common.min(s.data) }

pub fn geo_proj_orthographic_cluster_max(s : GeoprojorthographicCluster) -> Double { @_common.max(s.data) }

pub fn geo_proj_orthographic_cluster_to_string(s : GeoprojorthographicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_model_make(size : Int) -> GeoprojorthographicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_orthographic_model_len(s : GeoprojorthographicModel) -> Int { s.size }

pub fn geo_proj_orthographic_model_get(s : GeoprojorthographicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_orthographic_model_set(s : GeoprojorthographicModel, i : Int, v : Double) -> GeoprojorthographicModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_model_sum(s : GeoprojorthographicModel) -> Double { @_common.sum(s.data) }

pub fn geo_proj_orthographic_model_mean(s : GeoprojorthographicModel) -> Double { @_common.mean(s.data) }

pub fn geo_proj_orthographic_model_scale(s : GeoprojorthographicModel, f : Double) -> GeoprojorthographicModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_model_add(a : GeoprojorthographicModel, b : GeoprojorthographicModel) -> GeoprojorthographicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_orthographic_model_copy(s : GeoprojorthographicModel) -> GeoprojorthographicModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_model_fill(s : GeoprojorthographicModel, v : Double) -> GeoprojorthographicModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_model_min(s : GeoprojorthographicModel) -> Double { @_common.min(s.data) }

pub fn geo_proj_orthographic_model_max(s : GeoprojorthographicModel) -> Double { @_common.max(s.data) }

pub fn geo_proj_orthographic_model_to_string(s : GeoprojorthographicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_layer_make(size : Int) -> GeoprojorthographicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_orthographic_layer_len(s : GeoprojorthographicLayer) -> Int { s.size }

pub fn geo_proj_orthographic_layer_get(s : GeoprojorthographicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_orthographic_layer_set(s : GeoprojorthographicLayer, i : Int, v : Double) -> GeoprojorthographicLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_layer_sum(s : GeoprojorthographicLayer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_orthographic_layer_mean(s : GeoprojorthographicLayer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_orthographic_layer_scale(s : GeoprojorthographicLayer, f : Double) -> GeoprojorthographicLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_layer_add(a : GeoprojorthographicLayer, b : GeoprojorthographicLayer) -> GeoprojorthographicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_orthographic_layer_copy(s : GeoprojorthographicLayer) -> GeoprojorthographicLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_layer_fill(s : GeoprojorthographicLayer, v : Double) -> GeoprojorthographicLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_layer_min(s : GeoprojorthographicLayer) -> Double { @_common.min(s.data) }

pub fn geo_proj_orthographic_layer_max(s : GeoprojorthographicLayer) -> Double { @_common.max(s.data) }

pub fn geo_proj_orthographic_layer_to_string(s : GeoprojorthographicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_buffer_make(size : Int) -> GeoprojorthographicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_orthographic_buffer_len(s : GeoprojorthographicBuffer) -> Int { s.size }

pub fn geo_proj_orthographic_buffer_get(s : GeoprojorthographicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_orthographic_buffer_set(s : GeoprojorthographicBuffer, i : Int, v : Double) -> GeoprojorthographicBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_buffer_sum(s : GeoprojorthographicBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_orthographic_buffer_mean(s : GeoprojorthographicBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_orthographic_buffer_scale(s : GeoprojorthographicBuffer, f : Double) -> GeoprojorthographicBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_buffer_add(a : GeoprojorthographicBuffer, b : GeoprojorthographicBuffer) -> GeoprojorthographicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_orthographic_buffer_copy(s : GeoprojorthographicBuffer) -> GeoprojorthographicBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_buffer_fill(s : GeoprojorthographicBuffer, v : Double) -> GeoprojorthographicBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_buffer_min(s : GeoprojorthographicBuffer) -> Double { @_common.min(s.data) }

pub fn geo_proj_orthographic_buffer_max(s : GeoprojorthographicBuffer) -> Double { @_common.max(s.data) }

pub fn geo_proj_orthographic_buffer_to_string(s : GeoprojorthographicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_cursor_make(size : Int) -> GeoprojorthographicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_orthographic_cursor_len(s : GeoprojorthographicCursor) -> Int { s.size }

pub fn geo_proj_orthographic_cursor_get(s : GeoprojorthographicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_orthographic_cursor_set(s : GeoprojorthographicCursor, i : Int, v : Double) -> GeoprojorthographicCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_cursor_sum(s : GeoprojorthographicCursor) -> Double { @_common.sum(s.data) }

pub fn geo_proj_orthographic_cursor_mean(s : GeoprojorthographicCursor) -> Double { @_common.mean(s.data) }

pub fn geo_proj_orthographic_cursor_scale(s : GeoprojorthographicCursor, f : Double) -> GeoprojorthographicCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_cursor_add(a : GeoprojorthographicCursor, b : GeoprojorthographicCursor) -> GeoprojorthographicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_orthographic_cursor_copy(s : GeoprojorthographicCursor) -> GeoprojorthographicCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_cursor_fill(s : GeoprojorthographicCursor, v : Double) -> GeoprojorthographicCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_cursor_min(s : GeoprojorthographicCursor) -> Double { @_common.min(s.data) }

pub fn geo_proj_orthographic_cursor_max(s : GeoprojorthographicCursor) -> Double { @_common.max(s.data) }

pub fn geo_proj_orthographic_cursor_to_string(s : GeoprojorthographicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_view_make(size : Int) -> GeoprojorthographicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_orthographic_view_len(s : GeoprojorthographicView) -> Int { s.size }

pub fn geo_proj_orthographic_view_get(s : GeoprojorthographicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_orthographic_view_set(s : GeoprojorthographicView, i : Int, v : Double) -> GeoprojorthographicView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_view_sum(s : GeoprojorthographicView) -> Double { @_common.sum(s.data) }

pub fn geo_proj_orthographic_view_mean(s : GeoprojorthographicView) -> Double { @_common.mean(s.data) }

pub fn geo_proj_orthographic_view_scale(s : GeoprojorthographicView, f : Double) -> GeoprojorthographicView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_view_add(a : GeoprojorthographicView, b : GeoprojorthographicView) -> GeoprojorthographicView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_orthographic_view_copy(s : GeoprojorthographicView) -> GeoprojorthographicView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_view_fill(s : GeoprojorthographicView, v : Double) -> GeoprojorthographicView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_view_min(s : GeoprojorthographicView) -> Double { @_common.min(s.data) }

pub fn geo_proj_orthographic_view_max(s : GeoprojorthographicView) -> Double { @_common.max(s.data) }

pub fn geo_proj_orthographic_view_to_string(s : GeoprojorthographicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_range_make(size : Int) -> GeoprojorthographicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_orthographic_range_len(s : GeoprojorthographicRange) -> Int { s.size }

pub fn geo_proj_orthographic_range_get(s : GeoprojorthographicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_orthographic_range_set(s : GeoprojorthographicRange, i : Int, v : Double) -> GeoprojorthographicRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_range_sum(s : GeoprojorthographicRange) -> Double { @_common.sum(s.data) }

pub fn geo_proj_orthographic_range_mean(s : GeoprojorthographicRange) -> Double { @_common.mean(s.data) }

pub fn geo_proj_orthographic_range_scale(s : GeoprojorthographicRange, f : Double) -> GeoprojorthographicRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_range_add(a : GeoprojorthographicRange, b : GeoprojorthographicRange) -> GeoprojorthographicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_orthographic_range_copy(s : GeoprojorthographicRange) -> GeoprojorthographicRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_range_fill(s : GeoprojorthographicRange, v : Double) -> GeoprojorthographicRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_range_min(s : GeoprojorthographicRange) -> Double { @_common.min(s.data) }

pub fn geo_proj_orthographic_range_max(s : GeoprojorthographicRange) -> Double { @_common.max(s.data) }

pub fn geo_proj_orthographic_range_to_string(s : GeoprojorthographicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojorthographicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_orthographic_slice_make(size : Int) -> GeoprojorthographicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_orthographic_slice_len(s : GeoprojorthographicSlice) -> Int { s.size }

pub fn geo_proj_orthographic_slice_get(s : GeoprojorthographicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_orthographic_slice_set(s : GeoprojorthographicSlice, i : Int, v : Double) -> GeoprojorthographicSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_slice_sum(s : GeoprojorthographicSlice) -> Double { @_common.sum(s.data) }

pub fn geo_proj_orthographic_slice_mean(s : GeoprojorthographicSlice) -> Double { @_common.mean(s.data) }

pub fn geo_proj_orthographic_slice_scale(s : GeoprojorthographicSlice, f : Double) -> GeoprojorthographicSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_slice_add(a : GeoprojorthographicSlice, b : GeoprojorthographicSlice) -> GeoprojorthographicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_orthographic_slice_copy(s : GeoprojorthographicSlice) -> GeoprojorthographicSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_slice_fill(s : GeoprojorthographicSlice, v : Double) -> GeoprojorthographicSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_orthographic_slice_min(s : GeoprojorthographicSlice) -> Double { @_common.min(s.data) }

pub fn geo_proj_orthographic_slice_max(s : GeoprojorthographicSlice) -> Double { @_common.max(s.data) }

pub fn geo_proj_orthographic_slice_to_string(s : GeoprojorthographicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

