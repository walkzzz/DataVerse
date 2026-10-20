///===
/// extcore/geo_intersect_ellipse

pub(all) struct GeointersectellipsePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_ellipse_make_point(x : Double, y : Double) -> GeointersectellipsePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_ellipse_make_point3(x : Double, y : Double, z : Double) -> GeointersectellipsePoint {
  { x, y, z, label: 0 }
}

pub fn geo_intersect_ellipse_point_x(pt : GeointersectellipsePoint) -> Double { pt.x }

pub fn geo_intersect_ellipse_point_y(pt : GeointersectellipsePoint) -> Double { pt.y }

pub fn geo_intersect_ellipse_point_z(pt : GeointersectellipsePoint) -> Double { pt.z }

pub fn geo_intersect_ellipse_point_label(pt : GeointersectellipsePoint) -> Int { pt.label }

pub fn geo_intersect_ellipse_point_dist(a : GeointersectellipsePoint, b : GeointersectellipsePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_intersect_ellipse_point_add(a : GeointersectellipsePoint, b : GeointersectellipsePoint) -> GeointersectellipsePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_intersect_ellipse_point_sub(a : GeointersectellipsePoint, b : GeointersectellipsePoint) -> GeointersectellipsePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_intersect_ellipse_point_scale(pt : GeointersectellipsePoint, s : Double) -> GeointersectellipsePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_intersect_ellipse_point_dot(a : GeointersectellipsePoint, b : GeointersectellipsePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_intersect_ellipse_point_cross(a : GeointersectellipsePoint, b : GeointersectellipsePoint) -> GeointersectellipsePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_intersect_ellipse_point_norm(pt : GeointersectellipsePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_intersect_ellipse_point_normalize(pt : GeointersectellipsePoint) -> GeointersectellipsePoint {
  let n = geo_intersect_ellipse_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_intersect_ellipse_point_scale(pt, 1.0 / n) }
}

pub fn geo_intersect_ellipse_point_negate(pt : GeointersectellipsePoint) -> GeointersectellipsePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_intersect_ellipse_point_mid(a : GeointersectellipsePoint, b : GeointersectellipsePoint) -> GeointersectellipsePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_intersect_ellipse_point_lerp(a : GeointersectellipsePoint, b : GeointersectellipsePoint, t : Double) -> GeointersectellipsePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_intersect_ellipse_point_to_string(pt : GeointersectellipsePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeointersectellipseSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_ellipse_make_series(vals : Array[Double], name : String) -> GeointersectellipseSeries {
  { vals, name, meta: 0 }
}

pub fn geo_intersect_ellipse_series_len(s : GeointersectellipseSeries) -> Int { s.vals.length() }

pub fn geo_intersect_ellipse_series_sum(s : GeointersectellipseSeries) -> Double { @_common.sum(s.vals) }

pub fn geo_intersect_ellipse_series_mean(s : GeointersectellipseSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_intersect_ellipse_series_min(s : GeointersectellipseSeries) -> Double { @_common.min(s.vals) }

pub fn geo_intersect_ellipse_series_max(s : GeointersectellipseSeries) -> Double { @_common.max(s.vals) }

pub fn geo_intersect_ellipse_series_range(s : GeointersectellipseSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_intersect_ellipse_series_var(s : GeointersectellipseSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_intersect_ellipse_series_std(s : GeointersectellipseSeries) -> Double { @_common.std(s.vals) }

pub fn geo_intersect_ellipse_series_median(s : GeointersectellipseSeries) -> Double { @_common.median(s.vals) }

pub fn geo_intersect_ellipse_series_scale(s : GeointersectellipseSeries, f : Double) -> GeointersectellipseSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn geo_intersect_ellipse_series_add(a : GeointersectellipseSeries, b : GeointersectellipseSeries) -> GeointersectellipseSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_intersect_ellipse_series_sub(a : GeointersectellipseSeries, b : GeointersectellipseSeries) -> GeointersectellipseSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_intersect_ellipse_series_normalize(s : GeointersectellipseSeries) -> GeointersectellipseSeries {
  let mn = geo_intersect_ellipse_series_min(s)
  let mx = geo_intersect_ellipse_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_intersect_ellipse_series_cumsum(s : GeointersectellipseSeries) -> GeointersectellipseSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_intersect_ellipse_series_to_string(s : GeointersectellipseSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectellipseMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_ellipse_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectellipseMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_ellipse_matrix_identity(n : Int) -> GeointersectellipseMatrix {
  let m = geo_intersect_ellipse_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_intersect_ellipse_matrix_get(m : GeointersectellipseMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_intersect_ellipse_matrix_transpose(m : GeointersectellipseMatrix) -> GeointersectellipseMatrix {
  let result = geo_intersect_ellipse_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_intersect_ellipse_matrix_add(a : GeointersectellipseMatrix, b : GeointersectellipseMatrix) -> GeointersectellipseMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_intersect_ellipse_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_intersect_ellipse_matrix_scale(m : GeointersectellipseMatrix, s : Double) -> GeointersectellipseMatrix {
  let result = geo_intersect_ellipse_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_intersect_ellipse_matrix_multiply(a : GeointersectellipseMatrix, b : GeointersectellipseMatrix) -> GeointersectellipseMatrix {
  if a.cols != b.rows { return geo_intersect_ellipse_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_intersect_ellipse_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_intersect_ellipse_matrix_trace(m : GeointersectellipseMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_intersect_ellipse_matrix_det(m : GeointersectellipseMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_intersect_ellipse_matrix_norm(m : GeointersectellipseMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_intersect_ellipse_matrix_to_string(m : GeointersectellipseMatrix) -> String {
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

pub(all) struct GeointersectellipseVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_ellipse_make_vector(comps : Array[Double]) -> GeointersectellipseVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_ellipse_vector_zero(dim : Int) -> GeointersectellipseVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_intersect_ellipse_vector_add(a : GeointersectellipseVector, b : GeointersectellipseVector) -> GeointersectellipseVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn geo_intersect_ellipse_vector_sub(a : GeointersectellipseVector, b : GeointersectellipseVector) -> GeointersectellipseVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn geo_intersect_ellipse_vector_scale(v : GeointersectellipseVector, s : Double) -> GeointersectellipseVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn geo_intersect_ellipse_vector_dot(a : GeointersectellipseVector, b : GeointersectellipseVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_intersect_ellipse_vector_norm(v : GeointersectellipseVector) -> Double { @_common.sqrt(geo_intersect_ellipse_vector_dot(v, v)) }

pub fn geo_intersect_ellipse_vector_normalize(v : GeointersectellipseVector) -> GeointersectellipseVector {
  let n = geo_intersect_ellipse_vector_norm(v)
  if n < 0.0000001 { v } else { geo_intersect_ellipse_vector_scale(v, 1.0 / n) }
}

pub fn geo_intersect_ellipse_vector_dist(a : GeointersectellipseVector, b : GeointersectellipseVector) -> Double {
  geo_intersect_ellipse_vector_norm(geo_intersect_ellipse_vector_sub(a, b))
}

pub fn geo_intersect_ellipse_vector_to_string(v : GeointersectellipseVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_ellipse_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_intersect_ellipse_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_intersect_ellipse_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_intersect_ellipse_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_intersect_ellipse_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_intersect_ellipse_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_intersect_ellipse_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_intersect_ellipse_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_intersect_ellipse_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_intersect_ellipse_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_intersect_ellipse_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_intersect_ellipse_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_intersect_ellipse_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_intersect_ellipse_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_intersect_ellipse_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_intersect_ellipse_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_intersect_ellipse_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_intersect_ellipse_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_intersect_ellipse_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_intersect_ellipse_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_intersect_ellipse_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_intersect_ellipse_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_intersect_ellipse_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_intersect_ellipse_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_intersect_ellipse_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_intersect_ellipse_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_intersect_ellipse_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_intersect_ellipse_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_intersect_ellipse_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeointersectellipseFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_frame_make(size : Int) -> GeointersectellipseFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_frame_len(s : GeointersectellipseFrame) -> Int { s.size }

pub fn geo_intersect_ellipse_frame_get(s : GeointersectellipseFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_frame_set(s : GeointersectellipseFrame, i : Int, v : Double) -> GeointersectellipseFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_frame_sum(s : GeointersectellipseFrame) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_frame_mean(s : GeointersectellipseFrame) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_frame_scale(s : GeointersectellipseFrame, f : Double) -> GeointersectellipseFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_frame_add(a : GeointersectellipseFrame, b : GeointersectellipseFrame) -> GeointersectellipseFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_frame_copy(s : GeointersectellipseFrame) -> GeointersectellipseFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_frame_fill(s : GeointersectellipseFrame, v : Double) -> GeointersectellipseFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_frame_min(s : GeointersectellipseFrame) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_frame_max(s : GeointersectellipseFrame) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_frame_to_string(s : GeointersectellipseFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_table_make(size : Int) -> GeointersectellipseTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_table_len(s : GeointersectellipseTable) -> Int { s.size }

pub fn geo_intersect_ellipse_table_get(s : GeointersectellipseTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_table_set(s : GeointersectellipseTable, i : Int, v : Double) -> GeointersectellipseTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_table_sum(s : GeointersectellipseTable) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_table_mean(s : GeointersectellipseTable) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_table_scale(s : GeointersectellipseTable, f : Double) -> GeointersectellipseTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_table_add(a : GeointersectellipseTable, b : GeointersectellipseTable) -> GeointersectellipseTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_table_copy(s : GeointersectellipseTable) -> GeointersectellipseTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_table_fill(s : GeointersectellipseTable, v : Double) -> GeointersectellipseTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_table_min(s : GeointersectellipseTable) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_table_max(s : GeointersectellipseTable) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_table_to_string(s : GeointersectellipseTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_graphn_make(size : Int) -> GeointersectellipseGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_graphn_len(s : GeointersectellipseGraphN) -> Int { s.size }

pub fn geo_intersect_ellipse_graphn_get(s : GeointersectellipseGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_graphn_set(s : GeointersectellipseGraphN, i : Int, v : Double) -> GeointersectellipseGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_graphn_sum(s : GeointersectellipseGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_graphn_mean(s : GeointersectellipseGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_graphn_scale(s : GeointersectellipseGraphN, f : Double) -> GeointersectellipseGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_graphn_add(a : GeointersectellipseGraphN, b : GeointersectellipseGraphN) -> GeointersectellipseGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_graphn_copy(s : GeointersectellipseGraphN) -> GeointersectellipseGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_graphn_fill(s : GeointersectellipseGraphN, v : Double) -> GeointersectellipseGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_graphn_min(s : GeointersectellipseGraphN) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_graphn_max(s : GeointersectellipseGraphN) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_graphn_to_string(s : GeointersectellipseGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_node_make(size : Int) -> GeointersectellipseNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_node_len(s : GeointersectellipseNode) -> Int { s.size }

pub fn geo_intersect_ellipse_node_get(s : GeointersectellipseNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_node_set(s : GeointersectellipseNode, i : Int, v : Double) -> GeointersectellipseNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_node_sum(s : GeointersectellipseNode) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_node_mean(s : GeointersectellipseNode) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_node_scale(s : GeointersectellipseNode, f : Double) -> GeointersectellipseNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_node_add(a : GeointersectellipseNode, b : GeointersectellipseNode) -> GeointersectellipseNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_node_copy(s : GeointersectellipseNode) -> GeointersectellipseNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_node_fill(s : GeointersectellipseNode, v : Double) -> GeointersectellipseNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_node_min(s : GeointersectellipseNode) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_node_max(s : GeointersectellipseNode) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_node_to_string(s : GeointersectellipseNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_edge_make(size : Int) -> GeointersectellipseEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_edge_len(s : GeointersectellipseEdge) -> Int { s.size }

pub fn geo_intersect_ellipse_edge_get(s : GeointersectellipseEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_edge_set(s : GeointersectellipseEdge, i : Int, v : Double) -> GeointersectellipseEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_edge_sum(s : GeointersectellipseEdge) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_edge_mean(s : GeointersectellipseEdge) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_edge_scale(s : GeointersectellipseEdge, f : Double) -> GeointersectellipseEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_edge_add(a : GeointersectellipseEdge, b : GeointersectellipseEdge) -> GeointersectellipseEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_edge_copy(s : GeointersectellipseEdge) -> GeointersectellipseEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_edge_fill(s : GeointersectellipseEdge, v : Double) -> GeointersectellipseEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_edge_min(s : GeointersectellipseEdge) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_edge_max(s : GeointersectellipseEdge) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_edge_to_string(s : GeointersectellipseEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipsePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_path_make(size : Int) -> GeointersectellipsePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_path_len(s : GeointersectellipsePath) -> Int { s.size }

pub fn geo_intersect_ellipse_path_get(s : GeointersectellipsePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_path_set(s : GeointersectellipsePath, i : Int, v : Double) -> GeointersectellipsePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_path_sum(s : GeointersectellipsePath) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_path_mean(s : GeointersectellipsePath) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_path_scale(s : GeointersectellipsePath, f : Double) -> GeointersectellipsePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_path_add(a : GeointersectellipsePath, b : GeointersectellipsePath) -> GeointersectellipsePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_path_copy(s : GeointersectellipsePath) -> GeointersectellipsePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_path_fill(s : GeointersectellipsePath, v : Double) -> GeointersectellipsePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_path_min(s : GeointersectellipsePath) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_path_max(s : GeointersectellipsePath) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_path_to_string(s : GeointersectellipsePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_cluster_make(size : Int) -> GeointersectellipseCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_cluster_len(s : GeointersectellipseCluster) -> Int { s.size }

pub fn geo_intersect_ellipse_cluster_get(s : GeointersectellipseCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_cluster_set(s : GeointersectellipseCluster, i : Int, v : Double) -> GeointersectellipseCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_cluster_sum(s : GeointersectellipseCluster) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_cluster_mean(s : GeointersectellipseCluster) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_cluster_scale(s : GeointersectellipseCluster, f : Double) -> GeointersectellipseCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_cluster_add(a : GeointersectellipseCluster, b : GeointersectellipseCluster) -> GeointersectellipseCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_cluster_copy(s : GeointersectellipseCluster) -> GeointersectellipseCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_cluster_fill(s : GeointersectellipseCluster, v : Double) -> GeointersectellipseCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_cluster_min(s : GeointersectellipseCluster) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_cluster_max(s : GeointersectellipseCluster) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_cluster_to_string(s : GeointersectellipseCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_model_make(size : Int) -> GeointersectellipseModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_model_len(s : GeointersectellipseModel) -> Int { s.size }

pub fn geo_intersect_ellipse_model_get(s : GeointersectellipseModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_model_set(s : GeointersectellipseModel, i : Int, v : Double) -> GeointersectellipseModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_model_sum(s : GeointersectellipseModel) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_model_mean(s : GeointersectellipseModel) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_model_scale(s : GeointersectellipseModel, f : Double) -> GeointersectellipseModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_model_add(a : GeointersectellipseModel, b : GeointersectellipseModel) -> GeointersectellipseModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_model_copy(s : GeointersectellipseModel) -> GeointersectellipseModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_model_fill(s : GeointersectellipseModel, v : Double) -> GeointersectellipseModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_model_min(s : GeointersectellipseModel) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_model_max(s : GeointersectellipseModel) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_model_to_string(s : GeointersectellipseModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_layer_make(size : Int) -> GeointersectellipseLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_layer_len(s : GeointersectellipseLayer) -> Int { s.size }

pub fn geo_intersect_ellipse_layer_get(s : GeointersectellipseLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_layer_set(s : GeointersectellipseLayer, i : Int, v : Double) -> GeointersectellipseLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_layer_sum(s : GeointersectellipseLayer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_layer_mean(s : GeointersectellipseLayer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_layer_scale(s : GeointersectellipseLayer, f : Double) -> GeointersectellipseLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_layer_add(a : GeointersectellipseLayer, b : GeointersectellipseLayer) -> GeointersectellipseLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_layer_copy(s : GeointersectellipseLayer) -> GeointersectellipseLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_layer_fill(s : GeointersectellipseLayer, v : Double) -> GeointersectellipseLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_layer_min(s : GeointersectellipseLayer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_layer_max(s : GeointersectellipseLayer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_layer_to_string(s : GeointersectellipseLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_buffer_make(size : Int) -> GeointersectellipseBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_buffer_len(s : GeointersectellipseBuffer) -> Int { s.size }

pub fn geo_intersect_ellipse_buffer_get(s : GeointersectellipseBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_buffer_set(s : GeointersectellipseBuffer, i : Int, v : Double) -> GeointersectellipseBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_buffer_sum(s : GeointersectellipseBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_buffer_mean(s : GeointersectellipseBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_buffer_scale(s : GeointersectellipseBuffer, f : Double) -> GeointersectellipseBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_buffer_add(a : GeointersectellipseBuffer, b : GeointersectellipseBuffer) -> GeointersectellipseBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_buffer_copy(s : GeointersectellipseBuffer) -> GeointersectellipseBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_buffer_fill(s : GeointersectellipseBuffer, v : Double) -> GeointersectellipseBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_buffer_min(s : GeointersectellipseBuffer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_buffer_max(s : GeointersectellipseBuffer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_buffer_to_string(s : GeointersectellipseBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_cursor_make(size : Int) -> GeointersectellipseCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_cursor_len(s : GeointersectellipseCursor) -> Int { s.size }

pub fn geo_intersect_ellipse_cursor_get(s : GeointersectellipseCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_cursor_set(s : GeointersectellipseCursor, i : Int, v : Double) -> GeointersectellipseCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_cursor_sum(s : GeointersectellipseCursor) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_cursor_mean(s : GeointersectellipseCursor) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_cursor_scale(s : GeointersectellipseCursor, f : Double) -> GeointersectellipseCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_cursor_add(a : GeointersectellipseCursor, b : GeointersectellipseCursor) -> GeointersectellipseCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_cursor_copy(s : GeointersectellipseCursor) -> GeointersectellipseCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_cursor_fill(s : GeointersectellipseCursor, v : Double) -> GeointersectellipseCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_cursor_min(s : GeointersectellipseCursor) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_cursor_max(s : GeointersectellipseCursor) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_cursor_to_string(s : GeointersectellipseCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_view_make(size : Int) -> GeointersectellipseView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_view_len(s : GeointersectellipseView) -> Int { s.size }

pub fn geo_intersect_ellipse_view_get(s : GeointersectellipseView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_view_set(s : GeointersectellipseView, i : Int, v : Double) -> GeointersectellipseView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_view_sum(s : GeointersectellipseView) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_view_mean(s : GeointersectellipseView) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_view_scale(s : GeointersectellipseView, f : Double) -> GeointersectellipseView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_view_add(a : GeointersectellipseView, b : GeointersectellipseView) -> GeointersectellipseView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_view_copy(s : GeointersectellipseView) -> GeointersectellipseView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_view_fill(s : GeointersectellipseView, v : Double) -> GeointersectellipseView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_view_min(s : GeointersectellipseView) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_view_max(s : GeointersectellipseView) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_view_to_string(s : GeointersectellipseView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_range_make(size : Int) -> GeointersectellipseRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_range_len(s : GeointersectellipseRange) -> Int { s.size }

pub fn geo_intersect_ellipse_range_get(s : GeointersectellipseRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_range_set(s : GeointersectellipseRange, i : Int, v : Double) -> GeointersectellipseRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_range_sum(s : GeointersectellipseRange) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_range_mean(s : GeointersectellipseRange) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_range_scale(s : GeointersectellipseRange, f : Double) -> GeointersectellipseRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_range_add(a : GeointersectellipseRange, b : GeointersectellipseRange) -> GeointersectellipseRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_range_copy(s : GeointersectellipseRange) -> GeointersectellipseRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_range_fill(s : GeointersectellipseRange, v : Double) -> GeointersectellipseRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_range_min(s : GeointersectellipseRange) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_range_max(s : GeointersectellipseRange) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_range_to_string(s : GeointersectellipseRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectellipseSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_ellipse_slice_make(size : Int) -> GeointersectellipseSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_ellipse_slice_len(s : GeointersectellipseSlice) -> Int { s.size }

pub fn geo_intersect_ellipse_slice_get(s : GeointersectellipseSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_ellipse_slice_set(s : GeointersectellipseSlice, i : Int, v : Double) -> GeointersectellipseSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_slice_sum(s : GeointersectellipseSlice) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_ellipse_slice_mean(s : GeointersectellipseSlice) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_ellipse_slice_scale(s : GeointersectellipseSlice, f : Double) -> GeointersectellipseSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_slice_add(a : GeointersectellipseSlice, b : GeointersectellipseSlice) -> GeointersectellipseSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_ellipse_slice_copy(s : GeointersectellipseSlice) -> GeointersectellipseSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_slice_fill(s : GeointersectellipseSlice, v : Double) -> GeointersectellipseSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_ellipse_slice_min(s : GeointersectellipseSlice) -> Double { @_common.min(s.data) }

pub fn geo_intersect_ellipse_slice_max(s : GeointersectellipseSlice) -> Double { @_common.max(s.data) }

pub fn geo_intersect_ellipse_slice_to_string(s : GeointersectellipseSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

