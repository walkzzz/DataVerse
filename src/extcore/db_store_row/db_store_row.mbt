///===
/// extcore/db_store_row

pub(all) struct DbstorerowPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_row_make_point(x : Double, y : Double) -> DbstorerowPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_row_make_point3(x : Double, y : Double, z : Double) -> DbstorerowPoint {
  { x, y, z, label: 0 }
}

pub fn db_store_row_point_x(pt : DbstorerowPoint) -> Double { pt.x }

pub fn db_store_row_point_y(pt : DbstorerowPoint) -> Double { pt.y }

pub fn db_store_row_point_z(pt : DbstorerowPoint) -> Double { pt.z }

pub fn db_store_row_point_label(pt : DbstorerowPoint) -> Int { pt.label }

pub fn db_store_row_point_dist(a : DbstorerowPoint, b : DbstorerowPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_store_row_point_add(a : DbstorerowPoint, b : DbstorerowPoint) -> DbstorerowPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_store_row_point_sub(a : DbstorerowPoint, b : DbstorerowPoint) -> DbstorerowPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_store_row_point_scale(pt : DbstorerowPoint, s : Double) -> DbstorerowPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_store_row_point_dot(a : DbstorerowPoint, b : DbstorerowPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_store_row_point_cross(a : DbstorerowPoint, b : DbstorerowPoint) -> DbstorerowPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_store_row_point_norm(pt : DbstorerowPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_store_row_point_normalize(pt : DbstorerowPoint) -> DbstorerowPoint {
  let n = db_store_row_point_norm(pt)
  if n < 0.0000001 { pt } else { db_store_row_point_scale(pt, 1.0 / n) }
}

pub fn db_store_row_point_negate(pt : DbstorerowPoint) -> DbstorerowPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_store_row_point_mid(a : DbstorerowPoint, b : DbstorerowPoint) -> DbstorerowPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_store_row_point_lerp(a : DbstorerowPoint, b : DbstorerowPoint, t : Double) -> DbstorerowPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_store_row_point_to_string(pt : DbstorerowPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbstorerowSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_row_make_series(vals : Array[Double], name : String) -> DbstorerowSeries {
  { vals, name, meta: 0 }
}

pub fn db_store_row_series_len(s : DbstorerowSeries) -> Int { s.vals.length() }

pub fn db_store_row_series_sum(s : DbstorerowSeries) -> Double { @_common.sum(s.vals) }

pub fn db_store_row_series_mean(s : DbstorerowSeries) -> Double { @_common.mean(s.vals) }

pub fn db_store_row_series_min(s : DbstorerowSeries) -> Double { @_common.min(s.vals) }

pub fn db_store_row_series_max(s : DbstorerowSeries) -> Double { @_common.max(s.vals) }

pub fn db_store_row_series_range(s : DbstorerowSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_store_row_series_var(s : DbstorerowSeries) -> Double { @_common.variance(s.vals) }

pub fn db_store_row_series_std(s : DbstorerowSeries) -> Double { @_common.std(s.vals) }

pub fn db_store_row_series_median(s : DbstorerowSeries) -> Double { @_common.median(s.vals) }

pub fn db_store_row_series_scale(s : DbstorerowSeries, f : Double) -> DbstorerowSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_store_row_series_add(a : DbstorerowSeries, b : DbstorerowSeries) -> DbstorerowSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_store_row_series_sub(a : DbstorerowSeries, b : DbstorerowSeries) -> DbstorerowSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_store_row_series_normalize(s : DbstorerowSeries) -> DbstorerowSeries {
  let mn = db_store_row_series_min(s)
  let mx = db_store_row_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_store_row_series_cumsum(s : DbstorerowSeries) -> DbstorerowSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_store_row_series_to_string(s : DbstorerowSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstorerowMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_row_make_matrix(rows : Int, cols : Int, val : Double) -> DbstorerowMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_row_matrix_identity(n : Int) -> DbstorerowMatrix {
  let m = db_store_row_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_store_row_matrix_get(m : DbstorerowMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_store_row_matrix_transpose(m : DbstorerowMatrix) -> DbstorerowMatrix {
  let result = db_store_row_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_store_row_matrix_add(a : DbstorerowMatrix, b : DbstorerowMatrix) -> DbstorerowMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_store_row_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_store_row_matrix_scale(m : DbstorerowMatrix, s : Double) -> DbstorerowMatrix {
  let result = db_store_row_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_store_row_matrix_multiply(a : DbstorerowMatrix, b : DbstorerowMatrix) -> DbstorerowMatrix {
  if a.cols != b.rows { return db_store_row_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_store_row_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_store_row_matrix_trace(m : DbstorerowMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_store_row_matrix_det(m : DbstorerowMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_store_row_matrix_norm(m : DbstorerowMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_store_row_matrix_to_string(m : DbstorerowMatrix) -> String {
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

pub(all) struct DbstorerowVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_row_make_vector(comps : Array[Double]) -> DbstorerowVector {
  { comps, dim: comps.length() }
}

pub fn db_store_row_vector_zero(dim : Int) -> DbstorerowVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_store_row_vector_add(a : DbstorerowVector, b : DbstorerowVector) -> DbstorerowVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_row_vector_sub(a : DbstorerowVector, b : DbstorerowVector) -> DbstorerowVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_row_vector_scale(v : DbstorerowVector, s : Double) -> DbstorerowVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_store_row_vector_dot(a : DbstorerowVector, b : DbstorerowVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_store_row_vector_norm(v : DbstorerowVector) -> Double { @_common.sqrt(db_store_row_vector_dot(v, v)) }

pub fn db_store_row_vector_normalize(v : DbstorerowVector) -> DbstorerowVector {
  let n = db_store_row_vector_norm(v)
  if n < 0.0000001 { v } else { db_store_row_vector_scale(v, 1.0 / n) }
}

pub fn db_store_row_vector_dist(a : DbstorerowVector, b : DbstorerowVector) -> Double {
  db_store_row_vector_norm(db_store_row_vector_sub(a, b))
}

pub fn db_store_row_vector_to_string(v : DbstorerowVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_row_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_row_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_row_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_row_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_row_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_row_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_row_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_row_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_row_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_row_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_row_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_row_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_row_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_row_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_row_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_row_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_row_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_row_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_row_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_row_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_row_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_row_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_row_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_row_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_row_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_row_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_row_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_row_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_row_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstorerowFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_frame_make(size : Int) -> DbstorerowFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_frame_len(s : DbstorerowFrame) -> Int { s.size }

pub fn db_store_row_frame_get(s : DbstorerowFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_frame_set(s : DbstorerowFrame, i : Int, v : Double) -> DbstorerowFrame {
  let result = db_store_row_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_row_frame_sum(s : DbstorerowFrame) -> Double { @_common.sum(s.data) }

pub fn db_store_row_frame_mean(s : DbstorerowFrame) -> Double { @_common.mean(s.data) }

pub fn db_store_row_frame_scale(s : DbstorerowFrame, f : Double) -> DbstorerowFrame {
  let result = db_store_row_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_row_frame_add(a : DbstorerowFrame, b : DbstorerowFrame) -> DbstorerowFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_row_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_row_frame_copy(s : DbstorerowFrame) -> DbstorerowFrame {
  let result = db_store_row_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_row_frame_fill(s : DbstorerowFrame, v : Double) -> DbstorerowFrame {
  let result = db_store_row_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_row_frame_min(s : DbstorerowFrame) -> Double { @_common.min(s.data) }

pub fn db_store_row_frame_max(s : DbstorerowFrame) -> Double { @_common.max(s.data) }

pub fn db_store_row_frame_to_string(s : DbstorerowFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_table_make(size : Int) -> DbstorerowTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_table_len(s : DbstorerowTable) -> Int { s.size }

pub fn db_store_row_table_get(s : DbstorerowTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_table_set(s : DbstorerowTable, i : Int, v : Double) -> DbstorerowTable {
  let result = db_store_row_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_row_table_sum(s : DbstorerowTable) -> Double { @_common.sum(s.data) }

pub fn db_store_row_table_mean(s : DbstorerowTable) -> Double { @_common.mean(s.data) }

pub fn db_store_row_table_scale(s : DbstorerowTable, f : Double) -> DbstorerowTable {
  let result = db_store_row_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_row_table_add(a : DbstorerowTable, b : DbstorerowTable) -> DbstorerowTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_row_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_row_table_copy(s : DbstorerowTable) -> DbstorerowTable {
  let result = db_store_row_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_row_table_fill(s : DbstorerowTable, v : Double) -> DbstorerowTable {
  let result = db_store_row_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_row_table_min(s : DbstorerowTable) -> Double { @_common.min(s.data) }

pub fn db_store_row_table_max(s : DbstorerowTable) -> Double { @_common.max(s.data) }

pub fn db_store_row_table_to_string(s : DbstorerowTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_graphn_make(size : Int) -> DbstorerowGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_graphn_len(s : DbstorerowGraphN) -> Int { s.size }

pub fn db_store_row_graphn_get(s : DbstorerowGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_graphn_set(s : DbstorerowGraphN, i : Int, v : Double) -> DbstorerowGraphN {
  let result = db_store_row_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_row_graphn_sum(s : DbstorerowGraphN) -> Double { @_common.sum(s.data) }

pub fn db_store_row_graphn_mean(s : DbstorerowGraphN) -> Double { @_common.mean(s.data) }

pub fn db_store_row_graphn_scale(s : DbstorerowGraphN, f : Double) -> DbstorerowGraphN {
  let result = db_store_row_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_row_graphn_add(a : DbstorerowGraphN, b : DbstorerowGraphN) -> DbstorerowGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_row_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_row_graphn_copy(s : DbstorerowGraphN) -> DbstorerowGraphN {
  let result = db_store_row_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_row_graphn_fill(s : DbstorerowGraphN, v : Double) -> DbstorerowGraphN {
  let result = db_store_row_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_row_graphn_min(s : DbstorerowGraphN) -> Double { @_common.min(s.data) }

pub fn db_store_row_graphn_max(s : DbstorerowGraphN) -> Double { @_common.max(s.data) }

pub fn db_store_row_graphn_to_string(s : DbstorerowGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_node_make(size : Int) -> DbstorerowNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_node_len(s : DbstorerowNode) -> Int { s.size }

pub fn db_store_row_node_get(s : DbstorerowNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_node_set(s : DbstorerowNode, i : Int, v : Double) -> DbstorerowNode {
  let result = db_store_row_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_row_node_sum(s : DbstorerowNode) -> Double { @_common.sum(s.data) }

pub fn db_store_row_node_mean(s : DbstorerowNode) -> Double { @_common.mean(s.data) }

pub fn db_store_row_node_scale(s : DbstorerowNode, f : Double) -> DbstorerowNode {
  let result = db_store_row_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_row_node_add(a : DbstorerowNode, b : DbstorerowNode) -> DbstorerowNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_row_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_row_node_copy(s : DbstorerowNode) -> DbstorerowNode {
  let result = db_store_row_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_row_node_fill(s : DbstorerowNode, v : Double) -> DbstorerowNode {
  let result = db_store_row_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_row_node_min(s : DbstorerowNode) -> Double { @_common.min(s.data) }

pub fn db_store_row_node_max(s : DbstorerowNode) -> Double { @_common.max(s.data) }

pub fn db_store_row_node_to_string(s : DbstorerowNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_edge_make(size : Int) -> DbstorerowEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_edge_len(s : DbstorerowEdge) -> Int { s.size }

pub fn db_store_row_edge_get(s : DbstorerowEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_edge_set(s : DbstorerowEdge, i : Int, v : Double) -> DbstorerowEdge {
  let result = db_store_row_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_row_edge_sum(s : DbstorerowEdge) -> Double { @_common.sum(s.data) }

pub fn db_store_row_edge_mean(s : DbstorerowEdge) -> Double { @_common.mean(s.data) }

pub fn db_store_row_edge_scale(s : DbstorerowEdge, f : Double) -> DbstorerowEdge {
  let result = db_store_row_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_row_edge_add(a : DbstorerowEdge, b : DbstorerowEdge) -> DbstorerowEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_row_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_row_edge_copy(s : DbstorerowEdge) -> DbstorerowEdge {
  let result = db_store_row_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_row_edge_fill(s : DbstorerowEdge, v : Double) -> DbstorerowEdge {
  let result = db_store_row_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_row_edge_min(s : DbstorerowEdge) -> Double { @_common.min(s.data) }

pub fn db_store_row_edge_max(s : DbstorerowEdge) -> Double { @_common.max(s.data) }

pub fn db_store_row_edge_to_string(s : DbstorerowEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_path_make(size : Int) -> DbstorerowPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_path_len(s : DbstorerowPath) -> Int { s.size }

pub fn db_store_row_path_get(s : DbstorerowPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_path_set(s : DbstorerowPath, i : Int, v : Double) -> DbstorerowPath {
  let result = db_store_row_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_row_path_sum(s : DbstorerowPath) -> Double { @_common.sum(s.data) }

pub fn db_store_row_path_mean(s : DbstorerowPath) -> Double { @_common.mean(s.data) }

pub fn db_store_row_path_scale(s : DbstorerowPath, f : Double) -> DbstorerowPath {
  let result = db_store_row_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_row_path_add(a : DbstorerowPath, b : DbstorerowPath) -> DbstorerowPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_row_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_row_path_copy(s : DbstorerowPath) -> DbstorerowPath {
  let result = db_store_row_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_row_path_fill(s : DbstorerowPath, v : Double) -> DbstorerowPath {
  let result = db_store_row_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_row_path_min(s : DbstorerowPath) -> Double { @_common.min(s.data) }

pub fn db_store_row_path_max(s : DbstorerowPath) -> Double { @_common.max(s.data) }

pub fn db_store_row_path_to_string(s : DbstorerowPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_cluster_make(size : Int) -> DbstorerowCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_cluster_len(s : DbstorerowCluster) -> Int { s.size }

pub fn db_store_row_cluster_get(s : DbstorerowCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_cluster_set(s : DbstorerowCluster, i : Int, v : Double) -> DbstorerowCluster {
  let result = db_store_row_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_row_cluster_sum(s : DbstorerowCluster) -> Double { @_common.sum(s.data) }

pub fn db_store_row_cluster_mean(s : DbstorerowCluster) -> Double { @_common.mean(s.data) }

pub fn db_store_row_cluster_scale(s : DbstorerowCluster, f : Double) -> DbstorerowCluster {
  let result = db_store_row_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_row_cluster_add(a : DbstorerowCluster, b : DbstorerowCluster) -> DbstorerowCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_row_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_row_cluster_copy(s : DbstorerowCluster) -> DbstorerowCluster {
  let result = db_store_row_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_row_cluster_fill(s : DbstorerowCluster, v : Double) -> DbstorerowCluster {
  let result = db_store_row_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_row_cluster_min(s : DbstorerowCluster) -> Double { @_common.min(s.data) }

pub fn db_store_row_cluster_max(s : DbstorerowCluster) -> Double { @_common.max(s.data) }

pub fn db_store_row_cluster_to_string(s : DbstorerowCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_model_make(size : Int) -> DbstorerowModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_model_len(s : DbstorerowModel) -> Int { s.size }

pub fn db_store_row_model_get(s : DbstorerowModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_model_set(s : DbstorerowModel, i : Int, v : Double) -> DbstorerowModel {
  let result = db_store_row_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_row_model_sum(s : DbstorerowModel) -> Double { @_common.sum(s.data) }

pub fn db_store_row_model_mean(s : DbstorerowModel) -> Double { @_common.mean(s.data) }

pub fn db_store_row_model_scale(s : DbstorerowModel, f : Double) -> DbstorerowModel {
  let result = db_store_row_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_row_model_add(a : DbstorerowModel, b : DbstorerowModel) -> DbstorerowModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_row_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_row_model_copy(s : DbstorerowModel) -> DbstorerowModel {
  let result = db_store_row_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_row_model_fill(s : DbstorerowModel, v : Double) -> DbstorerowModel {
  let result = db_store_row_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_row_model_min(s : DbstorerowModel) -> Double { @_common.min(s.data) }

pub fn db_store_row_model_max(s : DbstorerowModel) -> Double { @_common.max(s.data) }

pub fn db_store_row_model_to_string(s : DbstorerowModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_layer_make(size : Int) -> DbstorerowLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_layer_len(s : DbstorerowLayer) -> Int { s.size }

pub fn db_store_row_layer_get(s : DbstorerowLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_layer_set(s : DbstorerowLayer, i : Int, v : Double) -> DbstorerowLayer {
  let result = db_store_row_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_row_layer_sum(s : DbstorerowLayer) -> Double { @_common.sum(s.data) }

pub fn db_store_row_layer_mean(s : DbstorerowLayer) -> Double { @_common.mean(s.data) }

pub fn db_store_row_layer_scale(s : DbstorerowLayer, f : Double) -> DbstorerowLayer {
  let result = db_store_row_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_row_layer_add(a : DbstorerowLayer, b : DbstorerowLayer) -> DbstorerowLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_row_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_row_layer_copy(s : DbstorerowLayer) -> DbstorerowLayer {
  let result = db_store_row_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_row_layer_fill(s : DbstorerowLayer, v : Double) -> DbstorerowLayer {
  let result = db_store_row_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_row_layer_min(s : DbstorerowLayer) -> Double { @_common.min(s.data) }

pub fn db_store_row_layer_max(s : DbstorerowLayer) -> Double { @_common.max(s.data) }

pub fn db_store_row_layer_to_string(s : DbstorerowLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_buffer_make(size : Int) -> DbstorerowBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_buffer_len(s : DbstorerowBuffer) -> Int { s.size }

pub fn db_store_row_buffer_get(s : DbstorerowBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_buffer_set(s : DbstorerowBuffer, i : Int, v : Double) -> DbstorerowBuffer {
  let result = db_store_row_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_row_buffer_sum(s : DbstorerowBuffer) -> Double { @_common.sum(s.data) }

pub fn db_store_row_buffer_mean(s : DbstorerowBuffer) -> Double { @_common.mean(s.data) }

pub fn db_store_row_buffer_scale(s : DbstorerowBuffer, f : Double) -> DbstorerowBuffer {
  let result = db_store_row_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_row_buffer_add(a : DbstorerowBuffer, b : DbstorerowBuffer) -> DbstorerowBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_row_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_row_buffer_copy(s : DbstorerowBuffer) -> DbstorerowBuffer {
  let result = db_store_row_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_row_buffer_fill(s : DbstorerowBuffer, v : Double) -> DbstorerowBuffer {
  let result = db_store_row_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_row_buffer_min(s : DbstorerowBuffer) -> Double { @_common.min(s.data) }

pub fn db_store_row_buffer_max(s : DbstorerowBuffer) -> Double { @_common.max(s.data) }

pub fn db_store_row_buffer_to_string(s : DbstorerowBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_cursor_make(size : Int) -> DbstorerowCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_cursor_len(s : DbstorerowCursor) -> Int { s.size }

pub fn db_store_row_cursor_get(s : DbstorerowCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_cursor_set(s : DbstorerowCursor, i : Int, v : Double) -> DbstorerowCursor {
  let result = db_store_row_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_row_cursor_sum(s : DbstorerowCursor) -> Double { @_common.sum(s.data) }

pub fn db_store_row_cursor_mean(s : DbstorerowCursor) -> Double { @_common.mean(s.data) }

pub fn db_store_row_cursor_scale(s : DbstorerowCursor, f : Double) -> DbstorerowCursor {
  let result = db_store_row_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_row_cursor_add(a : DbstorerowCursor, b : DbstorerowCursor) -> DbstorerowCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_row_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_row_cursor_copy(s : DbstorerowCursor) -> DbstorerowCursor {
  let result = db_store_row_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_row_cursor_fill(s : DbstorerowCursor, v : Double) -> DbstorerowCursor {
  let result = db_store_row_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_row_cursor_min(s : DbstorerowCursor) -> Double { @_common.min(s.data) }

pub fn db_store_row_cursor_max(s : DbstorerowCursor) -> Double { @_common.max(s.data) }

pub fn db_store_row_cursor_to_string(s : DbstorerowCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_view_make(size : Int) -> DbstorerowView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_view_len(s : DbstorerowView) -> Int { s.size }

pub fn db_store_row_view_get(s : DbstorerowView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_view_set(s : DbstorerowView, i : Int, v : Double) -> DbstorerowView {
  let result = db_store_row_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_row_view_sum(s : DbstorerowView) -> Double { @_common.sum(s.data) }

pub fn db_store_row_view_mean(s : DbstorerowView) -> Double { @_common.mean(s.data) }

pub fn db_store_row_view_scale(s : DbstorerowView, f : Double) -> DbstorerowView {
  let result = db_store_row_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_row_view_add(a : DbstorerowView, b : DbstorerowView) -> DbstorerowView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_row_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_row_view_copy(s : DbstorerowView) -> DbstorerowView {
  let result = db_store_row_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_row_view_fill(s : DbstorerowView, v : Double) -> DbstorerowView {
  let result = db_store_row_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_row_view_min(s : DbstorerowView) -> Double { @_common.min(s.data) }

pub fn db_store_row_view_max(s : DbstorerowView) -> Double { @_common.max(s.data) }

pub fn db_store_row_view_to_string(s : DbstorerowView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_range_make(size : Int) -> DbstorerowRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_range_len(s : DbstorerowRange) -> Int { s.size }

pub fn db_store_row_range_get(s : DbstorerowRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_range_set(s : DbstorerowRange, i : Int, v : Double) -> DbstorerowRange {
  let result = db_store_row_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_row_range_sum(s : DbstorerowRange) -> Double { @_common.sum(s.data) }

pub fn db_store_row_range_mean(s : DbstorerowRange) -> Double { @_common.mean(s.data) }

pub fn db_store_row_range_scale(s : DbstorerowRange, f : Double) -> DbstorerowRange {
  let result = db_store_row_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_row_range_add(a : DbstorerowRange, b : DbstorerowRange) -> DbstorerowRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_row_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_row_range_copy(s : DbstorerowRange) -> DbstorerowRange {
  let result = db_store_row_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_row_range_fill(s : DbstorerowRange, v : Double) -> DbstorerowRange {
  let result = db_store_row_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_row_range_min(s : DbstorerowRange) -> Double { @_common.min(s.data) }

pub fn db_store_row_range_max(s : DbstorerowRange) -> Double { @_common.max(s.data) }

pub fn db_store_row_range_to_string(s : DbstorerowRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorerowSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_slice_make(size : Int) -> DbstorerowSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_row_slice_len(s : DbstorerowSlice) -> Int { s.size }

pub fn db_store_row_slice_get(s : DbstorerowSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_row_slice_set(s : DbstorerowSlice, i : Int, v : Double) -> DbstorerowSlice {
  let result = db_store_row_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_row_slice_sum(s : DbstorerowSlice) -> Double { @_common.sum(s.data) }

pub fn db_store_row_slice_mean(s : DbstorerowSlice) -> Double { @_common.mean(s.data) }

pub fn db_store_row_slice_scale(s : DbstorerowSlice, f : Double) -> DbstorerowSlice {
  let result = db_store_row_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_row_slice_add(a : DbstorerowSlice, b : DbstorerowSlice) -> DbstorerowSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_row_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_row_slice_copy(s : DbstorerowSlice) -> DbstorerowSlice {
  let result = db_store_row_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_row_slice_fill(s : DbstorerowSlice, v : Double) -> DbstorerowSlice {
  let result = db_store_row_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_row_slice_min(s : DbstorerowSlice) -> Double { @_common.min(s.data) }

pub fn db_store_row_slice_max(s : DbstorerowSlice) -> Double { @_common.max(s.data) }

pub fn db_store_row_slice_to_string(s : DbstorerowSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

