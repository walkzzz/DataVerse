///===
/// extcore/math_numerical_integ

pub(all) struct MathnumericalintegPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_numerical_integ_make_point(x : Double, y : Double) -> MathnumericalintegPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_numerical_integ_make_point3(x : Double, y : Double, z : Double) -> MathnumericalintegPoint {
  { x, y, z, label: 0 }
}

pub fn math_numerical_integ_point_x(pt : MathnumericalintegPoint) -> Double { pt.x }

pub fn math_numerical_integ_point_y(pt : MathnumericalintegPoint) -> Double { pt.y }

pub fn math_numerical_integ_point_z(pt : MathnumericalintegPoint) -> Double { pt.z }

pub fn math_numerical_integ_point_label(pt : MathnumericalintegPoint) -> Int { pt.label }

pub fn math_numerical_integ_point_dist(a : MathnumericalintegPoint, b : MathnumericalintegPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn math_numerical_integ_point_add(a : MathnumericalintegPoint, b : MathnumericalintegPoint) -> MathnumericalintegPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn math_numerical_integ_point_sub(a : MathnumericalintegPoint, b : MathnumericalintegPoint) -> MathnumericalintegPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn math_numerical_integ_point_scale(pt : MathnumericalintegPoint, s : Double) -> MathnumericalintegPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn math_numerical_integ_point_dot(a : MathnumericalintegPoint, b : MathnumericalintegPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn math_numerical_integ_point_cross(a : MathnumericalintegPoint, b : MathnumericalintegPoint) -> MathnumericalintegPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn math_numerical_integ_point_norm(pt : MathnumericalintegPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn math_numerical_integ_point_normalize(pt : MathnumericalintegPoint) -> MathnumericalintegPoint {
  let n = math_numerical_integ_point_norm(pt)
  if n < 0.0000001 { pt } else { math_numerical_integ_point_scale(pt, 1.0 / n) }
}

pub fn math_numerical_integ_point_negate(pt : MathnumericalintegPoint) -> MathnumericalintegPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn math_numerical_integ_point_mid(a : MathnumericalintegPoint, b : MathnumericalintegPoint) -> MathnumericalintegPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn math_numerical_integ_point_lerp(a : MathnumericalintegPoint, b : MathnumericalintegPoint, t : Double) -> MathnumericalintegPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn math_numerical_integ_point_to_string(pt : MathnumericalintegPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MathnumericalintegSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_numerical_integ_make_series(vals : Array[Double], name : String) -> MathnumericalintegSeries {
  { vals, name, meta: 0 }
}

pub fn math_numerical_integ_series_len(s : MathnumericalintegSeries) -> Int { s.vals.length() }

pub fn math_numerical_integ_series_sum(s : MathnumericalintegSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn math_numerical_integ_series_mean(s : MathnumericalintegSeries) -> Double { @_common.mean(s.vals) }

pub fn math_numerical_integ_series_min(s : MathnumericalintegSeries) -> Double { @_common.min(s.vals) }

pub fn math_numerical_integ_series_max(s : MathnumericalintegSeries) -> Double { @_common.max(s.vals) }

pub fn math_numerical_integ_series_range(s : MathnumericalintegSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn math_numerical_integ_series_var(s : MathnumericalintegSeries) -> Double { @_common.variance(s.vals) }

pub fn math_numerical_integ_series_std(s : MathnumericalintegSeries) -> Double { @_common.std(s.vals) }

pub fn math_numerical_integ_series_median(s : MathnumericalintegSeries) -> Double { @_common.median(s.vals) }

pub fn math_numerical_integ_series_scale(s : MathnumericalintegSeries, f : Double) -> MathnumericalintegSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn math_numerical_integ_series_add(a : MathnumericalintegSeries, b : MathnumericalintegSeries) -> MathnumericalintegSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn math_numerical_integ_series_sub(a : MathnumericalintegSeries, b : MathnumericalintegSeries) -> MathnumericalintegSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn math_numerical_integ_series_normalize(s : MathnumericalintegSeries) -> MathnumericalintegSeries {
  let mn = math_numerical_integ_series_min(s)
  let mx = math_numerical_integ_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn math_numerical_integ_series_cumsum(s : MathnumericalintegSeries) -> MathnumericalintegSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn math_numerical_integ_series_to_string(s : MathnumericalintegSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathnumericalintegMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_numerical_integ_make_matrix(rows : Int, cols : Int, val : Double) -> MathnumericalintegMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_numerical_integ_matrix_identity(n : Int) -> MathnumericalintegMatrix {
  let m = math_numerical_integ_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn math_numerical_integ_matrix_get(m : MathnumericalintegMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn math_numerical_integ_matrix_transpose(m : MathnumericalintegMatrix) -> MathnumericalintegMatrix {
  let result = math_numerical_integ_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn math_numerical_integ_matrix_add(a : MathnumericalintegMatrix, b : MathnumericalintegMatrix) -> MathnumericalintegMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = math_numerical_integ_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn math_numerical_integ_matrix_scale(m : MathnumericalintegMatrix, s : Double) -> MathnumericalintegMatrix {
  let result = math_numerical_integ_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn math_numerical_integ_matrix_multiply(a : MathnumericalintegMatrix, b : MathnumericalintegMatrix) -> MathnumericalintegMatrix {
  if a.cols != b.rows { return math_numerical_integ_make_matrix(a.rows, b.cols, 0.0) }
  let result = math_numerical_integ_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn math_numerical_integ_matrix_trace(m : MathnumericalintegMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn math_numerical_integ_matrix_det(m : MathnumericalintegMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn math_numerical_integ_matrix_norm(m : MathnumericalintegMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn math_numerical_integ_matrix_to_string(m : MathnumericalintegMatrix) -> String {
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

pub(all) struct MathnumericalintegVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_numerical_integ_make_vector(comps : Array[Double]) -> MathnumericalintegVector {
  { comps, dim: comps.length() }
}

pub fn math_numerical_integ_vector_zero(dim : Int) -> MathnumericalintegVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn math_numerical_integ_vector_add(a : MathnumericalintegVector, b : MathnumericalintegVector) -> MathnumericalintegVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_numerical_integ_vector_sub(a : MathnumericalintegVector, b : MathnumericalintegVector) -> MathnumericalintegVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn math_numerical_integ_vector_scale(v : MathnumericalintegVector, s : Double) -> MathnumericalintegVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn math_numerical_integ_vector_dot(a : MathnumericalintegVector, b : MathnumericalintegVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn math_numerical_integ_vector_norm(v : MathnumericalintegVector) -> Double { @_common.sqrt(math_numerical_integ_vector_dot(v, v)) }

pub fn math_numerical_integ_vector_normalize(v : MathnumericalintegVector) -> MathnumericalintegVector {
  let n = math_numerical_integ_vector_norm(v)
  if n < 0.0000001 { v } else { math_numerical_integ_vector_scale(v, 1.0 / n) }
}

pub fn math_numerical_integ_vector_dist(a : MathnumericalintegVector, b : MathnumericalintegVector) -> Double {
  math_numerical_integ_vector_norm(math_numerical_integ_vector_sub(a, b))
}

pub fn math_numerical_integ_vector_to_string(v : MathnumericalintegVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_numerical_integ_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_numerical_integ_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_numerical_integ_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_numerical_integ_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_numerical_integ_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_numerical_integ_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_numerical_integ_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_numerical_integ_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_numerical_integ_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_numerical_integ_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_numerical_integ_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_numerical_integ_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_numerical_integ_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_numerical_integ_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_numerical_integ_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_numerical_integ_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_numerical_integ_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_numerical_integ_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_numerical_integ_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_numerical_integ_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_numerical_integ_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_numerical_integ_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_numerical_integ_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_numerical_integ_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_numerical_integ_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_numerical_integ_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_numerical_integ_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_numerical_integ_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_numerical_integ_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathnumericalintegFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_frame_make(size : Int) -> MathnumericalintegFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_frame_len(s : MathnumericalintegFrame) -> Int { s.size }

pub fn math_numerical_integ_frame_get(s : MathnumericalintegFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_frame_set(s : MathnumericalintegFrame, i : Int, v : Double) -> MathnumericalintegFrame {
  let result = math_numerical_integ_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_frame_sum(s : MathnumericalintegFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_integ_frame_mean(s : MathnumericalintegFrame) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_integ_frame_sum(s) / s.size.to_double() }
}

pub fn math_numerical_integ_frame_scale(s : MathnumericalintegFrame, f : Double) -> MathnumericalintegFrame {
  let result = math_numerical_integ_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_integ_frame_add(a : MathnumericalintegFrame, b : MathnumericalintegFrame) -> MathnumericalintegFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_integ_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_integ_frame_copy(s : MathnumericalintegFrame) -> MathnumericalintegFrame {
  let result = math_numerical_integ_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_integ_frame_fill(s : MathnumericalintegFrame, v : Double) -> MathnumericalintegFrame {
  let result = math_numerical_integ_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_frame_min(s : MathnumericalintegFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_frame_max(s : MathnumericalintegFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_frame_to_string(s : MathnumericalintegFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_table_make(size : Int) -> MathnumericalintegTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_table_len(s : MathnumericalintegTable) -> Int { s.size }

pub fn math_numerical_integ_table_get(s : MathnumericalintegTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_table_set(s : MathnumericalintegTable, i : Int, v : Double) -> MathnumericalintegTable {
  let result = math_numerical_integ_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_table_sum(s : MathnumericalintegTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_integ_table_mean(s : MathnumericalintegTable) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_integ_table_sum(s) / s.size.to_double() }
}

pub fn math_numerical_integ_table_scale(s : MathnumericalintegTable, f : Double) -> MathnumericalintegTable {
  let result = math_numerical_integ_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_integ_table_add(a : MathnumericalintegTable, b : MathnumericalintegTable) -> MathnumericalintegTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_integ_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_integ_table_copy(s : MathnumericalintegTable) -> MathnumericalintegTable {
  let result = math_numerical_integ_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_integ_table_fill(s : MathnumericalintegTable, v : Double) -> MathnumericalintegTable {
  let result = math_numerical_integ_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_table_min(s : MathnumericalintegTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_table_max(s : MathnumericalintegTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_table_to_string(s : MathnumericalintegTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_graphn_make(size : Int) -> MathnumericalintegGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_graphn_len(s : MathnumericalintegGraphN) -> Int { s.size }

pub fn math_numerical_integ_graphn_get(s : MathnumericalintegGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_graphn_set(s : MathnumericalintegGraphN, i : Int, v : Double) -> MathnumericalintegGraphN {
  let result = math_numerical_integ_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_graphn_sum(s : MathnumericalintegGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_integ_graphn_mean(s : MathnumericalintegGraphN) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_integ_graphn_sum(s) / s.size.to_double() }
}

pub fn math_numerical_integ_graphn_scale(s : MathnumericalintegGraphN, f : Double) -> MathnumericalintegGraphN {
  let result = math_numerical_integ_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_integ_graphn_add(a : MathnumericalintegGraphN, b : MathnumericalintegGraphN) -> MathnumericalintegGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_integ_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_integ_graphn_copy(s : MathnumericalintegGraphN) -> MathnumericalintegGraphN {
  let result = math_numerical_integ_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_integ_graphn_fill(s : MathnumericalintegGraphN, v : Double) -> MathnumericalintegGraphN {
  let result = math_numerical_integ_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_graphn_min(s : MathnumericalintegGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_graphn_max(s : MathnumericalintegGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_graphn_to_string(s : MathnumericalintegGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_node_make(size : Int) -> MathnumericalintegNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_node_len(s : MathnumericalintegNode) -> Int { s.size }

pub fn math_numerical_integ_node_get(s : MathnumericalintegNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_node_set(s : MathnumericalintegNode, i : Int, v : Double) -> MathnumericalintegNode {
  let result = math_numerical_integ_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_node_sum(s : MathnumericalintegNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_integ_node_mean(s : MathnumericalintegNode) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_integ_node_sum(s) / s.size.to_double() }
}

pub fn math_numerical_integ_node_scale(s : MathnumericalintegNode, f : Double) -> MathnumericalintegNode {
  let result = math_numerical_integ_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_integ_node_add(a : MathnumericalintegNode, b : MathnumericalintegNode) -> MathnumericalintegNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_integ_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_integ_node_copy(s : MathnumericalintegNode) -> MathnumericalintegNode {
  let result = math_numerical_integ_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_integ_node_fill(s : MathnumericalintegNode, v : Double) -> MathnumericalintegNode {
  let result = math_numerical_integ_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_node_min(s : MathnumericalintegNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_node_max(s : MathnumericalintegNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_node_to_string(s : MathnumericalintegNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_edge_make(size : Int) -> MathnumericalintegEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_edge_len(s : MathnumericalintegEdge) -> Int { s.size }

pub fn math_numerical_integ_edge_get(s : MathnumericalintegEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_edge_set(s : MathnumericalintegEdge, i : Int, v : Double) -> MathnumericalintegEdge {
  let result = math_numerical_integ_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_edge_sum(s : MathnumericalintegEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_integ_edge_mean(s : MathnumericalintegEdge) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_integ_edge_sum(s) / s.size.to_double() }
}

pub fn math_numerical_integ_edge_scale(s : MathnumericalintegEdge, f : Double) -> MathnumericalintegEdge {
  let result = math_numerical_integ_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_integ_edge_add(a : MathnumericalintegEdge, b : MathnumericalintegEdge) -> MathnumericalintegEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_integ_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_integ_edge_copy(s : MathnumericalintegEdge) -> MathnumericalintegEdge {
  let result = math_numerical_integ_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_integ_edge_fill(s : MathnumericalintegEdge, v : Double) -> MathnumericalintegEdge {
  let result = math_numerical_integ_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_edge_min(s : MathnumericalintegEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_edge_max(s : MathnumericalintegEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_edge_to_string(s : MathnumericalintegEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_path_make(size : Int) -> MathnumericalintegPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_path_len(s : MathnumericalintegPath) -> Int { s.size }

pub fn math_numerical_integ_path_get(s : MathnumericalintegPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_path_set(s : MathnumericalintegPath, i : Int, v : Double) -> MathnumericalintegPath {
  let result = math_numerical_integ_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_path_sum(s : MathnumericalintegPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_integ_path_mean(s : MathnumericalintegPath) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_integ_path_sum(s) / s.size.to_double() }
}

pub fn math_numerical_integ_path_scale(s : MathnumericalintegPath, f : Double) -> MathnumericalintegPath {
  let result = math_numerical_integ_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_integ_path_add(a : MathnumericalintegPath, b : MathnumericalintegPath) -> MathnumericalintegPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_integ_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_integ_path_copy(s : MathnumericalintegPath) -> MathnumericalintegPath {
  let result = math_numerical_integ_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_integ_path_fill(s : MathnumericalintegPath, v : Double) -> MathnumericalintegPath {
  let result = math_numerical_integ_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_path_min(s : MathnumericalintegPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_path_max(s : MathnumericalintegPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_path_to_string(s : MathnumericalintegPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_cluster_make(size : Int) -> MathnumericalintegCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_cluster_len(s : MathnumericalintegCluster) -> Int { s.size }

pub fn math_numerical_integ_cluster_get(s : MathnumericalintegCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_cluster_set(s : MathnumericalintegCluster, i : Int, v : Double) -> MathnumericalintegCluster {
  let result = math_numerical_integ_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_cluster_sum(s : MathnumericalintegCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_integ_cluster_mean(s : MathnumericalintegCluster) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_integ_cluster_sum(s) / s.size.to_double() }
}

pub fn math_numerical_integ_cluster_scale(s : MathnumericalintegCluster, f : Double) -> MathnumericalintegCluster {
  let result = math_numerical_integ_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_integ_cluster_add(a : MathnumericalintegCluster, b : MathnumericalintegCluster) -> MathnumericalintegCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_integ_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_integ_cluster_copy(s : MathnumericalintegCluster) -> MathnumericalintegCluster {
  let result = math_numerical_integ_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_integ_cluster_fill(s : MathnumericalintegCluster, v : Double) -> MathnumericalintegCluster {
  let result = math_numerical_integ_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_cluster_min(s : MathnumericalintegCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_cluster_max(s : MathnumericalintegCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_cluster_to_string(s : MathnumericalintegCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_model_make(size : Int) -> MathnumericalintegModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_model_len(s : MathnumericalintegModel) -> Int { s.size }

pub fn math_numerical_integ_model_get(s : MathnumericalintegModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_model_set(s : MathnumericalintegModel, i : Int, v : Double) -> MathnumericalintegModel {
  let result = math_numerical_integ_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_model_sum(s : MathnumericalintegModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_integ_model_mean(s : MathnumericalintegModel) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_integ_model_sum(s) / s.size.to_double() }
}

pub fn math_numerical_integ_model_scale(s : MathnumericalintegModel, f : Double) -> MathnumericalintegModel {
  let result = math_numerical_integ_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_integ_model_add(a : MathnumericalintegModel, b : MathnumericalintegModel) -> MathnumericalintegModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_integ_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_integ_model_copy(s : MathnumericalintegModel) -> MathnumericalintegModel {
  let result = math_numerical_integ_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_integ_model_fill(s : MathnumericalintegModel, v : Double) -> MathnumericalintegModel {
  let result = math_numerical_integ_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_model_min(s : MathnumericalintegModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_model_max(s : MathnumericalintegModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_model_to_string(s : MathnumericalintegModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_layer_make(size : Int) -> MathnumericalintegLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_layer_len(s : MathnumericalintegLayer) -> Int { s.size }

pub fn math_numerical_integ_layer_get(s : MathnumericalintegLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_layer_set(s : MathnumericalintegLayer, i : Int, v : Double) -> MathnumericalintegLayer {
  let result = math_numerical_integ_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_layer_sum(s : MathnumericalintegLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_integ_layer_mean(s : MathnumericalintegLayer) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_integ_layer_sum(s) / s.size.to_double() }
}

pub fn math_numerical_integ_layer_scale(s : MathnumericalintegLayer, f : Double) -> MathnumericalintegLayer {
  let result = math_numerical_integ_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_integ_layer_add(a : MathnumericalintegLayer, b : MathnumericalintegLayer) -> MathnumericalintegLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_integ_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_integ_layer_copy(s : MathnumericalintegLayer) -> MathnumericalintegLayer {
  let result = math_numerical_integ_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_integ_layer_fill(s : MathnumericalintegLayer, v : Double) -> MathnumericalintegLayer {
  let result = math_numerical_integ_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_layer_min(s : MathnumericalintegLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_layer_max(s : MathnumericalintegLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_layer_to_string(s : MathnumericalintegLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_buffer_make(size : Int) -> MathnumericalintegBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_buffer_len(s : MathnumericalintegBuffer) -> Int { s.size }

pub fn math_numerical_integ_buffer_get(s : MathnumericalintegBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_buffer_set(s : MathnumericalintegBuffer, i : Int, v : Double) -> MathnumericalintegBuffer {
  let result = math_numerical_integ_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_buffer_sum(s : MathnumericalintegBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_integ_buffer_mean(s : MathnumericalintegBuffer) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_integ_buffer_sum(s) / s.size.to_double() }
}

pub fn math_numerical_integ_buffer_scale(s : MathnumericalintegBuffer, f : Double) -> MathnumericalintegBuffer {
  let result = math_numerical_integ_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_integ_buffer_add(a : MathnumericalintegBuffer, b : MathnumericalintegBuffer) -> MathnumericalintegBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_integ_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_integ_buffer_copy(s : MathnumericalintegBuffer) -> MathnumericalintegBuffer {
  let result = math_numerical_integ_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_integ_buffer_fill(s : MathnumericalintegBuffer, v : Double) -> MathnumericalintegBuffer {
  let result = math_numerical_integ_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_buffer_min(s : MathnumericalintegBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_buffer_max(s : MathnumericalintegBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_buffer_to_string(s : MathnumericalintegBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_cursor_make(size : Int) -> MathnumericalintegCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_cursor_len(s : MathnumericalintegCursor) -> Int { s.size }

pub fn math_numerical_integ_cursor_get(s : MathnumericalintegCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_cursor_set(s : MathnumericalintegCursor, i : Int, v : Double) -> MathnumericalintegCursor {
  let result = math_numerical_integ_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_cursor_sum(s : MathnumericalintegCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_integ_cursor_mean(s : MathnumericalintegCursor) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_integ_cursor_sum(s) / s.size.to_double() }
}

pub fn math_numerical_integ_cursor_scale(s : MathnumericalintegCursor, f : Double) -> MathnumericalintegCursor {
  let result = math_numerical_integ_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_integ_cursor_add(a : MathnumericalintegCursor, b : MathnumericalintegCursor) -> MathnumericalintegCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_integ_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_integ_cursor_copy(s : MathnumericalintegCursor) -> MathnumericalintegCursor {
  let result = math_numerical_integ_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_integ_cursor_fill(s : MathnumericalintegCursor, v : Double) -> MathnumericalintegCursor {
  let result = math_numerical_integ_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_cursor_min(s : MathnumericalintegCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_cursor_max(s : MathnumericalintegCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_cursor_to_string(s : MathnumericalintegCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_view_make(size : Int) -> MathnumericalintegView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_view_len(s : MathnumericalintegView) -> Int { s.size }

pub fn math_numerical_integ_view_get(s : MathnumericalintegView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_view_set(s : MathnumericalintegView, i : Int, v : Double) -> MathnumericalintegView {
  let result = math_numerical_integ_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_view_sum(s : MathnumericalintegView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_integ_view_mean(s : MathnumericalintegView) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_integ_view_sum(s) / s.size.to_double() }
}

pub fn math_numerical_integ_view_scale(s : MathnumericalintegView, f : Double) -> MathnumericalintegView {
  let result = math_numerical_integ_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_integ_view_add(a : MathnumericalintegView, b : MathnumericalintegView) -> MathnumericalintegView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_integ_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_integ_view_copy(s : MathnumericalintegView) -> MathnumericalintegView {
  let result = math_numerical_integ_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_integ_view_fill(s : MathnumericalintegView, v : Double) -> MathnumericalintegView {
  let result = math_numerical_integ_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_view_min(s : MathnumericalintegView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_view_max(s : MathnumericalintegView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_view_to_string(s : MathnumericalintegView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_range_make(size : Int) -> MathnumericalintegRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_range_len(s : MathnumericalintegRange) -> Int { s.size }

pub fn math_numerical_integ_range_get(s : MathnumericalintegRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_range_set(s : MathnumericalintegRange, i : Int, v : Double) -> MathnumericalintegRange {
  let result = math_numerical_integ_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_range_sum(s : MathnumericalintegRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_integ_range_mean(s : MathnumericalintegRange) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_integ_range_sum(s) / s.size.to_double() }
}

pub fn math_numerical_integ_range_scale(s : MathnumericalintegRange, f : Double) -> MathnumericalintegRange {
  let result = math_numerical_integ_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_integ_range_add(a : MathnumericalintegRange, b : MathnumericalintegRange) -> MathnumericalintegRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_integ_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_integ_range_copy(s : MathnumericalintegRange) -> MathnumericalintegRange {
  let result = math_numerical_integ_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_integ_range_fill(s : MathnumericalintegRange, v : Double) -> MathnumericalintegRange {
  let result = math_numerical_integ_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_range_min(s : MathnumericalintegRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_range_max(s : MathnumericalintegRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_range_to_string(s : MathnumericalintegRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_slice_make(size : Int) -> MathnumericalintegSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_slice_len(s : MathnumericalintegSlice) -> Int { s.size }

pub fn math_numerical_integ_slice_get(s : MathnumericalintegSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_slice_set(s : MathnumericalintegSlice, i : Int, v : Double) -> MathnumericalintegSlice {
  let result = math_numerical_integ_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_slice_sum(s : MathnumericalintegSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn math_numerical_integ_slice_mean(s : MathnumericalintegSlice) -> Double {
  if s.size == 0 { 0.0 } else { math_numerical_integ_slice_sum(s) / s.size.to_double() }
}

pub fn math_numerical_integ_slice_scale(s : MathnumericalintegSlice, f : Double) -> MathnumericalintegSlice {
  let result = math_numerical_integ_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn math_numerical_integ_slice_add(a : MathnumericalintegSlice, b : MathnumericalintegSlice) -> MathnumericalintegSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = math_numerical_integ_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn math_numerical_integ_slice_copy(s : MathnumericalintegSlice) -> MathnumericalintegSlice {
  let result = math_numerical_integ_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn math_numerical_integ_slice_fill(s : MathnumericalintegSlice, v : Double) -> MathnumericalintegSlice {
  let result = math_numerical_integ_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn math_numerical_integ_slice_min(s : MathnumericalintegSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_slice_max(s : MathnumericalintegSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn math_numerical_integ_slice_to_string(s : MathnumericalintegSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

