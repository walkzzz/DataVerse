///===
/// extcore/db_store_time

pub(all) struct DbstoretimePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_time_make_point(x : Double, y : Double) -> DbstoretimePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_time_make_point3(x : Double, y : Double, z : Double) -> DbstoretimePoint {
  { x, y, z, label: 0 }
}

pub fn db_store_time_point_x(pt : DbstoretimePoint) -> Double { pt.x }

pub fn db_store_time_point_y(pt : DbstoretimePoint) -> Double { pt.y }

pub fn db_store_time_point_z(pt : DbstoretimePoint) -> Double { pt.z }

pub fn db_store_time_point_label(pt : DbstoretimePoint) -> Int { pt.label }

pub fn db_store_time_point_dist(a : DbstoretimePoint, b : DbstoretimePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_store_time_point_add(a : DbstoretimePoint, b : DbstoretimePoint) -> DbstoretimePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_store_time_point_sub(a : DbstoretimePoint, b : DbstoretimePoint) -> DbstoretimePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_store_time_point_scale(pt : DbstoretimePoint, s : Double) -> DbstoretimePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_store_time_point_dot(a : DbstoretimePoint, b : DbstoretimePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_store_time_point_cross(a : DbstoretimePoint, b : DbstoretimePoint) -> DbstoretimePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_store_time_point_norm(pt : DbstoretimePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_store_time_point_normalize(pt : DbstoretimePoint) -> DbstoretimePoint {
  let n = db_store_time_point_norm(pt)
  if n < 0.0000001 { pt } else { db_store_time_point_scale(pt, 1.0 / n) }
}

pub fn db_store_time_point_negate(pt : DbstoretimePoint) -> DbstoretimePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_store_time_point_mid(a : DbstoretimePoint, b : DbstoretimePoint) -> DbstoretimePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_store_time_point_lerp(a : DbstoretimePoint, b : DbstoretimePoint, t : Double) -> DbstoretimePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_store_time_point_to_string(pt : DbstoretimePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbstoretimeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_time_make_series(vals : Array[Double], name : String) -> DbstoretimeSeries {
  { vals, name, meta: 0 }
}

pub fn db_store_time_series_len(s : DbstoretimeSeries) -> Int { s.vals.length() }

pub fn db_store_time_series_sum(s : DbstoretimeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_store_time_series_mean(s : DbstoretimeSeries) -> Double { @_common.mean(s.vals) }

pub fn db_store_time_series_min(s : DbstoretimeSeries) -> Double { @_common.min(s.vals) }

pub fn db_store_time_series_max(s : DbstoretimeSeries) -> Double { @_common.max(s.vals) }

pub fn db_store_time_series_range(s : DbstoretimeSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_store_time_series_var(s : DbstoretimeSeries) -> Double { @_common.variance(s.vals) }

pub fn db_store_time_series_std(s : DbstoretimeSeries) -> Double { @_common.std(s.vals) }

pub fn db_store_time_series_median(s : DbstoretimeSeries) -> Double { @_common.median(s.vals) }

pub fn db_store_time_series_scale(s : DbstoretimeSeries, f : Double) -> DbstoretimeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_store_time_series_add(a : DbstoretimeSeries, b : DbstoretimeSeries) -> DbstoretimeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_store_time_series_sub(a : DbstoretimeSeries, b : DbstoretimeSeries) -> DbstoretimeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_store_time_series_normalize(s : DbstoretimeSeries) -> DbstoretimeSeries {
  let mn = db_store_time_series_min(s)
  let mx = db_store_time_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_store_time_series_cumsum(s : DbstoretimeSeries) -> DbstoretimeSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_store_time_series_to_string(s : DbstoretimeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstoretimeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_time_make_matrix(rows : Int, cols : Int, val : Double) -> DbstoretimeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_time_matrix_identity(n : Int) -> DbstoretimeMatrix {
  let m = db_store_time_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_store_time_matrix_get(m : DbstoretimeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_store_time_matrix_transpose(m : DbstoretimeMatrix) -> DbstoretimeMatrix {
  let result = db_store_time_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_store_time_matrix_add(a : DbstoretimeMatrix, b : DbstoretimeMatrix) -> DbstoretimeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_store_time_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_store_time_matrix_scale(m : DbstoretimeMatrix, s : Double) -> DbstoretimeMatrix {
  let result = db_store_time_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_store_time_matrix_multiply(a : DbstoretimeMatrix, b : DbstoretimeMatrix) -> DbstoretimeMatrix {
  if a.cols != b.rows { return db_store_time_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_store_time_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_store_time_matrix_trace(m : DbstoretimeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_store_time_matrix_det(m : DbstoretimeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_store_time_matrix_norm(m : DbstoretimeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_store_time_matrix_to_string(m : DbstoretimeMatrix) -> String {
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

pub(all) struct DbstoretimeVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_time_make_vector(comps : Array[Double]) -> DbstoretimeVector {
  { comps, dim: comps.length() }
}

pub fn db_store_time_vector_zero(dim : Int) -> DbstoretimeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_store_time_vector_add(a : DbstoretimeVector, b : DbstoretimeVector) -> DbstoretimeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_time_vector_sub(a : DbstoretimeVector, b : DbstoretimeVector) -> DbstoretimeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_time_vector_scale(v : DbstoretimeVector, s : Double) -> DbstoretimeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_store_time_vector_dot(a : DbstoretimeVector, b : DbstoretimeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_store_time_vector_norm(v : DbstoretimeVector) -> Double { @_common.sqrt(db_store_time_vector_dot(v, v)) }

pub fn db_store_time_vector_normalize(v : DbstoretimeVector) -> DbstoretimeVector {
  let n = db_store_time_vector_norm(v)
  if n < 0.0000001 { v } else { db_store_time_vector_scale(v, 1.0 / n) }
}

pub fn db_store_time_vector_dist(a : DbstoretimeVector, b : DbstoretimeVector) -> Double {
  db_store_time_vector_norm(db_store_time_vector_sub(a, b))
}

pub fn db_store_time_vector_to_string(v : DbstoretimeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_time_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_time_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_time_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_time_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_time_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_time_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_time_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_time_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_time_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_time_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_time_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_time_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_time_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_time_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_time_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_time_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_time_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_time_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_time_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_time_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_time_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_time_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_time_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_time_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_time_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_time_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_time_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_time_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_time_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstoretimeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_frame_make(size : Int) -> DbstoretimeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_frame_len(s : DbstoretimeFrame) -> Int { s.size }

pub fn db_store_time_frame_get(s : DbstoretimeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_frame_set(s : DbstoretimeFrame, i : Int, v : Double) -> DbstoretimeFrame {
  let result = db_store_time_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_time_frame_sum(s : DbstoretimeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_time_frame_mean(s : DbstoretimeFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_store_time_frame_sum(s) / s.size.to_double() }
}

pub fn db_store_time_frame_scale(s : DbstoretimeFrame, f : Double) -> DbstoretimeFrame {
  let result = db_store_time_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_time_frame_add(a : DbstoretimeFrame, b : DbstoretimeFrame) -> DbstoretimeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_time_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_time_frame_copy(s : DbstoretimeFrame) -> DbstoretimeFrame {
  let result = db_store_time_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_time_frame_fill(s : DbstoretimeFrame, v : Double) -> DbstoretimeFrame {
  let result = db_store_time_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_time_frame_min(s : DbstoretimeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_frame_max(s : DbstoretimeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_frame_to_string(s : DbstoretimeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_table_make(size : Int) -> DbstoretimeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_table_len(s : DbstoretimeTable) -> Int { s.size }

pub fn db_store_time_table_get(s : DbstoretimeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_table_set(s : DbstoretimeTable, i : Int, v : Double) -> DbstoretimeTable {
  let result = db_store_time_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_time_table_sum(s : DbstoretimeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_time_table_mean(s : DbstoretimeTable) -> Double {
  if s.size == 0 { 0.0 } else { db_store_time_table_sum(s) / s.size.to_double() }
}

pub fn db_store_time_table_scale(s : DbstoretimeTable, f : Double) -> DbstoretimeTable {
  let result = db_store_time_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_time_table_add(a : DbstoretimeTable, b : DbstoretimeTable) -> DbstoretimeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_time_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_time_table_copy(s : DbstoretimeTable) -> DbstoretimeTable {
  let result = db_store_time_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_time_table_fill(s : DbstoretimeTable, v : Double) -> DbstoretimeTable {
  let result = db_store_time_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_time_table_min(s : DbstoretimeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_table_max(s : DbstoretimeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_table_to_string(s : DbstoretimeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_graphn_make(size : Int) -> DbstoretimeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_graphn_len(s : DbstoretimeGraphN) -> Int { s.size }

pub fn db_store_time_graphn_get(s : DbstoretimeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_graphn_set(s : DbstoretimeGraphN, i : Int, v : Double) -> DbstoretimeGraphN {
  let result = db_store_time_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_time_graphn_sum(s : DbstoretimeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_time_graphn_mean(s : DbstoretimeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_store_time_graphn_sum(s) / s.size.to_double() }
}

pub fn db_store_time_graphn_scale(s : DbstoretimeGraphN, f : Double) -> DbstoretimeGraphN {
  let result = db_store_time_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_time_graphn_add(a : DbstoretimeGraphN, b : DbstoretimeGraphN) -> DbstoretimeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_time_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_time_graphn_copy(s : DbstoretimeGraphN) -> DbstoretimeGraphN {
  let result = db_store_time_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_time_graphn_fill(s : DbstoretimeGraphN, v : Double) -> DbstoretimeGraphN {
  let result = db_store_time_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_time_graphn_min(s : DbstoretimeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_graphn_max(s : DbstoretimeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_graphn_to_string(s : DbstoretimeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_node_make(size : Int) -> DbstoretimeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_node_len(s : DbstoretimeNode) -> Int { s.size }

pub fn db_store_time_node_get(s : DbstoretimeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_node_set(s : DbstoretimeNode, i : Int, v : Double) -> DbstoretimeNode {
  let result = db_store_time_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_time_node_sum(s : DbstoretimeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_time_node_mean(s : DbstoretimeNode) -> Double {
  if s.size == 0 { 0.0 } else { db_store_time_node_sum(s) / s.size.to_double() }
}

pub fn db_store_time_node_scale(s : DbstoretimeNode, f : Double) -> DbstoretimeNode {
  let result = db_store_time_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_time_node_add(a : DbstoretimeNode, b : DbstoretimeNode) -> DbstoretimeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_time_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_time_node_copy(s : DbstoretimeNode) -> DbstoretimeNode {
  let result = db_store_time_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_time_node_fill(s : DbstoretimeNode, v : Double) -> DbstoretimeNode {
  let result = db_store_time_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_time_node_min(s : DbstoretimeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_node_max(s : DbstoretimeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_node_to_string(s : DbstoretimeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_edge_make(size : Int) -> DbstoretimeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_edge_len(s : DbstoretimeEdge) -> Int { s.size }

pub fn db_store_time_edge_get(s : DbstoretimeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_edge_set(s : DbstoretimeEdge, i : Int, v : Double) -> DbstoretimeEdge {
  let result = db_store_time_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_time_edge_sum(s : DbstoretimeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_time_edge_mean(s : DbstoretimeEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_store_time_edge_sum(s) / s.size.to_double() }
}

pub fn db_store_time_edge_scale(s : DbstoretimeEdge, f : Double) -> DbstoretimeEdge {
  let result = db_store_time_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_time_edge_add(a : DbstoretimeEdge, b : DbstoretimeEdge) -> DbstoretimeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_time_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_time_edge_copy(s : DbstoretimeEdge) -> DbstoretimeEdge {
  let result = db_store_time_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_time_edge_fill(s : DbstoretimeEdge, v : Double) -> DbstoretimeEdge {
  let result = db_store_time_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_time_edge_min(s : DbstoretimeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_edge_max(s : DbstoretimeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_edge_to_string(s : DbstoretimeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_path_make(size : Int) -> DbstoretimePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_path_len(s : DbstoretimePath) -> Int { s.size }

pub fn db_store_time_path_get(s : DbstoretimePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_path_set(s : DbstoretimePath, i : Int, v : Double) -> DbstoretimePath {
  let result = db_store_time_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_time_path_sum(s : DbstoretimePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_time_path_mean(s : DbstoretimePath) -> Double {
  if s.size == 0 { 0.0 } else { db_store_time_path_sum(s) / s.size.to_double() }
}

pub fn db_store_time_path_scale(s : DbstoretimePath, f : Double) -> DbstoretimePath {
  let result = db_store_time_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_time_path_add(a : DbstoretimePath, b : DbstoretimePath) -> DbstoretimePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_time_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_time_path_copy(s : DbstoretimePath) -> DbstoretimePath {
  let result = db_store_time_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_time_path_fill(s : DbstoretimePath, v : Double) -> DbstoretimePath {
  let result = db_store_time_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_time_path_min(s : DbstoretimePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_path_max(s : DbstoretimePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_path_to_string(s : DbstoretimePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_cluster_make(size : Int) -> DbstoretimeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_cluster_len(s : DbstoretimeCluster) -> Int { s.size }

pub fn db_store_time_cluster_get(s : DbstoretimeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_cluster_set(s : DbstoretimeCluster, i : Int, v : Double) -> DbstoretimeCluster {
  let result = db_store_time_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_time_cluster_sum(s : DbstoretimeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_time_cluster_mean(s : DbstoretimeCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_store_time_cluster_sum(s) / s.size.to_double() }
}

pub fn db_store_time_cluster_scale(s : DbstoretimeCluster, f : Double) -> DbstoretimeCluster {
  let result = db_store_time_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_time_cluster_add(a : DbstoretimeCluster, b : DbstoretimeCluster) -> DbstoretimeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_time_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_time_cluster_copy(s : DbstoretimeCluster) -> DbstoretimeCluster {
  let result = db_store_time_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_time_cluster_fill(s : DbstoretimeCluster, v : Double) -> DbstoretimeCluster {
  let result = db_store_time_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_time_cluster_min(s : DbstoretimeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_cluster_max(s : DbstoretimeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_cluster_to_string(s : DbstoretimeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_model_make(size : Int) -> DbstoretimeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_model_len(s : DbstoretimeModel) -> Int { s.size }

pub fn db_store_time_model_get(s : DbstoretimeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_model_set(s : DbstoretimeModel, i : Int, v : Double) -> DbstoretimeModel {
  let result = db_store_time_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_time_model_sum(s : DbstoretimeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_time_model_mean(s : DbstoretimeModel) -> Double {
  if s.size == 0 { 0.0 } else { db_store_time_model_sum(s) / s.size.to_double() }
}

pub fn db_store_time_model_scale(s : DbstoretimeModel, f : Double) -> DbstoretimeModel {
  let result = db_store_time_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_time_model_add(a : DbstoretimeModel, b : DbstoretimeModel) -> DbstoretimeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_time_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_time_model_copy(s : DbstoretimeModel) -> DbstoretimeModel {
  let result = db_store_time_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_time_model_fill(s : DbstoretimeModel, v : Double) -> DbstoretimeModel {
  let result = db_store_time_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_time_model_min(s : DbstoretimeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_model_max(s : DbstoretimeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_model_to_string(s : DbstoretimeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_layer_make(size : Int) -> DbstoretimeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_layer_len(s : DbstoretimeLayer) -> Int { s.size }

pub fn db_store_time_layer_get(s : DbstoretimeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_layer_set(s : DbstoretimeLayer, i : Int, v : Double) -> DbstoretimeLayer {
  let result = db_store_time_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_time_layer_sum(s : DbstoretimeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_time_layer_mean(s : DbstoretimeLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_store_time_layer_sum(s) / s.size.to_double() }
}

pub fn db_store_time_layer_scale(s : DbstoretimeLayer, f : Double) -> DbstoretimeLayer {
  let result = db_store_time_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_time_layer_add(a : DbstoretimeLayer, b : DbstoretimeLayer) -> DbstoretimeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_time_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_time_layer_copy(s : DbstoretimeLayer) -> DbstoretimeLayer {
  let result = db_store_time_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_time_layer_fill(s : DbstoretimeLayer, v : Double) -> DbstoretimeLayer {
  let result = db_store_time_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_time_layer_min(s : DbstoretimeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_layer_max(s : DbstoretimeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_layer_to_string(s : DbstoretimeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_buffer_make(size : Int) -> DbstoretimeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_buffer_len(s : DbstoretimeBuffer) -> Int { s.size }

pub fn db_store_time_buffer_get(s : DbstoretimeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_buffer_set(s : DbstoretimeBuffer, i : Int, v : Double) -> DbstoretimeBuffer {
  let result = db_store_time_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_time_buffer_sum(s : DbstoretimeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_time_buffer_mean(s : DbstoretimeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_store_time_buffer_sum(s) / s.size.to_double() }
}

pub fn db_store_time_buffer_scale(s : DbstoretimeBuffer, f : Double) -> DbstoretimeBuffer {
  let result = db_store_time_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_time_buffer_add(a : DbstoretimeBuffer, b : DbstoretimeBuffer) -> DbstoretimeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_time_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_time_buffer_copy(s : DbstoretimeBuffer) -> DbstoretimeBuffer {
  let result = db_store_time_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_time_buffer_fill(s : DbstoretimeBuffer, v : Double) -> DbstoretimeBuffer {
  let result = db_store_time_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_time_buffer_min(s : DbstoretimeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_buffer_max(s : DbstoretimeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_buffer_to_string(s : DbstoretimeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_cursor_make(size : Int) -> DbstoretimeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_cursor_len(s : DbstoretimeCursor) -> Int { s.size }

pub fn db_store_time_cursor_get(s : DbstoretimeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_cursor_set(s : DbstoretimeCursor, i : Int, v : Double) -> DbstoretimeCursor {
  let result = db_store_time_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_time_cursor_sum(s : DbstoretimeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_time_cursor_mean(s : DbstoretimeCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_store_time_cursor_sum(s) / s.size.to_double() }
}

pub fn db_store_time_cursor_scale(s : DbstoretimeCursor, f : Double) -> DbstoretimeCursor {
  let result = db_store_time_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_time_cursor_add(a : DbstoretimeCursor, b : DbstoretimeCursor) -> DbstoretimeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_time_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_time_cursor_copy(s : DbstoretimeCursor) -> DbstoretimeCursor {
  let result = db_store_time_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_time_cursor_fill(s : DbstoretimeCursor, v : Double) -> DbstoretimeCursor {
  let result = db_store_time_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_time_cursor_min(s : DbstoretimeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_cursor_max(s : DbstoretimeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_cursor_to_string(s : DbstoretimeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_view_make(size : Int) -> DbstoretimeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_view_len(s : DbstoretimeView) -> Int { s.size }

pub fn db_store_time_view_get(s : DbstoretimeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_view_set(s : DbstoretimeView, i : Int, v : Double) -> DbstoretimeView {
  let result = db_store_time_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_time_view_sum(s : DbstoretimeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_time_view_mean(s : DbstoretimeView) -> Double {
  if s.size == 0 { 0.0 } else { db_store_time_view_sum(s) / s.size.to_double() }
}

pub fn db_store_time_view_scale(s : DbstoretimeView, f : Double) -> DbstoretimeView {
  let result = db_store_time_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_time_view_add(a : DbstoretimeView, b : DbstoretimeView) -> DbstoretimeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_time_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_time_view_copy(s : DbstoretimeView) -> DbstoretimeView {
  let result = db_store_time_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_time_view_fill(s : DbstoretimeView, v : Double) -> DbstoretimeView {
  let result = db_store_time_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_time_view_min(s : DbstoretimeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_view_max(s : DbstoretimeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_view_to_string(s : DbstoretimeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_range_make(size : Int) -> DbstoretimeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_range_len(s : DbstoretimeRange) -> Int { s.size }

pub fn db_store_time_range_get(s : DbstoretimeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_range_set(s : DbstoretimeRange, i : Int, v : Double) -> DbstoretimeRange {
  let result = db_store_time_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_time_range_sum(s : DbstoretimeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_time_range_mean(s : DbstoretimeRange) -> Double {
  if s.size == 0 { 0.0 } else { db_store_time_range_sum(s) / s.size.to_double() }
}

pub fn db_store_time_range_scale(s : DbstoretimeRange, f : Double) -> DbstoretimeRange {
  let result = db_store_time_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_time_range_add(a : DbstoretimeRange, b : DbstoretimeRange) -> DbstoretimeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_time_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_time_range_copy(s : DbstoretimeRange) -> DbstoretimeRange {
  let result = db_store_time_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_time_range_fill(s : DbstoretimeRange, v : Double) -> DbstoretimeRange {
  let result = db_store_time_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_time_range_min(s : DbstoretimeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_range_max(s : DbstoretimeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_range_to_string(s : DbstoretimeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_slice_make(size : Int) -> DbstoretimeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_slice_len(s : DbstoretimeSlice) -> Int { s.size }

pub fn db_store_time_slice_get(s : DbstoretimeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_slice_set(s : DbstoretimeSlice, i : Int, v : Double) -> DbstoretimeSlice {
  let result = db_store_time_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_time_slice_sum(s : DbstoretimeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_time_slice_mean(s : DbstoretimeSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_store_time_slice_sum(s) / s.size.to_double() }
}

pub fn db_store_time_slice_scale(s : DbstoretimeSlice, f : Double) -> DbstoretimeSlice {
  let result = db_store_time_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_time_slice_add(a : DbstoretimeSlice, b : DbstoretimeSlice) -> DbstoretimeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_time_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_time_slice_copy(s : DbstoretimeSlice) -> DbstoretimeSlice {
  let result = db_store_time_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_time_slice_fill(s : DbstoretimeSlice, v : Double) -> DbstoretimeSlice {
  let result = db_store_time_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_time_slice_min(s : DbstoretimeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_slice_max(s : DbstoretimeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_time_slice_to_string(s : DbstoretimeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

