///===
/// extcore/db_tx_timestamp

pub(all) struct DbtxtimestampPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_timestamp_make_point(x : Double, y : Double) -> DbtxtimestampPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_timestamp_make_point3(x : Double, y : Double, z : Double) -> DbtxtimestampPoint {
  { x, y, z, label: 0 }
}

pub fn db_tx_timestamp_point_x(pt : DbtxtimestampPoint) -> Double { pt.x }

pub fn db_tx_timestamp_point_y(pt : DbtxtimestampPoint) -> Double { pt.y }

pub fn db_tx_timestamp_point_z(pt : DbtxtimestampPoint) -> Double { pt.z }

pub fn db_tx_timestamp_point_label(pt : DbtxtimestampPoint) -> Int { pt.label }

pub fn db_tx_timestamp_point_dist(a : DbtxtimestampPoint, b : DbtxtimestampPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_tx_timestamp_point_add(a : DbtxtimestampPoint, b : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_tx_timestamp_point_sub(a : DbtxtimestampPoint, b : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_tx_timestamp_point_scale(pt : DbtxtimestampPoint, s : Double) -> DbtxtimestampPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_tx_timestamp_point_dot(a : DbtxtimestampPoint, b : DbtxtimestampPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_tx_timestamp_point_cross(a : DbtxtimestampPoint, b : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_tx_timestamp_point_norm(pt : DbtxtimestampPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_tx_timestamp_point_normalize(pt : DbtxtimestampPoint) -> DbtxtimestampPoint {
  let n = db_tx_timestamp_point_norm(pt)
  if n < 0.0000001 { pt } else { db_tx_timestamp_point_scale(pt, 1.0 / n) }
}

pub fn db_tx_timestamp_point_negate(pt : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_tx_timestamp_point_mid(a : DbtxtimestampPoint, b : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_tx_timestamp_point_lerp(a : DbtxtimestampPoint, b : DbtxtimestampPoint, t : Double) -> DbtxtimestampPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_tx_timestamp_point_to_string(pt : DbtxtimestampPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbtxtimestampSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_timestamp_make_series(vals : Array[Double], name : String) -> DbtxtimestampSeries {
  { vals, name, meta: 0 }
}

pub fn db_tx_timestamp_series_len(s : DbtxtimestampSeries) -> Int { s.vals.length() }

pub fn db_tx_timestamp_series_sum(s : DbtxtimestampSeries) -> Double { @_common.sum(s.vals) }

pub fn db_tx_timestamp_series_mean(s : DbtxtimestampSeries) -> Double { @_common.mean(s.vals) }

pub fn db_tx_timestamp_series_min(s : DbtxtimestampSeries) -> Double { @_common.min(s.vals) }

pub fn db_tx_timestamp_series_max(s : DbtxtimestampSeries) -> Double { @_common.max(s.vals) }

pub fn db_tx_timestamp_series_range(s : DbtxtimestampSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_tx_timestamp_series_var(s : DbtxtimestampSeries) -> Double { @_common.variance(s.vals) }

pub fn db_tx_timestamp_series_std(s : DbtxtimestampSeries) -> Double { @_common.std(s.vals) }

pub fn db_tx_timestamp_series_median(s : DbtxtimestampSeries) -> Double { @_common.median(s.vals) }

pub fn db_tx_timestamp_series_scale(s : DbtxtimestampSeries, f : Double) -> DbtxtimestampSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_tx_timestamp_series_add(a : DbtxtimestampSeries, b : DbtxtimestampSeries) -> DbtxtimestampSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_tx_timestamp_series_sub(a : DbtxtimestampSeries, b : DbtxtimestampSeries) -> DbtxtimestampSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_tx_timestamp_series_normalize(s : DbtxtimestampSeries) -> DbtxtimestampSeries {
  let mn = db_tx_timestamp_series_min(s)
  let mx = db_tx_timestamp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_tx_timestamp_series_cumsum(s : DbtxtimestampSeries) -> DbtxtimestampSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_tx_timestamp_series_to_string(s : DbtxtimestampSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxtimestampMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_timestamp_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxtimestampMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_timestamp_matrix_identity(n : Int) -> DbtxtimestampMatrix {
  let m = db_tx_timestamp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_tx_timestamp_matrix_get(m : DbtxtimestampMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_tx_timestamp_matrix_transpose(m : DbtxtimestampMatrix) -> DbtxtimestampMatrix {
  let result = db_tx_timestamp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_tx_timestamp_matrix_add(a : DbtxtimestampMatrix, b : DbtxtimestampMatrix) -> DbtxtimestampMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_tx_timestamp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_tx_timestamp_matrix_scale(m : DbtxtimestampMatrix, s : Double) -> DbtxtimestampMatrix {
  let result = db_tx_timestamp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_tx_timestamp_matrix_multiply(a : DbtxtimestampMatrix, b : DbtxtimestampMatrix) -> DbtxtimestampMatrix {
  if a.cols != b.rows { return db_tx_timestamp_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_tx_timestamp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_tx_timestamp_matrix_trace(m : DbtxtimestampMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_tx_timestamp_matrix_det(m : DbtxtimestampMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_tx_timestamp_matrix_norm(m : DbtxtimestampMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_tx_timestamp_matrix_to_string(m : DbtxtimestampMatrix) -> String {
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

pub(all) struct DbtxtimestampVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_timestamp_make_vector(comps : Array[Double]) -> DbtxtimestampVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_timestamp_vector_zero(dim : Int) -> DbtxtimestampVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_tx_timestamp_vector_add(a : DbtxtimestampVector, b : DbtxtimestampVector) -> DbtxtimestampVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_timestamp_vector_sub(a : DbtxtimestampVector, b : DbtxtimestampVector) -> DbtxtimestampVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_timestamp_vector_scale(v : DbtxtimestampVector, s : Double) -> DbtxtimestampVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_tx_timestamp_vector_dot(a : DbtxtimestampVector, b : DbtxtimestampVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_tx_timestamp_vector_norm(v : DbtxtimestampVector) -> Double { @_common.sqrt(db_tx_timestamp_vector_dot(v, v)) }

pub fn db_tx_timestamp_vector_normalize(v : DbtxtimestampVector) -> DbtxtimestampVector {
  let n = db_tx_timestamp_vector_norm(v)
  if n < 0.0000001 { v } else { db_tx_timestamp_vector_scale(v, 1.0 / n) }
}

pub fn db_tx_timestamp_vector_dist(a : DbtxtimestampVector, b : DbtxtimestampVector) -> Double {
  db_tx_timestamp_vector_norm(db_tx_timestamp_vector_sub(a, b))
}

pub fn db_tx_timestamp_vector_to_string(v : DbtxtimestampVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_timestamp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_tx_timestamp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_tx_timestamp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_tx_timestamp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_tx_timestamp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_tx_timestamp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_tx_timestamp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_tx_timestamp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_tx_timestamp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_tx_timestamp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_tx_timestamp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_tx_timestamp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_tx_timestamp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_tx_timestamp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_tx_timestamp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_tx_timestamp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_tx_timestamp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_tx_timestamp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_tx_timestamp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_tx_timestamp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_tx_timestamp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_tx_timestamp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_tx_timestamp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_tx_timestamp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_tx_timestamp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_tx_timestamp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_tx_timestamp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_tx_timestamp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_tx_timestamp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbtxtimestampFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_frame_make(size : Int) -> DbtxtimestampFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_frame_len(s : DbtxtimestampFrame) -> Int { s.size }

pub fn db_tx_timestamp_frame_get(s : DbtxtimestampFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_frame_set(s : DbtxtimestampFrame, i : Int, v : Double) -> DbtxtimestampFrame {
  let result = db_tx_timestamp_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_frame_sum(s : DbtxtimestampFrame) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_frame_mean(s : DbtxtimestampFrame) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_frame_scale(s : DbtxtimestampFrame, f : Double) -> DbtxtimestampFrame {
  let result = db_tx_timestamp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_frame_add(a : DbtxtimestampFrame, b : DbtxtimestampFrame) -> DbtxtimestampFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_frame_copy(s : DbtxtimestampFrame) -> DbtxtimestampFrame {
  let result = db_tx_timestamp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_frame_fill(s : DbtxtimestampFrame, v : Double) -> DbtxtimestampFrame {
  let result = db_tx_timestamp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_frame_min(s : DbtxtimestampFrame) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_frame_max(s : DbtxtimestampFrame) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_frame_to_string(s : DbtxtimestampFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_table_make(size : Int) -> DbtxtimestampTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_table_len(s : DbtxtimestampTable) -> Int { s.size }

pub fn db_tx_timestamp_table_get(s : DbtxtimestampTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_table_set(s : DbtxtimestampTable, i : Int, v : Double) -> DbtxtimestampTable {
  let result = db_tx_timestamp_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_table_sum(s : DbtxtimestampTable) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_table_mean(s : DbtxtimestampTable) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_table_scale(s : DbtxtimestampTable, f : Double) -> DbtxtimestampTable {
  let result = db_tx_timestamp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_table_add(a : DbtxtimestampTable, b : DbtxtimestampTable) -> DbtxtimestampTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_table_copy(s : DbtxtimestampTable) -> DbtxtimestampTable {
  let result = db_tx_timestamp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_table_fill(s : DbtxtimestampTable, v : Double) -> DbtxtimestampTable {
  let result = db_tx_timestamp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_table_min(s : DbtxtimestampTable) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_table_max(s : DbtxtimestampTable) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_table_to_string(s : DbtxtimestampTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_graphn_make(size : Int) -> DbtxtimestampGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_graphn_len(s : DbtxtimestampGraphN) -> Int { s.size }

pub fn db_tx_timestamp_graphn_get(s : DbtxtimestampGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_graphn_set(s : DbtxtimestampGraphN, i : Int, v : Double) -> DbtxtimestampGraphN {
  let result = db_tx_timestamp_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_graphn_sum(s : DbtxtimestampGraphN) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_graphn_mean(s : DbtxtimestampGraphN) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_graphn_scale(s : DbtxtimestampGraphN, f : Double) -> DbtxtimestampGraphN {
  let result = db_tx_timestamp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_graphn_add(a : DbtxtimestampGraphN, b : DbtxtimestampGraphN) -> DbtxtimestampGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_graphn_copy(s : DbtxtimestampGraphN) -> DbtxtimestampGraphN {
  let result = db_tx_timestamp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_graphn_fill(s : DbtxtimestampGraphN, v : Double) -> DbtxtimestampGraphN {
  let result = db_tx_timestamp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_graphn_min(s : DbtxtimestampGraphN) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_graphn_max(s : DbtxtimestampGraphN) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_graphn_to_string(s : DbtxtimestampGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_node_make(size : Int) -> DbtxtimestampNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_node_len(s : DbtxtimestampNode) -> Int { s.size }

pub fn db_tx_timestamp_node_get(s : DbtxtimestampNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_node_set(s : DbtxtimestampNode, i : Int, v : Double) -> DbtxtimestampNode {
  let result = db_tx_timestamp_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_node_sum(s : DbtxtimestampNode) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_node_mean(s : DbtxtimestampNode) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_node_scale(s : DbtxtimestampNode, f : Double) -> DbtxtimestampNode {
  let result = db_tx_timestamp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_node_add(a : DbtxtimestampNode, b : DbtxtimestampNode) -> DbtxtimestampNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_node_copy(s : DbtxtimestampNode) -> DbtxtimestampNode {
  let result = db_tx_timestamp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_node_fill(s : DbtxtimestampNode, v : Double) -> DbtxtimestampNode {
  let result = db_tx_timestamp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_node_min(s : DbtxtimestampNode) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_node_max(s : DbtxtimestampNode) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_node_to_string(s : DbtxtimestampNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_edge_make(size : Int) -> DbtxtimestampEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_edge_len(s : DbtxtimestampEdge) -> Int { s.size }

pub fn db_tx_timestamp_edge_get(s : DbtxtimestampEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_edge_set(s : DbtxtimestampEdge, i : Int, v : Double) -> DbtxtimestampEdge {
  let result = db_tx_timestamp_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_edge_sum(s : DbtxtimestampEdge) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_edge_mean(s : DbtxtimestampEdge) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_edge_scale(s : DbtxtimestampEdge, f : Double) -> DbtxtimestampEdge {
  let result = db_tx_timestamp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_edge_add(a : DbtxtimestampEdge, b : DbtxtimestampEdge) -> DbtxtimestampEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_edge_copy(s : DbtxtimestampEdge) -> DbtxtimestampEdge {
  let result = db_tx_timestamp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_edge_fill(s : DbtxtimestampEdge, v : Double) -> DbtxtimestampEdge {
  let result = db_tx_timestamp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_edge_min(s : DbtxtimestampEdge) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_edge_max(s : DbtxtimestampEdge) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_edge_to_string(s : DbtxtimestampEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_path_make(size : Int) -> DbtxtimestampPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_path_len(s : DbtxtimestampPath) -> Int { s.size }

pub fn db_tx_timestamp_path_get(s : DbtxtimestampPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_path_set(s : DbtxtimestampPath, i : Int, v : Double) -> DbtxtimestampPath {
  let result = db_tx_timestamp_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_path_sum(s : DbtxtimestampPath) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_path_mean(s : DbtxtimestampPath) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_path_scale(s : DbtxtimestampPath, f : Double) -> DbtxtimestampPath {
  let result = db_tx_timestamp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_path_add(a : DbtxtimestampPath, b : DbtxtimestampPath) -> DbtxtimestampPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_path_copy(s : DbtxtimestampPath) -> DbtxtimestampPath {
  let result = db_tx_timestamp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_path_fill(s : DbtxtimestampPath, v : Double) -> DbtxtimestampPath {
  let result = db_tx_timestamp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_path_min(s : DbtxtimestampPath) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_path_max(s : DbtxtimestampPath) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_path_to_string(s : DbtxtimestampPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_cluster_make(size : Int) -> DbtxtimestampCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_cluster_len(s : DbtxtimestampCluster) -> Int { s.size }

pub fn db_tx_timestamp_cluster_get(s : DbtxtimestampCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_cluster_set(s : DbtxtimestampCluster, i : Int, v : Double) -> DbtxtimestampCluster {
  let result = db_tx_timestamp_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_cluster_sum(s : DbtxtimestampCluster) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_cluster_mean(s : DbtxtimestampCluster) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_cluster_scale(s : DbtxtimestampCluster, f : Double) -> DbtxtimestampCluster {
  let result = db_tx_timestamp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_cluster_add(a : DbtxtimestampCluster, b : DbtxtimestampCluster) -> DbtxtimestampCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_cluster_copy(s : DbtxtimestampCluster) -> DbtxtimestampCluster {
  let result = db_tx_timestamp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_cluster_fill(s : DbtxtimestampCluster, v : Double) -> DbtxtimestampCluster {
  let result = db_tx_timestamp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_cluster_min(s : DbtxtimestampCluster) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_cluster_max(s : DbtxtimestampCluster) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_cluster_to_string(s : DbtxtimestampCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_model_make(size : Int) -> DbtxtimestampModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_model_len(s : DbtxtimestampModel) -> Int { s.size }

pub fn db_tx_timestamp_model_get(s : DbtxtimestampModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_model_set(s : DbtxtimestampModel, i : Int, v : Double) -> DbtxtimestampModel {
  let result = db_tx_timestamp_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_model_sum(s : DbtxtimestampModel) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_model_mean(s : DbtxtimestampModel) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_model_scale(s : DbtxtimestampModel, f : Double) -> DbtxtimestampModel {
  let result = db_tx_timestamp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_model_add(a : DbtxtimestampModel, b : DbtxtimestampModel) -> DbtxtimestampModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_model_copy(s : DbtxtimestampModel) -> DbtxtimestampModel {
  let result = db_tx_timestamp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_model_fill(s : DbtxtimestampModel, v : Double) -> DbtxtimestampModel {
  let result = db_tx_timestamp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_model_min(s : DbtxtimestampModel) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_model_max(s : DbtxtimestampModel) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_model_to_string(s : DbtxtimestampModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_layer_make(size : Int) -> DbtxtimestampLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_layer_len(s : DbtxtimestampLayer) -> Int { s.size }

pub fn db_tx_timestamp_layer_get(s : DbtxtimestampLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_layer_set(s : DbtxtimestampLayer, i : Int, v : Double) -> DbtxtimestampLayer {
  let result = db_tx_timestamp_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_layer_sum(s : DbtxtimestampLayer) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_layer_mean(s : DbtxtimestampLayer) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_layer_scale(s : DbtxtimestampLayer, f : Double) -> DbtxtimestampLayer {
  let result = db_tx_timestamp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_layer_add(a : DbtxtimestampLayer, b : DbtxtimestampLayer) -> DbtxtimestampLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_layer_copy(s : DbtxtimestampLayer) -> DbtxtimestampLayer {
  let result = db_tx_timestamp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_layer_fill(s : DbtxtimestampLayer, v : Double) -> DbtxtimestampLayer {
  let result = db_tx_timestamp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_layer_min(s : DbtxtimestampLayer) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_layer_max(s : DbtxtimestampLayer) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_layer_to_string(s : DbtxtimestampLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_buffer_make(size : Int) -> DbtxtimestampBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_buffer_len(s : DbtxtimestampBuffer) -> Int { s.size }

pub fn db_tx_timestamp_buffer_get(s : DbtxtimestampBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_buffer_set(s : DbtxtimestampBuffer, i : Int, v : Double) -> DbtxtimestampBuffer {
  let result = db_tx_timestamp_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_buffer_sum(s : DbtxtimestampBuffer) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_buffer_mean(s : DbtxtimestampBuffer) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_buffer_scale(s : DbtxtimestampBuffer, f : Double) -> DbtxtimestampBuffer {
  let result = db_tx_timestamp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_buffer_add(a : DbtxtimestampBuffer, b : DbtxtimestampBuffer) -> DbtxtimestampBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_buffer_copy(s : DbtxtimestampBuffer) -> DbtxtimestampBuffer {
  let result = db_tx_timestamp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_buffer_fill(s : DbtxtimestampBuffer, v : Double) -> DbtxtimestampBuffer {
  let result = db_tx_timestamp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_buffer_min(s : DbtxtimestampBuffer) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_buffer_max(s : DbtxtimestampBuffer) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_buffer_to_string(s : DbtxtimestampBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_cursor_make(size : Int) -> DbtxtimestampCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_cursor_len(s : DbtxtimestampCursor) -> Int { s.size }

pub fn db_tx_timestamp_cursor_get(s : DbtxtimestampCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_cursor_set(s : DbtxtimestampCursor, i : Int, v : Double) -> DbtxtimestampCursor {
  let result = db_tx_timestamp_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_cursor_sum(s : DbtxtimestampCursor) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_cursor_mean(s : DbtxtimestampCursor) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_cursor_scale(s : DbtxtimestampCursor, f : Double) -> DbtxtimestampCursor {
  let result = db_tx_timestamp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_cursor_add(a : DbtxtimestampCursor, b : DbtxtimestampCursor) -> DbtxtimestampCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_cursor_copy(s : DbtxtimestampCursor) -> DbtxtimestampCursor {
  let result = db_tx_timestamp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_cursor_fill(s : DbtxtimestampCursor, v : Double) -> DbtxtimestampCursor {
  let result = db_tx_timestamp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_cursor_min(s : DbtxtimestampCursor) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_cursor_max(s : DbtxtimestampCursor) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_cursor_to_string(s : DbtxtimestampCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_view_make(size : Int) -> DbtxtimestampView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_view_len(s : DbtxtimestampView) -> Int { s.size }

pub fn db_tx_timestamp_view_get(s : DbtxtimestampView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_view_set(s : DbtxtimestampView, i : Int, v : Double) -> DbtxtimestampView {
  let result = db_tx_timestamp_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_view_sum(s : DbtxtimestampView) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_view_mean(s : DbtxtimestampView) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_view_scale(s : DbtxtimestampView, f : Double) -> DbtxtimestampView {
  let result = db_tx_timestamp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_view_add(a : DbtxtimestampView, b : DbtxtimestampView) -> DbtxtimestampView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_view_copy(s : DbtxtimestampView) -> DbtxtimestampView {
  let result = db_tx_timestamp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_view_fill(s : DbtxtimestampView, v : Double) -> DbtxtimestampView {
  let result = db_tx_timestamp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_view_min(s : DbtxtimestampView) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_view_max(s : DbtxtimestampView) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_view_to_string(s : DbtxtimestampView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_range_make(size : Int) -> DbtxtimestampRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_range_len(s : DbtxtimestampRange) -> Int { s.size }

pub fn db_tx_timestamp_range_get(s : DbtxtimestampRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_range_set(s : DbtxtimestampRange, i : Int, v : Double) -> DbtxtimestampRange {
  let result = db_tx_timestamp_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_range_sum(s : DbtxtimestampRange) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_range_mean(s : DbtxtimestampRange) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_range_scale(s : DbtxtimestampRange, f : Double) -> DbtxtimestampRange {
  let result = db_tx_timestamp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_range_add(a : DbtxtimestampRange, b : DbtxtimestampRange) -> DbtxtimestampRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_range_copy(s : DbtxtimestampRange) -> DbtxtimestampRange {
  let result = db_tx_timestamp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_range_fill(s : DbtxtimestampRange, v : Double) -> DbtxtimestampRange {
  let result = db_tx_timestamp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_range_min(s : DbtxtimestampRange) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_range_max(s : DbtxtimestampRange) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_range_to_string(s : DbtxtimestampRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_slice_make(size : Int) -> DbtxtimestampSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_slice_len(s : DbtxtimestampSlice) -> Int { s.size }

pub fn db_tx_timestamp_slice_get(s : DbtxtimestampSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_slice_set(s : DbtxtimestampSlice, i : Int, v : Double) -> DbtxtimestampSlice {
  let result = db_tx_timestamp_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_slice_sum(s : DbtxtimestampSlice) -> Double { @_common.sum(s.data) }

pub fn db_tx_timestamp_slice_mean(s : DbtxtimestampSlice) -> Double { @_common.mean(s.data) }

pub fn db_tx_timestamp_slice_scale(s : DbtxtimestampSlice, f : Double) -> DbtxtimestampSlice {
  let result = db_tx_timestamp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_slice_add(a : DbtxtimestampSlice, b : DbtxtimestampSlice) -> DbtxtimestampSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_slice_copy(s : DbtxtimestampSlice) -> DbtxtimestampSlice {
  let result = db_tx_timestamp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_slice_fill(s : DbtxtimestampSlice, v : Double) -> DbtxtimestampSlice {
  let result = db_tx_timestamp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_slice_min(s : DbtxtimestampSlice) -> Double { @_common.min(s.data) }

pub fn db_tx_timestamp_slice_max(s : DbtxtimestampSlice) -> Double { @_common.max(s.data) }

pub fn db_tx_timestamp_slice_to_string(s : DbtxtimestampSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

