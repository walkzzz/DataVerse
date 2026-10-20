///===
/// extcore/geo_proj_lambert

pub(all) struct GeoprojlambertPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_lambert_make_point(x : Double, y : Double) -> GeoprojlambertPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_lambert_make_point3(x : Double, y : Double, z : Double) -> GeoprojlambertPoint {
  { x, y, z, label: 0 }
}

pub fn geo_proj_lambert_point_x(pt : GeoprojlambertPoint) -> Double { pt.x }

pub fn geo_proj_lambert_point_y(pt : GeoprojlambertPoint) -> Double { pt.y }

pub fn geo_proj_lambert_point_z(pt : GeoprojlambertPoint) -> Double { pt.z }

pub fn geo_proj_lambert_point_label(pt : GeoprojlambertPoint) -> Int { pt.label }

pub fn geo_proj_lambert_point_dist(a : GeoprojlambertPoint, b : GeoprojlambertPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_proj_lambert_point_add(a : GeoprojlambertPoint, b : GeoprojlambertPoint) -> GeoprojlambertPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_proj_lambert_point_sub(a : GeoprojlambertPoint, b : GeoprojlambertPoint) -> GeoprojlambertPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_proj_lambert_point_scale(pt : GeoprojlambertPoint, s : Double) -> GeoprojlambertPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_proj_lambert_point_dot(a : GeoprojlambertPoint, b : GeoprojlambertPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_proj_lambert_point_cross(a : GeoprojlambertPoint, b : GeoprojlambertPoint) -> GeoprojlambertPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_proj_lambert_point_norm(pt : GeoprojlambertPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_proj_lambert_point_normalize(pt : GeoprojlambertPoint) -> GeoprojlambertPoint {
  let n = geo_proj_lambert_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_proj_lambert_point_scale(pt, 1.0 / n) }
}

pub fn geo_proj_lambert_point_negate(pt : GeoprojlambertPoint) -> GeoprojlambertPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_proj_lambert_point_mid(a : GeoprojlambertPoint, b : GeoprojlambertPoint) -> GeoprojlambertPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_proj_lambert_point_lerp(a : GeoprojlambertPoint, b : GeoprojlambertPoint, t : Double) -> GeoprojlambertPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_proj_lambert_point_to_string(pt : GeoprojlambertPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeoprojlambertSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_lambert_make_series(vals : Array[Double], name : String) -> GeoprojlambertSeries {
  { vals, name, meta: 0 }
}

pub fn geo_proj_lambert_series_len(s : GeoprojlambertSeries) -> Int { s.vals.length() }

pub fn geo_proj_lambert_series_sum(s : GeoprojlambertSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_proj_lambert_series_mean(s : GeoprojlambertSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_proj_lambert_series_min(s : GeoprojlambertSeries) -> Double { @_common.min(s.vals) }

pub fn geo_proj_lambert_series_max(s : GeoprojlambertSeries) -> Double { @_common.max(s.vals) }

pub fn geo_proj_lambert_series_range(s : GeoprojlambertSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_proj_lambert_series_var(s : GeoprojlambertSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_proj_lambert_series_std(s : GeoprojlambertSeries) -> Double { @_common.std(s.vals) }

pub fn geo_proj_lambert_series_median(s : GeoprojlambertSeries) -> Double { @_common.median(s.vals) }

pub fn geo_proj_lambert_series_scale(s : GeoprojlambertSeries, f : Double) -> GeoprojlambertSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_proj_lambert_series_add(a : GeoprojlambertSeries, b : GeoprojlambertSeries) -> GeoprojlambertSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_proj_lambert_series_sub(a : GeoprojlambertSeries, b : GeoprojlambertSeries) -> GeoprojlambertSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_proj_lambert_series_normalize(s : GeoprojlambertSeries) -> GeoprojlambertSeries {
  let mn = geo_proj_lambert_series_min(s)
  let mx = geo_proj_lambert_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_proj_lambert_series_cumsum(s : GeoprojlambertSeries) -> GeoprojlambertSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_proj_lambert_series_to_string(s : GeoprojlambertSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojlambertMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_lambert_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojlambertMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_lambert_matrix_identity(n : Int) -> GeoprojlambertMatrix {
  let m = geo_proj_lambert_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_proj_lambert_matrix_get(m : GeoprojlambertMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_proj_lambert_matrix_transpose(m : GeoprojlambertMatrix) -> GeoprojlambertMatrix {
  let result = geo_proj_lambert_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_proj_lambert_matrix_add(a : GeoprojlambertMatrix, b : GeoprojlambertMatrix) -> GeoprojlambertMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_proj_lambert_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_proj_lambert_matrix_scale(m : GeoprojlambertMatrix, s : Double) -> GeoprojlambertMatrix {
  let result = geo_proj_lambert_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_proj_lambert_matrix_multiply(a : GeoprojlambertMatrix, b : GeoprojlambertMatrix) -> GeoprojlambertMatrix {
  if a.cols != b.rows { return geo_proj_lambert_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_proj_lambert_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_proj_lambert_matrix_trace(m : GeoprojlambertMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_proj_lambert_matrix_det(m : GeoprojlambertMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_proj_lambert_matrix_norm(m : GeoprojlambertMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_proj_lambert_matrix_to_string(m : GeoprojlambertMatrix) -> String {
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

pub(all) struct GeoprojlambertVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_lambert_make_vector(comps : Array[Double]) -> GeoprojlambertVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_lambert_vector_zero(dim : Int) -> GeoprojlambertVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_proj_lambert_vector_add(a : GeoprojlambertVector, b : GeoprojlambertVector) -> GeoprojlambertVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_proj_lambert_vector_sub(a : GeoprojlambertVector, b : GeoprojlambertVector) -> GeoprojlambertVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_proj_lambert_vector_scale(v : GeoprojlambertVector, s : Double) -> GeoprojlambertVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_proj_lambert_vector_dot(a : GeoprojlambertVector, b : GeoprojlambertVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_proj_lambert_vector_norm(v : GeoprojlambertVector) -> Double { @_common.sqrt(geo_proj_lambert_vector_dot(v, v)) }

pub fn geo_proj_lambert_vector_normalize(v : GeoprojlambertVector) -> GeoprojlambertVector {
  let n = geo_proj_lambert_vector_norm(v)
  if n < 0.0000001 { v } else { geo_proj_lambert_vector_scale(v, 1.0 / n) }
}

pub fn geo_proj_lambert_vector_dist(a : GeoprojlambertVector, b : GeoprojlambertVector) -> Double {
  geo_proj_lambert_vector_norm(geo_proj_lambert_vector_sub(a, b))
}

pub fn geo_proj_lambert_vector_to_string(v : GeoprojlambertVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_lambert_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_proj_lambert_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_proj_lambert_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_proj_lambert_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_proj_lambert_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_proj_lambert_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_proj_lambert_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_proj_lambert_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_proj_lambert_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_proj_lambert_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_proj_lambert_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_proj_lambert_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_proj_lambert_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_proj_lambert_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_proj_lambert_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_proj_lambert_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_proj_lambert_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_proj_lambert_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_proj_lambert_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_proj_lambert_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_proj_lambert_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_proj_lambert_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_proj_lambert_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_proj_lambert_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_proj_lambert_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_proj_lambert_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_proj_lambert_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_proj_lambert_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_proj_lambert_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeoprojlambertFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_frame_make(size : Int) -> GeoprojlambertFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_frame_len(s : GeoprojlambertFrame) -> Int { s.size }

pub fn geo_proj_lambert_frame_get(s : GeoprojlambertFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_frame_set(s : GeoprojlambertFrame, i : Int, v : Double) -> GeoprojlambertFrame {
  let result = geo_proj_lambert_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_frame_sum(s : GeoprojlambertFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_lambert_frame_mean(s : GeoprojlambertFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_lambert_frame_sum(s) / s.size.to_double() }
}

pub fn geo_proj_lambert_frame_scale(s : GeoprojlambertFrame, f : Double) -> GeoprojlambertFrame {
  let result = geo_proj_lambert_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_lambert_frame_add(a : GeoprojlambertFrame, b : GeoprojlambertFrame) -> GeoprojlambertFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_lambert_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_lambert_frame_copy(s : GeoprojlambertFrame) -> GeoprojlambertFrame {
  let result = geo_proj_lambert_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_lambert_frame_fill(s : GeoprojlambertFrame, v : Double) -> GeoprojlambertFrame {
  let result = geo_proj_lambert_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_frame_min(s : GeoprojlambertFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_frame_max(s : GeoprojlambertFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_frame_to_string(s : GeoprojlambertFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_table_make(size : Int) -> GeoprojlambertTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_table_len(s : GeoprojlambertTable) -> Int { s.size }

pub fn geo_proj_lambert_table_get(s : GeoprojlambertTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_table_set(s : GeoprojlambertTable, i : Int, v : Double) -> GeoprojlambertTable {
  let result = geo_proj_lambert_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_table_sum(s : GeoprojlambertTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_lambert_table_mean(s : GeoprojlambertTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_lambert_table_sum(s) / s.size.to_double() }
}

pub fn geo_proj_lambert_table_scale(s : GeoprojlambertTable, f : Double) -> GeoprojlambertTable {
  let result = geo_proj_lambert_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_lambert_table_add(a : GeoprojlambertTable, b : GeoprojlambertTable) -> GeoprojlambertTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_lambert_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_lambert_table_copy(s : GeoprojlambertTable) -> GeoprojlambertTable {
  let result = geo_proj_lambert_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_lambert_table_fill(s : GeoprojlambertTable, v : Double) -> GeoprojlambertTable {
  let result = geo_proj_lambert_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_table_min(s : GeoprojlambertTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_table_max(s : GeoprojlambertTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_table_to_string(s : GeoprojlambertTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_graphn_make(size : Int) -> GeoprojlambertGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_graphn_len(s : GeoprojlambertGraphN) -> Int { s.size }

pub fn geo_proj_lambert_graphn_get(s : GeoprojlambertGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_graphn_set(s : GeoprojlambertGraphN, i : Int, v : Double) -> GeoprojlambertGraphN {
  let result = geo_proj_lambert_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_graphn_sum(s : GeoprojlambertGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_lambert_graphn_mean(s : GeoprojlambertGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_lambert_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_proj_lambert_graphn_scale(s : GeoprojlambertGraphN, f : Double) -> GeoprojlambertGraphN {
  let result = geo_proj_lambert_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_lambert_graphn_add(a : GeoprojlambertGraphN, b : GeoprojlambertGraphN) -> GeoprojlambertGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_lambert_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_lambert_graphn_copy(s : GeoprojlambertGraphN) -> GeoprojlambertGraphN {
  let result = geo_proj_lambert_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_lambert_graphn_fill(s : GeoprojlambertGraphN, v : Double) -> GeoprojlambertGraphN {
  let result = geo_proj_lambert_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_graphn_min(s : GeoprojlambertGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_graphn_max(s : GeoprojlambertGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_graphn_to_string(s : GeoprojlambertGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_node_make(size : Int) -> GeoprojlambertNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_node_len(s : GeoprojlambertNode) -> Int { s.size }

pub fn geo_proj_lambert_node_get(s : GeoprojlambertNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_node_set(s : GeoprojlambertNode, i : Int, v : Double) -> GeoprojlambertNode {
  let result = geo_proj_lambert_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_node_sum(s : GeoprojlambertNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_lambert_node_mean(s : GeoprojlambertNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_lambert_node_sum(s) / s.size.to_double() }
}

pub fn geo_proj_lambert_node_scale(s : GeoprojlambertNode, f : Double) -> GeoprojlambertNode {
  let result = geo_proj_lambert_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_lambert_node_add(a : GeoprojlambertNode, b : GeoprojlambertNode) -> GeoprojlambertNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_lambert_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_lambert_node_copy(s : GeoprojlambertNode) -> GeoprojlambertNode {
  let result = geo_proj_lambert_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_lambert_node_fill(s : GeoprojlambertNode, v : Double) -> GeoprojlambertNode {
  let result = geo_proj_lambert_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_node_min(s : GeoprojlambertNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_node_max(s : GeoprojlambertNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_node_to_string(s : GeoprojlambertNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_edge_make(size : Int) -> GeoprojlambertEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_edge_len(s : GeoprojlambertEdge) -> Int { s.size }

pub fn geo_proj_lambert_edge_get(s : GeoprojlambertEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_edge_set(s : GeoprojlambertEdge, i : Int, v : Double) -> GeoprojlambertEdge {
  let result = geo_proj_lambert_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_edge_sum(s : GeoprojlambertEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_lambert_edge_mean(s : GeoprojlambertEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_lambert_edge_sum(s) / s.size.to_double() }
}

pub fn geo_proj_lambert_edge_scale(s : GeoprojlambertEdge, f : Double) -> GeoprojlambertEdge {
  let result = geo_proj_lambert_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_lambert_edge_add(a : GeoprojlambertEdge, b : GeoprojlambertEdge) -> GeoprojlambertEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_lambert_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_lambert_edge_copy(s : GeoprojlambertEdge) -> GeoprojlambertEdge {
  let result = geo_proj_lambert_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_lambert_edge_fill(s : GeoprojlambertEdge, v : Double) -> GeoprojlambertEdge {
  let result = geo_proj_lambert_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_edge_min(s : GeoprojlambertEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_edge_max(s : GeoprojlambertEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_edge_to_string(s : GeoprojlambertEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_path_make(size : Int) -> GeoprojlambertPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_path_len(s : GeoprojlambertPath) -> Int { s.size }

pub fn geo_proj_lambert_path_get(s : GeoprojlambertPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_path_set(s : GeoprojlambertPath, i : Int, v : Double) -> GeoprojlambertPath {
  let result = geo_proj_lambert_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_path_sum(s : GeoprojlambertPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_lambert_path_mean(s : GeoprojlambertPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_lambert_path_sum(s) / s.size.to_double() }
}

pub fn geo_proj_lambert_path_scale(s : GeoprojlambertPath, f : Double) -> GeoprojlambertPath {
  let result = geo_proj_lambert_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_lambert_path_add(a : GeoprojlambertPath, b : GeoprojlambertPath) -> GeoprojlambertPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_lambert_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_lambert_path_copy(s : GeoprojlambertPath) -> GeoprojlambertPath {
  let result = geo_proj_lambert_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_lambert_path_fill(s : GeoprojlambertPath, v : Double) -> GeoprojlambertPath {
  let result = geo_proj_lambert_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_path_min(s : GeoprojlambertPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_path_max(s : GeoprojlambertPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_path_to_string(s : GeoprojlambertPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_cluster_make(size : Int) -> GeoprojlambertCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_cluster_len(s : GeoprojlambertCluster) -> Int { s.size }

pub fn geo_proj_lambert_cluster_get(s : GeoprojlambertCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_cluster_set(s : GeoprojlambertCluster, i : Int, v : Double) -> GeoprojlambertCluster {
  let result = geo_proj_lambert_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_cluster_sum(s : GeoprojlambertCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_lambert_cluster_mean(s : GeoprojlambertCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_lambert_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_proj_lambert_cluster_scale(s : GeoprojlambertCluster, f : Double) -> GeoprojlambertCluster {
  let result = geo_proj_lambert_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_lambert_cluster_add(a : GeoprojlambertCluster, b : GeoprojlambertCluster) -> GeoprojlambertCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_lambert_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_lambert_cluster_copy(s : GeoprojlambertCluster) -> GeoprojlambertCluster {
  let result = geo_proj_lambert_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_lambert_cluster_fill(s : GeoprojlambertCluster, v : Double) -> GeoprojlambertCluster {
  let result = geo_proj_lambert_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_cluster_min(s : GeoprojlambertCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_cluster_max(s : GeoprojlambertCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_cluster_to_string(s : GeoprojlambertCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_model_make(size : Int) -> GeoprojlambertModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_model_len(s : GeoprojlambertModel) -> Int { s.size }

pub fn geo_proj_lambert_model_get(s : GeoprojlambertModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_model_set(s : GeoprojlambertModel, i : Int, v : Double) -> GeoprojlambertModel {
  let result = geo_proj_lambert_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_model_sum(s : GeoprojlambertModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_lambert_model_mean(s : GeoprojlambertModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_lambert_model_sum(s) / s.size.to_double() }
}

pub fn geo_proj_lambert_model_scale(s : GeoprojlambertModel, f : Double) -> GeoprojlambertModel {
  let result = geo_proj_lambert_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_lambert_model_add(a : GeoprojlambertModel, b : GeoprojlambertModel) -> GeoprojlambertModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_lambert_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_lambert_model_copy(s : GeoprojlambertModel) -> GeoprojlambertModel {
  let result = geo_proj_lambert_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_lambert_model_fill(s : GeoprojlambertModel, v : Double) -> GeoprojlambertModel {
  let result = geo_proj_lambert_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_model_min(s : GeoprojlambertModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_model_max(s : GeoprojlambertModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_model_to_string(s : GeoprojlambertModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_layer_make(size : Int) -> GeoprojlambertLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_layer_len(s : GeoprojlambertLayer) -> Int { s.size }

pub fn geo_proj_lambert_layer_get(s : GeoprojlambertLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_layer_set(s : GeoprojlambertLayer, i : Int, v : Double) -> GeoprojlambertLayer {
  let result = geo_proj_lambert_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_layer_sum(s : GeoprojlambertLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_lambert_layer_mean(s : GeoprojlambertLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_lambert_layer_sum(s) / s.size.to_double() }
}

pub fn geo_proj_lambert_layer_scale(s : GeoprojlambertLayer, f : Double) -> GeoprojlambertLayer {
  let result = geo_proj_lambert_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_lambert_layer_add(a : GeoprojlambertLayer, b : GeoprojlambertLayer) -> GeoprojlambertLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_lambert_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_lambert_layer_copy(s : GeoprojlambertLayer) -> GeoprojlambertLayer {
  let result = geo_proj_lambert_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_lambert_layer_fill(s : GeoprojlambertLayer, v : Double) -> GeoprojlambertLayer {
  let result = geo_proj_lambert_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_layer_min(s : GeoprojlambertLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_layer_max(s : GeoprojlambertLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_layer_to_string(s : GeoprojlambertLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_buffer_make(size : Int) -> GeoprojlambertBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_buffer_len(s : GeoprojlambertBuffer) -> Int { s.size }

pub fn geo_proj_lambert_buffer_get(s : GeoprojlambertBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_buffer_set(s : GeoprojlambertBuffer, i : Int, v : Double) -> GeoprojlambertBuffer {
  let result = geo_proj_lambert_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_buffer_sum(s : GeoprojlambertBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_lambert_buffer_mean(s : GeoprojlambertBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_lambert_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_proj_lambert_buffer_scale(s : GeoprojlambertBuffer, f : Double) -> GeoprojlambertBuffer {
  let result = geo_proj_lambert_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_lambert_buffer_add(a : GeoprojlambertBuffer, b : GeoprojlambertBuffer) -> GeoprojlambertBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_lambert_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_lambert_buffer_copy(s : GeoprojlambertBuffer) -> GeoprojlambertBuffer {
  let result = geo_proj_lambert_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_lambert_buffer_fill(s : GeoprojlambertBuffer, v : Double) -> GeoprojlambertBuffer {
  let result = geo_proj_lambert_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_buffer_min(s : GeoprojlambertBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_buffer_max(s : GeoprojlambertBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_buffer_to_string(s : GeoprojlambertBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_cursor_make(size : Int) -> GeoprojlambertCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_cursor_len(s : GeoprojlambertCursor) -> Int { s.size }

pub fn geo_proj_lambert_cursor_get(s : GeoprojlambertCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_cursor_set(s : GeoprojlambertCursor, i : Int, v : Double) -> GeoprojlambertCursor {
  let result = geo_proj_lambert_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_cursor_sum(s : GeoprojlambertCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_lambert_cursor_mean(s : GeoprojlambertCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_lambert_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_proj_lambert_cursor_scale(s : GeoprojlambertCursor, f : Double) -> GeoprojlambertCursor {
  let result = geo_proj_lambert_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_lambert_cursor_add(a : GeoprojlambertCursor, b : GeoprojlambertCursor) -> GeoprojlambertCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_lambert_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_lambert_cursor_copy(s : GeoprojlambertCursor) -> GeoprojlambertCursor {
  let result = geo_proj_lambert_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_lambert_cursor_fill(s : GeoprojlambertCursor, v : Double) -> GeoprojlambertCursor {
  let result = geo_proj_lambert_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_cursor_min(s : GeoprojlambertCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_cursor_max(s : GeoprojlambertCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_cursor_to_string(s : GeoprojlambertCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_view_make(size : Int) -> GeoprojlambertView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_view_len(s : GeoprojlambertView) -> Int { s.size }

pub fn geo_proj_lambert_view_get(s : GeoprojlambertView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_view_set(s : GeoprojlambertView, i : Int, v : Double) -> GeoprojlambertView {
  let result = geo_proj_lambert_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_view_sum(s : GeoprojlambertView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_lambert_view_mean(s : GeoprojlambertView) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_lambert_view_sum(s) / s.size.to_double() }
}

pub fn geo_proj_lambert_view_scale(s : GeoprojlambertView, f : Double) -> GeoprojlambertView {
  let result = geo_proj_lambert_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_lambert_view_add(a : GeoprojlambertView, b : GeoprojlambertView) -> GeoprojlambertView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_lambert_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_lambert_view_copy(s : GeoprojlambertView) -> GeoprojlambertView {
  let result = geo_proj_lambert_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_lambert_view_fill(s : GeoprojlambertView, v : Double) -> GeoprojlambertView {
  let result = geo_proj_lambert_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_view_min(s : GeoprojlambertView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_view_max(s : GeoprojlambertView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_view_to_string(s : GeoprojlambertView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_range_make(size : Int) -> GeoprojlambertRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_range_len(s : GeoprojlambertRange) -> Int { s.size }

pub fn geo_proj_lambert_range_get(s : GeoprojlambertRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_range_set(s : GeoprojlambertRange, i : Int, v : Double) -> GeoprojlambertRange {
  let result = geo_proj_lambert_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_range_sum(s : GeoprojlambertRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_lambert_range_mean(s : GeoprojlambertRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_lambert_range_sum(s) / s.size.to_double() }
}

pub fn geo_proj_lambert_range_scale(s : GeoprojlambertRange, f : Double) -> GeoprojlambertRange {
  let result = geo_proj_lambert_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_lambert_range_add(a : GeoprojlambertRange, b : GeoprojlambertRange) -> GeoprojlambertRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_lambert_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_lambert_range_copy(s : GeoprojlambertRange) -> GeoprojlambertRange {
  let result = geo_proj_lambert_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_lambert_range_fill(s : GeoprojlambertRange, v : Double) -> GeoprojlambertRange {
  let result = geo_proj_lambert_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_range_min(s : GeoprojlambertRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_range_max(s : GeoprojlambertRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_range_to_string(s : GeoprojlambertRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_slice_make(size : Int) -> GeoprojlambertSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_slice_len(s : GeoprojlambertSlice) -> Int { s.size }

pub fn geo_proj_lambert_slice_get(s : GeoprojlambertSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_slice_set(s : GeoprojlambertSlice, i : Int, v : Double) -> GeoprojlambertSlice {
  let result = geo_proj_lambert_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_slice_sum(s : GeoprojlambertSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_lambert_slice_mean(s : GeoprojlambertSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_lambert_slice_sum(s) / s.size.to_double() }
}

pub fn geo_proj_lambert_slice_scale(s : GeoprojlambertSlice, f : Double) -> GeoprojlambertSlice {
  let result = geo_proj_lambert_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_lambert_slice_add(a : GeoprojlambertSlice, b : GeoprojlambertSlice) -> GeoprojlambertSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_lambert_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_lambert_slice_copy(s : GeoprojlambertSlice) -> GeoprojlambertSlice {
  let result = geo_proj_lambert_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_lambert_slice_fill(s : GeoprojlambertSlice, v : Double) -> GeoprojlambertSlice {
  let result = geo_proj_lambert_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_lambert_slice_min(s : GeoprojlambertSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_slice_max(s : GeoprojlambertSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_lambert_slice_to_string(s : GeoprojlambertSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

