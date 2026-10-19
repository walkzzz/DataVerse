///===
/// extcore/db_store_series

pub(all) struct DbstoreseriesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_series_make_point(x : Double, y : Double) -> DbstoreseriesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_series_make_point3(x : Double, y : Double, z : Double) -> DbstoreseriesPoint {
  { x, y, z, label: 0 }
}

pub fn db_store_series_point_x(pt : DbstoreseriesPoint) -> Double { pt.x }

pub fn db_store_series_point_y(pt : DbstoreseriesPoint) -> Double { pt.y }

pub fn db_store_series_point_z(pt : DbstoreseriesPoint) -> Double { pt.z }

pub fn db_store_series_point_label(pt : DbstoreseriesPoint) -> Int { pt.label }

pub fn db_store_series_point_dist(a : DbstoreseriesPoint, b : DbstoreseriesPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_store_series_point_add(a : DbstoreseriesPoint, b : DbstoreseriesPoint) -> DbstoreseriesPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_store_series_point_sub(a : DbstoreseriesPoint, b : DbstoreseriesPoint) -> DbstoreseriesPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_store_series_point_scale(pt : DbstoreseriesPoint, s : Double) -> DbstoreseriesPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_store_series_point_dot(a : DbstoreseriesPoint, b : DbstoreseriesPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_store_series_point_cross(a : DbstoreseriesPoint, b : DbstoreseriesPoint) -> DbstoreseriesPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_store_series_point_norm(pt : DbstoreseriesPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_store_series_point_normalize(pt : DbstoreseriesPoint) -> DbstoreseriesPoint {
  let n = db_store_series_point_norm(pt)
  if n < 0.0000001 { pt } else { db_store_series_point_scale(pt, 1.0 / n) }
}

pub fn db_store_series_point_negate(pt : DbstoreseriesPoint) -> DbstoreseriesPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_store_series_point_mid(a : DbstoreseriesPoint, b : DbstoreseriesPoint) -> DbstoreseriesPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_store_series_point_lerp(a : DbstoreseriesPoint, b : DbstoreseriesPoint, t : Double) -> DbstoreseriesPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_store_series_point_to_string(pt : DbstoreseriesPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbstoreseriesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_series_make_series(vals : Array[Double], name : String) -> DbstoreseriesSeries {
  { vals, name, meta: 0 }
}

pub fn db_store_series_series_len(s : DbstoreseriesSeries) -> Int { s.vals.length() }

pub fn db_store_series_series_sum(s : DbstoreseriesSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_store_series_series_mean(s : DbstoreseriesSeries) -> Double {
  let n = db_store_series_series_len(s)
  if n == 0 { 0.0 } else { db_store_series_series_sum(s) / n.to_double() }
}

pub fn db_store_series_series_min(s : DbstoreseriesSeries) -> Double {
  let n = db_store_series_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_store_series_series_max(s : DbstoreseriesSeries) -> Double {
  let n = db_store_series_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_store_series_series_range(s : DbstoreseriesSeries) -> Double {
  db_store_series_series_max(s) - db_store_series_series_min(s)
}

pub fn db_store_series_series_var(s : DbstoreseriesSeries) -> Double {
  let n = db_store_series_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_store_series_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_store_series_series_std(s : DbstoreseriesSeries) -> Double { @_common.sqrt(db_store_series_series_var(s)) }

pub fn db_store_series_series_median(s : DbstoreseriesSeries) -> Double {
  let n = db_store_series_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_store_series_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_store_series_series_scale(s : DbstoreseriesSeries, f : Double) -> DbstoreseriesSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_store_series_series_add(a : DbstoreseriesSeries, b : DbstoreseriesSeries) -> DbstoreseriesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_store_series_series_sub(a : DbstoreseriesSeries, b : DbstoreseriesSeries) -> DbstoreseriesSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_store_series_series_normalize(s : DbstoreseriesSeries) -> DbstoreseriesSeries {
  let mn = db_store_series_series_min(s)
  let mx = db_store_series_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_store_series_series_cumsum(s : DbstoreseriesSeries) -> DbstoreseriesSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_store_series_series_to_string(s : DbstoreseriesSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstoreseriesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_series_make_matrix(rows : Int, cols : Int, val : Double) -> DbstoreseriesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_series_matrix_identity(n : Int) -> DbstoreseriesMatrix {
  let m = db_store_series_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_store_series_matrix_get(m : DbstoreseriesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_store_series_matrix_transpose(m : DbstoreseriesMatrix) -> DbstoreseriesMatrix {
  let result = db_store_series_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_store_series_matrix_add(a : DbstoreseriesMatrix, b : DbstoreseriesMatrix) -> DbstoreseriesMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_store_series_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_store_series_matrix_scale(m : DbstoreseriesMatrix, s : Double) -> DbstoreseriesMatrix {
  let result = db_store_series_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_store_series_matrix_multiply(a : DbstoreseriesMatrix, b : DbstoreseriesMatrix) -> DbstoreseriesMatrix {
  if a.cols != b.rows { return db_store_series_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_store_series_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_store_series_matrix_trace(m : DbstoreseriesMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_store_series_matrix_det(m : DbstoreseriesMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_store_series_matrix_norm(m : DbstoreseriesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_store_series_matrix_to_string(m : DbstoreseriesMatrix) -> String {
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

pub(all) struct DbstoreseriesVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_series_make_vector(comps : Array[Double]) -> DbstoreseriesVector {
  { comps, dim: comps.length() }
}

pub fn db_store_series_vector_zero(dim : Int) -> DbstoreseriesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_store_series_vector_add(a : DbstoreseriesVector, b : DbstoreseriesVector) -> DbstoreseriesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_series_vector_sub(a : DbstoreseriesVector, b : DbstoreseriesVector) -> DbstoreseriesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_series_vector_scale(v : DbstoreseriesVector, s : Double) -> DbstoreseriesVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_store_series_vector_dot(a : DbstoreseriesVector, b : DbstoreseriesVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_store_series_vector_norm(v : DbstoreseriesVector) -> Double { @_common.sqrt(db_store_series_vector_dot(v, v)) }

pub fn db_store_series_vector_normalize(v : DbstoreseriesVector) -> DbstoreseriesVector {
  let n = db_store_series_vector_norm(v)
  if n < 0.0000001 { v } else { db_store_series_vector_scale(v, 1.0 / n) }
}

pub fn db_store_series_vector_dist(a : DbstoreseriesVector, b : DbstoreseriesVector) -> Double {
  db_store_series_vector_norm(db_store_series_vector_sub(a, b))
}

pub fn db_store_series_vector_to_string(v : DbstoreseriesVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_series_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_series_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_series_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_series_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_series_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_series_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_series_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_series_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_series_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_series_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_series_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_series_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_series_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_series_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_series_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_series_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_series_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_series_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_series_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_series_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_series_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_series_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_series_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_series_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_series_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_series_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_series_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_series_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_series_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstoreseriesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_frame_make(size : Int) -> DbstoreseriesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_frame_len(s : DbstoreseriesFrame) -> Int { s.size }

pub fn db_store_series_frame_get(s : DbstoreseriesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_frame_set(s : DbstoreseriesFrame, i : Int, v : Double) -> DbstoreseriesFrame {
  let result = db_store_series_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_series_frame_sum(s : DbstoreseriesFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_series_frame_mean(s : DbstoreseriesFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_store_series_frame_sum(s) / s.size.to_double() }
}

pub fn db_store_series_frame_scale(s : DbstoreseriesFrame, f : Double) -> DbstoreseriesFrame {
  let result = db_store_series_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_series_frame_add(a : DbstoreseriesFrame, b : DbstoreseriesFrame) -> DbstoreseriesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_series_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_series_frame_copy(s : DbstoreseriesFrame) -> DbstoreseriesFrame {
  let result = db_store_series_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_series_frame_fill(s : DbstoreseriesFrame, v : Double) -> DbstoreseriesFrame {
  let result = db_store_series_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_series_frame_min(s : DbstoreseriesFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_frame_max(s : DbstoreseriesFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_frame_to_string(s : DbstoreseriesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_table_make(size : Int) -> DbstoreseriesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_table_len(s : DbstoreseriesTable) -> Int { s.size }

pub fn db_store_series_table_get(s : DbstoreseriesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_table_set(s : DbstoreseriesTable, i : Int, v : Double) -> DbstoreseriesTable {
  let result = db_store_series_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_series_table_sum(s : DbstoreseriesTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_series_table_mean(s : DbstoreseriesTable) -> Double {
  if s.size == 0 { 0.0 } else { db_store_series_table_sum(s) / s.size.to_double() }
}

pub fn db_store_series_table_scale(s : DbstoreseriesTable, f : Double) -> DbstoreseriesTable {
  let result = db_store_series_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_series_table_add(a : DbstoreseriesTable, b : DbstoreseriesTable) -> DbstoreseriesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_series_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_series_table_copy(s : DbstoreseriesTable) -> DbstoreseriesTable {
  let result = db_store_series_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_series_table_fill(s : DbstoreseriesTable, v : Double) -> DbstoreseriesTable {
  let result = db_store_series_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_series_table_min(s : DbstoreseriesTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_table_max(s : DbstoreseriesTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_table_to_string(s : DbstoreseriesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_graphn_make(size : Int) -> DbstoreseriesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_graphn_len(s : DbstoreseriesGraphN) -> Int { s.size }

pub fn db_store_series_graphn_get(s : DbstoreseriesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_graphn_set(s : DbstoreseriesGraphN, i : Int, v : Double) -> DbstoreseriesGraphN {
  let result = db_store_series_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_series_graphn_sum(s : DbstoreseriesGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_series_graphn_mean(s : DbstoreseriesGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_store_series_graphn_sum(s) / s.size.to_double() }
}

pub fn db_store_series_graphn_scale(s : DbstoreseriesGraphN, f : Double) -> DbstoreseriesGraphN {
  let result = db_store_series_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_series_graphn_add(a : DbstoreseriesGraphN, b : DbstoreseriesGraphN) -> DbstoreseriesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_series_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_series_graphn_copy(s : DbstoreseriesGraphN) -> DbstoreseriesGraphN {
  let result = db_store_series_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_series_graphn_fill(s : DbstoreseriesGraphN, v : Double) -> DbstoreseriesGraphN {
  let result = db_store_series_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_series_graphn_min(s : DbstoreseriesGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_graphn_max(s : DbstoreseriesGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_graphn_to_string(s : DbstoreseriesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_node_make(size : Int) -> DbstoreseriesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_node_len(s : DbstoreseriesNode) -> Int { s.size }

pub fn db_store_series_node_get(s : DbstoreseriesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_node_set(s : DbstoreseriesNode, i : Int, v : Double) -> DbstoreseriesNode {
  let result = db_store_series_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_series_node_sum(s : DbstoreseriesNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_series_node_mean(s : DbstoreseriesNode) -> Double {
  if s.size == 0 { 0.0 } else { db_store_series_node_sum(s) / s.size.to_double() }
}

pub fn db_store_series_node_scale(s : DbstoreseriesNode, f : Double) -> DbstoreseriesNode {
  let result = db_store_series_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_series_node_add(a : DbstoreseriesNode, b : DbstoreseriesNode) -> DbstoreseriesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_series_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_series_node_copy(s : DbstoreseriesNode) -> DbstoreseriesNode {
  let result = db_store_series_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_series_node_fill(s : DbstoreseriesNode, v : Double) -> DbstoreseriesNode {
  let result = db_store_series_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_series_node_min(s : DbstoreseriesNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_node_max(s : DbstoreseriesNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_node_to_string(s : DbstoreseriesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_edge_make(size : Int) -> DbstoreseriesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_edge_len(s : DbstoreseriesEdge) -> Int { s.size }

pub fn db_store_series_edge_get(s : DbstoreseriesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_edge_set(s : DbstoreseriesEdge, i : Int, v : Double) -> DbstoreseriesEdge {
  let result = db_store_series_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_series_edge_sum(s : DbstoreseriesEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_series_edge_mean(s : DbstoreseriesEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_store_series_edge_sum(s) / s.size.to_double() }
}

pub fn db_store_series_edge_scale(s : DbstoreseriesEdge, f : Double) -> DbstoreseriesEdge {
  let result = db_store_series_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_series_edge_add(a : DbstoreseriesEdge, b : DbstoreseriesEdge) -> DbstoreseriesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_series_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_series_edge_copy(s : DbstoreseriesEdge) -> DbstoreseriesEdge {
  let result = db_store_series_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_series_edge_fill(s : DbstoreseriesEdge, v : Double) -> DbstoreseriesEdge {
  let result = db_store_series_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_series_edge_min(s : DbstoreseriesEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_edge_max(s : DbstoreseriesEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_edge_to_string(s : DbstoreseriesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_path_make(size : Int) -> DbstoreseriesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_path_len(s : DbstoreseriesPath) -> Int { s.size }

pub fn db_store_series_path_get(s : DbstoreseriesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_path_set(s : DbstoreseriesPath, i : Int, v : Double) -> DbstoreseriesPath {
  let result = db_store_series_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_series_path_sum(s : DbstoreseriesPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_series_path_mean(s : DbstoreseriesPath) -> Double {
  if s.size == 0 { 0.0 } else { db_store_series_path_sum(s) / s.size.to_double() }
}

pub fn db_store_series_path_scale(s : DbstoreseriesPath, f : Double) -> DbstoreseriesPath {
  let result = db_store_series_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_series_path_add(a : DbstoreseriesPath, b : DbstoreseriesPath) -> DbstoreseriesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_series_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_series_path_copy(s : DbstoreseriesPath) -> DbstoreseriesPath {
  let result = db_store_series_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_series_path_fill(s : DbstoreseriesPath, v : Double) -> DbstoreseriesPath {
  let result = db_store_series_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_series_path_min(s : DbstoreseriesPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_path_max(s : DbstoreseriesPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_path_to_string(s : DbstoreseriesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_cluster_make(size : Int) -> DbstoreseriesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_cluster_len(s : DbstoreseriesCluster) -> Int { s.size }

pub fn db_store_series_cluster_get(s : DbstoreseriesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_cluster_set(s : DbstoreseriesCluster, i : Int, v : Double) -> DbstoreseriesCluster {
  let result = db_store_series_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_series_cluster_sum(s : DbstoreseriesCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_series_cluster_mean(s : DbstoreseriesCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_store_series_cluster_sum(s) / s.size.to_double() }
}

pub fn db_store_series_cluster_scale(s : DbstoreseriesCluster, f : Double) -> DbstoreseriesCluster {
  let result = db_store_series_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_series_cluster_add(a : DbstoreseriesCluster, b : DbstoreseriesCluster) -> DbstoreseriesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_series_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_series_cluster_copy(s : DbstoreseriesCluster) -> DbstoreseriesCluster {
  let result = db_store_series_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_series_cluster_fill(s : DbstoreseriesCluster, v : Double) -> DbstoreseriesCluster {
  let result = db_store_series_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_series_cluster_min(s : DbstoreseriesCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_cluster_max(s : DbstoreseriesCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_cluster_to_string(s : DbstoreseriesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_model_make(size : Int) -> DbstoreseriesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_model_len(s : DbstoreseriesModel) -> Int { s.size }

pub fn db_store_series_model_get(s : DbstoreseriesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_model_set(s : DbstoreseriesModel, i : Int, v : Double) -> DbstoreseriesModel {
  let result = db_store_series_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_series_model_sum(s : DbstoreseriesModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_series_model_mean(s : DbstoreseriesModel) -> Double {
  if s.size == 0 { 0.0 } else { db_store_series_model_sum(s) / s.size.to_double() }
}

pub fn db_store_series_model_scale(s : DbstoreseriesModel, f : Double) -> DbstoreseriesModel {
  let result = db_store_series_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_series_model_add(a : DbstoreseriesModel, b : DbstoreseriesModel) -> DbstoreseriesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_series_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_series_model_copy(s : DbstoreseriesModel) -> DbstoreseriesModel {
  let result = db_store_series_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_series_model_fill(s : DbstoreseriesModel, v : Double) -> DbstoreseriesModel {
  let result = db_store_series_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_series_model_min(s : DbstoreseriesModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_model_max(s : DbstoreseriesModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_model_to_string(s : DbstoreseriesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_layer_make(size : Int) -> DbstoreseriesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_layer_len(s : DbstoreseriesLayer) -> Int { s.size }

pub fn db_store_series_layer_get(s : DbstoreseriesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_layer_set(s : DbstoreseriesLayer, i : Int, v : Double) -> DbstoreseriesLayer {
  let result = db_store_series_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_series_layer_sum(s : DbstoreseriesLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_series_layer_mean(s : DbstoreseriesLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_store_series_layer_sum(s) / s.size.to_double() }
}

pub fn db_store_series_layer_scale(s : DbstoreseriesLayer, f : Double) -> DbstoreseriesLayer {
  let result = db_store_series_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_series_layer_add(a : DbstoreseriesLayer, b : DbstoreseriesLayer) -> DbstoreseriesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_series_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_series_layer_copy(s : DbstoreseriesLayer) -> DbstoreseriesLayer {
  let result = db_store_series_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_series_layer_fill(s : DbstoreseriesLayer, v : Double) -> DbstoreseriesLayer {
  let result = db_store_series_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_series_layer_min(s : DbstoreseriesLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_layer_max(s : DbstoreseriesLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_layer_to_string(s : DbstoreseriesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_buffer_make(size : Int) -> DbstoreseriesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_buffer_len(s : DbstoreseriesBuffer) -> Int { s.size }

pub fn db_store_series_buffer_get(s : DbstoreseriesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_buffer_set(s : DbstoreseriesBuffer, i : Int, v : Double) -> DbstoreseriesBuffer {
  let result = db_store_series_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_series_buffer_sum(s : DbstoreseriesBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_series_buffer_mean(s : DbstoreseriesBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_store_series_buffer_sum(s) / s.size.to_double() }
}

pub fn db_store_series_buffer_scale(s : DbstoreseriesBuffer, f : Double) -> DbstoreseriesBuffer {
  let result = db_store_series_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_series_buffer_add(a : DbstoreseriesBuffer, b : DbstoreseriesBuffer) -> DbstoreseriesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_series_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_series_buffer_copy(s : DbstoreseriesBuffer) -> DbstoreseriesBuffer {
  let result = db_store_series_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_series_buffer_fill(s : DbstoreseriesBuffer, v : Double) -> DbstoreseriesBuffer {
  let result = db_store_series_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_series_buffer_min(s : DbstoreseriesBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_buffer_max(s : DbstoreseriesBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_buffer_to_string(s : DbstoreseriesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_cursor_make(size : Int) -> DbstoreseriesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_cursor_len(s : DbstoreseriesCursor) -> Int { s.size }

pub fn db_store_series_cursor_get(s : DbstoreseriesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_cursor_set(s : DbstoreseriesCursor, i : Int, v : Double) -> DbstoreseriesCursor {
  let result = db_store_series_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_series_cursor_sum(s : DbstoreseriesCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_series_cursor_mean(s : DbstoreseriesCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_store_series_cursor_sum(s) / s.size.to_double() }
}

pub fn db_store_series_cursor_scale(s : DbstoreseriesCursor, f : Double) -> DbstoreseriesCursor {
  let result = db_store_series_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_series_cursor_add(a : DbstoreseriesCursor, b : DbstoreseriesCursor) -> DbstoreseriesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_series_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_series_cursor_copy(s : DbstoreseriesCursor) -> DbstoreseriesCursor {
  let result = db_store_series_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_series_cursor_fill(s : DbstoreseriesCursor, v : Double) -> DbstoreseriesCursor {
  let result = db_store_series_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_series_cursor_min(s : DbstoreseriesCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_cursor_max(s : DbstoreseriesCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_cursor_to_string(s : DbstoreseriesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_view_make(size : Int) -> DbstoreseriesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_view_len(s : DbstoreseriesView) -> Int { s.size }

pub fn db_store_series_view_get(s : DbstoreseriesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_view_set(s : DbstoreseriesView, i : Int, v : Double) -> DbstoreseriesView {
  let result = db_store_series_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_series_view_sum(s : DbstoreseriesView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_series_view_mean(s : DbstoreseriesView) -> Double {
  if s.size == 0 { 0.0 } else { db_store_series_view_sum(s) / s.size.to_double() }
}

pub fn db_store_series_view_scale(s : DbstoreseriesView, f : Double) -> DbstoreseriesView {
  let result = db_store_series_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_series_view_add(a : DbstoreseriesView, b : DbstoreseriesView) -> DbstoreseriesView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_series_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_series_view_copy(s : DbstoreseriesView) -> DbstoreseriesView {
  let result = db_store_series_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_series_view_fill(s : DbstoreseriesView, v : Double) -> DbstoreseriesView {
  let result = db_store_series_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_series_view_min(s : DbstoreseriesView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_view_max(s : DbstoreseriesView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_view_to_string(s : DbstoreseriesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_range_make(size : Int) -> DbstoreseriesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_range_len(s : DbstoreseriesRange) -> Int { s.size }

pub fn db_store_series_range_get(s : DbstoreseriesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_range_set(s : DbstoreseriesRange, i : Int, v : Double) -> DbstoreseriesRange {
  let result = db_store_series_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_series_range_sum(s : DbstoreseriesRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_series_range_mean(s : DbstoreseriesRange) -> Double {
  if s.size == 0 { 0.0 } else { db_store_series_range_sum(s) / s.size.to_double() }
}

pub fn db_store_series_range_scale(s : DbstoreseriesRange, f : Double) -> DbstoreseriesRange {
  let result = db_store_series_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_series_range_add(a : DbstoreseriesRange, b : DbstoreseriesRange) -> DbstoreseriesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_series_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_series_range_copy(s : DbstoreseriesRange) -> DbstoreseriesRange {
  let result = db_store_series_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_series_range_fill(s : DbstoreseriesRange, v : Double) -> DbstoreseriesRange {
  let result = db_store_series_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_series_range_min(s : DbstoreseriesRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_range_max(s : DbstoreseriesRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_range_to_string(s : DbstoreseriesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoreseriesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_series_slice_make(size : Int) -> DbstoreseriesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_series_slice_len(s : DbstoreseriesSlice) -> Int { s.size }

pub fn db_store_series_slice_get(s : DbstoreseriesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_series_slice_set(s : DbstoreseriesSlice, i : Int, v : Double) -> DbstoreseriesSlice {
  let result = db_store_series_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_series_slice_sum(s : DbstoreseriesSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_series_slice_mean(s : DbstoreseriesSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_store_series_slice_sum(s) / s.size.to_double() }
}

pub fn db_store_series_slice_scale(s : DbstoreseriesSlice, f : Double) -> DbstoreseriesSlice {
  let result = db_store_series_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_series_slice_add(a : DbstoreseriesSlice, b : DbstoreseriesSlice) -> DbstoreseriesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_series_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_series_slice_copy(s : DbstoreseriesSlice) -> DbstoreseriesSlice {
  let result = db_store_series_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_series_slice_fill(s : DbstoreseriesSlice, v : Double) -> DbstoreseriesSlice {
  let result = db_store_series_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_series_slice_min(s : DbstoreseriesSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_slice_max(s : DbstoreseriesSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_series_slice_to_string(s : DbstoreseriesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

