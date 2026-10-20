///===
/// extcore/db_query_select

pub(all) struct DbqueryselectPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_select_make_point(x : Double, y : Double) -> DbqueryselectPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_select_make_point3(x : Double, y : Double, z : Double) -> DbqueryselectPoint {
  { x, y, z, label: 0 }
}

pub fn db_query_select_point_x(pt : DbqueryselectPoint) -> Double { pt.x }

pub fn db_query_select_point_y(pt : DbqueryselectPoint) -> Double { pt.y }

pub fn db_query_select_point_z(pt : DbqueryselectPoint) -> Double { pt.z }

pub fn db_query_select_point_label(pt : DbqueryselectPoint) -> Int { pt.label }

pub fn db_query_select_point_dist(a : DbqueryselectPoint, b : DbqueryselectPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_query_select_point_add(a : DbqueryselectPoint, b : DbqueryselectPoint) -> DbqueryselectPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_query_select_point_sub(a : DbqueryselectPoint, b : DbqueryselectPoint) -> DbqueryselectPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_query_select_point_scale(pt : DbqueryselectPoint, s : Double) -> DbqueryselectPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_query_select_point_dot(a : DbqueryselectPoint, b : DbqueryselectPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_query_select_point_cross(a : DbqueryselectPoint, b : DbqueryselectPoint) -> DbqueryselectPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_query_select_point_norm(pt : DbqueryselectPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_query_select_point_normalize(pt : DbqueryselectPoint) -> DbqueryselectPoint {
  let n = db_query_select_point_norm(pt)
  if n < 0.0000001 { pt } else { db_query_select_point_scale(pt, 1.0 / n) }
}

pub fn db_query_select_point_negate(pt : DbqueryselectPoint) -> DbqueryselectPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_query_select_point_mid(a : DbqueryselectPoint, b : DbqueryselectPoint) -> DbqueryselectPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_query_select_point_lerp(a : DbqueryselectPoint, b : DbqueryselectPoint, t : Double) -> DbqueryselectPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_query_select_point_to_string(pt : DbqueryselectPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbqueryselectSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_select_make_series(vals : Array[Double], name : String) -> DbqueryselectSeries {
  { vals, name, meta: 0 }
}

pub fn db_query_select_series_len(s : DbqueryselectSeries) -> Int { s.vals.length() }

pub fn db_query_select_series_sum(s : DbqueryselectSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_query_select_series_mean(s : DbqueryselectSeries) -> Double { @_common.mean(s.vals) }

pub fn db_query_select_series_min(s : DbqueryselectSeries) -> Double { @_common.min(s.vals) }

pub fn db_query_select_series_max(s : DbqueryselectSeries) -> Double { @_common.max(s.vals) }

pub fn db_query_select_series_range(s : DbqueryselectSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_query_select_series_var(s : DbqueryselectSeries) -> Double { @_common.variance(s.vals) }

pub fn db_query_select_series_std(s : DbqueryselectSeries) -> Double { @_common.std(s.vals) }

pub fn db_query_select_series_median(s : DbqueryselectSeries) -> Double { @_common.median(s.vals) }

pub fn db_query_select_series_scale(s : DbqueryselectSeries, f : Double) -> DbqueryselectSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_query_select_series_add(a : DbqueryselectSeries, b : DbqueryselectSeries) -> DbqueryselectSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_query_select_series_sub(a : DbqueryselectSeries, b : DbqueryselectSeries) -> DbqueryselectSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_query_select_series_normalize(s : DbqueryselectSeries) -> DbqueryselectSeries {
  let mn = db_query_select_series_min(s)
  let mx = db_query_select_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_query_select_series_cumsum(s : DbqueryselectSeries) -> DbqueryselectSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_query_select_series_to_string(s : DbqueryselectSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbqueryselectMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_select_make_matrix(rows : Int, cols : Int, val : Double) -> DbqueryselectMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_select_matrix_identity(n : Int) -> DbqueryselectMatrix {
  let m = db_query_select_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_query_select_matrix_get(m : DbqueryselectMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_query_select_matrix_transpose(m : DbqueryselectMatrix) -> DbqueryselectMatrix {
  let result = db_query_select_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_query_select_matrix_add(a : DbqueryselectMatrix, b : DbqueryselectMatrix) -> DbqueryselectMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_query_select_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_query_select_matrix_scale(m : DbqueryselectMatrix, s : Double) -> DbqueryselectMatrix {
  let result = db_query_select_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_query_select_matrix_multiply(a : DbqueryselectMatrix, b : DbqueryselectMatrix) -> DbqueryselectMatrix {
  if a.cols != b.rows { return db_query_select_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_query_select_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_query_select_matrix_trace(m : DbqueryselectMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_query_select_matrix_det(m : DbqueryselectMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_query_select_matrix_norm(m : DbqueryselectMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_query_select_matrix_to_string(m : DbqueryselectMatrix) -> String {
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

pub(all) struct DbqueryselectVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_select_make_vector(comps : Array[Double]) -> DbqueryselectVector {
  { comps, dim: comps.length() }
}

pub fn db_query_select_vector_zero(dim : Int) -> DbqueryselectVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_query_select_vector_add(a : DbqueryselectVector, b : DbqueryselectVector) -> DbqueryselectVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_select_vector_sub(a : DbqueryselectVector, b : DbqueryselectVector) -> DbqueryselectVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_select_vector_scale(v : DbqueryselectVector, s : Double) -> DbqueryselectVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_query_select_vector_dot(a : DbqueryselectVector, b : DbqueryselectVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_query_select_vector_norm(v : DbqueryselectVector) -> Double { @_common.sqrt(db_query_select_vector_dot(v, v)) }

pub fn db_query_select_vector_normalize(v : DbqueryselectVector) -> DbqueryselectVector {
  let n = db_query_select_vector_norm(v)
  if n < 0.0000001 { v } else { db_query_select_vector_scale(v, 1.0 / n) }
}

pub fn db_query_select_vector_dist(a : DbqueryselectVector, b : DbqueryselectVector) -> Double {
  db_query_select_vector_norm(db_query_select_vector_sub(a, b))
}

pub fn db_query_select_vector_to_string(v : DbqueryselectVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_select_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_select_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_select_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_select_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_select_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_select_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_select_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_select_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_select_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_select_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_select_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_select_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_select_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_select_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_select_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_select_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_select_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_select_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_select_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_select_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_select_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_select_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_select_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_select_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_select_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_select_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_select_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_select_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_select_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbqueryselectFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_frame_make(size : Int) -> DbqueryselectFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_frame_len(s : DbqueryselectFrame) -> Int { s.size }

pub fn db_query_select_frame_get(s : DbqueryselectFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_frame_set(s : DbqueryselectFrame, i : Int, v : Double) -> DbqueryselectFrame {
  let result = db_query_select_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_select_frame_sum(s : DbqueryselectFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_select_frame_mean(s : DbqueryselectFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_query_select_frame_sum(s) / s.size.to_double() }
}

pub fn db_query_select_frame_scale(s : DbqueryselectFrame, f : Double) -> DbqueryselectFrame {
  let result = db_query_select_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_select_frame_add(a : DbqueryselectFrame, b : DbqueryselectFrame) -> DbqueryselectFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_select_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_select_frame_copy(s : DbqueryselectFrame) -> DbqueryselectFrame {
  let result = db_query_select_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_select_frame_fill(s : DbqueryselectFrame, v : Double) -> DbqueryselectFrame {
  let result = db_query_select_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_select_frame_min(s : DbqueryselectFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_frame_max(s : DbqueryselectFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_frame_to_string(s : DbqueryselectFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_table_make(size : Int) -> DbqueryselectTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_table_len(s : DbqueryselectTable) -> Int { s.size }

pub fn db_query_select_table_get(s : DbqueryselectTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_table_set(s : DbqueryselectTable, i : Int, v : Double) -> DbqueryselectTable {
  let result = db_query_select_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_select_table_sum(s : DbqueryselectTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_select_table_mean(s : DbqueryselectTable) -> Double {
  if s.size == 0 { 0.0 } else { db_query_select_table_sum(s) / s.size.to_double() }
}

pub fn db_query_select_table_scale(s : DbqueryselectTable, f : Double) -> DbqueryselectTable {
  let result = db_query_select_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_select_table_add(a : DbqueryselectTable, b : DbqueryselectTable) -> DbqueryselectTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_select_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_select_table_copy(s : DbqueryselectTable) -> DbqueryselectTable {
  let result = db_query_select_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_select_table_fill(s : DbqueryselectTable, v : Double) -> DbqueryselectTable {
  let result = db_query_select_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_select_table_min(s : DbqueryselectTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_table_max(s : DbqueryselectTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_table_to_string(s : DbqueryselectTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_graphn_make(size : Int) -> DbqueryselectGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_graphn_len(s : DbqueryselectGraphN) -> Int { s.size }

pub fn db_query_select_graphn_get(s : DbqueryselectGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_graphn_set(s : DbqueryselectGraphN, i : Int, v : Double) -> DbqueryselectGraphN {
  let result = db_query_select_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_select_graphn_sum(s : DbqueryselectGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_select_graphn_mean(s : DbqueryselectGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_query_select_graphn_sum(s) / s.size.to_double() }
}

pub fn db_query_select_graphn_scale(s : DbqueryselectGraphN, f : Double) -> DbqueryselectGraphN {
  let result = db_query_select_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_select_graphn_add(a : DbqueryselectGraphN, b : DbqueryselectGraphN) -> DbqueryselectGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_select_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_select_graphn_copy(s : DbqueryselectGraphN) -> DbqueryselectGraphN {
  let result = db_query_select_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_select_graphn_fill(s : DbqueryselectGraphN, v : Double) -> DbqueryselectGraphN {
  let result = db_query_select_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_select_graphn_min(s : DbqueryselectGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_graphn_max(s : DbqueryselectGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_graphn_to_string(s : DbqueryselectGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_node_make(size : Int) -> DbqueryselectNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_node_len(s : DbqueryselectNode) -> Int { s.size }

pub fn db_query_select_node_get(s : DbqueryselectNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_node_set(s : DbqueryselectNode, i : Int, v : Double) -> DbqueryselectNode {
  let result = db_query_select_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_select_node_sum(s : DbqueryselectNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_select_node_mean(s : DbqueryselectNode) -> Double {
  if s.size == 0 { 0.0 } else { db_query_select_node_sum(s) / s.size.to_double() }
}

pub fn db_query_select_node_scale(s : DbqueryselectNode, f : Double) -> DbqueryselectNode {
  let result = db_query_select_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_select_node_add(a : DbqueryselectNode, b : DbqueryselectNode) -> DbqueryselectNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_select_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_select_node_copy(s : DbqueryselectNode) -> DbqueryselectNode {
  let result = db_query_select_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_select_node_fill(s : DbqueryselectNode, v : Double) -> DbqueryselectNode {
  let result = db_query_select_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_select_node_min(s : DbqueryselectNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_node_max(s : DbqueryselectNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_node_to_string(s : DbqueryselectNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_edge_make(size : Int) -> DbqueryselectEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_edge_len(s : DbqueryselectEdge) -> Int { s.size }

pub fn db_query_select_edge_get(s : DbqueryselectEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_edge_set(s : DbqueryselectEdge, i : Int, v : Double) -> DbqueryselectEdge {
  let result = db_query_select_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_select_edge_sum(s : DbqueryselectEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_select_edge_mean(s : DbqueryselectEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_query_select_edge_sum(s) / s.size.to_double() }
}

pub fn db_query_select_edge_scale(s : DbqueryselectEdge, f : Double) -> DbqueryselectEdge {
  let result = db_query_select_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_select_edge_add(a : DbqueryselectEdge, b : DbqueryselectEdge) -> DbqueryselectEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_select_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_select_edge_copy(s : DbqueryselectEdge) -> DbqueryselectEdge {
  let result = db_query_select_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_select_edge_fill(s : DbqueryselectEdge, v : Double) -> DbqueryselectEdge {
  let result = db_query_select_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_select_edge_min(s : DbqueryselectEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_edge_max(s : DbqueryselectEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_edge_to_string(s : DbqueryselectEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_path_make(size : Int) -> DbqueryselectPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_path_len(s : DbqueryselectPath) -> Int { s.size }

pub fn db_query_select_path_get(s : DbqueryselectPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_path_set(s : DbqueryselectPath, i : Int, v : Double) -> DbqueryselectPath {
  let result = db_query_select_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_select_path_sum(s : DbqueryselectPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_select_path_mean(s : DbqueryselectPath) -> Double {
  if s.size == 0 { 0.0 } else { db_query_select_path_sum(s) / s.size.to_double() }
}

pub fn db_query_select_path_scale(s : DbqueryselectPath, f : Double) -> DbqueryselectPath {
  let result = db_query_select_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_select_path_add(a : DbqueryselectPath, b : DbqueryselectPath) -> DbqueryselectPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_select_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_select_path_copy(s : DbqueryselectPath) -> DbqueryselectPath {
  let result = db_query_select_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_select_path_fill(s : DbqueryselectPath, v : Double) -> DbqueryselectPath {
  let result = db_query_select_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_select_path_min(s : DbqueryselectPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_path_max(s : DbqueryselectPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_path_to_string(s : DbqueryselectPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_cluster_make(size : Int) -> DbqueryselectCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_cluster_len(s : DbqueryselectCluster) -> Int { s.size }

pub fn db_query_select_cluster_get(s : DbqueryselectCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_cluster_set(s : DbqueryselectCluster, i : Int, v : Double) -> DbqueryselectCluster {
  let result = db_query_select_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_select_cluster_sum(s : DbqueryselectCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_select_cluster_mean(s : DbqueryselectCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_query_select_cluster_sum(s) / s.size.to_double() }
}

pub fn db_query_select_cluster_scale(s : DbqueryselectCluster, f : Double) -> DbqueryselectCluster {
  let result = db_query_select_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_select_cluster_add(a : DbqueryselectCluster, b : DbqueryselectCluster) -> DbqueryselectCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_select_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_select_cluster_copy(s : DbqueryselectCluster) -> DbqueryselectCluster {
  let result = db_query_select_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_select_cluster_fill(s : DbqueryselectCluster, v : Double) -> DbqueryselectCluster {
  let result = db_query_select_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_select_cluster_min(s : DbqueryselectCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_cluster_max(s : DbqueryselectCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_cluster_to_string(s : DbqueryselectCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_model_make(size : Int) -> DbqueryselectModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_model_len(s : DbqueryselectModel) -> Int { s.size }

pub fn db_query_select_model_get(s : DbqueryselectModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_model_set(s : DbqueryselectModel, i : Int, v : Double) -> DbqueryselectModel {
  let result = db_query_select_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_select_model_sum(s : DbqueryselectModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_select_model_mean(s : DbqueryselectModel) -> Double {
  if s.size == 0 { 0.0 } else { db_query_select_model_sum(s) / s.size.to_double() }
}

pub fn db_query_select_model_scale(s : DbqueryselectModel, f : Double) -> DbqueryselectModel {
  let result = db_query_select_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_select_model_add(a : DbqueryselectModel, b : DbqueryselectModel) -> DbqueryselectModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_select_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_select_model_copy(s : DbqueryselectModel) -> DbqueryselectModel {
  let result = db_query_select_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_select_model_fill(s : DbqueryselectModel, v : Double) -> DbqueryselectModel {
  let result = db_query_select_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_select_model_min(s : DbqueryselectModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_model_max(s : DbqueryselectModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_model_to_string(s : DbqueryselectModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_layer_make(size : Int) -> DbqueryselectLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_layer_len(s : DbqueryselectLayer) -> Int { s.size }

pub fn db_query_select_layer_get(s : DbqueryselectLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_layer_set(s : DbqueryselectLayer, i : Int, v : Double) -> DbqueryselectLayer {
  let result = db_query_select_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_select_layer_sum(s : DbqueryselectLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_select_layer_mean(s : DbqueryselectLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_select_layer_sum(s) / s.size.to_double() }
}

pub fn db_query_select_layer_scale(s : DbqueryselectLayer, f : Double) -> DbqueryselectLayer {
  let result = db_query_select_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_select_layer_add(a : DbqueryselectLayer, b : DbqueryselectLayer) -> DbqueryselectLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_select_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_select_layer_copy(s : DbqueryselectLayer) -> DbqueryselectLayer {
  let result = db_query_select_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_select_layer_fill(s : DbqueryselectLayer, v : Double) -> DbqueryselectLayer {
  let result = db_query_select_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_select_layer_min(s : DbqueryselectLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_layer_max(s : DbqueryselectLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_layer_to_string(s : DbqueryselectLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_buffer_make(size : Int) -> DbqueryselectBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_buffer_len(s : DbqueryselectBuffer) -> Int { s.size }

pub fn db_query_select_buffer_get(s : DbqueryselectBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_buffer_set(s : DbqueryselectBuffer, i : Int, v : Double) -> DbqueryselectBuffer {
  let result = db_query_select_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_select_buffer_sum(s : DbqueryselectBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_select_buffer_mean(s : DbqueryselectBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_select_buffer_sum(s) / s.size.to_double() }
}

pub fn db_query_select_buffer_scale(s : DbqueryselectBuffer, f : Double) -> DbqueryselectBuffer {
  let result = db_query_select_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_select_buffer_add(a : DbqueryselectBuffer, b : DbqueryselectBuffer) -> DbqueryselectBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_select_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_select_buffer_copy(s : DbqueryselectBuffer) -> DbqueryselectBuffer {
  let result = db_query_select_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_select_buffer_fill(s : DbqueryselectBuffer, v : Double) -> DbqueryselectBuffer {
  let result = db_query_select_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_select_buffer_min(s : DbqueryselectBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_buffer_max(s : DbqueryselectBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_buffer_to_string(s : DbqueryselectBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_cursor_make(size : Int) -> DbqueryselectCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_cursor_len(s : DbqueryselectCursor) -> Int { s.size }

pub fn db_query_select_cursor_get(s : DbqueryselectCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_cursor_set(s : DbqueryselectCursor, i : Int, v : Double) -> DbqueryselectCursor {
  let result = db_query_select_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_select_cursor_sum(s : DbqueryselectCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_select_cursor_mean(s : DbqueryselectCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_query_select_cursor_sum(s) / s.size.to_double() }
}

pub fn db_query_select_cursor_scale(s : DbqueryselectCursor, f : Double) -> DbqueryselectCursor {
  let result = db_query_select_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_select_cursor_add(a : DbqueryselectCursor, b : DbqueryselectCursor) -> DbqueryselectCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_select_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_select_cursor_copy(s : DbqueryselectCursor) -> DbqueryselectCursor {
  let result = db_query_select_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_select_cursor_fill(s : DbqueryselectCursor, v : Double) -> DbqueryselectCursor {
  let result = db_query_select_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_select_cursor_min(s : DbqueryselectCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_cursor_max(s : DbqueryselectCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_cursor_to_string(s : DbqueryselectCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_view_make(size : Int) -> DbqueryselectView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_view_len(s : DbqueryselectView) -> Int { s.size }

pub fn db_query_select_view_get(s : DbqueryselectView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_view_set(s : DbqueryselectView, i : Int, v : Double) -> DbqueryselectView {
  let result = db_query_select_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_select_view_sum(s : DbqueryselectView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_select_view_mean(s : DbqueryselectView) -> Double {
  if s.size == 0 { 0.0 } else { db_query_select_view_sum(s) / s.size.to_double() }
}

pub fn db_query_select_view_scale(s : DbqueryselectView, f : Double) -> DbqueryselectView {
  let result = db_query_select_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_select_view_add(a : DbqueryselectView, b : DbqueryselectView) -> DbqueryselectView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_select_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_select_view_copy(s : DbqueryselectView) -> DbqueryselectView {
  let result = db_query_select_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_select_view_fill(s : DbqueryselectView, v : Double) -> DbqueryselectView {
  let result = db_query_select_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_select_view_min(s : DbqueryselectView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_view_max(s : DbqueryselectView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_view_to_string(s : DbqueryselectView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_range_make(size : Int) -> DbqueryselectRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_range_len(s : DbqueryselectRange) -> Int { s.size }

pub fn db_query_select_range_get(s : DbqueryselectRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_range_set(s : DbqueryselectRange, i : Int, v : Double) -> DbqueryselectRange {
  let result = db_query_select_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_select_range_sum(s : DbqueryselectRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_select_range_mean(s : DbqueryselectRange) -> Double {
  if s.size == 0 { 0.0 } else { db_query_select_range_sum(s) / s.size.to_double() }
}

pub fn db_query_select_range_scale(s : DbqueryselectRange, f : Double) -> DbqueryselectRange {
  let result = db_query_select_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_select_range_add(a : DbqueryselectRange, b : DbqueryselectRange) -> DbqueryselectRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_select_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_select_range_copy(s : DbqueryselectRange) -> DbqueryselectRange {
  let result = db_query_select_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_select_range_fill(s : DbqueryselectRange, v : Double) -> DbqueryselectRange {
  let result = db_query_select_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_select_range_min(s : DbqueryselectRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_range_max(s : DbqueryselectRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_range_to_string(s : DbqueryselectRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryselectSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_slice_make(size : Int) -> DbqueryselectSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_select_slice_len(s : DbqueryselectSlice) -> Int { s.size }

pub fn db_query_select_slice_get(s : DbqueryselectSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_select_slice_set(s : DbqueryselectSlice, i : Int, v : Double) -> DbqueryselectSlice {
  let result = db_query_select_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_select_slice_sum(s : DbqueryselectSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_select_slice_mean(s : DbqueryselectSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_query_select_slice_sum(s) / s.size.to_double() }
}

pub fn db_query_select_slice_scale(s : DbqueryselectSlice, f : Double) -> DbqueryselectSlice {
  let result = db_query_select_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_select_slice_add(a : DbqueryselectSlice, b : DbqueryselectSlice) -> DbqueryselectSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_select_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_select_slice_copy(s : DbqueryselectSlice) -> DbqueryselectSlice {
  let result = db_query_select_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_select_slice_fill(s : DbqueryselectSlice, v : Double) -> DbqueryselectSlice {
  let result = db_query_select_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_select_slice_min(s : DbqueryselectSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_slice_max(s : DbqueryselectSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_select_slice_to_string(s : DbqueryselectSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

