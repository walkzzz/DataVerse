///===
/// extcore/db_store_matrix

pub(all) struct DbstorematrixPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_matrix_make_point(x : Double, y : Double) -> DbstorematrixPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_matrix_make_point3(x : Double, y : Double, z : Double) -> DbstorematrixPoint {
  { x, y, z, label: 0 }
}

pub fn db_store_matrix_point_x(pt : DbstorematrixPoint) -> Double { pt.x }

pub fn db_store_matrix_point_y(pt : DbstorematrixPoint) -> Double { pt.y }

pub fn db_store_matrix_point_z(pt : DbstorematrixPoint) -> Double { pt.z }

pub fn db_store_matrix_point_label(pt : DbstorematrixPoint) -> Int { pt.label }

pub fn db_store_matrix_point_dist(a : DbstorematrixPoint, b : DbstorematrixPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_store_matrix_point_add(a : DbstorematrixPoint, b : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_store_matrix_point_sub(a : DbstorematrixPoint, b : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_store_matrix_point_scale(pt : DbstorematrixPoint, s : Double) -> DbstorematrixPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_store_matrix_point_dot(a : DbstorematrixPoint, b : DbstorematrixPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_store_matrix_point_cross(a : DbstorematrixPoint, b : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_store_matrix_point_norm(pt : DbstorematrixPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_store_matrix_point_normalize(pt : DbstorematrixPoint) -> DbstorematrixPoint {
  let n = db_store_matrix_point_norm(pt)
  if n < 0.0000001 { pt } else { db_store_matrix_point_scale(pt, 1.0 / n) }
}

pub fn db_store_matrix_point_negate(pt : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_store_matrix_point_mid(a : DbstorematrixPoint, b : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_store_matrix_point_lerp(a : DbstorematrixPoint, b : DbstorematrixPoint, t : Double) -> DbstorematrixPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_store_matrix_point_to_string(pt : DbstorematrixPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbstorematrixSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_matrix_make_series(vals : Array[Double], name : String) -> DbstorematrixSeries {
  { vals, name, meta: 0 }
}

pub fn db_store_matrix_series_len(s : DbstorematrixSeries) -> Int { s.vals.length() }

pub fn db_store_matrix_series_sum(s : DbstorematrixSeries) -> Double { @_common.sum(s.vals) }

pub fn db_store_matrix_series_mean(s : DbstorematrixSeries) -> Double { @_common.mean(s.vals) }

pub fn db_store_matrix_series_min(s : DbstorematrixSeries) -> Double { @_common.min(s.vals) }

pub fn db_store_matrix_series_max(s : DbstorematrixSeries) -> Double { @_common.max(s.vals) }

pub fn db_store_matrix_series_range(s : DbstorematrixSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_store_matrix_series_var(s : DbstorematrixSeries) -> Double { @_common.variance(s.vals) }

pub fn db_store_matrix_series_std(s : DbstorematrixSeries) -> Double { @_common.std(s.vals) }

pub fn db_store_matrix_series_median(s : DbstorematrixSeries) -> Double { @_common.median(s.vals) }

pub fn db_store_matrix_series_scale(s : DbstorematrixSeries, f : Double) -> DbstorematrixSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn db_store_matrix_series_add(a : DbstorematrixSeries, b : DbstorematrixSeries) -> DbstorematrixSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_store_matrix_series_sub(a : DbstorematrixSeries, b : DbstorematrixSeries) -> DbstorematrixSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_store_matrix_series_normalize(s : DbstorematrixSeries) -> DbstorematrixSeries {
  let mn = db_store_matrix_series_min(s)
  let mx = db_store_matrix_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_store_matrix_series_cumsum(s : DbstorematrixSeries) -> DbstorematrixSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_store_matrix_series_to_string(s : DbstorematrixSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstorematrixMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_matrix_make_matrix(rows : Int, cols : Int, val : Double) -> DbstorematrixMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_matrix_matrix_identity(n : Int) -> DbstorematrixMatrix {
  let m = db_store_matrix_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_store_matrix_matrix_get(m : DbstorematrixMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_store_matrix_matrix_transpose(m : DbstorematrixMatrix) -> DbstorematrixMatrix {
  let result = db_store_matrix_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_store_matrix_matrix_add(a : DbstorematrixMatrix, b : DbstorematrixMatrix) -> DbstorematrixMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_store_matrix_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_store_matrix_matrix_scale(m : DbstorematrixMatrix, s : Double) -> DbstorematrixMatrix {
  let result = db_store_matrix_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_store_matrix_matrix_multiply(a : DbstorematrixMatrix, b : DbstorematrixMatrix) -> DbstorematrixMatrix {
  if a.cols != b.rows { return db_store_matrix_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_store_matrix_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_store_matrix_matrix_trace(m : DbstorematrixMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_store_matrix_matrix_det(m : DbstorematrixMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_store_matrix_matrix_norm(m : DbstorematrixMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_store_matrix_matrix_to_string(m : DbstorematrixMatrix) -> String {
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

pub(all) struct DbstorematrixVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_matrix_make_vector(comps : Array[Double]) -> DbstorematrixVector {
  { comps, dim: comps.length() }
}

pub fn db_store_matrix_vector_zero(dim : Int) -> DbstorematrixVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_store_matrix_vector_add(a : DbstorematrixVector, b : DbstorematrixVector) -> DbstorematrixVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn db_store_matrix_vector_sub(a : DbstorematrixVector, b : DbstorematrixVector) -> DbstorematrixVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn db_store_matrix_vector_scale(v : DbstorematrixVector, s : Double) -> DbstorematrixVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn db_store_matrix_vector_dot(a : DbstorematrixVector, b : DbstorematrixVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_store_matrix_vector_norm(v : DbstorematrixVector) -> Double { @_common.sqrt(db_store_matrix_vector_dot(v, v)) }

pub fn db_store_matrix_vector_normalize(v : DbstorematrixVector) -> DbstorematrixVector {
  let n = db_store_matrix_vector_norm(v)
  if n < 0.0000001 { v } else { db_store_matrix_vector_scale(v, 1.0 / n) }
}

pub fn db_store_matrix_vector_dist(a : DbstorematrixVector, b : DbstorematrixVector) -> Double {
  db_store_matrix_vector_norm(db_store_matrix_vector_sub(a, b))
}

pub fn db_store_matrix_vector_to_string(v : DbstorematrixVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_matrix_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_matrix_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_matrix_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_matrix_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_matrix_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_matrix_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_matrix_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_matrix_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_matrix_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_matrix_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_matrix_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_matrix_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_matrix_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_matrix_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_matrix_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_matrix_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_matrix_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_matrix_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_matrix_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_matrix_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_matrix_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_matrix_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_matrix_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_matrix_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_matrix_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_matrix_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_matrix_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_matrix_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_matrix_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstorematrixFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_frame_make(size : Int) -> DbstorematrixFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_frame_len(s : DbstorematrixFrame) -> Int { s.size }

pub fn db_store_matrix_frame_get(s : DbstorematrixFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_frame_set(s : DbstorematrixFrame, i : Int, v : Double) -> DbstorematrixFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_frame_sum(s : DbstorematrixFrame) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_frame_mean(s : DbstorematrixFrame) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_frame_scale(s : DbstorematrixFrame, f : Double) -> DbstorematrixFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_frame_add(a : DbstorematrixFrame, b : DbstorematrixFrame) -> DbstorematrixFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_frame_copy(s : DbstorematrixFrame) -> DbstorematrixFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_frame_fill(s : DbstorematrixFrame, v : Double) -> DbstorematrixFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_frame_min(s : DbstorematrixFrame) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_frame_max(s : DbstorematrixFrame) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_frame_to_string(s : DbstorematrixFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_table_make(size : Int) -> DbstorematrixTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_table_len(s : DbstorematrixTable) -> Int { s.size }

pub fn db_store_matrix_table_get(s : DbstorematrixTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_table_set(s : DbstorematrixTable, i : Int, v : Double) -> DbstorematrixTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_table_sum(s : DbstorematrixTable) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_table_mean(s : DbstorematrixTable) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_table_scale(s : DbstorematrixTable, f : Double) -> DbstorematrixTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_table_add(a : DbstorematrixTable, b : DbstorematrixTable) -> DbstorematrixTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_table_copy(s : DbstorematrixTable) -> DbstorematrixTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_table_fill(s : DbstorematrixTable, v : Double) -> DbstorematrixTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_table_min(s : DbstorematrixTable) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_table_max(s : DbstorematrixTable) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_table_to_string(s : DbstorematrixTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_graphn_make(size : Int) -> DbstorematrixGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_graphn_len(s : DbstorematrixGraphN) -> Int { s.size }

pub fn db_store_matrix_graphn_get(s : DbstorematrixGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_graphn_set(s : DbstorematrixGraphN, i : Int, v : Double) -> DbstorematrixGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_graphn_sum(s : DbstorematrixGraphN) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_graphn_mean(s : DbstorematrixGraphN) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_graphn_scale(s : DbstorematrixGraphN, f : Double) -> DbstorematrixGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_graphn_add(a : DbstorematrixGraphN, b : DbstorematrixGraphN) -> DbstorematrixGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_graphn_copy(s : DbstorematrixGraphN) -> DbstorematrixGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_graphn_fill(s : DbstorematrixGraphN, v : Double) -> DbstorematrixGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_graphn_min(s : DbstorematrixGraphN) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_graphn_max(s : DbstorematrixGraphN) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_graphn_to_string(s : DbstorematrixGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_node_make(size : Int) -> DbstorematrixNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_node_len(s : DbstorematrixNode) -> Int { s.size }

pub fn db_store_matrix_node_get(s : DbstorematrixNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_node_set(s : DbstorematrixNode, i : Int, v : Double) -> DbstorematrixNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_node_sum(s : DbstorematrixNode) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_node_mean(s : DbstorematrixNode) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_node_scale(s : DbstorematrixNode, f : Double) -> DbstorematrixNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_node_add(a : DbstorematrixNode, b : DbstorematrixNode) -> DbstorematrixNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_node_copy(s : DbstorematrixNode) -> DbstorematrixNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_node_fill(s : DbstorematrixNode, v : Double) -> DbstorematrixNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_node_min(s : DbstorematrixNode) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_node_max(s : DbstorematrixNode) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_node_to_string(s : DbstorematrixNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_edge_make(size : Int) -> DbstorematrixEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_edge_len(s : DbstorematrixEdge) -> Int { s.size }

pub fn db_store_matrix_edge_get(s : DbstorematrixEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_edge_set(s : DbstorematrixEdge, i : Int, v : Double) -> DbstorematrixEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_edge_sum(s : DbstorematrixEdge) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_edge_mean(s : DbstorematrixEdge) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_edge_scale(s : DbstorematrixEdge, f : Double) -> DbstorematrixEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_edge_add(a : DbstorematrixEdge, b : DbstorematrixEdge) -> DbstorematrixEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_edge_copy(s : DbstorematrixEdge) -> DbstorematrixEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_edge_fill(s : DbstorematrixEdge, v : Double) -> DbstorematrixEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_edge_min(s : DbstorematrixEdge) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_edge_max(s : DbstorematrixEdge) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_edge_to_string(s : DbstorematrixEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_path_make(size : Int) -> DbstorematrixPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_path_len(s : DbstorematrixPath) -> Int { s.size }

pub fn db_store_matrix_path_get(s : DbstorematrixPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_path_set(s : DbstorematrixPath, i : Int, v : Double) -> DbstorematrixPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_path_sum(s : DbstorematrixPath) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_path_mean(s : DbstorematrixPath) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_path_scale(s : DbstorematrixPath, f : Double) -> DbstorematrixPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_path_add(a : DbstorematrixPath, b : DbstorematrixPath) -> DbstorematrixPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_path_copy(s : DbstorematrixPath) -> DbstorematrixPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_path_fill(s : DbstorematrixPath, v : Double) -> DbstorematrixPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_path_min(s : DbstorematrixPath) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_path_max(s : DbstorematrixPath) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_path_to_string(s : DbstorematrixPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_cluster_make(size : Int) -> DbstorematrixCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_cluster_len(s : DbstorematrixCluster) -> Int { s.size }

pub fn db_store_matrix_cluster_get(s : DbstorematrixCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_cluster_set(s : DbstorematrixCluster, i : Int, v : Double) -> DbstorematrixCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_cluster_sum(s : DbstorematrixCluster) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_cluster_mean(s : DbstorematrixCluster) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_cluster_scale(s : DbstorematrixCluster, f : Double) -> DbstorematrixCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_cluster_add(a : DbstorematrixCluster, b : DbstorematrixCluster) -> DbstorematrixCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_cluster_copy(s : DbstorematrixCluster) -> DbstorematrixCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_cluster_fill(s : DbstorematrixCluster, v : Double) -> DbstorematrixCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_cluster_min(s : DbstorematrixCluster) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_cluster_max(s : DbstorematrixCluster) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_cluster_to_string(s : DbstorematrixCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_model_make(size : Int) -> DbstorematrixModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_model_len(s : DbstorematrixModel) -> Int { s.size }

pub fn db_store_matrix_model_get(s : DbstorematrixModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_model_set(s : DbstorematrixModel, i : Int, v : Double) -> DbstorematrixModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_model_sum(s : DbstorematrixModel) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_model_mean(s : DbstorematrixModel) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_model_scale(s : DbstorematrixModel, f : Double) -> DbstorematrixModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_model_add(a : DbstorematrixModel, b : DbstorematrixModel) -> DbstorematrixModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_model_copy(s : DbstorematrixModel) -> DbstorematrixModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_model_fill(s : DbstorematrixModel, v : Double) -> DbstorematrixModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_model_min(s : DbstorematrixModel) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_model_max(s : DbstorematrixModel) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_model_to_string(s : DbstorematrixModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_layer_make(size : Int) -> DbstorematrixLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_layer_len(s : DbstorematrixLayer) -> Int { s.size }

pub fn db_store_matrix_layer_get(s : DbstorematrixLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_layer_set(s : DbstorematrixLayer, i : Int, v : Double) -> DbstorematrixLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_layer_sum(s : DbstorematrixLayer) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_layer_mean(s : DbstorematrixLayer) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_layer_scale(s : DbstorematrixLayer, f : Double) -> DbstorematrixLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_layer_add(a : DbstorematrixLayer, b : DbstorematrixLayer) -> DbstorematrixLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_layer_copy(s : DbstorematrixLayer) -> DbstorematrixLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_layer_fill(s : DbstorematrixLayer, v : Double) -> DbstorematrixLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_layer_min(s : DbstorematrixLayer) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_layer_max(s : DbstorematrixLayer) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_layer_to_string(s : DbstorematrixLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_buffer_make(size : Int) -> DbstorematrixBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_buffer_len(s : DbstorematrixBuffer) -> Int { s.size }

pub fn db_store_matrix_buffer_get(s : DbstorematrixBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_buffer_set(s : DbstorematrixBuffer, i : Int, v : Double) -> DbstorematrixBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_buffer_sum(s : DbstorematrixBuffer) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_buffer_mean(s : DbstorematrixBuffer) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_buffer_scale(s : DbstorematrixBuffer, f : Double) -> DbstorematrixBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_buffer_add(a : DbstorematrixBuffer, b : DbstorematrixBuffer) -> DbstorematrixBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_buffer_copy(s : DbstorematrixBuffer) -> DbstorematrixBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_buffer_fill(s : DbstorematrixBuffer, v : Double) -> DbstorematrixBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_buffer_min(s : DbstorematrixBuffer) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_buffer_max(s : DbstorematrixBuffer) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_buffer_to_string(s : DbstorematrixBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_cursor_make(size : Int) -> DbstorematrixCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_cursor_len(s : DbstorematrixCursor) -> Int { s.size }

pub fn db_store_matrix_cursor_get(s : DbstorematrixCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_cursor_set(s : DbstorematrixCursor, i : Int, v : Double) -> DbstorematrixCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_cursor_sum(s : DbstorematrixCursor) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_cursor_mean(s : DbstorematrixCursor) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_cursor_scale(s : DbstorematrixCursor, f : Double) -> DbstorematrixCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_cursor_add(a : DbstorematrixCursor, b : DbstorematrixCursor) -> DbstorematrixCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_cursor_copy(s : DbstorematrixCursor) -> DbstorematrixCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_cursor_fill(s : DbstorematrixCursor, v : Double) -> DbstorematrixCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_cursor_min(s : DbstorematrixCursor) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_cursor_max(s : DbstorematrixCursor) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_cursor_to_string(s : DbstorematrixCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_view_make(size : Int) -> DbstorematrixView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_view_len(s : DbstorematrixView) -> Int { s.size }

pub fn db_store_matrix_view_get(s : DbstorematrixView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_view_set(s : DbstorematrixView, i : Int, v : Double) -> DbstorematrixView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_view_sum(s : DbstorematrixView) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_view_mean(s : DbstorematrixView) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_view_scale(s : DbstorematrixView, f : Double) -> DbstorematrixView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_view_add(a : DbstorematrixView, b : DbstorematrixView) -> DbstorematrixView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_view_copy(s : DbstorematrixView) -> DbstorematrixView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_view_fill(s : DbstorematrixView, v : Double) -> DbstorematrixView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_view_min(s : DbstorematrixView) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_view_max(s : DbstorematrixView) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_view_to_string(s : DbstorematrixView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_range_make(size : Int) -> DbstorematrixRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_range_len(s : DbstorematrixRange) -> Int { s.size }

pub fn db_store_matrix_range_get(s : DbstorematrixRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_range_set(s : DbstorematrixRange, i : Int, v : Double) -> DbstorematrixRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_range_sum(s : DbstorematrixRange) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_range_mean(s : DbstorematrixRange) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_range_scale(s : DbstorematrixRange, f : Double) -> DbstorematrixRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_range_add(a : DbstorematrixRange, b : DbstorematrixRange) -> DbstorematrixRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_range_copy(s : DbstorematrixRange) -> DbstorematrixRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_range_fill(s : DbstorematrixRange, v : Double) -> DbstorematrixRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_range_min(s : DbstorematrixRange) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_range_max(s : DbstorematrixRange) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_range_to_string(s : DbstorematrixRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_slice_make(size : Int) -> DbstorematrixSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_slice_len(s : DbstorematrixSlice) -> Int { s.size }

pub fn db_store_matrix_slice_get(s : DbstorematrixSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_slice_set(s : DbstorematrixSlice, i : Int, v : Double) -> DbstorematrixSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_matrix_slice_sum(s : DbstorematrixSlice) -> Double { @_common.sum(s.data) }

pub fn db_store_matrix_slice_mean(s : DbstorematrixSlice) -> Double { @_common.mean(s.data) }

pub fn db_store_matrix_slice_scale(s : DbstorematrixSlice, f : Double) -> DbstorematrixSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_slice_add(a : DbstorematrixSlice, b : DbstorematrixSlice) -> DbstorematrixSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_matrix_slice_copy(s : DbstorematrixSlice) -> DbstorematrixSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_slice_fill(s : DbstorematrixSlice, v : Double) -> DbstorematrixSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_matrix_slice_min(s : DbstorematrixSlice) -> Double { @_common.min(s.data) }

pub fn db_store_matrix_slice_max(s : DbstorematrixSlice) -> Double { @_common.max(s.data) }

pub fn db_store_matrix_slice_to_string(s : DbstorematrixSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

