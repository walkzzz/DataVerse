///===
/// extcore/db_query_group

pub(all) struct DbquerygroupPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_group_make_point(x : Double, y : Double) -> DbquerygroupPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_group_make_point3(x : Double, y : Double, z : Double) -> DbquerygroupPoint {
  { x, y, z, label: 0 }
}

pub fn db_query_group_point_x(pt : DbquerygroupPoint) -> Double { pt.x }

pub fn db_query_group_point_y(pt : DbquerygroupPoint) -> Double { pt.y }

pub fn db_query_group_point_z(pt : DbquerygroupPoint) -> Double { pt.z }

pub fn db_query_group_point_label(pt : DbquerygroupPoint) -> Int { pt.label }

pub fn db_query_group_point_dist(a : DbquerygroupPoint, b : DbquerygroupPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_query_group_point_add(a : DbquerygroupPoint, b : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_query_group_point_sub(a : DbquerygroupPoint, b : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_query_group_point_scale(pt : DbquerygroupPoint, s : Double) -> DbquerygroupPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_query_group_point_dot(a : DbquerygroupPoint, b : DbquerygroupPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_query_group_point_cross(a : DbquerygroupPoint, b : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_query_group_point_norm(pt : DbquerygroupPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_query_group_point_normalize(pt : DbquerygroupPoint) -> DbquerygroupPoint {
  let n = db_query_group_point_norm(pt)
  if n < 0.0000001 { pt } else { db_query_group_point_scale(pt, 1.0 / n) }
}

pub fn db_query_group_point_negate(pt : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_query_group_point_mid(a : DbquerygroupPoint, b : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_query_group_point_lerp(a : DbquerygroupPoint, b : DbquerygroupPoint, t : Double) -> DbquerygroupPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_query_group_point_to_string(pt : DbquerygroupPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbquerygroupSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_group_make_series(vals : Array[Double], name : String) -> DbquerygroupSeries {
  { vals, name, meta: 0 }
}

pub fn db_query_group_series_len(s : DbquerygroupSeries) -> Int { s.vals.length() }

pub fn db_query_group_series_sum(s : DbquerygroupSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_query_group_series_mean(s : DbquerygroupSeries) -> Double { @_common.mean(s.vals) }

pub fn db_query_group_series_min(s : DbquerygroupSeries) -> Double { @_common.min(s.vals) }

pub fn db_query_group_series_max(s : DbquerygroupSeries) -> Double { @_common.max(s.vals) }

pub fn db_query_group_series_range(s : DbquerygroupSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_query_group_series_var(s : DbquerygroupSeries) -> Double { @_common.variance(s.vals) }

pub fn db_query_group_series_std(s : DbquerygroupSeries) -> Double { @_common.std(s.vals) }

pub fn db_query_group_series_median(s : DbquerygroupSeries) -> Double { @_common.median(s.vals) }

pub fn db_query_group_series_scale(s : DbquerygroupSeries, f : Double) -> DbquerygroupSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_query_group_series_add(a : DbquerygroupSeries, b : DbquerygroupSeries) -> DbquerygroupSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_query_group_series_sub(a : DbquerygroupSeries, b : DbquerygroupSeries) -> DbquerygroupSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_query_group_series_normalize(s : DbquerygroupSeries) -> DbquerygroupSeries {
  let mn = db_query_group_series_min(s)
  let mx = db_query_group_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_query_group_series_cumsum(s : DbquerygroupSeries) -> DbquerygroupSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_query_group_series_to_string(s : DbquerygroupSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbquerygroupMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_group_make_matrix(rows : Int, cols : Int, val : Double) -> DbquerygroupMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_group_matrix_identity(n : Int) -> DbquerygroupMatrix {
  let m = db_query_group_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_query_group_matrix_get(m : DbquerygroupMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_query_group_matrix_transpose(m : DbquerygroupMatrix) -> DbquerygroupMatrix {
  let result = db_query_group_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_query_group_matrix_add(a : DbquerygroupMatrix, b : DbquerygroupMatrix) -> DbquerygroupMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_query_group_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_query_group_matrix_scale(m : DbquerygroupMatrix, s : Double) -> DbquerygroupMatrix {
  let result = db_query_group_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_query_group_matrix_multiply(a : DbquerygroupMatrix, b : DbquerygroupMatrix) -> DbquerygroupMatrix {
  if a.cols != b.rows { return db_query_group_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_query_group_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_query_group_matrix_trace(m : DbquerygroupMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_query_group_matrix_det(m : DbquerygroupMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_query_group_matrix_norm(m : DbquerygroupMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_query_group_matrix_to_string(m : DbquerygroupMatrix) -> String {
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

pub(all) struct DbquerygroupVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_group_make_vector(comps : Array[Double]) -> DbquerygroupVector {
  { comps, dim: comps.length() }
}

pub fn db_query_group_vector_zero(dim : Int) -> DbquerygroupVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_query_group_vector_add(a : DbquerygroupVector, b : DbquerygroupVector) -> DbquerygroupVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_group_vector_sub(a : DbquerygroupVector, b : DbquerygroupVector) -> DbquerygroupVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_group_vector_scale(v : DbquerygroupVector, s : Double) -> DbquerygroupVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_query_group_vector_dot(a : DbquerygroupVector, b : DbquerygroupVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_query_group_vector_norm(v : DbquerygroupVector) -> Double { @_common.sqrt(db_query_group_vector_dot(v, v)) }

pub fn db_query_group_vector_normalize(v : DbquerygroupVector) -> DbquerygroupVector {
  let n = db_query_group_vector_norm(v)
  if n < 0.0000001 { v } else { db_query_group_vector_scale(v, 1.0 / n) }
}

pub fn db_query_group_vector_dist(a : DbquerygroupVector, b : DbquerygroupVector) -> Double {
  db_query_group_vector_norm(db_query_group_vector_sub(a, b))
}

pub fn db_query_group_vector_to_string(v : DbquerygroupVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_group_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_group_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_group_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_group_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_group_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_group_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_group_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_group_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_group_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_group_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_group_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_group_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_group_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_group_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_group_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_group_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_group_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_group_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_group_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_group_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_group_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_group_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_group_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_group_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_group_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_group_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_group_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_group_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_group_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbquerygroupFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_frame_make(size : Int) -> DbquerygroupFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_frame_len(s : DbquerygroupFrame) -> Int { s.size }

pub fn db_query_group_frame_get(s : DbquerygroupFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_frame_set(s : DbquerygroupFrame, i : Int, v : Double) -> DbquerygroupFrame {
  let result = db_query_group_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_frame_sum(s : DbquerygroupFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_frame_mean(s : DbquerygroupFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_frame_sum(s) / s.size.to_double() }
}

pub fn db_query_group_frame_scale(s : DbquerygroupFrame, f : Double) -> DbquerygroupFrame {
  let result = db_query_group_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_frame_add(a : DbquerygroupFrame, b : DbquerygroupFrame) -> DbquerygroupFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_frame_copy(s : DbquerygroupFrame) -> DbquerygroupFrame {
  let result = db_query_group_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_frame_fill(s : DbquerygroupFrame, v : Double) -> DbquerygroupFrame {
  let result = db_query_group_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_frame_min(s : DbquerygroupFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_frame_max(s : DbquerygroupFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_frame_to_string(s : DbquerygroupFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_table_make(size : Int) -> DbquerygroupTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_table_len(s : DbquerygroupTable) -> Int { s.size }

pub fn db_query_group_table_get(s : DbquerygroupTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_table_set(s : DbquerygroupTable, i : Int, v : Double) -> DbquerygroupTable {
  let result = db_query_group_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_table_sum(s : DbquerygroupTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_table_mean(s : DbquerygroupTable) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_table_sum(s) / s.size.to_double() }
}

pub fn db_query_group_table_scale(s : DbquerygroupTable, f : Double) -> DbquerygroupTable {
  let result = db_query_group_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_table_add(a : DbquerygroupTable, b : DbquerygroupTable) -> DbquerygroupTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_table_copy(s : DbquerygroupTable) -> DbquerygroupTable {
  let result = db_query_group_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_table_fill(s : DbquerygroupTable, v : Double) -> DbquerygroupTable {
  let result = db_query_group_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_table_min(s : DbquerygroupTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_table_max(s : DbquerygroupTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_table_to_string(s : DbquerygroupTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_graphn_make(size : Int) -> DbquerygroupGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_graphn_len(s : DbquerygroupGraphN) -> Int { s.size }

pub fn db_query_group_graphn_get(s : DbquerygroupGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_graphn_set(s : DbquerygroupGraphN, i : Int, v : Double) -> DbquerygroupGraphN {
  let result = db_query_group_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_graphn_sum(s : DbquerygroupGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_graphn_mean(s : DbquerygroupGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_graphn_sum(s) / s.size.to_double() }
}

pub fn db_query_group_graphn_scale(s : DbquerygroupGraphN, f : Double) -> DbquerygroupGraphN {
  let result = db_query_group_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_graphn_add(a : DbquerygroupGraphN, b : DbquerygroupGraphN) -> DbquerygroupGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_graphn_copy(s : DbquerygroupGraphN) -> DbquerygroupGraphN {
  let result = db_query_group_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_graphn_fill(s : DbquerygroupGraphN, v : Double) -> DbquerygroupGraphN {
  let result = db_query_group_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_graphn_min(s : DbquerygroupGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_graphn_max(s : DbquerygroupGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_graphn_to_string(s : DbquerygroupGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_node_make(size : Int) -> DbquerygroupNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_node_len(s : DbquerygroupNode) -> Int { s.size }

pub fn db_query_group_node_get(s : DbquerygroupNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_node_set(s : DbquerygroupNode, i : Int, v : Double) -> DbquerygroupNode {
  let result = db_query_group_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_node_sum(s : DbquerygroupNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_node_mean(s : DbquerygroupNode) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_node_sum(s) / s.size.to_double() }
}

pub fn db_query_group_node_scale(s : DbquerygroupNode, f : Double) -> DbquerygroupNode {
  let result = db_query_group_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_node_add(a : DbquerygroupNode, b : DbquerygroupNode) -> DbquerygroupNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_node_copy(s : DbquerygroupNode) -> DbquerygroupNode {
  let result = db_query_group_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_node_fill(s : DbquerygroupNode, v : Double) -> DbquerygroupNode {
  let result = db_query_group_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_node_min(s : DbquerygroupNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_node_max(s : DbquerygroupNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_node_to_string(s : DbquerygroupNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_edge_make(size : Int) -> DbquerygroupEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_edge_len(s : DbquerygroupEdge) -> Int { s.size }

pub fn db_query_group_edge_get(s : DbquerygroupEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_edge_set(s : DbquerygroupEdge, i : Int, v : Double) -> DbquerygroupEdge {
  let result = db_query_group_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_edge_sum(s : DbquerygroupEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_edge_mean(s : DbquerygroupEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_edge_sum(s) / s.size.to_double() }
}

pub fn db_query_group_edge_scale(s : DbquerygroupEdge, f : Double) -> DbquerygroupEdge {
  let result = db_query_group_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_edge_add(a : DbquerygroupEdge, b : DbquerygroupEdge) -> DbquerygroupEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_edge_copy(s : DbquerygroupEdge) -> DbquerygroupEdge {
  let result = db_query_group_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_edge_fill(s : DbquerygroupEdge, v : Double) -> DbquerygroupEdge {
  let result = db_query_group_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_edge_min(s : DbquerygroupEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_edge_max(s : DbquerygroupEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_edge_to_string(s : DbquerygroupEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_path_make(size : Int) -> DbquerygroupPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_path_len(s : DbquerygroupPath) -> Int { s.size }

pub fn db_query_group_path_get(s : DbquerygroupPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_path_set(s : DbquerygroupPath, i : Int, v : Double) -> DbquerygroupPath {
  let result = db_query_group_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_path_sum(s : DbquerygroupPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_path_mean(s : DbquerygroupPath) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_path_sum(s) / s.size.to_double() }
}

pub fn db_query_group_path_scale(s : DbquerygroupPath, f : Double) -> DbquerygroupPath {
  let result = db_query_group_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_path_add(a : DbquerygroupPath, b : DbquerygroupPath) -> DbquerygroupPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_path_copy(s : DbquerygroupPath) -> DbquerygroupPath {
  let result = db_query_group_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_path_fill(s : DbquerygroupPath, v : Double) -> DbquerygroupPath {
  let result = db_query_group_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_path_min(s : DbquerygroupPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_path_max(s : DbquerygroupPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_path_to_string(s : DbquerygroupPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_cluster_make(size : Int) -> DbquerygroupCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_cluster_len(s : DbquerygroupCluster) -> Int { s.size }

pub fn db_query_group_cluster_get(s : DbquerygroupCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_cluster_set(s : DbquerygroupCluster, i : Int, v : Double) -> DbquerygroupCluster {
  let result = db_query_group_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_cluster_sum(s : DbquerygroupCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_cluster_mean(s : DbquerygroupCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_cluster_sum(s) / s.size.to_double() }
}

pub fn db_query_group_cluster_scale(s : DbquerygroupCluster, f : Double) -> DbquerygroupCluster {
  let result = db_query_group_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_cluster_add(a : DbquerygroupCluster, b : DbquerygroupCluster) -> DbquerygroupCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_cluster_copy(s : DbquerygroupCluster) -> DbquerygroupCluster {
  let result = db_query_group_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_cluster_fill(s : DbquerygroupCluster, v : Double) -> DbquerygroupCluster {
  let result = db_query_group_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_cluster_min(s : DbquerygroupCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_cluster_max(s : DbquerygroupCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_cluster_to_string(s : DbquerygroupCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_model_make(size : Int) -> DbquerygroupModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_model_len(s : DbquerygroupModel) -> Int { s.size }

pub fn db_query_group_model_get(s : DbquerygroupModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_model_set(s : DbquerygroupModel, i : Int, v : Double) -> DbquerygroupModel {
  let result = db_query_group_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_model_sum(s : DbquerygroupModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_model_mean(s : DbquerygroupModel) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_model_sum(s) / s.size.to_double() }
}

pub fn db_query_group_model_scale(s : DbquerygroupModel, f : Double) -> DbquerygroupModel {
  let result = db_query_group_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_model_add(a : DbquerygroupModel, b : DbquerygroupModel) -> DbquerygroupModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_model_copy(s : DbquerygroupModel) -> DbquerygroupModel {
  let result = db_query_group_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_model_fill(s : DbquerygroupModel, v : Double) -> DbquerygroupModel {
  let result = db_query_group_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_model_min(s : DbquerygroupModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_model_max(s : DbquerygroupModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_model_to_string(s : DbquerygroupModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_layer_make(size : Int) -> DbquerygroupLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_layer_len(s : DbquerygroupLayer) -> Int { s.size }

pub fn db_query_group_layer_get(s : DbquerygroupLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_layer_set(s : DbquerygroupLayer, i : Int, v : Double) -> DbquerygroupLayer {
  let result = db_query_group_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_layer_sum(s : DbquerygroupLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_layer_mean(s : DbquerygroupLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_layer_sum(s) / s.size.to_double() }
}

pub fn db_query_group_layer_scale(s : DbquerygroupLayer, f : Double) -> DbquerygroupLayer {
  let result = db_query_group_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_layer_add(a : DbquerygroupLayer, b : DbquerygroupLayer) -> DbquerygroupLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_layer_copy(s : DbquerygroupLayer) -> DbquerygroupLayer {
  let result = db_query_group_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_layer_fill(s : DbquerygroupLayer, v : Double) -> DbquerygroupLayer {
  let result = db_query_group_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_layer_min(s : DbquerygroupLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_layer_max(s : DbquerygroupLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_layer_to_string(s : DbquerygroupLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_buffer_make(size : Int) -> DbquerygroupBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_buffer_len(s : DbquerygroupBuffer) -> Int { s.size }

pub fn db_query_group_buffer_get(s : DbquerygroupBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_buffer_set(s : DbquerygroupBuffer, i : Int, v : Double) -> DbquerygroupBuffer {
  let result = db_query_group_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_buffer_sum(s : DbquerygroupBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_buffer_mean(s : DbquerygroupBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_buffer_sum(s) / s.size.to_double() }
}

pub fn db_query_group_buffer_scale(s : DbquerygroupBuffer, f : Double) -> DbquerygroupBuffer {
  let result = db_query_group_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_buffer_add(a : DbquerygroupBuffer, b : DbquerygroupBuffer) -> DbquerygroupBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_buffer_copy(s : DbquerygroupBuffer) -> DbquerygroupBuffer {
  let result = db_query_group_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_buffer_fill(s : DbquerygroupBuffer, v : Double) -> DbquerygroupBuffer {
  let result = db_query_group_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_buffer_min(s : DbquerygroupBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_buffer_max(s : DbquerygroupBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_buffer_to_string(s : DbquerygroupBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_cursor_make(size : Int) -> DbquerygroupCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_cursor_len(s : DbquerygroupCursor) -> Int { s.size }

pub fn db_query_group_cursor_get(s : DbquerygroupCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_cursor_set(s : DbquerygroupCursor, i : Int, v : Double) -> DbquerygroupCursor {
  let result = db_query_group_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_cursor_sum(s : DbquerygroupCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_cursor_mean(s : DbquerygroupCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_cursor_sum(s) / s.size.to_double() }
}

pub fn db_query_group_cursor_scale(s : DbquerygroupCursor, f : Double) -> DbquerygroupCursor {
  let result = db_query_group_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_cursor_add(a : DbquerygroupCursor, b : DbquerygroupCursor) -> DbquerygroupCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_cursor_copy(s : DbquerygroupCursor) -> DbquerygroupCursor {
  let result = db_query_group_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_cursor_fill(s : DbquerygroupCursor, v : Double) -> DbquerygroupCursor {
  let result = db_query_group_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_cursor_min(s : DbquerygroupCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_cursor_max(s : DbquerygroupCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_cursor_to_string(s : DbquerygroupCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_view_make(size : Int) -> DbquerygroupView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_view_len(s : DbquerygroupView) -> Int { s.size }

pub fn db_query_group_view_get(s : DbquerygroupView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_view_set(s : DbquerygroupView, i : Int, v : Double) -> DbquerygroupView {
  let result = db_query_group_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_view_sum(s : DbquerygroupView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_view_mean(s : DbquerygroupView) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_view_sum(s) / s.size.to_double() }
}

pub fn db_query_group_view_scale(s : DbquerygroupView, f : Double) -> DbquerygroupView {
  let result = db_query_group_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_view_add(a : DbquerygroupView, b : DbquerygroupView) -> DbquerygroupView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_view_copy(s : DbquerygroupView) -> DbquerygroupView {
  let result = db_query_group_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_view_fill(s : DbquerygroupView, v : Double) -> DbquerygroupView {
  let result = db_query_group_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_view_min(s : DbquerygroupView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_view_max(s : DbquerygroupView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_view_to_string(s : DbquerygroupView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_range_make(size : Int) -> DbquerygroupRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_range_len(s : DbquerygroupRange) -> Int { s.size }

pub fn db_query_group_range_get(s : DbquerygroupRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_range_set(s : DbquerygroupRange, i : Int, v : Double) -> DbquerygroupRange {
  let result = db_query_group_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_range_sum(s : DbquerygroupRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_range_mean(s : DbquerygroupRange) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_range_sum(s) / s.size.to_double() }
}

pub fn db_query_group_range_scale(s : DbquerygroupRange, f : Double) -> DbquerygroupRange {
  let result = db_query_group_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_range_add(a : DbquerygroupRange, b : DbquerygroupRange) -> DbquerygroupRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_range_copy(s : DbquerygroupRange) -> DbquerygroupRange {
  let result = db_query_group_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_range_fill(s : DbquerygroupRange, v : Double) -> DbquerygroupRange {
  let result = db_query_group_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_range_min(s : DbquerygroupRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_range_max(s : DbquerygroupRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_range_to_string(s : DbquerygroupRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_slice_make(size : Int) -> DbquerygroupSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_slice_len(s : DbquerygroupSlice) -> Int { s.size }

pub fn db_query_group_slice_get(s : DbquerygroupSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_slice_set(s : DbquerygroupSlice, i : Int, v : Double) -> DbquerygroupSlice {
  let result = db_query_group_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_slice_sum(s : DbquerygroupSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_slice_mean(s : DbquerygroupSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_slice_sum(s) / s.size.to_double() }
}

pub fn db_query_group_slice_scale(s : DbquerygroupSlice, f : Double) -> DbquerygroupSlice {
  let result = db_query_group_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_slice_add(a : DbquerygroupSlice, b : DbquerygroupSlice) -> DbquerygroupSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_slice_copy(s : DbquerygroupSlice) -> DbquerygroupSlice {
  let result = db_query_group_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_slice_fill(s : DbquerygroupSlice, v : Double) -> DbquerygroupSlice {
  let result = db_query_group_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_slice_min(s : DbquerygroupSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_slice_max(s : DbquerygroupSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_slice_to_string(s : DbquerygroupSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

