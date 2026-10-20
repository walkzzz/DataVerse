///===
/// extcore/math_qr_decomp

pub(all) struct MathqrdecompPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_qr_decomp_make_point(x : Double, y : Double) -> MathqrdecompPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_qr_decomp_make_point3(x : Double, y : Double, z : Double) -> MathqrdecompPoint {
  { x, y, z, label: 0 }
}

pub fn math_qr_decomp_point_x(pt : MathqrdecompPoint) -> Double { pt.x }

pub fn math_qr_decomp_point_y(pt : MathqrdecompPoint) -> Double { pt.y }

pub fn math_qr_decomp_point_z(pt : MathqrdecompPoint) -> Double { pt.z }

pub fn math_qr_decomp_point_label(pt : MathqrdecompPoint) -> Int { pt.label }

pub fn math_qr_decomp_point_dist(a : MathqrdecompPoint, b : MathqrdecompPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_qr_decomp_point_add(a : MathqrdecompPoint, b : MathqrdecompPoint) -> MathqrdecompPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_qr_decomp_point_sub(a : MathqrdecompPoint, b : MathqrdecompPoint) -> MathqrdecompPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_qr_decomp_point_scale(pt : MathqrdecompPoint, s : Double) -> MathqrdecompPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_qr_decomp_point_dot(a : MathqrdecompPoint, b : MathqrdecompPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_qr_decomp_point_cross(a : MathqrdecompPoint, b : MathqrdecompPoint) -> MathqrdecompPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_qr_decomp_point_norm(pt : MathqrdecompPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_qr_decomp_point_normalize(pt : MathqrdecompPoint) -> MathqrdecompPoint {
  let n = math_qr_decomp_point_norm(pt)
  if n < 0.0000001 { pt } else { math_qr_decomp_point_scale(pt, 1.0 / n) }
}

pub fn math_qr_decomp_point_negate(pt : MathqrdecompPoint) -> MathqrdecompPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_qr_decomp_point_mid(a : MathqrdecompPoint, b : MathqrdecompPoint) -> MathqrdecompPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_qr_decomp_point_lerp(a : MathqrdecompPoint, b : MathqrdecompPoint, t : Double) -> MathqrdecompPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_qr_decomp_point_to_string(pt : MathqrdecompPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathqrdecompSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_qr_decomp_make_series(vals : Array[Double], name : String) -> MathqrdecompSeries {
  { vals, name, meta: 0 }
}

pub fn math_qr_decomp_series_len(s : MathqrdecompSeries) -> Int { s.vals.length() }

pub fn math_qr_decomp_series_sum(s : MathqrdecompSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_qr_decomp_series_mean(s : MathqrdecompSeries) -> Double { @_common.mean(s.vals) }

pub fn math_qr_decomp_series_min(s : MathqrdecompSeries) -> Double { @_common.min(s.vals) }

pub fn math_qr_decomp_series_max(s : MathqrdecompSeries) -> Double { @_common.max(s.vals) }

pub fn math_qr_decomp_series_range(s : MathqrdecompSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_qr_decomp_series_var(s : MathqrdecompSeries) -> Double { @_common.variance(s.vals) }

pub fn math_qr_decomp_series_std(s : MathqrdecompSeries) -> Double { @_common.std(s.vals) }

pub fn math_qr_decomp_series_median(s : MathqrdecompSeries) -> Double { @_common.median(s.vals) }

pub fn math_qr_decomp_series_scale(s : MathqrdecompSeries, f : Double) -> MathqrdecompSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_qr_decomp_series_add(a : MathqrdecompSeries, b : MathqrdecompSeries) -> MathqrdecompSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_qr_decomp_series_sub(a : MathqrdecompSeries, b : MathqrdecompSeries) -> MathqrdecompSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_qr_decomp_series_normalize(s : MathqrdecompSeries) -> MathqrdecompSeries {
  let mn = math_qr_decomp_series_min(s)
  let mx = math_qr_decomp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_qr_decomp_series_cumsum(s : MathqrdecompSeries) -> MathqrdecompSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_qr_decomp_series_to_string(s : MathqrdecompSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathqrdecompMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_qr_decomp_make_matrix(rows : Int, cols : Int, val : Double) -> MathqrdecompMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_qr_decomp_matrix_identity(n : Int) -> MathqrdecompMatrix {
  let m = math_qr_decomp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_qr_decomp_matrix_get(m : MathqrdecompMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_qr_decomp_matrix_transpose(m : MathqrdecompMatrix) -> MathqrdecompMatrix {
  let result = math_qr_decomp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_qr_decomp_matrix_add(a : MathqrdecompMatrix, b : MathqrdecompMatrix) -> MathqrdecompMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_qr_decomp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_qr_decomp_matrix_scale(m : MathqrdecompMatrix, s : Double) -> MathqrdecompMatrix {
  let result = math_qr_decomp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_qr_decomp_matrix_multiply(a : MathqrdecompMatrix, b : MathqrdecompMatrix) -> MathqrdecompMatrix {
  if a.cols != b.rows { return math_qr_decomp_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_qr_decomp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_qr_decomp_matrix_trace(m : MathqrdecompMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_qr_decomp_matrix_det(m : MathqrdecompMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_qr_decomp_matrix_norm(m : MathqrdecompMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_qr_decomp_matrix_to_string(m : MathqrdecompMatrix) -> String {
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

pub(all) struct MathqrdecompVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_qr_decomp_make_vector(comps : Array[Double]) -> MathqrdecompVector {
  { comps, dim: comps.length() }
}

pub fn math_qr_decomp_vector_zero(dim : Int) -> MathqrdecompVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_qr_decomp_vector_add(a : MathqrdecompVector, b : MathqrdecompVector) -> MathqrdecompVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_qr_decomp_vector_sub(a : MathqrdecompVector, b : MathqrdecompVector) -> MathqrdecompVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_qr_decomp_vector_scale(v : MathqrdecompVector, s : Double) -> MathqrdecompVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_qr_decomp_vector_dot(a : MathqrdecompVector, b : MathqrdecompVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_qr_decomp_vector_norm(v : MathqrdecompVector) -> Double { @_common.sqrt(math_qr_decomp_vector_dot(v, v)) }

pub fn math_qr_decomp_vector_normalize(v : MathqrdecompVector) -> MathqrdecompVector {
  let n = math_qr_decomp_vector_norm(v)
  if n < 0.0000001 { v } else { math_qr_decomp_vector_scale(v, 1.0 / n) }
}

pub fn math_qr_decomp_vector_dist(a : MathqrdecompVector, b : MathqrdecompVector) -> Double {
  math_qr_decomp_vector_norm(math_qr_decomp_vector_sub(a, b))
}

pub fn math_qr_decomp_vector_to_string(v : MathqrdecompVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_qr_decomp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_qr_decomp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_qr_decomp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_qr_decomp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_qr_decomp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_qr_decomp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_qr_decomp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_qr_decomp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_qr_decomp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_qr_decomp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_qr_decomp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_qr_decomp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_qr_decomp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_qr_decomp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_qr_decomp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_qr_decomp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_qr_decomp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_qr_decomp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_qr_decomp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_qr_decomp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_qr_decomp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_qr_decomp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_qr_decomp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_qr_decomp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_qr_decomp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_qr_decomp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_qr_decomp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_qr_decomp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_qr_decomp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathqrdecompFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_frame_make(size : Int) -> MathqrdecompFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_frame_len(s : MathqrdecompFrame) -> Int { s.size }

pub fn math_qr_decomp_frame_get(s : MathqrdecompFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_frame_set(s : MathqrdecompFrame, i : Int, v : Double) -> MathqrdecompFrame {
  let result = math_qr_decomp_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_frame_sum(s : MathqrdecompFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_qr_decomp_frame_mean(s : MathqrdecompFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_qr_decomp_frame_sum(s) / s.size.to_double() }
}

pub fn math_qr_decomp_frame_scale(s : MathqrdecompFrame, f : Double) -> MathqrdecompFrame {
  let result = math_qr_decomp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_qr_decomp_frame_add(a : MathqrdecompFrame, b : MathqrdecompFrame) -> MathqrdecompFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_qr_decomp_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_qr_decomp_frame_copy(s : MathqrdecompFrame) -> MathqrdecompFrame {
  let result = math_qr_decomp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_qr_decomp_frame_fill(s : MathqrdecompFrame, v : Double) -> MathqrdecompFrame {
  let result = math_qr_decomp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_frame_min(s : MathqrdecompFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_frame_max(s : MathqrdecompFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_frame_to_string(s : MathqrdecompFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_table_make(size : Int) -> MathqrdecompTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_table_len(s : MathqrdecompTable) -> Int { s.size }

pub fn math_qr_decomp_table_get(s : MathqrdecompTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_table_set(s : MathqrdecompTable, i : Int, v : Double) -> MathqrdecompTable {
  let result = math_qr_decomp_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_table_sum(s : MathqrdecompTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_qr_decomp_table_mean(s : MathqrdecompTable) -> Double {
  if s.size == 0 { 0.0 } else { math_qr_decomp_table_sum(s) / s.size.to_double() }
}

pub fn math_qr_decomp_table_scale(s : MathqrdecompTable, f : Double) -> MathqrdecompTable {
  let result = math_qr_decomp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_qr_decomp_table_add(a : MathqrdecompTable, b : MathqrdecompTable) -> MathqrdecompTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_qr_decomp_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_qr_decomp_table_copy(s : MathqrdecompTable) -> MathqrdecompTable {
  let result = math_qr_decomp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_qr_decomp_table_fill(s : MathqrdecompTable, v : Double) -> MathqrdecompTable {
  let result = math_qr_decomp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_table_min(s : MathqrdecompTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_table_max(s : MathqrdecompTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_table_to_string(s : MathqrdecompTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_graphn_make(size : Int) -> MathqrdecompGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_graphn_len(s : MathqrdecompGraphN) -> Int { s.size }

pub fn math_qr_decomp_graphn_get(s : MathqrdecompGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_graphn_set(s : MathqrdecompGraphN, i : Int, v : Double) -> MathqrdecompGraphN {
  let result = math_qr_decomp_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_graphn_sum(s : MathqrdecompGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_qr_decomp_graphn_mean(s : MathqrdecompGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_qr_decomp_graphn_sum(s) / s.size.to_double() }
}

pub fn math_qr_decomp_graphn_scale(s : MathqrdecompGraphN, f : Double) -> MathqrdecompGraphN {
  let result = math_qr_decomp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_qr_decomp_graphn_add(a : MathqrdecompGraphN, b : MathqrdecompGraphN) -> MathqrdecompGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_qr_decomp_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_qr_decomp_graphn_copy(s : MathqrdecompGraphN) -> MathqrdecompGraphN {
  let result = math_qr_decomp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_qr_decomp_graphn_fill(s : MathqrdecompGraphN, v : Double) -> MathqrdecompGraphN {
  let result = math_qr_decomp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_graphn_min(s : MathqrdecompGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_graphn_max(s : MathqrdecompGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_graphn_to_string(s : MathqrdecompGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_node_make(size : Int) -> MathqrdecompNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_node_len(s : MathqrdecompNode) -> Int { s.size }

pub fn math_qr_decomp_node_get(s : MathqrdecompNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_node_set(s : MathqrdecompNode, i : Int, v : Double) -> MathqrdecompNode {
  let result = math_qr_decomp_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_node_sum(s : MathqrdecompNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_qr_decomp_node_mean(s : MathqrdecompNode) -> Double {
  if s.size == 0 { 0.0 } else { math_qr_decomp_node_sum(s) / s.size.to_double() }
}

pub fn math_qr_decomp_node_scale(s : MathqrdecompNode, f : Double) -> MathqrdecompNode {
  let result = math_qr_decomp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_qr_decomp_node_add(a : MathqrdecompNode, b : MathqrdecompNode) -> MathqrdecompNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_qr_decomp_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_qr_decomp_node_copy(s : MathqrdecompNode) -> MathqrdecompNode {
  let result = math_qr_decomp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_qr_decomp_node_fill(s : MathqrdecompNode, v : Double) -> MathqrdecompNode {
  let result = math_qr_decomp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_node_min(s : MathqrdecompNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_node_max(s : MathqrdecompNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_node_to_string(s : MathqrdecompNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_edge_make(size : Int) -> MathqrdecompEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_edge_len(s : MathqrdecompEdge) -> Int { s.size }

pub fn math_qr_decomp_edge_get(s : MathqrdecompEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_edge_set(s : MathqrdecompEdge, i : Int, v : Double) -> MathqrdecompEdge {
  let result = math_qr_decomp_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_edge_sum(s : MathqrdecompEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_qr_decomp_edge_mean(s : MathqrdecompEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_qr_decomp_edge_sum(s) / s.size.to_double() }
}

pub fn math_qr_decomp_edge_scale(s : MathqrdecompEdge, f : Double) -> MathqrdecompEdge {
  let result = math_qr_decomp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_qr_decomp_edge_add(a : MathqrdecompEdge, b : MathqrdecompEdge) -> MathqrdecompEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_qr_decomp_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_qr_decomp_edge_copy(s : MathqrdecompEdge) -> MathqrdecompEdge {
  let result = math_qr_decomp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_qr_decomp_edge_fill(s : MathqrdecompEdge, v : Double) -> MathqrdecompEdge {
  let result = math_qr_decomp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_edge_min(s : MathqrdecompEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_edge_max(s : MathqrdecompEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_edge_to_string(s : MathqrdecompEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_path_make(size : Int) -> MathqrdecompPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_path_len(s : MathqrdecompPath) -> Int { s.size }

pub fn math_qr_decomp_path_get(s : MathqrdecompPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_path_set(s : MathqrdecompPath, i : Int, v : Double) -> MathqrdecompPath {
  let result = math_qr_decomp_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_path_sum(s : MathqrdecompPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_qr_decomp_path_mean(s : MathqrdecompPath) -> Double {
  if s.size == 0 { 0.0 } else { math_qr_decomp_path_sum(s) / s.size.to_double() }
}

pub fn math_qr_decomp_path_scale(s : MathqrdecompPath, f : Double) -> MathqrdecompPath {
  let result = math_qr_decomp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_qr_decomp_path_add(a : MathqrdecompPath, b : MathqrdecompPath) -> MathqrdecompPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_qr_decomp_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_qr_decomp_path_copy(s : MathqrdecompPath) -> MathqrdecompPath {
  let result = math_qr_decomp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_qr_decomp_path_fill(s : MathqrdecompPath, v : Double) -> MathqrdecompPath {
  let result = math_qr_decomp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_path_min(s : MathqrdecompPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_path_max(s : MathqrdecompPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_path_to_string(s : MathqrdecompPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_cluster_make(size : Int) -> MathqrdecompCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_cluster_len(s : MathqrdecompCluster) -> Int { s.size }

pub fn math_qr_decomp_cluster_get(s : MathqrdecompCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_cluster_set(s : MathqrdecompCluster, i : Int, v : Double) -> MathqrdecompCluster {
  let result = math_qr_decomp_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_cluster_sum(s : MathqrdecompCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_qr_decomp_cluster_mean(s : MathqrdecompCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_qr_decomp_cluster_sum(s) / s.size.to_double() }
}

pub fn math_qr_decomp_cluster_scale(s : MathqrdecompCluster, f : Double) -> MathqrdecompCluster {
  let result = math_qr_decomp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_qr_decomp_cluster_add(a : MathqrdecompCluster, b : MathqrdecompCluster) -> MathqrdecompCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_qr_decomp_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_qr_decomp_cluster_copy(s : MathqrdecompCluster) -> MathqrdecompCluster {
  let result = math_qr_decomp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_qr_decomp_cluster_fill(s : MathqrdecompCluster, v : Double) -> MathqrdecompCluster {
  let result = math_qr_decomp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_cluster_min(s : MathqrdecompCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_cluster_max(s : MathqrdecompCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_cluster_to_string(s : MathqrdecompCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_model_make(size : Int) -> MathqrdecompModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_model_len(s : MathqrdecompModel) -> Int { s.size }

pub fn math_qr_decomp_model_get(s : MathqrdecompModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_model_set(s : MathqrdecompModel, i : Int, v : Double) -> MathqrdecompModel {
  let result = math_qr_decomp_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_model_sum(s : MathqrdecompModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_qr_decomp_model_mean(s : MathqrdecompModel) -> Double {
  if s.size == 0 { 0.0 } else { math_qr_decomp_model_sum(s) / s.size.to_double() }
}

pub fn math_qr_decomp_model_scale(s : MathqrdecompModel, f : Double) -> MathqrdecompModel {
  let result = math_qr_decomp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_qr_decomp_model_add(a : MathqrdecompModel, b : MathqrdecompModel) -> MathqrdecompModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_qr_decomp_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_qr_decomp_model_copy(s : MathqrdecompModel) -> MathqrdecompModel {
  let result = math_qr_decomp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_qr_decomp_model_fill(s : MathqrdecompModel, v : Double) -> MathqrdecompModel {
  let result = math_qr_decomp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_model_min(s : MathqrdecompModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_model_max(s : MathqrdecompModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_model_to_string(s : MathqrdecompModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_layer_make(size : Int) -> MathqrdecompLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_layer_len(s : MathqrdecompLayer) -> Int { s.size }

pub fn math_qr_decomp_layer_get(s : MathqrdecompLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_layer_set(s : MathqrdecompLayer, i : Int, v : Double) -> MathqrdecompLayer {
  let result = math_qr_decomp_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_layer_sum(s : MathqrdecompLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_qr_decomp_layer_mean(s : MathqrdecompLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_qr_decomp_layer_sum(s) / s.size.to_double() }
}

pub fn math_qr_decomp_layer_scale(s : MathqrdecompLayer, f : Double) -> MathqrdecompLayer {
  let result = math_qr_decomp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_qr_decomp_layer_add(a : MathqrdecompLayer, b : MathqrdecompLayer) -> MathqrdecompLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_qr_decomp_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_qr_decomp_layer_copy(s : MathqrdecompLayer) -> MathqrdecompLayer {
  let result = math_qr_decomp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_qr_decomp_layer_fill(s : MathqrdecompLayer, v : Double) -> MathqrdecompLayer {
  let result = math_qr_decomp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_layer_min(s : MathqrdecompLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_layer_max(s : MathqrdecompLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_layer_to_string(s : MathqrdecompLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_buffer_make(size : Int) -> MathqrdecompBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_buffer_len(s : MathqrdecompBuffer) -> Int { s.size }

pub fn math_qr_decomp_buffer_get(s : MathqrdecompBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_buffer_set(s : MathqrdecompBuffer, i : Int, v : Double) -> MathqrdecompBuffer {
  let result = math_qr_decomp_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_buffer_sum(s : MathqrdecompBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_qr_decomp_buffer_mean(s : MathqrdecompBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_qr_decomp_buffer_sum(s) / s.size.to_double() }
}

pub fn math_qr_decomp_buffer_scale(s : MathqrdecompBuffer, f : Double) -> MathqrdecompBuffer {
  let result = math_qr_decomp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_qr_decomp_buffer_add(a : MathqrdecompBuffer, b : MathqrdecompBuffer) -> MathqrdecompBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_qr_decomp_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_qr_decomp_buffer_copy(s : MathqrdecompBuffer) -> MathqrdecompBuffer {
  let result = math_qr_decomp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_qr_decomp_buffer_fill(s : MathqrdecompBuffer, v : Double) -> MathqrdecompBuffer {
  let result = math_qr_decomp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_buffer_min(s : MathqrdecompBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_buffer_max(s : MathqrdecompBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_buffer_to_string(s : MathqrdecompBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_cursor_make(size : Int) -> MathqrdecompCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_cursor_len(s : MathqrdecompCursor) -> Int { s.size }

pub fn math_qr_decomp_cursor_get(s : MathqrdecompCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_cursor_set(s : MathqrdecompCursor, i : Int, v : Double) -> MathqrdecompCursor {
  let result = math_qr_decomp_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_cursor_sum(s : MathqrdecompCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_qr_decomp_cursor_mean(s : MathqrdecompCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_qr_decomp_cursor_sum(s) / s.size.to_double() }
}

pub fn math_qr_decomp_cursor_scale(s : MathqrdecompCursor, f : Double) -> MathqrdecompCursor {
  let result = math_qr_decomp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_qr_decomp_cursor_add(a : MathqrdecompCursor, b : MathqrdecompCursor) -> MathqrdecompCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_qr_decomp_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_qr_decomp_cursor_copy(s : MathqrdecompCursor) -> MathqrdecompCursor {
  let result = math_qr_decomp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_qr_decomp_cursor_fill(s : MathqrdecompCursor, v : Double) -> MathqrdecompCursor {
  let result = math_qr_decomp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_cursor_min(s : MathqrdecompCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_cursor_max(s : MathqrdecompCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_cursor_to_string(s : MathqrdecompCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_view_make(size : Int) -> MathqrdecompView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_view_len(s : MathqrdecompView) -> Int { s.size }

pub fn math_qr_decomp_view_get(s : MathqrdecompView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_view_set(s : MathqrdecompView, i : Int, v : Double) -> MathqrdecompView {
  let result = math_qr_decomp_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_view_sum(s : MathqrdecompView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_qr_decomp_view_mean(s : MathqrdecompView) -> Double {
  if s.size == 0 { 0.0 } else { math_qr_decomp_view_sum(s) / s.size.to_double() }
}

pub fn math_qr_decomp_view_scale(s : MathqrdecompView, f : Double) -> MathqrdecompView {
  let result = math_qr_decomp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_qr_decomp_view_add(a : MathqrdecompView, b : MathqrdecompView) -> MathqrdecompView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_qr_decomp_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_qr_decomp_view_copy(s : MathqrdecompView) -> MathqrdecompView {
  let result = math_qr_decomp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_qr_decomp_view_fill(s : MathqrdecompView, v : Double) -> MathqrdecompView {
  let result = math_qr_decomp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_view_min(s : MathqrdecompView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_view_max(s : MathqrdecompView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_view_to_string(s : MathqrdecompView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_range_make(size : Int) -> MathqrdecompRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_range_len(s : MathqrdecompRange) -> Int { s.size }

pub fn math_qr_decomp_range_get(s : MathqrdecompRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_range_set(s : MathqrdecompRange, i : Int, v : Double) -> MathqrdecompRange {
  let result = math_qr_decomp_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_range_sum(s : MathqrdecompRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_qr_decomp_range_mean(s : MathqrdecompRange) -> Double {
  if s.size == 0 { 0.0 } else { math_qr_decomp_range_sum(s) / s.size.to_double() }
}

pub fn math_qr_decomp_range_scale(s : MathqrdecompRange, f : Double) -> MathqrdecompRange {
  let result = math_qr_decomp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_qr_decomp_range_add(a : MathqrdecompRange, b : MathqrdecompRange) -> MathqrdecompRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_qr_decomp_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_qr_decomp_range_copy(s : MathqrdecompRange) -> MathqrdecompRange {
  let result = math_qr_decomp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_qr_decomp_range_fill(s : MathqrdecompRange, v : Double) -> MathqrdecompRange {
  let result = math_qr_decomp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_range_min(s : MathqrdecompRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_range_max(s : MathqrdecompRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_range_to_string(s : MathqrdecompRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_slice_make(size : Int) -> MathqrdecompSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_slice_len(s : MathqrdecompSlice) -> Int { s.size }

pub fn math_qr_decomp_slice_get(s : MathqrdecompSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_slice_set(s : MathqrdecompSlice, i : Int, v : Double) -> MathqrdecompSlice {
  let result = math_qr_decomp_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_slice_sum(s : MathqrdecompSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_qr_decomp_slice_mean(s : MathqrdecompSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_qr_decomp_slice_sum(s) / s.size.to_double() }
}

pub fn math_qr_decomp_slice_scale(s : MathqrdecompSlice, f : Double) -> MathqrdecompSlice {
  let result = math_qr_decomp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_qr_decomp_slice_add(a : MathqrdecompSlice, b : MathqrdecompSlice) -> MathqrdecompSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_qr_decomp_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_qr_decomp_slice_copy(s : MathqrdecompSlice) -> MathqrdecompSlice {
  let result = math_qr_decomp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_qr_decomp_slice_fill(s : MathqrdecompSlice, v : Double) -> MathqrdecompSlice {
  let result = math_qr_decomp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_qr_decomp_slice_min(s : MathqrdecompSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_slice_max(s : MathqrdecompSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_qr_decomp_slice_to_string(s : MathqrdecompSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

