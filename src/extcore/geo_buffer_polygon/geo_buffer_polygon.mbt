///===
/// extcore/geo_buffer_polygon

pub(all) struct GeobufferpolygonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_polygon_make_point(x : Double, y : Double) -> GeobufferpolygonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_polygon_make_point3(x : Double, y : Double, z : Double) -> GeobufferpolygonPoint {
  { x, y, z, label: 0 }
}

pub fn geo_buffer_polygon_point_x(pt : GeobufferpolygonPoint) -> Double { pt.x }

pub fn geo_buffer_polygon_point_y(pt : GeobufferpolygonPoint) -> Double { pt.y }

pub fn geo_buffer_polygon_point_z(pt : GeobufferpolygonPoint) -> Double { pt.z }

pub fn geo_buffer_polygon_point_label(pt : GeobufferpolygonPoint) -> Int { pt.label }

pub fn geo_buffer_polygon_point_dist(a : GeobufferpolygonPoint, b : GeobufferpolygonPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_buffer_polygon_point_add(a : GeobufferpolygonPoint, b : GeobufferpolygonPoint) -> GeobufferpolygonPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_buffer_polygon_point_sub(a : GeobufferpolygonPoint, b : GeobufferpolygonPoint) -> GeobufferpolygonPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_buffer_polygon_point_scale(pt : GeobufferpolygonPoint, s : Double) -> GeobufferpolygonPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_buffer_polygon_point_dot(a : GeobufferpolygonPoint, b : GeobufferpolygonPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_buffer_polygon_point_cross(a : GeobufferpolygonPoint, b : GeobufferpolygonPoint) -> GeobufferpolygonPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_buffer_polygon_point_norm(pt : GeobufferpolygonPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_buffer_polygon_point_normalize(pt : GeobufferpolygonPoint) -> GeobufferpolygonPoint {
  let n = geo_buffer_polygon_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_buffer_polygon_point_scale(pt, 1.0 / n) }
}

pub fn geo_buffer_polygon_point_negate(pt : GeobufferpolygonPoint) -> GeobufferpolygonPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_buffer_polygon_point_mid(a : GeobufferpolygonPoint, b : GeobufferpolygonPoint) -> GeobufferpolygonPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_buffer_polygon_point_lerp(a : GeobufferpolygonPoint, b : GeobufferpolygonPoint, t : Double) -> GeobufferpolygonPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_buffer_polygon_point_to_string(pt : GeobufferpolygonPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeobufferpolygonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_polygon_make_series(vals : Array[Double], name : String) -> GeobufferpolygonSeries {
  { vals, name, meta: 0 }
}

pub fn geo_buffer_polygon_series_len(s : GeobufferpolygonSeries) -> Int { s.vals.length() }

pub fn geo_buffer_polygon_series_sum(s : GeobufferpolygonSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_buffer_polygon_series_mean(s : GeobufferpolygonSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_buffer_polygon_series_min(s : GeobufferpolygonSeries) -> Double { @_common.min(s.vals) }

pub fn geo_buffer_polygon_series_max(s : GeobufferpolygonSeries) -> Double { @_common.max(s.vals) }

pub fn geo_buffer_polygon_series_range(s : GeobufferpolygonSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_buffer_polygon_series_var(s : GeobufferpolygonSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_buffer_polygon_series_std(s : GeobufferpolygonSeries) -> Double { @_common.std(s.vals) }

pub fn geo_buffer_polygon_series_median(s : GeobufferpolygonSeries) -> Double { @_common.median(s.vals) }

pub fn geo_buffer_polygon_series_scale(s : GeobufferpolygonSeries, f : Double) -> GeobufferpolygonSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_buffer_polygon_series_add(a : GeobufferpolygonSeries, b : GeobufferpolygonSeries) -> GeobufferpolygonSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_buffer_polygon_series_sub(a : GeobufferpolygonSeries, b : GeobufferpolygonSeries) -> GeobufferpolygonSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_buffer_polygon_series_normalize(s : GeobufferpolygonSeries) -> GeobufferpolygonSeries {
  let mn = geo_buffer_polygon_series_min(s)
  let mx = geo_buffer_polygon_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_buffer_polygon_series_cumsum(s : GeobufferpolygonSeries) -> GeobufferpolygonSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_buffer_polygon_series_to_string(s : GeobufferpolygonSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobufferpolygonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_polygon_make_matrix(rows : Int, cols : Int, val : Double) -> GeobufferpolygonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_polygon_matrix_identity(n : Int) -> GeobufferpolygonMatrix {
  let m = geo_buffer_polygon_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_buffer_polygon_matrix_get(m : GeobufferpolygonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_buffer_polygon_matrix_transpose(m : GeobufferpolygonMatrix) -> GeobufferpolygonMatrix {
  let result = geo_buffer_polygon_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_buffer_polygon_matrix_add(a : GeobufferpolygonMatrix, b : GeobufferpolygonMatrix) -> GeobufferpolygonMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_buffer_polygon_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_buffer_polygon_matrix_scale(m : GeobufferpolygonMatrix, s : Double) -> GeobufferpolygonMatrix {
  let result = geo_buffer_polygon_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_buffer_polygon_matrix_multiply(a : GeobufferpolygonMatrix, b : GeobufferpolygonMatrix) -> GeobufferpolygonMatrix {
  if a.cols != b.rows { return geo_buffer_polygon_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_buffer_polygon_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_buffer_polygon_matrix_trace(m : GeobufferpolygonMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_buffer_polygon_matrix_det(m : GeobufferpolygonMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_buffer_polygon_matrix_norm(m : GeobufferpolygonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_buffer_polygon_matrix_to_string(m : GeobufferpolygonMatrix) -> String {
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

pub(all) struct GeobufferpolygonVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_polygon_make_vector(comps : Array[Double]) -> GeobufferpolygonVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_polygon_vector_zero(dim : Int) -> GeobufferpolygonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_buffer_polygon_vector_add(a : GeobufferpolygonVector, b : GeobufferpolygonVector) -> GeobufferpolygonVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_buffer_polygon_vector_sub(a : GeobufferpolygonVector, b : GeobufferpolygonVector) -> GeobufferpolygonVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_buffer_polygon_vector_scale(v : GeobufferpolygonVector, s : Double) -> GeobufferpolygonVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_buffer_polygon_vector_dot(a : GeobufferpolygonVector, b : GeobufferpolygonVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_buffer_polygon_vector_norm(v : GeobufferpolygonVector) -> Double { @_common.sqrt(geo_buffer_polygon_vector_dot(v, v)) }

pub fn geo_buffer_polygon_vector_normalize(v : GeobufferpolygonVector) -> GeobufferpolygonVector {
  let n = geo_buffer_polygon_vector_norm(v)
  if n < 0.0000001 { v } else { geo_buffer_polygon_vector_scale(v, 1.0 / n) }
}

pub fn geo_buffer_polygon_vector_dist(a : GeobufferpolygonVector, b : GeobufferpolygonVector) -> Double {
  geo_buffer_polygon_vector_norm(geo_buffer_polygon_vector_sub(a, b))
}

pub fn geo_buffer_polygon_vector_to_string(v : GeobufferpolygonVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_buffer_polygon_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_buffer_polygon_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_buffer_polygon_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_buffer_polygon_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_buffer_polygon_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_buffer_polygon_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_buffer_polygon_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_buffer_polygon_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_buffer_polygon_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_buffer_polygon_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_buffer_polygon_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_buffer_polygon_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_buffer_polygon_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_buffer_polygon_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_buffer_polygon_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_buffer_polygon_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_buffer_polygon_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_buffer_polygon_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_buffer_polygon_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_buffer_polygon_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_buffer_polygon_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_buffer_polygon_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_buffer_polygon_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_buffer_polygon_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_buffer_polygon_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_buffer_polygon_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_buffer_polygon_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_buffer_polygon_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_buffer_polygon_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeobufferpolygonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_frame_make(size : Int) -> GeobufferpolygonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_frame_len(s : GeobufferpolygonFrame) -> Int { s.size }

pub fn geo_buffer_polygon_frame_get(s : GeobufferpolygonFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_frame_set(s : GeobufferpolygonFrame, i : Int, v : Double) -> GeobufferpolygonFrame {
  let result = geo_buffer_polygon_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_frame_sum(s : GeobufferpolygonFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_polygon_frame_mean(s : GeobufferpolygonFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_polygon_frame_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_polygon_frame_scale(s : GeobufferpolygonFrame, f : Double) -> GeobufferpolygonFrame {
  let result = geo_buffer_polygon_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_polygon_frame_add(a : GeobufferpolygonFrame, b : GeobufferpolygonFrame) -> GeobufferpolygonFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_polygon_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_polygon_frame_copy(s : GeobufferpolygonFrame) -> GeobufferpolygonFrame {
  let result = geo_buffer_polygon_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_polygon_frame_fill(s : GeobufferpolygonFrame, v : Double) -> GeobufferpolygonFrame {
  let result = geo_buffer_polygon_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_frame_min(s : GeobufferpolygonFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_frame_max(s : GeobufferpolygonFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_frame_to_string(s : GeobufferpolygonFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_table_make(size : Int) -> GeobufferpolygonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_table_len(s : GeobufferpolygonTable) -> Int { s.size }

pub fn geo_buffer_polygon_table_get(s : GeobufferpolygonTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_table_set(s : GeobufferpolygonTable, i : Int, v : Double) -> GeobufferpolygonTable {
  let result = geo_buffer_polygon_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_table_sum(s : GeobufferpolygonTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_polygon_table_mean(s : GeobufferpolygonTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_polygon_table_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_polygon_table_scale(s : GeobufferpolygonTable, f : Double) -> GeobufferpolygonTable {
  let result = geo_buffer_polygon_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_polygon_table_add(a : GeobufferpolygonTable, b : GeobufferpolygonTable) -> GeobufferpolygonTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_polygon_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_polygon_table_copy(s : GeobufferpolygonTable) -> GeobufferpolygonTable {
  let result = geo_buffer_polygon_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_polygon_table_fill(s : GeobufferpolygonTable, v : Double) -> GeobufferpolygonTable {
  let result = geo_buffer_polygon_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_table_min(s : GeobufferpolygonTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_table_max(s : GeobufferpolygonTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_table_to_string(s : GeobufferpolygonTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_graphn_make(size : Int) -> GeobufferpolygonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_graphn_len(s : GeobufferpolygonGraphN) -> Int { s.size }

pub fn geo_buffer_polygon_graphn_get(s : GeobufferpolygonGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_graphn_set(s : GeobufferpolygonGraphN, i : Int, v : Double) -> GeobufferpolygonGraphN {
  let result = geo_buffer_polygon_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_graphn_sum(s : GeobufferpolygonGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_polygon_graphn_mean(s : GeobufferpolygonGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_polygon_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_polygon_graphn_scale(s : GeobufferpolygonGraphN, f : Double) -> GeobufferpolygonGraphN {
  let result = geo_buffer_polygon_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_polygon_graphn_add(a : GeobufferpolygonGraphN, b : GeobufferpolygonGraphN) -> GeobufferpolygonGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_polygon_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_polygon_graphn_copy(s : GeobufferpolygonGraphN) -> GeobufferpolygonGraphN {
  let result = geo_buffer_polygon_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_polygon_graphn_fill(s : GeobufferpolygonGraphN, v : Double) -> GeobufferpolygonGraphN {
  let result = geo_buffer_polygon_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_graphn_min(s : GeobufferpolygonGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_graphn_max(s : GeobufferpolygonGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_graphn_to_string(s : GeobufferpolygonGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_node_make(size : Int) -> GeobufferpolygonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_node_len(s : GeobufferpolygonNode) -> Int { s.size }

pub fn geo_buffer_polygon_node_get(s : GeobufferpolygonNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_node_set(s : GeobufferpolygonNode, i : Int, v : Double) -> GeobufferpolygonNode {
  let result = geo_buffer_polygon_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_node_sum(s : GeobufferpolygonNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_polygon_node_mean(s : GeobufferpolygonNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_polygon_node_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_polygon_node_scale(s : GeobufferpolygonNode, f : Double) -> GeobufferpolygonNode {
  let result = geo_buffer_polygon_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_polygon_node_add(a : GeobufferpolygonNode, b : GeobufferpolygonNode) -> GeobufferpolygonNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_polygon_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_polygon_node_copy(s : GeobufferpolygonNode) -> GeobufferpolygonNode {
  let result = geo_buffer_polygon_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_polygon_node_fill(s : GeobufferpolygonNode, v : Double) -> GeobufferpolygonNode {
  let result = geo_buffer_polygon_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_node_min(s : GeobufferpolygonNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_node_max(s : GeobufferpolygonNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_node_to_string(s : GeobufferpolygonNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_edge_make(size : Int) -> GeobufferpolygonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_edge_len(s : GeobufferpolygonEdge) -> Int { s.size }

pub fn geo_buffer_polygon_edge_get(s : GeobufferpolygonEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_edge_set(s : GeobufferpolygonEdge, i : Int, v : Double) -> GeobufferpolygonEdge {
  let result = geo_buffer_polygon_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_edge_sum(s : GeobufferpolygonEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_polygon_edge_mean(s : GeobufferpolygonEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_polygon_edge_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_polygon_edge_scale(s : GeobufferpolygonEdge, f : Double) -> GeobufferpolygonEdge {
  let result = geo_buffer_polygon_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_polygon_edge_add(a : GeobufferpolygonEdge, b : GeobufferpolygonEdge) -> GeobufferpolygonEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_polygon_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_polygon_edge_copy(s : GeobufferpolygonEdge) -> GeobufferpolygonEdge {
  let result = geo_buffer_polygon_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_polygon_edge_fill(s : GeobufferpolygonEdge, v : Double) -> GeobufferpolygonEdge {
  let result = geo_buffer_polygon_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_edge_min(s : GeobufferpolygonEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_edge_max(s : GeobufferpolygonEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_edge_to_string(s : GeobufferpolygonEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_path_make(size : Int) -> GeobufferpolygonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_path_len(s : GeobufferpolygonPath) -> Int { s.size }

pub fn geo_buffer_polygon_path_get(s : GeobufferpolygonPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_path_set(s : GeobufferpolygonPath, i : Int, v : Double) -> GeobufferpolygonPath {
  let result = geo_buffer_polygon_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_path_sum(s : GeobufferpolygonPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_polygon_path_mean(s : GeobufferpolygonPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_polygon_path_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_polygon_path_scale(s : GeobufferpolygonPath, f : Double) -> GeobufferpolygonPath {
  let result = geo_buffer_polygon_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_polygon_path_add(a : GeobufferpolygonPath, b : GeobufferpolygonPath) -> GeobufferpolygonPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_polygon_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_polygon_path_copy(s : GeobufferpolygonPath) -> GeobufferpolygonPath {
  let result = geo_buffer_polygon_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_polygon_path_fill(s : GeobufferpolygonPath, v : Double) -> GeobufferpolygonPath {
  let result = geo_buffer_polygon_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_path_min(s : GeobufferpolygonPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_path_max(s : GeobufferpolygonPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_path_to_string(s : GeobufferpolygonPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_cluster_make(size : Int) -> GeobufferpolygonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_cluster_len(s : GeobufferpolygonCluster) -> Int { s.size }

pub fn geo_buffer_polygon_cluster_get(s : GeobufferpolygonCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_cluster_set(s : GeobufferpolygonCluster, i : Int, v : Double) -> GeobufferpolygonCluster {
  let result = geo_buffer_polygon_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_cluster_sum(s : GeobufferpolygonCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_polygon_cluster_mean(s : GeobufferpolygonCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_polygon_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_polygon_cluster_scale(s : GeobufferpolygonCluster, f : Double) -> GeobufferpolygonCluster {
  let result = geo_buffer_polygon_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_polygon_cluster_add(a : GeobufferpolygonCluster, b : GeobufferpolygonCluster) -> GeobufferpolygonCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_polygon_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_polygon_cluster_copy(s : GeobufferpolygonCluster) -> GeobufferpolygonCluster {
  let result = geo_buffer_polygon_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_polygon_cluster_fill(s : GeobufferpolygonCluster, v : Double) -> GeobufferpolygonCluster {
  let result = geo_buffer_polygon_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_cluster_min(s : GeobufferpolygonCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_cluster_max(s : GeobufferpolygonCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_cluster_to_string(s : GeobufferpolygonCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_model_make(size : Int) -> GeobufferpolygonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_model_len(s : GeobufferpolygonModel) -> Int { s.size }

pub fn geo_buffer_polygon_model_get(s : GeobufferpolygonModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_model_set(s : GeobufferpolygonModel, i : Int, v : Double) -> GeobufferpolygonModel {
  let result = geo_buffer_polygon_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_model_sum(s : GeobufferpolygonModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_polygon_model_mean(s : GeobufferpolygonModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_polygon_model_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_polygon_model_scale(s : GeobufferpolygonModel, f : Double) -> GeobufferpolygonModel {
  let result = geo_buffer_polygon_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_polygon_model_add(a : GeobufferpolygonModel, b : GeobufferpolygonModel) -> GeobufferpolygonModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_polygon_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_polygon_model_copy(s : GeobufferpolygonModel) -> GeobufferpolygonModel {
  let result = geo_buffer_polygon_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_polygon_model_fill(s : GeobufferpolygonModel, v : Double) -> GeobufferpolygonModel {
  let result = geo_buffer_polygon_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_model_min(s : GeobufferpolygonModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_model_max(s : GeobufferpolygonModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_model_to_string(s : GeobufferpolygonModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_layer_make(size : Int) -> GeobufferpolygonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_layer_len(s : GeobufferpolygonLayer) -> Int { s.size }

pub fn geo_buffer_polygon_layer_get(s : GeobufferpolygonLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_layer_set(s : GeobufferpolygonLayer, i : Int, v : Double) -> GeobufferpolygonLayer {
  let result = geo_buffer_polygon_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_layer_sum(s : GeobufferpolygonLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_polygon_layer_mean(s : GeobufferpolygonLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_polygon_layer_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_polygon_layer_scale(s : GeobufferpolygonLayer, f : Double) -> GeobufferpolygonLayer {
  let result = geo_buffer_polygon_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_polygon_layer_add(a : GeobufferpolygonLayer, b : GeobufferpolygonLayer) -> GeobufferpolygonLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_polygon_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_polygon_layer_copy(s : GeobufferpolygonLayer) -> GeobufferpolygonLayer {
  let result = geo_buffer_polygon_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_polygon_layer_fill(s : GeobufferpolygonLayer, v : Double) -> GeobufferpolygonLayer {
  let result = geo_buffer_polygon_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_layer_min(s : GeobufferpolygonLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_layer_max(s : GeobufferpolygonLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_layer_to_string(s : GeobufferpolygonLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_buffer_make(size : Int) -> GeobufferpolygonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_buffer_len(s : GeobufferpolygonBuffer) -> Int { s.size }

pub fn geo_buffer_polygon_buffer_get(s : GeobufferpolygonBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_buffer_set(s : GeobufferpolygonBuffer, i : Int, v : Double) -> GeobufferpolygonBuffer {
  let result = geo_buffer_polygon_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_buffer_sum(s : GeobufferpolygonBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_polygon_buffer_mean(s : GeobufferpolygonBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_polygon_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_polygon_buffer_scale(s : GeobufferpolygonBuffer, f : Double) -> GeobufferpolygonBuffer {
  let result = geo_buffer_polygon_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_polygon_buffer_add(a : GeobufferpolygonBuffer, b : GeobufferpolygonBuffer) -> GeobufferpolygonBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_polygon_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_polygon_buffer_copy(s : GeobufferpolygonBuffer) -> GeobufferpolygonBuffer {
  let result = geo_buffer_polygon_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_polygon_buffer_fill(s : GeobufferpolygonBuffer, v : Double) -> GeobufferpolygonBuffer {
  let result = geo_buffer_polygon_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_buffer_min(s : GeobufferpolygonBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_buffer_max(s : GeobufferpolygonBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_buffer_to_string(s : GeobufferpolygonBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_cursor_make(size : Int) -> GeobufferpolygonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_cursor_len(s : GeobufferpolygonCursor) -> Int { s.size }

pub fn geo_buffer_polygon_cursor_get(s : GeobufferpolygonCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_cursor_set(s : GeobufferpolygonCursor, i : Int, v : Double) -> GeobufferpolygonCursor {
  let result = geo_buffer_polygon_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_cursor_sum(s : GeobufferpolygonCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_polygon_cursor_mean(s : GeobufferpolygonCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_polygon_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_polygon_cursor_scale(s : GeobufferpolygonCursor, f : Double) -> GeobufferpolygonCursor {
  let result = geo_buffer_polygon_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_polygon_cursor_add(a : GeobufferpolygonCursor, b : GeobufferpolygonCursor) -> GeobufferpolygonCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_polygon_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_polygon_cursor_copy(s : GeobufferpolygonCursor) -> GeobufferpolygonCursor {
  let result = geo_buffer_polygon_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_polygon_cursor_fill(s : GeobufferpolygonCursor, v : Double) -> GeobufferpolygonCursor {
  let result = geo_buffer_polygon_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_cursor_min(s : GeobufferpolygonCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_cursor_max(s : GeobufferpolygonCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_cursor_to_string(s : GeobufferpolygonCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_view_make(size : Int) -> GeobufferpolygonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_view_len(s : GeobufferpolygonView) -> Int { s.size }

pub fn geo_buffer_polygon_view_get(s : GeobufferpolygonView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_view_set(s : GeobufferpolygonView, i : Int, v : Double) -> GeobufferpolygonView {
  let result = geo_buffer_polygon_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_view_sum(s : GeobufferpolygonView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_polygon_view_mean(s : GeobufferpolygonView) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_polygon_view_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_polygon_view_scale(s : GeobufferpolygonView, f : Double) -> GeobufferpolygonView {
  let result = geo_buffer_polygon_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_polygon_view_add(a : GeobufferpolygonView, b : GeobufferpolygonView) -> GeobufferpolygonView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_polygon_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_polygon_view_copy(s : GeobufferpolygonView) -> GeobufferpolygonView {
  let result = geo_buffer_polygon_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_polygon_view_fill(s : GeobufferpolygonView, v : Double) -> GeobufferpolygonView {
  let result = geo_buffer_polygon_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_view_min(s : GeobufferpolygonView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_view_max(s : GeobufferpolygonView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_view_to_string(s : GeobufferpolygonView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_range_make(size : Int) -> GeobufferpolygonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_range_len(s : GeobufferpolygonRange) -> Int { s.size }

pub fn geo_buffer_polygon_range_get(s : GeobufferpolygonRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_range_set(s : GeobufferpolygonRange, i : Int, v : Double) -> GeobufferpolygonRange {
  let result = geo_buffer_polygon_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_range_sum(s : GeobufferpolygonRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_polygon_range_mean(s : GeobufferpolygonRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_polygon_range_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_polygon_range_scale(s : GeobufferpolygonRange, f : Double) -> GeobufferpolygonRange {
  let result = geo_buffer_polygon_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_polygon_range_add(a : GeobufferpolygonRange, b : GeobufferpolygonRange) -> GeobufferpolygonRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_polygon_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_polygon_range_copy(s : GeobufferpolygonRange) -> GeobufferpolygonRange {
  let result = geo_buffer_polygon_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_polygon_range_fill(s : GeobufferpolygonRange, v : Double) -> GeobufferpolygonRange {
  let result = geo_buffer_polygon_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_range_min(s : GeobufferpolygonRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_range_max(s : GeobufferpolygonRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_range_to_string(s : GeobufferpolygonRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpolygonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_polygon_slice_make(size : Int) -> GeobufferpolygonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_polygon_slice_len(s : GeobufferpolygonSlice) -> Int { s.size }

pub fn geo_buffer_polygon_slice_get(s : GeobufferpolygonSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_polygon_slice_set(s : GeobufferpolygonSlice, i : Int, v : Double) -> GeobufferpolygonSlice {
  let result = geo_buffer_polygon_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_slice_sum(s : GeobufferpolygonSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_polygon_slice_mean(s : GeobufferpolygonSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_polygon_slice_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_polygon_slice_scale(s : GeobufferpolygonSlice, f : Double) -> GeobufferpolygonSlice {
  let result = geo_buffer_polygon_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_polygon_slice_add(a : GeobufferpolygonSlice, b : GeobufferpolygonSlice) -> GeobufferpolygonSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_polygon_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_polygon_slice_copy(s : GeobufferpolygonSlice) -> GeobufferpolygonSlice {
  let result = geo_buffer_polygon_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_polygon_slice_fill(s : GeobufferpolygonSlice, v : Double) -> GeobufferpolygonSlice {
  let result = geo_buffer_polygon_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_polygon_slice_min(s : GeobufferpolygonSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_slice_max(s : GeobufferpolygonSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_polygon_slice_to_string(s : GeobufferpolygonSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

