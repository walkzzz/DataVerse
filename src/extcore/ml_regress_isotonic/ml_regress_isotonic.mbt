///===
/// extcore/ml_regress_isotonic

pub(all) struct MlregressisotonicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_isotonic_make_point(x : Double, y : Double) -> MlregressisotonicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_isotonic_make_point3(x : Double, y : Double, z : Double) -> MlregressisotonicPoint {
  { x, y, z, label: 0 }
}

pub fn ml_regress_isotonic_point_x(pt : MlregressisotonicPoint) -> Double { pt.x }

pub fn ml_regress_isotonic_point_y(pt : MlregressisotonicPoint) -> Double { pt.y }

pub fn ml_regress_isotonic_point_z(pt : MlregressisotonicPoint) -> Double { pt.z }

pub fn ml_regress_isotonic_point_label(pt : MlregressisotonicPoint) -> Int { pt.label }

pub fn ml_regress_isotonic_point_dist(a : MlregressisotonicPoint, b : MlregressisotonicPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_regress_isotonic_point_add(a : MlregressisotonicPoint, b : MlregressisotonicPoint) -> MlregressisotonicPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_regress_isotonic_point_sub(a : MlregressisotonicPoint, b : MlregressisotonicPoint) -> MlregressisotonicPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_regress_isotonic_point_scale(pt : MlregressisotonicPoint, s : Double) -> MlregressisotonicPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_regress_isotonic_point_dot(a : MlregressisotonicPoint, b : MlregressisotonicPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_regress_isotonic_point_cross(a : MlregressisotonicPoint, b : MlregressisotonicPoint) -> MlregressisotonicPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_regress_isotonic_point_norm(pt : MlregressisotonicPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_regress_isotonic_point_normalize(pt : MlregressisotonicPoint) -> MlregressisotonicPoint {
  let n = ml_regress_isotonic_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_regress_isotonic_point_scale(pt, 1.0 / n) }
}

pub fn ml_regress_isotonic_point_negate(pt : MlregressisotonicPoint) -> MlregressisotonicPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_regress_isotonic_point_mid(a : MlregressisotonicPoint, b : MlregressisotonicPoint) -> MlregressisotonicPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_regress_isotonic_point_lerp(a : MlregressisotonicPoint, b : MlregressisotonicPoint, t : Double) -> MlregressisotonicPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_regress_isotonic_point_to_string(pt : MlregressisotonicPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlregressisotonicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_isotonic_make_series(vals : Array[Double], name : String) -> MlregressisotonicSeries {
  { vals, name, meta: 0 }
}

pub fn ml_regress_isotonic_series_len(s : MlregressisotonicSeries) -> Int { s.vals.length() }

pub fn ml_regress_isotonic_series_sum(s : MlregressisotonicSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_regress_isotonic_series_mean(s : MlregressisotonicSeries) -> Double {
  let n = ml_regress_isotonic_series_len(s)
  if n == 0 { 0.0 } else { ml_regress_isotonic_series_sum(s) / n.to_double() }
}

pub fn ml_regress_isotonic_series_min(s : MlregressisotonicSeries) -> Double {
  let n = ml_regress_isotonic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_regress_isotonic_series_max(s : MlregressisotonicSeries) -> Double {
  let n = ml_regress_isotonic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_regress_isotonic_series_range(s : MlregressisotonicSeries) -> Double {
  ml_regress_isotonic_series_max(s) - ml_regress_isotonic_series_min(s)
}

pub fn ml_regress_isotonic_series_var(s : MlregressisotonicSeries) -> Double {
  let n = ml_regress_isotonic_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_regress_isotonic_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_regress_isotonic_series_std(s : MlregressisotonicSeries) -> Double { @_common.sqrt(ml_regress_isotonic_series_var(s)) }

pub fn ml_regress_isotonic_series_median(s : MlregressisotonicSeries) -> Double {
  let n = ml_regress_isotonic_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_regress_isotonic_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_regress_isotonic_series_scale(s : MlregressisotonicSeries, f : Double) -> MlregressisotonicSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_regress_isotonic_series_add(a : MlregressisotonicSeries, b : MlregressisotonicSeries) -> MlregressisotonicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_regress_isotonic_series_sub(a : MlregressisotonicSeries, b : MlregressisotonicSeries) -> MlregressisotonicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_regress_isotonic_series_normalize(s : MlregressisotonicSeries) -> MlregressisotonicSeries {
  let mn = ml_regress_isotonic_series_min(s)
  let mx = ml_regress_isotonic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_regress_isotonic_series_cumsum(s : MlregressisotonicSeries) -> MlregressisotonicSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_regress_isotonic_series_to_string(s : MlregressisotonicSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregressisotonicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_isotonic_make_matrix(rows : Int, cols : Int, val : Double) -> MlregressisotonicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_isotonic_matrix_identity(n : Int) -> MlregressisotonicMatrix {
  let m = ml_regress_isotonic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_regress_isotonic_matrix_get(m : MlregressisotonicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_regress_isotonic_matrix_transpose(m : MlregressisotonicMatrix) -> MlregressisotonicMatrix {
  let result = ml_regress_isotonic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_regress_isotonic_matrix_add(a : MlregressisotonicMatrix, b : MlregressisotonicMatrix) -> MlregressisotonicMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_regress_isotonic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_regress_isotonic_matrix_scale(m : MlregressisotonicMatrix, s : Double) -> MlregressisotonicMatrix {
  let result = ml_regress_isotonic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_regress_isotonic_matrix_multiply(a : MlregressisotonicMatrix, b : MlregressisotonicMatrix) -> MlregressisotonicMatrix {
  if a.cols != b.rows { return ml_regress_isotonic_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_regress_isotonic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_regress_isotonic_matrix_trace(m : MlregressisotonicMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_regress_isotonic_matrix_det(m : MlregressisotonicMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_regress_isotonic_matrix_norm(m : MlregressisotonicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_regress_isotonic_matrix_to_string(m : MlregressisotonicMatrix) -> String {
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

pub(all) struct MlregressisotonicVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_isotonic_make_vector(comps : Array[Double]) -> MlregressisotonicVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_isotonic_vector_zero(dim : Int) -> MlregressisotonicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_regress_isotonic_vector_add(a : MlregressisotonicVector, b : MlregressisotonicVector) -> MlregressisotonicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_regress_isotonic_vector_sub(a : MlregressisotonicVector, b : MlregressisotonicVector) -> MlregressisotonicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_regress_isotonic_vector_scale(v : MlregressisotonicVector, s : Double) -> MlregressisotonicVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_regress_isotonic_vector_dot(a : MlregressisotonicVector, b : MlregressisotonicVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_regress_isotonic_vector_norm(v : MlregressisotonicVector) -> Double { @_common.sqrt(ml_regress_isotonic_vector_dot(v, v)) }

pub fn ml_regress_isotonic_vector_normalize(v : MlregressisotonicVector) -> MlregressisotonicVector {
  let n = ml_regress_isotonic_vector_norm(v)
  if n < 0.0000001 { v } else { ml_regress_isotonic_vector_scale(v, 1.0 / n) }
}

pub fn ml_regress_isotonic_vector_dist(a : MlregressisotonicVector, b : MlregressisotonicVector) -> Double {
  ml_regress_isotonic_vector_norm(ml_regress_isotonic_vector_sub(a, b))
}

pub fn ml_regress_isotonic_vector_to_string(v : MlregressisotonicVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_regress_isotonic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_regress_isotonic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_regress_isotonic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_regress_isotonic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_regress_isotonic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_regress_isotonic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_regress_isotonic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_regress_isotonic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_regress_isotonic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_regress_isotonic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_regress_isotonic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_regress_isotonic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_regress_isotonic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_regress_isotonic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_regress_isotonic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_regress_isotonic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_regress_isotonic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_regress_isotonic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_regress_isotonic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_regress_isotonic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_regress_isotonic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_regress_isotonic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_regress_isotonic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_regress_isotonic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_regress_isotonic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_regress_isotonic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_regress_isotonic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_regress_isotonic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_regress_isotonic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlregressisotonicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_frame_make(size : Int) -> MlregressisotonicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_frame_len(s : MlregressisotonicFrame) -> Int { s.size }

pub fn ml_regress_isotonic_frame_get(s : MlregressisotonicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_frame_set(s : MlregressisotonicFrame, i : Int, v : Double) -> MlregressisotonicFrame {
  let result = ml_regress_isotonic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_frame_sum(s : MlregressisotonicFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_isotonic_frame_mean(s : MlregressisotonicFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_isotonic_frame_sum(s) / s.size.to_double() }
}

pub fn ml_regress_isotonic_frame_scale(s : MlregressisotonicFrame, f : Double) -> MlregressisotonicFrame {
  let result = ml_regress_isotonic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_isotonic_frame_add(a : MlregressisotonicFrame, b : MlregressisotonicFrame) -> MlregressisotonicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_isotonic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_isotonic_frame_copy(s : MlregressisotonicFrame) -> MlregressisotonicFrame {
  let result = ml_regress_isotonic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_isotonic_frame_fill(s : MlregressisotonicFrame, v : Double) -> MlregressisotonicFrame {
  let result = ml_regress_isotonic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_frame_min(s : MlregressisotonicFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_frame_max(s : MlregressisotonicFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_frame_to_string(s : MlregressisotonicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_table_make(size : Int) -> MlregressisotonicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_table_len(s : MlregressisotonicTable) -> Int { s.size }

pub fn ml_regress_isotonic_table_get(s : MlregressisotonicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_table_set(s : MlregressisotonicTable, i : Int, v : Double) -> MlregressisotonicTable {
  let result = ml_regress_isotonic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_table_sum(s : MlregressisotonicTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_isotonic_table_mean(s : MlregressisotonicTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_isotonic_table_sum(s) / s.size.to_double() }
}

pub fn ml_regress_isotonic_table_scale(s : MlregressisotonicTable, f : Double) -> MlregressisotonicTable {
  let result = ml_regress_isotonic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_isotonic_table_add(a : MlregressisotonicTable, b : MlregressisotonicTable) -> MlregressisotonicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_isotonic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_isotonic_table_copy(s : MlregressisotonicTable) -> MlregressisotonicTable {
  let result = ml_regress_isotonic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_isotonic_table_fill(s : MlregressisotonicTable, v : Double) -> MlregressisotonicTable {
  let result = ml_regress_isotonic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_table_min(s : MlregressisotonicTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_table_max(s : MlregressisotonicTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_table_to_string(s : MlregressisotonicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_graphn_make(size : Int) -> MlregressisotonicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_graphn_len(s : MlregressisotonicGraphN) -> Int { s.size }

pub fn ml_regress_isotonic_graphn_get(s : MlregressisotonicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_graphn_set(s : MlregressisotonicGraphN, i : Int, v : Double) -> MlregressisotonicGraphN {
  let result = ml_regress_isotonic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_graphn_sum(s : MlregressisotonicGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_isotonic_graphn_mean(s : MlregressisotonicGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_isotonic_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_regress_isotonic_graphn_scale(s : MlregressisotonicGraphN, f : Double) -> MlregressisotonicGraphN {
  let result = ml_regress_isotonic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_isotonic_graphn_add(a : MlregressisotonicGraphN, b : MlregressisotonicGraphN) -> MlregressisotonicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_isotonic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_isotonic_graphn_copy(s : MlregressisotonicGraphN) -> MlregressisotonicGraphN {
  let result = ml_regress_isotonic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_isotonic_graphn_fill(s : MlregressisotonicGraphN, v : Double) -> MlregressisotonicGraphN {
  let result = ml_regress_isotonic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_graphn_min(s : MlregressisotonicGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_graphn_max(s : MlregressisotonicGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_graphn_to_string(s : MlregressisotonicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_node_make(size : Int) -> MlregressisotonicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_node_len(s : MlregressisotonicNode) -> Int { s.size }

pub fn ml_regress_isotonic_node_get(s : MlregressisotonicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_node_set(s : MlregressisotonicNode, i : Int, v : Double) -> MlregressisotonicNode {
  let result = ml_regress_isotonic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_node_sum(s : MlregressisotonicNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_isotonic_node_mean(s : MlregressisotonicNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_isotonic_node_sum(s) / s.size.to_double() }
}

pub fn ml_regress_isotonic_node_scale(s : MlregressisotonicNode, f : Double) -> MlregressisotonicNode {
  let result = ml_regress_isotonic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_isotonic_node_add(a : MlregressisotonicNode, b : MlregressisotonicNode) -> MlregressisotonicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_isotonic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_isotonic_node_copy(s : MlregressisotonicNode) -> MlregressisotonicNode {
  let result = ml_regress_isotonic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_isotonic_node_fill(s : MlregressisotonicNode, v : Double) -> MlregressisotonicNode {
  let result = ml_regress_isotonic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_node_min(s : MlregressisotonicNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_node_max(s : MlregressisotonicNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_node_to_string(s : MlregressisotonicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_edge_make(size : Int) -> MlregressisotonicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_edge_len(s : MlregressisotonicEdge) -> Int { s.size }

pub fn ml_regress_isotonic_edge_get(s : MlregressisotonicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_edge_set(s : MlregressisotonicEdge, i : Int, v : Double) -> MlregressisotonicEdge {
  let result = ml_regress_isotonic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_edge_sum(s : MlregressisotonicEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_isotonic_edge_mean(s : MlregressisotonicEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_isotonic_edge_sum(s) / s.size.to_double() }
}

pub fn ml_regress_isotonic_edge_scale(s : MlregressisotonicEdge, f : Double) -> MlregressisotonicEdge {
  let result = ml_regress_isotonic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_isotonic_edge_add(a : MlregressisotonicEdge, b : MlregressisotonicEdge) -> MlregressisotonicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_isotonic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_isotonic_edge_copy(s : MlregressisotonicEdge) -> MlregressisotonicEdge {
  let result = ml_regress_isotonic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_isotonic_edge_fill(s : MlregressisotonicEdge, v : Double) -> MlregressisotonicEdge {
  let result = ml_regress_isotonic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_edge_min(s : MlregressisotonicEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_edge_max(s : MlregressisotonicEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_edge_to_string(s : MlregressisotonicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_path_make(size : Int) -> MlregressisotonicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_path_len(s : MlregressisotonicPath) -> Int { s.size }

pub fn ml_regress_isotonic_path_get(s : MlregressisotonicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_path_set(s : MlregressisotonicPath, i : Int, v : Double) -> MlregressisotonicPath {
  let result = ml_regress_isotonic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_path_sum(s : MlregressisotonicPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_isotonic_path_mean(s : MlregressisotonicPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_isotonic_path_sum(s) / s.size.to_double() }
}

pub fn ml_regress_isotonic_path_scale(s : MlregressisotonicPath, f : Double) -> MlregressisotonicPath {
  let result = ml_regress_isotonic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_isotonic_path_add(a : MlregressisotonicPath, b : MlregressisotonicPath) -> MlregressisotonicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_isotonic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_isotonic_path_copy(s : MlregressisotonicPath) -> MlregressisotonicPath {
  let result = ml_regress_isotonic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_isotonic_path_fill(s : MlregressisotonicPath, v : Double) -> MlregressisotonicPath {
  let result = ml_regress_isotonic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_path_min(s : MlregressisotonicPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_path_max(s : MlregressisotonicPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_path_to_string(s : MlregressisotonicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_cluster_make(size : Int) -> MlregressisotonicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_cluster_len(s : MlregressisotonicCluster) -> Int { s.size }

pub fn ml_regress_isotonic_cluster_get(s : MlregressisotonicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_cluster_set(s : MlregressisotonicCluster, i : Int, v : Double) -> MlregressisotonicCluster {
  let result = ml_regress_isotonic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_cluster_sum(s : MlregressisotonicCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_isotonic_cluster_mean(s : MlregressisotonicCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_isotonic_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_regress_isotonic_cluster_scale(s : MlregressisotonicCluster, f : Double) -> MlregressisotonicCluster {
  let result = ml_regress_isotonic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_isotonic_cluster_add(a : MlregressisotonicCluster, b : MlregressisotonicCluster) -> MlregressisotonicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_isotonic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_isotonic_cluster_copy(s : MlregressisotonicCluster) -> MlregressisotonicCluster {
  let result = ml_regress_isotonic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_isotonic_cluster_fill(s : MlregressisotonicCluster, v : Double) -> MlregressisotonicCluster {
  let result = ml_regress_isotonic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_cluster_min(s : MlregressisotonicCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_cluster_max(s : MlregressisotonicCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_cluster_to_string(s : MlregressisotonicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_model_make(size : Int) -> MlregressisotonicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_model_len(s : MlregressisotonicModel) -> Int { s.size }

pub fn ml_regress_isotonic_model_get(s : MlregressisotonicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_model_set(s : MlregressisotonicModel, i : Int, v : Double) -> MlregressisotonicModel {
  let result = ml_regress_isotonic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_model_sum(s : MlregressisotonicModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_isotonic_model_mean(s : MlregressisotonicModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_isotonic_model_sum(s) / s.size.to_double() }
}

pub fn ml_regress_isotonic_model_scale(s : MlregressisotonicModel, f : Double) -> MlregressisotonicModel {
  let result = ml_regress_isotonic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_isotonic_model_add(a : MlregressisotonicModel, b : MlregressisotonicModel) -> MlregressisotonicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_isotonic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_isotonic_model_copy(s : MlregressisotonicModel) -> MlregressisotonicModel {
  let result = ml_regress_isotonic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_isotonic_model_fill(s : MlregressisotonicModel, v : Double) -> MlregressisotonicModel {
  let result = ml_regress_isotonic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_model_min(s : MlregressisotonicModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_model_max(s : MlregressisotonicModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_model_to_string(s : MlregressisotonicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_layer_make(size : Int) -> MlregressisotonicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_layer_len(s : MlregressisotonicLayer) -> Int { s.size }

pub fn ml_regress_isotonic_layer_get(s : MlregressisotonicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_layer_set(s : MlregressisotonicLayer, i : Int, v : Double) -> MlregressisotonicLayer {
  let result = ml_regress_isotonic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_layer_sum(s : MlregressisotonicLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_isotonic_layer_mean(s : MlregressisotonicLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_isotonic_layer_sum(s) / s.size.to_double() }
}

pub fn ml_regress_isotonic_layer_scale(s : MlregressisotonicLayer, f : Double) -> MlregressisotonicLayer {
  let result = ml_regress_isotonic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_isotonic_layer_add(a : MlregressisotonicLayer, b : MlregressisotonicLayer) -> MlregressisotonicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_isotonic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_isotonic_layer_copy(s : MlregressisotonicLayer) -> MlregressisotonicLayer {
  let result = ml_regress_isotonic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_isotonic_layer_fill(s : MlregressisotonicLayer, v : Double) -> MlregressisotonicLayer {
  let result = ml_regress_isotonic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_layer_min(s : MlregressisotonicLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_layer_max(s : MlregressisotonicLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_layer_to_string(s : MlregressisotonicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_buffer_make(size : Int) -> MlregressisotonicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_buffer_len(s : MlregressisotonicBuffer) -> Int { s.size }

pub fn ml_regress_isotonic_buffer_get(s : MlregressisotonicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_buffer_set(s : MlregressisotonicBuffer, i : Int, v : Double) -> MlregressisotonicBuffer {
  let result = ml_regress_isotonic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_buffer_sum(s : MlregressisotonicBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_isotonic_buffer_mean(s : MlregressisotonicBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_isotonic_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_regress_isotonic_buffer_scale(s : MlregressisotonicBuffer, f : Double) -> MlregressisotonicBuffer {
  let result = ml_regress_isotonic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_isotonic_buffer_add(a : MlregressisotonicBuffer, b : MlregressisotonicBuffer) -> MlregressisotonicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_isotonic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_isotonic_buffer_copy(s : MlregressisotonicBuffer) -> MlregressisotonicBuffer {
  let result = ml_regress_isotonic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_isotonic_buffer_fill(s : MlregressisotonicBuffer, v : Double) -> MlregressisotonicBuffer {
  let result = ml_regress_isotonic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_buffer_min(s : MlregressisotonicBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_buffer_max(s : MlregressisotonicBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_buffer_to_string(s : MlregressisotonicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_cursor_make(size : Int) -> MlregressisotonicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_cursor_len(s : MlregressisotonicCursor) -> Int { s.size }

pub fn ml_regress_isotonic_cursor_get(s : MlregressisotonicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_cursor_set(s : MlregressisotonicCursor, i : Int, v : Double) -> MlregressisotonicCursor {
  let result = ml_regress_isotonic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_cursor_sum(s : MlregressisotonicCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_isotonic_cursor_mean(s : MlregressisotonicCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_isotonic_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_regress_isotonic_cursor_scale(s : MlregressisotonicCursor, f : Double) -> MlregressisotonicCursor {
  let result = ml_regress_isotonic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_isotonic_cursor_add(a : MlregressisotonicCursor, b : MlregressisotonicCursor) -> MlregressisotonicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_isotonic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_isotonic_cursor_copy(s : MlregressisotonicCursor) -> MlregressisotonicCursor {
  let result = ml_regress_isotonic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_isotonic_cursor_fill(s : MlregressisotonicCursor, v : Double) -> MlregressisotonicCursor {
  let result = ml_regress_isotonic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_cursor_min(s : MlregressisotonicCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_cursor_max(s : MlregressisotonicCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_cursor_to_string(s : MlregressisotonicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_view_make(size : Int) -> MlregressisotonicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_view_len(s : MlregressisotonicView) -> Int { s.size }

pub fn ml_regress_isotonic_view_get(s : MlregressisotonicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_view_set(s : MlregressisotonicView, i : Int, v : Double) -> MlregressisotonicView {
  let result = ml_regress_isotonic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_view_sum(s : MlregressisotonicView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_isotonic_view_mean(s : MlregressisotonicView) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_isotonic_view_sum(s) / s.size.to_double() }
}

pub fn ml_regress_isotonic_view_scale(s : MlregressisotonicView, f : Double) -> MlregressisotonicView {
  let result = ml_regress_isotonic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_isotonic_view_add(a : MlregressisotonicView, b : MlregressisotonicView) -> MlregressisotonicView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_isotonic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_isotonic_view_copy(s : MlregressisotonicView) -> MlregressisotonicView {
  let result = ml_regress_isotonic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_isotonic_view_fill(s : MlregressisotonicView, v : Double) -> MlregressisotonicView {
  let result = ml_regress_isotonic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_view_min(s : MlregressisotonicView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_view_max(s : MlregressisotonicView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_view_to_string(s : MlregressisotonicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_range_make(size : Int) -> MlregressisotonicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_range_len(s : MlregressisotonicRange) -> Int { s.size }

pub fn ml_regress_isotonic_range_get(s : MlregressisotonicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_range_set(s : MlregressisotonicRange, i : Int, v : Double) -> MlregressisotonicRange {
  let result = ml_regress_isotonic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_range_sum(s : MlregressisotonicRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_isotonic_range_mean(s : MlregressisotonicRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_isotonic_range_sum(s) / s.size.to_double() }
}

pub fn ml_regress_isotonic_range_scale(s : MlregressisotonicRange, f : Double) -> MlregressisotonicRange {
  let result = ml_regress_isotonic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_isotonic_range_add(a : MlregressisotonicRange, b : MlregressisotonicRange) -> MlregressisotonicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_isotonic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_isotonic_range_copy(s : MlregressisotonicRange) -> MlregressisotonicRange {
  let result = ml_regress_isotonic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_isotonic_range_fill(s : MlregressisotonicRange, v : Double) -> MlregressisotonicRange {
  let result = ml_regress_isotonic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_range_min(s : MlregressisotonicRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_range_max(s : MlregressisotonicRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_range_to_string(s : MlregressisotonicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregressisotonicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_isotonic_slice_make(size : Int) -> MlregressisotonicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_isotonic_slice_len(s : MlregressisotonicSlice) -> Int { s.size }

pub fn ml_regress_isotonic_slice_get(s : MlregressisotonicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_isotonic_slice_set(s : MlregressisotonicSlice, i : Int, v : Double) -> MlregressisotonicSlice {
  let result = ml_regress_isotonic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_slice_sum(s : MlregressisotonicSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_isotonic_slice_mean(s : MlregressisotonicSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_isotonic_slice_sum(s) / s.size.to_double() }
}

pub fn ml_regress_isotonic_slice_scale(s : MlregressisotonicSlice, f : Double) -> MlregressisotonicSlice {
  let result = ml_regress_isotonic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_isotonic_slice_add(a : MlregressisotonicSlice, b : MlregressisotonicSlice) -> MlregressisotonicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_isotonic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_isotonic_slice_copy(s : MlregressisotonicSlice) -> MlregressisotonicSlice {
  let result = ml_regress_isotonic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_isotonic_slice_fill(s : MlregressisotonicSlice, v : Double) -> MlregressisotonicSlice {
  let result = ml_regress_isotonic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_isotonic_slice_min(s : MlregressisotonicSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_slice_max(s : MlregressisotonicSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_isotonic_slice_to_string(s : MlregressisotonicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

