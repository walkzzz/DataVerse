///===
/// extcore/db_index_hash

pub(all) struct DbindexhashPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_hash_make_point(x : Double, y : Double) -> DbindexhashPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_hash_make_point3(x : Double, y : Double, z : Double) -> DbindexhashPoint {
  { x, y, z, label: 0 }
}

pub fn db_index_hash_point_x(pt : DbindexhashPoint) -> Double { pt.x }

pub fn db_index_hash_point_y(pt : DbindexhashPoint) -> Double { pt.y }

pub fn db_index_hash_point_z(pt : DbindexhashPoint) -> Double { pt.z }

pub fn db_index_hash_point_label(pt : DbindexhashPoint) -> Int { pt.label }

pub fn db_index_hash_point_dist(a : DbindexhashPoint, b : DbindexhashPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_index_hash_point_add(a : DbindexhashPoint, b : DbindexhashPoint) -> DbindexhashPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_index_hash_point_sub(a : DbindexhashPoint, b : DbindexhashPoint) -> DbindexhashPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_index_hash_point_scale(pt : DbindexhashPoint, s : Double) -> DbindexhashPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_index_hash_point_dot(a : DbindexhashPoint, b : DbindexhashPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_index_hash_point_cross(a : DbindexhashPoint, b : DbindexhashPoint) -> DbindexhashPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_index_hash_point_norm(pt : DbindexhashPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_index_hash_point_normalize(pt : DbindexhashPoint) -> DbindexhashPoint {
  let n = db_index_hash_point_norm(pt)
  if n < 0.0000001 { pt } else { db_index_hash_point_scale(pt, 1.0 / n) }
}

pub fn db_index_hash_point_negate(pt : DbindexhashPoint) -> DbindexhashPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_index_hash_point_mid(a : DbindexhashPoint, b : DbindexhashPoint) -> DbindexhashPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_index_hash_point_lerp(a : DbindexhashPoint, b : DbindexhashPoint, t : Double) -> DbindexhashPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_index_hash_point_to_string(pt : DbindexhashPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbindexhashSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_hash_make_series(vals : Array[Double], name : String) -> DbindexhashSeries {
  { vals, name, meta: 0 }
}

pub fn db_index_hash_series_len(s : DbindexhashSeries) -> Int { s.vals.length() }

pub fn db_index_hash_series_sum(s : DbindexhashSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_index_hash_series_mean(s : DbindexhashSeries) -> Double { @_common.mean(s.vals) }

pub fn db_index_hash_series_min(s : DbindexhashSeries) -> Double { @_common.min(s.vals) }

pub fn db_index_hash_series_max(s : DbindexhashSeries) -> Double { @_common.max(s.vals) }

pub fn db_index_hash_series_range(s : DbindexhashSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_index_hash_series_var(s : DbindexhashSeries) -> Double { @_common.variance(s.vals) }

pub fn db_index_hash_series_std(s : DbindexhashSeries) -> Double { @_common.std(s.vals) }

pub fn db_index_hash_series_median(s : DbindexhashSeries) -> Double { @_common.median(s.vals) }

pub fn db_index_hash_series_scale(s : DbindexhashSeries, f : Double) -> DbindexhashSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_index_hash_series_add(a : DbindexhashSeries, b : DbindexhashSeries) -> DbindexhashSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_index_hash_series_sub(a : DbindexhashSeries, b : DbindexhashSeries) -> DbindexhashSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_index_hash_series_normalize(s : DbindexhashSeries) -> DbindexhashSeries {
  let mn = db_index_hash_series_min(s)
  let mx = db_index_hash_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_index_hash_series_cumsum(s : DbindexhashSeries) -> DbindexhashSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_index_hash_series_to_string(s : DbindexhashSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexhashMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_hash_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexhashMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_hash_matrix_identity(n : Int) -> DbindexhashMatrix {
  let m = db_index_hash_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_index_hash_matrix_get(m : DbindexhashMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_index_hash_matrix_transpose(m : DbindexhashMatrix) -> DbindexhashMatrix {
  let result = db_index_hash_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_index_hash_matrix_add(a : DbindexhashMatrix, b : DbindexhashMatrix) -> DbindexhashMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_index_hash_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_index_hash_matrix_scale(m : DbindexhashMatrix, s : Double) -> DbindexhashMatrix {
  let result = db_index_hash_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_index_hash_matrix_multiply(a : DbindexhashMatrix, b : DbindexhashMatrix) -> DbindexhashMatrix {
  if a.cols != b.rows { return db_index_hash_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_index_hash_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_index_hash_matrix_trace(m : DbindexhashMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_index_hash_matrix_det(m : DbindexhashMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_index_hash_matrix_norm(m : DbindexhashMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_index_hash_matrix_to_string(m : DbindexhashMatrix) -> String {
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

pub(all) struct DbindexhashVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_hash_make_vector(comps : Array[Double]) -> DbindexhashVector {
  { comps, dim: comps.length() }
}

pub fn db_index_hash_vector_zero(dim : Int) -> DbindexhashVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_index_hash_vector_add(a : DbindexhashVector, b : DbindexhashVector) -> DbindexhashVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_hash_vector_sub(a : DbindexhashVector, b : DbindexhashVector) -> DbindexhashVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_hash_vector_scale(v : DbindexhashVector, s : Double) -> DbindexhashVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_index_hash_vector_dot(a : DbindexhashVector, b : DbindexhashVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_index_hash_vector_norm(v : DbindexhashVector) -> Double { @_common.sqrt(db_index_hash_vector_dot(v, v)) }

pub fn db_index_hash_vector_normalize(v : DbindexhashVector) -> DbindexhashVector {
  let n = db_index_hash_vector_norm(v)
  if n < 0.0000001 { v } else { db_index_hash_vector_scale(v, 1.0 / n) }
}

pub fn db_index_hash_vector_dist(a : DbindexhashVector, b : DbindexhashVector) -> Double {
  db_index_hash_vector_norm(db_index_hash_vector_sub(a, b))
}

pub fn db_index_hash_vector_to_string(v : DbindexhashVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_index_hash_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_index_hash_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_index_hash_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_index_hash_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_index_hash_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_index_hash_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_index_hash_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_index_hash_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_index_hash_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_index_hash_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_index_hash_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_index_hash_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_index_hash_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_index_hash_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_index_hash_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_index_hash_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_index_hash_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_index_hash_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_index_hash_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_index_hash_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_index_hash_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_index_hash_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_index_hash_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_index_hash_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_index_hash_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_index_hash_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_index_hash_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_index_hash_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_index_hash_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbindexhashFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_frame_make(size : Int) -> DbindexhashFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_frame_len(s : DbindexhashFrame) -> Int { s.size }

pub fn db_index_hash_frame_get(s : DbindexhashFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_frame_set(s : DbindexhashFrame, i : Int, v : Double) -> DbindexhashFrame {
  let result = db_index_hash_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_frame_sum(s : DbindexhashFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_hash_frame_mean(s : DbindexhashFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_index_hash_frame_sum(s) / s.size.to_double() }
}

pub fn db_index_hash_frame_scale(s : DbindexhashFrame, f : Double) -> DbindexhashFrame {
  let result = db_index_hash_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_hash_frame_add(a : DbindexhashFrame, b : DbindexhashFrame) -> DbindexhashFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_hash_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_hash_frame_copy(s : DbindexhashFrame) -> DbindexhashFrame {
  let result = db_index_hash_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_hash_frame_fill(s : DbindexhashFrame, v : Double) -> DbindexhashFrame {
  let result = db_index_hash_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_frame_min(s : DbindexhashFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_frame_max(s : DbindexhashFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_frame_to_string(s : DbindexhashFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_table_make(size : Int) -> DbindexhashTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_table_len(s : DbindexhashTable) -> Int { s.size }

pub fn db_index_hash_table_get(s : DbindexhashTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_table_set(s : DbindexhashTable, i : Int, v : Double) -> DbindexhashTable {
  let result = db_index_hash_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_table_sum(s : DbindexhashTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_hash_table_mean(s : DbindexhashTable) -> Double {
  if s.size == 0 { 0.0 } else { db_index_hash_table_sum(s) / s.size.to_double() }
}

pub fn db_index_hash_table_scale(s : DbindexhashTable, f : Double) -> DbindexhashTable {
  let result = db_index_hash_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_hash_table_add(a : DbindexhashTable, b : DbindexhashTable) -> DbindexhashTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_hash_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_hash_table_copy(s : DbindexhashTable) -> DbindexhashTable {
  let result = db_index_hash_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_hash_table_fill(s : DbindexhashTable, v : Double) -> DbindexhashTable {
  let result = db_index_hash_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_table_min(s : DbindexhashTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_table_max(s : DbindexhashTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_table_to_string(s : DbindexhashTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_graphn_make(size : Int) -> DbindexhashGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_graphn_len(s : DbindexhashGraphN) -> Int { s.size }

pub fn db_index_hash_graphn_get(s : DbindexhashGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_graphn_set(s : DbindexhashGraphN, i : Int, v : Double) -> DbindexhashGraphN {
  let result = db_index_hash_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_graphn_sum(s : DbindexhashGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_hash_graphn_mean(s : DbindexhashGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_index_hash_graphn_sum(s) / s.size.to_double() }
}

pub fn db_index_hash_graphn_scale(s : DbindexhashGraphN, f : Double) -> DbindexhashGraphN {
  let result = db_index_hash_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_hash_graphn_add(a : DbindexhashGraphN, b : DbindexhashGraphN) -> DbindexhashGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_hash_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_hash_graphn_copy(s : DbindexhashGraphN) -> DbindexhashGraphN {
  let result = db_index_hash_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_hash_graphn_fill(s : DbindexhashGraphN, v : Double) -> DbindexhashGraphN {
  let result = db_index_hash_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_graphn_min(s : DbindexhashGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_graphn_max(s : DbindexhashGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_graphn_to_string(s : DbindexhashGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_node_make(size : Int) -> DbindexhashNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_node_len(s : DbindexhashNode) -> Int { s.size }

pub fn db_index_hash_node_get(s : DbindexhashNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_node_set(s : DbindexhashNode, i : Int, v : Double) -> DbindexhashNode {
  let result = db_index_hash_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_node_sum(s : DbindexhashNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_hash_node_mean(s : DbindexhashNode) -> Double {
  if s.size == 0 { 0.0 } else { db_index_hash_node_sum(s) / s.size.to_double() }
}

pub fn db_index_hash_node_scale(s : DbindexhashNode, f : Double) -> DbindexhashNode {
  let result = db_index_hash_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_hash_node_add(a : DbindexhashNode, b : DbindexhashNode) -> DbindexhashNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_hash_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_hash_node_copy(s : DbindexhashNode) -> DbindexhashNode {
  let result = db_index_hash_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_hash_node_fill(s : DbindexhashNode, v : Double) -> DbindexhashNode {
  let result = db_index_hash_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_node_min(s : DbindexhashNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_node_max(s : DbindexhashNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_node_to_string(s : DbindexhashNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_edge_make(size : Int) -> DbindexhashEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_edge_len(s : DbindexhashEdge) -> Int { s.size }

pub fn db_index_hash_edge_get(s : DbindexhashEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_edge_set(s : DbindexhashEdge, i : Int, v : Double) -> DbindexhashEdge {
  let result = db_index_hash_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_edge_sum(s : DbindexhashEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_hash_edge_mean(s : DbindexhashEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_index_hash_edge_sum(s) / s.size.to_double() }
}

pub fn db_index_hash_edge_scale(s : DbindexhashEdge, f : Double) -> DbindexhashEdge {
  let result = db_index_hash_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_hash_edge_add(a : DbindexhashEdge, b : DbindexhashEdge) -> DbindexhashEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_hash_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_hash_edge_copy(s : DbindexhashEdge) -> DbindexhashEdge {
  let result = db_index_hash_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_hash_edge_fill(s : DbindexhashEdge, v : Double) -> DbindexhashEdge {
  let result = db_index_hash_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_edge_min(s : DbindexhashEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_edge_max(s : DbindexhashEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_edge_to_string(s : DbindexhashEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_path_make(size : Int) -> DbindexhashPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_path_len(s : DbindexhashPath) -> Int { s.size }

pub fn db_index_hash_path_get(s : DbindexhashPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_path_set(s : DbindexhashPath, i : Int, v : Double) -> DbindexhashPath {
  let result = db_index_hash_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_path_sum(s : DbindexhashPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_hash_path_mean(s : DbindexhashPath) -> Double {
  if s.size == 0 { 0.0 } else { db_index_hash_path_sum(s) / s.size.to_double() }
}

pub fn db_index_hash_path_scale(s : DbindexhashPath, f : Double) -> DbindexhashPath {
  let result = db_index_hash_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_hash_path_add(a : DbindexhashPath, b : DbindexhashPath) -> DbindexhashPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_hash_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_hash_path_copy(s : DbindexhashPath) -> DbindexhashPath {
  let result = db_index_hash_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_hash_path_fill(s : DbindexhashPath, v : Double) -> DbindexhashPath {
  let result = db_index_hash_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_path_min(s : DbindexhashPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_path_max(s : DbindexhashPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_path_to_string(s : DbindexhashPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_cluster_make(size : Int) -> DbindexhashCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_cluster_len(s : DbindexhashCluster) -> Int { s.size }

pub fn db_index_hash_cluster_get(s : DbindexhashCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_cluster_set(s : DbindexhashCluster, i : Int, v : Double) -> DbindexhashCluster {
  let result = db_index_hash_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_cluster_sum(s : DbindexhashCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_hash_cluster_mean(s : DbindexhashCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_index_hash_cluster_sum(s) / s.size.to_double() }
}

pub fn db_index_hash_cluster_scale(s : DbindexhashCluster, f : Double) -> DbindexhashCluster {
  let result = db_index_hash_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_hash_cluster_add(a : DbindexhashCluster, b : DbindexhashCluster) -> DbindexhashCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_hash_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_hash_cluster_copy(s : DbindexhashCluster) -> DbindexhashCluster {
  let result = db_index_hash_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_hash_cluster_fill(s : DbindexhashCluster, v : Double) -> DbindexhashCluster {
  let result = db_index_hash_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_cluster_min(s : DbindexhashCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_cluster_max(s : DbindexhashCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_cluster_to_string(s : DbindexhashCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_model_make(size : Int) -> DbindexhashModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_model_len(s : DbindexhashModel) -> Int { s.size }

pub fn db_index_hash_model_get(s : DbindexhashModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_model_set(s : DbindexhashModel, i : Int, v : Double) -> DbindexhashModel {
  let result = db_index_hash_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_model_sum(s : DbindexhashModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_hash_model_mean(s : DbindexhashModel) -> Double {
  if s.size == 0 { 0.0 } else { db_index_hash_model_sum(s) / s.size.to_double() }
}

pub fn db_index_hash_model_scale(s : DbindexhashModel, f : Double) -> DbindexhashModel {
  let result = db_index_hash_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_hash_model_add(a : DbindexhashModel, b : DbindexhashModel) -> DbindexhashModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_hash_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_hash_model_copy(s : DbindexhashModel) -> DbindexhashModel {
  let result = db_index_hash_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_hash_model_fill(s : DbindexhashModel, v : Double) -> DbindexhashModel {
  let result = db_index_hash_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_model_min(s : DbindexhashModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_model_max(s : DbindexhashModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_model_to_string(s : DbindexhashModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_layer_make(size : Int) -> DbindexhashLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_layer_len(s : DbindexhashLayer) -> Int { s.size }

pub fn db_index_hash_layer_get(s : DbindexhashLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_layer_set(s : DbindexhashLayer, i : Int, v : Double) -> DbindexhashLayer {
  let result = db_index_hash_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_layer_sum(s : DbindexhashLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_hash_layer_mean(s : DbindexhashLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_index_hash_layer_sum(s) / s.size.to_double() }
}

pub fn db_index_hash_layer_scale(s : DbindexhashLayer, f : Double) -> DbindexhashLayer {
  let result = db_index_hash_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_hash_layer_add(a : DbindexhashLayer, b : DbindexhashLayer) -> DbindexhashLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_hash_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_hash_layer_copy(s : DbindexhashLayer) -> DbindexhashLayer {
  let result = db_index_hash_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_hash_layer_fill(s : DbindexhashLayer, v : Double) -> DbindexhashLayer {
  let result = db_index_hash_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_layer_min(s : DbindexhashLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_layer_max(s : DbindexhashLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_layer_to_string(s : DbindexhashLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_buffer_make(size : Int) -> DbindexhashBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_buffer_len(s : DbindexhashBuffer) -> Int { s.size }

pub fn db_index_hash_buffer_get(s : DbindexhashBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_buffer_set(s : DbindexhashBuffer, i : Int, v : Double) -> DbindexhashBuffer {
  let result = db_index_hash_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_buffer_sum(s : DbindexhashBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_hash_buffer_mean(s : DbindexhashBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_index_hash_buffer_sum(s) / s.size.to_double() }
}

pub fn db_index_hash_buffer_scale(s : DbindexhashBuffer, f : Double) -> DbindexhashBuffer {
  let result = db_index_hash_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_hash_buffer_add(a : DbindexhashBuffer, b : DbindexhashBuffer) -> DbindexhashBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_hash_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_hash_buffer_copy(s : DbindexhashBuffer) -> DbindexhashBuffer {
  let result = db_index_hash_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_hash_buffer_fill(s : DbindexhashBuffer, v : Double) -> DbindexhashBuffer {
  let result = db_index_hash_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_buffer_min(s : DbindexhashBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_buffer_max(s : DbindexhashBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_buffer_to_string(s : DbindexhashBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_cursor_make(size : Int) -> DbindexhashCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_cursor_len(s : DbindexhashCursor) -> Int { s.size }

pub fn db_index_hash_cursor_get(s : DbindexhashCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_cursor_set(s : DbindexhashCursor, i : Int, v : Double) -> DbindexhashCursor {
  let result = db_index_hash_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_cursor_sum(s : DbindexhashCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_hash_cursor_mean(s : DbindexhashCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_index_hash_cursor_sum(s) / s.size.to_double() }
}

pub fn db_index_hash_cursor_scale(s : DbindexhashCursor, f : Double) -> DbindexhashCursor {
  let result = db_index_hash_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_hash_cursor_add(a : DbindexhashCursor, b : DbindexhashCursor) -> DbindexhashCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_hash_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_hash_cursor_copy(s : DbindexhashCursor) -> DbindexhashCursor {
  let result = db_index_hash_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_hash_cursor_fill(s : DbindexhashCursor, v : Double) -> DbindexhashCursor {
  let result = db_index_hash_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_cursor_min(s : DbindexhashCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_cursor_max(s : DbindexhashCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_cursor_to_string(s : DbindexhashCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_view_make(size : Int) -> DbindexhashView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_view_len(s : DbindexhashView) -> Int { s.size }

pub fn db_index_hash_view_get(s : DbindexhashView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_view_set(s : DbindexhashView, i : Int, v : Double) -> DbindexhashView {
  let result = db_index_hash_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_view_sum(s : DbindexhashView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_hash_view_mean(s : DbindexhashView) -> Double {
  if s.size == 0 { 0.0 } else { db_index_hash_view_sum(s) / s.size.to_double() }
}

pub fn db_index_hash_view_scale(s : DbindexhashView, f : Double) -> DbindexhashView {
  let result = db_index_hash_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_hash_view_add(a : DbindexhashView, b : DbindexhashView) -> DbindexhashView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_hash_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_hash_view_copy(s : DbindexhashView) -> DbindexhashView {
  let result = db_index_hash_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_hash_view_fill(s : DbindexhashView, v : Double) -> DbindexhashView {
  let result = db_index_hash_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_view_min(s : DbindexhashView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_view_max(s : DbindexhashView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_view_to_string(s : DbindexhashView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_range_make(size : Int) -> DbindexhashRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_range_len(s : DbindexhashRange) -> Int { s.size }

pub fn db_index_hash_range_get(s : DbindexhashRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_range_set(s : DbindexhashRange, i : Int, v : Double) -> DbindexhashRange {
  let result = db_index_hash_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_range_sum(s : DbindexhashRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_hash_range_mean(s : DbindexhashRange) -> Double {
  if s.size == 0 { 0.0 } else { db_index_hash_range_sum(s) / s.size.to_double() }
}

pub fn db_index_hash_range_scale(s : DbindexhashRange, f : Double) -> DbindexhashRange {
  let result = db_index_hash_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_hash_range_add(a : DbindexhashRange, b : DbindexhashRange) -> DbindexhashRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_hash_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_hash_range_copy(s : DbindexhashRange) -> DbindexhashRange {
  let result = db_index_hash_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_hash_range_fill(s : DbindexhashRange, v : Double) -> DbindexhashRange {
  let result = db_index_hash_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_range_min(s : DbindexhashRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_range_max(s : DbindexhashRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_range_to_string(s : DbindexhashRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexhashSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_hash_slice_make(size : Int) -> DbindexhashSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_hash_slice_len(s : DbindexhashSlice) -> Int { s.size }

pub fn db_index_hash_slice_get(s : DbindexhashSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_hash_slice_set(s : DbindexhashSlice, i : Int, v : Double) -> DbindexhashSlice {
  let result = db_index_hash_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_slice_sum(s : DbindexhashSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_hash_slice_mean(s : DbindexhashSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_index_hash_slice_sum(s) / s.size.to_double() }
}

pub fn db_index_hash_slice_scale(s : DbindexhashSlice, f : Double) -> DbindexhashSlice {
  let result = db_index_hash_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_hash_slice_add(a : DbindexhashSlice, b : DbindexhashSlice) -> DbindexhashSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_hash_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_hash_slice_copy(s : DbindexhashSlice) -> DbindexhashSlice {
  let result = db_index_hash_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_hash_slice_fill(s : DbindexhashSlice, v : Double) -> DbindexhashSlice {
  let result = db_index_hash_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_hash_slice_min(s : DbindexhashSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_slice_max(s : DbindexhashSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_hash_slice_to_string(s : DbindexhashSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

