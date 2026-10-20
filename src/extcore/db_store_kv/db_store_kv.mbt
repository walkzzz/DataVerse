///===
/// extcore/db_store_kv

pub(all) struct DbstorekvPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_kv_make_point(x : Double, y : Double) -> DbstorekvPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_kv_make_point3(x : Double, y : Double, z : Double) -> DbstorekvPoint {
  { x, y, z, label: 0 }
}

pub fn db_store_kv_point_x(pt : DbstorekvPoint) -> Double { pt.x }

pub fn db_store_kv_point_y(pt : DbstorekvPoint) -> Double { pt.y }

pub fn db_store_kv_point_z(pt : DbstorekvPoint) -> Double { pt.z }

pub fn db_store_kv_point_label(pt : DbstorekvPoint) -> Int { pt.label }

pub fn db_store_kv_point_dist(a : DbstorekvPoint, b : DbstorekvPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_store_kv_point_add(a : DbstorekvPoint, b : DbstorekvPoint) -> DbstorekvPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_store_kv_point_sub(a : DbstorekvPoint, b : DbstorekvPoint) -> DbstorekvPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_store_kv_point_scale(pt : DbstorekvPoint, s : Double) -> DbstorekvPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_store_kv_point_dot(a : DbstorekvPoint, b : DbstorekvPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_store_kv_point_cross(a : DbstorekvPoint, b : DbstorekvPoint) -> DbstorekvPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_store_kv_point_norm(pt : DbstorekvPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_store_kv_point_normalize(pt : DbstorekvPoint) -> DbstorekvPoint {
  let n = db_store_kv_point_norm(pt)
  if n < 0.0000001 { pt } else { db_store_kv_point_scale(pt, 1.0 / n) }
}

pub fn db_store_kv_point_negate(pt : DbstorekvPoint) -> DbstorekvPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_store_kv_point_mid(a : DbstorekvPoint, b : DbstorekvPoint) -> DbstorekvPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_store_kv_point_lerp(a : DbstorekvPoint, b : DbstorekvPoint, t : Double) -> DbstorekvPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_store_kv_point_to_string(pt : DbstorekvPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbstorekvSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_kv_make_series(vals : Array[Double], name : String) -> DbstorekvSeries {
  { vals, name, meta: 0 }
}

pub fn db_store_kv_series_len(s : DbstorekvSeries) -> Int { s.vals.length() }

pub fn db_store_kv_series_sum(s : DbstorekvSeries) -> Double { @_common.sum(s.vals) }

pub fn db_store_kv_series_mean(s : DbstorekvSeries) -> Double { @_common.mean(s.vals) }

pub fn db_store_kv_series_min(s : DbstorekvSeries) -> Double { @_common.min(s.vals) }

pub fn db_store_kv_series_max(s : DbstorekvSeries) -> Double { @_common.max(s.vals) }

pub fn db_store_kv_series_range(s : DbstorekvSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_store_kv_series_var(s : DbstorekvSeries) -> Double { @_common.variance(s.vals) }

pub fn db_store_kv_series_std(s : DbstorekvSeries) -> Double { @_common.std(s.vals) }

pub fn db_store_kv_series_median(s : DbstorekvSeries) -> Double { @_common.median(s.vals) }

pub fn db_store_kv_series_scale(s : DbstorekvSeries, f : Double) -> DbstorekvSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn db_store_kv_series_add(a : DbstorekvSeries, b : DbstorekvSeries) -> DbstorekvSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_store_kv_series_sub(a : DbstorekvSeries, b : DbstorekvSeries) -> DbstorekvSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_store_kv_series_normalize(s : DbstorekvSeries) -> DbstorekvSeries {
  let mn = db_store_kv_series_min(s)
  let mx = db_store_kv_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_store_kv_series_cumsum(s : DbstorekvSeries) -> DbstorekvSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_store_kv_series_to_string(s : DbstorekvSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstorekvMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_kv_make_matrix(rows : Int, cols : Int, val : Double) -> DbstorekvMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_kv_matrix_identity(n : Int) -> DbstorekvMatrix {
  let m = db_store_kv_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_store_kv_matrix_get(m : DbstorekvMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_store_kv_matrix_transpose(m : DbstorekvMatrix) -> DbstorekvMatrix {
  let result = db_store_kv_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_store_kv_matrix_add(a : DbstorekvMatrix, b : DbstorekvMatrix) -> DbstorekvMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_store_kv_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_store_kv_matrix_scale(m : DbstorekvMatrix, s : Double) -> DbstorekvMatrix {
  let result = db_store_kv_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_store_kv_matrix_multiply(a : DbstorekvMatrix, b : DbstorekvMatrix) -> DbstorekvMatrix {
  if a.cols != b.rows { return db_store_kv_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_store_kv_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_store_kv_matrix_trace(m : DbstorekvMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_store_kv_matrix_det(m : DbstorekvMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_store_kv_matrix_norm(m : DbstorekvMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_store_kv_matrix_to_string(m : DbstorekvMatrix) -> String {
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

pub(all) struct DbstorekvVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_kv_make_vector(comps : Array[Double]) -> DbstorekvVector {
  { comps, dim: comps.length() }
}

pub fn db_store_kv_vector_zero(dim : Int) -> DbstorekvVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_store_kv_vector_add(a : DbstorekvVector, b : DbstorekvVector) -> DbstorekvVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn db_store_kv_vector_sub(a : DbstorekvVector, b : DbstorekvVector) -> DbstorekvVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn db_store_kv_vector_scale(v : DbstorekvVector, s : Double) -> DbstorekvVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn db_store_kv_vector_dot(a : DbstorekvVector, b : DbstorekvVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_store_kv_vector_norm(v : DbstorekvVector) -> Double { @_common.sqrt(db_store_kv_vector_dot(v, v)) }

pub fn db_store_kv_vector_normalize(v : DbstorekvVector) -> DbstorekvVector {
  let n = db_store_kv_vector_norm(v)
  if n < 0.0000001 { v } else { db_store_kv_vector_scale(v, 1.0 / n) }
}

pub fn db_store_kv_vector_dist(a : DbstorekvVector, b : DbstorekvVector) -> Double {
  db_store_kv_vector_norm(db_store_kv_vector_sub(a, b))
}

pub fn db_store_kv_vector_to_string(v : DbstorekvVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_kv_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_kv_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_kv_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_kv_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_kv_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_kv_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_kv_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_kv_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_kv_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_kv_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_kv_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_kv_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_kv_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_kv_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_kv_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_kv_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_kv_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_kv_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_kv_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_kv_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_kv_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_kv_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_kv_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_kv_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_kv_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_kv_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_kv_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_kv_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_kv_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstorekvFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_frame_make(size : Int) -> DbstorekvFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_frame_len(s : DbstorekvFrame) -> Int { s.size }

pub fn db_store_kv_frame_get(s : DbstorekvFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_frame_set(s : DbstorekvFrame, i : Int, v : Double) -> DbstorekvFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_frame_sum(s : DbstorekvFrame) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_frame_mean(s : DbstorekvFrame) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_frame_scale(s : DbstorekvFrame, f : Double) -> DbstorekvFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_frame_add(a : DbstorekvFrame, b : DbstorekvFrame) -> DbstorekvFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_frame_copy(s : DbstorekvFrame) -> DbstorekvFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_frame_fill(s : DbstorekvFrame, v : Double) -> DbstorekvFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_frame_min(s : DbstorekvFrame) -> Double { @_common.min(s.data) }

pub fn db_store_kv_frame_max(s : DbstorekvFrame) -> Double { @_common.max(s.data) }

pub fn db_store_kv_frame_to_string(s : DbstorekvFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_table_make(size : Int) -> DbstorekvTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_table_len(s : DbstorekvTable) -> Int { s.size }

pub fn db_store_kv_table_get(s : DbstorekvTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_table_set(s : DbstorekvTable, i : Int, v : Double) -> DbstorekvTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_table_sum(s : DbstorekvTable) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_table_mean(s : DbstorekvTable) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_table_scale(s : DbstorekvTable, f : Double) -> DbstorekvTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_table_add(a : DbstorekvTable, b : DbstorekvTable) -> DbstorekvTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_table_copy(s : DbstorekvTable) -> DbstorekvTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_table_fill(s : DbstorekvTable, v : Double) -> DbstorekvTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_table_min(s : DbstorekvTable) -> Double { @_common.min(s.data) }

pub fn db_store_kv_table_max(s : DbstorekvTable) -> Double { @_common.max(s.data) }

pub fn db_store_kv_table_to_string(s : DbstorekvTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_graphn_make(size : Int) -> DbstorekvGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_graphn_len(s : DbstorekvGraphN) -> Int { s.size }

pub fn db_store_kv_graphn_get(s : DbstorekvGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_graphn_set(s : DbstorekvGraphN, i : Int, v : Double) -> DbstorekvGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_graphn_sum(s : DbstorekvGraphN) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_graphn_mean(s : DbstorekvGraphN) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_graphn_scale(s : DbstorekvGraphN, f : Double) -> DbstorekvGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_graphn_add(a : DbstorekvGraphN, b : DbstorekvGraphN) -> DbstorekvGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_graphn_copy(s : DbstorekvGraphN) -> DbstorekvGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_graphn_fill(s : DbstorekvGraphN, v : Double) -> DbstorekvGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_graphn_min(s : DbstorekvGraphN) -> Double { @_common.min(s.data) }

pub fn db_store_kv_graphn_max(s : DbstorekvGraphN) -> Double { @_common.max(s.data) }

pub fn db_store_kv_graphn_to_string(s : DbstorekvGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_node_make(size : Int) -> DbstorekvNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_node_len(s : DbstorekvNode) -> Int { s.size }

pub fn db_store_kv_node_get(s : DbstorekvNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_node_set(s : DbstorekvNode, i : Int, v : Double) -> DbstorekvNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_node_sum(s : DbstorekvNode) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_node_mean(s : DbstorekvNode) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_node_scale(s : DbstorekvNode, f : Double) -> DbstorekvNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_node_add(a : DbstorekvNode, b : DbstorekvNode) -> DbstorekvNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_node_copy(s : DbstorekvNode) -> DbstorekvNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_node_fill(s : DbstorekvNode, v : Double) -> DbstorekvNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_node_min(s : DbstorekvNode) -> Double { @_common.min(s.data) }

pub fn db_store_kv_node_max(s : DbstorekvNode) -> Double { @_common.max(s.data) }

pub fn db_store_kv_node_to_string(s : DbstorekvNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_edge_make(size : Int) -> DbstorekvEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_edge_len(s : DbstorekvEdge) -> Int { s.size }

pub fn db_store_kv_edge_get(s : DbstorekvEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_edge_set(s : DbstorekvEdge, i : Int, v : Double) -> DbstorekvEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_edge_sum(s : DbstorekvEdge) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_edge_mean(s : DbstorekvEdge) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_edge_scale(s : DbstorekvEdge, f : Double) -> DbstorekvEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_edge_add(a : DbstorekvEdge, b : DbstorekvEdge) -> DbstorekvEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_edge_copy(s : DbstorekvEdge) -> DbstorekvEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_edge_fill(s : DbstorekvEdge, v : Double) -> DbstorekvEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_edge_min(s : DbstorekvEdge) -> Double { @_common.min(s.data) }

pub fn db_store_kv_edge_max(s : DbstorekvEdge) -> Double { @_common.max(s.data) }

pub fn db_store_kv_edge_to_string(s : DbstorekvEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_path_make(size : Int) -> DbstorekvPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_path_len(s : DbstorekvPath) -> Int { s.size }

pub fn db_store_kv_path_get(s : DbstorekvPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_path_set(s : DbstorekvPath, i : Int, v : Double) -> DbstorekvPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_path_sum(s : DbstorekvPath) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_path_mean(s : DbstorekvPath) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_path_scale(s : DbstorekvPath, f : Double) -> DbstorekvPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_path_add(a : DbstorekvPath, b : DbstorekvPath) -> DbstorekvPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_path_copy(s : DbstorekvPath) -> DbstorekvPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_path_fill(s : DbstorekvPath, v : Double) -> DbstorekvPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_path_min(s : DbstorekvPath) -> Double { @_common.min(s.data) }

pub fn db_store_kv_path_max(s : DbstorekvPath) -> Double { @_common.max(s.data) }

pub fn db_store_kv_path_to_string(s : DbstorekvPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_cluster_make(size : Int) -> DbstorekvCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_cluster_len(s : DbstorekvCluster) -> Int { s.size }

pub fn db_store_kv_cluster_get(s : DbstorekvCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_cluster_set(s : DbstorekvCluster, i : Int, v : Double) -> DbstorekvCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_cluster_sum(s : DbstorekvCluster) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_cluster_mean(s : DbstorekvCluster) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_cluster_scale(s : DbstorekvCluster, f : Double) -> DbstorekvCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_cluster_add(a : DbstorekvCluster, b : DbstorekvCluster) -> DbstorekvCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_cluster_copy(s : DbstorekvCluster) -> DbstorekvCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_cluster_fill(s : DbstorekvCluster, v : Double) -> DbstorekvCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_cluster_min(s : DbstorekvCluster) -> Double { @_common.min(s.data) }

pub fn db_store_kv_cluster_max(s : DbstorekvCluster) -> Double { @_common.max(s.data) }

pub fn db_store_kv_cluster_to_string(s : DbstorekvCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_model_make(size : Int) -> DbstorekvModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_model_len(s : DbstorekvModel) -> Int { s.size }

pub fn db_store_kv_model_get(s : DbstorekvModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_model_set(s : DbstorekvModel, i : Int, v : Double) -> DbstorekvModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_model_sum(s : DbstorekvModel) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_model_mean(s : DbstorekvModel) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_model_scale(s : DbstorekvModel, f : Double) -> DbstorekvModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_model_add(a : DbstorekvModel, b : DbstorekvModel) -> DbstorekvModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_model_copy(s : DbstorekvModel) -> DbstorekvModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_model_fill(s : DbstorekvModel, v : Double) -> DbstorekvModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_model_min(s : DbstorekvModel) -> Double { @_common.min(s.data) }

pub fn db_store_kv_model_max(s : DbstorekvModel) -> Double { @_common.max(s.data) }

pub fn db_store_kv_model_to_string(s : DbstorekvModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_layer_make(size : Int) -> DbstorekvLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_layer_len(s : DbstorekvLayer) -> Int { s.size }

pub fn db_store_kv_layer_get(s : DbstorekvLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_layer_set(s : DbstorekvLayer, i : Int, v : Double) -> DbstorekvLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_layer_sum(s : DbstorekvLayer) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_layer_mean(s : DbstorekvLayer) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_layer_scale(s : DbstorekvLayer, f : Double) -> DbstorekvLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_layer_add(a : DbstorekvLayer, b : DbstorekvLayer) -> DbstorekvLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_layer_copy(s : DbstorekvLayer) -> DbstorekvLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_layer_fill(s : DbstorekvLayer, v : Double) -> DbstorekvLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_layer_min(s : DbstorekvLayer) -> Double { @_common.min(s.data) }

pub fn db_store_kv_layer_max(s : DbstorekvLayer) -> Double { @_common.max(s.data) }

pub fn db_store_kv_layer_to_string(s : DbstorekvLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_buffer_make(size : Int) -> DbstorekvBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_buffer_len(s : DbstorekvBuffer) -> Int { s.size }

pub fn db_store_kv_buffer_get(s : DbstorekvBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_buffer_set(s : DbstorekvBuffer, i : Int, v : Double) -> DbstorekvBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_buffer_sum(s : DbstorekvBuffer) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_buffer_mean(s : DbstorekvBuffer) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_buffer_scale(s : DbstorekvBuffer, f : Double) -> DbstorekvBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_buffer_add(a : DbstorekvBuffer, b : DbstorekvBuffer) -> DbstorekvBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_buffer_copy(s : DbstorekvBuffer) -> DbstorekvBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_buffer_fill(s : DbstorekvBuffer, v : Double) -> DbstorekvBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_buffer_min(s : DbstorekvBuffer) -> Double { @_common.min(s.data) }

pub fn db_store_kv_buffer_max(s : DbstorekvBuffer) -> Double { @_common.max(s.data) }

pub fn db_store_kv_buffer_to_string(s : DbstorekvBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_cursor_make(size : Int) -> DbstorekvCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_cursor_len(s : DbstorekvCursor) -> Int { s.size }

pub fn db_store_kv_cursor_get(s : DbstorekvCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_cursor_set(s : DbstorekvCursor, i : Int, v : Double) -> DbstorekvCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_cursor_sum(s : DbstorekvCursor) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_cursor_mean(s : DbstorekvCursor) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_cursor_scale(s : DbstorekvCursor, f : Double) -> DbstorekvCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_cursor_add(a : DbstorekvCursor, b : DbstorekvCursor) -> DbstorekvCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_cursor_copy(s : DbstorekvCursor) -> DbstorekvCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_cursor_fill(s : DbstorekvCursor, v : Double) -> DbstorekvCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_cursor_min(s : DbstorekvCursor) -> Double { @_common.min(s.data) }

pub fn db_store_kv_cursor_max(s : DbstorekvCursor) -> Double { @_common.max(s.data) }

pub fn db_store_kv_cursor_to_string(s : DbstorekvCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_view_make(size : Int) -> DbstorekvView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_view_len(s : DbstorekvView) -> Int { s.size }

pub fn db_store_kv_view_get(s : DbstorekvView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_view_set(s : DbstorekvView, i : Int, v : Double) -> DbstorekvView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_view_sum(s : DbstorekvView) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_view_mean(s : DbstorekvView) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_view_scale(s : DbstorekvView, f : Double) -> DbstorekvView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_view_add(a : DbstorekvView, b : DbstorekvView) -> DbstorekvView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_view_copy(s : DbstorekvView) -> DbstorekvView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_view_fill(s : DbstorekvView, v : Double) -> DbstorekvView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_view_min(s : DbstorekvView) -> Double { @_common.min(s.data) }

pub fn db_store_kv_view_max(s : DbstorekvView) -> Double { @_common.max(s.data) }

pub fn db_store_kv_view_to_string(s : DbstorekvView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_range_make(size : Int) -> DbstorekvRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_range_len(s : DbstorekvRange) -> Int { s.size }

pub fn db_store_kv_range_get(s : DbstorekvRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_range_set(s : DbstorekvRange, i : Int, v : Double) -> DbstorekvRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_range_sum(s : DbstorekvRange) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_range_mean(s : DbstorekvRange) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_range_scale(s : DbstorekvRange, f : Double) -> DbstorekvRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_range_add(a : DbstorekvRange, b : DbstorekvRange) -> DbstorekvRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_range_copy(s : DbstorekvRange) -> DbstorekvRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_range_fill(s : DbstorekvRange, v : Double) -> DbstorekvRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_range_min(s : DbstorekvRange) -> Double { @_common.min(s.data) }

pub fn db_store_kv_range_max(s : DbstorekvRange) -> Double { @_common.max(s.data) }

pub fn db_store_kv_range_to_string(s : DbstorekvRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_slice_make(size : Int) -> DbstorekvSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_slice_len(s : DbstorekvSlice) -> Int { s.size }

pub fn db_store_kv_slice_get(s : DbstorekvSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_slice_set(s : DbstorekvSlice, i : Int, v : Double) -> DbstorekvSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_kv_slice_sum(s : DbstorekvSlice) -> Double { @_common.sum(s.data) }

pub fn db_store_kv_slice_mean(s : DbstorekvSlice) -> Double { @_common.mean(s.data) }

pub fn db_store_kv_slice_scale(s : DbstorekvSlice, f : Double) -> DbstorekvSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_kv_slice_add(a : DbstorekvSlice, b : DbstorekvSlice) -> DbstorekvSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_kv_slice_copy(s : DbstorekvSlice) -> DbstorekvSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_kv_slice_fill(s : DbstorekvSlice, v : Double) -> DbstorekvSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_kv_slice_min(s : DbstorekvSlice) -> Double { @_common.min(s.data) }

pub fn db_store_kv_slice_max(s : DbstorekvSlice) -> Double { @_common.max(s.data) }

pub fn db_store_kv_slice_to_string(s : DbstorekvSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

