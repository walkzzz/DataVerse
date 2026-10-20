///===
/// extcore/db_store_graph

pub(all) struct DbstoregraphPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_graph_make_point(x : Double, y : Double) -> DbstoregraphPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_graph_make_point3(x : Double, y : Double, z : Double) -> DbstoregraphPoint {
  { x, y, z, label: 0 }
}

pub fn db_store_graph_point_x(pt : DbstoregraphPoint) -> Double { pt.x }

pub fn db_store_graph_point_y(pt : DbstoregraphPoint) -> Double { pt.y }

pub fn db_store_graph_point_z(pt : DbstoregraphPoint) -> Double { pt.z }

pub fn db_store_graph_point_label(pt : DbstoregraphPoint) -> Int { pt.label }

pub fn db_store_graph_point_dist(a : DbstoregraphPoint, b : DbstoregraphPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_store_graph_point_add(a : DbstoregraphPoint, b : DbstoregraphPoint) -> DbstoregraphPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_store_graph_point_sub(a : DbstoregraphPoint, b : DbstoregraphPoint) -> DbstoregraphPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_store_graph_point_scale(pt : DbstoregraphPoint, s : Double) -> DbstoregraphPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_store_graph_point_dot(a : DbstoregraphPoint, b : DbstoregraphPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_store_graph_point_cross(a : DbstoregraphPoint, b : DbstoregraphPoint) -> DbstoregraphPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_store_graph_point_norm(pt : DbstoregraphPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_store_graph_point_normalize(pt : DbstoregraphPoint) -> DbstoregraphPoint {
  let n = db_store_graph_point_norm(pt)
  if n < 0.0000001 { pt } else { db_store_graph_point_scale(pt, 1.0 / n) }
}

pub fn db_store_graph_point_negate(pt : DbstoregraphPoint) -> DbstoregraphPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_store_graph_point_mid(a : DbstoregraphPoint, b : DbstoregraphPoint) -> DbstoregraphPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_store_graph_point_lerp(a : DbstoregraphPoint, b : DbstoregraphPoint, t : Double) -> DbstoregraphPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_store_graph_point_to_string(pt : DbstoregraphPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbstoregraphSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_graph_make_series(vals : Array[Double], name : String) -> DbstoregraphSeries {
  { vals, name, meta: 0 }
}

pub fn db_store_graph_series_len(s : DbstoregraphSeries) -> Int { s.vals.length() }

pub fn db_store_graph_series_sum(s : DbstoregraphSeries) -> Double { @_common.sum(s.vals) }

pub fn db_store_graph_series_mean(s : DbstoregraphSeries) -> Double { @_common.mean(s.vals) }

pub fn db_store_graph_series_min(s : DbstoregraphSeries) -> Double { @_common.min(s.vals) }

pub fn db_store_graph_series_max(s : DbstoregraphSeries) -> Double { @_common.max(s.vals) }

pub fn db_store_graph_series_range(s : DbstoregraphSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_store_graph_series_var(s : DbstoregraphSeries) -> Double { @_common.variance(s.vals) }

pub fn db_store_graph_series_std(s : DbstoregraphSeries) -> Double { @_common.std(s.vals) }

pub fn db_store_graph_series_median(s : DbstoregraphSeries) -> Double { @_common.median(s.vals) }

pub fn db_store_graph_series_scale(s : DbstoregraphSeries, f : Double) -> DbstoregraphSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_store_graph_series_add(a : DbstoregraphSeries, b : DbstoregraphSeries) -> DbstoregraphSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_store_graph_series_sub(a : DbstoregraphSeries, b : DbstoregraphSeries) -> DbstoregraphSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_store_graph_series_normalize(s : DbstoregraphSeries) -> DbstoregraphSeries {
  let mn = db_store_graph_series_min(s)
  let mx = db_store_graph_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_store_graph_series_cumsum(s : DbstoregraphSeries) -> DbstoregraphSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_store_graph_series_to_string(s : DbstoregraphSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstoregraphMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_graph_make_matrix(rows : Int, cols : Int, val : Double) -> DbstoregraphMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_graph_matrix_identity(n : Int) -> DbstoregraphMatrix {
  let m = db_store_graph_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_store_graph_matrix_get(m : DbstoregraphMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_store_graph_matrix_transpose(m : DbstoregraphMatrix) -> DbstoregraphMatrix {
  let result = db_store_graph_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_store_graph_matrix_add(a : DbstoregraphMatrix, b : DbstoregraphMatrix) -> DbstoregraphMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_store_graph_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_store_graph_matrix_scale(m : DbstoregraphMatrix, s : Double) -> DbstoregraphMatrix {
  let result = db_store_graph_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_store_graph_matrix_multiply(a : DbstoregraphMatrix, b : DbstoregraphMatrix) -> DbstoregraphMatrix {
  if a.cols != b.rows { return db_store_graph_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_store_graph_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_store_graph_matrix_trace(m : DbstoregraphMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_store_graph_matrix_det(m : DbstoregraphMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_store_graph_matrix_norm(m : DbstoregraphMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_store_graph_matrix_to_string(m : DbstoregraphMatrix) -> String {
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

pub(all) struct DbstoregraphVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_graph_make_vector(comps : Array[Double]) -> DbstoregraphVector {
  { comps, dim: comps.length() }
}

pub fn db_store_graph_vector_zero(dim : Int) -> DbstoregraphVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_store_graph_vector_add(a : DbstoregraphVector, b : DbstoregraphVector) -> DbstoregraphVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_graph_vector_sub(a : DbstoregraphVector, b : DbstoregraphVector) -> DbstoregraphVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_graph_vector_scale(v : DbstoregraphVector, s : Double) -> DbstoregraphVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_store_graph_vector_dot(a : DbstoregraphVector, b : DbstoregraphVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_store_graph_vector_norm(v : DbstoregraphVector) -> Double { @_common.sqrt(db_store_graph_vector_dot(v, v)) }

pub fn db_store_graph_vector_normalize(v : DbstoregraphVector) -> DbstoregraphVector {
  let n = db_store_graph_vector_norm(v)
  if n < 0.0000001 { v } else { db_store_graph_vector_scale(v, 1.0 / n) }
}

pub fn db_store_graph_vector_dist(a : DbstoregraphVector, b : DbstoregraphVector) -> Double {
  db_store_graph_vector_norm(db_store_graph_vector_sub(a, b))
}

pub fn db_store_graph_vector_to_string(v : DbstoregraphVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_graph_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_graph_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_graph_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_graph_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_graph_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_graph_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_graph_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_graph_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_graph_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_graph_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_graph_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_graph_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_graph_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_graph_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_graph_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_graph_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_graph_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_graph_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_graph_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_graph_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_graph_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_graph_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_graph_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_graph_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_graph_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_graph_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_graph_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_graph_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_graph_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstoregraphFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_frame_make(size : Int) -> DbstoregraphFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_frame_len(s : DbstoregraphFrame) -> Int { s.size }

pub fn db_store_graph_frame_get(s : DbstoregraphFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_frame_set(s : DbstoregraphFrame, i : Int, v : Double) -> DbstoregraphFrame {
  let result = db_store_graph_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_frame_sum(s : DbstoregraphFrame) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_frame_mean(s : DbstoregraphFrame) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_frame_scale(s : DbstoregraphFrame, f : Double) -> DbstoregraphFrame {
  let result = db_store_graph_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_graph_frame_add(a : DbstoregraphFrame, b : DbstoregraphFrame) -> DbstoregraphFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_graph_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_graph_frame_copy(s : DbstoregraphFrame) -> DbstoregraphFrame {
  let result = db_store_graph_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_graph_frame_fill(s : DbstoregraphFrame, v : Double) -> DbstoregraphFrame {
  let result = db_store_graph_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_frame_min(s : DbstoregraphFrame) -> Double { @_common.min(s.data) }

pub fn db_store_graph_frame_max(s : DbstoregraphFrame) -> Double { @_common.max(s.data) }

pub fn db_store_graph_frame_to_string(s : DbstoregraphFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_table_make(size : Int) -> DbstoregraphTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_table_len(s : DbstoregraphTable) -> Int { s.size }

pub fn db_store_graph_table_get(s : DbstoregraphTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_table_set(s : DbstoregraphTable, i : Int, v : Double) -> DbstoregraphTable {
  let result = db_store_graph_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_table_sum(s : DbstoregraphTable) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_table_mean(s : DbstoregraphTable) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_table_scale(s : DbstoregraphTable, f : Double) -> DbstoregraphTable {
  let result = db_store_graph_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_graph_table_add(a : DbstoregraphTable, b : DbstoregraphTable) -> DbstoregraphTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_graph_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_graph_table_copy(s : DbstoregraphTable) -> DbstoregraphTable {
  let result = db_store_graph_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_graph_table_fill(s : DbstoregraphTable, v : Double) -> DbstoregraphTable {
  let result = db_store_graph_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_table_min(s : DbstoregraphTable) -> Double { @_common.min(s.data) }

pub fn db_store_graph_table_max(s : DbstoregraphTable) -> Double { @_common.max(s.data) }

pub fn db_store_graph_table_to_string(s : DbstoregraphTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_graphn_make(size : Int) -> DbstoregraphGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_graphn_len(s : DbstoregraphGraphN) -> Int { s.size }

pub fn db_store_graph_graphn_get(s : DbstoregraphGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_graphn_set(s : DbstoregraphGraphN, i : Int, v : Double) -> DbstoregraphGraphN {
  let result = db_store_graph_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_graphn_sum(s : DbstoregraphGraphN) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_graphn_mean(s : DbstoregraphGraphN) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_graphn_scale(s : DbstoregraphGraphN, f : Double) -> DbstoregraphGraphN {
  let result = db_store_graph_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_graph_graphn_add(a : DbstoregraphGraphN, b : DbstoregraphGraphN) -> DbstoregraphGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_graph_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_graph_graphn_copy(s : DbstoregraphGraphN) -> DbstoregraphGraphN {
  let result = db_store_graph_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_graph_graphn_fill(s : DbstoregraphGraphN, v : Double) -> DbstoregraphGraphN {
  let result = db_store_graph_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_graphn_min(s : DbstoregraphGraphN) -> Double { @_common.min(s.data) }

pub fn db_store_graph_graphn_max(s : DbstoregraphGraphN) -> Double { @_common.max(s.data) }

pub fn db_store_graph_graphn_to_string(s : DbstoregraphGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_node_make(size : Int) -> DbstoregraphNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_node_len(s : DbstoregraphNode) -> Int { s.size }

pub fn db_store_graph_node_get(s : DbstoregraphNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_node_set(s : DbstoregraphNode, i : Int, v : Double) -> DbstoregraphNode {
  let result = db_store_graph_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_node_sum(s : DbstoregraphNode) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_node_mean(s : DbstoregraphNode) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_node_scale(s : DbstoregraphNode, f : Double) -> DbstoregraphNode {
  let result = db_store_graph_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_graph_node_add(a : DbstoregraphNode, b : DbstoregraphNode) -> DbstoregraphNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_graph_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_graph_node_copy(s : DbstoregraphNode) -> DbstoregraphNode {
  let result = db_store_graph_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_graph_node_fill(s : DbstoregraphNode, v : Double) -> DbstoregraphNode {
  let result = db_store_graph_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_node_min(s : DbstoregraphNode) -> Double { @_common.min(s.data) }

pub fn db_store_graph_node_max(s : DbstoregraphNode) -> Double { @_common.max(s.data) }

pub fn db_store_graph_node_to_string(s : DbstoregraphNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_edge_make(size : Int) -> DbstoregraphEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_edge_len(s : DbstoregraphEdge) -> Int { s.size }

pub fn db_store_graph_edge_get(s : DbstoregraphEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_edge_set(s : DbstoregraphEdge, i : Int, v : Double) -> DbstoregraphEdge {
  let result = db_store_graph_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_edge_sum(s : DbstoregraphEdge) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_edge_mean(s : DbstoregraphEdge) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_edge_scale(s : DbstoregraphEdge, f : Double) -> DbstoregraphEdge {
  let result = db_store_graph_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_graph_edge_add(a : DbstoregraphEdge, b : DbstoregraphEdge) -> DbstoregraphEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_graph_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_graph_edge_copy(s : DbstoregraphEdge) -> DbstoregraphEdge {
  let result = db_store_graph_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_graph_edge_fill(s : DbstoregraphEdge, v : Double) -> DbstoregraphEdge {
  let result = db_store_graph_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_edge_min(s : DbstoregraphEdge) -> Double { @_common.min(s.data) }

pub fn db_store_graph_edge_max(s : DbstoregraphEdge) -> Double { @_common.max(s.data) }

pub fn db_store_graph_edge_to_string(s : DbstoregraphEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_path_make(size : Int) -> DbstoregraphPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_path_len(s : DbstoregraphPath) -> Int { s.size }

pub fn db_store_graph_path_get(s : DbstoregraphPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_path_set(s : DbstoregraphPath, i : Int, v : Double) -> DbstoregraphPath {
  let result = db_store_graph_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_path_sum(s : DbstoregraphPath) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_path_mean(s : DbstoregraphPath) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_path_scale(s : DbstoregraphPath, f : Double) -> DbstoregraphPath {
  let result = db_store_graph_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_graph_path_add(a : DbstoregraphPath, b : DbstoregraphPath) -> DbstoregraphPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_graph_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_graph_path_copy(s : DbstoregraphPath) -> DbstoregraphPath {
  let result = db_store_graph_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_graph_path_fill(s : DbstoregraphPath, v : Double) -> DbstoregraphPath {
  let result = db_store_graph_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_path_min(s : DbstoregraphPath) -> Double { @_common.min(s.data) }

pub fn db_store_graph_path_max(s : DbstoregraphPath) -> Double { @_common.max(s.data) }

pub fn db_store_graph_path_to_string(s : DbstoregraphPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_cluster_make(size : Int) -> DbstoregraphCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_cluster_len(s : DbstoregraphCluster) -> Int { s.size }

pub fn db_store_graph_cluster_get(s : DbstoregraphCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_cluster_set(s : DbstoregraphCluster, i : Int, v : Double) -> DbstoregraphCluster {
  let result = db_store_graph_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_cluster_sum(s : DbstoregraphCluster) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_cluster_mean(s : DbstoregraphCluster) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_cluster_scale(s : DbstoregraphCluster, f : Double) -> DbstoregraphCluster {
  let result = db_store_graph_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_graph_cluster_add(a : DbstoregraphCluster, b : DbstoregraphCluster) -> DbstoregraphCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_graph_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_graph_cluster_copy(s : DbstoregraphCluster) -> DbstoregraphCluster {
  let result = db_store_graph_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_graph_cluster_fill(s : DbstoregraphCluster, v : Double) -> DbstoregraphCluster {
  let result = db_store_graph_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_cluster_min(s : DbstoregraphCluster) -> Double { @_common.min(s.data) }

pub fn db_store_graph_cluster_max(s : DbstoregraphCluster) -> Double { @_common.max(s.data) }

pub fn db_store_graph_cluster_to_string(s : DbstoregraphCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_model_make(size : Int) -> DbstoregraphModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_model_len(s : DbstoregraphModel) -> Int { s.size }

pub fn db_store_graph_model_get(s : DbstoregraphModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_model_set(s : DbstoregraphModel, i : Int, v : Double) -> DbstoregraphModel {
  let result = db_store_graph_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_model_sum(s : DbstoregraphModel) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_model_mean(s : DbstoregraphModel) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_model_scale(s : DbstoregraphModel, f : Double) -> DbstoregraphModel {
  let result = db_store_graph_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_graph_model_add(a : DbstoregraphModel, b : DbstoregraphModel) -> DbstoregraphModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_graph_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_graph_model_copy(s : DbstoregraphModel) -> DbstoregraphModel {
  let result = db_store_graph_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_graph_model_fill(s : DbstoregraphModel, v : Double) -> DbstoregraphModel {
  let result = db_store_graph_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_model_min(s : DbstoregraphModel) -> Double { @_common.min(s.data) }

pub fn db_store_graph_model_max(s : DbstoregraphModel) -> Double { @_common.max(s.data) }

pub fn db_store_graph_model_to_string(s : DbstoregraphModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_layer_make(size : Int) -> DbstoregraphLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_layer_len(s : DbstoregraphLayer) -> Int { s.size }

pub fn db_store_graph_layer_get(s : DbstoregraphLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_layer_set(s : DbstoregraphLayer, i : Int, v : Double) -> DbstoregraphLayer {
  let result = db_store_graph_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_layer_sum(s : DbstoregraphLayer) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_layer_mean(s : DbstoregraphLayer) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_layer_scale(s : DbstoregraphLayer, f : Double) -> DbstoregraphLayer {
  let result = db_store_graph_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_graph_layer_add(a : DbstoregraphLayer, b : DbstoregraphLayer) -> DbstoregraphLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_graph_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_graph_layer_copy(s : DbstoregraphLayer) -> DbstoregraphLayer {
  let result = db_store_graph_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_graph_layer_fill(s : DbstoregraphLayer, v : Double) -> DbstoregraphLayer {
  let result = db_store_graph_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_layer_min(s : DbstoregraphLayer) -> Double { @_common.min(s.data) }

pub fn db_store_graph_layer_max(s : DbstoregraphLayer) -> Double { @_common.max(s.data) }

pub fn db_store_graph_layer_to_string(s : DbstoregraphLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_buffer_make(size : Int) -> DbstoregraphBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_buffer_len(s : DbstoregraphBuffer) -> Int { s.size }

pub fn db_store_graph_buffer_get(s : DbstoregraphBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_buffer_set(s : DbstoregraphBuffer, i : Int, v : Double) -> DbstoregraphBuffer {
  let result = db_store_graph_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_buffer_sum(s : DbstoregraphBuffer) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_buffer_mean(s : DbstoregraphBuffer) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_buffer_scale(s : DbstoregraphBuffer, f : Double) -> DbstoregraphBuffer {
  let result = db_store_graph_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_graph_buffer_add(a : DbstoregraphBuffer, b : DbstoregraphBuffer) -> DbstoregraphBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_graph_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_graph_buffer_copy(s : DbstoregraphBuffer) -> DbstoregraphBuffer {
  let result = db_store_graph_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_graph_buffer_fill(s : DbstoregraphBuffer, v : Double) -> DbstoregraphBuffer {
  let result = db_store_graph_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_buffer_min(s : DbstoregraphBuffer) -> Double { @_common.min(s.data) }

pub fn db_store_graph_buffer_max(s : DbstoregraphBuffer) -> Double { @_common.max(s.data) }

pub fn db_store_graph_buffer_to_string(s : DbstoregraphBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_cursor_make(size : Int) -> DbstoregraphCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_cursor_len(s : DbstoregraphCursor) -> Int { s.size }

pub fn db_store_graph_cursor_get(s : DbstoregraphCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_cursor_set(s : DbstoregraphCursor, i : Int, v : Double) -> DbstoregraphCursor {
  let result = db_store_graph_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_cursor_sum(s : DbstoregraphCursor) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_cursor_mean(s : DbstoregraphCursor) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_cursor_scale(s : DbstoregraphCursor, f : Double) -> DbstoregraphCursor {
  let result = db_store_graph_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_graph_cursor_add(a : DbstoregraphCursor, b : DbstoregraphCursor) -> DbstoregraphCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_graph_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_graph_cursor_copy(s : DbstoregraphCursor) -> DbstoregraphCursor {
  let result = db_store_graph_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_graph_cursor_fill(s : DbstoregraphCursor, v : Double) -> DbstoregraphCursor {
  let result = db_store_graph_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_cursor_min(s : DbstoregraphCursor) -> Double { @_common.min(s.data) }

pub fn db_store_graph_cursor_max(s : DbstoregraphCursor) -> Double { @_common.max(s.data) }

pub fn db_store_graph_cursor_to_string(s : DbstoregraphCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_view_make(size : Int) -> DbstoregraphView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_view_len(s : DbstoregraphView) -> Int { s.size }

pub fn db_store_graph_view_get(s : DbstoregraphView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_view_set(s : DbstoregraphView, i : Int, v : Double) -> DbstoregraphView {
  let result = db_store_graph_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_view_sum(s : DbstoregraphView) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_view_mean(s : DbstoregraphView) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_view_scale(s : DbstoregraphView, f : Double) -> DbstoregraphView {
  let result = db_store_graph_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_graph_view_add(a : DbstoregraphView, b : DbstoregraphView) -> DbstoregraphView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_graph_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_graph_view_copy(s : DbstoregraphView) -> DbstoregraphView {
  let result = db_store_graph_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_graph_view_fill(s : DbstoregraphView, v : Double) -> DbstoregraphView {
  let result = db_store_graph_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_view_min(s : DbstoregraphView) -> Double { @_common.min(s.data) }

pub fn db_store_graph_view_max(s : DbstoregraphView) -> Double { @_common.max(s.data) }

pub fn db_store_graph_view_to_string(s : DbstoregraphView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_range_make(size : Int) -> DbstoregraphRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_range_len(s : DbstoregraphRange) -> Int { s.size }

pub fn db_store_graph_range_get(s : DbstoregraphRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_range_set(s : DbstoregraphRange, i : Int, v : Double) -> DbstoregraphRange {
  let result = db_store_graph_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_range_sum(s : DbstoregraphRange) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_range_mean(s : DbstoregraphRange) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_range_scale(s : DbstoregraphRange, f : Double) -> DbstoregraphRange {
  let result = db_store_graph_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_graph_range_add(a : DbstoregraphRange, b : DbstoregraphRange) -> DbstoregraphRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_graph_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_graph_range_copy(s : DbstoregraphRange) -> DbstoregraphRange {
  let result = db_store_graph_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_graph_range_fill(s : DbstoregraphRange, v : Double) -> DbstoregraphRange {
  let result = db_store_graph_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_range_min(s : DbstoregraphRange) -> Double { @_common.min(s.data) }

pub fn db_store_graph_range_max(s : DbstoregraphRange) -> Double { @_common.max(s.data) }

pub fn db_store_graph_range_to_string(s : DbstoregraphRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoregraphSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_graph_slice_make(size : Int) -> DbstoregraphSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_graph_slice_len(s : DbstoregraphSlice) -> Int { s.size }

pub fn db_store_graph_slice_get(s : DbstoregraphSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_graph_slice_set(s : DbstoregraphSlice, i : Int, v : Double) -> DbstoregraphSlice {
  let result = db_store_graph_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_slice_sum(s : DbstoregraphSlice) -> Double { @_common.sum(s.data) }

pub fn db_store_graph_slice_mean(s : DbstoregraphSlice) -> Double { @_common.mean(s.data) }

pub fn db_store_graph_slice_scale(s : DbstoregraphSlice, f : Double) -> DbstoregraphSlice {
  let result = db_store_graph_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_graph_slice_add(a : DbstoregraphSlice, b : DbstoregraphSlice) -> DbstoregraphSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_graph_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_graph_slice_copy(s : DbstoregraphSlice) -> DbstoregraphSlice {
  let result = db_store_graph_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_graph_slice_fill(s : DbstoregraphSlice, v : Double) -> DbstoregraphSlice {
  let result = db_store_graph_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_graph_slice_min(s : DbstoregraphSlice) -> Double { @_common.min(s.data) }

pub fn db_store_graph_slice_max(s : DbstoregraphSlice) -> Double { @_common.max(s.data) }

pub fn db_store_graph_slice_to_string(s : DbstoregraphSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

