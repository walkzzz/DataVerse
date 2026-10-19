///===
/// extcore/db_query_parallel

pub(all) struct DbqueryparallelPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_parallel_make_point(x : Double, y : Double) -> DbqueryparallelPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_parallel_make_point3(x : Double, y : Double, z : Double) -> DbqueryparallelPoint {
  { x, y, z, label: 0 }
}

pub fn db_query_parallel_point_x(pt : DbqueryparallelPoint) -> Double { pt.x }

pub fn db_query_parallel_point_y(pt : DbqueryparallelPoint) -> Double { pt.y }

pub fn db_query_parallel_point_z(pt : DbqueryparallelPoint) -> Double { pt.z }

pub fn db_query_parallel_point_label(pt : DbqueryparallelPoint) -> Int { pt.label }

pub fn db_query_parallel_point_dist(a : DbqueryparallelPoint, b : DbqueryparallelPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_query_parallel_point_add(a : DbqueryparallelPoint, b : DbqueryparallelPoint) -> DbqueryparallelPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_query_parallel_point_sub(a : DbqueryparallelPoint, b : DbqueryparallelPoint) -> DbqueryparallelPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_query_parallel_point_scale(pt : DbqueryparallelPoint, s : Double) -> DbqueryparallelPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_query_parallel_point_dot(a : DbqueryparallelPoint, b : DbqueryparallelPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_query_parallel_point_cross(a : DbqueryparallelPoint, b : DbqueryparallelPoint) -> DbqueryparallelPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_query_parallel_point_norm(pt : DbqueryparallelPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_query_parallel_point_normalize(pt : DbqueryparallelPoint) -> DbqueryparallelPoint {
  let n = db_query_parallel_point_norm(pt)
  if n < 0.0000001 { pt } else { db_query_parallel_point_scale(pt, 1.0 / n) }
}

pub fn db_query_parallel_point_negate(pt : DbqueryparallelPoint) -> DbqueryparallelPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_query_parallel_point_mid(a : DbqueryparallelPoint, b : DbqueryparallelPoint) -> DbqueryparallelPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_query_parallel_point_lerp(a : DbqueryparallelPoint, b : DbqueryparallelPoint, t : Double) -> DbqueryparallelPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_query_parallel_point_to_string(pt : DbqueryparallelPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbqueryparallelSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_parallel_make_series(vals : Array[Double], name : String) -> DbqueryparallelSeries {
  { vals, name, meta: 0 }
}

pub fn db_query_parallel_series_len(s : DbqueryparallelSeries) -> Int { s.vals.length() }

pub fn db_query_parallel_series_sum(s : DbqueryparallelSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_query_parallel_series_mean(s : DbqueryparallelSeries) -> Double {
  let n = db_query_parallel_series_len(s)
  if n == 0 { 0.0 } else { db_query_parallel_series_sum(s) / n.to_double() }
}

pub fn db_query_parallel_series_min(s : DbqueryparallelSeries) -> Double {
  let n = db_query_parallel_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_query_parallel_series_max(s : DbqueryparallelSeries) -> Double {
  let n = db_query_parallel_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_query_parallel_series_range(s : DbqueryparallelSeries) -> Double {
  db_query_parallel_series_max(s) - db_query_parallel_series_min(s)
}

pub fn db_query_parallel_series_var(s : DbqueryparallelSeries) -> Double {
  let n = db_query_parallel_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_query_parallel_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_query_parallel_series_std(s : DbqueryparallelSeries) -> Double { @_common.sqrt(db_query_parallel_series_var(s)) }

pub fn db_query_parallel_series_median(s : DbqueryparallelSeries) -> Double {
  let n = db_query_parallel_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_query_parallel_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_query_parallel_series_scale(s : DbqueryparallelSeries, f : Double) -> DbqueryparallelSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_query_parallel_series_add(a : DbqueryparallelSeries, b : DbqueryparallelSeries) -> DbqueryparallelSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_query_parallel_series_sub(a : DbqueryparallelSeries, b : DbqueryparallelSeries) -> DbqueryparallelSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_query_parallel_series_normalize(s : DbqueryparallelSeries) -> DbqueryparallelSeries {
  let mn = db_query_parallel_series_min(s)
  let mx = db_query_parallel_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_query_parallel_series_cumsum(s : DbqueryparallelSeries) -> DbqueryparallelSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_query_parallel_series_to_string(s : DbqueryparallelSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbqueryparallelMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_parallel_make_matrix(rows : Int, cols : Int, val : Double) -> DbqueryparallelMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_parallel_matrix_identity(n : Int) -> DbqueryparallelMatrix {
  let m = db_query_parallel_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_query_parallel_matrix_get(m : DbqueryparallelMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_query_parallel_matrix_transpose(m : DbqueryparallelMatrix) -> DbqueryparallelMatrix {
  let result = db_query_parallel_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_query_parallel_matrix_add(a : DbqueryparallelMatrix, b : DbqueryparallelMatrix) -> DbqueryparallelMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_query_parallel_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_query_parallel_matrix_scale(m : DbqueryparallelMatrix, s : Double) -> DbqueryparallelMatrix {
  let result = db_query_parallel_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_query_parallel_matrix_multiply(a : DbqueryparallelMatrix, b : DbqueryparallelMatrix) -> DbqueryparallelMatrix {
  if a.cols != b.rows { return db_query_parallel_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_query_parallel_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_query_parallel_matrix_trace(m : DbqueryparallelMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_query_parallel_matrix_det(m : DbqueryparallelMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_query_parallel_matrix_norm(m : DbqueryparallelMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_query_parallel_matrix_to_string(m : DbqueryparallelMatrix) -> String {
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

pub(all) struct DbqueryparallelVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_parallel_make_vector(comps : Array[Double]) -> DbqueryparallelVector {
  { comps, dim: comps.length() }
}

pub fn db_query_parallel_vector_zero(dim : Int) -> DbqueryparallelVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_query_parallel_vector_add(a : DbqueryparallelVector, b : DbqueryparallelVector) -> DbqueryparallelVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_parallel_vector_sub(a : DbqueryparallelVector, b : DbqueryparallelVector) -> DbqueryparallelVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_parallel_vector_scale(v : DbqueryparallelVector, s : Double) -> DbqueryparallelVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_query_parallel_vector_dot(a : DbqueryparallelVector, b : DbqueryparallelVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_query_parallel_vector_norm(v : DbqueryparallelVector) -> Double { @_common.sqrt(db_query_parallel_vector_dot(v, v)) }

pub fn db_query_parallel_vector_normalize(v : DbqueryparallelVector) -> DbqueryparallelVector {
  let n = db_query_parallel_vector_norm(v)
  if n < 0.0000001 { v } else { db_query_parallel_vector_scale(v, 1.0 / n) }
}

pub fn db_query_parallel_vector_dist(a : DbqueryparallelVector, b : DbqueryparallelVector) -> Double {
  db_query_parallel_vector_norm(db_query_parallel_vector_sub(a, b))
}

pub fn db_query_parallel_vector_to_string(v : DbqueryparallelVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_parallel_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_parallel_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_parallel_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_parallel_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_parallel_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_parallel_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_parallel_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_parallel_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_parallel_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_parallel_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_parallel_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_parallel_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_parallel_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_parallel_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_parallel_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_parallel_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_parallel_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_parallel_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_parallel_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_parallel_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_parallel_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_parallel_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_parallel_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_parallel_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_parallel_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_parallel_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_parallel_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_parallel_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_parallel_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbqueryparallelFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_frame_make(size : Int) -> DbqueryparallelFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_frame_len(s : DbqueryparallelFrame) -> Int { s.size }

pub fn db_query_parallel_frame_get(s : DbqueryparallelFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_frame_set(s : DbqueryparallelFrame, i : Int, v : Double) -> DbqueryparallelFrame {
  let result = db_query_parallel_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_frame_sum(s : DbqueryparallelFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_parallel_frame_mean(s : DbqueryparallelFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_query_parallel_frame_sum(s) / s.size.to_double() }
}

pub fn db_query_parallel_frame_scale(s : DbqueryparallelFrame, f : Double) -> DbqueryparallelFrame {
  let result = db_query_parallel_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_parallel_frame_add(a : DbqueryparallelFrame, b : DbqueryparallelFrame) -> DbqueryparallelFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_parallel_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_parallel_frame_copy(s : DbqueryparallelFrame) -> DbqueryparallelFrame {
  let result = db_query_parallel_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_parallel_frame_fill(s : DbqueryparallelFrame, v : Double) -> DbqueryparallelFrame {
  let result = db_query_parallel_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_frame_min(s : DbqueryparallelFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_frame_max(s : DbqueryparallelFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_frame_to_string(s : DbqueryparallelFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_table_make(size : Int) -> DbqueryparallelTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_table_len(s : DbqueryparallelTable) -> Int { s.size }

pub fn db_query_parallel_table_get(s : DbqueryparallelTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_table_set(s : DbqueryparallelTable, i : Int, v : Double) -> DbqueryparallelTable {
  let result = db_query_parallel_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_table_sum(s : DbqueryparallelTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_parallel_table_mean(s : DbqueryparallelTable) -> Double {
  if s.size == 0 { 0.0 } else { db_query_parallel_table_sum(s) / s.size.to_double() }
}

pub fn db_query_parallel_table_scale(s : DbqueryparallelTable, f : Double) -> DbqueryparallelTable {
  let result = db_query_parallel_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_parallel_table_add(a : DbqueryparallelTable, b : DbqueryparallelTable) -> DbqueryparallelTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_parallel_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_parallel_table_copy(s : DbqueryparallelTable) -> DbqueryparallelTable {
  let result = db_query_parallel_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_parallel_table_fill(s : DbqueryparallelTable, v : Double) -> DbqueryparallelTable {
  let result = db_query_parallel_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_table_min(s : DbqueryparallelTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_table_max(s : DbqueryparallelTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_table_to_string(s : DbqueryparallelTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_graphn_make(size : Int) -> DbqueryparallelGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_graphn_len(s : DbqueryparallelGraphN) -> Int { s.size }

pub fn db_query_parallel_graphn_get(s : DbqueryparallelGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_graphn_set(s : DbqueryparallelGraphN, i : Int, v : Double) -> DbqueryparallelGraphN {
  let result = db_query_parallel_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_graphn_sum(s : DbqueryparallelGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_parallel_graphn_mean(s : DbqueryparallelGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_query_parallel_graphn_sum(s) / s.size.to_double() }
}

pub fn db_query_parallel_graphn_scale(s : DbqueryparallelGraphN, f : Double) -> DbqueryparallelGraphN {
  let result = db_query_parallel_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_parallel_graphn_add(a : DbqueryparallelGraphN, b : DbqueryparallelGraphN) -> DbqueryparallelGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_parallel_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_parallel_graphn_copy(s : DbqueryparallelGraphN) -> DbqueryparallelGraphN {
  let result = db_query_parallel_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_parallel_graphn_fill(s : DbqueryparallelGraphN, v : Double) -> DbqueryparallelGraphN {
  let result = db_query_parallel_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_graphn_min(s : DbqueryparallelGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_graphn_max(s : DbqueryparallelGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_graphn_to_string(s : DbqueryparallelGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_node_make(size : Int) -> DbqueryparallelNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_node_len(s : DbqueryparallelNode) -> Int { s.size }

pub fn db_query_parallel_node_get(s : DbqueryparallelNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_node_set(s : DbqueryparallelNode, i : Int, v : Double) -> DbqueryparallelNode {
  let result = db_query_parallel_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_node_sum(s : DbqueryparallelNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_parallel_node_mean(s : DbqueryparallelNode) -> Double {
  if s.size == 0 { 0.0 } else { db_query_parallel_node_sum(s) / s.size.to_double() }
}

pub fn db_query_parallel_node_scale(s : DbqueryparallelNode, f : Double) -> DbqueryparallelNode {
  let result = db_query_parallel_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_parallel_node_add(a : DbqueryparallelNode, b : DbqueryparallelNode) -> DbqueryparallelNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_parallel_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_parallel_node_copy(s : DbqueryparallelNode) -> DbqueryparallelNode {
  let result = db_query_parallel_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_parallel_node_fill(s : DbqueryparallelNode, v : Double) -> DbqueryparallelNode {
  let result = db_query_parallel_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_node_min(s : DbqueryparallelNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_node_max(s : DbqueryparallelNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_node_to_string(s : DbqueryparallelNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_edge_make(size : Int) -> DbqueryparallelEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_edge_len(s : DbqueryparallelEdge) -> Int { s.size }

pub fn db_query_parallel_edge_get(s : DbqueryparallelEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_edge_set(s : DbqueryparallelEdge, i : Int, v : Double) -> DbqueryparallelEdge {
  let result = db_query_parallel_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_edge_sum(s : DbqueryparallelEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_parallel_edge_mean(s : DbqueryparallelEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_query_parallel_edge_sum(s) / s.size.to_double() }
}

pub fn db_query_parallel_edge_scale(s : DbqueryparallelEdge, f : Double) -> DbqueryparallelEdge {
  let result = db_query_parallel_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_parallel_edge_add(a : DbqueryparallelEdge, b : DbqueryparallelEdge) -> DbqueryparallelEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_parallel_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_parallel_edge_copy(s : DbqueryparallelEdge) -> DbqueryparallelEdge {
  let result = db_query_parallel_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_parallel_edge_fill(s : DbqueryparallelEdge, v : Double) -> DbqueryparallelEdge {
  let result = db_query_parallel_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_edge_min(s : DbqueryparallelEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_edge_max(s : DbqueryparallelEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_edge_to_string(s : DbqueryparallelEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_path_make(size : Int) -> DbqueryparallelPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_path_len(s : DbqueryparallelPath) -> Int { s.size }

pub fn db_query_parallel_path_get(s : DbqueryparallelPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_path_set(s : DbqueryparallelPath, i : Int, v : Double) -> DbqueryparallelPath {
  let result = db_query_parallel_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_path_sum(s : DbqueryparallelPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_parallel_path_mean(s : DbqueryparallelPath) -> Double {
  if s.size == 0 { 0.0 } else { db_query_parallel_path_sum(s) / s.size.to_double() }
}

pub fn db_query_parallel_path_scale(s : DbqueryparallelPath, f : Double) -> DbqueryparallelPath {
  let result = db_query_parallel_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_parallel_path_add(a : DbqueryparallelPath, b : DbqueryparallelPath) -> DbqueryparallelPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_parallel_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_parallel_path_copy(s : DbqueryparallelPath) -> DbqueryparallelPath {
  let result = db_query_parallel_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_parallel_path_fill(s : DbqueryparallelPath, v : Double) -> DbqueryparallelPath {
  let result = db_query_parallel_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_path_min(s : DbqueryparallelPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_path_max(s : DbqueryparallelPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_path_to_string(s : DbqueryparallelPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_cluster_make(size : Int) -> DbqueryparallelCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_cluster_len(s : DbqueryparallelCluster) -> Int { s.size }

pub fn db_query_parallel_cluster_get(s : DbqueryparallelCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_cluster_set(s : DbqueryparallelCluster, i : Int, v : Double) -> DbqueryparallelCluster {
  let result = db_query_parallel_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_cluster_sum(s : DbqueryparallelCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_parallel_cluster_mean(s : DbqueryparallelCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_query_parallel_cluster_sum(s) / s.size.to_double() }
}

pub fn db_query_parallel_cluster_scale(s : DbqueryparallelCluster, f : Double) -> DbqueryparallelCluster {
  let result = db_query_parallel_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_parallel_cluster_add(a : DbqueryparallelCluster, b : DbqueryparallelCluster) -> DbqueryparallelCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_parallel_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_parallel_cluster_copy(s : DbqueryparallelCluster) -> DbqueryparallelCluster {
  let result = db_query_parallel_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_parallel_cluster_fill(s : DbqueryparallelCluster, v : Double) -> DbqueryparallelCluster {
  let result = db_query_parallel_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_cluster_min(s : DbqueryparallelCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_cluster_max(s : DbqueryparallelCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_cluster_to_string(s : DbqueryparallelCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_model_make(size : Int) -> DbqueryparallelModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_model_len(s : DbqueryparallelModel) -> Int { s.size }

pub fn db_query_parallel_model_get(s : DbqueryparallelModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_model_set(s : DbqueryparallelModel, i : Int, v : Double) -> DbqueryparallelModel {
  let result = db_query_parallel_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_model_sum(s : DbqueryparallelModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_parallel_model_mean(s : DbqueryparallelModel) -> Double {
  if s.size == 0 { 0.0 } else { db_query_parallel_model_sum(s) / s.size.to_double() }
}

pub fn db_query_parallel_model_scale(s : DbqueryparallelModel, f : Double) -> DbqueryparallelModel {
  let result = db_query_parallel_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_parallel_model_add(a : DbqueryparallelModel, b : DbqueryparallelModel) -> DbqueryparallelModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_parallel_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_parallel_model_copy(s : DbqueryparallelModel) -> DbqueryparallelModel {
  let result = db_query_parallel_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_parallel_model_fill(s : DbqueryparallelModel, v : Double) -> DbqueryparallelModel {
  let result = db_query_parallel_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_model_min(s : DbqueryparallelModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_model_max(s : DbqueryparallelModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_model_to_string(s : DbqueryparallelModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_layer_make(size : Int) -> DbqueryparallelLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_layer_len(s : DbqueryparallelLayer) -> Int { s.size }

pub fn db_query_parallel_layer_get(s : DbqueryparallelLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_layer_set(s : DbqueryparallelLayer, i : Int, v : Double) -> DbqueryparallelLayer {
  let result = db_query_parallel_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_layer_sum(s : DbqueryparallelLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_parallel_layer_mean(s : DbqueryparallelLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_parallel_layer_sum(s) / s.size.to_double() }
}

pub fn db_query_parallel_layer_scale(s : DbqueryparallelLayer, f : Double) -> DbqueryparallelLayer {
  let result = db_query_parallel_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_parallel_layer_add(a : DbqueryparallelLayer, b : DbqueryparallelLayer) -> DbqueryparallelLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_parallel_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_parallel_layer_copy(s : DbqueryparallelLayer) -> DbqueryparallelLayer {
  let result = db_query_parallel_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_parallel_layer_fill(s : DbqueryparallelLayer, v : Double) -> DbqueryparallelLayer {
  let result = db_query_parallel_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_layer_min(s : DbqueryparallelLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_layer_max(s : DbqueryparallelLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_layer_to_string(s : DbqueryparallelLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_buffer_make(size : Int) -> DbqueryparallelBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_buffer_len(s : DbqueryparallelBuffer) -> Int { s.size }

pub fn db_query_parallel_buffer_get(s : DbqueryparallelBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_buffer_set(s : DbqueryparallelBuffer, i : Int, v : Double) -> DbqueryparallelBuffer {
  let result = db_query_parallel_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_buffer_sum(s : DbqueryparallelBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_parallel_buffer_mean(s : DbqueryparallelBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_parallel_buffer_sum(s) / s.size.to_double() }
}

pub fn db_query_parallel_buffer_scale(s : DbqueryparallelBuffer, f : Double) -> DbqueryparallelBuffer {
  let result = db_query_parallel_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_parallel_buffer_add(a : DbqueryparallelBuffer, b : DbqueryparallelBuffer) -> DbqueryparallelBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_parallel_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_parallel_buffer_copy(s : DbqueryparallelBuffer) -> DbqueryparallelBuffer {
  let result = db_query_parallel_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_parallel_buffer_fill(s : DbqueryparallelBuffer, v : Double) -> DbqueryparallelBuffer {
  let result = db_query_parallel_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_buffer_min(s : DbqueryparallelBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_buffer_max(s : DbqueryparallelBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_buffer_to_string(s : DbqueryparallelBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_cursor_make(size : Int) -> DbqueryparallelCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_cursor_len(s : DbqueryparallelCursor) -> Int { s.size }

pub fn db_query_parallel_cursor_get(s : DbqueryparallelCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_cursor_set(s : DbqueryparallelCursor, i : Int, v : Double) -> DbqueryparallelCursor {
  let result = db_query_parallel_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_cursor_sum(s : DbqueryparallelCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_parallel_cursor_mean(s : DbqueryparallelCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_query_parallel_cursor_sum(s) / s.size.to_double() }
}

pub fn db_query_parallel_cursor_scale(s : DbqueryparallelCursor, f : Double) -> DbqueryparallelCursor {
  let result = db_query_parallel_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_parallel_cursor_add(a : DbqueryparallelCursor, b : DbqueryparallelCursor) -> DbqueryparallelCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_parallel_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_parallel_cursor_copy(s : DbqueryparallelCursor) -> DbqueryparallelCursor {
  let result = db_query_parallel_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_parallel_cursor_fill(s : DbqueryparallelCursor, v : Double) -> DbqueryparallelCursor {
  let result = db_query_parallel_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_cursor_min(s : DbqueryparallelCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_cursor_max(s : DbqueryparallelCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_cursor_to_string(s : DbqueryparallelCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_view_make(size : Int) -> DbqueryparallelView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_view_len(s : DbqueryparallelView) -> Int { s.size }

pub fn db_query_parallel_view_get(s : DbqueryparallelView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_view_set(s : DbqueryparallelView, i : Int, v : Double) -> DbqueryparallelView {
  let result = db_query_parallel_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_view_sum(s : DbqueryparallelView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_parallel_view_mean(s : DbqueryparallelView) -> Double {
  if s.size == 0 { 0.0 } else { db_query_parallel_view_sum(s) / s.size.to_double() }
}

pub fn db_query_parallel_view_scale(s : DbqueryparallelView, f : Double) -> DbqueryparallelView {
  let result = db_query_parallel_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_parallel_view_add(a : DbqueryparallelView, b : DbqueryparallelView) -> DbqueryparallelView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_parallel_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_parallel_view_copy(s : DbqueryparallelView) -> DbqueryparallelView {
  let result = db_query_parallel_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_parallel_view_fill(s : DbqueryparallelView, v : Double) -> DbqueryparallelView {
  let result = db_query_parallel_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_view_min(s : DbqueryparallelView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_view_max(s : DbqueryparallelView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_view_to_string(s : DbqueryparallelView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_range_make(size : Int) -> DbqueryparallelRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_range_len(s : DbqueryparallelRange) -> Int { s.size }

pub fn db_query_parallel_range_get(s : DbqueryparallelRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_range_set(s : DbqueryparallelRange, i : Int, v : Double) -> DbqueryparallelRange {
  let result = db_query_parallel_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_range_sum(s : DbqueryparallelRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_parallel_range_mean(s : DbqueryparallelRange) -> Double {
  if s.size == 0 { 0.0 } else { db_query_parallel_range_sum(s) / s.size.to_double() }
}

pub fn db_query_parallel_range_scale(s : DbqueryparallelRange, f : Double) -> DbqueryparallelRange {
  let result = db_query_parallel_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_parallel_range_add(a : DbqueryparallelRange, b : DbqueryparallelRange) -> DbqueryparallelRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_parallel_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_parallel_range_copy(s : DbqueryparallelRange) -> DbqueryparallelRange {
  let result = db_query_parallel_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_parallel_range_fill(s : DbqueryparallelRange, v : Double) -> DbqueryparallelRange {
  let result = db_query_parallel_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_range_min(s : DbqueryparallelRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_range_max(s : DbqueryparallelRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_range_to_string(s : DbqueryparallelRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryparallelSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_parallel_slice_make(size : Int) -> DbqueryparallelSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_parallel_slice_len(s : DbqueryparallelSlice) -> Int { s.size }

pub fn db_query_parallel_slice_get(s : DbqueryparallelSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_parallel_slice_set(s : DbqueryparallelSlice, i : Int, v : Double) -> DbqueryparallelSlice {
  let result = db_query_parallel_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_slice_sum(s : DbqueryparallelSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_parallel_slice_mean(s : DbqueryparallelSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_query_parallel_slice_sum(s) / s.size.to_double() }
}

pub fn db_query_parallel_slice_scale(s : DbqueryparallelSlice, f : Double) -> DbqueryparallelSlice {
  let result = db_query_parallel_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_parallel_slice_add(a : DbqueryparallelSlice, b : DbqueryparallelSlice) -> DbqueryparallelSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_parallel_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_parallel_slice_copy(s : DbqueryparallelSlice) -> DbqueryparallelSlice {
  let result = db_query_parallel_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_parallel_slice_fill(s : DbqueryparallelSlice, v : Double) -> DbqueryparallelSlice {
  let result = db_query_parallel_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_parallel_slice_min(s : DbqueryparallelSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_slice_max(s : DbqueryparallelSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_parallel_slice_to_string(s : DbqueryparallelSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

