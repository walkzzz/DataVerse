///===
/// extcore/geo_proj_mercator

pub(all) struct GeoprojmercatorPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_mercator_make_point(x : Double, y : Double) -> GeoprojmercatorPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_mercator_make_point3(x : Double, y : Double, z : Double) -> GeoprojmercatorPoint {
  { x, y, z, label: 0 }
}

pub fn geo_proj_mercator_point_x(pt : GeoprojmercatorPoint) -> Double { pt.x }

pub fn geo_proj_mercator_point_y(pt : GeoprojmercatorPoint) -> Double { pt.y }

pub fn geo_proj_mercator_point_z(pt : GeoprojmercatorPoint) -> Double { pt.z }

pub fn geo_proj_mercator_point_label(pt : GeoprojmercatorPoint) -> Int { pt.label }

pub fn geo_proj_mercator_point_dist(a : GeoprojmercatorPoint, b : GeoprojmercatorPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_proj_mercator_point_add(a : GeoprojmercatorPoint, b : GeoprojmercatorPoint) -> GeoprojmercatorPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_proj_mercator_point_sub(a : GeoprojmercatorPoint, b : GeoprojmercatorPoint) -> GeoprojmercatorPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_proj_mercator_point_scale(pt : GeoprojmercatorPoint, s : Double) -> GeoprojmercatorPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_proj_mercator_point_dot(a : GeoprojmercatorPoint, b : GeoprojmercatorPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_proj_mercator_point_cross(a : GeoprojmercatorPoint, b : GeoprojmercatorPoint) -> GeoprojmercatorPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_proj_mercator_point_norm(pt : GeoprojmercatorPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_proj_mercator_point_normalize(pt : GeoprojmercatorPoint) -> GeoprojmercatorPoint {
  let n = geo_proj_mercator_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_proj_mercator_point_scale(pt, 1.0 / n) }
}

pub fn geo_proj_mercator_point_negate(pt : GeoprojmercatorPoint) -> GeoprojmercatorPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_proj_mercator_point_mid(a : GeoprojmercatorPoint, b : GeoprojmercatorPoint) -> GeoprojmercatorPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_proj_mercator_point_lerp(a : GeoprojmercatorPoint, b : GeoprojmercatorPoint, t : Double) -> GeoprojmercatorPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_proj_mercator_point_to_string(pt : GeoprojmercatorPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeoprojmercatorSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_mercator_make_series(vals : Array[Double], name : String) -> GeoprojmercatorSeries {
  { vals, name, meta: 0 }
}

pub fn geo_proj_mercator_series_len(s : GeoprojmercatorSeries) -> Int { s.vals.length() }

pub fn geo_proj_mercator_series_sum(s : GeoprojmercatorSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_proj_mercator_series_mean(s : GeoprojmercatorSeries) -> Double {
  let n = geo_proj_mercator_series_len(s)
  if n == 0 { 0.0 } else { geo_proj_mercator_series_sum(s) / n.to_double() }
}

pub fn geo_proj_mercator_series_min(s : GeoprojmercatorSeries) -> Double {
  let n = geo_proj_mercator_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_proj_mercator_series_max(s : GeoprojmercatorSeries) -> Double {
  let n = geo_proj_mercator_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_proj_mercator_series_range(s : GeoprojmercatorSeries) -> Double {
  geo_proj_mercator_series_max(s) - geo_proj_mercator_series_min(s)
}

pub fn geo_proj_mercator_series_var(s : GeoprojmercatorSeries) -> Double {
  let n = geo_proj_mercator_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_proj_mercator_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_proj_mercator_series_std(s : GeoprojmercatorSeries) -> Double { @_common.sqrt(geo_proj_mercator_series_var(s)) }

pub fn geo_proj_mercator_series_median(s : GeoprojmercatorSeries) -> Double {
  let n = geo_proj_mercator_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_proj_mercator_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_proj_mercator_series_scale(s : GeoprojmercatorSeries, f : Double) -> GeoprojmercatorSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_proj_mercator_series_add(a : GeoprojmercatorSeries, b : GeoprojmercatorSeries) -> GeoprojmercatorSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_proj_mercator_series_sub(a : GeoprojmercatorSeries, b : GeoprojmercatorSeries) -> GeoprojmercatorSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_proj_mercator_series_normalize(s : GeoprojmercatorSeries) -> GeoprojmercatorSeries {
  let mn = geo_proj_mercator_series_min(s)
  let mx = geo_proj_mercator_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_proj_mercator_series_cumsum(s : GeoprojmercatorSeries) -> GeoprojmercatorSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_proj_mercator_series_to_string(s : GeoprojmercatorSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojmercatorMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_mercator_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojmercatorMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_mercator_matrix_identity(n : Int) -> GeoprojmercatorMatrix {
  let m = geo_proj_mercator_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_proj_mercator_matrix_get(m : GeoprojmercatorMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_proj_mercator_matrix_transpose(m : GeoprojmercatorMatrix) -> GeoprojmercatorMatrix {
  let result = geo_proj_mercator_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_proj_mercator_matrix_add(a : GeoprojmercatorMatrix, b : GeoprojmercatorMatrix) -> GeoprojmercatorMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_proj_mercator_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_proj_mercator_matrix_scale(m : GeoprojmercatorMatrix, s : Double) -> GeoprojmercatorMatrix {
  let result = geo_proj_mercator_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_proj_mercator_matrix_multiply(a : GeoprojmercatorMatrix, b : GeoprojmercatorMatrix) -> GeoprojmercatorMatrix {
  if a.cols != b.rows { return geo_proj_mercator_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_proj_mercator_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_proj_mercator_matrix_trace(m : GeoprojmercatorMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_proj_mercator_matrix_det(m : GeoprojmercatorMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_proj_mercator_matrix_norm(m : GeoprojmercatorMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_proj_mercator_matrix_to_string(m : GeoprojmercatorMatrix) -> String {
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

pub(all) struct GeoprojmercatorVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_mercator_make_vector(comps : Array[Double]) -> GeoprojmercatorVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_mercator_vector_zero(dim : Int) -> GeoprojmercatorVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_proj_mercator_vector_add(a : GeoprojmercatorVector, b : GeoprojmercatorVector) -> GeoprojmercatorVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_proj_mercator_vector_sub(a : GeoprojmercatorVector, b : GeoprojmercatorVector) -> GeoprojmercatorVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_proj_mercator_vector_scale(v : GeoprojmercatorVector, s : Double) -> GeoprojmercatorVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_proj_mercator_vector_dot(a : GeoprojmercatorVector, b : GeoprojmercatorVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_proj_mercator_vector_norm(v : GeoprojmercatorVector) -> Double { @_common.sqrt(geo_proj_mercator_vector_dot(v, v)) }

pub fn geo_proj_mercator_vector_normalize(v : GeoprojmercatorVector) -> GeoprojmercatorVector {
  let n = geo_proj_mercator_vector_norm(v)
  if n < 0.0000001 { v } else { geo_proj_mercator_vector_scale(v, 1.0 / n) }
}

pub fn geo_proj_mercator_vector_dist(a : GeoprojmercatorVector, b : GeoprojmercatorVector) -> Double {
  geo_proj_mercator_vector_norm(geo_proj_mercator_vector_sub(a, b))
}

pub fn geo_proj_mercator_vector_to_string(v : GeoprojmercatorVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_mercator_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_proj_mercator_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_proj_mercator_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_proj_mercator_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_proj_mercator_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_proj_mercator_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_proj_mercator_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_proj_mercator_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_proj_mercator_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_proj_mercator_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_proj_mercator_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_proj_mercator_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_proj_mercator_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_proj_mercator_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_proj_mercator_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_proj_mercator_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_proj_mercator_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_proj_mercator_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_proj_mercator_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_proj_mercator_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_proj_mercator_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_proj_mercator_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_proj_mercator_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_proj_mercator_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_proj_mercator_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_proj_mercator_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_proj_mercator_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_proj_mercator_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_proj_mercator_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeoprojmercatorFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_frame_make(size : Int) -> GeoprojmercatorFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_mercator_frame_len(s : GeoprojmercatorFrame) -> Int { s.size }

pub fn geo_proj_mercator_frame_get(s : GeoprojmercatorFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_mercator_frame_set(s : GeoprojmercatorFrame, i : Int, v : Double) -> GeoprojmercatorFrame {
  let result = geo_proj_mercator_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_frame_sum(s : GeoprojmercatorFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_mercator_frame_mean(s : GeoprojmercatorFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_mercator_frame_sum(s) / s.size.to_double() }
}

pub fn geo_proj_mercator_frame_scale(s : GeoprojmercatorFrame, f : Double) -> GeoprojmercatorFrame {
  let result = geo_proj_mercator_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_mercator_frame_add(a : GeoprojmercatorFrame, b : GeoprojmercatorFrame) -> GeoprojmercatorFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_mercator_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_mercator_frame_copy(s : GeoprojmercatorFrame) -> GeoprojmercatorFrame {
  let result = geo_proj_mercator_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_mercator_frame_fill(s : GeoprojmercatorFrame, v : Double) -> GeoprojmercatorFrame {
  let result = geo_proj_mercator_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_frame_min(s : GeoprojmercatorFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_frame_max(s : GeoprojmercatorFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_frame_to_string(s : GeoprojmercatorFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_table_make(size : Int) -> GeoprojmercatorTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_mercator_table_len(s : GeoprojmercatorTable) -> Int { s.size }

pub fn geo_proj_mercator_table_get(s : GeoprojmercatorTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_mercator_table_set(s : GeoprojmercatorTable, i : Int, v : Double) -> GeoprojmercatorTable {
  let result = geo_proj_mercator_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_table_sum(s : GeoprojmercatorTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_mercator_table_mean(s : GeoprojmercatorTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_mercator_table_sum(s) / s.size.to_double() }
}

pub fn geo_proj_mercator_table_scale(s : GeoprojmercatorTable, f : Double) -> GeoprojmercatorTable {
  let result = geo_proj_mercator_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_mercator_table_add(a : GeoprojmercatorTable, b : GeoprojmercatorTable) -> GeoprojmercatorTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_mercator_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_mercator_table_copy(s : GeoprojmercatorTable) -> GeoprojmercatorTable {
  let result = geo_proj_mercator_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_mercator_table_fill(s : GeoprojmercatorTable, v : Double) -> GeoprojmercatorTable {
  let result = geo_proj_mercator_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_table_min(s : GeoprojmercatorTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_table_max(s : GeoprojmercatorTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_table_to_string(s : GeoprojmercatorTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_graphn_make(size : Int) -> GeoprojmercatorGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_mercator_graphn_len(s : GeoprojmercatorGraphN) -> Int { s.size }

pub fn geo_proj_mercator_graphn_get(s : GeoprojmercatorGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_mercator_graphn_set(s : GeoprojmercatorGraphN, i : Int, v : Double) -> GeoprojmercatorGraphN {
  let result = geo_proj_mercator_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_graphn_sum(s : GeoprojmercatorGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_mercator_graphn_mean(s : GeoprojmercatorGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_mercator_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_proj_mercator_graphn_scale(s : GeoprojmercatorGraphN, f : Double) -> GeoprojmercatorGraphN {
  let result = geo_proj_mercator_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_mercator_graphn_add(a : GeoprojmercatorGraphN, b : GeoprojmercatorGraphN) -> GeoprojmercatorGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_mercator_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_mercator_graphn_copy(s : GeoprojmercatorGraphN) -> GeoprojmercatorGraphN {
  let result = geo_proj_mercator_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_mercator_graphn_fill(s : GeoprojmercatorGraphN, v : Double) -> GeoprojmercatorGraphN {
  let result = geo_proj_mercator_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_graphn_min(s : GeoprojmercatorGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_graphn_max(s : GeoprojmercatorGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_graphn_to_string(s : GeoprojmercatorGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_node_make(size : Int) -> GeoprojmercatorNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_mercator_node_len(s : GeoprojmercatorNode) -> Int { s.size }

pub fn geo_proj_mercator_node_get(s : GeoprojmercatorNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_mercator_node_set(s : GeoprojmercatorNode, i : Int, v : Double) -> GeoprojmercatorNode {
  let result = geo_proj_mercator_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_node_sum(s : GeoprojmercatorNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_mercator_node_mean(s : GeoprojmercatorNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_mercator_node_sum(s) / s.size.to_double() }
}

pub fn geo_proj_mercator_node_scale(s : GeoprojmercatorNode, f : Double) -> GeoprojmercatorNode {
  let result = geo_proj_mercator_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_mercator_node_add(a : GeoprojmercatorNode, b : GeoprojmercatorNode) -> GeoprojmercatorNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_mercator_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_mercator_node_copy(s : GeoprojmercatorNode) -> GeoprojmercatorNode {
  let result = geo_proj_mercator_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_mercator_node_fill(s : GeoprojmercatorNode, v : Double) -> GeoprojmercatorNode {
  let result = geo_proj_mercator_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_node_min(s : GeoprojmercatorNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_node_max(s : GeoprojmercatorNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_node_to_string(s : GeoprojmercatorNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_edge_make(size : Int) -> GeoprojmercatorEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_mercator_edge_len(s : GeoprojmercatorEdge) -> Int { s.size }

pub fn geo_proj_mercator_edge_get(s : GeoprojmercatorEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_mercator_edge_set(s : GeoprojmercatorEdge, i : Int, v : Double) -> GeoprojmercatorEdge {
  let result = geo_proj_mercator_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_edge_sum(s : GeoprojmercatorEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_mercator_edge_mean(s : GeoprojmercatorEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_mercator_edge_sum(s) / s.size.to_double() }
}

pub fn geo_proj_mercator_edge_scale(s : GeoprojmercatorEdge, f : Double) -> GeoprojmercatorEdge {
  let result = geo_proj_mercator_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_mercator_edge_add(a : GeoprojmercatorEdge, b : GeoprojmercatorEdge) -> GeoprojmercatorEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_mercator_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_mercator_edge_copy(s : GeoprojmercatorEdge) -> GeoprojmercatorEdge {
  let result = geo_proj_mercator_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_mercator_edge_fill(s : GeoprojmercatorEdge, v : Double) -> GeoprojmercatorEdge {
  let result = geo_proj_mercator_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_edge_min(s : GeoprojmercatorEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_edge_max(s : GeoprojmercatorEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_edge_to_string(s : GeoprojmercatorEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_path_make(size : Int) -> GeoprojmercatorPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_mercator_path_len(s : GeoprojmercatorPath) -> Int { s.size }

pub fn geo_proj_mercator_path_get(s : GeoprojmercatorPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_mercator_path_set(s : GeoprojmercatorPath, i : Int, v : Double) -> GeoprojmercatorPath {
  let result = geo_proj_mercator_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_path_sum(s : GeoprojmercatorPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_mercator_path_mean(s : GeoprojmercatorPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_mercator_path_sum(s) / s.size.to_double() }
}

pub fn geo_proj_mercator_path_scale(s : GeoprojmercatorPath, f : Double) -> GeoprojmercatorPath {
  let result = geo_proj_mercator_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_mercator_path_add(a : GeoprojmercatorPath, b : GeoprojmercatorPath) -> GeoprojmercatorPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_mercator_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_mercator_path_copy(s : GeoprojmercatorPath) -> GeoprojmercatorPath {
  let result = geo_proj_mercator_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_mercator_path_fill(s : GeoprojmercatorPath, v : Double) -> GeoprojmercatorPath {
  let result = geo_proj_mercator_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_path_min(s : GeoprojmercatorPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_path_max(s : GeoprojmercatorPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_path_to_string(s : GeoprojmercatorPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_cluster_make(size : Int) -> GeoprojmercatorCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_mercator_cluster_len(s : GeoprojmercatorCluster) -> Int { s.size }

pub fn geo_proj_mercator_cluster_get(s : GeoprojmercatorCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_mercator_cluster_set(s : GeoprojmercatorCluster, i : Int, v : Double) -> GeoprojmercatorCluster {
  let result = geo_proj_mercator_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_cluster_sum(s : GeoprojmercatorCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_mercator_cluster_mean(s : GeoprojmercatorCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_mercator_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_proj_mercator_cluster_scale(s : GeoprojmercatorCluster, f : Double) -> GeoprojmercatorCluster {
  let result = geo_proj_mercator_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_mercator_cluster_add(a : GeoprojmercatorCluster, b : GeoprojmercatorCluster) -> GeoprojmercatorCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_mercator_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_mercator_cluster_copy(s : GeoprojmercatorCluster) -> GeoprojmercatorCluster {
  let result = geo_proj_mercator_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_mercator_cluster_fill(s : GeoprojmercatorCluster, v : Double) -> GeoprojmercatorCluster {
  let result = geo_proj_mercator_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_cluster_min(s : GeoprojmercatorCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_cluster_max(s : GeoprojmercatorCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_cluster_to_string(s : GeoprojmercatorCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_model_make(size : Int) -> GeoprojmercatorModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_mercator_model_len(s : GeoprojmercatorModel) -> Int { s.size }

pub fn geo_proj_mercator_model_get(s : GeoprojmercatorModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_mercator_model_set(s : GeoprojmercatorModel, i : Int, v : Double) -> GeoprojmercatorModel {
  let result = geo_proj_mercator_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_model_sum(s : GeoprojmercatorModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_mercator_model_mean(s : GeoprojmercatorModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_mercator_model_sum(s) / s.size.to_double() }
}

pub fn geo_proj_mercator_model_scale(s : GeoprojmercatorModel, f : Double) -> GeoprojmercatorModel {
  let result = geo_proj_mercator_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_mercator_model_add(a : GeoprojmercatorModel, b : GeoprojmercatorModel) -> GeoprojmercatorModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_mercator_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_mercator_model_copy(s : GeoprojmercatorModel) -> GeoprojmercatorModel {
  let result = geo_proj_mercator_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_mercator_model_fill(s : GeoprojmercatorModel, v : Double) -> GeoprojmercatorModel {
  let result = geo_proj_mercator_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_model_min(s : GeoprojmercatorModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_model_max(s : GeoprojmercatorModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_model_to_string(s : GeoprojmercatorModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_layer_make(size : Int) -> GeoprojmercatorLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_mercator_layer_len(s : GeoprojmercatorLayer) -> Int { s.size }

pub fn geo_proj_mercator_layer_get(s : GeoprojmercatorLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_mercator_layer_set(s : GeoprojmercatorLayer, i : Int, v : Double) -> GeoprojmercatorLayer {
  let result = geo_proj_mercator_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_layer_sum(s : GeoprojmercatorLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_mercator_layer_mean(s : GeoprojmercatorLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_mercator_layer_sum(s) / s.size.to_double() }
}

pub fn geo_proj_mercator_layer_scale(s : GeoprojmercatorLayer, f : Double) -> GeoprojmercatorLayer {
  let result = geo_proj_mercator_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_mercator_layer_add(a : GeoprojmercatorLayer, b : GeoprojmercatorLayer) -> GeoprojmercatorLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_mercator_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_mercator_layer_copy(s : GeoprojmercatorLayer) -> GeoprojmercatorLayer {
  let result = geo_proj_mercator_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_mercator_layer_fill(s : GeoprojmercatorLayer, v : Double) -> GeoprojmercatorLayer {
  let result = geo_proj_mercator_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_layer_min(s : GeoprojmercatorLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_layer_max(s : GeoprojmercatorLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_layer_to_string(s : GeoprojmercatorLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_buffer_make(size : Int) -> GeoprojmercatorBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_mercator_buffer_len(s : GeoprojmercatorBuffer) -> Int { s.size }

pub fn geo_proj_mercator_buffer_get(s : GeoprojmercatorBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_mercator_buffer_set(s : GeoprojmercatorBuffer, i : Int, v : Double) -> GeoprojmercatorBuffer {
  let result = geo_proj_mercator_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_buffer_sum(s : GeoprojmercatorBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_mercator_buffer_mean(s : GeoprojmercatorBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_mercator_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_proj_mercator_buffer_scale(s : GeoprojmercatorBuffer, f : Double) -> GeoprojmercatorBuffer {
  let result = geo_proj_mercator_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_mercator_buffer_add(a : GeoprojmercatorBuffer, b : GeoprojmercatorBuffer) -> GeoprojmercatorBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_mercator_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_mercator_buffer_copy(s : GeoprojmercatorBuffer) -> GeoprojmercatorBuffer {
  let result = geo_proj_mercator_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_mercator_buffer_fill(s : GeoprojmercatorBuffer, v : Double) -> GeoprojmercatorBuffer {
  let result = geo_proj_mercator_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_buffer_min(s : GeoprojmercatorBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_buffer_max(s : GeoprojmercatorBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_buffer_to_string(s : GeoprojmercatorBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_cursor_make(size : Int) -> GeoprojmercatorCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_mercator_cursor_len(s : GeoprojmercatorCursor) -> Int { s.size }

pub fn geo_proj_mercator_cursor_get(s : GeoprojmercatorCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_mercator_cursor_set(s : GeoprojmercatorCursor, i : Int, v : Double) -> GeoprojmercatorCursor {
  let result = geo_proj_mercator_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_cursor_sum(s : GeoprojmercatorCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_mercator_cursor_mean(s : GeoprojmercatorCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_mercator_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_proj_mercator_cursor_scale(s : GeoprojmercatorCursor, f : Double) -> GeoprojmercatorCursor {
  let result = geo_proj_mercator_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_mercator_cursor_add(a : GeoprojmercatorCursor, b : GeoprojmercatorCursor) -> GeoprojmercatorCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_mercator_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_mercator_cursor_copy(s : GeoprojmercatorCursor) -> GeoprojmercatorCursor {
  let result = geo_proj_mercator_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_mercator_cursor_fill(s : GeoprojmercatorCursor, v : Double) -> GeoprojmercatorCursor {
  let result = geo_proj_mercator_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_cursor_min(s : GeoprojmercatorCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_cursor_max(s : GeoprojmercatorCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_cursor_to_string(s : GeoprojmercatorCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_view_make(size : Int) -> GeoprojmercatorView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_mercator_view_len(s : GeoprojmercatorView) -> Int { s.size }

pub fn geo_proj_mercator_view_get(s : GeoprojmercatorView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_mercator_view_set(s : GeoprojmercatorView, i : Int, v : Double) -> GeoprojmercatorView {
  let result = geo_proj_mercator_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_view_sum(s : GeoprojmercatorView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_mercator_view_mean(s : GeoprojmercatorView) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_mercator_view_sum(s) / s.size.to_double() }
}

pub fn geo_proj_mercator_view_scale(s : GeoprojmercatorView, f : Double) -> GeoprojmercatorView {
  let result = geo_proj_mercator_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_mercator_view_add(a : GeoprojmercatorView, b : GeoprojmercatorView) -> GeoprojmercatorView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_mercator_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_mercator_view_copy(s : GeoprojmercatorView) -> GeoprojmercatorView {
  let result = geo_proj_mercator_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_mercator_view_fill(s : GeoprojmercatorView, v : Double) -> GeoprojmercatorView {
  let result = geo_proj_mercator_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_view_min(s : GeoprojmercatorView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_view_max(s : GeoprojmercatorView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_view_to_string(s : GeoprojmercatorView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_range_make(size : Int) -> GeoprojmercatorRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_mercator_range_len(s : GeoprojmercatorRange) -> Int { s.size }

pub fn geo_proj_mercator_range_get(s : GeoprojmercatorRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_mercator_range_set(s : GeoprojmercatorRange, i : Int, v : Double) -> GeoprojmercatorRange {
  let result = geo_proj_mercator_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_range_sum(s : GeoprojmercatorRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_mercator_range_mean(s : GeoprojmercatorRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_mercator_range_sum(s) / s.size.to_double() }
}

pub fn geo_proj_mercator_range_scale(s : GeoprojmercatorRange, f : Double) -> GeoprojmercatorRange {
  let result = geo_proj_mercator_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_mercator_range_add(a : GeoprojmercatorRange, b : GeoprojmercatorRange) -> GeoprojmercatorRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_mercator_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_mercator_range_copy(s : GeoprojmercatorRange) -> GeoprojmercatorRange {
  let result = geo_proj_mercator_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_mercator_range_fill(s : GeoprojmercatorRange, v : Double) -> GeoprojmercatorRange {
  let result = geo_proj_mercator_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_range_min(s : GeoprojmercatorRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_range_max(s : GeoprojmercatorRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_range_to_string(s : GeoprojmercatorRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_slice_make(size : Int) -> GeoprojmercatorSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_mercator_slice_len(s : GeoprojmercatorSlice) -> Int { s.size }

pub fn geo_proj_mercator_slice_get(s : GeoprojmercatorSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_mercator_slice_set(s : GeoprojmercatorSlice, i : Int, v : Double) -> GeoprojmercatorSlice {
  let result = geo_proj_mercator_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_slice_sum(s : GeoprojmercatorSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_mercator_slice_mean(s : GeoprojmercatorSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_mercator_slice_sum(s) / s.size.to_double() }
}

pub fn geo_proj_mercator_slice_scale(s : GeoprojmercatorSlice, f : Double) -> GeoprojmercatorSlice {
  let result = geo_proj_mercator_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_mercator_slice_add(a : GeoprojmercatorSlice, b : GeoprojmercatorSlice) -> GeoprojmercatorSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_mercator_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_mercator_slice_copy(s : GeoprojmercatorSlice) -> GeoprojmercatorSlice {
  let result = geo_proj_mercator_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_mercator_slice_fill(s : GeoprojmercatorSlice, v : Double) -> GeoprojmercatorSlice {
  let result = geo_proj_mercator_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_mercator_slice_min(s : GeoprojmercatorSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_slice_max(s : GeoprojmercatorSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_mercator_slice_to_string(s : GeoprojmercatorSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

