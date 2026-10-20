///===
/// extcore/ml_rl_qlearning

pub(all) struct MlrlqlearningPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_qlearning_make_point(x : Double, y : Double) -> MlrlqlearningPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_qlearning_make_point3(x : Double, y : Double, z : Double) -> MlrlqlearningPoint {
  { x, y, z, label: 0 }
}

pub fn ml_rl_qlearning_point_x(pt : MlrlqlearningPoint) -> Double { pt.x }

pub fn ml_rl_qlearning_point_y(pt : MlrlqlearningPoint) -> Double { pt.y }

pub fn ml_rl_qlearning_point_z(pt : MlrlqlearningPoint) -> Double { pt.z }

pub fn ml_rl_qlearning_point_label(pt : MlrlqlearningPoint) -> Int { pt.label }

pub fn ml_rl_qlearning_point_dist(a : MlrlqlearningPoint, b : MlrlqlearningPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_rl_qlearning_point_add(a : MlrlqlearningPoint, b : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_rl_qlearning_point_sub(a : MlrlqlearningPoint, b : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_rl_qlearning_point_scale(pt : MlrlqlearningPoint, s : Double) -> MlrlqlearningPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_rl_qlearning_point_dot(a : MlrlqlearningPoint, b : MlrlqlearningPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_rl_qlearning_point_cross(a : MlrlqlearningPoint, b : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_rl_qlearning_point_norm(pt : MlrlqlearningPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_rl_qlearning_point_normalize(pt : MlrlqlearningPoint) -> MlrlqlearningPoint {
  let n = ml_rl_qlearning_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_rl_qlearning_point_scale(pt, 1.0 / n) }
}

pub fn ml_rl_qlearning_point_negate(pt : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_rl_qlearning_point_mid(a : MlrlqlearningPoint, b : MlrlqlearningPoint) -> MlrlqlearningPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_rl_qlearning_point_lerp(a : MlrlqlearningPoint, b : MlrlqlearningPoint, t : Double) -> MlrlqlearningPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_rl_qlearning_point_to_string(pt : MlrlqlearningPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlrlqlearningSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_qlearning_make_series(vals : Array[Double], name : String) -> MlrlqlearningSeries {
  { vals, name, meta: 0 }
}

pub fn ml_rl_qlearning_series_len(s : MlrlqlearningSeries) -> Int { s.vals.length() }

pub fn ml_rl_qlearning_series_sum(s : MlrlqlearningSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_rl_qlearning_series_mean(s : MlrlqlearningSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_rl_qlearning_series_min(s : MlrlqlearningSeries) -> Double { @_common.min(s.vals) }

pub fn ml_rl_qlearning_series_max(s : MlrlqlearningSeries) -> Double { @_common.max(s.vals) }

pub fn ml_rl_qlearning_series_range(s : MlrlqlearningSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_rl_qlearning_series_var(s : MlrlqlearningSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_rl_qlearning_series_std(s : MlrlqlearningSeries) -> Double { @_common.std(s.vals) }

pub fn ml_rl_qlearning_series_median(s : MlrlqlearningSeries) -> Double { @_common.median(s.vals) }

pub fn ml_rl_qlearning_series_scale(s : MlrlqlearningSeries, f : Double) -> MlrlqlearningSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_rl_qlearning_series_add(a : MlrlqlearningSeries, b : MlrlqlearningSeries) -> MlrlqlearningSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_rl_qlearning_series_sub(a : MlrlqlearningSeries, b : MlrlqlearningSeries) -> MlrlqlearningSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_rl_qlearning_series_normalize(s : MlrlqlearningSeries) -> MlrlqlearningSeries {
  let mn = ml_rl_qlearning_series_min(s)
  let mx = ml_rl_qlearning_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_rl_qlearning_series_cumsum(s : MlrlqlearningSeries) -> MlrlqlearningSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_rl_qlearning_series_to_string(s : MlrlqlearningSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlqlearningMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_qlearning_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlqlearningMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_qlearning_matrix_identity(n : Int) -> MlrlqlearningMatrix {
  let m = ml_rl_qlearning_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_rl_qlearning_matrix_get(m : MlrlqlearningMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_rl_qlearning_matrix_transpose(m : MlrlqlearningMatrix) -> MlrlqlearningMatrix {
  let result = ml_rl_qlearning_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_rl_qlearning_matrix_add(a : MlrlqlearningMatrix, b : MlrlqlearningMatrix) -> MlrlqlearningMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_rl_qlearning_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_rl_qlearning_matrix_scale(m : MlrlqlearningMatrix, s : Double) -> MlrlqlearningMatrix {
  let result = ml_rl_qlearning_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_rl_qlearning_matrix_multiply(a : MlrlqlearningMatrix, b : MlrlqlearningMatrix) -> MlrlqlearningMatrix {
  if a.cols != b.rows { return ml_rl_qlearning_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_rl_qlearning_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_rl_qlearning_matrix_trace(m : MlrlqlearningMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_rl_qlearning_matrix_det(m : MlrlqlearningMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_rl_qlearning_matrix_norm(m : MlrlqlearningMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_rl_qlearning_matrix_to_string(m : MlrlqlearningMatrix) -> String {
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

pub(all) struct MlrlqlearningVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_qlearning_make_vector(comps : Array[Double]) -> MlrlqlearningVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_qlearning_vector_zero(dim : Int) -> MlrlqlearningVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_rl_qlearning_vector_add(a : MlrlqlearningVector, b : MlrlqlearningVector) -> MlrlqlearningVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_qlearning_vector_sub(a : MlrlqlearningVector, b : MlrlqlearningVector) -> MlrlqlearningVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_qlearning_vector_scale(v : MlrlqlearningVector, s : Double) -> MlrlqlearningVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_rl_qlearning_vector_dot(a : MlrlqlearningVector, b : MlrlqlearningVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_rl_qlearning_vector_norm(v : MlrlqlearningVector) -> Double { @_common.sqrt(ml_rl_qlearning_vector_dot(v, v)) }

pub fn ml_rl_qlearning_vector_normalize(v : MlrlqlearningVector) -> MlrlqlearningVector {
  let n = ml_rl_qlearning_vector_norm(v)
  if n < 0.0000001 { v } else { ml_rl_qlearning_vector_scale(v, 1.0 / n) }
}

pub fn ml_rl_qlearning_vector_dist(a : MlrlqlearningVector, b : MlrlqlearningVector) -> Double {
  ml_rl_qlearning_vector_norm(ml_rl_qlearning_vector_sub(a, b))
}

pub fn ml_rl_qlearning_vector_to_string(v : MlrlqlearningVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_qlearning_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_rl_qlearning_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_rl_qlearning_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_rl_qlearning_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_rl_qlearning_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_rl_qlearning_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_rl_qlearning_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_rl_qlearning_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_rl_qlearning_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_rl_qlearning_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_rl_qlearning_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_rl_qlearning_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_rl_qlearning_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_rl_qlearning_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_rl_qlearning_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_rl_qlearning_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_rl_qlearning_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_rl_qlearning_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_rl_qlearning_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_rl_qlearning_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_rl_qlearning_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_rl_qlearning_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_rl_qlearning_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_rl_qlearning_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_rl_qlearning_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_rl_qlearning_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_rl_qlearning_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_rl_qlearning_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_rl_qlearning_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlrlqlearningFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_frame_make(size : Int) -> MlrlqlearningFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_frame_len(s : MlrlqlearningFrame) -> Int { s.size }

pub fn ml_rl_qlearning_frame_get(s : MlrlqlearningFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_frame_set(s : MlrlqlearningFrame, i : Int, v : Double) -> MlrlqlearningFrame {
  let result = ml_rl_qlearning_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_frame_sum(s : MlrlqlearningFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_frame_mean(s : MlrlqlearningFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_frame_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_frame_scale(s : MlrlqlearningFrame, f : Double) -> MlrlqlearningFrame {
  let result = ml_rl_qlearning_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_frame_add(a : MlrlqlearningFrame, b : MlrlqlearningFrame) -> MlrlqlearningFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_frame_copy(s : MlrlqlearningFrame) -> MlrlqlearningFrame {
  let result = ml_rl_qlearning_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_frame_fill(s : MlrlqlearningFrame, v : Double) -> MlrlqlearningFrame {
  let result = ml_rl_qlearning_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_frame_min(s : MlrlqlearningFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_frame_max(s : MlrlqlearningFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_frame_to_string(s : MlrlqlearningFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_table_make(size : Int) -> MlrlqlearningTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_table_len(s : MlrlqlearningTable) -> Int { s.size }

pub fn ml_rl_qlearning_table_get(s : MlrlqlearningTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_table_set(s : MlrlqlearningTable, i : Int, v : Double) -> MlrlqlearningTable {
  let result = ml_rl_qlearning_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_table_sum(s : MlrlqlearningTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_table_mean(s : MlrlqlearningTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_table_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_table_scale(s : MlrlqlearningTable, f : Double) -> MlrlqlearningTable {
  let result = ml_rl_qlearning_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_table_add(a : MlrlqlearningTable, b : MlrlqlearningTable) -> MlrlqlearningTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_table_copy(s : MlrlqlearningTable) -> MlrlqlearningTable {
  let result = ml_rl_qlearning_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_table_fill(s : MlrlqlearningTable, v : Double) -> MlrlqlearningTable {
  let result = ml_rl_qlearning_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_table_min(s : MlrlqlearningTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_table_max(s : MlrlqlearningTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_table_to_string(s : MlrlqlearningTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_graphn_make(size : Int) -> MlrlqlearningGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_graphn_len(s : MlrlqlearningGraphN) -> Int { s.size }

pub fn ml_rl_qlearning_graphn_get(s : MlrlqlearningGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_graphn_set(s : MlrlqlearningGraphN, i : Int, v : Double) -> MlrlqlearningGraphN {
  let result = ml_rl_qlearning_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_graphn_sum(s : MlrlqlearningGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_graphn_mean(s : MlrlqlearningGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_graphn_scale(s : MlrlqlearningGraphN, f : Double) -> MlrlqlearningGraphN {
  let result = ml_rl_qlearning_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_graphn_add(a : MlrlqlearningGraphN, b : MlrlqlearningGraphN) -> MlrlqlearningGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_graphn_copy(s : MlrlqlearningGraphN) -> MlrlqlearningGraphN {
  let result = ml_rl_qlearning_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_graphn_fill(s : MlrlqlearningGraphN, v : Double) -> MlrlqlearningGraphN {
  let result = ml_rl_qlearning_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_graphn_min(s : MlrlqlearningGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_graphn_max(s : MlrlqlearningGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_graphn_to_string(s : MlrlqlearningGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_node_make(size : Int) -> MlrlqlearningNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_node_len(s : MlrlqlearningNode) -> Int { s.size }

pub fn ml_rl_qlearning_node_get(s : MlrlqlearningNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_node_set(s : MlrlqlearningNode, i : Int, v : Double) -> MlrlqlearningNode {
  let result = ml_rl_qlearning_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_node_sum(s : MlrlqlearningNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_node_mean(s : MlrlqlearningNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_node_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_node_scale(s : MlrlqlearningNode, f : Double) -> MlrlqlearningNode {
  let result = ml_rl_qlearning_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_node_add(a : MlrlqlearningNode, b : MlrlqlearningNode) -> MlrlqlearningNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_node_copy(s : MlrlqlearningNode) -> MlrlqlearningNode {
  let result = ml_rl_qlearning_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_node_fill(s : MlrlqlearningNode, v : Double) -> MlrlqlearningNode {
  let result = ml_rl_qlearning_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_node_min(s : MlrlqlearningNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_node_max(s : MlrlqlearningNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_node_to_string(s : MlrlqlearningNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_edge_make(size : Int) -> MlrlqlearningEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_edge_len(s : MlrlqlearningEdge) -> Int { s.size }

pub fn ml_rl_qlearning_edge_get(s : MlrlqlearningEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_edge_set(s : MlrlqlearningEdge, i : Int, v : Double) -> MlrlqlearningEdge {
  let result = ml_rl_qlearning_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_edge_sum(s : MlrlqlearningEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_edge_mean(s : MlrlqlearningEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_edge_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_edge_scale(s : MlrlqlearningEdge, f : Double) -> MlrlqlearningEdge {
  let result = ml_rl_qlearning_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_edge_add(a : MlrlqlearningEdge, b : MlrlqlearningEdge) -> MlrlqlearningEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_edge_copy(s : MlrlqlearningEdge) -> MlrlqlearningEdge {
  let result = ml_rl_qlearning_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_edge_fill(s : MlrlqlearningEdge, v : Double) -> MlrlqlearningEdge {
  let result = ml_rl_qlearning_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_edge_min(s : MlrlqlearningEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_edge_max(s : MlrlqlearningEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_edge_to_string(s : MlrlqlearningEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_path_make(size : Int) -> MlrlqlearningPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_path_len(s : MlrlqlearningPath) -> Int { s.size }

pub fn ml_rl_qlearning_path_get(s : MlrlqlearningPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_path_set(s : MlrlqlearningPath, i : Int, v : Double) -> MlrlqlearningPath {
  let result = ml_rl_qlearning_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_path_sum(s : MlrlqlearningPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_path_mean(s : MlrlqlearningPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_path_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_path_scale(s : MlrlqlearningPath, f : Double) -> MlrlqlearningPath {
  let result = ml_rl_qlearning_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_path_add(a : MlrlqlearningPath, b : MlrlqlearningPath) -> MlrlqlearningPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_path_copy(s : MlrlqlearningPath) -> MlrlqlearningPath {
  let result = ml_rl_qlearning_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_path_fill(s : MlrlqlearningPath, v : Double) -> MlrlqlearningPath {
  let result = ml_rl_qlearning_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_path_min(s : MlrlqlearningPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_path_max(s : MlrlqlearningPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_path_to_string(s : MlrlqlearningPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_cluster_make(size : Int) -> MlrlqlearningCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_cluster_len(s : MlrlqlearningCluster) -> Int { s.size }

pub fn ml_rl_qlearning_cluster_get(s : MlrlqlearningCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_cluster_set(s : MlrlqlearningCluster, i : Int, v : Double) -> MlrlqlearningCluster {
  let result = ml_rl_qlearning_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_cluster_sum(s : MlrlqlearningCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_cluster_mean(s : MlrlqlearningCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_cluster_scale(s : MlrlqlearningCluster, f : Double) -> MlrlqlearningCluster {
  let result = ml_rl_qlearning_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_cluster_add(a : MlrlqlearningCluster, b : MlrlqlearningCluster) -> MlrlqlearningCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_cluster_copy(s : MlrlqlearningCluster) -> MlrlqlearningCluster {
  let result = ml_rl_qlearning_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_cluster_fill(s : MlrlqlearningCluster, v : Double) -> MlrlqlearningCluster {
  let result = ml_rl_qlearning_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_cluster_min(s : MlrlqlearningCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_cluster_max(s : MlrlqlearningCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_cluster_to_string(s : MlrlqlearningCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_model_make(size : Int) -> MlrlqlearningModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_model_len(s : MlrlqlearningModel) -> Int { s.size }

pub fn ml_rl_qlearning_model_get(s : MlrlqlearningModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_model_set(s : MlrlqlearningModel, i : Int, v : Double) -> MlrlqlearningModel {
  let result = ml_rl_qlearning_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_model_sum(s : MlrlqlearningModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_model_mean(s : MlrlqlearningModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_model_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_model_scale(s : MlrlqlearningModel, f : Double) -> MlrlqlearningModel {
  let result = ml_rl_qlearning_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_model_add(a : MlrlqlearningModel, b : MlrlqlearningModel) -> MlrlqlearningModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_model_copy(s : MlrlqlearningModel) -> MlrlqlearningModel {
  let result = ml_rl_qlearning_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_model_fill(s : MlrlqlearningModel, v : Double) -> MlrlqlearningModel {
  let result = ml_rl_qlearning_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_model_min(s : MlrlqlearningModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_model_max(s : MlrlqlearningModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_model_to_string(s : MlrlqlearningModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_layer_make(size : Int) -> MlrlqlearningLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_layer_len(s : MlrlqlearningLayer) -> Int { s.size }

pub fn ml_rl_qlearning_layer_get(s : MlrlqlearningLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_layer_set(s : MlrlqlearningLayer, i : Int, v : Double) -> MlrlqlearningLayer {
  let result = ml_rl_qlearning_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_layer_sum(s : MlrlqlearningLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_layer_mean(s : MlrlqlearningLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_layer_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_layer_scale(s : MlrlqlearningLayer, f : Double) -> MlrlqlearningLayer {
  let result = ml_rl_qlearning_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_layer_add(a : MlrlqlearningLayer, b : MlrlqlearningLayer) -> MlrlqlearningLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_layer_copy(s : MlrlqlearningLayer) -> MlrlqlearningLayer {
  let result = ml_rl_qlearning_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_layer_fill(s : MlrlqlearningLayer, v : Double) -> MlrlqlearningLayer {
  let result = ml_rl_qlearning_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_layer_min(s : MlrlqlearningLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_layer_max(s : MlrlqlearningLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_layer_to_string(s : MlrlqlearningLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_buffer_make(size : Int) -> MlrlqlearningBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_buffer_len(s : MlrlqlearningBuffer) -> Int { s.size }

pub fn ml_rl_qlearning_buffer_get(s : MlrlqlearningBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_buffer_set(s : MlrlqlearningBuffer, i : Int, v : Double) -> MlrlqlearningBuffer {
  let result = ml_rl_qlearning_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_buffer_sum(s : MlrlqlearningBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_buffer_mean(s : MlrlqlearningBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_buffer_scale(s : MlrlqlearningBuffer, f : Double) -> MlrlqlearningBuffer {
  let result = ml_rl_qlearning_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_buffer_add(a : MlrlqlearningBuffer, b : MlrlqlearningBuffer) -> MlrlqlearningBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_buffer_copy(s : MlrlqlearningBuffer) -> MlrlqlearningBuffer {
  let result = ml_rl_qlearning_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_buffer_fill(s : MlrlqlearningBuffer, v : Double) -> MlrlqlearningBuffer {
  let result = ml_rl_qlearning_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_buffer_min(s : MlrlqlearningBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_buffer_max(s : MlrlqlearningBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_buffer_to_string(s : MlrlqlearningBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_cursor_make(size : Int) -> MlrlqlearningCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_cursor_len(s : MlrlqlearningCursor) -> Int { s.size }

pub fn ml_rl_qlearning_cursor_get(s : MlrlqlearningCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_cursor_set(s : MlrlqlearningCursor, i : Int, v : Double) -> MlrlqlearningCursor {
  let result = ml_rl_qlearning_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_cursor_sum(s : MlrlqlearningCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_cursor_mean(s : MlrlqlearningCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_cursor_scale(s : MlrlqlearningCursor, f : Double) -> MlrlqlearningCursor {
  let result = ml_rl_qlearning_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_cursor_add(a : MlrlqlearningCursor, b : MlrlqlearningCursor) -> MlrlqlearningCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_cursor_copy(s : MlrlqlearningCursor) -> MlrlqlearningCursor {
  let result = ml_rl_qlearning_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_cursor_fill(s : MlrlqlearningCursor, v : Double) -> MlrlqlearningCursor {
  let result = ml_rl_qlearning_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_cursor_min(s : MlrlqlearningCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_cursor_max(s : MlrlqlearningCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_cursor_to_string(s : MlrlqlearningCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_view_make(size : Int) -> MlrlqlearningView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_view_len(s : MlrlqlearningView) -> Int { s.size }

pub fn ml_rl_qlearning_view_get(s : MlrlqlearningView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_view_set(s : MlrlqlearningView, i : Int, v : Double) -> MlrlqlearningView {
  let result = ml_rl_qlearning_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_view_sum(s : MlrlqlearningView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_view_mean(s : MlrlqlearningView) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_view_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_view_scale(s : MlrlqlearningView, f : Double) -> MlrlqlearningView {
  let result = ml_rl_qlearning_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_view_add(a : MlrlqlearningView, b : MlrlqlearningView) -> MlrlqlearningView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_view_copy(s : MlrlqlearningView) -> MlrlqlearningView {
  let result = ml_rl_qlearning_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_view_fill(s : MlrlqlearningView, v : Double) -> MlrlqlearningView {
  let result = ml_rl_qlearning_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_view_min(s : MlrlqlearningView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_view_max(s : MlrlqlearningView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_view_to_string(s : MlrlqlearningView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_range_make(size : Int) -> MlrlqlearningRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_range_len(s : MlrlqlearningRange) -> Int { s.size }

pub fn ml_rl_qlearning_range_get(s : MlrlqlearningRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_range_set(s : MlrlqlearningRange, i : Int, v : Double) -> MlrlqlearningRange {
  let result = ml_rl_qlearning_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_range_sum(s : MlrlqlearningRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_range_mean(s : MlrlqlearningRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_range_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_range_scale(s : MlrlqlearningRange, f : Double) -> MlrlqlearningRange {
  let result = ml_rl_qlearning_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_range_add(a : MlrlqlearningRange, b : MlrlqlearningRange) -> MlrlqlearningRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_range_copy(s : MlrlqlearningRange) -> MlrlqlearningRange {
  let result = ml_rl_qlearning_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_range_fill(s : MlrlqlearningRange, v : Double) -> MlrlqlearningRange {
  let result = ml_rl_qlearning_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_range_min(s : MlrlqlearningRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_range_max(s : MlrlqlearningRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_range_to_string(s : MlrlqlearningRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlqlearningSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_qlearning_slice_make(size : Int) -> MlrlqlearningSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_qlearning_slice_len(s : MlrlqlearningSlice) -> Int { s.size }

pub fn ml_rl_qlearning_slice_get(s : MlrlqlearningSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_qlearning_slice_set(s : MlrlqlearningSlice, i : Int, v : Double) -> MlrlqlearningSlice {
  let result = ml_rl_qlearning_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_slice_sum(s : MlrlqlearningSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_qlearning_slice_mean(s : MlrlqlearningSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_qlearning_slice_sum(s) / s.size.to_double() }
}

pub fn ml_rl_qlearning_slice_scale(s : MlrlqlearningSlice, f : Double) -> MlrlqlearningSlice {
  let result = ml_rl_qlearning_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_qlearning_slice_add(a : MlrlqlearningSlice, b : MlrlqlearningSlice) -> MlrlqlearningSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_qlearning_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_qlearning_slice_copy(s : MlrlqlearningSlice) -> MlrlqlearningSlice {
  let result = ml_rl_qlearning_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_qlearning_slice_fill(s : MlrlqlearningSlice, v : Double) -> MlrlqlearningSlice {
  let result = ml_rl_qlearning_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_qlearning_slice_min(s : MlrlqlearningSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_slice_max(s : MlrlqlearningSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_qlearning_slice_to_string(s : MlrlqlearningSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

