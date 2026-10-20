///===
/// extcore/ml_regress_cox

pub(all) struct MlregresscoxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_cox_make_point(x : Double, y : Double) -> MlregresscoxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_cox_make_point3(x : Double, y : Double, z : Double) -> MlregresscoxPoint {
  { x, y, z, label: 0 }
}

pub fn ml_regress_cox_point_x(pt : MlregresscoxPoint) -> Double { pt.x }

pub fn ml_regress_cox_point_y(pt : MlregresscoxPoint) -> Double { pt.y }

pub fn ml_regress_cox_point_z(pt : MlregresscoxPoint) -> Double { pt.z }

pub fn ml_regress_cox_point_label(pt : MlregresscoxPoint) -> Int { pt.label }

pub fn ml_regress_cox_point_dist(a : MlregresscoxPoint, b : MlregresscoxPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_regress_cox_point_add(a : MlregresscoxPoint, b : MlregresscoxPoint) -> MlregresscoxPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_regress_cox_point_sub(a : MlregresscoxPoint, b : MlregresscoxPoint) -> MlregresscoxPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_regress_cox_point_scale(pt : MlregresscoxPoint, s : Double) -> MlregresscoxPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_regress_cox_point_dot(a : MlregresscoxPoint, b : MlregresscoxPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_regress_cox_point_cross(a : MlregresscoxPoint, b : MlregresscoxPoint) -> MlregresscoxPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_regress_cox_point_norm(pt : MlregresscoxPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_regress_cox_point_normalize(pt : MlregresscoxPoint) -> MlregresscoxPoint {
  let n = ml_regress_cox_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_regress_cox_point_scale(pt, 1.0 / n) }
}

pub fn ml_regress_cox_point_negate(pt : MlregresscoxPoint) -> MlregresscoxPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_regress_cox_point_mid(a : MlregresscoxPoint, b : MlregresscoxPoint) -> MlregresscoxPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_regress_cox_point_lerp(a : MlregresscoxPoint, b : MlregresscoxPoint, t : Double) -> MlregresscoxPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_regress_cox_point_to_string(pt : MlregresscoxPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlregresscoxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_cox_make_series(vals : Array[Double], name : String) -> MlregresscoxSeries {
  { vals, name, meta: 0 }
}

pub fn ml_regress_cox_series_len(s : MlregresscoxSeries) -> Int { s.vals.length() }

pub fn ml_regress_cox_series_sum(s : MlregresscoxSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_regress_cox_series_mean(s : MlregresscoxSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_regress_cox_series_min(s : MlregresscoxSeries) -> Double { @_common.min(s.vals) }

pub fn ml_regress_cox_series_max(s : MlregresscoxSeries) -> Double { @_common.max(s.vals) }

pub fn ml_regress_cox_series_range(s : MlregresscoxSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_regress_cox_series_var(s : MlregresscoxSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_regress_cox_series_std(s : MlregresscoxSeries) -> Double { @_common.std(s.vals) }

pub fn ml_regress_cox_series_median(s : MlregresscoxSeries) -> Double { @_common.median(s.vals) }

pub fn ml_regress_cox_series_scale(s : MlregresscoxSeries, f : Double) -> MlregresscoxSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_regress_cox_series_add(a : MlregresscoxSeries, b : MlregresscoxSeries) -> MlregresscoxSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_regress_cox_series_sub(a : MlregresscoxSeries, b : MlregresscoxSeries) -> MlregresscoxSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_regress_cox_series_normalize(s : MlregresscoxSeries) -> MlregresscoxSeries {
  let mn = ml_regress_cox_series_min(s)
  let mx = ml_regress_cox_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_regress_cox_series_cumsum(s : MlregresscoxSeries) -> MlregresscoxSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_regress_cox_series_to_string(s : MlregresscoxSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresscoxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_cox_make_matrix(rows : Int, cols : Int, val : Double) -> MlregresscoxMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_cox_matrix_identity(n : Int) -> MlregresscoxMatrix {
  let m = ml_regress_cox_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_regress_cox_matrix_get(m : MlregresscoxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_regress_cox_matrix_transpose(m : MlregresscoxMatrix) -> MlregresscoxMatrix {
  let result = ml_regress_cox_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_regress_cox_matrix_add(a : MlregresscoxMatrix, b : MlregresscoxMatrix) -> MlregresscoxMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_regress_cox_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_regress_cox_matrix_scale(m : MlregresscoxMatrix, s : Double) -> MlregresscoxMatrix {
  let result = ml_regress_cox_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_regress_cox_matrix_multiply(a : MlregresscoxMatrix, b : MlregresscoxMatrix) -> MlregresscoxMatrix {
  if a.cols != b.rows { return ml_regress_cox_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_regress_cox_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_regress_cox_matrix_trace(m : MlregresscoxMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_regress_cox_matrix_det(m : MlregresscoxMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_regress_cox_matrix_norm(m : MlregresscoxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_regress_cox_matrix_to_string(m : MlregresscoxMatrix) -> String {
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

pub(all) struct MlregresscoxVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_cox_make_vector(comps : Array[Double]) -> MlregresscoxVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_cox_vector_zero(dim : Int) -> MlregresscoxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_regress_cox_vector_add(a : MlregresscoxVector, b : MlregresscoxVector) -> MlregresscoxVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_regress_cox_vector_sub(a : MlregresscoxVector, b : MlregresscoxVector) -> MlregresscoxVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_regress_cox_vector_scale(v : MlregresscoxVector, s : Double) -> MlregresscoxVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_regress_cox_vector_dot(a : MlregresscoxVector, b : MlregresscoxVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_regress_cox_vector_norm(v : MlregresscoxVector) -> Double { @_common.sqrt(ml_regress_cox_vector_dot(v, v)) }

pub fn ml_regress_cox_vector_normalize(v : MlregresscoxVector) -> MlregresscoxVector {
  let n = ml_regress_cox_vector_norm(v)
  if n < 0.0000001 { v } else { ml_regress_cox_vector_scale(v, 1.0 / n) }
}

pub fn ml_regress_cox_vector_dist(a : MlregresscoxVector, b : MlregresscoxVector) -> Double {
  ml_regress_cox_vector_norm(ml_regress_cox_vector_sub(a, b))
}

pub fn ml_regress_cox_vector_to_string(v : MlregresscoxVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_regress_cox_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_regress_cox_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_regress_cox_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_regress_cox_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_regress_cox_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_regress_cox_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_regress_cox_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_regress_cox_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_regress_cox_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_regress_cox_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_regress_cox_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_regress_cox_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_regress_cox_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_regress_cox_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_regress_cox_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_regress_cox_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_regress_cox_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_regress_cox_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_regress_cox_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_regress_cox_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_regress_cox_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_regress_cox_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_regress_cox_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_regress_cox_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_regress_cox_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_regress_cox_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_regress_cox_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_regress_cox_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_regress_cox_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlregresscoxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_frame_make(size : Int) -> MlregresscoxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_frame_len(s : MlregresscoxFrame) -> Int { s.size }

pub fn ml_regress_cox_frame_get(s : MlregresscoxFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_frame_set(s : MlregresscoxFrame, i : Int, v : Double) -> MlregresscoxFrame {
  let result = ml_regress_cox_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_frame_sum(s : MlregresscoxFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_cox_frame_mean(s : MlregresscoxFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_cox_frame_sum(s) / s.size.to_double() }
}

pub fn ml_regress_cox_frame_scale(s : MlregresscoxFrame, f : Double) -> MlregresscoxFrame {
  let result = ml_regress_cox_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_cox_frame_add(a : MlregresscoxFrame, b : MlregresscoxFrame) -> MlregresscoxFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_cox_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_cox_frame_copy(s : MlregresscoxFrame) -> MlregresscoxFrame {
  let result = ml_regress_cox_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_cox_frame_fill(s : MlregresscoxFrame, v : Double) -> MlregresscoxFrame {
  let result = ml_regress_cox_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_frame_min(s : MlregresscoxFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_frame_max(s : MlregresscoxFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_frame_to_string(s : MlregresscoxFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_table_make(size : Int) -> MlregresscoxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_table_len(s : MlregresscoxTable) -> Int { s.size }

pub fn ml_regress_cox_table_get(s : MlregresscoxTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_table_set(s : MlregresscoxTable, i : Int, v : Double) -> MlregresscoxTable {
  let result = ml_regress_cox_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_table_sum(s : MlregresscoxTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_cox_table_mean(s : MlregresscoxTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_cox_table_sum(s) / s.size.to_double() }
}

pub fn ml_regress_cox_table_scale(s : MlregresscoxTable, f : Double) -> MlregresscoxTable {
  let result = ml_regress_cox_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_cox_table_add(a : MlregresscoxTable, b : MlregresscoxTable) -> MlregresscoxTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_cox_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_cox_table_copy(s : MlregresscoxTable) -> MlregresscoxTable {
  let result = ml_regress_cox_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_cox_table_fill(s : MlregresscoxTable, v : Double) -> MlregresscoxTable {
  let result = ml_regress_cox_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_table_min(s : MlregresscoxTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_table_max(s : MlregresscoxTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_table_to_string(s : MlregresscoxTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_graphn_make(size : Int) -> MlregresscoxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_graphn_len(s : MlregresscoxGraphN) -> Int { s.size }

pub fn ml_regress_cox_graphn_get(s : MlregresscoxGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_graphn_set(s : MlregresscoxGraphN, i : Int, v : Double) -> MlregresscoxGraphN {
  let result = ml_regress_cox_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_graphn_sum(s : MlregresscoxGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_cox_graphn_mean(s : MlregresscoxGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_cox_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_regress_cox_graphn_scale(s : MlregresscoxGraphN, f : Double) -> MlregresscoxGraphN {
  let result = ml_regress_cox_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_cox_graphn_add(a : MlregresscoxGraphN, b : MlregresscoxGraphN) -> MlregresscoxGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_cox_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_cox_graphn_copy(s : MlregresscoxGraphN) -> MlregresscoxGraphN {
  let result = ml_regress_cox_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_cox_graphn_fill(s : MlregresscoxGraphN, v : Double) -> MlregresscoxGraphN {
  let result = ml_regress_cox_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_graphn_min(s : MlregresscoxGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_graphn_max(s : MlregresscoxGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_graphn_to_string(s : MlregresscoxGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_node_make(size : Int) -> MlregresscoxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_node_len(s : MlregresscoxNode) -> Int { s.size }

pub fn ml_regress_cox_node_get(s : MlregresscoxNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_node_set(s : MlregresscoxNode, i : Int, v : Double) -> MlregresscoxNode {
  let result = ml_regress_cox_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_node_sum(s : MlregresscoxNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_cox_node_mean(s : MlregresscoxNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_cox_node_sum(s) / s.size.to_double() }
}

pub fn ml_regress_cox_node_scale(s : MlregresscoxNode, f : Double) -> MlregresscoxNode {
  let result = ml_regress_cox_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_cox_node_add(a : MlregresscoxNode, b : MlregresscoxNode) -> MlregresscoxNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_cox_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_cox_node_copy(s : MlregresscoxNode) -> MlregresscoxNode {
  let result = ml_regress_cox_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_cox_node_fill(s : MlregresscoxNode, v : Double) -> MlregresscoxNode {
  let result = ml_regress_cox_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_node_min(s : MlregresscoxNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_node_max(s : MlregresscoxNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_node_to_string(s : MlregresscoxNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_edge_make(size : Int) -> MlregresscoxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_edge_len(s : MlregresscoxEdge) -> Int { s.size }

pub fn ml_regress_cox_edge_get(s : MlregresscoxEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_edge_set(s : MlregresscoxEdge, i : Int, v : Double) -> MlregresscoxEdge {
  let result = ml_regress_cox_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_edge_sum(s : MlregresscoxEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_cox_edge_mean(s : MlregresscoxEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_cox_edge_sum(s) / s.size.to_double() }
}

pub fn ml_regress_cox_edge_scale(s : MlregresscoxEdge, f : Double) -> MlregresscoxEdge {
  let result = ml_regress_cox_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_cox_edge_add(a : MlregresscoxEdge, b : MlregresscoxEdge) -> MlregresscoxEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_cox_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_cox_edge_copy(s : MlregresscoxEdge) -> MlregresscoxEdge {
  let result = ml_regress_cox_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_cox_edge_fill(s : MlregresscoxEdge, v : Double) -> MlregresscoxEdge {
  let result = ml_regress_cox_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_edge_min(s : MlregresscoxEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_edge_max(s : MlregresscoxEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_edge_to_string(s : MlregresscoxEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_path_make(size : Int) -> MlregresscoxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_path_len(s : MlregresscoxPath) -> Int { s.size }

pub fn ml_regress_cox_path_get(s : MlregresscoxPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_path_set(s : MlregresscoxPath, i : Int, v : Double) -> MlregresscoxPath {
  let result = ml_regress_cox_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_path_sum(s : MlregresscoxPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_cox_path_mean(s : MlregresscoxPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_cox_path_sum(s) / s.size.to_double() }
}

pub fn ml_regress_cox_path_scale(s : MlregresscoxPath, f : Double) -> MlregresscoxPath {
  let result = ml_regress_cox_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_cox_path_add(a : MlregresscoxPath, b : MlregresscoxPath) -> MlregresscoxPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_cox_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_cox_path_copy(s : MlregresscoxPath) -> MlregresscoxPath {
  let result = ml_regress_cox_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_cox_path_fill(s : MlregresscoxPath, v : Double) -> MlregresscoxPath {
  let result = ml_regress_cox_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_path_min(s : MlregresscoxPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_path_max(s : MlregresscoxPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_path_to_string(s : MlregresscoxPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_cluster_make(size : Int) -> MlregresscoxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_cluster_len(s : MlregresscoxCluster) -> Int { s.size }

pub fn ml_regress_cox_cluster_get(s : MlregresscoxCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_cluster_set(s : MlregresscoxCluster, i : Int, v : Double) -> MlregresscoxCluster {
  let result = ml_regress_cox_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_cluster_sum(s : MlregresscoxCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_cox_cluster_mean(s : MlregresscoxCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_cox_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_regress_cox_cluster_scale(s : MlregresscoxCluster, f : Double) -> MlregresscoxCluster {
  let result = ml_regress_cox_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_cox_cluster_add(a : MlregresscoxCluster, b : MlregresscoxCluster) -> MlregresscoxCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_cox_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_cox_cluster_copy(s : MlregresscoxCluster) -> MlregresscoxCluster {
  let result = ml_regress_cox_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_cox_cluster_fill(s : MlregresscoxCluster, v : Double) -> MlregresscoxCluster {
  let result = ml_regress_cox_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_cluster_min(s : MlregresscoxCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_cluster_max(s : MlregresscoxCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_cluster_to_string(s : MlregresscoxCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_model_make(size : Int) -> MlregresscoxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_model_len(s : MlregresscoxModel) -> Int { s.size }

pub fn ml_regress_cox_model_get(s : MlregresscoxModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_model_set(s : MlregresscoxModel, i : Int, v : Double) -> MlregresscoxModel {
  let result = ml_regress_cox_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_model_sum(s : MlregresscoxModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_cox_model_mean(s : MlregresscoxModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_cox_model_sum(s) / s.size.to_double() }
}

pub fn ml_regress_cox_model_scale(s : MlregresscoxModel, f : Double) -> MlregresscoxModel {
  let result = ml_regress_cox_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_cox_model_add(a : MlregresscoxModel, b : MlregresscoxModel) -> MlregresscoxModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_cox_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_cox_model_copy(s : MlregresscoxModel) -> MlregresscoxModel {
  let result = ml_regress_cox_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_cox_model_fill(s : MlregresscoxModel, v : Double) -> MlregresscoxModel {
  let result = ml_regress_cox_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_model_min(s : MlregresscoxModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_model_max(s : MlregresscoxModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_model_to_string(s : MlregresscoxModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_layer_make(size : Int) -> MlregresscoxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_layer_len(s : MlregresscoxLayer) -> Int { s.size }

pub fn ml_regress_cox_layer_get(s : MlregresscoxLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_layer_set(s : MlregresscoxLayer, i : Int, v : Double) -> MlregresscoxLayer {
  let result = ml_regress_cox_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_layer_sum(s : MlregresscoxLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_cox_layer_mean(s : MlregresscoxLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_cox_layer_sum(s) / s.size.to_double() }
}

pub fn ml_regress_cox_layer_scale(s : MlregresscoxLayer, f : Double) -> MlregresscoxLayer {
  let result = ml_regress_cox_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_cox_layer_add(a : MlregresscoxLayer, b : MlregresscoxLayer) -> MlregresscoxLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_cox_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_cox_layer_copy(s : MlregresscoxLayer) -> MlregresscoxLayer {
  let result = ml_regress_cox_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_cox_layer_fill(s : MlregresscoxLayer, v : Double) -> MlregresscoxLayer {
  let result = ml_regress_cox_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_layer_min(s : MlregresscoxLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_layer_max(s : MlregresscoxLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_layer_to_string(s : MlregresscoxLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_buffer_make(size : Int) -> MlregresscoxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_buffer_len(s : MlregresscoxBuffer) -> Int { s.size }

pub fn ml_regress_cox_buffer_get(s : MlregresscoxBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_buffer_set(s : MlregresscoxBuffer, i : Int, v : Double) -> MlregresscoxBuffer {
  let result = ml_regress_cox_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_buffer_sum(s : MlregresscoxBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_cox_buffer_mean(s : MlregresscoxBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_cox_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_regress_cox_buffer_scale(s : MlregresscoxBuffer, f : Double) -> MlregresscoxBuffer {
  let result = ml_regress_cox_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_cox_buffer_add(a : MlregresscoxBuffer, b : MlregresscoxBuffer) -> MlregresscoxBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_cox_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_cox_buffer_copy(s : MlregresscoxBuffer) -> MlregresscoxBuffer {
  let result = ml_regress_cox_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_cox_buffer_fill(s : MlregresscoxBuffer, v : Double) -> MlregresscoxBuffer {
  let result = ml_regress_cox_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_buffer_min(s : MlregresscoxBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_buffer_max(s : MlregresscoxBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_buffer_to_string(s : MlregresscoxBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_cursor_make(size : Int) -> MlregresscoxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_cursor_len(s : MlregresscoxCursor) -> Int { s.size }

pub fn ml_regress_cox_cursor_get(s : MlregresscoxCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_cursor_set(s : MlregresscoxCursor, i : Int, v : Double) -> MlregresscoxCursor {
  let result = ml_regress_cox_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_cursor_sum(s : MlregresscoxCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_cox_cursor_mean(s : MlregresscoxCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_cox_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_regress_cox_cursor_scale(s : MlregresscoxCursor, f : Double) -> MlregresscoxCursor {
  let result = ml_regress_cox_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_cox_cursor_add(a : MlregresscoxCursor, b : MlregresscoxCursor) -> MlregresscoxCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_cox_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_cox_cursor_copy(s : MlregresscoxCursor) -> MlregresscoxCursor {
  let result = ml_regress_cox_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_cox_cursor_fill(s : MlregresscoxCursor, v : Double) -> MlregresscoxCursor {
  let result = ml_regress_cox_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_cursor_min(s : MlregresscoxCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_cursor_max(s : MlregresscoxCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_cursor_to_string(s : MlregresscoxCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_view_make(size : Int) -> MlregresscoxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_view_len(s : MlregresscoxView) -> Int { s.size }

pub fn ml_regress_cox_view_get(s : MlregresscoxView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_view_set(s : MlregresscoxView, i : Int, v : Double) -> MlregresscoxView {
  let result = ml_regress_cox_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_view_sum(s : MlregresscoxView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_cox_view_mean(s : MlregresscoxView) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_cox_view_sum(s) / s.size.to_double() }
}

pub fn ml_regress_cox_view_scale(s : MlregresscoxView, f : Double) -> MlregresscoxView {
  let result = ml_regress_cox_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_cox_view_add(a : MlregresscoxView, b : MlregresscoxView) -> MlregresscoxView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_cox_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_cox_view_copy(s : MlregresscoxView) -> MlregresscoxView {
  let result = ml_regress_cox_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_cox_view_fill(s : MlregresscoxView, v : Double) -> MlregresscoxView {
  let result = ml_regress_cox_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_view_min(s : MlregresscoxView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_view_max(s : MlregresscoxView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_view_to_string(s : MlregresscoxView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_range_make(size : Int) -> MlregresscoxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_range_len(s : MlregresscoxRange) -> Int { s.size }

pub fn ml_regress_cox_range_get(s : MlregresscoxRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_range_set(s : MlregresscoxRange, i : Int, v : Double) -> MlregresscoxRange {
  let result = ml_regress_cox_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_range_sum(s : MlregresscoxRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_cox_range_mean(s : MlregresscoxRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_cox_range_sum(s) / s.size.to_double() }
}

pub fn ml_regress_cox_range_scale(s : MlregresscoxRange, f : Double) -> MlregresscoxRange {
  let result = ml_regress_cox_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_cox_range_add(a : MlregresscoxRange, b : MlregresscoxRange) -> MlregresscoxRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_cox_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_cox_range_copy(s : MlregresscoxRange) -> MlregresscoxRange {
  let result = ml_regress_cox_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_cox_range_fill(s : MlregresscoxRange, v : Double) -> MlregresscoxRange {
  let result = ml_regress_cox_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_range_min(s : MlregresscoxRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_range_max(s : MlregresscoxRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_range_to_string(s : MlregresscoxRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresscoxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_cox_slice_make(size : Int) -> MlregresscoxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_cox_slice_len(s : MlregresscoxSlice) -> Int { s.size }

pub fn ml_regress_cox_slice_get(s : MlregresscoxSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_cox_slice_set(s : MlregresscoxSlice, i : Int, v : Double) -> MlregresscoxSlice {
  let result = ml_regress_cox_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_slice_sum(s : MlregresscoxSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_regress_cox_slice_mean(s : MlregresscoxSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_regress_cox_slice_sum(s) / s.size.to_double() }
}

pub fn ml_regress_cox_slice_scale(s : MlregresscoxSlice, f : Double) -> MlregresscoxSlice {
  let result = ml_regress_cox_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_regress_cox_slice_add(a : MlregresscoxSlice, b : MlregresscoxSlice) -> MlregresscoxSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_regress_cox_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_regress_cox_slice_copy(s : MlregresscoxSlice) -> MlregresscoxSlice {
  let result = ml_regress_cox_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_regress_cox_slice_fill(s : MlregresscoxSlice, v : Double) -> MlregresscoxSlice {
  let result = ml_regress_cox_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_regress_cox_slice_min(s : MlregresscoxSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_slice_max(s : MlregresscoxSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_regress_cox_slice_to_string(s : MlregresscoxSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

