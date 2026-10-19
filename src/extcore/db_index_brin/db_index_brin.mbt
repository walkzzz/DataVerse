///===
/// extcore/db_index_brin

pub(all) struct DbindexbrinPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_brin_make_point(x : Double, y : Double) -> DbindexbrinPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_brin_make_point3(x : Double, y : Double, z : Double) -> DbindexbrinPoint {
  { x, y, z, label: 0 }
}

pub fn db_index_brin_point_x(pt : DbindexbrinPoint) -> Double { pt.x }

pub fn db_index_brin_point_y(pt : DbindexbrinPoint) -> Double { pt.y }

pub fn db_index_brin_point_z(pt : DbindexbrinPoint) -> Double { pt.z }

pub fn db_index_brin_point_label(pt : DbindexbrinPoint) -> Int { pt.label }

pub fn db_index_brin_point_dist(a : DbindexbrinPoint, b : DbindexbrinPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_index_brin_point_add(a : DbindexbrinPoint, b : DbindexbrinPoint) -> DbindexbrinPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_index_brin_point_sub(a : DbindexbrinPoint, b : DbindexbrinPoint) -> DbindexbrinPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_index_brin_point_scale(pt : DbindexbrinPoint, s : Double) -> DbindexbrinPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_index_brin_point_dot(a : DbindexbrinPoint, b : DbindexbrinPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_index_brin_point_cross(a : DbindexbrinPoint, b : DbindexbrinPoint) -> DbindexbrinPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_index_brin_point_norm(pt : DbindexbrinPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_index_brin_point_normalize(pt : DbindexbrinPoint) -> DbindexbrinPoint {
  let n = db_index_brin_point_norm(pt)
  if n < 0.0000001 { pt } else { db_index_brin_point_scale(pt, 1.0 / n) }
}

pub fn db_index_brin_point_negate(pt : DbindexbrinPoint) -> DbindexbrinPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_index_brin_point_mid(a : DbindexbrinPoint, b : DbindexbrinPoint) -> DbindexbrinPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_index_brin_point_lerp(a : DbindexbrinPoint, b : DbindexbrinPoint, t : Double) -> DbindexbrinPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_index_brin_point_to_string(pt : DbindexbrinPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbindexbrinSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_brin_make_series(vals : Array[Double], name : String) -> DbindexbrinSeries {
  { vals, name, meta: 0 }
}

pub fn db_index_brin_series_len(s : DbindexbrinSeries) -> Int { s.vals.length() }

pub fn db_index_brin_series_sum(s : DbindexbrinSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_index_brin_series_mean(s : DbindexbrinSeries) -> Double {
  let n = db_index_brin_series_len(s)
  if n == 0 { 0.0 } else { db_index_brin_series_sum(s) / n.to_double() }
}

pub fn db_index_brin_series_min(s : DbindexbrinSeries) -> Double {
  let n = db_index_brin_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_index_brin_series_max(s : DbindexbrinSeries) -> Double {
  let n = db_index_brin_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_index_brin_series_range(s : DbindexbrinSeries) -> Double {
  db_index_brin_series_max(s) - db_index_brin_series_min(s)
}

pub fn db_index_brin_series_var(s : DbindexbrinSeries) -> Double {
  let n = db_index_brin_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_index_brin_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_index_brin_series_std(s : DbindexbrinSeries) -> Double { @_common.sqrt(db_index_brin_series_var(s)) }

pub fn db_index_brin_series_median(s : DbindexbrinSeries) -> Double {
  let n = db_index_brin_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_index_brin_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_index_brin_series_scale(s : DbindexbrinSeries, f : Double) -> DbindexbrinSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_index_brin_series_add(a : DbindexbrinSeries, b : DbindexbrinSeries) -> DbindexbrinSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_index_brin_series_sub(a : DbindexbrinSeries, b : DbindexbrinSeries) -> DbindexbrinSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_index_brin_series_normalize(s : DbindexbrinSeries) -> DbindexbrinSeries {
  let mn = db_index_brin_series_min(s)
  let mx = db_index_brin_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_index_brin_series_cumsum(s : DbindexbrinSeries) -> DbindexbrinSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_index_brin_series_to_string(s : DbindexbrinSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexbrinMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_brin_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexbrinMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_brin_matrix_identity(n : Int) -> DbindexbrinMatrix {
  let m = db_index_brin_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_index_brin_matrix_get(m : DbindexbrinMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_index_brin_matrix_transpose(m : DbindexbrinMatrix) -> DbindexbrinMatrix {
  let result = db_index_brin_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_index_brin_matrix_add(a : DbindexbrinMatrix, b : DbindexbrinMatrix) -> DbindexbrinMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_index_brin_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_index_brin_matrix_scale(m : DbindexbrinMatrix, s : Double) -> DbindexbrinMatrix {
  let result = db_index_brin_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_index_brin_matrix_multiply(a : DbindexbrinMatrix, b : DbindexbrinMatrix) -> DbindexbrinMatrix {
  if a.cols != b.rows { return db_index_brin_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_index_brin_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_index_brin_matrix_trace(m : DbindexbrinMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_index_brin_matrix_det(m : DbindexbrinMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_index_brin_matrix_norm(m : DbindexbrinMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_index_brin_matrix_to_string(m : DbindexbrinMatrix) -> String {
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

pub(all) struct DbindexbrinVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_brin_make_vector(comps : Array[Double]) -> DbindexbrinVector {
  { comps, dim: comps.length() }
}

pub fn db_index_brin_vector_zero(dim : Int) -> DbindexbrinVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_index_brin_vector_add(a : DbindexbrinVector, b : DbindexbrinVector) -> DbindexbrinVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_brin_vector_sub(a : DbindexbrinVector, b : DbindexbrinVector) -> DbindexbrinVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_brin_vector_scale(v : DbindexbrinVector, s : Double) -> DbindexbrinVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_index_brin_vector_dot(a : DbindexbrinVector, b : DbindexbrinVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_index_brin_vector_norm(v : DbindexbrinVector) -> Double { @_common.sqrt(db_index_brin_vector_dot(v, v)) }

pub fn db_index_brin_vector_normalize(v : DbindexbrinVector) -> DbindexbrinVector {
  let n = db_index_brin_vector_norm(v)
  if n < 0.0000001 { v } else { db_index_brin_vector_scale(v, 1.0 / n) }
}

pub fn db_index_brin_vector_dist(a : DbindexbrinVector, b : DbindexbrinVector) -> Double {
  db_index_brin_vector_norm(db_index_brin_vector_sub(a, b))
}

pub fn db_index_brin_vector_to_string(v : DbindexbrinVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_index_brin_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_index_brin_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_index_brin_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_index_brin_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_index_brin_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_index_brin_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_index_brin_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_index_brin_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_index_brin_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_index_brin_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_index_brin_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_index_brin_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_index_brin_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_index_brin_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_index_brin_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_index_brin_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_index_brin_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_index_brin_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_index_brin_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_index_brin_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_index_brin_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_index_brin_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_index_brin_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_index_brin_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_index_brin_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_index_brin_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_index_brin_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_index_brin_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_index_brin_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbindexbrinFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_frame_make(size : Int) -> DbindexbrinFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_frame_len(s : DbindexbrinFrame) -> Int { s.size }

pub fn db_index_brin_frame_get(s : DbindexbrinFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_frame_set(s : DbindexbrinFrame, i : Int, v : Double) -> DbindexbrinFrame {
  let result = db_index_brin_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_frame_sum(s : DbindexbrinFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_brin_frame_mean(s : DbindexbrinFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_index_brin_frame_sum(s) / s.size.to_double() }
}

pub fn db_index_brin_frame_scale(s : DbindexbrinFrame, f : Double) -> DbindexbrinFrame {
  let result = db_index_brin_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_brin_frame_add(a : DbindexbrinFrame, b : DbindexbrinFrame) -> DbindexbrinFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_brin_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_brin_frame_copy(s : DbindexbrinFrame) -> DbindexbrinFrame {
  let result = db_index_brin_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_brin_frame_fill(s : DbindexbrinFrame, v : Double) -> DbindexbrinFrame {
  let result = db_index_brin_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_frame_min(s : DbindexbrinFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_frame_max(s : DbindexbrinFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_frame_to_string(s : DbindexbrinFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_table_make(size : Int) -> DbindexbrinTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_table_len(s : DbindexbrinTable) -> Int { s.size }

pub fn db_index_brin_table_get(s : DbindexbrinTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_table_set(s : DbindexbrinTable, i : Int, v : Double) -> DbindexbrinTable {
  let result = db_index_brin_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_table_sum(s : DbindexbrinTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_brin_table_mean(s : DbindexbrinTable) -> Double {
  if s.size == 0 { 0.0 } else { db_index_brin_table_sum(s) / s.size.to_double() }
}

pub fn db_index_brin_table_scale(s : DbindexbrinTable, f : Double) -> DbindexbrinTable {
  let result = db_index_brin_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_brin_table_add(a : DbindexbrinTable, b : DbindexbrinTable) -> DbindexbrinTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_brin_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_brin_table_copy(s : DbindexbrinTable) -> DbindexbrinTable {
  let result = db_index_brin_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_brin_table_fill(s : DbindexbrinTable, v : Double) -> DbindexbrinTable {
  let result = db_index_brin_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_table_min(s : DbindexbrinTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_table_max(s : DbindexbrinTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_table_to_string(s : DbindexbrinTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_graphn_make(size : Int) -> DbindexbrinGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_graphn_len(s : DbindexbrinGraphN) -> Int { s.size }

pub fn db_index_brin_graphn_get(s : DbindexbrinGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_graphn_set(s : DbindexbrinGraphN, i : Int, v : Double) -> DbindexbrinGraphN {
  let result = db_index_brin_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_graphn_sum(s : DbindexbrinGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_brin_graphn_mean(s : DbindexbrinGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_index_brin_graphn_sum(s) / s.size.to_double() }
}

pub fn db_index_brin_graphn_scale(s : DbindexbrinGraphN, f : Double) -> DbindexbrinGraphN {
  let result = db_index_brin_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_brin_graphn_add(a : DbindexbrinGraphN, b : DbindexbrinGraphN) -> DbindexbrinGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_brin_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_brin_graphn_copy(s : DbindexbrinGraphN) -> DbindexbrinGraphN {
  let result = db_index_brin_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_brin_graphn_fill(s : DbindexbrinGraphN, v : Double) -> DbindexbrinGraphN {
  let result = db_index_brin_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_graphn_min(s : DbindexbrinGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_graphn_max(s : DbindexbrinGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_graphn_to_string(s : DbindexbrinGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_node_make(size : Int) -> DbindexbrinNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_node_len(s : DbindexbrinNode) -> Int { s.size }

pub fn db_index_brin_node_get(s : DbindexbrinNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_node_set(s : DbindexbrinNode, i : Int, v : Double) -> DbindexbrinNode {
  let result = db_index_brin_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_node_sum(s : DbindexbrinNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_brin_node_mean(s : DbindexbrinNode) -> Double {
  if s.size == 0 { 0.0 } else { db_index_brin_node_sum(s) / s.size.to_double() }
}

pub fn db_index_brin_node_scale(s : DbindexbrinNode, f : Double) -> DbindexbrinNode {
  let result = db_index_brin_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_brin_node_add(a : DbindexbrinNode, b : DbindexbrinNode) -> DbindexbrinNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_brin_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_brin_node_copy(s : DbindexbrinNode) -> DbindexbrinNode {
  let result = db_index_brin_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_brin_node_fill(s : DbindexbrinNode, v : Double) -> DbindexbrinNode {
  let result = db_index_brin_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_node_min(s : DbindexbrinNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_node_max(s : DbindexbrinNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_node_to_string(s : DbindexbrinNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_edge_make(size : Int) -> DbindexbrinEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_edge_len(s : DbindexbrinEdge) -> Int { s.size }

pub fn db_index_brin_edge_get(s : DbindexbrinEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_edge_set(s : DbindexbrinEdge, i : Int, v : Double) -> DbindexbrinEdge {
  let result = db_index_brin_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_edge_sum(s : DbindexbrinEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_brin_edge_mean(s : DbindexbrinEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_index_brin_edge_sum(s) / s.size.to_double() }
}

pub fn db_index_brin_edge_scale(s : DbindexbrinEdge, f : Double) -> DbindexbrinEdge {
  let result = db_index_brin_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_brin_edge_add(a : DbindexbrinEdge, b : DbindexbrinEdge) -> DbindexbrinEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_brin_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_brin_edge_copy(s : DbindexbrinEdge) -> DbindexbrinEdge {
  let result = db_index_brin_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_brin_edge_fill(s : DbindexbrinEdge, v : Double) -> DbindexbrinEdge {
  let result = db_index_brin_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_edge_min(s : DbindexbrinEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_edge_max(s : DbindexbrinEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_edge_to_string(s : DbindexbrinEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_path_make(size : Int) -> DbindexbrinPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_path_len(s : DbindexbrinPath) -> Int { s.size }

pub fn db_index_brin_path_get(s : DbindexbrinPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_path_set(s : DbindexbrinPath, i : Int, v : Double) -> DbindexbrinPath {
  let result = db_index_brin_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_path_sum(s : DbindexbrinPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_brin_path_mean(s : DbindexbrinPath) -> Double {
  if s.size == 0 { 0.0 } else { db_index_brin_path_sum(s) / s.size.to_double() }
}

pub fn db_index_brin_path_scale(s : DbindexbrinPath, f : Double) -> DbindexbrinPath {
  let result = db_index_brin_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_brin_path_add(a : DbindexbrinPath, b : DbindexbrinPath) -> DbindexbrinPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_brin_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_brin_path_copy(s : DbindexbrinPath) -> DbindexbrinPath {
  let result = db_index_brin_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_brin_path_fill(s : DbindexbrinPath, v : Double) -> DbindexbrinPath {
  let result = db_index_brin_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_path_min(s : DbindexbrinPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_path_max(s : DbindexbrinPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_path_to_string(s : DbindexbrinPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_cluster_make(size : Int) -> DbindexbrinCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_cluster_len(s : DbindexbrinCluster) -> Int { s.size }

pub fn db_index_brin_cluster_get(s : DbindexbrinCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_cluster_set(s : DbindexbrinCluster, i : Int, v : Double) -> DbindexbrinCluster {
  let result = db_index_brin_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_cluster_sum(s : DbindexbrinCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_brin_cluster_mean(s : DbindexbrinCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_index_brin_cluster_sum(s) / s.size.to_double() }
}

pub fn db_index_brin_cluster_scale(s : DbindexbrinCluster, f : Double) -> DbindexbrinCluster {
  let result = db_index_brin_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_brin_cluster_add(a : DbindexbrinCluster, b : DbindexbrinCluster) -> DbindexbrinCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_brin_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_brin_cluster_copy(s : DbindexbrinCluster) -> DbindexbrinCluster {
  let result = db_index_brin_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_brin_cluster_fill(s : DbindexbrinCluster, v : Double) -> DbindexbrinCluster {
  let result = db_index_brin_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_cluster_min(s : DbindexbrinCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_cluster_max(s : DbindexbrinCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_cluster_to_string(s : DbindexbrinCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_model_make(size : Int) -> DbindexbrinModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_model_len(s : DbindexbrinModel) -> Int { s.size }

pub fn db_index_brin_model_get(s : DbindexbrinModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_model_set(s : DbindexbrinModel, i : Int, v : Double) -> DbindexbrinModel {
  let result = db_index_brin_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_model_sum(s : DbindexbrinModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_brin_model_mean(s : DbindexbrinModel) -> Double {
  if s.size == 0 { 0.0 } else { db_index_brin_model_sum(s) / s.size.to_double() }
}

pub fn db_index_brin_model_scale(s : DbindexbrinModel, f : Double) -> DbindexbrinModel {
  let result = db_index_brin_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_brin_model_add(a : DbindexbrinModel, b : DbindexbrinModel) -> DbindexbrinModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_brin_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_brin_model_copy(s : DbindexbrinModel) -> DbindexbrinModel {
  let result = db_index_brin_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_brin_model_fill(s : DbindexbrinModel, v : Double) -> DbindexbrinModel {
  let result = db_index_brin_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_model_min(s : DbindexbrinModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_model_max(s : DbindexbrinModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_model_to_string(s : DbindexbrinModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_layer_make(size : Int) -> DbindexbrinLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_layer_len(s : DbindexbrinLayer) -> Int { s.size }

pub fn db_index_brin_layer_get(s : DbindexbrinLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_layer_set(s : DbindexbrinLayer, i : Int, v : Double) -> DbindexbrinLayer {
  let result = db_index_brin_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_layer_sum(s : DbindexbrinLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_brin_layer_mean(s : DbindexbrinLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_index_brin_layer_sum(s) / s.size.to_double() }
}

pub fn db_index_brin_layer_scale(s : DbindexbrinLayer, f : Double) -> DbindexbrinLayer {
  let result = db_index_brin_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_brin_layer_add(a : DbindexbrinLayer, b : DbindexbrinLayer) -> DbindexbrinLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_brin_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_brin_layer_copy(s : DbindexbrinLayer) -> DbindexbrinLayer {
  let result = db_index_brin_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_brin_layer_fill(s : DbindexbrinLayer, v : Double) -> DbindexbrinLayer {
  let result = db_index_brin_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_layer_min(s : DbindexbrinLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_layer_max(s : DbindexbrinLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_layer_to_string(s : DbindexbrinLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_buffer_make(size : Int) -> DbindexbrinBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_buffer_len(s : DbindexbrinBuffer) -> Int { s.size }

pub fn db_index_brin_buffer_get(s : DbindexbrinBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_buffer_set(s : DbindexbrinBuffer, i : Int, v : Double) -> DbindexbrinBuffer {
  let result = db_index_brin_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_buffer_sum(s : DbindexbrinBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_brin_buffer_mean(s : DbindexbrinBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_index_brin_buffer_sum(s) / s.size.to_double() }
}

pub fn db_index_brin_buffer_scale(s : DbindexbrinBuffer, f : Double) -> DbindexbrinBuffer {
  let result = db_index_brin_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_brin_buffer_add(a : DbindexbrinBuffer, b : DbindexbrinBuffer) -> DbindexbrinBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_brin_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_brin_buffer_copy(s : DbindexbrinBuffer) -> DbindexbrinBuffer {
  let result = db_index_brin_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_brin_buffer_fill(s : DbindexbrinBuffer, v : Double) -> DbindexbrinBuffer {
  let result = db_index_brin_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_buffer_min(s : DbindexbrinBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_buffer_max(s : DbindexbrinBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_buffer_to_string(s : DbindexbrinBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_cursor_make(size : Int) -> DbindexbrinCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_cursor_len(s : DbindexbrinCursor) -> Int { s.size }

pub fn db_index_brin_cursor_get(s : DbindexbrinCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_cursor_set(s : DbindexbrinCursor, i : Int, v : Double) -> DbindexbrinCursor {
  let result = db_index_brin_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_cursor_sum(s : DbindexbrinCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_brin_cursor_mean(s : DbindexbrinCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_index_brin_cursor_sum(s) / s.size.to_double() }
}

pub fn db_index_brin_cursor_scale(s : DbindexbrinCursor, f : Double) -> DbindexbrinCursor {
  let result = db_index_brin_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_brin_cursor_add(a : DbindexbrinCursor, b : DbindexbrinCursor) -> DbindexbrinCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_brin_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_brin_cursor_copy(s : DbindexbrinCursor) -> DbindexbrinCursor {
  let result = db_index_brin_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_brin_cursor_fill(s : DbindexbrinCursor, v : Double) -> DbindexbrinCursor {
  let result = db_index_brin_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_cursor_min(s : DbindexbrinCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_cursor_max(s : DbindexbrinCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_cursor_to_string(s : DbindexbrinCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_view_make(size : Int) -> DbindexbrinView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_view_len(s : DbindexbrinView) -> Int { s.size }

pub fn db_index_brin_view_get(s : DbindexbrinView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_view_set(s : DbindexbrinView, i : Int, v : Double) -> DbindexbrinView {
  let result = db_index_brin_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_view_sum(s : DbindexbrinView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_brin_view_mean(s : DbindexbrinView) -> Double {
  if s.size == 0 { 0.0 } else { db_index_brin_view_sum(s) / s.size.to_double() }
}

pub fn db_index_brin_view_scale(s : DbindexbrinView, f : Double) -> DbindexbrinView {
  let result = db_index_brin_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_brin_view_add(a : DbindexbrinView, b : DbindexbrinView) -> DbindexbrinView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_brin_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_brin_view_copy(s : DbindexbrinView) -> DbindexbrinView {
  let result = db_index_brin_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_brin_view_fill(s : DbindexbrinView, v : Double) -> DbindexbrinView {
  let result = db_index_brin_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_view_min(s : DbindexbrinView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_view_max(s : DbindexbrinView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_view_to_string(s : DbindexbrinView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_range_make(size : Int) -> DbindexbrinRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_range_len(s : DbindexbrinRange) -> Int { s.size }

pub fn db_index_brin_range_get(s : DbindexbrinRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_range_set(s : DbindexbrinRange, i : Int, v : Double) -> DbindexbrinRange {
  let result = db_index_brin_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_range_sum(s : DbindexbrinRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_brin_range_mean(s : DbindexbrinRange) -> Double {
  if s.size == 0 { 0.0 } else { db_index_brin_range_sum(s) / s.size.to_double() }
}

pub fn db_index_brin_range_scale(s : DbindexbrinRange, f : Double) -> DbindexbrinRange {
  let result = db_index_brin_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_brin_range_add(a : DbindexbrinRange, b : DbindexbrinRange) -> DbindexbrinRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_brin_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_brin_range_copy(s : DbindexbrinRange) -> DbindexbrinRange {
  let result = db_index_brin_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_brin_range_fill(s : DbindexbrinRange, v : Double) -> DbindexbrinRange {
  let result = db_index_brin_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_range_min(s : DbindexbrinRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_range_max(s : DbindexbrinRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_range_to_string(s : DbindexbrinRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_slice_make(size : Int) -> DbindexbrinSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_slice_len(s : DbindexbrinSlice) -> Int { s.size }

pub fn db_index_brin_slice_get(s : DbindexbrinSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_slice_set(s : DbindexbrinSlice, i : Int, v : Double) -> DbindexbrinSlice {
  let result = db_index_brin_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_slice_sum(s : DbindexbrinSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_brin_slice_mean(s : DbindexbrinSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_index_brin_slice_sum(s) / s.size.to_double() }
}

pub fn db_index_brin_slice_scale(s : DbindexbrinSlice, f : Double) -> DbindexbrinSlice {
  let result = db_index_brin_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_brin_slice_add(a : DbindexbrinSlice, b : DbindexbrinSlice) -> DbindexbrinSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_brin_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_brin_slice_copy(s : DbindexbrinSlice) -> DbindexbrinSlice {
  let result = db_index_brin_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_brin_slice_fill(s : DbindexbrinSlice, v : Double) -> DbindexbrinSlice {
  let result = db_index_brin_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_brin_slice_min(s : DbindexbrinSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_slice_max(s : DbindexbrinSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_brin_slice_to_string(s : DbindexbrinSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

