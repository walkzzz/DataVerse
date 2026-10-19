///===
/// extcore/db_query_distributed

pub(all) struct DbquerydistributedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_distributed_make_point(x : Double, y : Double) -> DbquerydistributedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_distributed_make_point3(x : Double, y : Double, z : Double) -> DbquerydistributedPoint {
  { x, y, z, label: 0 }
}

pub fn db_query_distributed_point_x(pt : DbquerydistributedPoint) -> Double { pt.x }

pub fn db_query_distributed_point_y(pt : DbquerydistributedPoint) -> Double { pt.y }

pub fn db_query_distributed_point_z(pt : DbquerydistributedPoint) -> Double { pt.z }

pub fn db_query_distributed_point_label(pt : DbquerydistributedPoint) -> Int { pt.label }

pub fn db_query_distributed_point_dist(a : DbquerydistributedPoint, b : DbquerydistributedPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_query_distributed_point_add(a : DbquerydistributedPoint, b : DbquerydistributedPoint) -> DbquerydistributedPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_query_distributed_point_sub(a : DbquerydistributedPoint, b : DbquerydistributedPoint) -> DbquerydistributedPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_query_distributed_point_scale(pt : DbquerydistributedPoint, s : Double) -> DbquerydistributedPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_query_distributed_point_dot(a : DbquerydistributedPoint, b : DbquerydistributedPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_query_distributed_point_cross(a : DbquerydistributedPoint, b : DbquerydistributedPoint) -> DbquerydistributedPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_query_distributed_point_norm(pt : DbquerydistributedPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_query_distributed_point_normalize(pt : DbquerydistributedPoint) -> DbquerydistributedPoint {
  let n = db_query_distributed_point_norm(pt)
  if n < 0.0000001 { pt } else { db_query_distributed_point_scale(pt, 1.0 / n) }
}

pub fn db_query_distributed_point_negate(pt : DbquerydistributedPoint) -> DbquerydistributedPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_query_distributed_point_mid(a : DbquerydistributedPoint, b : DbquerydistributedPoint) -> DbquerydistributedPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_query_distributed_point_lerp(a : DbquerydistributedPoint, b : DbquerydistributedPoint, t : Double) -> DbquerydistributedPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_query_distributed_point_to_string(pt : DbquerydistributedPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbquerydistributedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_distributed_make_series(vals : Array[Double], name : String) -> DbquerydistributedSeries {
  { vals, name, meta: 0 }
}

pub fn db_query_distributed_series_len(s : DbquerydistributedSeries) -> Int { s.vals.length() }

pub fn db_query_distributed_series_sum(s : DbquerydistributedSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_query_distributed_series_mean(s : DbquerydistributedSeries) -> Double {
  let n = db_query_distributed_series_len(s)
  if n == 0 { 0.0 } else { db_query_distributed_series_sum(s) / n.to_double() }
}

pub fn db_query_distributed_series_min(s : DbquerydistributedSeries) -> Double {
  let n = db_query_distributed_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_query_distributed_series_max(s : DbquerydistributedSeries) -> Double {
  let n = db_query_distributed_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_query_distributed_series_range(s : DbquerydistributedSeries) -> Double {
  db_query_distributed_series_max(s) - db_query_distributed_series_min(s)
}

pub fn db_query_distributed_series_var(s : DbquerydistributedSeries) -> Double {
  let n = db_query_distributed_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_query_distributed_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_query_distributed_series_std(s : DbquerydistributedSeries) -> Double { @_common.sqrt(db_query_distributed_series_var(s)) }

pub fn db_query_distributed_series_median(s : DbquerydistributedSeries) -> Double {
  let n = db_query_distributed_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_query_distributed_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_query_distributed_series_scale(s : DbquerydistributedSeries, f : Double) -> DbquerydistributedSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_query_distributed_series_add(a : DbquerydistributedSeries, b : DbquerydistributedSeries) -> DbquerydistributedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_query_distributed_series_sub(a : DbquerydistributedSeries, b : DbquerydistributedSeries) -> DbquerydistributedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_query_distributed_series_normalize(s : DbquerydistributedSeries) -> DbquerydistributedSeries {
  let mn = db_query_distributed_series_min(s)
  let mx = db_query_distributed_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_query_distributed_series_cumsum(s : DbquerydistributedSeries) -> DbquerydistributedSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_query_distributed_series_to_string(s : DbquerydistributedSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbquerydistributedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_distributed_make_matrix(rows : Int, cols : Int, val : Double) -> DbquerydistributedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_distributed_matrix_identity(n : Int) -> DbquerydistributedMatrix {
  let m = db_query_distributed_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_query_distributed_matrix_get(m : DbquerydistributedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_query_distributed_matrix_transpose(m : DbquerydistributedMatrix) -> DbquerydistributedMatrix {
  let result = db_query_distributed_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_query_distributed_matrix_add(a : DbquerydistributedMatrix, b : DbquerydistributedMatrix) -> DbquerydistributedMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_query_distributed_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_query_distributed_matrix_scale(m : DbquerydistributedMatrix, s : Double) -> DbquerydistributedMatrix {
  let result = db_query_distributed_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_query_distributed_matrix_multiply(a : DbquerydistributedMatrix, b : DbquerydistributedMatrix) -> DbquerydistributedMatrix {
  if a.cols != b.rows { return db_query_distributed_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_query_distributed_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_query_distributed_matrix_trace(m : DbquerydistributedMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_query_distributed_matrix_det(m : DbquerydistributedMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_query_distributed_matrix_norm(m : DbquerydistributedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_query_distributed_matrix_to_string(m : DbquerydistributedMatrix) -> String {
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

pub(all) struct DbquerydistributedVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_distributed_make_vector(comps : Array[Double]) -> DbquerydistributedVector {
  { comps, dim: comps.length() }
}

pub fn db_query_distributed_vector_zero(dim : Int) -> DbquerydistributedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_query_distributed_vector_add(a : DbquerydistributedVector, b : DbquerydistributedVector) -> DbquerydistributedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_distributed_vector_sub(a : DbquerydistributedVector, b : DbquerydistributedVector) -> DbquerydistributedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_distributed_vector_scale(v : DbquerydistributedVector, s : Double) -> DbquerydistributedVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_query_distributed_vector_dot(a : DbquerydistributedVector, b : DbquerydistributedVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_query_distributed_vector_norm(v : DbquerydistributedVector) -> Double { @_common.sqrt(db_query_distributed_vector_dot(v, v)) }

pub fn db_query_distributed_vector_normalize(v : DbquerydistributedVector) -> DbquerydistributedVector {
  let n = db_query_distributed_vector_norm(v)
  if n < 0.0000001 { v } else { db_query_distributed_vector_scale(v, 1.0 / n) }
}

pub fn db_query_distributed_vector_dist(a : DbquerydistributedVector, b : DbquerydistributedVector) -> Double {
  db_query_distributed_vector_norm(db_query_distributed_vector_sub(a, b))
}

pub fn db_query_distributed_vector_to_string(v : DbquerydistributedVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_distributed_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_distributed_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_distributed_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_distributed_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_distributed_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_distributed_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_distributed_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_distributed_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_distributed_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_distributed_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_distributed_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_distributed_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_distributed_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_distributed_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_distributed_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_distributed_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_distributed_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_distributed_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_distributed_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_distributed_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_distributed_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_distributed_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_distributed_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_distributed_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_distributed_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_distributed_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_distributed_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_distributed_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_distributed_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbquerydistributedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_frame_make(size : Int) -> DbquerydistributedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_frame_len(s : DbquerydistributedFrame) -> Int { s.size }

pub fn db_query_distributed_frame_get(s : DbquerydistributedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_frame_set(s : DbquerydistributedFrame, i : Int, v : Double) -> DbquerydistributedFrame {
  let result = db_query_distributed_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_frame_sum(s : DbquerydistributedFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_distributed_frame_mean(s : DbquerydistributedFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_query_distributed_frame_sum(s) / s.size.to_double() }
}

pub fn db_query_distributed_frame_scale(s : DbquerydistributedFrame, f : Double) -> DbquerydistributedFrame {
  let result = db_query_distributed_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_distributed_frame_add(a : DbquerydistributedFrame, b : DbquerydistributedFrame) -> DbquerydistributedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_distributed_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_distributed_frame_copy(s : DbquerydistributedFrame) -> DbquerydistributedFrame {
  let result = db_query_distributed_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_distributed_frame_fill(s : DbquerydistributedFrame, v : Double) -> DbquerydistributedFrame {
  let result = db_query_distributed_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_frame_min(s : DbquerydistributedFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_frame_max(s : DbquerydistributedFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_frame_to_string(s : DbquerydistributedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_table_make(size : Int) -> DbquerydistributedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_table_len(s : DbquerydistributedTable) -> Int { s.size }

pub fn db_query_distributed_table_get(s : DbquerydistributedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_table_set(s : DbquerydistributedTable, i : Int, v : Double) -> DbquerydistributedTable {
  let result = db_query_distributed_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_table_sum(s : DbquerydistributedTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_distributed_table_mean(s : DbquerydistributedTable) -> Double {
  if s.size == 0 { 0.0 } else { db_query_distributed_table_sum(s) / s.size.to_double() }
}

pub fn db_query_distributed_table_scale(s : DbquerydistributedTable, f : Double) -> DbquerydistributedTable {
  let result = db_query_distributed_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_distributed_table_add(a : DbquerydistributedTable, b : DbquerydistributedTable) -> DbquerydistributedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_distributed_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_distributed_table_copy(s : DbquerydistributedTable) -> DbquerydistributedTable {
  let result = db_query_distributed_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_distributed_table_fill(s : DbquerydistributedTable, v : Double) -> DbquerydistributedTable {
  let result = db_query_distributed_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_table_min(s : DbquerydistributedTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_table_max(s : DbquerydistributedTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_table_to_string(s : DbquerydistributedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_graphn_make(size : Int) -> DbquerydistributedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_graphn_len(s : DbquerydistributedGraphN) -> Int { s.size }

pub fn db_query_distributed_graphn_get(s : DbquerydistributedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_graphn_set(s : DbquerydistributedGraphN, i : Int, v : Double) -> DbquerydistributedGraphN {
  let result = db_query_distributed_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_graphn_sum(s : DbquerydistributedGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_distributed_graphn_mean(s : DbquerydistributedGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_query_distributed_graphn_sum(s) / s.size.to_double() }
}

pub fn db_query_distributed_graphn_scale(s : DbquerydistributedGraphN, f : Double) -> DbquerydistributedGraphN {
  let result = db_query_distributed_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_distributed_graphn_add(a : DbquerydistributedGraphN, b : DbquerydistributedGraphN) -> DbquerydistributedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_distributed_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_distributed_graphn_copy(s : DbquerydistributedGraphN) -> DbquerydistributedGraphN {
  let result = db_query_distributed_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_distributed_graphn_fill(s : DbquerydistributedGraphN, v : Double) -> DbquerydistributedGraphN {
  let result = db_query_distributed_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_graphn_min(s : DbquerydistributedGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_graphn_max(s : DbquerydistributedGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_graphn_to_string(s : DbquerydistributedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_node_make(size : Int) -> DbquerydistributedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_node_len(s : DbquerydistributedNode) -> Int { s.size }

pub fn db_query_distributed_node_get(s : DbquerydistributedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_node_set(s : DbquerydistributedNode, i : Int, v : Double) -> DbquerydistributedNode {
  let result = db_query_distributed_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_node_sum(s : DbquerydistributedNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_distributed_node_mean(s : DbquerydistributedNode) -> Double {
  if s.size == 0 { 0.0 } else { db_query_distributed_node_sum(s) / s.size.to_double() }
}

pub fn db_query_distributed_node_scale(s : DbquerydistributedNode, f : Double) -> DbquerydistributedNode {
  let result = db_query_distributed_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_distributed_node_add(a : DbquerydistributedNode, b : DbquerydistributedNode) -> DbquerydistributedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_distributed_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_distributed_node_copy(s : DbquerydistributedNode) -> DbquerydistributedNode {
  let result = db_query_distributed_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_distributed_node_fill(s : DbquerydistributedNode, v : Double) -> DbquerydistributedNode {
  let result = db_query_distributed_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_node_min(s : DbquerydistributedNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_node_max(s : DbquerydistributedNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_node_to_string(s : DbquerydistributedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_edge_make(size : Int) -> DbquerydistributedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_edge_len(s : DbquerydistributedEdge) -> Int { s.size }

pub fn db_query_distributed_edge_get(s : DbquerydistributedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_edge_set(s : DbquerydistributedEdge, i : Int, v : Double) -> DbquerydistributedEdge {
  let result = db_query_distributed_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_edge_sum(s : DbquerydistributedEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_distributed_edge_mean(s : DbquerydistributedEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_query_distributed_edge_sum(s) / s.size.to_double() }
}

pub fn db_query_distributed_edge_scale(s : DbquerydistributedEdge, f : Double) -> DbquerydistributedEdge {
  let result = db_query_distributed_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_distributed_edge_add(a : DbquerydistributedEdge, b : DbquerydistributedEdge) -> DbquerydistributedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_distributed_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_distributed_edge_copy(s : DbquerydistributedEdge) -> DbquerydistributedEdge {
  let result = db_query_distributed_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_distributed_edge_fill(s : DbquerydistributedEdge, v : Double) -> DbquerydistributedEdge {
  let result = db_query_distributed_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_edge_min(s : DbquerydistributedEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_edge_max(s : DbquerydistributedEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_edge_to_string(s : DbquerydistributedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_path_make(size : Int) -> DbquerydistributedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_path_len(s : DbquerydistributedPath) -> Int { s.size }

pub fn db_query_distributed_path_get(s : DbquerydistributedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_path_set(s : DbquerydistributedPath, i : Int, v : Double) -> DbquerydistributedPath {
  let result = db_query_distributed_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_path_sum(s : DbquerydistributedPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_distributed_path_mean(s : DbquerydistributedPath) -> Double {
  if s.size == 0 { 0.0 } else { db_query_distributed_path_sum(s) / s.size.to_double() }
}

pub fn db_query_distributed_path_scale(s : DbquerydistributedPath, f : Double) -> DbquerydistributedPath {
  let result = db_query_distributed_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_distributed_path_add(a : DbquerydistributedPath, b : DbquerydistributedPath) -> DbquerydistributedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_distributed_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_distributed_path_copy(s : DbquerydistributedPath) -> DbquerydistributedPath {
  let result = db_query_distributed_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_distributed_path_fill(s : DbquerydistributedPath, v : Double) -> DbquerydistributedPath {
  let result = db_query_distributed_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_path_min(s : DbquerydistributedPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_path_max(s : DbquerydistributedPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_path_to_string(s : DbquerydistributedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_cluster_make(size : Int) -> DbquerydistributedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_cluster_len(s : DbquerydistributedCluster) -> Int { s.size }

pub fn db_query_distributed_cluster_get(s : DbquerydistributedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_cluster_set(s : DbquerydistributedCluster, i : Int, v : Double) -> DbquerydistributedCluster {
  let result = db_query_distributed_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_cluster_sum(s : DbquerydistributedCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_distributed_cluster_mean(s : DbquerydistributedCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_query_distributed_cluster_sum(s) / s.size.to_double() }
}

pub fn db_query_distributed_cluster_scale(s : DbquerydistributedCluster, f : Double) -> DbquerydistributedCluster {
  let result = db_query_distributed_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_distributed_cluster_add(a : DbquerydistributedCluster, b : DbquerydistributedCluster) -> DbquerydistributedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_distributed_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_distributed_cluster_copy(s : DbquerydistributedCluster) -> DbquerydistributedCluster {
  let result = db_query_distributed_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_distributed_cluster_fill(s : DbquerydistributedCluster, v : Double) -> DbquerydistributedCluster {
  let result = db_query_distributed_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_cluster_min(s : DbquerydistributedCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_cluster_max(s : DbquerydistributedCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_cluster_to_string(s : DbquerydistributedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_model_make(size : Int) -> DbquerydistributedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_model_len(s : DbquerydistributedModel) -> Int { s.size }

pub fn db_query_distributed_model_get(s : DbquerydistributedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_model_set(s : DbquerydistributedModel, i : Int, v : Double) -> DbquerydistributedModel {
  let result = db_query_distributed_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_model_sum(s : DbquerydistributedModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_distributed_model_mean(s : DbquerydistributedModel) -> Double {
  if s.size == 0 { 0.0 } else { db_query_distributed_model_sum(s) / s.size.to_double() }
}

pub fn db_query_distributed_model_scale(s : DbquerydistributedModel, f : Double) -> DbquerydistributedModel {
  let result = db_query_distributed_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_distributed_model_add(a : DbquerydistributedModel, b : DbquerydistributedModel) -> DbquerydistributedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_distributed_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_distributed_model_copy(s : DbquerydistributedModel) -> DbquerydistributedModel {
  let result = db_query_distributed_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_distributed_model_fill(s : DbquerydistributedModel, v : Double) -> DbquerydistributedModel {
  let result = db_query_distributed_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_model_min(s : DbquerydistributedModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_model_max(s : DbquerydistributedModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_model_to_string(s : DbquerydistributedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_layer_make(size : Int) -> DbquerydistributedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_layer_len(s : DbquerydistributedLayer) -> Int { s.size }

pub fn db_query_distributed_layer_get(s : DbquerydistributedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_layer_set(s : DbquerydistributedLayer, i : Int, v : Double) -> DbquerydistributedLayer {
  let result = db_query_distributed_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_layer_sum(s : DbquerydistributedLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_distributed_layer_mean(s : DbquerydistributedLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_distributed_layer_sum(s) / s.size.to_double() }
}

pub fn db_query_distributed_layer_scale(s : DbquerydistributedLayer, f : Double) -> DbquerydistributedLayer {
  let result = db_query_distributed_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_distributed_layer_add(a : DbquerydistributedLayer, b : DbquerydistributedLayer) -> DbquerydistributedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_distributed_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_distributed_layer_copy(s : DbquerydistributedLayer) -> DbquerydistributedLayer {
  let result = db_query_distributed_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_distributed_layer_fill(s : DbquerydistributedLayer, v : Double) -> DbquerydistributedLayer {
  let result = db_query_distributed_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_layer_min(s : DbquerydistributedLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_layer_max(s : DbquerydistributedLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_layer_to_string(s : DbquerydistributedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_buffer_make(size : Int) -> DbquerydistributedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_buffer_len(s : DbquerydistributedBuffer) -> Int { s.size }

pub fn db_query_distributed_buffer_get(s : DbquerydistributedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_buffer_set(s : DbquerydistributedBuffer, i : Int, v : Double) -> DbquerydistributedBuffer {
  let result = db_query_distributed_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_buffer_sum(s : DbquerydistributedBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_distributed_buffer_mean(s : DbquerydistributedBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_distributed_buffer_sum(s) / s.size.to_double() }
}

pub fn db_query_distributed_buffer_scale(s : DbquerydistributedBuffer, f : Double) -> DbquerydistributedBuffer {
  let result = db_query_distributed_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_distributed_buffer_add(a : DbquerydistributedBuffer, b : DbquerydistributedBuffer) -> DbquerydistributedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_distributed_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_distributed_buffer_copy(s : DbquerydistributedBuffer) -> DbquerydistributedBuffer {
  let result = db_query_distributed_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_distributed_buffer_fill(s : DbquerydistributedBuffer, v : Double) -> DbquerydistributedBuffer {
  let result = db_query_distributed_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_buffer_min(s : DbquerydistributedBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_buffer_max(s : DbquerydistributedBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_buffer_to_string(s : DbquerydistributedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_cursor_make(size : Int) -> DbquerydistributedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_cursor_len(s : DbquerydistributedCursor) -> Int { s.size }

pub fn db_query_distributed_cursor_get(s : DbquerydistributedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_cursor_set(s : DbquerydistributedCursor, i : Int, v : Double) -> DbquerydistributedCursor {
  let result = db_query_distributed_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_cursor_sum(s : DbquerydistributedCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_distributed_cursor_mean(s : DbquerydistributedCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_query_distributed_cursor_sum(s) / s.size.to_double() }
}

pub fn db_query_distributed_cursor_scale(s : DbquerydistributedCursor, f : Double) -> DbquerydistributedCursor {
  let result = db_query_distributed_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_distributed_cursor_add(a : DbquerydistributedCursor, b : DbquerydistributedCursor) -> DbquerydistributedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_distributed_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_distributed_cursor_copy(s : DbquerydistributedCursor) -> DbquerydistributedCursor {
  let result = db_query_distributed_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_distributed_cursor_fill(s : DbquerydistributedCursor, v : Double) -> DbquerydistributedCursor {
  let result = db_query_distributed_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_cursor_min(s : DbquerydistributedCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_cursor_max(s : DbquerydistributedCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_cursor_to_string(s : DbquerydistributedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_view_make(size : Int) -> DbquerydistributedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_view_len(s : DbquerydistributedView) -> Int { s.size }

pub fn db_query_distributed_view_get(s : DbquerydistributedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_view_set(s : DbquerydistributedView, i : Int, v : Double) -> DbquerydistributedView {
  let result = db_query_distributed_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_view_sum(s : DbquerydistributedView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_distributed_view_mean(s : DbquerydistributedView) -> Double {
  if s.size == 0 { 0.0 } else { db_query_distributed_view_sum(s) / s.size.to_double() }
}

pub fn db_query_distributed_view_scale(s : DbquerydistributedView, f : Double) -> DbquerydistributedView {
  let result = db_query_distributed_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_distributed_view_add(a : DbquerydistributedView, b : DbquerydistributedView) -> DbquerydistributedView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_distributed_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_distributed_view_copy(s : DbquerydistributedView) -> DbquerydistributedView {
  let result = db_query_distributed_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_distributed_view_fill(s : DbquerydistributedView, v : Double) -> DbquerydistributedView {
  let result = db_query_distributed_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_view_min(s : DbquerydistributedView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_view_max(s : DbquerydistributedView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_view_to_string(s : DbquerydistributedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_range_make(size : Int) -> DbquerydistributedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_range_len(s : DbquerydistributedRange) -> Int { s.size }

pub fn db_query_distributed_range_get(s : DbquerydistributedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_range_set(s : DbquerydistributedRange, i : Int, v : Double) -> DbquerydistributedRange {
  let result = db_query_distributed_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_range_sum(s : DbquerydistributedRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_distributed_range_mean(s : DbquerydistributedRange) -> Double {
  if s.size == 0 { 0.0 } else { db_query_distributed_range_sum(s) / s.size.to_double() }
}

pub fn db_query_distributed_range_scale(s : DbquerydistributedRange, f : Double) -> DbquerydistributedRange {
  let result = db_query_distributed_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_distributed_range_add(a : DbquerydistributedRange, b : DbquerydistributedRange) -> DbquerydistributedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_distributed_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_distributed_range_copy(s : DbquerydistributedRange) -> DbquerydistributedRange {
  let result = db_query_distributed_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_distributed_range_fill(s : DbquerydistributedRange, v : Double) -> DbquerydistributedRange {
  let result = db_query_distributed_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_range_min(s : DbquerydistributedRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_range_max(s : DbquerydistributedRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_range_to_string(s : DbquerydistributedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerydistributedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_distributed_slice_make(size : Int) -> DbquerydistributedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_distributed_slice_len(s : DbquerydistributedSlice) -> Int { s.size }

pub fn db_query_distributed_slice_get(s : DbquerydistributedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_distributed_slice_set(s : DbquerydistributedSlice, i : Int, v : Double) -> DbquerydistributedSlice {
  let result = db_query_distributed_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_slice_sum(s : DbquerydistributedSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_distributed_slice_mean(s : DbquerydistributedSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_query_distributed_slice_sum(s) / s.size.to_double() }
}

pub fn db_query_distributed_slice_scale(s : DbquerydistributedSlice, f : Double) -> DbquerydistributedSlice {
  let result = db_query_distributed_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_distributed_slice_add(a : DbquerydistributedSlice, b : DbquerydistributedSlice) -> DbquerydistributedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_distributed_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_distributed_slice_copy(s : DbquerydistributedSlice) -> DbquerydistributedSlice {
  let result = db_query_distributed_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_distributed_slice_fill(s : DbquerydistributedSlice, v : Double) -> DbquerydistributedSlice {
  let result = db_query_distributed_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_distributed_slice_min(s : DbquerydistributedSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_slice_max(s : DbquerydistributedSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_distributed_slice_to_string(s : DbquerydistributedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

