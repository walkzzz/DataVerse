///===
/// extcore/db_index_lsm

pub(all) struct DbindexlsmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_lsm_make_point(x : Double, y : Double) -> DbindexlsmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_lsm_make_point3(x : Double, y : Double, z : Double) -> DbindexlsmPoint {
  { x, y, z, label: 0 }
}

pub fn db_index_lsm_point_x(pt : DbindexlsmPoint) -> Double { pt.x }

pub fn db_index_lsm_point_y(pt : DbindexlsmPoint) -> Double { pt.y }

pub fn db_index_lsm_point_z(pt : DbindexlsmPoint) -> Double { pt.z }

pub fn db_index_lsm_point_label(pt : DbindexlsmPoint) -> Int { pt.label }

pub fn db_index_lsm_point_dist(a : DbindexlsmPoint, b : DbindexlsmPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_index_lsm_point_add(a : DbindexlsmPoint, b : DbindexlsmPoint) -> DbindexlsmPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_index_lsm_point_sub(a : DbindexlsmPoint, b : DbindexlsmPoint) -> DbindexlsmPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_index_lsm_point_scale(pt : DbindexlsmPoint, s : Double) -> DbindexlsmPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_index_lsm_point_dot(a : DbindexlsmPoint, b : DbindexlsmPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_index_lsm_point_cross(a : DbindexlsmPoint, b : DbindexlsmPoint) -> DbindexlsmPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_index_lsm_point_norm(pt : DbindexlsmPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_index_lsm_point_normalize(pt : DbindexlsmPoint) -> DbindexlsmPoint {
  let n = db_index_lsm_point_norm(pt)
  if n < 0.0000001 { pt } else { db_index_lsm_point_scale(pt, 1.0 / n) }
}

pub fn db_index_lsm_point_negate(pt : DbindexlsmPoint) -> DbindexlsmPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_index_lsm_point_mid(a : DbindexlsmPoint, b : DbindexlsmPoint) -> DbindexlsmPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_index_lsm_point_lerp(a : DbindexlsmPoint, b : DbindexlsmPoint, t : Double) -> DbindexlsmPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_index_lsm_point_to_string(pt : DbindexlsmPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbindexlsmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_lsm_make_series(vals : Array[Double], name : String) -> DbindexlsmSeries {
  { vals, name, meta: 0 }
}

pub fn db_index_lsm_series_len(s : DbindexlsmSeries) -> Int { s.vals.length() }

pub fn db_index_lsm_series_sum(s : DbindexlsmSeries) -> Double { @_common.sum(s.vals) }

pub fn db_index_lsm_series_mean(s : DbindexlsmSeries) -> Double { @_common.mean(s.vals) }

pub fn db_index_lsm_series_min(s : DbindexlsmSeries) -> Double { @_common.min(s.vals) }

pub fn db_index_lsm_series_max(s : DbindexlsmSeries) -> Double { @_common.max(s.vals) }

pub fn db_index_lsm_series_range(s : DbindexlsmSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_index_lsm_series_var(s : DbindexlsmSeries) -> Double { @_common.variance(s.vals) }

pub fn db_index_lsm_series_std(s : DbindexlsmSeries) -> Double { @_common.std(s.vals) }

pub fn db_index_lsm_series_median(s : DbindexlsmSeries) -> Double { @_common.median(s.vals) }

pub fn db_index_lsm_series_scale(s : DbindexlsmSeries, f : Double) -> DbindexlsmSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_index_lsm_series_add(a : DbindexlsmSeries, b : DbindexlsmSeries) -> DbindexlsmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_index_lsm_series_sub(a : DbindexlsmSeries, b : DbindexlsmSeries) -> DbindexlsmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_index_lsm_series_normalize(s : DbindexlsmSeries) -> DbindexlsmSeries {
  let mn = db_index_lsm_series_min(s)
  let mx = db_index_lsm_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_index_lsm_series_cumsum(s : DbindexlsmSeries) -> DbindexlsmSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_index_lsm_series_to_string(s : DbindexlsmSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexlsmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_lsm_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexlsmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_lsm_matrix_identity(n : Int) -> DbindexlsmMatrix {
  let m = db_index_lsm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_index_lsm_matrix_get(m : DbindexlsmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_index_lsm_matrix_transpose(m : DbindexlsmMatrix) -> DbindexlsmMatrix {
  let result = db_index_lsm_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_index_lsm_matrix_add(a : DbindexlsmMatrix, b : DbindexlsmMatrix) -> DbindexlsmMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_index_lsm_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_index_lsm_matrix_scale(m : DbindexlsmMatrix, s : Double) -> DbindexlsmMatrix {
  let result = db_index_lsm_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_index_lsm_matrix_multiply(a : DbindexlsmMatrix, b : DbindexlsmMatrix) -> DbindexlsmMatrix {
  if a.cols != b.rows { return db_index_lsm_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_index_lsm_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_index_lsm_matrix_trace(m : DbindexlsmMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_index_lsm_matrix_det(m : DbindexlsmMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_index_lsm_matrix_norm(m : DbindexlsmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_index_lsm_matrix_to_string(m : DbindexlsmMatrix) -> String {
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

pub(all) struct DbindexlsmVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_lsm_make_vector(comps : Array[Double]) -> DbindexlsmVector {
  { comps, dim: comps.length() }
}

pub fn db_index_lsm_vector_zero(dim : Int) -> DbindexlsmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_index_lsm_vector_add(a : DbindexlsmVector, b : DbindexlsmVector) -> DbindexlsmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_lsm_vector_sub(a : DbindexlsmVector, b : DbindexlsmVector) -> DbindexlsmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_lsm_vector_scale(v : DbindexlsmVector, s : Double) -> DbindexlsmVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_index_lsm_vector_dot(a : DbindexlsmVector, b : DbindexlsmVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_index_lsm_vector_norm(v : DbindexlsmVector) -> Double { @_common.sqrt(db_index_lsm_vector_dot(v, v)) }

pub fn db_index_lsm_vector_normalize(v : DbindexlsmVector) -> DbindexlsmVector {
  let n = db_index_lsm_vector_norm(v)
  if n < 0.0000001 { v } else { db_index_lsm_vector_scale(v, 1.0 / n) }
}

pub fn db_index_lsm_vector_dist(a : DbindexlsmVector, b : DbindexlsmVector) -> Double {
  db_index_lsm_vector_norm(db_index_lsm_vector_sub(a, b))
}

pub fn db_index_lsm_vector_to_string(v : DbindexlsmVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_index_lsm_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_index_lsm_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_index_lsm_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_index_lsm_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_index_lsm_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_index_lsm_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_index_lsm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_index_lsm_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_index_lsm_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_index_lsm_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_index_lsm_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_index_lsm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_index_lsm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_index_lsm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_index_lsm_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_index_lsm_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_index_lsm_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_index_lsm_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_index_lsm_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_index_lsm_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_index_lsm_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_index_lsm_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_index_lsm_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_index_lsm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_index_lsm_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_index_lsm_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_index_lsm_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_index_lsm_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_index_lsm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbindexlsmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_frame_make(size : Int) -> DbindexlsmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_frame_len(s : DbindexlsmFrame) -> Int { s.size }

pub fn db_index_lsm_frame_get(s : DbindexlsmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_frame_set(s : DbindexlsmFrame, i : Int, v : Double) -> DbindexlsmFrame {
  let result = db_index_lsm_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_frame_sum(s : DbindexlsmFrame) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_frame_mean(s : DbindexlsmFrame) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_frame_scale(s : DbindexlsmFrame, f : Double) -> DbindexlsmFrame {
  let result = db_index_lsm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_frame_add(a : DbindexlsmFrame, b : DbindexlsmFrame) -> DbindexlsmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_frame_copy(s : DbindexlsmFrame) -> DbindexlsmFrame {
  let result = db_index_lsm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_frame_fill(s : DbindexlsmFrame, v : Double) -> DbindexlsmFrame {
  let result = db_index_lsm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_frame_min(s : DbindexlsmFrame) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_frame_max(s : DbindexlsmFrame) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_frame_to_string(s : DbindexlsmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_table_make(size : Int) -> DbindexlsmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_table_len(s : DbindexlsmTable) -> Int { s.size }

pub fn db_index_lsm_table_get(s : DbindexlsmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_table_set(s : DbindexlsmTable, i : Int, v : Double) -> DbindexlsmTable {
  let result = db_index_lsm_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_table_sum(s : DbindexlsmTable) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_table_mean(s : DbindexlsmTable) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_table_scale(s : DbindexlsmTable, f : Double) -> DbindexlsmTable {
  let result = db_index_lsm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_table_add(a : DbindexlsmTable, b : DbindexlsmTable) -> DbindexlsmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_table_copy(s : DbindexlsmTable) -> DbindexlsmTable {
  let result = db_index_lsm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_table_fill(s : DbindexlsmTable, v : Double) -> DbindexlsmTable {
  let result = db_index_lsm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_table_min(s : DbindexlsmTable) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_table_max(s : DbindexlsmTable) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_table_to_string(s : DbindexlsmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_graphn_make(size : Int) -> DbindexlsmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_graphn_len(s : DbindexlsmGraphN) -> Int { s.size }

pub fn db_index_lsm_graphn_get(s : DbindexlsmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_graphn_set(s : DbindexlsmGraphN, i : Int, v : Double) -> DbindexlsmGraphN {
  let result = db_index_lsm_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_graphn_sum(s : DbindexlsmGraphN) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_graphn_mean(s : DbindexlsmGraphN) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_graphn_scale(s : DbindexlsmGraphN, f : Double) -> DbindexlsmGraphN {
  let result = db_index_lsm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_graphn_add(a : DbindexlsmGraphN, b : DbindexlsmGraphN) -> DbindexlsmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_graphn_copy(s : DbindexlsmGraphN) -> DbindexlsmGraphN {
  let result = db_index_lsm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_graphn_fill(s : DbindexlsmGraphN, v : Double) -> DbindexlsmGraphN {
  let result = db_index_lsm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_graphn_min(s : DbindexlsmGraphN) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_graphn_max(s : DbindexlsmGraphN) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_graphn_to_string(s : DbindexlsmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_node_make(size : Int) -> DbindexlsmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_node_len(s : DbindexlsmNode) -> Int { s.size }

pub fn db_index_lsm_node_get(s : DbindexlsmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_node_set(s : DbindexlsmNode, i : Int, v : Double) -> DbindexlsmNode {
  let result = db_index_lsm_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_node_sum(s : DbindexlsmNode) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_node_mean(s : DbindexlsmNode) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_node_scale(s : DbindexlsmNode, f : Double) -> DbindexlsmNode {
  let result = db_index_lsm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_node_add(a : DbindexlsmNode, b : DbindexlsmNode) -> DbindexlsmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_node_copy(s : DbindexlsmNode) -> DbindexlsmNode {
  let result = db_index_lsm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_node_fill(s : DbindexlsmNode, v : Double) -> DbindexlsmNode {
  let result = db_index_lsm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_node_min(s : DbindexlsmNode) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_node_max(s : DbindexlsmNode) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_node_to_string(s : DbindexlsmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_edge_make(size : Int) -> DbindexlsmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_edge_len(s : DbindexlsmEdge) -> Int { s.size }

pub fn db_index_lsm_edge_get(s : DbindexlsmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_edge_set(s : DbindexlsmEdge, i : Int, v : Double) -> DbindexlsmEdge {
  let result = db_index_lsm_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_edge_sum(s : DbindexlsmEdge) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_edge_mean(s : DbindexlsmEdge) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_edge_scale(s : DbindexlsmEdge, f : Double) -> DbindexlsmEdge {
  let result = db_index_lsm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_edge_add(a : DbindexlsmEdge, b : DbindexlsmEdge) -> DbindexlsmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_edge_copy(s : DbindexlsmEdge) -> DbindexlsmEdge {
  let result = db_index_lsm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_edge_fill(s : DbindexlsmEdge, v : Double) -> DbindexlsmEdge {
  let result = db_index_lsm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_edge_min(s : DbindexlsmEdge) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_edge_max(s : DbindexlsmEdge) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_edge_to_string(s : DbindexlsmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_path_make(size : Int) -> DbindexlsmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_path_len(s : DbindexlsmPath) -> Int { s.size }

pub fn db_index_lsm_path_get(s : DbindexlsmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_path_set(s : DbindexlsmPath, i : Int, v : Double) -> DbindexlsmPath {
  let result = db_index_lsm_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_path_sum(s : DbindexlsmPath) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_path_mean(s : DbindexlsmPath) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_path_scale(s : DbindexlsmPath, f : Double) -> DbindexlsmPath {
  let result = db_index_lsm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_path_add(a : DbindexlsmPath, b : DbindexlsmPath) -> DbindexlsmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_path_copy(s : DbindexlsmPath) -> DbindexlsmPath {
  let result = db_index_lsm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_path_fill(s : DbindexlsmPath, v : Double) -> DbindexlsmPath {
  let result = db_index_lsm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_path_min(s : DbindexlsmPath) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_path_max(s : DbindexlsmPath) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_path_to_string(s : DbindexlsmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_cluster_make(size : Int) -> DbindexlsmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_cluster_len(s : DbindexlsmCluster) -> Int { s.size }

pub fn db_index_lsm_cluster_get(s : DbindexlsmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_cluster_set(s : DbindexlsmCluster, i : Int, v : Double) -> DbindexlsmCluster {
  let result = db_index_lsm_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_cluster_sum(s : DbindexlsmCluster) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_cluster_mean(s : DbindexlsmCluster) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_cluster_scale(s : DbindexlsmCluster, f : Double) -> DbindexlsmCluster {
  let result = db_index_lsm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_cluster_add(a : DbindexlsmCluster, b : DbindexlsmCluster) -> DbindexlsmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_cluster_copy(s : DbindexlsmCluster) -> DbindexlsmCluster {
  let result = db_index_lsm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_cluster_fill(s : DbindexlsmCluster, v : Double) -> DbindexlsmCluster {
  let result = db_index_lsm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_cluster_min(s : DbindexlsmCluster) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_cluster_max(s : DbindexlsmCluster) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_cluster_to_string(s : DbindexlsmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_model_make(size : Int) -> DbindexlsmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_model_len(s : DbindexlsmModel) -> Int { s.size }

pub fn db_index_lsm_model_get(s : DbindexlsmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_model_set(s : DbindexlsmModel, i : Int, v : Double) -> DbindexlsmModel {
  let result = db_index_lsm_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_model_sum(s : DbindexlsmModel) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_model_mean(s : DbindexlsmModel) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_model_scale(s : DbindexlsmModel, f : Double) -> DbindexlsmModel {
  let result = db_index_lsm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_model_add(a : DbindexlsmModel, b : DbindexlsmModel) -> DbindexlsmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_model_copy(s : DbindexlsmModel) -> DbindexlsmModel {
  let result = db_index_lsm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_model_fill(s : DbindexlsmModel, v : Double) -> DbindexlsmModel {
  let result = db_index_lsm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_model_min(s : DbindexlsmModel) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_model_max(s : DbindexlsmModel) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_model_to_string(s : DbindexlsmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_layer_make(size : Int) -> DbindexlsmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_layer_len(s : DbindexlsmLayer) -> Int { s.size }

pub fn db_index_lsm_layer_get(s : DbindexlsmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_layer_set(s : DbindexlsmLayer, i : Int, v : Double) -> DbindexlsmLayer {
  let result = db_index_lsm_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_layer_sum(s : DbindexlsmLayer) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_layer_mean(s : DbindexlsmLayer) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_layer_scale(s : DbindexlsmLayer, f : Double) -> DbindexlsmLayer {
  let result = db_index_lsm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_layer_add(a : DbindexlsmLayer, b : DbindexlsmLayer) -> DbindexlsmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_layer_copy(s : DbindexlsmLayer) -> DbindexlsmLayer {
  let result = db_index_lsm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_layer_fill(s : DbindexlsmLayer, v : Double) -> DbindexlsmLayer {
  let result = db_index_lsm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_layer_min(s : DbindexlsmLayer) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_layer_max(s : DbindexlsmLayer) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_layer_to_string(s : DbindexlsmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_buffer_make(size : Int) -> DbindexlsmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_buffer_len(s : DbindexlsmBuffer) -> Int { s.size }

pub fn db_index_lsm_buffer_get(s : DbindexlsmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_buffer_set(s : DbindexlsmBuffer, i : Int, v : Double) -> DbindexlsmBuffer {
  let result = db_index_lsm_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_buffer_sum(s : DbindexlsmBuffer) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_buffer_mean(s : DbindexlsmBuffer) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_buffer_scale(s : DbindexlsmBuffer, f : Double) -> DbindexlsmBuffer {
  let result = db_index_lsm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_buffer_add(a : DbindexlsmBuffer, b : DbindexlsmBuffer) -> DbindexlsmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_buffer_copy(s : DbindexlsmBuffer) -> DbindexlsmBuffer {
  let result = db_index_lsm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_buffer_fill(s : DbindexlsmBuffer, v : Double) -> DbindexlsmBuffer {
  let result = db_index_lsm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_buffer_min(s : DbindexlsmBuffer) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_buffer_max(s : DbindexlsmBuffer) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_buffer_to_string(s : DbindexlsmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_cursor_make(size : Int) -> DbindexlsmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_cursor_len(s : DbindexlsmCursor) -> Int { s.size }

pub fn db_index_lsm_cursor_get(s : DbindexlsmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_cursor_set(s : DbindexlsmCursor, i : Int, v : Double) -> DbindexlsmCursor {
  let result = db_index_lsm_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_cursor_sum(s : DbindexlsmCursor) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_cursor_mean(s : DbindexlsmCursor) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_cursor_scale(s : DbindexlsmCursor, f : Double) -> DbindexlsmCursor {
  let result = db_index_lsm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_cursor_add(a : DbindexlsmCursor, b : DbindexlsmCursor) -> DbindexlsmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_cursor_copy(s : DbindexlsmCursor) -> DbindexlsmCursor {
  let result = db_index_lsm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_cursor_fill(s : DbindexlsmCursor, v : Double) -> DbindexlsmCursor {
  let result = db_index_lsm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_cursor_min(s : DbindexlsmCursor) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_cursor_max(s : DbindexlsmCursor) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_cursor_to_string(s : DbindexlsmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_view_make(size : Int) -> DbindexlsmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_view_len(s : DbindexlsmView) -> Int { s.size }

pub fn db_index_lsm_view_get(s : DbindexlsmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_view_set(s : DbindexlsmView, i : Int, v : Double) -> DbindexlsmView {
  let result = db_index_lsm_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_view_sum(s : DbindexlsmView) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_view_mean(s : DbindexlsmView) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_view_scale(s : DbindexlsmView, f : Double) -> DbindexlsmView {
  let result = db_index_lsm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_view_add(a : DbindexlsmView, b : DbindexlsmView) -> DbindexlsmView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_view_copy(s : DbindexlsmView) -> DbindexlsmView {
  let result = db_index_lsm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_view_fill(s : DbindexlsmView, v : Double) -> DbindexlsmView {
  let result = db_index_lsm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_view_min(s : DbindexlsmView) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_view_max(s : DbindexlsmView) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_view_to_string(s : DbindexlsmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_range_make(size : Int) -> DbindexlsmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_range_len(s : DbindexlsmRange) -> Int { s.size }

pub fn db_index_lsm_range_get(s : DbindexlsmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_range_set(s : DbindexlsmRange, i : Int, v : Double) -> DbindexlsmRange {
  let result = db_index_lsm_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_range_sum(s : DbindexlsmRange) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_range_mean(s : DbindexlsmRange) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_range_scale(s : DbindexlsmRange, f : Double) -> DbindexlsmRange {
  let result = db_index_lsm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_range_add(a : DbindexlsmRange, b : DbindexlsmRange) -> DbindexlsmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_range_copy(s : DbindexlsmRange) -> DbindexlsmRange {
  let result = db_index_lsm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_range_fill(s : DbindexlsmRange, v : Double) -> DbindexlsmRange {
  let result = db_index_lsm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_range_min(s : DbindexlsmRange) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_range_max(s : DbindexlsmRange) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_range_to_string(s : DbindexlsmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_slice_make(size : Int) -> DbindexlsmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_slice_len(s : DbindexlsmSlice) -> Int { s.size }

pub fn db_index_lsm_slice_get(s : DbindexlsmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_slice_set(s : DbindexlsmSlice, i : Int, v : Double) -> DbindexlsmSlice {
  let result = db_index_lsm_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_slice_sum(s : DbindexlsmSlice) -> Double { @_common.sum(s.data) }

pub fn db_index_lsm_slice_mean(s : DbindexlsmSlice) -> Double { @_common.mean(s.data) }

pub fn db_index_lsm_slice_scale(s : DbindexlsmSlice, f : Double) -> DbindexlsmSlice {
  let result = db_index_lsm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_slice_add(a : DbindexlsmSlice, b : DbindexlsmSlice) -> DbindexlsmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_slice_copy(s : DbindexlsmSlice) -> DbindexlsmSlice {
  let result = db_index_lsm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_slice_fill(s : DbindexlsmSlice, v : Double) -> DbindexlsmSlice {
  let result = db_index_lsm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_slice_min(s : DbindexlsmSlice) -> Double { @_common.min(s.data) }

pub fn db_index_lsm_slice_max(s : DbindexlsmSlice) -> Double { @_common.max(s.data) }

pub fn db_index_lsm_slice_to_string(s : DbindexlsmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

