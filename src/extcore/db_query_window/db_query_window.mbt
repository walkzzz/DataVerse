///===
/// extcore/db_query_window

pub(all) struct DbquerywindowPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_window_make_point(x : Double, y : Double) -> DbquerywindowPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_window_make_point3(x : Double, y : Double, z : Double) -> DbquerywindowPoint {
  { x, y, z, label: 0 }
}

pub fn db_query_window_point_x(pt : DbquerywindowPoint) -> Double { pt.x }

pub fn db_query_window_point_y(pt : DbquerywindowPoint) -> Double { pt.y }

pub fn db_query_window_point_z(pt : DbquerywindowPoint) -> Double { pt.z }

pub fn db_query_window_point_label(pt : DbquerywindowPoint) -> Int { pt.label }

pub fn db_query_window_point_dist(a : DbquerywindowPoint, b : DbquerywindowPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_query_window_point_add(a : DbquerywindowPoint, b : DbquerywindowPoint) -> DbquerywindowPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_query_window_point_sub(a : DbquerywindowPoint, b : DbquerywindowPoint) -> DbquerywindowPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_query_window_point_scale(pt : DbquerywindowPoint, s : Double) -> DbquerywindowPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_query_window_point_dot(a : DbquerywindowPoint, b : DbquerywindowPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_query_window_point_cross(a : DbquerywindowPoint, b : DbquerywindowPoint) -> DbquerywindowPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_query_window_point_norm(pt : DbquerywindowPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_query_window_point_normalize(pt : DbquerywindowPoint) -> DbquerywindowPoint {
  let n = db_query_window_point_norm(pt)
  if n < 0.0000001 { pt } else { db_query_window_point_scale(pt, 1.0 / n) }
}

pub fn db_query_window_point_negate(pt : DbquerywindowPoint) -> DbquerywindowPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_query_window_point_mid(a : DbquerywindowPoint, b : DbquerywindowPoint) -> DbquerywindowPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_query_window_point_lerp(a : DbquerywindowPoint, b : DbquerywindowPoint, t : Double) -> DbquerywindowPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_query_window_point_to_string(pt : DbquerywindowPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbquerywindowSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_window_make_series(vals : Array[Double], name : String) -> DbquerywindowSeries {
  { vals, name, meta: 0 }
}

pub fn db_query_window_series_len(s : DbquerywindowSeries) -> Int { s.vals.length() }

pub fn db_query_window_series_sum(s : DbquerywindowSeries) -> Double { @_common.sum(s.vals) }

pub fn db_query_window_series_mean(s : DbquerywindowSeries) -> Double { @_common.mean(s.vals) }

pub fn db_query_window_series_min(s : DbquerywindowSeries) -> Double { @_common.min(s.vals) }

pub fn db_query_window_series_max(s : DbquerywindowSeries) -> Double { @_common.max(s.vals) }

pub fn db_query_window_series_range(s : DbquerywindowSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_query_window_series_var(s : DbquerywindowSeries) -> Double { @_common.variance(s.vals) }

pub fn db_query_window_series_std(s : DbquerywindowSeries) -> Double { @_common.std(s.vals) }

pub fn db_query_window_series_median(s : DbquerywindowSeries) -> Double { @_common.median(s.vals) }

pub fn db_query_window_series_scale(s : DbquerywindowSeries, f : Double) -> DbquerywindowSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_query_window_series_add(a : DbquerywindowSeries, b : DbquerywindowSeries) -> DbquerywindowSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_query_window_series_sub(a : DbquerywindowSeries, b : DbquerywindowSeries) -> DbquerywindowSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_query_window_series_normalize(s : DbquerywindowSeries) -> DbquerywindowSeries {
  let mn = db_query_window_series_min(s)
  let mx = db_query_window_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_query_window_series_cumsum(s : DbquerywindowSeries) -> DbquerywindowSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_query_window_series_to_string(s : DbquerywindowSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbquerywindowMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_window_make_matrix(rows : Int, cols : Int, val : Double) -> DbquerywindowMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_window_matrix_identity(n : Int) -> DbquerywindowMatrix {
  let m = db_query_window_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_query_window_matrix_get(m : DbquerywindowMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_query_window_matrix_transpose(m : DbquerywindowMatrix) -> DbquerywindowMatrix {
  let result = db_query_window_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_query_window_matrix_add(a : DbquerywindowMatrix, b : DbquerywindowMatrix) -> DbquerywindowMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_query_window_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_query_window_matrix_scale(m : DbquerywindowMatrix, s : Double) -> DbquerywindowMatrix {
  let result = db_query_window_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_query_window_matrix_multiply(a : DbquerywindowMatrix, b : DbquerywindowMatrix) -> DbquerywindowMatrix {
  if a.cols != b.rows { return db_query_window_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_query_window_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_query_window_matrix_trace(m : DbquerywindowMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_query_window_matrix_det(m : DbquerywindowMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_query_window_matrix_norm(m : DbquerywindowMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_query_window_matrix_to_string(m : DbquerywindowMatrix) -> String {
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

pub(all) struct DbquerywindowVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_window_make_vector(comps : Array[Double]) -> DbquerywindowVector {
  { comps, dim: comps.length() }
}

pub fn db_query_window_vector_zero(dim : Int) -> DbquerywindowVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_query_window_vector_add(a : DbquerywindowVector, b : DbquerywindowVector) -> DbquerywindowVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_window_vector_sub(a : DbquerywindowVector, b : DbquerywindowVector) -> DbquerywindowVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_window_vector_scale(v : DbquerywindowVector, s : Double) -> DbquerywindowVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_query_window_vector_dot(a : DbquerywindowVector, b : DbquerywindowVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_query_window_vector_norm(v : DbquerywindowVector) -> Double { @_common.sqrt(db_query_window_vector_dot(v, v)) }

pub fn db_query_window_vector_normalize(v : DbquerywindowVector) -> DbquerywindowVector {
  let n = db_query_window_vector_norm(v)
  if n < 0.0000001 { v } else { db_query_window_vector_scale(v, 1.0 / n) }
}

pub fn db_query_window_vector_dist(a : DbquerywindowVector, b : DbquerywindowVector) -> Double {
  db_query_window_vector_norm(db_query_window_vector_sub(a, b))
}

pub fn db_query_window_vector_to_string(v : DbquerywindowVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_window_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_window_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_window_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_window_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_window_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_window_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_window_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_window_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_window_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_window_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_window_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_window_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_window_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_window_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_window_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_window_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_window_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_window_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_window_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_window_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_window_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_window_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_window_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_window_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_window_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_window_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_window_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_window_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_window_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbquerywindowFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_frame_make(size : Int) -> DbquerywindowFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_frame_len(s : DbquerywindowFrame) -> Int { s.size }

pub fn db_query_window_frame_get(s : DbquerywindowFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_frame_set(s : DbquerywindowFrame, i : Int, v : Double) -> DbquerywindowFrame {
  let result = db_query_window_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_window_frame_sum(s : DbquerywindowFrame) -> Double { @_common.sum(s.data) }

pub fn db_query_window_frame_mean(s : DbquerywindowFrame) -> Double { @_common.mean(s.data) }

pub fn db_query_window_frame_scale(s : DbquerywindowFrame, f : Double) -> DbquerywindowFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_frame_add(a : DbquerywindowFrame, b : DbquerywindowFrame) -> DbquerywindowFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_frame_copy(s : DbquerywindowFrame) -> DbquerywindowFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_frame_fill(s : DbquerywindowFrame, v : Double) -> DbquerywindowFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_frame_min(s : DbquerywindowFrame) -> Double { @_common.min(s.data) }

pub fn db_query_window_frame_max(s : DbquerywindowFrame) -> Double { @_common.max(s.data) }

pub fn db_query_window_frame_to_string(s : DbquerywindowFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_table_make(size : Int) -> DbquerywindowTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_table_len(s : DbquerywindowTable) -> Int { s.size }

pub fn db_query_window_table_get(s : DbquerywindowTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_table_set(s : DbquerywindowTable, i : Int, v : Double) -> DbquerywindowTable {
  let result = db_query_window_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_window_table_sum(s : DbquerywindowTable) -> Double { @_common.sum(s.data) }

pub fn db_query_window_table_mean(s : DbquerywindowTable) -> Double { @_common.mean(s.data) }

pub fn db_query_window_table_scale(s : DbquerywindowTable, f : Double) -> DbquerywindowTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_table_add(a : DbquerywindowTable, b : DbquerywindowTable) -> DbquerywindowTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_table_copy(s : DbquerywindowTable) -> DbquerywindowTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_table_fill(s : DbquerywindowTable, v : Double) -> DbquerywindowTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_table_min(s : DbquerywindowTable) -> Double { @_common.min(s.data) }

pub fn db_query_window_table_max(s : DbquerywindowTable) -> Double { @_common.max(s.data) }

pub fn db_query_window_table_to_string(s : DbquerywindowTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_graphn_make(size : Int) -> DbquerywindowGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_graphn_len(s : DbquerywindowGraphN) -> Int { s.size }

pub fn db_query_window_graphn_get(s : DbquerywindowGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_graphn_set(s : DbquerywindowGraphN, i : Int, v : Double) -> DbquerywindowGraphN {
  let result = db_query_window_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_window_graphn_sum(s : DbquerywindowGraphN) -> Double { @_common.sum(s.data) }

pub fn db_query_window_graphn_mean(s : DbquerywindowGraphN) -> Double { @_common.mean(s.data) }

pub fn db_query_window_graphn_scale(s : DbquerywindowGraphN, f : Double) -> DbquerywindowGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_graphn_add(a : DbquerywindowGraphN, b : DbquerywindowGraphN) -> DbquerywindowGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_graphn_copy(s : DbquerywindowGraphN) -> DbquerywindowGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_graphn_fill(s : DbquerywindowGraphN, v : Double) -> DbquerywindowGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_graphn_min(s : DbquerywindowGraphN) -> Double { @_common.min(s.data) }

pub fn db_query_window_graphn_max(s : DbquerywindowGraphN) -> Double { @_common.max(s.data) }

pub fn db_query_window_graphn_to_string(s : DbquerywindowGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_node_make(size : Int) -> DbquerywindowNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_node_len(s : DbquerywindowNode) -> Int { s.size }

pub fn db_query_window_node_get(s : DbquerywindowNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_node_set(s : DbquerywindowNode, i : Int, v : Double) -> DbquerywindowNode {
  let result = db_query_window_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_window_node_sum(s : DbquerywindowNode) -> Double { @_common.sum(s.data) }

pub fn db_query_window_node_mean(s : DbquerywindowNode) -> Double { @_common.mean(s.data) }

pub fn db_query_window_node_scale(s : DbquerywindowNode, f : Double) -> DbquerywindowNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_node_add(a : DbquerywindowNode, b : DbquerywindowNode) -> DbquerywindowNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_node_copy(s : DbquerywindowNode) -> DbquerywindowNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_node_fill(s : DbquerywindowNode, v : Double) -> DbquerywindowNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_node_min(s : DbquerywindowNode) -> Double { @_common.min(s.data) }

pub fn db_query_window_node_max(s : DbquerywindowNode) -> Double { @_common.max(s.data) }

pub fn db_query_window_node_to_string(s : DbquerywindowNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_edge_make(size : Int) -> DbquerywindowEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_edge_len(s : DbquerywindowEdge) -> Int { s.size }

pub fn db_query_window_edge_get(s : DbquerywindowEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_edge_set(s : DbquerywindowEdge, i : Int, v : Double) -> DbquerywindowEdge {
  let result = db_query_window_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_window_edge_sum(s : DbquerywindowEdge) -> Double { @_common.sum(s.data) }

pub fn db_query_window_edge_mean(s : DbquerywindowEdge) -> Double { @_common.mean(s.data) }

pub fn db_query_window_edge_scale(s : DbquerywindowEdge, f : Double) -> DbquerywindowEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_edge_add(a : DbquerywindowEdge, b : DbquerywindowEdge) -> DbquerywindowEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_edge_copy(s : DbquerywindowEdge) -> DbquerywindowEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_edge_fill(s : DbquerywindowEdge, v : Double) -> DbquerywindowEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_edge_min(s : DbquerywindowEdge) -> Double { @_common.min(s.data) }

pub fn db_query_window_edge_max(s : DbquerywindowEdge) -> Double { @_common.max(s.data) }

pub fn db_query_window_edge_to_string(s : DbquerywindowEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_path_make(size : Int) -> DbquerywindowPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_path_len(s : DbquerywindowPath) -> Int { s.size }

pub fn db_query_window_path_get(s : DbquerywindowPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_path_set(s : DbquerywindowPath, i : Int, v : Double) -> DbquerywindowPath {
  let result = db_query_window_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_window_path_sum(s : DbquerywindowPath) -> Double { @_common.sum(s.data) }

pub fn db_query_window_path_mean(s : DbquerywindowPath) -> Double { @_common.mean(s.data) }

pub fn db_query_window_path_scale(s : DbquerywindowPath, f : Double) -> DbquerywindowPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_path_add(a : DbquerywindowPath, b : DbquerywindowPath) -> DbquerywindowPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_path_copy(s : DbquerywindowPath) -> DbquerywindowPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_path_fill(s : DbquerywindowPath, v : Double) -> DbquerywindowPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_path_min(s : DbquerywindowPath) -> Double { @_common.min(s.data) }

pub fn db_query_window_path_max(s : DbquerywindowPath) -> Double { @_common.max(s.data) }

pub fn db_query_window_path_to_string(s : DbquerywindowPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_cluster_make(size : Int) -> DbquerywindowCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_cluster_len(s : DbquerywindowCluster) -> Int { s.size }

pub fn db_query_window_cluster_get(s : DbquerywindowCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_cluster_set(s : DbquerywindowCluster, i : Int, v : Double) -> DbquerywindowCluster {
  let result = db_query_window_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_window_cluster_sum(s : DbquerywindowCluster) -> Double { @_common.sum(s.data) }

pub fn db_query_window_cluster_mean(s : DbquerywindowCluster) -> Double { @_common.mean(s.data) }

pub fn db_query_window_cluster_scale(s : DbquerywindowCluster, f : Double) -> DbquerywindowCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_cluster_add(a : DbquerywindowCluster, b : DbquerywindowCluster) -> DbquerywindowCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_cluster_copy(s : DbquerywindowCluster) -> DbquerywindowCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_cluster_fill(s : DbquerywindowCluster, v : Double) -> DbquerywindowCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_cluster_min(s : DbquerywindowCluster) -> Double { @_common.min(s.data) }

pub fn db_query_window_cluster_max(s : DbquerywindowCluster) -> Double { @_common.max(s.data) }

pub fn db_query_window_cluster_to_string(s : DbquerywindowCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_model_make(size : Int) -> DbquerywindowModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_model_len(s : DbquerywindowModel) -> Int { s.size }

pub fn db_query_window_model_get(s : DbquerywindowModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_model_set(s : DbquerywindowModel, i : Int, v : Double) -> DbquerywindowModel {
  let result = db_query_window_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_window_model_sum(s : DbquerywindowModel) -> Double { @_common.sum(s.data) }

pub fn db_query_window_model_mean(s : DbquerywindowModel) -> Double { @_common.mean(s.data) }

pub fn db_query_window_model_scale(s : DbquerywindowModel, f : Double) -> DbquerywindowModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_model_add(a : DbquerywindowModel, b : DbquerywindowModel) -> DbquerywindowModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_model_copy(s : DbquerywindowModel) -> DbquerywindowModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_model_fill(s : DbquerywindowModel, v : Double) -> DbquerywindowModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_model_min(s : DbquerywindowModel) -> Double { @_common.min(s.data) }

pub fn db_query_window_model_max(s : DbquerywindowModel) -> Double { @_common.max(s.data) }

pub fn db_query_window_model_to_string(s : DbquerywindowModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_layer_make(size : Int) -> DbquerywindowLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_layer_len(s : DbquerywindowLayer) -> Int { s.size }

pub fn db_query_window_layer_get(s : DbquerywindowLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_layer_set(s : DbquerywindowLayer, i : Int, v : Double) -> DbquerywindowLayer {
  let result = db_query_window_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_window_layer_sum(s : DbquerywindowLayer) -> Double { @_common.sum(s.data) }

pub fn db_query_window_layer_mean(s : DbquerywindowLayer) -> Double { @_common.mean(s.data) }

pub fn db_query_window_layer_scale(s : DbquerywindowLayer, f : Double) -> DbquerywindowLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_layer_add(a : DbquerywindowLayer, b : DbquerywindowLayer) -> DbquerywindowLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_layer_copy(s : DbquerywindowLayer) -> DbquerywindowLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_layer_fill(s : DbquerywindowLayer, v : Double) -> DbquerywindowLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_layer_min(s : DbquerywindowLayer) -> Double { @_common.min(s.data) }

pub fn db_query_window_layer_max(s : DbquerywindowLayer) -> Double { @_common.max(s.data) }

pub fn db_query_window_layer_to_string(s : DbquerywindowLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_buffer_make(size : Int) -> DbquerywindowBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_buffer_len(s : DbquerywindowBuffer) -> Int { s.size }

pub fn db_query_window_buffer_get(s : DbquerywindowBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_buffer_set(s : DbquerywindowBuffer, i : Int, v : Double) -> DbquerywindowBuffer {
  let result = db_query_window_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_window_buffer_sum(s : DbquerywindowBuffer) -> Double { @_common.sum(s.data) }

pub fn db_query_window_buffer_mean(s : DbquerywindowBuffer) -> Double { @_common.mean(s.data) }

pub fn db_query_window_buffer_scale(s : DbquerywindowBuffer, f : Double) -> DbquerywindowBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_buffer_add(a : DbquerywindowBuffer, b : DbquerywindowBuffer) -> DbquerywindowBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_buffer_copy(s : DbquerywindowBuffer) -> DbquerywindowBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_buffer_fill(s : DbquerywindowBuffer, v : Double) -> DbquerywindowBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_buffer_min(s : DbquerywindowBuffer) -> Double { @_common.min(s.data) }

pub fn db_query_window_buffer_max(s : DbquerywindowBuffer) -> Double { @_common.max(s.data) }

pub fn db_query_window_buffer_to_string(s : DbquerywindowBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_cursor_make(size : Int) -> DbquerywindowCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_cursor_len(s : DbquerywindowCursor) -> Int { s.size }

pub fn db_query_window_cursor_get(s : DbquerywindowCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_cursor_set(s : DbquerywindowCursor, i : Int, v : Double) -> DbquerywindowCursor {
  let result = db_query_window_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_window_cursor_sum(s : DbquerywindowCursor) -> Double { @_common.sum(s.data) }

pub fn db_query_window_cursor_mean(s : DbquerywindowCursor) -> Double { @_common.mean(s.data) }

pub fn db_query_window_cursor_scale(s : DbquerywindowCursor, f : Double) -> DbquerywindowCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_cursor_add(a : DbquerywindowCursor, b : DbquerywindowCursor) -> DbquerywindowCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_cursor_copy(s : DbquerywindowCursor) -> DbquerywindowCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_cursor_fill(s : DbquerywindowCursor, v : Double) -> DbquerywindowCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_cursor_min(s : DbquerywindowCursor) -> Double { @_common.min(s.data) }

pub fn db_query_window_cursor_max(s : DbquerywindowCursor) -> Double { @_common.max(s.data) }

pub fn db_query_window_cursor_to_string(s : DbquerywindowCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_view_make(size : Int) -> DbquerywindowView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_view_len(s : DbquerywindowView) -> Int { s.size }

pub fn db_query_window_view_get(s : DbquerywindowView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_view_set(s : DbquerywindowView, i : Int, v : Double) -> DbquerywindowView {
  let result = db_query_window_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_window_view_sum(s : DbquerywindowView) -> Double { @_common.sum(s.data) }

pub fn db_query_window_view_mean(s : DbquerywindowView) -> Double { @_common.mean(s.data) }

pub fn db_query_window_view_scale(s : DbquerywindowView, f : Double) -> DbquerywindowView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_view_add(a : DbquerywindowView, b : DbquerywindowView) -> DbquerywindowView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_view_copy(s : DbquerywindowView) -> DbquerywindowView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_view_fill(s : DbquerywindowView, v : Double) -> DbquerywindowView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_view_min(s : DbquerywindowView) -> Double { @_common.min(s.data) }

pub fn db_query_window_view_max(s : DbquerywindowView) -> Double { @_common.max(s.data) }

pub fn db_query_window_view_to_string(s : DbquerywindowView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_range_make(size : Int) -> DbquerywindowRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_range_len(s : DbquerywindowRange) -> Int { s.size }

pub fn db_query_window_range_get(s : DbquerywindowRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_range_set(s : DbquerywindowRange, i : Int, v : Double) -> DbquerywindowRange {
  let result = db_query_window_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_window_range_sum(s : DbquerywindowRange) -> Double { @_common.sum(s.data) }

pub fn db_query_window_range_mean(s : DbquerywindowRange) -> Double { @_common.mean(s.data) }

pub fn db_query_window_range_scale(s : DbquerywindowRange, f : Double) -> DbquerywindowRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_range_add(a : DbquerywindowRange, b : DbquerywindowRange) -> DbquerywindowRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_range_copy(s : DbquerywindowRange) -> DbquerywindowRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_range_fill(s : DbquerywindowRange, v : Double) -> DbquerywindowRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_range_min(s : DbquerywindowRange) -> Double { @_common.min(s.data) }

pub fn db_query_window_range_max(s : DbquerywindowRange) -> Double { @_common.max(s.data) }

pub fn db_query_window_range_to_string(s : DbquerywindowRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerywindowSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_window_slice_make(size : Int) -> DbquerywindowSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_window_slice_len(s : DbquerywindowSlice) -> Int { s.size }

pub fn db_query_window_slice_get(s : DbquerywindowSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_window_slice_set(s : DbquerywindowSlice, i : Int, v : Double) -> DbquerywindowSlice {
  let result = db_query_window_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_window_slice_sum(s : DbquerywindowSlice) -> Double { @_common.sum(s.data) }

pub fn db_query_window_slice_mean(s : DbquerywindowSlice) -> Double { @_common.mean(s.data) }

pub fn db_query_window_slice_scale(s : DbquerywindowSlice, f : Double) -> DbquerywindowSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_query_window_slice_add(a : DbquerywindowSlice, b : DbquerywindowSlice) -> DbquerywindowSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_query_window_slice_copy(s : DbquerywindowSlice) -> DbquerywindowSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_query_window_slice_fill(s : DbquerywindowSlice, v : Double) -> DbquerywindowSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_query_window_slice_min(s : DbquerywindowSlice) -> Double { @_common.min(s.data) }

pub fn db_query_window_slice_max(s : DbquerywindowSlice) -> Double { @_common.max(s.data) }

pub fn db_query_window_slice_to_string(s : DbquerywindowSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

