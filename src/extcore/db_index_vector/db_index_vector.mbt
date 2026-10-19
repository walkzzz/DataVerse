///===
/// extcore/db_index_vector

pub(all) struct DbindexvectorPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_vector_make_point(x : Double, y : Double) -> DbindexvectorPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_vector_make_point3(x : Double, y : Double, z : Double) -> DbindexvectorPoint {
  { x, y, z, label: 0 }
}

pub fn db_index_vector_point_x(pt : DbindexvectorPoint) -> Double { pt.x }

pub fn db_index_vector_point_y(pt : DbindexvectorPoint) -> Double { pt.y }

pub fn db_index_vector_point_z(pt : DbindexvectorPoint) -> Double { pt.z }

pub fn db_index_vector_point_label(pt : DbindexvectorPoint) -> Int { pt.label }

pub fn db_index_vector_point_dist(a : DbindexvectorPoint, b : DbindexvectorPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_index_vector_point_add(a : DbindexvectorPoint, b : DbindexvectorPoint) -> DbindexvectorPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_index_vector_point_sub(a : DbindexvectorPoint, b : DbindexvectorPoint) -> DbindexvectorPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_index_vector_point_scale(pt : DbindexvectorPoint, s : Double) -> DbindexvectorPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_index_vector_point_dot(a : DbindexvectorPoint, b : DbindexvectorPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_index_vector_point_cross(a : DbindexvectorPoint, b : DbindexvectorPoint) -> DbindexvectorPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_index_vector_point_norm(pt : DbindexvectorPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_index_vector_point_normalize(pt : DbindexvectorPoint) -> DbindexvectorPoint {
  let n = db_index_vector_point_norm(pt)
  if n < 0.0000001 { pt } else { db_index_vector_point_scale(pt, 1.0 / n) }
}

pub fn db_index_vector_point_negate(pt : DbindexvectorPoint) -> DbindexvectorPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_index_vector_point_mid(a : DbindexvectorPoint, b : DbindexvectorPoint) -> DbindexvectorPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_index_vector_point_lerp(a : DbindexvectorPoint, b : DbindexvectorPoint, t : Double) -> DbindexvectorPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_index_vector_point_to_string(pt : DbindexvectorPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbindexvectorSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_vector_make_series(vals : Array[Double], name : String) -> DbindexvectorSeries {
  { vals, name, meta: 0 }
}

pub fn db_index_vector_series_len(s : DbindexvectorSeries) -> Int { s.vals.length() }

pub fn db_index_vector_series_sum(s : DbindexvectorSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_index_vector_series_mean(s : DbindexvectorSeries) -> Double {
  let n = db_index_vector_series_len(s)
  if n == 0 { 0.0 } else { db_index_vector_series_sum(s) / n.to_double() }
}

pub fn db_index_vector_series_min(s : DbindexvectorSeries) -> Double {
  let n = db_index_vector_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_index_vector_series_max(s : DbindexvectorSeries) -> Double {
  let n = db_index_vector_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_index_vector_series_range(s : DbindexvectorSeries) -> Double {
  db_index_vector_series_max(s) - db_index_vector_series_min(s)
}

pub fn db_index_vector_series_var(s : DbindexvectorSeries) -> Double {
  let n = db_index_vector_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_index_vector_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_index_vector_series_std(s : DbindexvectorSeries) -> Double { @_common.sqrt(db_index_vector_series_var(s)) }

pub fn db_index_vector_series_median(s : DbindexvectorSeries) -> Double {
  let n = db_index_vector_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_index_vector_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_index_vector_series_scale(s : DbindexvectorSeries, f : Double) -> DbindexvectorSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_index_vector_series_add(a : DbindexvectorSeries, b : DbindexvectorSeries) -> DbindexvectorSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_index_vector_series_sub(a : DbindexvectorSeries, b : DbindexvectorSeries) -> DbindexvectorSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_index_vector_series_normalize(s : DbindexvectorSeries) -> DbindexvectorSeries {
  let mn = db_index_vector_series_min(s)
  let mx = db_index_vector_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_index_vector_series_cumsum(s : DbindexvectorSeries) -> DbindexvectorSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_index_vector_series_to_string(s : DbindexvectorSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexvectorMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_vector_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexvectorMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_vector_matrix_identity(n : Int) -> DbindexvectorMatrix {
  let m = db_index_vector_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_index_vector_matrix_get(m : DbindexvectorMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_index_vector_matrix_transpose(m : DbindexvectorMatrix) -> DbindexvectorMatrix {
  let result = db_index_vector_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_index_vector_matrix_add(a : DbindexvectorMatrix, b : DbindexvectorMatrix) -> DbindexvectorMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_index_vector_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_index_vector_matrix_scale(m : DbindexvectorMatrix, s : Double) -> DbindexvectorMatrix {
  let result = db_index_vector_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_index_vector_matrix_multiply(a : DbindexvectorMatrix, b : DbindexvectorMatrix) -> DbindexvectorMatrix {
  if a.cols != b.rows { return db_index_vector_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_index_vector_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_index_vector_matrix_trace(m : DbindexvectorMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_index_vector_matrix_det(m : DbindexvectorMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_index_vector_matrix_norm(m : DbindexvectorMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_index_vector_matrix_to_string(m : DbindexvectorMatrix) -> String {
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

pub(all) struct DbindexvectorVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_vector_make_vector(comps : Array[Double]) -> DbindexvectorVector {
  { comps, dim: comps.length() }
}

pub fn db_index_vector_vector_zero(dim : Int) -> DbindexvectorVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_index_vector_vector_add(a : DbindexvectorVector, b : DbindexvectorVector) -> DbindexvectorVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_vector_vector_sub(a : DbindexvectorVector, b : DbindexvectorVector) -> DbindexvectorVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_vector_vector_scale(v : DbindexvectorVector, s : Double) -> DbindexvectorVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_index_vector_vector_dot(a : DbindexvectorVector, b : DbindexvectorVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_index_vector_vector_norm(v : DbindexvectorVector) -> Double { @_common.sqrt(db_index_vector_vector_dot(v, v)) }

pub fn db_index_vector_vector_normalize(v : DbindexvectorVector) -> DbindexvectorVector {
  let n = db_index_vector_vector_norm(v)
  if n < 0.0000001 { v } else { db_index_vector_vector_scale(v, 1.0 / n) }
}

pub fn db_index_vector_vector_dist(a : DbindexvectorVector, b : DbindexvectorVector) -> Double {
  db_index_vector_vector_norm(db_index_vector_vector_sub(a, b))
}

pub fn db_index_vector_vector_to_string(v : DbindexvectorVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_index_vector_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_index_vector_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_index_vector_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_index_vector_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_index_vector_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_index_vector_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_index_vector_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_index_vector_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_index_vector_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_index_vector_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_index_vector_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_index_vector_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_index_vector_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_index_vector_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_index_vector_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_index_vector_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_index_vector_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_index_vector_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_index_vector_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_index_vector_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_index_vector_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_index_vector_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_index_vector_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_index_vector_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_index_vector_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_index_vector_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_index_vector_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_index_vector_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_index_vector_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbindexvectorFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_frame_make(size : Int) -> DbindexvectorFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_frame_len(s : DbindexvectorFrame) -> Int { s.size }

pub fn db_index_vector_frame_get(s : DbindexvectorFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_frame_set(s : DbindexvectorFrame, i : Int, v : Double) -> DbindexvectorFrame {
  let result = db_index_vector_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_frame_sum(s : DbindexvectorFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_vector_frame_mean(s : DbindexvectorFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_index_vector_frame_sum(s) / s.size.to_double() }
}

pub fn db_index_vector_frame_scale(s : DbindexvectorFrame, f : Double) -> DbindexvectorFrame {
  let result = db_index_vector_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_vector_frame_add(a : DbindexvectorFrame, b : DbindexvectorFrame) -> DbindexvectorFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_vector_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_vector_frame_copy(s : DbindexvectorFrame) -> DbindexvectorFrame {
  let result = db_index_vector_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_vector_frame_fill(s : DbindexvectorFrame, v : Double) -> DbindexvectorFrame {
  let result = db_index_vector_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_frame_min(s : DbindexvectorFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_frame_max(s : DbindexvectorFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_frame_to_string(s : DbindexvectorFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_table_make(size : Int) -> DbindexvectorTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_table_len(s : DbindexvectorTable) -> Int { s.size }

pub fn db_index_vector_table_get(s : DbindexvectorTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_table_set(s : DbindexvectorTable, i : Int, v : Double) -> DbindexvectorTable {
  let result = db_index_vector_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_table_sum(s : DbindexvectorTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_vector_table_mean(s : DbindexvectorTable) -> Double {
  if s.size == 0 { 0.0 } else { db_index_vector_table_sum(s) / s.size.to_double() }
}

pub fn db_index_vector_table_scale(s : DbindexvectorTable, f : Double) -> DbindexvectorTable {
  let result = db_index_vector_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_vector_table_add(a : DbindexvectorTable, b : DbindexvectorTable) -> DbindexvectorTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_vector_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_vector_table_copy(s : DbindexvectorTable) -> DbindexvectorTable {
  let result = db_index_vector_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_vector_table_fill(s : DbindexvectorTable, v : Double) -> DbindexvectorTable {
  let result = db_index_vector_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_table_min(s : DbindexvectorTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_table_max(s : DbindexvectorTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_table_to_string(s : DbindexvectorTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_graphn_make(size : Int) -> DbindexvectorGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_graphn_len(s : DbindexvectorGraphN) -> Int { s.size }

pub fn db_index_vector_graphn_get(s : DbindexvectorGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_graphn_set(s : DbindexvectorGraphN, i : Int, v : Double) -> DbindexvectorGraphN {
  let result = db_index_vector_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_graphn_sum(s : DbindexvectorGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_vector_graphn_mean(s : DbindexvectorGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_index_vector_graphn_sum(s) / s.size.to_double() }
}

pub fn db_index_vector_graphn_scale(s : DbindexvectorGraphN, f : Double) -> DbindexvectorGraphN {
  let result = db_index_vector_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_vector_graphn_add(a : DbindexvectorGraphN, b : DbindexvectorGraphN) -> DbindexvectorGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_vector_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_vector_graphn_copy(s : DbindexvectorGraphN) -> DbindexvectorGraphN {
  let result = db_index_vector_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_vector_graphn_fill(s : DbindexvectorGraphN, v : Double) -> DbindexvectorGraphN {
  let result = db_index_vector_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_graphn_min(s : DbindexvectorGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_graphn_max(s : DbindexvectorGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_graphn_to_string(s : DbindexvectorGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_node_make(size : Int) -> DbindexvectorNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_node_len(s : DbindexvectorNode) -> Int { s.size }

pub fn db_index_vector_node_get(s : DbindexvectorNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_node_set(s : DbindexvectorNode, i : Int, v : Double) -> DbindexvectorNode {
  let result = db_index_vector_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_node_sum(s : DbindexvectorNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_vector_node_mean(s : DbindexvectorNode) -> Double {
  if s.size == 0 { 0.0 } else { db_index_vector_node_sum(s) / s.size.to_double() }
}

pub fn db_index_vector_node_scale(s : DbindexvectorNode, f : Double) -> DbindexvectorNode {
  let result = db_index_vector_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_vector_node_add(a : DbindexvectorNode, b : DbindexvectorNode) -> DbindexvectorNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_vector_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_vector_node_copy(s : DbindexvectorNode) -> DbindexvectorNode {
  let result = db_index_vector_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_vector_node_fill(s : DbindexvectorNode, v : Double) -> DbindexvectorNode {
  let result = db_index_vector_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_node_min(s : DbindexvectorNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_node_max(s : DbindexvectorNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_node_to_string(s : DbindexvectorNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_edge_make(size : Int) -> DbindexvectorEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_edge_len(s : DbindexvectorEdge) -> Int { s.size }

pub fn db_index_vector_edge_get(s : DbindexvectorEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_edge_set(s : DbindexvectorEdge, i : Int, v : Double) -> DbindexvectorEdge {
  let result = db_index_vector_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_edge_sum(s : DbindexvectorEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_vector_edge_mean(s : DbindexvectorEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_index_vector_edge_sum(s) / s.size.to_double() }
}

pub fn db_index_vector_edge_scale(s : DbindexvectorEdge, f : Double) -> DbindexvectorEdge {
  let result = db_index_vector_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_vector_edge_add(a : DbindexvectorEdge, b : DbindexvectorEdge) -> DbindexvectorEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_vector_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_vector_edge_copy(s : DbindexvectorEdge) -> DbindexvectorEdge {
  let result = db_index_vector_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_vector_edge_fill(s : DbindexvectorEdge, v : Double) -> DbindexvectorEdge {
  let result = db_index_vector_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_edge_min(s : DbindexvectorEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_edge_max(s : DbindexvectorEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_edge_to_string(s : DbindexvectorEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_path_make(size : Int) -> DbindexvectorPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_path_len(s : DbindexvectorPath) -> Int { s.size }

pub fn db_index_vector_path_get(s : DbindexvectorPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_path_set(s : DbindexvectorPath, i : Int, v : Double) -> DbindexvectorPath {
  let result = db_index_vector_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_path_sum(s : DbindexvectorPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_vector_path_mean(s : DbindexvectorPath) -> Double {
  if s.size == 0 { 0.0 } else { db_index_vector_path_sum(s) / s.size.to_double() }
}

pub fn db_index_vector_path_scale(s : DbindexvectorPath, f : Double) -> DbindexvectorPath {
  let result = db_index_vector_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_vector_path_add(a : DbindexvectorPath, b : DbindexvectorPath) -> DbindexvectorPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_vector_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_vector_path_copy(s : DbindexvectorPath) -> DbindexvectorPath {
  let result = db_index_vector_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_vector_path_fill(s : DbindexvectorPath, v : Double) -> DbindexvectorPath {
  let result = db_index_vector_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_path_min(s : DbindexvectorPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_path_max(s : DbindexvectorPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_path_to_string(s : DbindexvectorPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_cluster_make(size : Int) -> DbindexvectorCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_cluster_len(s : DbindexvectorCluster) -> Int { s.size }

pub fn db_index_vector_cluster_get(s : DbindexvectorCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_cluster_set(s : DbindexvectorCluster, i : Int, v : Double) -> DbindexvectorCluster {
  let result = db_index_vector_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_cluster_sum(s : DbindexvectorCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_vector_cluster_mean(s : DbindexvectorCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_index_vector_cluster_sum(s) / s.size.to_double() }
}

pub fn db_index_vector_cluster_scale(s : DbindexvectorCluster, f : Double) -> DbindexvectorCluster {
  let result = db_index_vector_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_vector_cluster_add(a : DbindexvectorCluster, b : DbindexvectorCluster) -> DbindexvectorCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_vector_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_vector_cluster_copy(s : DbindexvectorCluster) -> DbindexvectorCluster {
  let result = db_index_vector_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_vector_cluster_fill(s : DbindexvectorCluster, v : Double) -> DbindexvectorCluster {
  let result = db_index_vector_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_cluster_min(s : DbindexvectorCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_cluster_max(s : DbindexvectorCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_cluster_to_string(s : DbindexvectorCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_model_make(size : Int) -> DbindexvectorModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_model_len(s : DbindexvectorModel) -> Int { s.size }

pub fn db_index_vector_model_get(s : DbindexvectorModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_model_set(s : DbindexvectorModel, i : Int, v : Double) -> DbindexvectorModel {
  let result = db_index_vector_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_model_sum(s : DbindexvectorModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_vector_model_mean(s : DbindexvectorModel) -> Double {
  if s.size == 0 { 0.0 } else { db_index_vector_model_sum(s) / s.size.to_double() }
}

pub fn db_index_vector_model_scale(s : DbindexvectorModel, f : Double) -> DbindexvectorModel {
  let result = db_index_vector_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_vector_model_add(a : DbindexvectorModel, b : DbindexvectorModel) -> DbindexvectorModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_vector_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_vector_model_copy(s : DbindexvectorModel) -> DbindexvectorModel {
  let result = db_index_vector_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_vector_model_fill(s : DbindexvectorModel, v : Double) -> DbindexvectorModel {
  let result = db_index_vector_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_model_min(s : DbindexvectorModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_model_max(s : DbindexvectorModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_model_to_string(s : DbindexvectorModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_layer_make(size : Int) -> DbindexvectorLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_layer_len(s : DbindexvectorLayer) -> Int { s.size }

pub fn db_index_vector_layer_get(s : DbindexvectorLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_layer_set(s : DbindexvectorLayer, i : Int, v : Double) -> DbindexvectorLayer {
  let result = db_index_vector_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_layer_sum(s : DbindexvectorLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_vector_layer_mean(s : DbindexvectorLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_index_vector_layer_sum(s) / s.size.to_double() }
}

pub fn db_index_vector_layer_scale(s : DbindexvectorLayer, f : Double) -> DbindexvectorLayer {
  let result = db_index_vector_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_vector_layer_add(a : DbindexvectorLayer, b : DbindexvectorLayer) -> DbindexvectorLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_vector_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_vector_layer_copy(s : DbindexvectorLayer) -> DbindexvectorLayer {
  let result = db_index_vector_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_vector_layer_fill(s : DbindexvectorLayer, v : Double) -> DbindexvectorLayer {
  let result = db_index_vector_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_layer_min(s : DbindexvectorLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_layer_max(s : DbindexvectorLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_layer_to_string(s : DbindexvectorLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_buffer_make(size : Int) -> DbindexvectorBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_buffer_len(s : DbindexvectorBuffer) -> Int { s.size }

pub fn db_index_vector_buffer_get(s : DbindexvectorBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_buffer_set(s : DbindexvectorBuffer, i : Int, v : Double) -> DbindexvectorBuffer {
  let result = db_index_vector_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_buffer_sum(s : DbindexvectorBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_vector_buffer_mean(s : DbindexvectorBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_index_vector_buffer_sum(s) / s.size.to_double() }
}

pub fn db_index_vector_buffer_scale(s : DbindexvectorBuffer, f : Double) -> DbindexvectorBuffer {
  let result = db_index_vector_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_vector_buffer_add(a : DbindexvectorBuffer, b : DbindexvectorBuffer) -> DbindexvectorBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_vector_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_vector_buffer_copy(s : DbindexvectorBuffer) -> DbindexvectorBuffer {
  let result = db_index_vector_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_vector_buffer_fill(s : DbindexvectorBuffer, v : Double) -> DbindexvectorBuffer {
  let result = db_index_vector_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_buffer_min(s : DbindexvectorBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_buffer_max(s : DbindexvectorBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_buffer_to_string(s : DbindexvectorBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_cursor_make(size : Int) -> DbindexvectorCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_cursor_len(s : DbindexvectorCursor) -> Int { s.size }

pub fn db_index_vector_cursor_get(s : DbindexvectorCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_cursor_set(s : DbindexvectorCursor, i : Int, v : Double) -> DbindexvectorCursor {
  let result = db_index_vector_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_cursor_sum(s : DbindexvectorCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_vector_cursor_mean(s : DbindexvectorCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_index_vector_cursor_sum(s) / s.size.to_double() }
}

pub fn db_index_vector_cursor_scale(s : DbindexvectorCursor, f : Double) -> DbindexvectorCursor {
  let result = db_index_vector_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_vector_cursor_add(a : DbindexvectorCursor, b : DbindexvectorCursor) -> DbindexvectorCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_vector_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_vector_cursor_copy(s : DbindexvectorCursor) -> DbindexvectorCursor {
  let result = db_index_vector_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_vector_cursor_fill(s : DbindexvectorCursor, v : Double) -> DbindexvectorCursor {
  let result = db_index_vector_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_cursor_min(s : DbindexvectorCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_cursor_max(s : DbindexvectorCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_cursor_to_string(s : DbindexvectorCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_view_make(size : Int) -> DbindexvectorView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_view_len(s : DbindexvectorView) -> Int { s.size }

pub fn db_index_vector_view_get(s : DbindexvectorView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_view_set(s : DbindexvectorView, i : Int, v : Double) -> DbindexvectorView {
  let result = db_index_vector_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_view_sum(s : DbindexvectorView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_vector_view_mean(s : DbindexvectorView) -> Double {
  if s.size == 0 { 0.0 } else { db_index_vector_view_sum(s) / s.size.to_double() }
}

pub fn db_index_vector_view_scale(s : DbindexvectorView, f : Double) -> DbindexvectorView {
  let result = db_index_vector_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_vector_view_add(a : DbindexvectorView, b : DbindexvectorView) -> DbindexvectorView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_vector_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_vector_view_copy(s : DbindexvectorView) -> DbindexvectorView {
  let result = db_index_vector_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_vector_view_fill(s : DbindexvectorView, v : Double) -> DbindexvectorView {
  let result = db_index_vector_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_view_min(s : DbindexvectorView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_view_max(s : DbindexvectorView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_view_to_string(s : DbindexvectorView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_range_make(size : Int) -> DbindexvectorRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_range_len(s : DbindexvectorRange) -> Int { s.size }

pub fn db_index_vector_range_get(s : DbindexvectorRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_range_set(s : DbindexvectorRange, i : Int, v : Double) -> DbindexvectorRange {
  let result = db_index_vector_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_range_sum(s : DbindexvectorRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_vector_range_mean(s : DbindexvectorRange) -> Double {
  if s.size == 0 { 0.0 } else { db_index_vector_range_sum(s) / s.size.to_double() }
}

pub fn db_index_vector_range_scale(s : DbindexvectorRange, f : Double) -> DbindexvectorRange {
  let result = db_index_vector_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_vector_range_add(a : DbindexvectorRange, b : DbindexvectorRange) -> DbindexvectorRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_vector_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_vector_range_copy(s : DbindexvectorRange) -> DbindexvectorRange {
  let result = db_index_vector_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_vector_range_fill(s : DbindexvectorRange, v : Double) -> DbindexvectorRange {
  let result = db_index_vector_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_range_min(s : DbindexvectorRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_range_max(s : DbindexvectorRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_range_to_string(s : DbindexvectorRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexvectorSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_vector_slice_make(size : Int) -> DbindexvectorSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_vector_slice_len(s : DbindexvectorSlice) -> Int { s.size }

pub fn db_index_vector_slice_get(s : DbindexvectorSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_vector_slice_set(s : DbindexvectorSlice, i : Int, v : Double) -> DbindexvectorSlice {
  let result = db_index_vector_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_slice_sum(s : DbindexvectorSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_vector_slice_mean(s : DbindexvectorSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_index_vector_slice_sum(s) / s.size.to_double() }
}

pub fn db_index_vector_slice_scale(s : DbindexvectorSlice, f : Double) -> DbindexvectorSlice {
  let result = db_index_vector_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_vector_slice_add(a : DbindexvectorSlice, b : DbindexvectorSlice) -> DbindexvectorSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_vector_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_vector_slice_copy(s : DbindexvectorSlice) -> DbindexvectorSlice {
  let result = db_index_vector_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_vector_slice_fill(s : DbindexvectorSlice, v : Double) -> DbindexvectorSlice {
  let result = db_index_vector_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_vector_slice_min(s : DbindexvectorSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_slice_max(s : DbindexvectorSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_vector_slice_to_string(s : DbindexvectorSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

