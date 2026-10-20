///===
/// extcore/db_tx_compensating

pub(all) struct DbtxcompensatingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_compensating_make_point(x : Double, y : Double) -> DbtxcompensatingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_compensating_make_point3(x : Double, y : Double, z : Double) -> DbtxcompensatingPoint {
  { x, y, z, label: 0 }
}

pub fn db_tx_compensating_point_x(pt : DbtxcompensatingPoint) -> Double { pt.x }

pub fn db_tx_compensating_point_y(pt : DbtxcompensatingPoint) -> Double { pt.y }

pub fn db_tx_compensating_point_z(pt : DbtxcompensatingPoint) -> Double { pt.z }

pub fn db_tx_compensating_point_label(pt : DbtxcompensatingPoint) -> Int { pt.label }

pub fn db_tx_compensating_point_dist(a : DbtxcompensatingPoint, b : DbtxcompensatingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_tx_compensating_point_add(a : DbtxcompensatingPoint, b : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_tx_compensating_point_sub(a : DbtxcompensatingPoint, b : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_tx_compensating_point_scale(pt : DbtxcompensatingPoint, s : Double) -> DbtxcompensatingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_tx_compensating_point_dot(a : DbtxcompensatingPoint, b : DbtxcompensatingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_tx_compensating_point_cross(a : DbtxcompensatingPoint, b : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_tx_compensating_point_norm(pt : DbtxcompensatingPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_tx_compensating_point_normalize(pt : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  let n = db_tx_compensating_point_norm(pt)
  if n < 0.0000001 { pt } else { db_tx_compensating_point_scale(pt, 1.0 / n) }
}

pub fn db_tx_compensating_point_negate(pt : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_tx_compensating_point_mid(a : DbtxcompensatingPoint, b : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_tx_compensating_point_lerp(a : DbtxcompensatingPoint, b : DbtxcompensatingPoint, t : Double) -> DbtxcompensatingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_tx_compensating_point_to_string(pt : DbtxcompensatingPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbtxcompensatingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_compensating_make_series(vals : Array[Double], name : String) -> DbtxcompensatingSeries {
  { vals, name, meta: 0 }
}

pub fn db_tx_compensating_series_len(s : DbtxcompensatingSeries) -> Int { s.vals.length() }

pub fn db_tx_compensating_series_sum(s : DbtxcompensatingSeries) -> Double { @_common.sum(s.vals) }

pub fn db_tx_compensating_series_mean(s : DbtxcompensatingSeries) -> Double { @_common.mean(s.vals) }

pub fn db_tx_compensating_series_min(s : DbtxcompensatingSeries) -> Double { @_common.min(s.vals) }

pub fn db_tx_compensating_series_max(s : DbtxcompensatingSeries) -> Double { @_common.max(s.vals) }

pub fn db_tx_compensating_series_range(s : DbtxcompensatingSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_tx_compensating_series_var(s : DbtxcompensatingSeries) -> Double { @_common.variance(s.vals) }

pub fn db_tx_compensating_series_std(s : DbtxcompensatingSeries) -> Double { @_common.std(s.vals) }

pub fn db_tx_compensating_series_median(s : DbtxcompensatingSeries) -> Double { @_common.median(s.vals) }

pub fn db_tx_compensating_series_scale(s : DbtxcompensatingSeries, f : Double) -> DbtxcompensatingSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_tx_compensating_series_add(a : DbtxcompensatingSeries, b : DbtxcompensatingSeries) -> DbtxcompensatingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_tx_compensating_series_sub(a : DbtxcompensatingSeries, b : DbtxcompensatingSeries) -> DbtxcompensatingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_tx_compensating_series_normalize(s : DbtxcompensatingSeries) -> DbtxcompensatingSeries {
  let mn = db_tx_compensating_series_min(s)
  let mx = db_tx_compensating_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_tx_compensating_series_cumsum(s : DbtxcompensatingSeries) -> DbtxcompensatingSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_tx_compensating_series_to_string(s : DbtxcompensatingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxcompensatingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_compensating_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxcompensatingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_compensating_matrix_identity(n : Int) -> DbtxcompensatingMatrix {
  let m = db_tx_compensating_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_tx_compensating_matrix_get(m : DbtxcompensatingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_tx_compensating_matrix_transpose(m : DbtxcompensatingMatrix) -> DbtxcompensatingMatrix {
  let result = db_tx_compensating_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_tx_compensating_matrix_add(a : DbtxcompensatingMatrix, b : DbtxcompensatingMatrix) -> DbtxcompensatingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_tx_compensating_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_tx_compensating_matrix_scale(m : DbtxcompensatingMatrix, s : Double) -> DbtxcompensatingMatrix {
  let result = db_tx_compensating_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_tx_compensating_matrix_multiply(a : DbtxcompensatingMatrix, b : DbtxcompensatingMatrix) -> DbtxcompensatingMatrix {
  if a.cols != b.rows { return db_tx_compensating_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_tx_compensating_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_tx_compensating_matrix_trace(m : DbtxcompensatingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_tx_compensating_matrix_det(m : DbtxcompensatingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_tx_compensating_matrix_norm(m : DbtxcompensatingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_tx_compensating_matrix_to_string(m : DbtxcompensatingMatrix) -> String {
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

pub(all) struct DbtxcompensatingVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_compensating_make_vector(comps : Array[Double]) -> DbtxcompensatingVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_compensating_vector_zero(dim : Int) -> DbtxcompensatingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_tx_compensating_vector_add(a : DbtxcompensatingVector, b : DbtxcompensatingVector) -> DbtxcompensatingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_compensating_vector_sub(a : DbtxcompensatingVector, b : DbtxcompensatingVector) -> DbtxcompensatingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_compensating_vector_scale(v : DbtxcompensatingVector, s : Double) -> DbtxcompensatingVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_tx_compensating_vector_dot(a : DbtxcompensatingVector, b : DbtxcompensatingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_tx_compensating_vector_norm(v : DbtxcompensatingVector) -> Double { @_common.sqrt(db_tx_compensating_vector_dot(v, v)) }

pub fn db_tx_compensating_vector_normalize(v : DbtxcompensatingVector) -> DbtxcompensatingVector {
  let n = db_tx_compensating_vector_norm(v)
  if n < 0.0000001 { v } else { db_tx_compensating_vector_scale(v, 1.0 / n) }
}

pub fn db_tx_compensating_vector_dist(a : DbtxcompensatingVector, b : DbtxcompensatingVector) -> Double {
  db_tx_compensating_vector_norm(db_tx_compensating_vector_sub(a, b))
}

pub fn db_tx_compensating_vector_to_string(v : DbtxcompensatingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_compensating_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_tx_compensating_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_tx_compensating_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_tx_compensating_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_tx_compensating_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_tx_compensating_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_tx_compensating_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_tx_compensating_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_tx_compensating_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_tx_compensating_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_tx_compensating_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_tx_compensating_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_tx_compensating_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_tx_compensating_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_tx_compensating_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_tx_compensating_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_tx_compensating_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_tx_compensating_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_tx_compensating_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_tx_compensating_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_tx_compensating_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_tx_compensating_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_tx_compensating_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_tx_compensating_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_tx_compensating_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_tx_compensating_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_tx_compensating_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_tx_compensating_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_tx_compensating_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbtxcompensatingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_frame_make(size : Int) -> DbtxcompensatingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_frame_len(s : DbtxcompensatingFrame) -> Int { s.size }

pub fn db_tx_compensating_frame_get(s : DbtxcompensatingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_frame_set(s : DbtxcompensatingFrame, i : Int, v : Double) -> DbtxcompensatingFrame {
  let result = db_tx_compensating_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_frame_sum(s : DbtxcompensatingFrame) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_frame_mean(s : DbtxcompensatingFrame) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_frame_scale(s : DbtxcompensatingFrame, f : Double) -> DbtxcompensatingFrame {
  let result = db_tx_compensating_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_frame_add(a : DbtxcompensatingFrame, b : DbtxcompensatingFrame) -> DbtxcompensatingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_frame_copy(s : DbtxcompensatingFrame) -> DbtxcompensatingFrame {
  let result = db_tx_compensating_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_frame_fill(s : DbtxcompensatingFrame, v : Double) -> DbtxcompensatingFrame {
  let result = db_tx_compensating_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_frame_min(s : DbtxcompensatingFrame) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_frame_max(s : DbtxcompensatingFrame) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_frame_to_string(s : DbtxcompensatingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_table_make(size : Int) -> DbtxcompensatingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_table_len(s : DbtxcompensatingTable) -> Int { s.size }

pub fn db_tx_compensating_table_get(s : DbtxcompensatingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_table_set(s : DbtxcompensatingTable, i : Int, v : Double) -> DbtxcompensatingTable {
  let result = db_tx_compensating_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_table_sum(s : DbtxcompensatingTable) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_table_mean(s : DbtxcompensatingTable) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_table_scale(s : DbtxcompensatingTable, f : Double) -> DbtxcompensatingTable {
  let result = db_tx_compensating_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_table_add(a : DbtxcompensatingTable, b : DbtxcompensatingTable) -> DbtxcompensatingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_table_copy(s : DbtxcompensatingTable) -> DbtxcompensatingTable {
  let result = db_tx_compensating_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_table_fill(s : DbtxcompensatingTable, v : Double) -> DbtxcompensatingTable {
  let result = db_tx_compensating_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_table_min(s : DbtxcompensatingTable) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_table_max(s : DbtxcompensatingTable) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_table_to_string(s : DbtxcompensatingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_graphn_make(size : Int) -> DbtxcompensatingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_graphn_len(s : DbtxcompensatingGraphN) -> Int { s.size }

pub fn db_tx_compensating_graphn_get(s : DbtxcompensatingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_graphn_set(s : DbtxcompensatingGraphN, i : Int, v : Double) -> DbtxcompensatingGraphN {
  let result = db_tx_compensating_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_graphn_sum(s : DbtxcompensatingGraphN) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_graphn_mean(s : DbtxcompensatingGraphN) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_graphn_scale(s : DbtxcompensatingGraphN, f : Double) -> DbtxcompensatingGraphN {
  let result = db_tx_compensating_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_graphn_add(a : DbtxcompensatingGraphN, b : DbtxcompensatingGraphN) -> DbtxcompensatingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_graphn_copy(s : DbtxcompensatingGraphN) -> DbtxcompensatingGraphN {
  let result = db_tx_compensating_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_graphn_fill(s : DbtxcompensatingGraphN, v : Double) -> DbtxcompensatingGraphN {
  let result = db_tx_compensating_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_graphn_min(s : DbtxcompensatingGraphN) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_graphn_max(s : DbtxcompensatingGraphN) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_graphn_to_string(s : DbtxcompensatingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_node_make(size : Int) -> DbtxcompensatingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_node_len(s : DbtxcompensatingNode) -> Int { s.size }

pub fn db_tx_compensating_node_get(s : DbtxcompensatingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_node_set(s : DbtxcompensatingNode, i : Int, v : Double) -> DbtxcompensatingNode {
  let result = db_tx_compensating_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_node_sum(s : DbtxcompensatingNode) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_node_mean(s : DbtxcompensatingNode) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_node_scale(s : DbtxcompensatingNode, f : Double) -> DbtxcompensatingNode {
  let result = db_tx_compensating_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_node_add(a : DbtxcompensatingNode, b : DbtxcompensatingNode) -> DbtxcompensatingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_node_copy(s : DbtxcompensatingNode) -> DbtxcompensatingNode {
  let result = db_tx_compensating_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_node_fill(s : DbtxcompensatingNode, v : Double) -> DbtxcompensatingNode {
  let result = db_tx_compensating_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_node_min(s : DbtxcompensatingNode) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_node_max(s : DbtxcompensatingNode) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_node_to_string(s : DbtxcompensatingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_edge_make(size : Int) -> DbtxcompensatingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_edge_len(s : DbtxcompensatingEdge) -> Int { s.size }

pub fn db_tx_compensating_edge_get(s : DbtxcompensatingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_edge_set(s : DbtxcompensatingEdge, i : Int, v : Double) -> DbtxcompensatingEdge {
  let result = db_tx_compensating_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_edge_sum(s : DbtxcompensatingEdge) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_edge_mean(s : DbtxcompensatingEdge) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_edge_scale(s : DbtxcompensatingEdge, f : Double) -> DbtxcompensatingEdge {
  let result = db_tx_compensating_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_edge_add(a : DbtxcompensatingEdge, b : DbtxcompensatingEdge) -> DbtxcompensatingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_edge_copy(s : DbtxcompensatingEdge) -> DbtxcompensatingEdge {
  let result = db_tx_compensating_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_edge_fill(s : DbtxcompensatingEdge, v : Double) -> DbtxcompensatingEdge {
  let result = db_tx_compensating_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_edge_min(s : DbtxcompensatingEdge) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_edge_max(s : DbtxcompensatingEdge) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_edge_to_string(s : DbtxcompensatingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_path_make(size : Int) -> DbtxcompensatingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_path_len(s : DbtxcompensatingPath) -> Int { s.size }

pub fn db_tx_compensating_path_get(s : DbtxcompensatingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_path_set(s : DbtxcompensatingPath, i : Int, v : Double) -> DbtxcompensatingPath {
  let result = db_tx_compensating_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_path_sum(s : DbtxcompensatingPath) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_path_mean(s : DbtxcompensatingPath) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_path_scale(s : DbtxcompensatingPath, f : Double) -> DbtxcompensatingPath {
  let result = db_tx_compensating_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_path_add(a : DbtxcompensatingPath, b : DbtxcompensatingPath) -> DbtxcompensatingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_path_copy(s : DbtxcompensatingPath) -> DbtxcompensatingPath {
  let result = db_tx_compensating_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_path_fill(s : DbtxcompensatingPath, v : Double) -> DbtxcompensatingPath {
  let result = db_tx_compensating_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_path_min(s : DbtxcompensatingPath) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_path_max(s : DbtxcompensatingPath) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_path_to_string(s : DbtxcompensatingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_cluster_make(size : Int) -> DbtxcompensatingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_cluster_len(s : DbtxcompensatingCluster) -> Int { s.size }

pub fn db_tx_compensating_cluster_get(s : DbtxcompensatingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_cluster_set(s : DbtxcompensatingCluster, i : Int, v : Double) -> DbtxcompensatingCluster {
  let result = db_tx_compensating_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_cluster_sum(s : DbtxcompensatingCluster) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_cluster_mean(s : DbtxcompensatingCluster) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_cluster_scale(s : DbtxcompensatingCluster, f : Double) -> DbtxcompensatingCluster {
  let result = db_tx_compensating_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_cluster_add(a : DbtxcompensatingCluster, b : DbtxcompensatingCluster) -> DbtxcompensatingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_cluster_copy(s : DbtxcompensatingCluster) -> DbtxcompensatingCluster {
  let result = db_tx_compensating_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_cluster_fill(s : DbtxcompensatingCluster, v : Double) -> DbtxcompensatingCluster {
  let result = db_tx_compensating_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_cluster_min(s : DbtxcompensatingCluster) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_cluster_max(s : DbtxcompensatingCluster) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_cluster_to_string(s : DbtxcompensatingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_model_make(size : Int) -> DbtxcompensatingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_model_len(s : DbtxcompensatingModel) -> Int { s.size }

pub fn db_tx_compensating_model_get(s : DbtxcompensatingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_model_set(s : DbtxcompensatingModel, i : Int, v : Double) -> DbtxcompensatingModel {
  let result = db_tx_compensating_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_model_sum(s : DbtxcompensatingModel) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_model_mean(s : DbtxcompensatingModel) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_model_scale(s : DbtxcompensatingModel, f : Double) -> DbtxcompensatingModel {
  let result = db_tx_compensating_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_model_add(a : DbtxcompensatingModel, b : DbtxcompensatingModel) -> DbtxcompensatingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_model_copy(s : DbtxcompensatingModel) -> DbtxcompensatingModel {
  let result = db_tx_compensating_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_model_fill(s : DbtxcompensatingModel, v : Double) -> DbtxcompensatingModel {
  let result = db_tx_compensating_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_model_min(s : DbtxcompensatingModel) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_model_max(s : DbtxcompensatingModel) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_model_to_string(s : DbtxcompensatingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_layer_make(size : Int) -> DbtxcompensatingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_layer_len(s : DbtxcompensatingLayer) -> Int { s.size }

pub fn db_tx_compensating_layer_get(s : DbtxcompensatingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_layer_set(s : DbtxcompensatingLayer, i : Int, v : Double) -> DbtxcompensatingLayer {
  let result = db_tx_compensating_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_layer_sum(s : DbtxcompensatingLayer) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_layer_mean(s : DbtxcompensatingLayer) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_layer_scale(s : DbtxcompensatingLayer, f : Double) -> DbtxcompensatingLayer {
  let result = db_tx_compensating_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_layer_add(a : DbtxcompensatingLayer, b : DbtxcompensatingLayer) -> DbtxcompensatingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_layer_copy(s : DbtxcompensatingLayer) -> DbtxcompensatingLayer {
  let result = db_tx_compensating_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_layer_fill(s : DbtxcompensatingLayer, v : Double) -> DbtxcompensatingLayer {
  let result = db_tx_compensating_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_layer_min(s : DbtxcompensatingLayer) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_layer_max(s : DbtxcompensatingLayer) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_layer_to_string(s : DbtxcompensatingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_buffer_make(size : Int) -> DbtxcompensatingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_buffer_len(s : DbtxcompensatingBuffer) -> Int { s.size }

pub fn db_tx_compensating_buffer_get(s : DbtxcompensatingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_buffer_set(s : DbtxcompensatingBuffer, i : Int, v : Double) -> DbtxcompensatingBuffer {
  let result = db_tx_compensating_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_buffer_sum(s : DbtxcompensatingBuffer) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_buffer_mean(s : DbtxcompensatingBuffer) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_buffer_scale(s : DbtxcompensatingBuffer, f : Double) -> DbtxcompensatingBuffer {
  let result = db_tx_compensating_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_buffer_add(a : DbtxcompensatingBuffer, b : DbtxcompensatingBuffer) -> DbtxcompensatingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_buffer_copy(s : DbtxcompensatingBuffer) -> DbtxcompensatingBuffer {
  let result = db_tx_compensating_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_buffer_fill(s : DbtxcompensatingBuffer, v : Double) -> DbtxcompensatingBuffer {
  let result = db_tx_compensating_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_buffer_min(s : DbtxcompensatingBuffer) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_buffer_max(s : DbtxcompensatingBuffer) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_buffer_to_string(s : DbtxcompensatingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_cursor_make(size : Int) -> DbtxcompensatingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_cursor_len(s : DbtxcompensatingCursor) -> Int { s.size }

pub fn db_tx_compensating_cursor_get(s : DbtxcompensatingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_cursor_set(s : DbtxcompensatingCursor, i : Int, v : Double) -> DbtxcompensatingCursor {
  let result = db_tx_compensating_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_cursor_sum(s : DbtxcompensatingCursor) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_cursor_mean(s : DbtxcompensatingCursor) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_cursor_scale(s : DbtxcompensatingCursor, f : Double) -> DbtxcompensatingCursor {
  let result = db_tx_compensating_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_cursor_add(a : DbtxcompensatingCursor, b : DbtxcompensatingCursor) -> DbtxcompensatingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_cursor_copy(s : DbtxcompensatingCursor) -> DbtxcompensatingCursor {
  let result = db_tx_compensating_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_cursor_fill(s : DbtxcompensatingCursor, v : Double) -> DbtxcompensatingCursor {
  let result = db_tx_compensating_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_cursor_min(s : DbtxcompensatingCursor) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_cursor_max(s : DbtxcompensatingCursor) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_cursor_to_string(s : DbtxcompensatingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_view_make(size : Int) -> DbtxcompensatingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_view_len(s : DbtxcompensatingView) -> Int { s.size }

pub fn db_tx_compensating_view_get(s : DbtxcompensatingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_view_set(s : DbtxcompensatingView, i : Int, v : Double) -> DbtxcompensatingView {
  let result = db_tx_compensating_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_view_sum(s : DbtxcompensatingView) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_view_mean(s : DbtxcompensatingView) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_view_scale(s : DbtxcompensatingView, f : Double) -> DbtxcompensatingView {
  let result = db_tx_compensating_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_view_add(a : DbtxcompensatingView, b : DbtxcompensatingView) -> DbtxcompensatingView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_view_copy(s : DbtxcompensatingView) -> DbtxcompensatingView {
  let result = db_tx_compensating_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_view_fill(s : DbtxcompensatingView, v : Double) -> DbtxcompensatingView {
  let result = db_tx_compensating_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_view_min(s : DbtxcompensatingView) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_view_max(s : DbtxcompensatingView) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_view_to_string(s : DbtxcompensatingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_range_make(size : Int) -> DbtxcompensatingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_range_len(s : DbtxcompensatingRange) -> Int { s.size }

pub fn db_tx_compensating_range_get(s : DbtxcompensatingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_range_set(s : DbtxcompensatingRange, i : Int, v : Double) -> DbtxcompensatingRange {
  let result = db_tx_compensating_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_range_sum(s : DbtxcompensatingRange) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_range_mean(s : DbtxcompensatingRange) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_range_scale(s : DbtxcompensatingRange, f : Double) -> DbtxcompensatingRange {
  let result = db_tx_compensating_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_range_add(a : DbtxcompensatingRange, b : DbtxcompensatingRange) -> DbtxcompensatingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_range_copy(s : DbtxcompensatingRange) -> DbtxcompensatingRange {
  let result = db_tx_compensating_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_range_fill(s : DbtxcompensatingRange, v : Double) -> DbtxcompensatingRange {
  let result = db_tx_compensating_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_range_min(s : DbtxcompensatingRange) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_range_max(s : DbtxcompensatingRange) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_range_to_string(s : DbtxcompensatingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_slice_make(size : Int) -> DbtxcompensatingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_slice_len(s : DbtxcompensatingSlice) -> Int { s.size }

pub fn db_tx_compensating_slice_get(s : DbtxcompensatingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_slice_set(s : DbtxcompensatingSlice, i : Int, v : Double) -> DbtxcompensatingSlice {
  let result = db_tx_compensating_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_slice_sum(s : DbtxcompensatingSlice) -> Double { @_common.sum(s.data) }

pub fn db_tx_compensating_slice_mean(s : DbtxcompensatingSlice) -> Double { @_common.mean(s.data) }

pub fn db_tx_compensating_slice_scale(s : DbtxcompensatingSlice, f : Double) -> DbtxcompensatingSlice {
  let result = db_tx_compensating_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_slice_add(a : DbtxcompensatingSlice, b : DbtxcompensatingSlice) -> DbtxcompensatingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_slice_copy(s : DbtxcompensatingSlice) -> DbtxcompensatingSlice {
  let result = db_tx_compensating_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_slice_fill(s : DbtxcompensatingSlice, v : Double) -> DbtxcompensatingSlice {
  let result = db_tx_compensating_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_slice_min(s : DbtxcompensatingSlice) -> Double { @_common.min(s.data) }

pub fn db_tx_compensating_slice_max(s : DbtxcompensatingSlice) -> Double { @_common.max(s.data) }

pub fn db_tx_compensating_slice_to_string(s : DbtxcompensatingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

