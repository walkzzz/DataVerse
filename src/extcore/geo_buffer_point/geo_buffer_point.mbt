///===
/// extcore/geo_buffer_point

pub(all) struct GeobufferpointPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_buffer_point_make_point(x : Double, y : Double) -> GeobufferpointPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_buffer_point_make_point3(x : Double, y : Double, z : Double) -> GeobufferpointPoint {
  { x, y, z, label: 0 }
}

pub fn geo_buffer_point_point_x(pt : GeobufferpointPoint) -> Double { pt.x }

pub fn geo_buffer_point_point_y(pt : GeobufferpointPoint) -> Double { pt.y }

pub fn geo_buffer_point_point_z(pt : GeobufferpointPoint) -> Double { pt.z }

pub fn geo_buffer_point_point_label(pt : GeobufferpointPoint) -> Int { pt.label }

pub fn geo_buffer_point_point_dist(a : GeobufferpointPoint, b : GeobufferpointPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_buffer_point_point_add(a : GeobufferpointPoint, b : GeobufferpointPoint) -> GeobufferpointPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_buffer_point_point_sub(a : GeobufferpointPoint, b : GeobufferpointPoint) -> GeobufferpointPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_buffer_point_point_scale(pt : GeobufferpointPoint, s : Double) -> GeobufferpointPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_buffer_point_point_dot(a : GeobufferpointPoint, b : GeobufferpointPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_buffer_point_point_cross(a : GeobufferpointPoint, b : GeobufferpointPoint) -> GeobufferpointPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_buffer_point_point_norm(pt : GeobufferpointPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_buffer_point_point_normalize(pt : GeobufferpointPoint) -> GeobufferpointPoint {
  let n = geo_buffer_point_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_buffer_point_point_scale(pt, 1.0 / n) }
}

pub fn geo_buffer_point_point_negate(pt : GeobufferpointPoint) -> GeobufferpointPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_buffer_point_point_mid(a : GeobufferpointPoint, b : GeobufferpointPoint) -> GeobufferpointPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_buffer_point_point_lerp(a : GeobufferpointPoint, b : GeobufferpointPoint, t : Double) -> GeobufferpointPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_buffer_point_point_to_string(pt : GeobufferpointPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeobufferpointSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_buffer_point_make_series(vals : Array[Double], name : String) -> GeobufferpointSeries {
  { vals, name, meta: 0 }
}

pub fn geo_buffer_point_series_len(s : GeobufferpointSeries) -> Int { s.vals.length() }

pub fn geo_buffer_point_series_sum(s : GeobufferpointSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_buffer_point_series_mean(s : GeobufferpointSeries) -> Double { @_common.mean(s.vals) }

pub fn geo_buffer_point_series_min(s : GeobufferpointSeries) -> Double { @_common.min(s.vals) }

pub fn geo_buffer_point_series_max(s : GeobufferpointSeries) -> Double { @_common.max(s.vals) }

pub fn geo_buffer_point_series_range(s : GeobufferpointSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn geo_buffer_point_series_var(s : GeobufferpointSeries) -> Double { @_common.variance(s.vals) }

pub fn geo_buffer_point_series_std(s : GeobufferpointSeries) -> Double { @_common.std(s.vals) }

pub fn geo_buffer_point_series_median(s : GeobufferpointSeries) -> Double { @_common.median(s.vals) }

pub fn geo_buffer_point_series_scale(s : GeobufferpointSeries, f : Double) -> GeobufferpointSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_buffer_point_series_add(a : GeobufferpointSeries, b : GeobufferpointSeries) -> GeobufferpointSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_buffer_point_series_sub(a : GeobufferpointSeries, b : GeobufferpointSeries) -> GeobufferpointSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_buffer_point_series_normalize(s : GeobufferpointSeries) -> GeobufferpointSeries {
  let mn = geo_buffer_point_series_min(s)
  let mx = geo_buffer_point_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_buffer_point_series_cumsum(s : GeobufferpointSeries) -> GeobufferpointSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_buffer_point_series_to_string(s : GeobufferpointSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeobufferpointMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_buffer_point_make_matrix(rows : Int, cols : Int, val : Double) -> GeobufferpointMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_buffer_point_matrix_identity(n : Int) -> GeobufferpointMatrix {
  let m = geo_buffer_point_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_buffer_point_matrix_get(m : GeobufferpointMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_buffer_point_matrix_transpose(m : GeobufferpointMatrix) -> GeobufferpointMatrix {
  let result = geo_buffer_point_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_buffer_point_matrix_add(a : GeobufferpointMatrix, b : GeobufferpointMatrix) -> GeobufferpointMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_buffer_point_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_buffer_point_matrix_scale(m : GeobufferpointMatrix, s : Double) -> GeobufferpointMatrix {
  let result = geo_buffer_point_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_buffer_point_matrix_multiply(a : GeobufferpointMatrix, b : GeobufferpointMatrix) -> GeobufferpointMatrix {
  if a.cols != b.rows { return geo_buffer_point_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_buffer_point_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_buffer_point_matrix_trace(m : GeobufferpointMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_buffer_point_matrix_det(m : GeobufferpointMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_buffer_point_matrix_norm(m : GeobufferpointMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_buffer_point_matrix_to_string(m : GeobufferpointMatrix) -> String {
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

pub(all) struct GeobufferpointVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_buffer_point_make_vector(comps : Array[Double]) -> GeobufferpointVector {
  { comps, dim: comps.length() }
}

pub fn geo_buffer_point_vector_zero(dim : Int) -> GeobufferpointVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_buffer_point_vector_add(a : GeobufferpointVector, b : GeobufferpointVector) -> GeobufferpointVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_buffer_point_vector_sub(a : GeobufferpointVector, b : GeobufferpointVector) -> GeobufferpointVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_buffer_point_vector_scale(v : GeobufferpointVector, s : Double) -> GeobufferpointVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_buffer_point_vector_dot(a : GeobufferpointVector, b : GeobufferpointVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_buffer_point_vector_norm(v : GeobufferpointVector) -> Double { @_common.sqrt(geo_buffer_point_vector_dot(v, v)) }

pub fn geo_buffer_point_vector_normalize(v : GeobufferpointVector) -> GeobufferpointVector {
  let n = geo_buffer_point_vector_norm(v)
  if n < 0.0000001 { v } else { geo_buffer_point_vector_scale(v, 1.0 / n) }
}

pub fn geo_buffer_point_vector_dist(a : GeobufferpointVector, b : GeobufferpointVector) -> Double {
  geo_buffer_point_vector_norm(geo_buffer_point_vector_sub(a, b))
}

pub fn geo_buffer_point_vector_to_string(v : GeobufferpointVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_buffer_point_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_buffer_point_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_buffer_point_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_buffer_point_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_buffer_point_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_buffer_point_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_buffer_point_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_buffer_point_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_buffer_point_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_buffer_point_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_buffer_point_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_buffer_point_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_buffer_point_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_buffer_point_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_buffer_point_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_buffer_point_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_buffer_point_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_buffer_point_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_buffer_point_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_buffer_point_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_buffer_point_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_buffer_point_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_buffer_point_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_buffer_point_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_buffer_point_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_buffer_point_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_buffer_point_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_buffer_point_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_buffer_point_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeobufferpointFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_frame_make(size : Int) -> GeobufferpointFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_frame_len(s : GeobufferpointFrame) -> Int { s.size }

pub fn geo_buffer_point_frame_get(s : GeobufferpointFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_frame_set(s : GeobufferpointFrame, i : Int, v : Double) -> GeobufferpointFrame {
  let result = geo_buffer_point_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_frame_sum(s : GeobufferpointFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_point_frame_mean(s : GeobufferpointFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_point_frame_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_point_frame_scale(s : GeobufferpointFrame, f : Double) -> GeobufferpointFrame {
  let result = geo_buffer_point_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_point_frame_add(a : GeobufferpointFrame, b : GeobufferpointFrame) -> GeobufferpointFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_point_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_point_frame_copy(s : GeobufferpointFrame) -> GeobufferpointFrame {
  let result = geo_buffer_point_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_point_frame_fill(s : GeobufferpointFrame, v : Double) -> GeobufferpointFrame {
  let result = geo_buffer_point_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_frame_min(s : GeobufferpointFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_frame_max(s : GeobufferpointFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_frame_to_string(s : GeobufferpointFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_table_make(size : Int) -> GeobufferpointTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_table_len(s : GeobufferpointTable) -> Int { s.size }

pub fn geo_buffer_point_table_get(s : GeobufferpointTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_table_set(s : GeobufferpointTable, i : Int, v : Double) -> GeobufferpointTable {
  let result = geo_buffer_point_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_table_sum(s : GeobufferpointTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_point_table_mean(s : GeobufferpointTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_point_table_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_point_table_scale(s : GeobufferpointTable, f : Double) -> GeobufferpointTable {
  let result = geo_buffer_point_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_point_table_add(a : GeobufferpointTable, b : GeobufferpointTable) -> GeobufferpointTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_point_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_point_table_copy(s : GeobufferpointTable) -> GeobufferpointTable {
  let result = geo_buffer_point_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_point_table_fill(s : GeobufferpointTable, v : Double) -> GeobufferpointTable {
  let result = geo_buffer_point_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_table_min(s : GeobufferpointTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_table_max(s : GeobufferpointTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_table_to_string(s : GeobufferpointTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_graphn_make(size : Int) -> GeobufferpointGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_graphn_len(s : GeobufferpointGraphN) -> Int { s.size }

pub fn geo_buffer_point_graphn_get(s : GeobufferpointGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_graphn_set(s : GeobufferpointGraphN, i : Int, v : Double) -> GeobufferpointGraphN {
  let result = geo_buffer_point_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_graphn_sum(s : GeobufferpointGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_point_graphn_mean(s : GeobufferpointGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_point_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_point_graphn_scale(s : GeobufferpointGraphN, f : Double) -> GeobufferpointGraphN {
  let result = geo_buffer_point_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_point_graphn_add(a : GeobufferpointGraphN, b : GeobufferpointGraphN) -> GeobufferpointGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_point_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_point_graphn_copy(s : GeobufferpointGraphN) -> GeobufferpointGraphN {
  let result = geo_buffer_point_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_point_graphn_fill(s : GeobufferpointGraphN, v : Double) -> GeobufferpointGraphN {
  let result = geo_buffer_point_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_graphn_min(s : GeobufferpointGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_graphn_max(s : GeobufferpointGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_graphn_to_string(s : GeobufferpointGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_node_make(size : Int) -> GeobufferpointNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_node_len(s : GeobufferpointNode) -> Int { s.size }

pub fn geo_buffer_point_node_get(s : GeobufferpointNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_node_set(s : GeobufferpointNode, i : Int, v : Double) -> GeobufferpointNode {
  let result = geo_buffer_point_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_node_sum(s : GeobufferpointNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_point_node_mean(s : GeobufferpointNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_point_node_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_point_node_scale(s : GeobufferpointNode, f : Double) -> GeobufferpointNode {
  let result = geo_buffer_point_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_point_node_add(a : GeobufferpointNode, b : GeobufferpointNode) -> GeobufferpointNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_point_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_point_node_copy(s : GeobufferpointNode) -> GeobufferpointNode {
  let result = geo_buffer_point_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_point_node_fill(s : GeobufferpointNode, v : Double) -> GeobufferpointNode {
  let result = geo_buffer_point_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_node_min(s : GeobufferpointNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_node_max(s : GeobufferpointNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_node_to_string(s : GeobufferpointNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_edge_make(size : Int) -> GeobufferpointEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_edge_len(s : GeobufferpointEdge) -> Int { s.size }

pub fn geo_buffer_point_edge_get(s : GeobufferpointEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_edge_set(s : GeobufferpointEdge, i : Int, v : Double) -> GeobufferpointEdge {
  let result = geo_buffer_point_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_edge_sum(s : GeobufferpointEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_point_edge_mean(s : GeobufferpointEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_point_edge_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_point_edge_scale(s : GeobufferpointEdge, f : Double) -> GeobufferpointEdge {
  let result = geo_buffer_point_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_point_edge_add(a : GeobufferpointEdge, b : GeobufferpointEdge) -> GeobufferpointEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_point_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_point_edge_copy(s : GeobufferpointEdge) -> GeobufferpointEdge {
  let result = geo_buffer_point_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_point_edge_fill(s : GeobufferpointEdge, v : Double) -> GeobufferpointEdge {
  let result = geo_buffer_point_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_edge_min(s : GeobufferpointEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_edge_max(s : GeobufferpointEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_edge_to_string(s : GeobufferpointEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_path_make(size : Int) -> GeobufferpointPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_path_len(s : GeobufferpointPath) -> Int { s.size }

pub fn geo_buffer_point_path_get(s : GeobufferpointPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_path_set(s : GeobufferpointPath, i : Int, v : Double) -> GeobufferpointPath {
  let result = geo_buffer_point_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_path_sum(s : GeobufferpointPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_point_path_mean(s : GeobufferpointPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_point_path_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_point_path_scale(s : GeobufferpointPath, f : Double) -> GeobufferpointPath {
  let result = geo_buffer_point_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_point_path_add(a : GeobufferpointPath, b : GeobufferpointPath) -> GeobufferpointPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_point_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_point_path_copy(s : GeobufferpointPath) -> GeobufferpointPath {
  let result = geo_buffer_point_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_point_path_fill(s : GeobufferpointPath, v : Double) -> GeobufferpointPath {
  let result = geo_buffer_point_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_path_min(s : GeobufferpointPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_path_max(s : GeobufferpointPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_path_to_string(s : GeobufferpointPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_cluster_make(size : Int) -> GeobufferpointCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_cluster_len(s : GeobufferpointCluster) -> Int { s.size }

pub fn geo_buffer_point_cluster_get(s : GeobufferpointCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_cluster_set(s : GeobufferpointCluster, i : Int, v : Double) -> GeobufferpointCluster {
  let result = geo_buffer_point_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_cluster_sum(s : GeobufferpointCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_point_cluster_mean(s : GeobufferpointCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_point_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_point_cluster_scale(s : GeobufferpointCluster, f : Double) -> GeobufferpointCluster {
  let result = geo_buffer_point_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_point_cluster_add(a : GeobufferpointCluster, b : GeobufferpointCluster) -> GeobufferpointCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_point_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_point_cluster_copy(s : GeobufferpointCluster) -> GeobufferpointCluster {
  let result = geo_buffer_point_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_point_cluster_fill(s : GeobufferpointCluster, v : Double) -> GeobufferpointCluster {
  let result = geo_buffer_point_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_cluster_min(s : GeobufferpointCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_cluster_max(s : GeobufferpointCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_cluster_to_string(s : GeobufferpointCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_model_make(size : Int) -> GeobufferpointModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_model_len(s : GeobufferpointModel) -> Int { s.size }

pub fn geo_buffer_point_model_get(s : GeobufferpointModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_model_set(s : GeobufferpointModel, i : Int, v : Double) -> GeobufferpointModel {
  let result = geo_buffer_point_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_model_sum(s : GeobufferpointModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_point_model_mean(s : GeobufferpointModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_point_model_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_point_model_scale(s : GeobufferpointModel, f : Double) -> GeobufferpointModel {
  let result = geo_buffer_point_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_point_model_add(a : GeobufferpointModel, b : GeobufferpointModel) -> GeobufferpointModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_point_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_point_model_copy(s : GeobufferpointModel) -> GeobufferpointModel {
  let result = geo_buffer_point_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_point_model_fill(s : GeobufferpointModel, v : Double) -> GeobufferpointModel {
  let result = geo_buffer_point_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_model_min(s : GeobufferpointModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_model_max(s : GeobufferpointModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_model_to_string(s : GeobufferpointModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_layer_make(size : Int) -> GeobufferpointLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_layer_len(s : GeobufferpointLayer) -> Int { s.size }

pub fn geo_buffer_point_layer_get(s : GeobufferpointLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_layer_set(s : GeobufferpointLayer, i : Int, v : Double) -> GeobufferpointLayer {
  let result = geo_buffer_point_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_layer_sum(s : GeobufferpointLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_point_layer_mean(s : GeobufferpointLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_point_layer_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_point_layer_scale(s : GeobufferpointLayer, f : Double) -> GeobufferpointLayer {
  let result = geo_buffer_point_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_point_layer_add(a : GeobufferpointLayer, b : GeobufferpointLayer) -> GeobufferpointLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_point_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_point_layer_copy(s : GeobufferpointLayer) -> GeobufferpointLayer {
  let result = geo_buffer_point_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_point_layer_fill(s : GeobufferpointLayer, v : Double) -> GeobufferpointLayer {
  let result = geo_buffer_point_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_layer_min(s : GeobufferpointLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_layer_max(s : GeobufferpointLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_layer_to_string(s : GeobufferpointLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_buffer_make(size : Int) -> GeobufferpointBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_buffer_len(s : GeobufferpointBuffer) -> Int { s.size }

pub fn geo_buffer_point_buffer_get(s : GeobufferpointBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_buffer_set(s : GeobufferpointBuffer, i : Int, v : Double) -> GeobufferpointBuffer {
  let result = geo_buffer_point_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_buffer_sum(s : GeobufferpointBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_point_buffer_mean(s : GeobufferpointBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_point_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_point_buffer_scale(s : GeobufferpointBuffer, f : Double) -> GeobufferpointBuffer {
  let result = geo_buffer_point_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_point_buffer_add(a : GeobufferpointBuffer, b : GeobufferpointBuffer) -> GeobufferpointBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_point_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_point_buffer_copy(s : GeobufferpointBuffer) -> GeobufferpointBuffer {
  let result = geo_buffer_point_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_point_buffer_fill(s : GeobufferpointBuffer, v : Double) -> GeobufferpointBuffer {
  let result = geo_buffer_point_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_buffer_min(s : GeobufferpointBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_buffer_max(s : GeobufferpointBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_buffer_to_string(s : GeobufferpointBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_cursor_make(size : Int) -> GeobufferpointCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_cursor_len(s : GeobufferpointCursor) -> Int { s.size }

pub fn geo_buffer_point_cursor_get(s : GeobufferpointCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_cursor_set(s : GeobufferpointCursor, i : Int, v : Double) -> GeobufferpointCursor {
  let result = geo_buffer_point_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_cursor_sum(s : GeobufferpointCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_point_cursor_mean(s : GeobufferpointCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_point_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_point_cursor_scale(s : GeobufferpointCursor, f : Double) -> GeobufferpointCursor {
  let result = geo_buffer_point_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_point_cursor_add(a : GeobufferpointCursor, b : GeobufferpointCursor) -> GeobufferpointCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_point_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_point_cursor_copy(s : GeobufferpointCursor) -> GeobufferpointCursor {
  let result = geo_buffer_point_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_point_cursor_fill(s : GeobufferpointCursor, v : Double) -> GeobufferpointCursor {
  let result = geo_buffer_point_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_cursor_min(s : GeobufferpointCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_cursor_max(s : GeobufferpointCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_cursor_to_string(s : GeobufferpointCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_view_make(size : Int) -> GeobufferpointView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_view_len(s : GeobufferpointView) -> Int { s.size }

pub fn geo_buffer_point_view_get(s : GeobufferpointView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_view_set(s : GeobufferpointView, i : Int, v : Double) -> GeobufferpointView {
  let result = geo_buffer_point_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_view_sum(s : GeobufferpointView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_point_view_mean(s : GeobufferpointView) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_point_view_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_point_view_scale(s : GeobufferpointView, f : Double) -> GeobufferpointView {
  let result = geo_buffer_point_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_point_view_add(a : GeobufferpointView, b : GeobufferpointView) -> GeobufferpointView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_point_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_point_view_copy(s : GeobufferpointView) -> GeobufferpointView {
  let result = geo_buffer_point_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_point_view_fill(s : GeobufferpointView, v : Double) -> GeobufferpointView {
  let result = geo_buffer_point_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_view_min(s : GeobufferpointView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_view_max(s : GeobufferpointView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_view_to_string(s : GeobufferpointView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_range_make(size : Int) -> GeobufferpointRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_range_len(s : GeobufferpointRange) -> Int { s.size }

pub fn geo_buffer_point_range_get(s : GeobufferpointRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_range_set(s : GeobufferpointRange, i : Int, v : Double) -> GeobufferpointRange {
  let result = geo_buffer_point_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_range_sum(s : GeobufferpointRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_point_range_mean(s : GeobufferpointRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_point_range_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_point_range_scale(s : GeobufferpointRange, f : Double) -> GeobufferpointRange {
  let result = geo_buffer_point_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_point_range_add(a : GeobufferpointRange, b : GeobufferpointRange) -> GeobufferpointRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_point_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_point_range_copy(s : GeobufferpointRange) -> GeobufferpointRange {
  let result = geo_buffer_point_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_point_range_fill(s : GeobufferpointRange, v : Double) -> GeobufferpointRange {
  let result = geo_buffer_point_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_range_min(s : GeobufferpointRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_range_max(s : GeobufferpointRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_range_to_string(s : GeobufferpointRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeobufferpointSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_buffer_point_slice_make(size : Int) -> GeobufferpointSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_buffer_point_slice_len(s : GeobufferpointSlice) -> Int { s.size }

pub fn geo_buffer_point_slice_get(s : GeobufferpointSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_buffer_point_slice_set(s : GeobufferpointSlice, i : Int, v : Double) -> GeobufferpointSlice {
  let result = geo_buffer_point_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_slice_sum(s : GeobufferpointSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_buffer_point_slice_mean(s : GeobufferpointSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_buffer_point_slice_sum(s) / s.size.to_double() }
}

pub fn geo_buffer_point_slice_scale(s : GeobufferpointSlice, f : Double) -> GeobufferpointSlice {
  let result = geo_buffer_point_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_buffer_point_slice_add(a : GeobufferpointSlice, b : GeobufferpointSlice) -> GeobufferpointSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_buffer_point_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_buffer_point_slice_copy(s : GeobufferpointSlice) -> GeobufferpointSlice {
  let result = geo_buffer_point_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_buffer_point_slice_fill(s : GeobufferpointSlice, v : Double) -> GeobufferpointSlice {
  let result = geo_buffer_point_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_buffer_point_slice_min(s : GeobufferpointSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_slice_max(s : GeobufferpointSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_buffer_point_slice_to_string(s : GeobufferpointSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

