///===
/// extcore/geo_intersect_polygon

pub(all) struct GeointersectpolygonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_polygon_make_point(x : Double, y : Double) -> GeointersectpolygonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_polygon_make_point3(x : Double, y : Double, z : Double) -> GeointersectpolygonPoint {
  { x, y, z, label: 0 }
}

pub fn geo_intersect_polygon_point_x(pt : GeointersectpolygonPoint) -> Double { pt.x }

pub fn geo_intersect_polygon_point_y(pt : GeointersectpolygonPoint) -> Double { pt.y }

pub fn geo_intersect_polygon_point_z(pt : GeointersectpolygonPoint) -> Double { pt.z }

pub fn geo_intersect_polygon_point_label(pt : GeointersectpolygonPoint) -> Int { pt.label }

pub fn geo_intersect_polygon_point_dist(a : GeointersectpolygonPoint, b : GeointersectpolygonPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_intersect_polygon_point_add(a : GeointersectpolygonPoint, b : GeointersectpolygonPoint) -> GeointersectpolygonPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_intersect_polygon_point_sub(a : GeointersectpolygonPoint, b : GeointersectpolygonPoint) -> GeointersectpolygonPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_intersect_polygon_point_scale(pt : GeointersectpolygonPoint, s : Double) -> GeointersectpolygonPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_intersect_polygon_point_dot(a : GeointersectpolygonPoint, b : GeointersectpolygonPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_intersect_polygon_point_cross(a : GeointersectpolygonPoint, b : GeointersectpolygonPoint) -> GeointersectpolygonPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_intersect_polygon_point_norm(pt : GeointersectpolygonPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_intersect_polygon_point_normalize(pt : GeointersectpolygonPoint) -> GeointersectpolygonPoint {
  let n = geo_intersect_polygon_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_intersect_polygon_point_scale(pt, 1.0 / n) }
}

pub fn geo_intersect_polygon_point_negate(pt : GeointersectpolygonPoint) -> GeointersectpolygonPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_intersect_polygon_point_mid(a : GeointersectpolygonPoint, b : GeointersectpolygonPoint) -> GeointersectpolygonPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_intersect_polygon_point_lerp(a : GeointersectpolygonPoint, b : GeointersectpolygonPoint, t : Double) -> GeointersectpolygonPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_intersect_polygon_point_to_string(pt : GeointersectpolygonPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeointersectpolygonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_polygon_make_series(vals : Array[Double], name : String) -> GeointersectpolygonSeries {
  { vals, name, meta: 0 }
}

pub fn geo_intersect_polygon_series_len(s : GeointersectpolygonSeries) -> Int { s.vals.length() }

pub fn geo_intersect_polygon_series_sum(s : GeointersectpolygonSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_intersect_polygon_series_mean(s : GeointersectpolygonSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_intersect_polygon_series_min(s : GeointersectpolygonSeries) -> Double { @_common.min(s.vals) }

pub fn geo_intersect_polygon_series_max(s : GeointersectpolygonSeries) -> Double { @_common.max(s.vals) }

pub fn geo_intersect_polygon_series_range(s : GeointersectpolygonSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_intersect_polygon_series_var(s : GeointersectpolygonSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_intersect_polygon_series_std(s : GeointersectpolygonSeries) -> Double { @_common.std(s.vals) }

pub fn geo_intersect_polygon_series_median(s : GeointersectpolygonSeries) -> Double { @_common.median(s.vals) }

pub fn geo_intersect_polygon_series_scale(s : GeointersectpolygonSeries, f : Double) -> GeointersectpolygonSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_intersect_polygon_series_add(a : GeointersectpolygonSeries, b : GeointersectpolygonSeries) -> GeointersectpolygonSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_intersect_polygon_series_sub(a : GeointersectpolygonSeries, b : GeointersectpolygonSeries) -> GeointersectpolygonSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_intersect_polygon_series_normalize(s : GeointersectpolygonSeries) -> GeointersectpolygonSeries {
  let mn = geo_intersect_polygon_series_min(s)
  let mx = geo_intersect_polygon_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_intersect_polygon_series_cumsum(s : GeointersectpolygonSeries) -> GeointersectpolygonSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_intersect_polygon_series_to_string(s : GeointersectpolygonSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectpolygonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_polygon_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectpolygonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_polygon_matrix_identity(n : Int) -> GeointersectpolygonMatrix {
  let m = geo_intersect_polygon_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_intersect_polygon_matrix_get(m : GeointersectpolygonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_intersect_polygon_matrix_transpose(m : GeointersectpolygonMatrix) -> GeointersectpolygonMatrix {
  let result = geo_intersect_polygon_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_intersect_polygon_matrix_add(a : GeointersectpolygonMatrix, b : GeointersectpolygonMatrix) -> GeointersectpolygonMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_intersect_polygon_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_intersect_polygon_matrix_scale(m : GeointersectpolygonMatrix, s : Double) -> GeointersectpolygonMatrix {
  let result = geo_intersect_polygon_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_intersect_polygon_matrix_multiply(a : GeointersectpolygonMatrix, b : GeointersectpolygonMatrix) -> GeointersectpolygonMatrix {
  if a.cols != b.rows { return geo_intersect_polygon_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_intersect_polygon_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_intersect_polygon_matrix_trace(m : GeointersectpolygonMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_intersect_polygon_matrix_det(m : GeointersectpolygonMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_intersect_polygon_matrix_norm(m : GeointersectpolygonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_intersect_polygon_matrix_to_string(m : GeointersectpolygonMatrix) -> String {
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

pub(all) struct GeointersectpolygonVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_polygon_make_vector(comps : Array[Double]) -> GeointersectpolygonVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_polygon_vector_zero(dim : Int) -> GeointersectpolygonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_intersect_polygon_vector_add(a : GeointersectpolygonVector, b : GeointersectpolygonVector) -> GeointersectpolygonVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_polygon_vector_sub(a : GeointersectpolygonVector, b : GeointersectpolygonVector) -> GeointersectpolygonVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_polygon_vector_scale(v : GeointersectpolygonVector, s : Double) -> GeointersectpolygonVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_intersect_polygon_vector_dot(a : GeointersectpolygonVector, b : GeointersectpolygonVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_intersect_polygon_vector_norm(v : GeointersectpolygonVector) -> Double { @_common.sqrt(geo_intersect_polygon_vector_dot(v, v)) }

pub fn geo_intersect_polygon_vector_normalize(v : GeointersectpolygonVector) -> GeointersectpolygonVector {
  let n = geo_intersect_polygon_vector_norm(v)
  if n < 0.0000001 { v } else { geo_intersect_polygon_vector_scale(v, 1.0 / n) }
}

pub fn geo_intersect_polygon_vector_dist(a : GeointersectpolygonVector, b : GeointersectpolygonVector) -> Double {
  geo_intersect_polygon_vector_norm(geo_intersect_polygon_vector_sub(a, b))
}

pub fn geo_intersect_polygon_vector_to_string(v : GeointersectpolygonVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_polygon_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_intersect_polygon_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_intersect_polygon_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_intersect_polygon_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_intersect_polygon_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_intersect_polygon_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_intersect_polygon_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_intersect_polygon_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_intersect_polygon_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_intersect_polygon_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_intersect_polygon_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_intersect_polygon_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_intersect_polygon_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_intersect_polygon_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_intersect_polygon_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_intersect_polygon_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_intersect_polygon_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_intersect_polygon_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_intersect_polygon_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_intersect_polygon_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_intersect_polygon_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_intersect_polygon_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_intersect_polygon_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_intersect_polygon_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_intersect_polygon_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_intersect_polygon_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_intersect_polygon_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_intersect_polygon_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_intersect_polygon_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeointersectpolygonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_frame_make(size : Int) -> GeointersectpolygonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_frame_len(s : GeointersectpolygonFrame) -> Int { s.size }

pub fn geo_intersect_polygon_frame_get(s : GeointersectpolygonFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_frame_set(s : GeointersectpolygonFrame, i : Int, v : Double) -> GeointersectpolygonFrame {
  let result = geo_intersect_polygon_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_frame_sum(s : GeointersectpolygonFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_polygon_frame_mean(s : GeointersectpolygonFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_polygon_frame_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_polygon_frame_scale(s : GeointersectpolygonFrame, f : Double) -> GeointersectpolygonFrame {
  let result = geo_intersect_polygon_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_polygon_frame_add(a : GeointersectpolygonFrame, b : GeointersectpolygonFrame) -> GeointersectpolygonFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_polygon_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_polygon_frame_copy(s : GeointersectpolygonFrame) -> GeointersectpolygonFrame {
  let result = geo_intersect_polygon_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_polygon_frame_fill(s : GeointersectpolygonFrame, v : Double) -> GeointersectpolygonFrame {
  let result = geo_intersect_polygon_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_frame_min(s : GeointersectpolygonFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_frame_max(s : GeointersectpolygonFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_frame_to_string(s : GeointersectpolygonFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_table_make(size : Int) -> GeointersectpolygonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_table_len(s : GeointersectpolygonTable) -> Int { s.size }

pub fn geo_intersect_polygon_table_get(s : GeointersectpolygonTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_table_set(s : GeointersectpolygonTable, i : Int, v : Double) -> GeointersectpolygonTable {
  let result = geo_intersect_polygon_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_table_sum(s : GeointersectpolygonTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_polygon_table_mean(s : GeointersectpolygonTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_polygon_table_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_polygon_table_scale(s : GeointersectpolygonTable, f : Double) -> GeointersectpolygonTable {
  let result = geo_intersect_polygon_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_polygon_table_add(a : GeointersectpolygonTable, b : GeointersectpolygonTable) -> GeointersectpolygonTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_polygon_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_polygon_table_copy(s : GeointersectpolygonTable) -> GeointersectpolygonTable {
  let result = geo_intersect_polygon_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_polygon_table_fill(s : GeointersectpolygonTable, v : Double) -> GeointersectpolygonTable {
  let result = geo_intersect_polygon_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_table_min(s : GeointersectpolygonTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_table_max(s : GeointersectpolygonTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_table_to_string(s : GeointersectpolygonTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_graphn_make(size : Int) -> GeointersectpolygonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_graphn_len(s : GeointersectpolygonGraphN) -> Int { s.size }

pub fn geo_intersect_polygon_graphn_get(s : GeointersectpolygonGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_graphn_set(s : GeointersectpolygonGraphN, i : Int, v : Double) -> GeointersectpolygonGraphN {
  let result = geo_intersect_polygon_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_graphn_sum(s : GeointersectpolygonGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_polygon_graphn_mean(s : GeointersectpolygonGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_polygon_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_polygon_graphn_scale(s : GeointersectpolygonGraphN, f : Double) -> GeointersectpolygonGraphN {
  let result = geo_intersect_polygon_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_polygon_graphn_add(a : GeointersectpolygonGraphN, b : GeointersectpolygonGraphN) -> GeointersectpolygonGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_polygon_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_polygon_graphn_copy(s : GeointersectpolygonGraphN) -> GeointersectpolygonGraphN {
  let result = geo_intersect_polygon_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_polygon_graphn_fill(s : GeointersectpolygonGraphN, v : Double) -> GeointersectpolygonGraphN {
  let result = geo_intersect_polygon_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_graphn_min(s : GeointersectpolygonGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_graphn_max(s : GeointersectpolygonGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_graphn_to_string(s : GeointersectpolygonGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_node_make(size : Int) -> GeointersectpolygonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_node_len(s : GeointersectpolygonNode) -> Int { s.size }

pub fn geo_intersect_polygon_node_get(s : GeointersectpolygonNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_node_set(s : GeointersectpolygonNode, i : Int, v : Double) -> GeointersectpolygonNode {
  let result = geo_intersect_polygon_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_node_sum(s : GeointersectpolygonNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_polygon_node_mean(s : GeointersectpolygonNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_polygon_node_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_polygon_node_scale(s : GeointersectpolygonNode, f : Double) -> GeointersectpolygonNode {
  let result = geo_intersect_polygon_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_polygon_node_add(a : GeointersectpolygonNode, b : GeointersectpolygonNode) -> GeointersectpolygonNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_polygon_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_polygon_node_copy(s : GeointersectpolygonNode) -> GeointersectpolygonNode {
  let result = geo_intersect_polygon_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_polygon_node_fill(s : GeointersectpolygonNode, v : Double) -> GeointersectpolygonNode {
  let result = geo_intersect_polygon_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_node_min(s : GeointersectpolygonNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_node_max(s : GeointersectpolygonNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_node_to_string(s : GeointersectpolygonNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_edge_make(size : Int) -> GeointersectpolygonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_edge_len(s : GeointersectpolygonEdge) -> Int { s.size }

pub fn geo_intersect_polygon_edge_get(s : GeointersectpolygonEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_edge_set(s : GeointersectpolygonEdge, i : Int, v : Double) -> GeointersectpolygonEdge {
  let result = geo_intersect_polygon_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_edge_sum(s : GeointersectpolygonEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_polygon_edge_mean(s : GeointersectpolygonEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_polygon_edge_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_polygon_edge_scale(s : GeointersectpolygonEdge, f : Double) -> GeointersectpolygonEdge {
  let result = geo_intersect_polygon_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_polygon_edge_add(a : GeointersectpolygonEdge, b : GeointersectpolygonEdge) -> GeointersectpolygonEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_polygon_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_polygon_edge_copy(s : GeointersectpolygonEdge) -> GeointersectpolygonEdge {
  let result = geo_intersect_polygon_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_polygon_edge_fill(s : GeointersectpolygonEdge, v : Double) -> GeointersectpolygonEdge {
  let result = geo_intersect_polygon_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_edge_min(s : GeointersectpolygonEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_edge_max(s : GeointersectpolygonEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_edge_to_string(s : GeointersectpolygonEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_path_make(size : Int) -> GeointersectpolygonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_path_len(s : GeointersectpolygonPath) -> Int { s.size }

pub fn geo_intersect_polygon_path_get(s : GeointersectpolygonPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_path_set(s : GeointersectpolygonPath, i : Int, v : Double) -> GeointersectpolygonPath {
  let result = geo_intersect_polygon_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_path_sum(s : GeointersectpolygonPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_polygon_path_mean(s : GeointersectpolygonPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_polygon_path_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_polygon_path_scale(s : GeointersectpolygonPath, f : Double) -> GeointersectpolygonPath {
  let result = geo_intersect_polygon_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_polygon_path_add(a : GeointersectpolygonPath, b : GeointersectpolygonPath) -> GeointersectpolygonPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_polygon_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_polygon_path_copy(s : GeointersectpolygonPath) -> GeointersectpolygonPath {
  let result = geo_intersect_polygon_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_polygon_path_fill(s : GeointersectpolygonPath, v : Double) -> GeointersectpolygonPath {
  let result = geo_intersect_polygon_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_path_min(s : GeointersectpolygonPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_path_max(s : GeointersectpolygonPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_path_to_string(s : GeointersectpolygonPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_cluster_make(size : Int) -> GeointersectpolygonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_cluster_len(s : GeointersectpolygonCluster) -> Int { s.size }

pub fn geo_intersect_polygon_cluster_get(s : GeointersectpolygonCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_cluster_set(s : GeointersectpolygonCluster, i : Int, v : Double) -> GeointersectpolygonCluster {
  let result = geo_intersect_polygon_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_cluster_sum(s : GeointersectpolygonCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_polygon_cluster_mean(s : GeointersectpolygonCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_polygon_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_polygon_cluster_scale(s : GeointersectpolygonCluster, f : Double) -> GeointersectpolygonCluster {
  let result = geo_intersect_polygon_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_polygon_cluster_add(a : GeointersectpolygonCluster, b : GeointersectpolygonCluster) -> GeointersectpolygonCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_polygon_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_polygon_cluster_copy(s : GeointersectpolygonCluster) -> GeointersectpolygonCluster {
  let result = geo_intersect_polygon_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_polygon_cluster_fill(s : GeointersectpolygonCluster, v : Double) -> GeointersectpolygonCluster {
  let result = geo_intersect_polygon_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_cluster_min(s : GeointersectpolygonCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_cluster_max(s : GeointersectpolygonCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_cluster_to_string(s : GeointersectpolygonCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_model_make(size : Int) -> GeointersectpolygonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_model_len(s : GeointersectpolygonModel) -> Int { s.size }

pub fn geo_intersect_polygon_model_get(s : GeointersectpolygonModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_model_set(s : GeointersectpolygonModel, i : Int, v : Double) -> GeointersectpolygonModel {
  let result = geo_intersect_polygon_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_model_sum(s : GeointersectpolygonModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_polygon_model_mean(s : GeointersectpolygonModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_polygon_model_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_polygon_model_scale(s : GeointersectpolygonModel, f : Double) -> GeointersectpolygonModel {
  let result = geo_intersect_polygon_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_polygon_model_add(a : GeointersectpolygonModel, b : GeointersectpolygonModel) -> GeointersectpolygonModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_polygon_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_polygon_model_copy(s : GeointersectpolygonModel) -> GeointersectpolygonModel {
  let result = geo_intersect_polygon_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_polygon_model_fill(s : GeointersectpolygonModel, v : Double) -> GeointersectpolygonModel {
  let result = geo_intersect_polygon_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_model_min(s : GeointersectpolygonModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_model_max(s : GeointersectpolygonModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_model_to_string(s : GeointersectpolygonModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_layer_make(size : Int) -> GeointersectpolygonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_layer_len(s : GeointersectpolygonLayer) -> Int { s.size }

pub fn geo_intersect_polygon_layer_get(s : GeointersectpolygonLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_layer_set(s : GeointersectpolygonLayer, i : Int, v : Double) -> GeointersectpolygonLayer {
  let result = geo_intersect_polygon_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_layer_sum(s : GeointersectpolygonLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_polygon_layer_mean(s : GeointersectpolygonLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_polygon_layer_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_polygon_layer_scale(s : GeointersectpolygonLayer, f : Double) -> GeointersectpolygonLayer {
  let result = geo_intersect_polygon_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_polygon_layer_add(a : GeointersectpolygonLayer, b : GeointersectpolygonLayer) -> GeointersectpolygonLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_polygon_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_polygon_layer_copy(s : GeointersectpolygonLayer) -> GeointersectpolygonLayer {
  let result = geo_intersect_polygon_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_polygon_layer_fill(s : GeointersectpolygonLayer, v : Double) -> GeointersectpolygonLayer {
  let result = geo_intersect_polygon_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_layer_min(s : GeointersectpolygonLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_layer_max(s : GeointersectpolygonLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_layer_to_string(s : GeointersectpolygonLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_buffer_make(size : Int) -> GeointersectpolygonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_buffer_len(s : GeointersectpolygonBuffer) -> Int { s.size }

pub fn geo_intersect_polygon_buffer_get(s : GeointersectpolygonBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_buffer_set(s : GeointersectpolygonBuffer, i : Int, v : Double) -> GeointersectpolygonBuffer {
  let result = geo_intersect_polygon_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_buffer_sum(s : GeointersectpolygonBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_polygon_buffer_mean(s : GeointersectpolygonBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_polygon_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_polygon_buffer_scale(s : GeointersectpolygonBuffer, f : Double) -> GeointersectpolygonBuffer {
  let result = geo_intersect_polygon_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_polygon_buffer_add(a : GeointersectpolygonBuffer, b : GeointersectpolygonBuffer) -> GeointersectpolygonBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_polygon_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_polygon_buffer_copy(s : GeointersectpolygonBuffer) -> GeointersectpolygonBuffer {
  let result = geo_intersect_polygon_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_polygon_buffer_fill(s : GeointersectpolygonBuffer, v : Double) -> GeointersectpolygonBuffer {
  let result = geo_intersect_polygon_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_buffer_min(s : GeointersectpolygonBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_buffer_max(s : GeointersectpolygonBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_buffer_to_string(s : GeointersectpolygonBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_cursor_make(size : Int) -> GeointersectpolygonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_cursor_len(s : GeointersectpolygonCursor) -> Int { s.size }

pub fn geo_intersect_polygon_cursor_get(s : GeointersectpolygonCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_cursor_set(s : GeointersectpolygonCursor, i : Int, v : Double) -> GeointersectpolygonCursor {
  let result = geo_intersect_polygon_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_cursor_sum(s : GeointersectpolygonCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_polygon_cursor_mean(s : GeointersectpolygonCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_polygon_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_polygon_cursor_scale(s : GeointersectpolygonCursor, f : Double) -> GeointersectpolygonCursor {
  let result = geo_intersect_polygon_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_polygon_cursor_add(a : GeointersectpolygonCursor, b : GeointersectpolygonCursor) -> GeointersectpolygonCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_polygon_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_polygon_cursor_copy(s : GeointersectpolygonCursor) -> GeointersectpolygonCursor {
  let result = geo_intersect_polygon_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_polygon_cursor_fill(s : GeointersectpolygonCursor, v : Double) -> GeointersectpolygonCursor {
  let result = geo_intersect_polygon_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_cursor_min(s : GeointersectpolygonCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_cursor_max(s : GeointersectpolygonCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_cursor_to_string(s : GeointersectpolygonCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_view_make(size : Int) -> GeointersectpolygonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_view_len(s : GeointersectpolygonView) -> Int { s.size }

pub fn geo_intersect_polygon_view_get(s : GeointersectpolygonView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_view_set(s : GeointersectpolygonView, i : Int, v : Double) -> GeointersectpolygonView {
  let result = geo_intersect_polygon_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_view_sum(s : GeointersectpolygonView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_polygon_view_mean(s : GeointersectpolygonView) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_polygon_view_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_polygon_view_scale(s : GeointersectpolygonView, f : Double) -> GeointersectpolygonView {
  let result = geo_intersect_polygon_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_polygon_view_add(a : GeointersectpolygonView, b : GeointersectpolygonView) -> GeointersectpolygonView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_polygon_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_polygon_view_copy(s : GeointersectpolygonView) -> GeointersectpolygonView {
  let result = geo_intersect_polygon_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_polygon_view_fill(s : GeointersectpolygonView, v : Double) -> GeointersectpolygonView {
  let result = geo_intersect_polygon_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_view_min(s : GeointersectpolygonView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_view_max(s : GeointersectpolygonView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_view_to_string(s : GeointersectpolygonView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_range_make(size : Int) -> GeointersectpolygonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_range_len(s : GeointersectpolygonRange) -> Int { s.size }

pub fn geo_intersect_polygon_range_get(s : GeointersectpolygonRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_range_set(s : GeointersectpolygonRange, i : Int, v : Double) -> GeointersectpolygonRange {
  let result = geo_intersect_polygon_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_range_sum(s : GeointersectpolygonRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_polygon_range_mean(s : GeointersectpolygonRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_polygon_range_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_polygon_range_scale(s : GeointersectpolygonRange, f : Double) -> GeointersectpolygonRange {
  let result = geo_intersect_polygon_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_polygon_range_add(a : GeointersectpolygonRange, b : GeointersectpolygonRange) -> GeointersectpolygonRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_polygon_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_polygon_range_copy(s : GeointersectpolygonRange) -> GeointersectpolygonRange {
  let result = geo_intersect_polygon_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_polygon_range_fill(s : GeointersectpolygonRange, v : Double) -> GeointersectpolygonRange {
  let result = geo_intersect_polygon_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_range_min(s : GeointersectpolygonRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_range_max(s : GeointersectpolygonRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_range_to_string(s : GeointersectpolygonRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_slice_make(size : Int) -> GeointersectpolygonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_slice_len(s : GeointersectpolygonSlice) -> Int { s.size }

pub fn geo_intersect_polygon_slice_get(s : GeointersectpolygonSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_slice_set(s : GeointersectpolygonSlice, i : Int, v : Double) -> GeointersectpolygonSlice {
  let result = geo_intersect_polygon_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_slice_sum(s : GeointersectpolygonSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_polygon_slice_mean(s : GeointersectpolygonSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_polygon_slice_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_polygon_slice_scale(s : GeointersectpolygonSlice, f : Double) -> GeointersectpolygonSlice {
  let result = geo_intersect_polygon_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_polygon_slice_add(a : GeointersectpolygonSlice, b : GeointersectpolygonSlice) -> GeointersectpolygonSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_polygon_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_polygon_slice_copy(s : GeointersectpolygonSlice) -> GeointersectpolygonSlice {
  let result = geo_intersect_polygon_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_polygon_slice_fill(s : GeointersectpolygonSlice, v : Double) -> GeointersectpolygonSlice {
  let result = geo_intersect_polygon_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_polygon_slice_min(s : GeointersectpolygonSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_slice_max(s : GeointersectpolygonSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_polygon_slice_to_string(s : GeointersectpolygonSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

