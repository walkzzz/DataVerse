///===
/// extcore/ml_ensemble_boosting

pub(all) struct MlensembleboostingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_ensemble_boosting_make_point(x : Double, y : Double) -> MlensembleboostingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_ensemble_boosting_make_point3(x : Double, y : Double, z : Double) -> MlensembleboostingPoint {
  { x, y, z, label: 0 }
}

pub fn ml_ensemble_boosting_point_x(pt : MlensembleboostingPoint) -> Double { pt.x }

pub fn ml_ensemble_boosting_point_y(pt : MlensembleboostingPoint) -> Double { pt.y }

pub fn ml_ensemble_boosting_point_z(pt : MlensembleboostingPoint) -> Double { pt.z }

pub fn ml_ensemble_boosting_point_label(pt : MlensembleboostingPoint) -> Int { pt.label }

pub fn ml_ensemble_boosting_point_dist(a : MlensembleboostingPoint, b : MlensembleboostingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_ensemble_boosting_point_add(a : MlensembleboostingPoint, b : MlensembleboostingPoint) -> MlensembleboostingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_ensemble_boosting_point_sub(a : MlensembleboostingPoint, b : MlensembleboostingPoint) -> MlensembleboostingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_ensemble_boosting_point_scale(pt : MlensembleboostingPoint, s : Double) -> MlensembleboostingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_ensemble_boosting_point_dot(a : MlensembleboostingPoint, b : MlensembleboostingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_ensemble_boosting_point_cross(a : MlensembleboostingPoint, b : MlensembleboostingPoint) -> MlensembleboostingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_ensemble_boosting_point_norm(pt : MlensembleboostingPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_ensemble_boosting_point_normalize(pt : MlensembleboostingPoint) -> MlensembleboostingPoint {
  let n = ml_ensemble_boosting_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_ensemble_boosting_point_scale(pt, 1.0 / n) }
}

pub fn ml_ensemble_boosting_point_negate(pt : MlensembleboostingPoint) -> MlensembleboostingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_ensemble_boosting_point_mid(a : MlensembleboostingPoint, b : MlensembleboostingPoint) -> MlensembleboostingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_ensemble_boosting_point_lerp(a : MlensembleboostingPoint, b : MlensembleboostingPoint, t : Double) -> MlensembleboostingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_ensemble_boosting_point_to_string(pt : MlensembleboostingPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlensembleboostingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_ensemble_boosting_make_series(vals : Array[Double], name : String) -> MlensembleboostingSeries {
  { vals, name, meta: 0 }
}

pub fn ml_ensemble_boosting_series_len(s : MlensembleboostingSeries) -> Int { s.vals.length() }

pub fn ml_ensemble_boosting_series_sum(s : MlensembleboostingSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_ensemble_boosting_series_mean(s : MlensembleboostingSeries) -> Double { @_common.mean(s.vals) }

pub fn ml_ensemble_boosting_series_min(s : MlensembleboostingSeries) -> Double { @_common.min(s.vals) }

pub fn ml_ensemble_boosting_series_max(s : MlensembleboostingSeries) -> Double { @_common.max(s.vals) }

pub fn ml_ensemble_boosting_series_range(s : MlensembleboostingSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn ml_ensemble_boosting_series_var(s : MlensembleboostingSeries) -> Double { @_common.variance(s.vals) }

pub fn ml_ensemble_boosting_series_std(s : MlensembleboostingSeries) -> Double { @_common.std(s.vals) }

pub fn ml_ensemble_boosting_series_median(s : MlensembleboostingSeries) -> Double { @_common.median(s.vals) }

pub fn ml_ensemble_boosting_series_scale(s : MlensembleboostingSeries, f : Double) -> MlensembleboostingSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_ensemble_boosting_series_add(a : MlensembleboostingSeries, b : MlensembleboostingSeries) -> MlensembleboostingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_ensemble_boosting_series_sub(a : MlensembleboostingSeries, b : MlensembleboostingSeries) -> MlensembleboostingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_ensemble_boosting_series_normalize(s : MlensembleboostingSeries) -> MlensembleboostingSeries {
  let mn = ml_ensemble_boosting_series_min(s)
  let mx = ml_ensemble_boosting_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_ensemble_boosting_series_cumsum(s : MlensembleboostingSeries) -> MlensembleboostingSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_ensemble_boosting_series_to_string(s : MlensembleboostingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlensembleboostingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_ensemble_boosting_make_matrix(rows : Int, cols : Int, val : Double) -> MlensembleboostingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_ensemble_boosting_matrix_identity(n : Int) -> MlensembleboostingMatrix {
  let m = ml_ensemble_boosting_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_ensemble_boosting_matrix_get(m : MlensembleboostingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_ensemble_boosting_matrix_transpose(m : MlensembleboostingMatrix) -> MlensembleboostingMatrix {
  let result = ml_ensemble_boosting_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_ensemble_boosting_matrix_add(a : MlensembleboostingMatrix, b : MlensembleboostingMatrix) -> MlensembleboostingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_ensemble_boosting_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_ensemble_boosting_matrix_scale(m : MlensembleboostingMatrix, s : Double) -> MlensembleboostingMatrix {
  let result = ml_ensemble_boosting_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_ensemble_boosting_matrix_multiply(a : MlensembleboostingMatrix, b : MlensembleboostingMatrix) -> MlensembleboostingMatrix {
  if a.cols != b.rows { return ml_ensemble_boosting_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_ensemble_boosting_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_ensemble_boosting_matrix_trace(m : MlensembleboostingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_ensemble_boosting_matrix_det(m : MlensembleboostingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_ensemble_boosting_matrix_norm(m : MlensembleboostingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_ensemble_boosting_matrix_to_string(m : MlensembleboostingMatrix) -> String {
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

pub(all) struct MlensembleboostingVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_ensemble_boosting_make_vector(comps : Array[Double]) -> MlensembleboostingVector {
  { comps, dim: comps.length() }
}

pub fn ml_ensemble_boosting_vector_zero(dim : Int) -> MlensembleboostingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_ensemble_boosting_vector_add(a : MlensembleboostingVector, b : MlensembleboostingVector) -> MlensembleboostingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_ensemble_boosting_vector_sub(a : MlensembleboostingVector, b : MlensembleboostingVector) -> MlensembleboostingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_ensemble_boosting_vector_scale(v : MlensembleboostingVector, s : Double) -> MlensembleboostingVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_ensemble_boosting_vector_dot(a : MlensembleboostingVector, b : MlensembleboostingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_ensemble_boosting_vector_norm(v : MlensembleboostingVector) -> Double { @_common.sqrt(ml_ensemble_boosting_vector_dot(v, v)) }

pub fn ml_ensemble_boosting_vector_normalize(v : MlensembleboostingVector) -> MlensembleboostingVector {
  let n = ml_ensemble_boosting_vector_norm(v)
  if n < 0.0000001 { v } else { ml_ensemble_boosting_vector_scale(v, 1.0 / n) }
}

pub fn ml_ensemble_boosting_vector_dist(a : MlensembleboostingVector, b : MlensembleboostingVector) -> Double {
  ml_ensemble_boosting_vector_norm(ml_ensemble_boosting_vector_sub(a, b))
}

pub fn ml_ensemble_boosting_vector_to_string(v : MlensembleboostingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_ensemble_boosting_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_ensemble_boosting_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_ensemble_boosting_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_ensemble_boosting_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_ensemble_boosting_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_ensemble_boosting_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_ensemble_boosting_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_ensemble_boosting_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_ensemble_boosting_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_ensemble_boosting_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_ensemble_boosting_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_ensemble_boosting_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_ensemble_boosting_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_ensemble_boosting_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_ensemble_boosting_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_ensemble_boosting_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_ensemble_boosting_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_ensemble_boosting_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_ensemble_boosting_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_ensemble_boosting_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_ensemble_boosting_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_ensemble_boosting_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_ensemble_boosting_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_ensemble_boosting_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_ensemble_boosting_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_ensemble_boosting_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_ensemble_boosting_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_ensemble_boosting_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_ensemble_boosting_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlensembleboostingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_frame_make(size : Int) -> MlensembleboostingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_frame_len(s : MlensembleboostingFrame) -> Int { s.size }

pub fn ml_ensemble_boosting_frame_get(s : MlensembleboostingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_frame_set(s : MlensembleboostingFrame, i : Int, v : Double) -> MlensembleboostingFrame {
  let result = ml_ensemble_boosting_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_frame_sum(s : MlensembleboostingFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_boosting_frame_mean(s : MlensembleboostingFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_boosting_frame_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_boosting_frame_scale(s : MlensembleboostingFrame, f : Double) -> MlensembleboostingFrame {
  let result = ml_ensemble_boosting_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_boosting_frame_add(a : MlensembleboostingFrame, b : MlensembleboostingFrame) -> MlensembleboostingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_boosting_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_boosting_frame_copy(s : MlensembleboostingFrame) -> MlensembleboostingFrame {
  let result = ml_ensemble_boosting_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_boosting_frame_fill(s : MlensembleboostingFrame, v : Double) -> MlensembleboostingFrame {
  let result = ml_ensemble_boosting_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_frame_min(s : MlensembleboostingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_frame_max(s : MlensembleboostingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_frame_to_string(s : MlensembleboostingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_table_make(size : Int) -> MlensembleboostingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_table_len(s : MlensembleboostingTable) -> Int { s.size }

pub fn ml_ensemble_boosting_table_get(s : MlensembleboostingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_table_set(s : MlensembleboostingTable, i : Int, v : Double) -> MlensembleboostingTable {
  let result = ml_ensemble_boosting_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_table_sum(s : MlensembleboostingTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_boosting_table_mean(s : MlensembleboostingTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_boosting_table_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_boosting_table_scale(s : MlensembleboostingTable, f : Double) -> MlensembleboostingTable {
  let result = ml_ensemble_boosting_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_boosting_table_add(a : MlensembleboostingTable, b : MlensembleboostingTable) -> MlensembleboostingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_boosting_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_boosting_table_copy(s : MlensembleboostingTable) -> MlensembleboostingTable {
  let result = ml_ensemble_boosting_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_boosting_table_fill(s : MlensembleboostingTable, v : Double) -> MlensembleboostingTable {
  let result = ml_ensemble_boosting_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_table_min(s : MlensembleboostingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_table_max(s : MlensembleboostingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_table_to_string(s : MlensembleboostingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_graphn_make(size : Int) -> MlensembleboostingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_graphn_len(s : MlensembleboostingGraphN) -> Int { s.size }

pub fn ml_ensemble_boosting_graphn_get(s : MlensembleboostingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_graphn_set(s : MlensembleboostingGraphN, i : Int, v : Double) -> MlensembleboostingGraphN {
  let result = ml_ensemble_boosting_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_graphn_sum(s : MlensembleboostingGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_boosting_graphn_mean(s : MlensembleboostingGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_boosting_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_boosting_graphn_scale(s : MlensembleboostingGraphN, f : Double) -> MlensembleboostingGraphN {
  let result = ml_ensemble_boosting_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_boosting_graphn_add(a : MlensembleboostingGraphN, b : MlensembleboostingGraphN) -> MlensembleboostingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_boosting_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_boosting_graphn_copy(s : MlensembleboostingGraphN) -> MlensembleboostingGraphN {
  let result = ml_ensemble_boosting_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_boosting_graphn_fill(s : MlensembleboostingGraphN, v : Double) -> MlensembleboostingGraphN {
  let result = ml_ensemble_boosting_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_graphn_min(s : MlensembleboostingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_graphn_max(s : MlensembleboostingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_graphn_to_string(s : MlensembleboostingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_node_make(size : Int) -> MlensembleboostingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_node_len(s : MlensembleboostingNode) -> Int { s.size }

pub fn ml_ensemble_boosting_node_get(s : MlensembleboostingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_node_set(s : MlensembleboostingNode, i : Int, v : Double) -> MlensembleboostingNode {
  let result = ml_ensemble_boosting_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_node_sum(s : MlensembleboostingNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_boosting_node_mean(s : MlensembleboostingNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_boosting_node_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_boosting_node_scale(s : MlensembleboostingNode, f : Double) -> MlensembleboostingNode {
  let result = ml_ensemble_boosting_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_boosting_node_add(a : MlensembleboostingNode, b : MlensembleboostingNode) -> MlensembleboostingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_boosting_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_boosting_node_copy(s : MlensembleboostingNode) -> MlensembleboostingNode {
  let result = ml_ensemble_boosting_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_boosting_node_fill(s : MlensembleboostingNode, v : Double) -> MlensembleboostingNode {
  let result = ml_ensemble_boosting_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_node_min(s : MlensembleboostingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_node_max(s : MlensembleboostingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_node_to_string(s : MlensembleboostingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_edge_make(size : Int) -> MlensembleboostingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_edge_len(s : MlensembleboostingEdge) -> Int { s.size }

pub fn ml_ensemble_boosting_edge_get(s : MlensembleboostingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_edge_set(s : MlensembleboostingEdge, i : Int, v : Double) -> MlensembleboostingEdge {
  let result = ml_ensemble_boosting_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_edge_sum(s : MlensembleboostingEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_boosting_edge_mean(s : MlensembleboostingEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_boosting_edge_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_boosting_edge_scale(s : MlensembleboostingEdge, f : Double) -> MlensembleboostingEdge {
  let result = ml_ensemble_boosting_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_boosting_edge_add(a : MlensembleboostingEdge, b : MlensembleboostingEdge) -> MlensembleboostingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_boosting_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_boosting_edge_copy(s : MlensembleboostingEdge) -> MlensembleboostingEdge {
  let result = ml_ensemble_boosting_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_boosting_edge_fill(s : MlensembleboostingEdge, v : Double) -> MlensembleboostingEdge {
  let result = ml_ensemble_boosting_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_edge_min(s : MlensembleboostingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_edge_max(s : MlensembleboostingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_edge_to_string(s : MlensembleboostingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_path_make(size : Int) -> MlensembleboostingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_path_len(s : MlensembleboostingPath) -> Int { s.size }

pub fn ml_ensemble_boosting_path_get(s : MlensembleboostingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_path_set(s : MlensembleboostingPath, i : Int, v : Double) -> MlensembleboostingPath {
  let result = ml_ensemble_boosting_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_path_sum(s : MlensembleboostingPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_boosting_path_mean(s : MlensembleboostingPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_boosting_path_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_boosting_path_scale(s : MlensembleboostingPath, f : Double) -> MlensembleboostingPath {
  let result = ml_ensemble_boosting_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_boosting_path_add(a : MlensembleboostingPath, b : MlensembleboostingPath) -> MlensembleboostingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_boosting_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_boosting_path_copy(s : MlensembleboostingPath) -> MlensembleboostingPath {
  let result = ml_ensemble_boosting_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_boosting_path_fill(s : MlensembleboostingPath, v : Double) -> MlensembleboostingPath {
  let result = ml_ensemble_boosting_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_path_min(s : MlensembleboostingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_path_max(s : MlensembleboostingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_path_to_string(s : MlensembleboostingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_cluster_make(size : Int) -> MlensembleboostingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_cluster_len(s : MlensembleboostingCluster) -> Int { s.size }

pub fn ml_ensemble_boosting_cluster_get(s : MlensembleboostingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_cluster_set(s : MlensembleboostingCluster, i : Int, v : Double) -> MlensembleboostingCluster {
  let result = ml_ensemble_boosting_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_cluster_sum(s : MlensembleboostingCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_boosting_cluster_mean(s : MlensembleboostingCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_boosting_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_boosting_cluster_scale(s : MlensembleboostingCluster, f : Double) -> MlensembleboostingCluster {
  let result = ml_ensemble_boosting_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_boosting_cluster_add(a : MlensembleboostingCluster, b : MlensembleboostingCluster) -> MlensembleboostingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_boosting_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_boosting_cluster_copy(s : MlensembleboostingCluster) -> MlensembleboostingCluster {
  let result = ml_ensemble_boosting_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_boosting_cluster_fill(s : MlensembleboostingCluster, v : Double) -> MlensembleboostingCluster {
  let result = ml_ensemble_boosting_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_cluster_min(s : MlensembleboostingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_cluster_max(s : MlensembleboostingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_cluster_to_string(s : MlensembleboostingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_model_make(size : Int) -> MlensembleboostingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_model_len(s : MlensembleboostingModel) -> Int { s.size }

pub fn ml_ensemble_boosting_model_get(s : MlensembleboostingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_model_set(s : MlensembleboostingModel, i : Int, v : Double) -> MlensembleboostingModel {
  let result = ml_ensemble_boosting_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_model_sum(s : MlensembleboostingModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_boosting_model_mean(s : MlensembleboostingModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_boosting_model_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_boosting_model_scale(s : MlensembleboostingModel, f : Double) -> MlensembleboostingModel {
  let result = ml_ensemble_boosting_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_boosting_model_add(a : MlensembleboostingModel, b : MlensembleboostingModel) -> MlensembleboostingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_boosting_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_boosting_model_copy(s : MlensembleboostingModel) -> MlensembleboostingModel {
  let result = ml_ensemble_boosting_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_boosting_model_fill(s : MlensembleboostingModel, v : Double) -> MlensembleboostingModel {
  let result = ml_ensemble_boosting_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_model_min(s : MlensembleboostingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_model_max(s : MlensembleboostingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_model_to_string(s : MlensembleboostingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_layer_make(size : Int) -> MlensembleboostingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_layer_len(s : MlensembleboostingLayer) -> Int { s.size }

pub fn ml_ensemble_boosting_layer_get(s : MlensembleboostingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_layer_set(s : MlensembleboostingLayer, i : Int, v : Double) -> MlensembleboostingLayer {
  let result = ml_ensemble_boosting_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_layer_sum(s : MlensembleboostingLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_boosting_layer_mean(s : MlensembleboostingLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_boosting_layer_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_boosting_layer_scale(s : MlensembleboostingLayer, f : Double) -> MlensembleboostingLayer {
  let result = ml_ensemble_boosting_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_boosting_layer_add(a : MlensembleboostingLayer, b : MlensembleboostingLayer) -> MlensembleboostingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_boosting_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_boosting_layer_copy(s : MlensembleboostingLayer) -> MlensembleboostingLayer {
  let result = ml_ensemble_boosting_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_boosting_layer_fill(s : MlensembleboostingLayer, v : Double) -> MlensembleboostingLayer {
  let result = ml_ensemble_boosting_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_layer_min(s : MlensembleboostingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_layer_max(s : MlensembleboostingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_layer_to_string(s : MlensembleboostingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_buffer_make(size : Int) -> MlensembleboostingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_buffer_len(s : MlensembleboostingBuffer) -> Int { s.size }

pub fn ml_ensemble_boosting_buffer_get(s : MlensembleboostingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_buffer_set(s : MlensembleboostingBuffer, i : Int, v : Double) -> MlensembleboostingBuffer {
  let result = ml_ensemble_boosting_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_buffer_sum(s : MlensembleboostingBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_boosting_buffer_mean(s : MlensembleboostingBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_boosting_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_boosting_buffer_scale(s : MlensembleboostingBuffer, f : Double) -> MlensembleboostingBuffer {
  let result = ml_ensemble_boosting_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_boosting_buffer_add(a : MlensembleboostingBuffer, b : MlensembleboostingBuffer) -> MlensembleboostingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_boosting_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_boosting_buffer_copy(s : MlensembleboostingBuffer) -> MlensembleboostingBuffer {
  let result = ml_ensemble_boosting_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_boosting_buffer_fill(s : MlensembleboostingBuffer, v : Double) -> MlensembleboostingBuffer {
  let result = ml_ensemble_boosting_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_buffer_min(s : MlensembleboostingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_buffer_max(s : MlensembleboostingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_buffer_to_string(s : MlensembleboostingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_cursor_make(size : Int) -> MlensembleboostingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_cursor_len(s : MlensembleboostingCursor) -> Int { s.size }

pub fn ml_ensemble_boosting_cursor_get(s : MlensembleboostingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_cursor_set(s : MlensembleboostingCursor, i : Int, v : Double) -> MlensembleboostingCursor {
  let result = ml_ensemble_boosting_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_cursor_sum(s : MlensembleboostingCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_boosting_cursor_mean(s : MlensembleboostingCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_boosting_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_boosting_cursor_scale(s : MlensembleboostingCursor, f : Double) -> MlensembleboostingCursor {
  let result = ml_ensemble_boosting_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_boosting_cursor_add(a : MlensembleboostingCursor, b : MlensembleboostingCursor) -> MlensembleboostingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_boosting_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_boosting_cursor_copy(s : MlensembleboostingCursor) -> MlensembleboostingCursor {
  let result = ml_ensemble_boosting_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_boosting_cursor_fill(s : MlensembleboostingCursor, v : Double) -> MlensembleboostingCursor {
  let result = ml_ensemble_boosting_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_cursor_min(s : MlensembleboostingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_cursor_max(s : MlensembleboostingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_cursor_to_string(s : MlensembleboostingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_view_make(size : Int) -> MlensembleboostingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_view_len(s : MlensembleboostingView) -> Int { s.size }

pub fn ml_ensemble_boosting_view_get(s : MlensembleboostingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_view_set(s : MlensembleboostingView, i : Int, v : Double) -> MlensembleboostingView {
  let result = ml_ensemble_boosting_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_view_sum(s : MlensembleboostingView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_boosting_view_mean(s : MlensembleboostingView) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_boosting_view_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_boosting_view_scale(s : MlensembleboostingView, f : Double) -> MlensembleboostingView {
  let result = ml_ensemble_boosting_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_boosting_view_add(a : MlensembleboostingView, b : MlensembleboostingView) -> MlensembleboostingView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_boosting_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_boosting_view_copy(s : MlensembleboostingView) -> MlensembleboostingView {
  let result = ml_ensemble_boosting_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_boosting_view_fill(s : MlensembleboostingView, v : Double) -> MlensembleboostingView {
  let result = ml_ensemble_boosting_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_view_min(s : MlensembleboostingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_view_max(s : MlensembleboostingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_view_to_string(s : MlensembleboostingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_range_make(size : Int) -> MlensembleboostingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_range_len(s : MlensembleboostingRange) -> Int { s.size }

pub fn ml_ensemble_boosting_range_get(s : MlensembleboostingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_range_set(s : MlensembleboostingRange, i : Int, v : Double) -> MlensembleboostingRange {
  let result = ml_ensemble_boosting_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_range_sum(s : MlensembleboostingRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_boosting_range_mean(s : MlensembleboostingRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_boosting_range_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_boosting_range_scale(s : MlensembleboostingRange, f : Double) -> MlensembleboostingRange {
  let result = ml_ensemble_boosting_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_boosting_range_add(a : MlensembleboostingRange, b : MlensembleboostingRange) -> MlensembleboostingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_boosting_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_boosting_range_copy(s : MlensembleboostingRange) -> MlensembleboostingRange {
  let result = ml_ensemble_boosting_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_boosting_range_fill(s : MlensembleboostingRange, v : Double) -> MlensembleboostingRange {
  let result = ml_ensemble_boosting_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_range_min(s : MlensembleboostingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_range_max(s : MlensembleboostingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_range_to_string(s : MlensembleboostingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlensembleboostingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_ensemble_boosting_slice_make(size : Int) -> MlensembleboostingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_ensemble_boosting_slice_len(s : MlensembleboostingSlice) -> Int { s.size }

pub fn ml_ensemble_boosting_slice_get(s : MlensembleboostingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_ensemble_boosting_slice_set(s : MlensembleboostingSlice, i : Int, v : Double) -> MlensembleboostingSlice {
  let result = ml_ensemble_boosting_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_slice_sum(s : MlensembleboostingSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_ensemble_boosting_slice_mean(s : MlensembleboostingSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_ensemble_boosting_slice_sum(s) / s.size.to_double() }
}

pub fn ml_ensemble_boosting_slice_scale(s : MlensembleboostingSlice, f : Double) -> MlensembleboostingSlice {
  let result = ml_ensemble_boosting_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_ensemble_boosting_slice_add(a : MlensembleboostingSlice, b : MlensembleboostingSlice) -> MlensembleboostingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_ensemble_boosting_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_ensemble_boosting_slice_copy(s : MlensembleboostingSlice) -> MlensembleboostingSlice {
  let result = ml_ensemble_boosting_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_ensemble_boosting_slice_fill(s : MlensembleboostingSlice, v : Double) -> MlensembleboostingSlice {
  let result = ml_ensemble_boosting_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_ensemble_boosting_slice_min(s : MlensembleboostingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_slice_max(s : MlensembleboostingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_ensemble_boosting_slice_to_string(s : MlensembleboostingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

