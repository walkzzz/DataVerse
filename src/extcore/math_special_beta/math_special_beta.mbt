///===
/// extcore/math_special_beta

pub(all) struct MathspecialbetaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_beta_make_point(x : Double, y : Double) -> MathspecialbetaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_beta_make_point3(x : Double, y : Double, z : Double) -> MathspecialbetaPoint {
  { x, y, z, label: 0 }
}

pub fn math_special_beta_point_x(pt : MathspecialbetaPoint) -> Double { pt.x }

pub fn math_special_beta_point_y(pt : MathspecialbetaPoint) -> Double { pt.y }

pub fn math_special_beta_point_z(pt : MathspecialbetaPoint) -> Double { pt.z }

pub fn math_special_beta_point_label(pt : MathspecialbetaPoint) -> Int { pt.label }

pub fn math_special_beta_point_dist(a : MathspecialbetaPoint, b : MathspecialbetaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_special_beta_point_add(a : MathspecialbetaPoint, b : MathspecialbetaPoint) -> MathspecialbetaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_special_beta_point_sub(a : MathspecialbetaPoint, b : MathspecialbetaPoint) -> MathspecialbetaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_special_beta_point_scale(pt : MathspecialbetaPoint, s : Double) -> MathspecialbetaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_special_beta_point_dot(a : MathspecialbetaPoint, b : MathspecialbetaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_special_beta_point_cross(a : MathspecialbetaPoint, b : MathspecialbetaPoint) -> MathspecialbetaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_special_beta_point_norm(pt : MathspecialbetaPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_special_beta_point_normalize(pt : MathspecialbetaPoint) -> MathspecialbetaPoint {
  let n = math_special_beta_point_norm(pt)
  if n < 0.0000001 { pt } else { math_special_beta_point_scale(pt, 1.0 / n) }
}

pub fn math_special_beta_point_negate(pt : MathspecialbetaPoint) -> MathspecialbetaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_special_beta_point_mid(a : MathspecialbetaPoint, b : MathspecialbetaPoint) -> MathspecialbetaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_special_beta_point_lerp(a : MathspecialbetaPoint, b : MathspecialbetaPoint, t : Double) -> MathspecialbetaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_special_beta_point_to_string(pt : MathspecialbetaPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathspecialbetaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_beta_make_series(vals : Array[Double], name : String) -> MathspecialbetaSeries {
  { vals, name, meta: 0 }
}

pub fn math_special_beta_series_len(s : MathspecialbetaSeries) -> Int { s.vals.length() }

pub fn math_special_beta_series_sum(s : MathspecialbetaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_special_beta_series_mean(s : MathspecialbetaSeries) -> Double { @_common.mean(s.vals) }

pub fn math_special_beta_series_min(s : MathspecialbetaSeries) -> Double { @_common.min(s.vals) }

pub fn math_special_beta_series_max(s : MathspecialbetaSeries) -> Double { @_common.max(s.vals) }

pub fn math_special_beta_series_range(s : MathspecialbetaSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_special_beta_series_var(s : MathspecialbetaSeries) -> Double { @_common.variance(s.vals) }

pub fn math_special_beta_series_std(s : MathspecialbetaSeries) -> Double { @_common.std(s.vals) }

pub fn math_special_beta_series_median(s : MathspecialbetaSeries) -> Double { @_common.median(s.vals) }

pub fn math_special_beta_series_scale(s : MathspecialbetaSeries, f : Double) -> MathspecialbetaSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_special_beta_series_add(a : MathspecialbetaSeries, b : MathspecialbetaSeries) -> MathspecialbetaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_special_beta_series_sub(a : MathspecialbetaSeries, b : MathspecialbetaSeries) -> MathspecialbetaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_special_beta_series_normalize(s : MathspecialbetaSeries) -> MathspecialbetaSeries {
  let mn = math_special_beta_series_min(s)
  let mx = math_special_beta_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_special_beta_series_cumsum(s : MathspecialbetaSeries) -> MathspecialbetaSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_special_beta_series_to_string(s : MathspecialbetaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialbetaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_beta_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialbetaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_beta_matrix_identity(n : Int) -> MathspecialbetaMatrix {
  let m = math_special_beta_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_special_beta_matrix_get(m : MathspecialbetaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_special_beta_matrix_transpose(m : MathspecialbetaMatrix) -> MathspecialbetaMatrix {
  let result = math_special_beta_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_special_beta_matrix_add(a : MathspecialbetaMatrix, b : MathspecialbetaMatrix) -> MathspecialbetaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_special_beta_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_special_beta_matrix_scale(m : MathspecialbetaMatrix, s : Double) -> MathspecialbetaMatrix {
  let result = math_special_beta_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_special_beta_matrix_multiply(a : MathspecialbetaMatrix, b : MathspecialbetaMatrix) -> MathspecialbetaMatrix {
  if a.cols != b.rows { return math_special_beta_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_special_beta_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_special_beta_matrix_trace(m : MathspecialbetaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_special_beta_matrix_det(m : MathspecialbetaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_special_beta_matrix_norm(m : MathspecialbetaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_special_beta_matrix_to_string(m : MathspecialbetaMatrix) -> String {
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

pub(all) struct MathspecialbetaVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_beta_make_vector(comps : Array[Double]) -> MathspecialbetaVector {
  { comps, dim: comps.length() }
}

pub fn math_special_beta_vector_zero(dim : Int) -> MathspecialbetaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_special_beta_vector_add(a : MathspecialbetaVector, b : MathspecialbetaVector) -> MathspecialbetaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_beta_vector_sub(a : MathspecialbetaVector, b : MathspecialbetaVector) -> MathspecialbetaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_special_beta_vector_scale(v : MathspecialbetaVector, s : Double) -> MathspecialbetaVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_special_beta_vector_dot(a : MathspecialbetaVector, b : MathspecialbetaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_special_beta_vector_norm(v : MathspecialbetaVector) -> Double { @_common.sqrt(math_special_beta_vector_dot(v, v)) }

pub fn math_special_beta_vector_normalize(v : MathspecialbetaVector) -> MathspecialbetaVector {
  let n = math_special_beta_vector_norm(v)
  if n < 0.0000001 { v } else { math_special_beta_vector_scale(v, 1.0 / n) }
}

pub fn math_special_beta_vector_dist(a : MathspecialbetaVector, b : MathspecialbetaVector) -> Double {
  math_special_beta_vector_norm(math_special_beta_vector_sub(a, b))
}

pub fn math_special_beta_vector_to_string(v : MathspecialbetaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_beta_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_beta_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_beta_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_beta_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_beta_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_beta_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_beta_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_beta_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_beta_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_beta_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_beta_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_beta_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_beta_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_beta_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_beta_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_beta_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_beta_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_beta_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_beta_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_beta_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_beta_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_beta_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_beta_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_beta_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_beta_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_beta_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_beta_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_beta_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_beta_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspecialbetaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_frame_make(size : Int) -> MathspecialbetaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_frame_len(s : MathspecialbetaFrame) -> Int { s.size }

pub fn math_special_beta_frame_get(s : MathspecialbetaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_frame_set(s : MathspecialbetaFrame, i : Int, v : Double) -> MathspecialbetaFrame {
  let result = math_special_beta_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_frame_sum(s : MathspecialbetaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_beta_frame_mean(s : MathspecialbetaFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_special_beta_frame_sum(s) / s.size.to_double() }
}

pub fn math_special_beta_frame_scale(s : MathspecialbetaFrame, f : Double) -> MathspecialbetaFrame {
  let result = math_special_beta_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_beta_frame_add(a : MathspecialbetaFrame, b : MathspecialbetaFrame) -> MathspecialbetaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_beta_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_beta_frame_copy(s : MathspecialbetaFrame) -> MathspecialbetaFrame {
  let result = math_special_beta_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_beta_frame_fill(s : MathspecialbetaFrame, v : Double) -> MathspecialbetaFrame {
  let result = math_special_beta_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_frame_min(s : MathspecialbetaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_frame_max(s : MathspecialbetaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_frame_to_string(s : MathspecialbetaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_table_make(size : Int) -> MathspecialbetaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_table_len(s : MathspecialbetaTable) -> Int { s.size }

pub fn math_special_beta_table_get(s : MathspecialbetaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_table_set(s : MathspecialbetaTable, i : Int, v : Double) -> MathspecialbetaTable {
  let result = math_special_beta_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_table_sum(s : MathspecialbetaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_beta_table_mean(s : MathspecialbetaTable) -> Double {
  if s.size == 0 { 0.0 } else { math_special_beta_table_sum(s) / s.size.to_double() }
}

pub fn math_special_beta_table_scale(s : MathspecialbetaTable, f : Double) -> MathspecialbetaTable {
  let result = math_special_beta_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_beta_table_add(a : MathspecialbetaTable, b : MathspecialbetaTable) -> MathspecialbetaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_beta_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_beta_table_copy(s : MathspecialbetaTable) -> MathspecialbetaTable {
  let result = math_special_beta_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_beta_table_fill(s : MathspecialbetaTable, v : Double) -> MathspecialbetaTable {
  let result = math_special_beta_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_table_min(s : MathspecialbetaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_table_max(s : MathspecialbetaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_table_to_string(s : MathspecialbetaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_graphn_make(size : Int) -> MathspecialbetaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_graphn_len(s : MathspecialbetaGraphN) -> Int { s.size }

pub fn math_special_beta_graphn_get(s : MathspecialbetaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_graphn_set(s : MathspecialbetaGraphN, i : Int, v : Double) -> MathspecialbetaGraphN {
  let result = math_special_beta_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_graphn_sum(s : MathspecialbetaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_beta_graphn_mean(s : MathspecialbetaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_special_beta_graphn_sum(s) / s.size.to_double() }
}

pub fn math_special_beta_graphn_scale(s : MathspecialbetaGraphN, f : Double) -> MathspecialbetaGraphN {
  let result = math_special_beta_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_beta_graphn_add(a : MathspecialbetaGraphN, b : MathspecialbetaGraphN) -> MathspecialbetaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_beta_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_beta_graphn_copy(s : MathspecialbetaGraphN) -> MathspecialbetaGraphN {
  let result = math_special_beta_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_beta_graphn_fill(s : MathspecialbetaGraphN, v : Double) -> MathspecialbetaGraphN {
  let result = math_special_beta_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_graphn_min(s : MathspecialbetaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_graphn_max(s : MathspecialbetaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_graphn_to_string(s : MathspecialbetaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_node_make(size : Int) -> MathspecialbetaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_node_len(s : MathspecialbetaNode) -> Int { s.size }

pub fn math_special_beta_node_get(s : MathspecialbetaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_node_set(s : MathspecialbetaNode, i : Int, v : Double) -> MathspecialbetaNode {
  let result = math_special_beta_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_node_sum(s : MathspecialbetaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_beta_node_mean(s : MathspecialbetaNode) -> Double {
  if s.size == 0 { 0.0 } else { math_special_beta_node_sum(s) / s.size.to_double() }
}

pub fn math_special_beta_node_scale(s : MathspecialbetaNode, f : Double) -> MathspecialbetaNode {
  let result = math_special_beta_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_beta_node_add(a : MathspecialbetaNode, b : MathspecialbetaNode) -> MathspecialbetaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_beta_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_beta_node_copy(s : MathspecialbetaNode) -> MathspecialbetaNode {
  let result = math_special_beta_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_beta_node_fill(s : MathspecialbetaNode, v : Double) -> MathspecialbetaNode {
  let result = math_special_beta_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_node_min(s : MathspecialbetaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_node_max(s : MathspecialbetaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_node_to_string(s : MathspecialbetaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_edge_make(size : Int) -> MathspecialbetaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_edge_len(s : MathspecialbetaEdge) -> Int { s.size }

pub fn math_special_beta_edge_get(s : MathspecialbetaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_edge_set(s : MathspecialbetaEdge, i : Int, v : Double) -> MathspecialbetaEdge {
  let result = math_special_beta_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_edge_sum(s : MathspecialbetaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_beta_edge_mean(s : MathspecialbetaEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_special_beta_edge_sum(s) / s.size.to_double() }
}

pub fn math_special_beta_edge_scale(s : MathspecialbetaEdge, f : Double) -> MathspecialbetaEdge {
  let result = math_special_beta_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_beta_edge_add(a : MathspecialbetaEdge, b : MathspecialbetaEdge) -> MathspecialbetaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_beta_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_beta_edge_copy(s : MathspecialbetaEdge) -> MathspecialbetaEdge {
  let result = math_special_beta_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_beta_edge_fill(s : MathspecialbetaEdge, v : Double) -> MathspecialbetaEdge {
  let result = math_special_beta_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_edge_min(s : MathspecialbetaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_edge_max(s : MathspecialbetaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_edge_to_string(s : MathspecialbetaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_path_make(size : Int) -> MathspecialbetaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_path_len(s : MathspecialbetaPath) -> Int { s.size }

pub fn math_special_beta_path_get(s : MathspecialbetaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_path_set(s : MathspecialbetaPath, i : Int, v : Double) -> MathspecialbetaPath {
  let result = math_special_beta_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_path_sum(s : MathspecialbetaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_beta_path_mean(s : MathspecialbetaPath) -> Double {
  if s.size == 0 { 0.0 } else { math_special_beta_path_sum(s) / s.size.to_double() }
}

pub fn math_special_beta_path_scale(s : MathspecialbetaPath, f : Double) -> MathspecialbetaPath {
  let result = math_special_beta_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_beta_path_add(a : MathspecialbetaPath, b : MathspecialbetaPath) -> MathspecialbetaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_beta_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_beta_path_copy(s : MathspecialbetaPath) -> MathspecialbetaPath {
  let result = math_special_beta_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_beta_path_fill(s : MathspecialbetaPath, v : Double) -> MathspecialbetaPath {
  let result = math_special_beta_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_path_min(s : MathspecialbetaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_path_max(s : MathspecialbetaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_path_to_string(s : MathspecialbetaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_cluster_make(size : Int) -> MathspecialbetaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_cluster_len(s : MathspecialbetaCluster) -> Int { s.size }

pub fn math_special_beta_cluster_get(s : MathspecialbetaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_cluster_set(s : MathspecialbetaCluster, i : Int, v : Double) -> MathspecialbetaCluster {
  let result = math_special_beta_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_cluster_sum(s : MathspecialbetaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_beta_cluster_mean(s : MathspecialbetaCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_special_beta_cluster_sum(s) / s.size.to_double() }
}

pub fn math_special_beta_cluster_scale(s : MathspecialbetaCluster, f : Double) -> MathspecialbetaCluster {
  let result = math_special_beta_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_beta_cluster_add(a : MathspecialbetaCluster, b : MathspecialbetaCluster) -> MathspecialbetaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_beta_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_beta_cluster_copy(s : MathspecialbetaCluster) -> MathspecialbetaCluster {
  let result = math_special_beta_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_beta_cluster_fill(s : MathspecialbetaCluster, v : Double) -> MathspecialbetaCluster {
  let result = math_special_beta_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_cluster_min(s : MathspecialbetaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_cluster_max(s : MathspecialbetaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_cluster_to_string(s : MathspecialbetaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_model_make(size : Int) -> MathspecialbetaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_model_len(s : MathspecialbetaModel) -> Int { s.size }

pub fn math_special_beta_model_get(s : MathspecialbetaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_model_set(s : MathspecialbetaModel, i : Int, v : Double) -> MathspecialbetaModel {
  let result = math_special_beta_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_model_sum(s : MathspecialbetaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_beta_model_mean(s : MathspecialbetaModel) -> Double {
  if s.size == 0 { 0.0 } else { math_special_beta_model_sum(s) / s.size.to_double() }
}

pub fn math_special_beta_model_scale(s : MathspecialbetaModel, f : Double) -> MathspecialbetaModel {
  let result = math_special_beta_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_beta_model_add(a : MathspecialbetaModel, b : MathspecialbetaModel) -> MathspecialbetaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_beta_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_beta_model_copy(s : MathspecialbetaModel) -> MathspecialbetaModel {
  let result = math_special_beta_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_beta_model_fill(s : MathspecialbetaModel, v : Double) -> MathspecialbetaModel {
  let result = math_special_beta_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_model_min(s : MathspecialbetaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_model_max(s : MathspecialbetaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_model_to_string(s : MathspecialbetaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_layer_make(size : Int) -> MathspecialbetaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_layer_len(s : MathspecialbetaLayer) -> Int { s.size }

pub fn math_special_beta_layer_get(s : MathspecialbetaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_layer_set(s : MathspecialbetaLayer, i : Int, v : Double) -> MathspecialbetaLayer {
  let result = math_special_beta_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_layer_sum(s : MathspecialbetaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_beta_layer_mean(s : MathspecialbetaLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_special_beta_layer_sum(s) / s.size.to_double() }
}

pub fn math_special_beta_layer_scale(s : MathspecialbetaLayer, f : Double) -> MathspecialbetaLayer {
  let result = math_special_beta_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_beta_layer_add(a : MathspecialbetaLayer, b : MathspecialbetaLayer) -> MathspecialbetaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_beta_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_beta_layer_copy(s : MathspecialbetaLayer) -> MathspecialbetaLayer {
  let result = math_special_beta_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_beta_layer_fill(s : MathspecialbetaLayer, v : Double) -> MathspecialbetaLayer {
  let result = math_special_beta_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_layer_min(s : MathspecialbetaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_layer_max(s : MathspecialbetaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_layer_to_string(s : MathspecialbetaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_buffer_make(size : Int) -> MathspecialbetaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_buffer_len(s : MathspecialbetaBuffer) -> Int { s.size }

pub fn math_special_beta_buffer_get(s : MathspecialbetaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_buffer_set(s : MathspecialbetaBuffer, i : Int, v : Double) -> MathspecialbetaBuffer {
  let result = math_special_beta_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_buffer_sum(s : MathspecialbetaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_beta_buffer_mean(s : MathspecialbetaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_special_beta_buffer_sum(s) / s.size.to_double() }
}

pub fn math_special_beta_buffer_scale(s : MathspecialbetaBuffer, f : Double) -> MathspecialbetaBuffer {
  let result = math_special_beta_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_beta_buffer_add(a : MathspecialbetaBuffer, b : MathspecialbetaBuffer) -> MathspecialbetaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_beta_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_beta_buffer_copy(s : MathspecialbetaBuffer) -> MathspecialbetaBuffer {
  let result = math_special_beta_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_beta_buffer_fill(s : MathspecialbetaBuffer, v : Double) -> MathspecialbetaBuffer {
  let result = math_special_beta_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_buffer_min(s : MathspecialbetaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_buffer_max(s : MathspecialbetaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_buffer_to_string(s : MathspecialbetaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_cursor_make(size : Int) -> MathspecialbetaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_cursor_len(s : MathspecialbetaCursor) -> Int { s.size }

pub fn math_special_beta_cursor_get(s : MathspecialbetaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_cursor_set(s : MathspecialbetaCursor, i : Int, v : Double) -> MathspecialbetaCursor {
  let result = math_special_beta_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_cursor_sum(s : MathspecialbetaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_beta_cursor_mean(s : MathspecialbetaCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_special_beta_cursor_sum(s) / s.size.to_double() }
}

pub fn math_special_beta_cursor_scale(s : MathspecialbetaCursor, f : Double) -> MathspecialbetaCursor {
  let result = math_special_beta_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_beta_cursor_add(a : MathspecialbetaCursor, b : MathspecialbetaCursor) -> MathspecialbetaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_beta_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_beta_cursor_copy(s : MathspecialbetaCursor) -> MathspecialbetaCursor {
  let result = math_special_beta_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_beta_cursor_fill(s : MathspecialbetaCursor, v : Double) -> MathspecialbetaCursor {
  let result = math_special_beta_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_cursor_min(s : MathspecialbetaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_cursor_max(s : MathspecialbetaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_cursor_to_string(s : MathspecialbetaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_view_make(size : Int) -> MathspecialbetaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_view_len(s : MathspecialbetaView) -> Int { s.size }

pub fn math_special_beta_view_get(s : MathspecialbetaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_view_set(s : MathspecialbetaView, i : Int, v : Double) -> MathspecialbetaView {
  let result = math_special_beta_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_view_sum(s : MathspecialbetaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_beta_view_mean(s : MathspecialbetaView) -> Double {
  if s.size == 0 { 0.0 } else { math_special_beta_view_sum(s) / s.size.to_double() }
}

pub fn math_special_beta_view_scale(s : MathspecialbetaView, f : Double) -> MathspecialbetaView {
  let result = math_special_beta_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_beta_view_add(a : MathspecialbetaView, b : MathspecialbetaView) -> MathspecialbetaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_beta_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_beta_view_copy(s : MathspecialbetaView) -> MathspecialbetaView {
  let result = math_special_beta_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_beta_view_fill(s : MathspecialbetaView, v : Double) -> MathspecialbetaView {
  let result = math_special_beta_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_view_min(s : MathspecialbetaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_view_max(s : MathspecialbetaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_view_to_string(s : MathspecialbetaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_range_make(size : Int) -> MathspecialbetaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_range_len(s : MathspecialbetaRange) -> Int { s.size }

pub fn math_special_beta_range_get(s : MathspecialbetaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_range_set(s : MathspecialbetaRange, i : Int, v : Double) -> MathspecialbetaRange {
  let result = math_special_beta_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_range_sum(s : MathspecialbetaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_beta_range_mean(s : MathspecialbetaRange) -> Double {
  if s.size == 0 { 0.0 } else { math_special_beta_range_sum(s) / s.size.to_double() }
}

pub fn math_special_beta_range_scale(s : MathspecialbetaRange, f : Double) -> MathspecialbetaRange {
  let result = math_special_beta_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_beta_range_add(a : MathspecialbetaRange, b : MathspecialbetaRange) -> MathspecialbetaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_beta_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_beta_range_copy(s : MathspecialbetaRange) -> MathspecialbetaRange {
  let result = math_special_beta_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_beta_range_fill(s : MathspecialbetaRange, v : Double) -> MathspecialbetaRange {
  let result = math_special_beta_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_range_min(s : MathspecialbetaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_range_max(s : MathspecialbetaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_range_to_string(s : MathspecialbetaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_slice_make(size : Int) -> MathspecialbetaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_beta_slice_len(s : MathspecialbetaSlice) -> Int { s.size }

pub fn math_special_beta_slice_get(s : MathspecialbetaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_beta_slice_set(s : MathspecialbetaSlice, i : Int, v : Double) -> MathspecialbetaSlice {
  let result = math_special_beta_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_slice_sum(s : MathspecialbetaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_special_beta_slice_mean(s : MathspecialbetaSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_special_beta_slice_sum(s) / s.size.to_double() }
}

pub fn math_special_beta_slice_scale(s : MathspecialbetaSlice, f : Double) -> MathspecialbetaSlice {
  let result = math_special_beta_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_special_beta_slice_add(a : MathspecialbetaSlice, b : MathspecialbetaSlice) -> MathspecialbetaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_special_beta_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_special_beta_slice_copy(s : MathspecialbetaSlice) -> MathspecialbetaSlice {
  let result = math_special_beta_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_special_beta_slice_fill(s : MathspecialbetaSlice, v : Double) -> MathspecialbetaSlice {
  let result = math_special_beta_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_special_beta_slice_min(s : MathspecialbetaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_slice_max(s : MathspecialbetaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_special_beta_slice_to_string(s : MathspecialbetaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

