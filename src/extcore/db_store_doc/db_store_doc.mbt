///===
/// extcore/db_store_doc

pub(all) struct DbstoredocPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_doc_make_point(x : Double, y : Double) -> DbstoredocPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_doc_make_point3(x : Double, y : Double, z : Double) -> DbstoredocPoint {
  { x, y, z, label: 0 }
}

pub fn db_store_doc_point_x(pt : DbstoredocPoint) -> Double { pt.x }

pub fn db_store_doc_point_y(pt : DbstoredocPoint) -> Double { pt.y }

pub fn db_store_doc_point_z(pt : DbstoredocPoint) -> Double { pt.z }

pub fn db_store_doc_point_label(pt : DbstoredocPoint) -> Int { pt.label }

pub fn db_store_doc_point_dist(a : DbstoredocPoint, b : DbstoredocPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_store_doc_point_add(a : DbstoredocPoint, b : DbstoredocPoint) -> DbstoredocPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_store_doc_point_sub(a : DbstoredocPoint, b : DbstoredocPoint) -> DbstoredocPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_store_doc_point_scale(pt : DbstoredocPoint, s : Double) -> DbstoredocPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_store_doc_point_dot(a : DbstoredocPoint, b : DbstoredocPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_store_doc_point_cross(a : DbstoredocPoint, b : DbstoredocPoint) -> DbstoredocPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_store_doc_point_norm(pt : DbstoredocPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_store_doc_point_normalize(pt : DbstoredocPoint) -> DbstoredocPoint {
  let n = db_store_doc_point_norm(pt)
  if n < 0.0000001 { pt } else { db_store_doc_point_scale(pt, 1.0 / n) }
}

pub fn db_store_doc_point_negate(pt : DbstoredocPoint) -> DbstoredocPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_store_doc_point_mid(a : DbstoredocPoint, b : DbstoredocPoint) -> DbstoredocPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_store_doc_point_lerp(a : DbstoredocPoint, b : DbstoredocPoint, t : Double) -> DbstoredocPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_store_doc_point_to_string(pt : DbstoredocPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbstoredocSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_doc_make_series(vals : Array[Double], name : String) -> DbstoredocSeries {
  { vals, name, meta: 0 }
}

pub fn db_store_doc_series_len(s : DbstoredocSeries) -> Int { s.vals.length() }

pub fn db_store_doc_series_sum(s : DbstoredocSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_store_doc_series_mean(s : DbstoredocSeries) -> Double {
  let n = db_store_doc_series_len(s)
  if n == 0 { 0.0 } else { db_store_doc_series_sum(s) / n.to_double() }
}

pub fn db_store_doc_series_min(s : DbstoredocSeries) -> Double {
  let n = db_store_doc_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_store_doc_series_max(s : DbstoredocSeries) -> Double {
  let n = db_store_doc_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_store_doc_series_range(s : DbstoredocSeries) -> Double {
  db_store_doc_series_max(s) - db_store_doc_series_min(s)
}

pub fn db_store_doc_series_var(s : DbstoredocSeries) -> Double {
  let n = db_store_doc_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_store_doc_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_store_doc_series_std(s : DbstoredocSeries) -> Double { @_common.sqrt(db_store_doc_series_var(s)) }

pub fn db_store_doc_series_median(s : DbstoredocSeries) -> Double {
  let n = db_store_doc_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_store_doc_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_store_doc_series_scale(s : DbstoredocSeries, f : Double) -> DbstoredocSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_store_doc_series_add(a : DbstoredocSeries, b : DbstoredocSeries) -> DbstoredocSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_store_doc_series_sub(a : DbstoredocSeries, b : DbstoredocSeries) -> DbstoredocSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_store_doc_series_normalize(s : DbstoredocSeries) -> DbstoredocSeries {
  let mn = db_store_doc_series_min(s)
  let mx = db_store_doc_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_store_doc_series_cumsum(s : DbstoredocSeries) -> DbstoredocSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_store_doc_series_to_string(s : DbstoredocSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstoredocMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_doc_make_matrix(rows : Int, cols : Int, val : Double) -> DbstoredocMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_doc_matrix_identity(n : Int) -> DbstoredocMatrix {
  let m = db_store_doc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_store_doc_matrix_get(m : DbstoredocMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_store_doc_matrix_transpose(m : DbstoredocMatrix) -> DbstoredocMatrix {
  let result = db_store_doc_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_store_doc_matrix_add(a : DbstoredocMatrix, b : DbstoredocMatrix) -> DbstoredocMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_store_doc_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_store_doc_matrix_scale(m : DbstoredocMatrix, s : Double) -> DbstoredocMatrix {
  let result = db_store_doc_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_store_doc_matrix_multiply(a : DbstoredocMatrix, b : DbstoredocMatrix) -> DbstoredocMatrix {
  if a.cols != b.rows { return db_store_doc_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_store_doc_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_store_doc_matrix_trace(m : DbstoredocMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_store_doc_matrix_det(m : DbstoredocMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_store_doc_matrix_norm(m : DbstoredocMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_store_doc_matrix_to_string(m : DbstoredocMatrix) -> String {
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

pub(all) struct DbstoredocVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_doc_make_vector(comps : Array[Double]) -> DbstoredocVector {
  { comps, dim: comps.length() }
}

pub fn db_store_doc_vector_zero(dim : Int) -> DbstoredocVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_store_doc_vector_add(a : DbstoredocVector, b : DbstoredocVector) -> DbstoredocVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_doc_vector_sub(a : DbstoredocVector, b : DbstoredocVector) -> DbstoredocVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_doc_vector_scale(v : DbstoredocVector, s : Double) -> DbstoredocVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_store_doc_vector_dot(a : DbstoredocVector, b : DbstoredocVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_store_doc_vector_norm(v : DbstoredocVector) -> Double { @_common.sqrt(db_store_doc_vector_dot(v, v)) }

pub fn db_store_doc_vector_normalize(v : DbstoredocVector) -> DbstoredocVector {
  let n = db_store_doc_vector_norm(v)
  if n < 0.0000001 { v } else { db_store_doc_vector_scale(v, 1.0 / n) }
}

pub fn db_store_doc_vector_dist(a : DbstoredocVector, b : DbstoredocVector) -> Double {
  db_store_doc_vector_norm(db_store_doc_vector_sub(a, b))
}

pub fn db_store_doc_vector_to_string(v : DbstoredocVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_doc_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_doc_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_doc_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_doc_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_doc_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_doc_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_doc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_doc_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_doc_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_doc_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_doc_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_doc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_doc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_doc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_doc_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_doc_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_doc_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_doc_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_doc_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_doc_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_doc_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_doc_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_doc_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_doc_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_doc_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_doc_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_doc_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_doc_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_doc_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstoredocFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_frame_make(size : Int) -> DbstoredocFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_frame_len(s : DbstoredocFrame) -> Int { s.size }

pub fn db_store_doc_frame_get(s : DbstoredocFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_frame_set(s : DbstoredocFrame, i : Int, v : Double) -> DbstoredocFrame {
  let result = db_store_doc_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_frame_sum(s : DbstoredocFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_doc_frame_mean(s : DbstoredocFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_store_doc_frame_sum(s) / s.size.to_double() }
}

pub fn db_store_doc_frame_scale(s : DbstoredocFrame, f : Double) -> DbstoredocFrame {
  let result = db_store_doc_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_doc_frame_add(a : DbstoredocFrame, b : DbstoredocFrame) -> DbstoredocFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_doc_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_doc_frame_copy(s : DbstoredocFrame) -> DbstoredocFrame {
  let result = db_store_doc_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_doc_frame_fill(s : DbstoredocFrame, v : Double) -> DbstoredocFrame {
  let result = db_store_doc_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_frame_min(s : DbstoredocFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_frame_max(s : DbstoredocFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_frame_to_string(s : DbstoredocFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_table_make(size : Int) -> DbstoredocTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_table_len(s : DbstoredocTable) -> Int { s.size }

pub fn db_store_doc_table_get(s : DbstoredocTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_table_set(s : DbstoredocTable, i : Int, v : Double) -> DbstoredocTable {
  let result = db_store_doc_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_table_sum(s : DbstoredocTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_doc_table_mean(s : DbstoredocTable) -> Double {
  if s.size == 0 { 0.0 } else { db_store_doc_table_sum(s) / s.size.to_double() }
}

pub fn db_store_doc_table_scale(s : DbstoredocTable, f : Double) -> DbstoredocTable {
  let result = db_store_doc_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_doc_table_add(a : DbstoredocTable, b : DbstoredocTable) -> DbstoredocTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_doc_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_doc_table_copy(s : DbstoredocTable) -> DbstoredocTable {
  let result = db_store_doc_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_doc_table_fill(s : DbstoredocTable, v : Double) -> DbstoredocTable {
  let result = db_store_doc_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_table_min(s : DbstoredocTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_table_max(s : DbstoredocTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_table_to_string(s : DbstoredocTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_graphn_make(size : Int) -> DbstoredocGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_graphn_len(s : DbstoredocGraphN) -> Int { s.size }

pub fn db_store_doc_graphn_get(s : DbstoredocGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_graphn_set(s : DbstoredocGraphN, i : Int, v : Double) -> DbstoredocGraphN {
  let result = db_store_doc_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_graphn_sum(s : DbstoredocGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_doc_graphn_mean(s : DbstoredocGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_store_doc_graphn_sum(s) / s.size.to_double() }
}

pub fn db_store_doc_graphn_scale(s : DbstoredocGraphN, f : Double) -> DbstoredocGraphN {
  let result = db_store_doc_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_doc_graphn_add(a : DbstoredocGraphN, b : DbstoredocGraphN) -> DbstoredocGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_doc_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_doc_graphn_copy(s : DbstoredocGraphN) -> DbstoredocGraphN {
  let result = db_store_doc_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_doc_graphn_fill(s : DbstoredocGraphN, v : Double) -> DbstoredocGraphN {
  let result = db_store_doc_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_graphn_min(s : DbstoredocGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_graphn_max(s : DbstoredocGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_graphn_to_string(s : DbstoredocGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_node_make(size : Int) -> DbstoredocNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_node_len(s : DbstoredocNode) -> Int { s.size }

pub fn db_store_doc_node_get(s : DbstoredocNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_node_set(s : DbstoredocNode, i : Int, v : Double) -> DbstoredocNode {
  let result = db_store_doc_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_node_sum(s : DbstoredocNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_doc_node_mean(s : DbstoredocNode) -> Double {
  if s.size == 0 { 0.0 } else { db_store_doc_node_sum(s) / s.size.to_double() }
}

pub fn db_store_doc_node_scale(s : DbstoredocNode, f : Double) -> DbstoredocNode {
  let result = db_store_doc_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_doc_node_add(a : DbstoredocNode, b : DbstoredocNode) -> DbstoredocNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_doc_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_doc_node_copy(s : DbstoredocNode) -> DbstoredocNode {
  let result = db_store_doc_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_doc_node_fill(s : DbstoredocNode, v : Double) -> DbstoredocNode {
  let result = db_store_doc_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_node_min(s : DbstoredocNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_node_max(s : DbstoredocNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_node_to_string(s : DbstoredocNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_edge_make(size : Int) -> DbstoredocEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_edge_len(s : DbstoredocEdge) -> Int { s.size }

pub fn db_store_doc_edge_get(s : DbstoredocEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_edge_set(s : DbstoredocEdge, i : Int, v : Double) -> DbstoredocEdge {
  let result = db_store_doc_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_edge_sum(s : DbstoredocEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_doc_edge_mean(s : DbstoredocEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_store_doc_edge_sum(s) / s.size.to_double() }
}

pub fn db_store_doc_edge_scale(s : DbstoredocEdge, f : Double) -> DbstoredocEdge {
  let result = db_store_doc_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_doc_edge_add(a : DbstoredocEdge, b : DbstoredocEdge) -> DbstoredocEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_doc_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_doc_edge_copy(s : DbstoredocEdge) -> DbstoredocEdge {
  let result = db_store_doc_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_doc_edge_fill(s : DbstoredocEdge, v : Double) -> DbstoredocEdge {
  let result = db_store_doc_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_edge_min(s : DbstoredocEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_edge_max(s : DbstoredocEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_edge_to_string(s : DbstoredocEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_path_make(size : Int) -> DbstoredocPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_path_len(s : DbstoredocPath) -> Int { s.size }

pub fn db_store_doc_path_get(s : DbstoredocPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_path_set(s : DbstoredocPath, i : Int, v : Double) -> DbstoredocPath {
  let result = db_store_doc_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_path_sum(s : DbstoredocPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_doc_path_mean(s : DbstoredocPath) -> Double {
  if s.size == 0 { 0.0 } else { db_store_doc_path_sum(s) / s.size.to_double() }
}

pub fn db_store_doc_path_scale(s : DbstoredocPath, f : Double) -> DbstoredocPath {
  let result = db_store_doc_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_doc_path_add(a : DbstoredocPath, b : DbstoredocPath) -> DbstoredocPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_doc_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_doc_path_copy(s : DbstoredocPath) -> DbstoredocPath {
  let result = db_store_doc_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_doc_path_fill(s : DbstoredocPath, v : Double) -> DbstoredocPath {
  let result = db_store_doc_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_path_min(s : DbstoredocPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_path_max(s : DbstoredocPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_path_to_string(s : DbstoredocPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_cluster_make(size : Int) -> DbstoredocCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_cluster_len(s : DbstoredocCluster) -> Int { s.size }

pub fn db_store_doc_cluster_get(s : DbstoredocCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_cluster_set(s : DbstoredocCluster, i : Int, v : Double) -> DbstoredocCluster {
  let result = db_store_doc_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_cluster_sum(s : DbstoredocCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_doc_cluster_mean(s : DbstoredocCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_store_doc_cluster_sum(s) / s.size.to_double() }
}

pub fn db_store_doc_cluster_scale(s : DbstoredocCluster, f : Double) -> DbstoredocCluster {
  let result = db_store_doc_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_doc_cluster_add(a : DbstoredocCluster, b : DbstoredocCluster) -> DbstoredocCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_doc_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_doc_cluster_copy(s : DbstoredocCluster) -> DbstoredocCluster {
  let result = db_store_doc_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_doc_cluster_fill(s : DbstoredocCluster, v : Double) -> DbstoredocCluster {
  let result = db_store_doc_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_cluster_min(s : DbstoredocCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_cluster_max(s : DbstoredocCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_cluster_to_string(s : DbstoredocCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_model_make(size : Int) -> DbstoredocModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_model_len(s : DbstoredocModel) -> Int { s.size }

pub fn db_store_doc_model_get(s : DbstoredocModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_model_set(s : DbstoredocModel, i : Int, v : Double) -> DbstoredocModel {
  let result = db_store_doc_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_model_sum(s : DbstoredocModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_doc_model_mean(s : DbstoredocModel) -> Double {
  if s.size == 0 { 0.0 } else { db_store_doc_model_sum(s) / s.size.to_double() }
}

pub fn db_store_doc_model_scale(s : DbstoredocModel, f : Double) -> DbstoredocModel {
  let result = db_store_doc_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_doc_model_add(a : DbstoredocModel, b : DbstoredocModel) -> DbstoredocModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_doc_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_doc_model_copy(s : DbstoredocModel) -> DbstoredocModel {
  let result = db_store_doc_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_doc_model_fill(s : DbstoredocModel, v : Double) -> DbstoredocModel {
  let result = db_store_doc_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_model_min(s : DbstoredocModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_model_max(s : DbstoredocModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_model_to_string(s : DbstoredocModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_layer_make(size : Int) -> DbstoredocLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_layer_len(s : DbstoredocLayer) -> Int { s.size }

pub fn db_store_doc_layer_get(s : DbstoredocLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_layer_set(s : DbstoredocLayer, i : Int, v : Double) -> DbstoredocLayer {
  let result = db_store_doc_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_layer_sum(s : DbstoredocLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_doc_layer_mean(s : DbstoredocLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_store_doc_layer_sum(s) / s.size.to_double() }
}

pub fn db_store_doc_layer_scale(s : DbstoredocLayer, f : Double) -> DbstoredocLayer {
  let result = db_store_doc_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_doc_layer_add(a : DbstoredocLayer, b : DbstoredocLayer) -> DbstoredocLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_doc_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_doc_layer_copy(s : DbstoredocLayer) -> DbstoredocLayer {
  let result = db_store_doc_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_doc_layer_fill(s : DbstoredocLayer, v : Double) -> DbstoredocLayer {
  let result = db_store_doc_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_layer_min(s : DbstoredocLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_layer_max(s : DbstoredocLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_layer_to_string(s : DbstoredocLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_buffer_make(size : Int) -> DbstoredocBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_buffer_len(s : DbstoredocBuffer) -> Int { s.size }

pub fn db_store_doc_buffer_get(s : DbstoredocBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_buffer_set(s : DbstoredocBuffer, i : Int, v : Double) -> DbstoredocBuffer {
  let result = db_store_doc_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_buffer_sum(s : DbstoredocBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_doc_buffer_mean(s : DbstoredocBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_store_doc_buffer_sum(s) / s.size.to_double() }
}

pub fn db_store_doc_buffer_scale(s : DbstoredocBuffer, f : Double) -> DbstoredocBuffer {
  let result = db_store_doc_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_doc_buffer_add(a : DbstoredocBuffer, b : DbstoredocBuffer) -> DbstoredocBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_doc_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_doc_buffer_copy(s : DbstoredocBuffer) -> DbstoredocBuffer {
  let result = db_store_doc_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_doc_buffer_fill(s : DbstoredocBuffer, v : Double) -> DbstoredocBuffer {
  let result = db_store_doc_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_buffer_min(s : DbstoredocBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_buffer_max(s : DbstoredocBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_buffer_to_string(s : DbstoredocBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_cursor_make(size : Int) -> DbstoredocCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_cursor_len(s : DbstoredocCursor) -> Int { s.size }

pub fn db_store_doc_cursor_get(s : DbstoredocCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_cursor_set(s : DbstoredocCursor, i : Int, v : Double) -> DbstoredocCursor {
  let result = db_store_doc_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_cursor_sum(s : DbstoredocCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_doc_cursor_mean(s : DbstoredocCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_store_doc_cursor_sum(s) / s.size.to_double() }
}

pub fn db_store_doc_cursor_scale(s : DbstoredocCursor, f : Double) -> DbstoredocCursor {
  let result = db_store_doc_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_doc_cursor_add(a : DbstoredocCursor, b : DbstoredocCursor) -> DbstoredocCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_doc_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_doc_cursor_copy(s : DbstoredocCursor) -> DbstoredocCursor {
  let result = db_store_doc_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_doc_cursor_fill(s : DbstoredocCursor, v : Double) -> DbstoredocCursor {
  let result = db_store_doc_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_cursor_min(s : DbstoredocCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_cursor_max(s : DbstoredocCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_cursor_to_string(s : DbstoredocCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_view_make(size : Int) -> DbstoredocView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_view_len(s : DbstoredocView) -> Int { s.size }

pub fn db_store_doc_view_get(s : DbstoredocView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_view_set(s : DbstoredocView, i : Int, v : Double) -> DbstoredocView {
  let result = db_store_doc_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_view_sum(s : DbstoredocView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_doc_view_mean(s : DbstoredocView) -> Double {
  if s.size == 0 { 0.0 } else { db_store_doc_view_sum(s) / s.size.to_double() }
}

pub fn db_store_doc_view_scale(s : DbstoredocView, f : Double) -> DbstoredocView {
  let result = db_store_doc_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_doc_view_add(a : DbstoredocView, b : DbstoredocView) -> DbstoredocView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_doc_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_doc_view_copy(s : DbstoredocView) -> DbstoredocView {
  let result = db_store_doc_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_doc_view_fill(s : DbstoredocView, v : Double) -> DbstoredocView {
  let result = db_store_doc_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_view_min(s : DbstoredocView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_view_max(s : DbstoredocView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_view_to_string(s : DbstoredocView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_range_make(size : Int) -> DbstoredocRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_range_len(s : DbstoredocRange) -> Int { s.size }

pub fn db_store_doc_range_get(s : DbstoredocRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_range_set(s : DbstoredocRange, i : Int, v : Double) -> DbstoredocRange {
  let result = db_store_doc_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_range_sum(s : DbstoredocRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_doc_range_mean(s : DbstoredocRange) -> Double {
  if s.size == 0 { 0.0 } else { db_store_doc_range_sum(s) / s.size.to_double() }
}

pub fn db_store_doc_range_scale(s : DbstoredocRange, f : Double) -> DbstoredocRange {
  let result = db_store_doc_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_doc_range_add(a : DbstoredocRange, b : DbstoredocRange) -> DbstoredocRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_doc_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_doc_range_copy(s : DbstoredocRange) -> DbstoredocRange {
  let result = db_store_doc_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_doc_range_fill(s : DbstoredocRange, v : Double) -> DbstoredocRange {
  let result = db_store_doc_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_range_min(s : DbstoredocRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_range_max(s : DbstoredocRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_range_to_string(s : DbstoredocRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_slice_make(size : Int) -> DbstoredocSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_slice_len(s : DbstoredocSlice) -> Int { s.size }

pub fn db_store_doc_slice_get(s : DbstoredocSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_slice_set(s : DbstoredocSlice, i : Int, v : Double) -> DbstoredocSlice {
  let result = db_store_doc_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_slice_sum(s : DbstoredocSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_doc_slice_mean(s : DbstoredocSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_store_doc_slice_sum(s) / s.size.to_double() }
}

pub fn db_store_doc_slice_scale(s : DbstoredocSlice, f : Double) -> DbstoredocSlice {
  let result = db_store_doc_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_doc_slice_add(a : DbstoredocSlice, b : DbstoredocSlice) -> DbstoredocSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_doc_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_doc_slice_copy(s : DbstoredocSlice) -> DbstoredocSlice {
  let result = db_store_doc_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_doc_slice_fill(s : DbstoredocSlice, v : Double) -> DbstoredocSlice {
  let result = db_store_doc_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_doc_slice_min(s : DbstoredocSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_slice_max(s : DbstoredocSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_doc_slice_to_string(s : DbstoredocSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

