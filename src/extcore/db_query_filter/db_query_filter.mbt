///===
/// extcore/db_query_filter

pub(all) struct DbqueryfilterPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_filter_make_point(x : Double, y : Double) -> DbqueryfilterPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_filter_make_point3(x : Double, y : Double, z : Double) -> DbqueryfilterPoint {
  { x, y, z, label: 0 }
}

pub fn db_query_filter_point_x(pt : DbqueryfilterPoint) -> Double { pt.x }

pub fn db_query_filter_point_y(pt : DbqueryfilterPoint) -> Double { pt.y }

pub fn db_query_filter_point_z(pt : DbqueryfilterPoint) -> Double { pt.z }

pub fn db_query_filter_point_label(pt : DbqueryfilterPoint) -> Int { pt.label }

pub fn db_query_filter_point_dist(a : DbqueryfilterPoint, b : DbqueryfilterPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_query_filter_point_add(a : DbqueryfilterPoint, b : DbqueryfilterPoint) -> DbqueryfilterPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_query_filter_point_sub(a : DbqueryfilterPoint, b : DbqueryfilterPoint) -> DbqueryfilterPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_query_filter_point_scale(pt : DbqueryfilterPoint, s : Double) -> DbqueryfilterPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_query_filter_point_dot(a : DbqueryfilterPoint, b : DbqueryfilterPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_query_filter_point_cross(a : DbqueryfilterPoint, b : DbqueryfilterPoint) -> DbqueryfilterPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_query_filter_point_norm(pt : DbqueryfilterPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_query_filter_point_normalize(pt : DbqueryfilterPoint) -> DbqueryfilterPoint {
  let n = db_query_filter_point_norm(pt)
  if n < 0.0000001 { pt } else { db_query_filter_point_scale(pt, 1.0 / n) }
}

pub fn db_query_filter_point_negate(pt : DbqueryfilterPoint) -> DbqueryfilterPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_query_filter_point_mid(a : DbqueryfilterPoint, b : DbqueryfilterPoint) -> DbqueryfilterPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_query_filter_point_lerp(a : DbqueryfilterPoint, b : DbqueryfilterPoint, t : Double) -> DbqueryfilterPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_query_filter_point_to_string(pt : DbqueryfilterPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbqueryfilterSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_filter_make_series(vals : Array[Double], name : String) -> DbqueryfilterSeries {
  { vals, name, meta: 0 }
}

pub fn db_query_filter_series_len(s : DbqueryfilterSeries) -> Int { s.vals.length() }

pub fn db_query_filter_series_sum(s : DbqueryfilterSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_query_filter_series_mean(s : DbqueryfilterSeries) -> Double { @_common.mean(s.vals) }

pub fn db_query_filter_series_min(s : DbqueryfilterSeries) -> Double { @_common.min(s.vals) }

pub fn db_query_filter_series_max(s : DbqueryfilterSeries) -> Double { @_common.max(s.vals) }

pub fn db_query_filter_series_range(s : DbqueryfilterSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_query_filter_series_var(s : DbqueryfilterSeries) -> Double { @_common.variance(s.vals) }

pub fn db_query_filter_series_std(s : DbqueryfilterSeries) -> Double { @_common.std(s.vals) }

pub fn db_query_filter_series_median(s : DbqueryfilterSeries) -> Double { @_common.median(s.vals) }

pub fn db_query_filter_series_scale(s : DbqueryfilterSeries, f : Double) -> DbqueryfilterSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_query_filter_series_add(a : DbqueryfilterSeries, b : DbqueryfilterSeries) -> DbqueryfilterSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_query_filter_series_sub(a : DbqueryfilterSeries, b : DbqueryfilterSeries) -> DbqueryfilterSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_query_filter_series_normalize(s : DbqueryfilterSeries) -> DbqueryfilterSeries {
  let mn = db_query_filter_series_min(s)
  let mx = db_query_filter_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_query_filter_series_cumsum(s : DbqueryfilterSeries) -> DbqueryfilterSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_query_filter_series_to_string(s : DbqueryfilterSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbqueryfilterMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_filter_make_matrix(rows : Int, cols : Int, val : Double) -> DbqueryfilterMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_filter_matrix_identity(n : Int) -> DbqueryfilterMatrix {
  let m = db_query_filter_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_query_filter_matrix_get(m : DbqueryfilterMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_query_filter_matrix_transpose(m : DbqueryfilterMatrix) -> DbqueryfilterMatrix {
  let result = db_query_filter_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_query_filter_matrix_add(a : DbqueryfilterMatrix, b : DbqueryfilterMatrix) -> DbqueryfilterMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_query_filter_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_query_filter_matrix_scale(m : DbqueryfilterMatrix, s : Double) -> DbqueryfilterMatrix {
  let result = db_query_filter_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_query_filter_matrix_multiply(a : DbqueryfilterMatrix, b : DbqueryfilterMatrix) -> DbqueryfilterMatrix {
  if a.cols != b.rows { return db_query_filter_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_query_filter_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_query_filter_matrix_trace(m : DbqueryfilterMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_query_filter_matrix_det(m : DbqueryfilterMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_query_filter_matrix_norm(m : DbqueryfilterMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_query_filter_matrix_to_string(m : DbqueryfilterMatrix) -> String {
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

pub(all) struct DbqueryfilterVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_filter_make_vector(comps : Array[Double]) -> DbqueryfilterVector {
  { comps, dim: comps.length() }
}

pub fn db_query_filter_vector_zero(dim : Int) -> DbqueryfilterVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_query_filter_vector_add(a : DbqueryfilterVector, b : DbqueryfilterVector) -> DbqueryfilterVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_filter_vector_sub(a : DbqueryfilterVector, b : DbqueryfilterVector) -> DbqueryfilterVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_filter_vector_scale(v : DbqueryfilterVector, s : Double) -> DbqueryfilterVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_query_filter_vector_dot(a : DbqueryfilterVector, b : DbqueryfilterVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_query_filter_vector_norm(v : DbqueryfilterVector) -> Double { @_common.sqrt(db_query_filter_vector_dot(v, v)) }

pub fn db_query_filter_vector_normalize(v : DbqueryfilterVector) -> DbqueryfilterVector {
  let n = db_query_filter_vector_norm(v)
  if n < 0.0000001 { v } else { db_query_filter_vector_scale(v, 1.0 / n) }
}

pub fn db_query_filter_vector_dist(a : DbqueryfilterVector, b : DbqueryfilterVector) -> Double {
  db_query_filter_vector_norm(db_query_filter_vector_sub(a, b))
}

pub fn db_query_filter_vector_to_string(v : DbqueryfilterVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_filter_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_filter_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_filter_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_filter_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_filter_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_filter_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_filter_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_filter_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_filter_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_filter_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_filter_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_filter_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_filter_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_filter_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_filter_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_filter_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_filter_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_filter_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_filter_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_filter_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_filter_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_filter_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_filter_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_filter_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_filter_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_filter_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_filter_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_filter_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_filter_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbqueryfilterFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_frame_make(size : Int) -> DbqueryfilterFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_frame_len(s : DbqueryfilterFrame) -> Int { s.size }

pub fn db_query_filter_frame_get(s : DbqueryfilterFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_frame_set(s : DbqueryfilterFrame, i : Int, v : Double) -> DbqueryfilterFrame {
  let result = db_query_filter_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_frame_sum(s : DbqueryfilterFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_filter_frame_mean(s : DbqueryfilterFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_query_filter_frame_sum(s) / s.size.to_double() }
}

pub fn db_query_filter_frame_scale(s : DbqueryfilterFrame, f : Double) -> DbqueryfilterFrame {
  let result = db_query_filter_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_filter_frame_add(a : DbqueryfilterFrame, b : DbqueryfilterFrame) -> DbqueryfilterFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_filter_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_filter_frame_copy(s : DbqueryfilterFrame) -> DbqueryfilterFrame {
  let result = db_query_filter_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_filter_frame_fill(s : DbqueryfilterFrame, v : Double) -> DbqueryfilterFrame {
  let result = db_query_filter_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_frame_min(s : DbqueryfilterFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_frame_max(s : DbqueryfilterFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_frame_to_string(s : DbqueryfilterFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_table_make(size : Int) -> DbqueryfilterTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_table_len(s : DbqueryfilterTable) -> Int { s.size }

pub fn db_query_filter_table_get(s : DbqueryfilterTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_table_set(s : DbqueryfilterTable, i : Int, v : Double) -> DbqueryfilterTable {
  let result = db_query_filter_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_table_sum(s : DbqueryfilterTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_filter_table_mean(s : DbqueryfilterTable) -> Double {
  if s.size == 0 { 0.0 } else { db_query_filter_table_sum(s) / s.size.to_double() }
}

pub fn db_query_filter_table_scale(s : DbqueryfilterTable, f : Double) -> DbqueryfilterTable {
  let result = db_query_filter_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_filter_table_add(a : DbqueryfilterTable, b : DbqueryfilterTable) -> DbqueryfilterTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_filter_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_filter_table_copy(s : DbqueryfilterTable) -> DbqueryfilterTable {
  let result = db_query_filter_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_filter_table_fill(s : DbqueryfilterTable, v : Double) -> DbqueryfilterTable {
  let result = db_query_filter_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_table_min(s : DbqueryfilterTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_table_max(s : DbqueryfilterTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_table_to_string(s : DbqueryfilterTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_graphn_make(size : Int) -> DbqueryfilterGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_graphn_len(s : DbqueryfilterGraphN) -> Int { s.size }

pub fn db_query_filter_graphn_get(s : DbqueryfilterGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_graphn_set(s : DbqueryfilterGraphN, i : Int, v : Double) -> DbqueryfilterGraphN {
  let result = db_query_filter_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_graphn_sum(s : DbqueryfilterGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_filter_graphn_mean(s : DbqueryfilterGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_query_filter_graphn_sum(s) / s.size.to_double() }
}

pub fn db_query_filter_graphn_scale(s : DbqueryfilterGraphN, f : Double) -> DbqueryfilterGraphN {
  let result = db_query_filter_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_filter_graphn_add(a : DbqueryfilterGraphN, b : DbqueryfilterGraphN) -> DbqueryfilterGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_filter_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_filter_graphn_copy(s : DbqueryfilterGraphN) -> DbqueryfilterGraphN {
  let result = db_query_filter_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_filter_graphn_fill(s : DbqueryfilterGraphN, v : Double) -> DbqueryfilterGraphN {
  let result = db_query_filter_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_graphn_min(s : DbqueryfilterGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_graphn_max(s : DbqueryfilterGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_graphn_to_string(s : DbqueryfilterGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_node_make(size : Int) -> DbqueryfilterNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_node_len(s : DbqueryfilterNode) -> Int { s.size }

pub fn db_query_filter_node_get(s : DbqueryfilterNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_node_set(s : DbqueryfilterNode, i : Int, v : Double) -> DbqueryfilterNode {
  let result = db_query_filter_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_node_sum(s : DbqueryfilterNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_filter_node_mean(s : DbqueryfilterNode) -> Double {
  if s.size == 0 { 0.0 } else { db_query_filter_node_sum(s) / s.size.to_double() }
}

pub fn db_query_filter_node_scale(s : DbqueryfilterNode, f : Double) -> DbqueryfilterNode {
  let result = db_query_filter_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_filter_node_add(a : DbqueryfilterNode, b : DbqueryfilterNode) -> DbqueryfilterNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_filter_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_filter_node_copy(s : DbqueryfilterNode) -> DbqueryfilterNode {
  let result = db_query_filter_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_filter_node_fill(s : DbqueryfilterNode, v : Double) -> DbqueryfilterNode {
  let result = db_query_filter_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_node_min(s : DbqueryfilterNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_node_max(s : DbqueryfilterNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_node_to_string(s : DbqueryfilterNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_edge_make(size : Int) -> DbqueryfilterEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_edge_len(s : DbqueryfilterEdge) -> Int { s.size }

pub fn db_query_filter_edge_get(s : DbqueryfilterEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_edge_set(s : DbqueryfilterEdge, i : Int, v : Double) -> DbqueryfilterEdge {
  let result = db_query_filter_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_edge_sum(s : DbqueryfilterEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_filter_edge_mean(s : DbqueryfilterEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_query_filter_edge_sum(s) / s.size.to_double() }
}

pub fn db_query_filter_edge_scale(s : DbqueryfilterEdge, f : Double) -> DbqueryfilterEdge {
  let result = db_query_filter_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_filter_edge_add(a : DbqueryfilterEdge, b : DbqueryfilterEdge) -> DbqueryfilterEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_filter_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_filter_edge_copy(s : DbqueryfilterEdge) -> DbqueryfilterEdge {
  let result = db_query_filter_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_filter_edge_fill(s : DbqueryfilterEdge, v : Double) -> DbqueryfilterEdge {
  let result = db_query_filter_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_edge_min(s : DbqueryfilterEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_edge_max(s : DbqueryfilterEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_edge_to_string(s : DbqueryfilterEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_path_make(size : Int) -> DbqueryfilterPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_path_len(s : DbqueryfilterPath) -> Int { s.size }

pub fn db_query_filter_path_get(s : DbqueryfilterPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_path_set(s : DbqueryfilterPath, i : Int, v : Double) -> DbqueryfilterPath {
  let result = db_query_filter_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_path_sum(s : DbqueryfilterPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_filter_path_mean(s : DbqueryfilterPath) -> Double {
  if s.size == 0 { 0.0 } else { db_query_filter_path_sum(s) / s.size.to_double() }
}

pub fn db_query_filter_path_scale(s : DbqueryfilterPath, f : Double) -> DbqueryfilterPath {
  let result = db_query_filter_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_filter_path_add(a : DbqueryfilterPath, b : DbqueryfilterPath) -> DbqueryfilterPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_filter_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_filter_path_copy(s : DbqueryfilterPath) -> DbqueryfilterPath {
  let result = db_query_filter_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_filter_path_fill(s : DbqueryfilterPath, v : Double) -> DbqueryfilterPath {
  let result = db_query_filter_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_path_min(s : DbqueryfilterPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_path_max(s : DbqueryfilterPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_path_to_string(s : DbqueryfilterPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_cluster_make(size : Int) -> DbqueryfilterCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_cluster_len(s : DbqueryfilterCluster) -> Int { s.size }

pub fn db_query_filter_cluster_get(s : DbqueryfilterCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_cluster_set(s : DbqueryfilterCluster, i : Int, v : Double) -> DbqueryfilterCluster {
  let result = db_query_filter_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_cluster_sum(s : DbqueryfilterCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_filter_cluster_mean(s : DbqueryfilterCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_query_filter_cluster_sum(s) / s.size.to_double() }
}

pub fn db_query_filter_cluster_scale(s : DbqueryfilterCluster, f : Double) -> DbqueryfilterCluster {
  let result = db_query_filter_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_filter_cluster_add(a : DbqueryfilterCluster, b : DbqueryfilterCluster) -> DbqueryfilterCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_filter_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_filter_cluster_copy(s : DbqueryfilterCluster) -> DbqueryfilterCluster {
  let result = db_query_filter_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_filter_cluster_fill(s : DbqueryfilterCluster, v : Double) -> DbqueryfilterCluster {
  let result = db_query_filter_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_cluster_min(s : DbqueryfilterCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_cluster_max(s : DbqueryfilterCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_cluster_to_string(s : DbqueryfilterCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_model_make(size : Int) -> DbqueryfilterModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_model_len(s : DbqueryfilterModel) -> Int { s.size }

pub fn db_query_filter_model_get(s : DbqueryfilterModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_model_set(s : DbqueryfilterModel, i : Int, v : Double) -> DbqueryfilterModel {
  let result = db_query_filter_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_model_sum(s : DbqueryfilterModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_filter_model_mean(s : DbqueryfilterModel) -> Double {
  if s.size == 0 { 0.0 } else { db_query_filter_model_sum(s) / s.size.to_double() }
}

pub fn db_query_filter_model_scale(s : DbqueryfilterModel, f : Double) -> DbqueryfilterModel {
  let result = db_query_filter_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_filter_model_add(a : DbqueryfilterModel, b : DbqueryfilterModel) -> DbqueryfilterModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_filter_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_filter_model_copy(s : DbqueryfilterModel) -> DbqueryfilterModel {
  let result = db_query_filter_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_filter_model_fill(s : DbqueryfilterModel, v : Double) -> DbqueryfilterModel {
  let result = db_query_filter_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_model_min(s : DbqueryfilterModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_model_max(s : DbqueryfilterModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_model_to_string(s : DbqueryfilterModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_layer_make(size : Int) -> DbqueryfilterLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_layer_len(s : DbqueryfilterLayer) -> Int { s.size }

pub fn db_query_filter_layer_get(s : DbqueryfilterLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_layer_set(s : DbqueryfilterLayer, i : Int, v : Double) -> DbqueryfilterLayer {
  let result = db_query_filter_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_layer_sum(s : DbqueryfilterLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_filter_layer_mean(s : DbqueryfilterLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_filter_layer_sum(s) / s.size.to_double() }
}

pub fn db_query_filter_layer_scale(s : DbqueryfilterLayer, f : Double) -> DbqueryfilterLayer {
  let result = db_query_filter_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_filter_layer_add(a : DbqueryfilterLayer, b : DbqueryfilterLayer) -> DbqueryfilterLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_filter_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_filter_layer_copy(s : DbqueryfilterLayer) -> DbqueryfilterLayer {
  let result = db_query_filter_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_filter_layer_fill(s : DbqueryfilterLayer, v : Double) -> DbqueryfilterLayer {
  let result = db_query_filter_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_layer_min(s : DbqueryfilterLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_layer_max(s : DbqueryfilterLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_layer_to_string(s : DbqueryfilterLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_buffer_make(size : Int) -> DbqueryfilterBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_buffer_len(s : DbqueryfilterBuffer) -> Int { s.size }

pub fn db_query_filter_buffer_get(s : DbqueryfilterBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_buffer_set(s : DbqueryfilterBuffer, i : Int, v : Double) -> DbqueryfilterBuffer {
  let result = db_query_filter_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_buffer_sum(s : DbqueryfilterBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_filter_buffer_mean(s : DbqueryfilterBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_filter_buffer_sum(s) / s.size.to_double() }
}

pub fn db_query_filter_buffer_scale(s : DbqueryfilterBuffer, f : Double) -> DbqueryfilterBuffer {
  let result = db_query_filter_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_filter_buffer_add(a : DbqueryfilterBuffer, b : DbqueryfilterBuffer) -> DbqueryfilterBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_filter_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_filter_buffer_copy(s : DbqueryfilterBuffer) -> DbqueryfilterBuffer {
  let result = db_query_filter_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_filter_buffer_fill(s : DbqueryfilterBuffer, v : Double) -> DbqueryfilterBuffer {
  let result = db_query_filter_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_buffer_min(s : DbqueryfilterBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_buffer_max(s : DbqueryfilterBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_buffer_to_string(s : DbqueryfilterBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_cursor_make(size : Int) -> DbqueryfilterCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_cursor_len(s : DbqueryfilterCursor) -> Int { s.size }

pub fn db_query_filter_cursor_get(s : DbqueryfilterCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_cursor_set(s : DbqueryfilterCursor, i : Int, v : Double) -> DbqueryfilterCursor {
  let result = db_query_filter_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_cursor_sum(s : DbqueryfilterCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_filter_cursor_mean(s : DbqueryfilterCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_query_filter_cursor_sum(s) / s.size.to_double() }
}

pub fn db_query_filter_cursor_scale(s : DbqueryfilterCursor, f : Double) -> DbqueryfilterCursor {
  let result = db_query_filter_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_filter_cursor_add(a : DbqueryfilterCursor, b : DbqueryfilterCursor) -> DbqueryfilterCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_filter_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_filter_cursor_copy(s : DbqueryfilterCursor) -> DbqueryfilterCursor {
  let result = db_query_filter_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_filter_cursor_fill(s : DbqueryfilterCursor, v : Double) -> DbqueryfilterCursor {
  let result = db_query_filter_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_cursor_min(s : DbqueryfilterCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_cursor_max(s : DbqueryfilterCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_cursor_to_string(s : DbqueryfilterCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_view_make(size : Int) -> DbqueryfilterView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_view_len(s : DbqueryfilterView) -> Int { s.size }

pub fn db_query_filter_view_get(s : DbqueryfilterView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_view_set(s : DbqueryfilterView, i : Int, v : Double) -> DbqueryfilterView {
  let result = db_query_filter_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_view_sum(s : DbqueryfilterView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_filter_view_mean(s : DbqueryfilterView) -> Double {
  if s.size == 0 { 0.0 } else { db_query_filter_view_sum(s) / s.size.to_double() }
}

pub fn db_query_filter_view_scale(s : DbqueryfilterView, f : Double) -> DbqueryfilterView {
  let result = db_query_filter_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_filter_view_add(a : DbqueryfilterView, b : DbqueryfilterView) -> DbqueryfilterView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_filter_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_filter_view_copy(s : DbqueryfilterView) -> DbqueryfilterView {
  let result = db_query_filter_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_filter_view_fill(s : DbqueryfilterView, v : Double) -> DbqueryfilterView {
  let result = db_query_filter_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_view_min(s : DbqueryfilterView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_view_max(s : DbqueryfilterView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_view_to_string(s : DbqueryfilterView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_range_make(size : Int) -> DbqueryfilterRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_range_len(s : DbqueryfilterRange) -> Int { s.size }

pub fn db_query_filter_range_get(s : DbqueryfilterRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_range_set(s : DbqueryfilterRange, i : Int, v : Double) -> DbqueryfilterRange {
  let result = db_query_filter_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_range_sum(s : DbqueryfilterRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_filter_range_mean(s : DbqueryfilterRange) -> Double {
  if s.size == 0 { 0.0 } else { db_query_filter_range_sum(s) / s.size.to_double() }
}

pub fn db_query_filter_range_scale(s : DbqueryfilterRange, f : Double) -> DbqueryfilterRange {
  let result = db_query_filter_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_filter_range_add(a : DbqueryfilterRange, b : DbqueryfilterRange) -> DbqueryfilterRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_filter_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_filter_range_copy(s : DbqueryfilterRange) -> DbqueryfilterRange {
  let result = db_query_filter_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_filter_range_fill(s : DbqueryfilterRange, v : Double) -> DbqueryfilterRange {
  let result = db_query_filter_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_range_min(s : DbqueryfilterRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_range_max(s : DbqueryfilterRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_range_to_string(s : DbqueryfilterRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_slice_make(size : Int) -> DbqueryfilterSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_filter_slice_len(s : DbqueryfilterSlice) -> Int { s.size }

pub fn db_query_filter_slice_get(s : DbqueryfilterSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_filter_slice_set(s : DbqueryfilterSlice, i : Int, v : Double) -> DbqueryfilterSlice {
  let result = db_query_filter_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_slice_sum(s : DbqueryfilterSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_filter_slice_mean(s : DbqueryfilterSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_query_filter_slice_sum(s) / s.size.to_double() }
}

pub fn db_query_filter_slice_scale(s : DbqueryfilterSlice, f : Double) -> DbqueryfilterSlice {
  let result = db_query_filter_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_filter_slice_add(a : DbqueryfilterSlice, b : DbqueryfilterSlice) -> DbqueryfilterSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_filter_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_filter_slice_copy(s : DbqueryfilterSlice) -> DbqueryfilterSlice {
  let result = db_query_filter_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_filter_slice_fill(s : DbqueryfilterSlice, v : Double) -> DbqueryfilterSlice {
  let result = db_query_filter_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_filter_slice_min(s : DbqueryfilterSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_slice_max(s : DbqueryfilterSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_filter_slice_to_string(s : DbqueryfilterSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

