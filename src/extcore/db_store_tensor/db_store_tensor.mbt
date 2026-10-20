///===
/// extcore/db_store_tensor

pub(all) struct DbstoretensorPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_tensor_make_point(x : Double, y : Double) -> DbstoretensorPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_tensor_make_point3(x : Double, y : Double, z : Double) -> DbstoretensorPoint {
  { x, y, z, label: 0 }
}

pub fn db_store_tensor_point_x(pt : DbstoretensorPoint) -> Double { pt.x }

pub fn db_store_tensor_point_y(pt : DbstoretensorPoint) -> Double { pt.y }

pub fn db_store_tensor_point_z(pt : DbstoretensorPoint) -> Double { pt.z }

pub fn db_store_tensor_point_label(pt : DbstoretensorPoint) -> Int { pt.label }

pub fn db_store_tensor_point_dist(a : DbstoretensorPoint, b : DbstoretensorPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_store_tensor_point_add(a : DbstoretensorPoint, b : DbstoretensorPoint) -> DbstoretensorPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_store_tensor_point_sub(a : DbstoretensorPoint, b : DbstoretensorPoint) -> DbstoretensorPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_store_tensor_point_scale(pt : DbstoretensorPoint, s : Double) -> DbstoretensorPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_store_tensor_point_dot(a : DbstoretensorPoint, b : DbstoretensorPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_store_tensor_point_cross(a : DbstoretensorPoint, b : DbstoretensorPoint) -> DbstoretensorPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_store_tensor_point_norm(pt : DbstoretensorPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_store_tensor_point_normalize(pt : DbstoretensorPoint) -> DbstoretensorPoint {
  let n = db_store_tensor_point_norm(pt)
  if n < 0.0000001 { pt } else { db_store_tensor_point_scale(pt, 1.0 / n) }
}

pub fn db_store_tensor_point_negate(pt : DbstoretensorPoint) -> DbstoretensorPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_store_tensor_point_mid(a : DbstoretensorPoint, b : DbstoretensorPoint) -> DbstoretensorPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_store_tensor_point_lerp(a : DbstoretensorPoint, b : DbstoretensorPoint, t : Double) -> DbstoretensorPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_store_tensor_point_to_string(pt : DbstoretensorPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbstoretensorSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_tensor_make_series(vals : Array[Double], name : String) -> DbstoretensorSeries {
  { vals, name, meta: 0 }
}

pub fn db_store_tensor_series_len(s : DbstoretensorSeries) -> Int { s.vals.length() }

pub fn db_store_tensor_series_sum(s : DbstoretensorSeries) -> Double { @_common.sum(s.vals) }

pub fn db_store_tensor_series_mean(s : DbstoretensorSeries) -> Double { @_common.mean(s.vals) }

pub fn db_store_tensor_series_min(s : DbstoretensorSeries) -> Double { @_common.min(s.vals) }

pub fn db_store_tensor_series_max(s : DbstoretensorSeries) -> Double { @_common.max(s.vals) }

pub fn db_store_tensor_series_range(s : DbstoretensorSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_store_tensor_series_var(s : DbstoretensorSeries) -> Double { @_common.variance(s.vals) }

pub fn db_store_tensor_series_std(s : DbstoretensorSeries) -> Double { @_common.std(s.vals) }

pub fn db_store_tensor_series_median(s : DbstoretensorSeries) -> Double { @_common.median(s.vals) }

pub fn db_store_tensor_series_scale(s : DbstoretensorSeries, f : Double) -> DbstoretensorSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn db_store_tensor_series_add(a : DbstoretensorSeries, b : DbstoretensorSeries) -> DbstoretensorSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_store_tensor_series_sub(a : DbstoretensorSeries, b : DbstoretensorSeries) -> DbstoretensorSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_store_tensor_series_normalize(s : DbstoretensorSeries) -> DbstoretensorSeries {
  let mn = db_store_tensor_series_min(s)
  let mx = db_store_tensor_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_store_tensor_series_cumsum(s : DbstoretensorSeries) -> DbstoretensorSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_store_tensor_series_to_string(s : DbstoretensorSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstoretensorMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_tensor_make_matrix(rows : Int, cols : Int, val : Double) -> DbstoretensorMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_tensor_matrix_identity(n : Int) -> DbstoretensorMatrix {
  let m = db_store_tensor_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_store_tensor_matrix_get(m : DbstoretensorMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_store_tensor_matrix_transpose(m : DbstoretensorMatrix) -> DbstoretensorMatrix {
  let result = db_store_tensor_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_store_tensor_matrix_add(a : DbstoretensorMatrix, b : DbstoretensorMatrix) -> DbstoretensorMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_store_tensor_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_store_tensor_matrix_scale(m : DbstoretensorMatrix, s : Double) -> DbstoretensorMatrix {
  let result = db_store_tensor_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_store_tensor_matrix_multiply(a : DbstoretensorMatrix, b : DbstoretensorMatrix) -> DbstoretensorMatrix {
  if a.cols != b.rows { return db_store_tensor_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_store_tensor_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_store_tensor_matrix_trace(m : DbstoretensorMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_store_tensor_matrix_det(m : DbstoretensorMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_store_tensor_matrix_norm(m : DbstoretensorMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_store_tensor_matrix_to_string(m : DbstoretensorMatrix) -> String {
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

pub(all) struct DbstoretensorVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_tensor_make_vector(comps : Array[Double]) -> DbstoretensorVector {
  { comps, dim: comps.length() }
}

pub fn db_store_tensor_vector_zero(dim : Int) -> DbstoretensorVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_store_tensor_vector_add(a : DbstoretensorVector, b : DbstoretensorVector) -> DbstoretensorVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn db_store_tensor_vector_sub(a : DbstoretensorVector, b : DbstoretensorVector) -> DbstoretensorVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn db_store_tensor_vector_scale(v : DbstoretensorVector, s : Double) -> DbstoretensorVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn db_store_tensor_vector_dot(a : DbstoretensorVector, b : DbstoretensorVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_store_tensor_vector_norm(v : DbstoretensorVector) -> Double { @_common.sqrt(db_store_tensor_vector_dot(v, v)) }

pub fn db_store_tensor_vector_normalize(v : DbstoretensorVector) -> DbstoretensorVector {
  let n = db_store_tensor_vector_norm(v)
  if n < 0.0000001 { v } else { db_store_tensor_vector_scale(v, 1.0 / n) }
}

pub fn db_store_tensor_vector_dist(a : DbstoretensorVector, b : DbstoretensorVector) -> Double {
  db_store_tensor_vector_norm(db_store_tensor_vector_sub(a, b))
}

pub fn db_store_tensor_vector_to_string(v : DbstoretensorVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_tensor_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_tensor_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_tensor_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_tensor_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_tensor_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_tensor_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_tensor_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_tensor_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_tensor_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_tensor_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_tensor_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_tensor_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_tensor_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_tensor_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_tensor_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_tensor_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_tensor_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_tensor_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_tensor_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_tensor_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_tensor_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_tensor_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_tensor_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_tensor_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_tensor_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_tensor_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_tensor_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_tensor_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_tensor_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstoretensorFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_frame_make(size : Int) -> DbstoretensorFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_frame_len(s : DbstoretensorFrame) -> Int { s.size }

pub fn db_store_tensor_frame_get(s : DbstoretensorFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_frame_set(s : DbstoretensorFrame, i : Int, v : Double) -> DbstoretensorFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_frame_sum(s : DbstoretensorFrame) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_frame_mean(s : DbstoretensorFrame) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_frame_scale(s : DbstoretensorFrame, f : Double) -> DbstoretensorFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_frame_add(a : DbstoretensorFrame, b : DbstoretensorFrame) -> DbstoretensorFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_frame_copy(s : DbstoretensorFrame) -> DbstoretensorFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_frame_fill(s : DbstoretensorFrame, v : Double) -> DbstoretensorFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_frame_min(s : DbstoretensorFrame) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_frame_max(s : DbstoretensorFrame) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_frame_to_string(s : DbstoretensorFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_table_make(size : Int) -> DbstoretensorTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_table_len(s : DbstoretensorTable) -> Int { s.size }

pub fn db_store_tensor_table_get(s : DbstoretensorTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_table_set(s : DbstoretensorTable, i : Int, v : Double) -> DbstoretensorTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_table_sum(s : DbstoretensorTable) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_table_mean(s : DbstoretensorTable) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_table_scale(s : DbstoretensorTable, f : Double) -> DbstoretensorTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_table_add(a : DbstoretensorTable, b : DbstoretensorTable) -> DbstoretensorTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_table_copy(s : DbstoretensorTable) -> DbstoretensorTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_table_fill(s : DbstoretensorTable, v : Double) -> DbstoretensorTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_table_min(s : DbstoretensorTable) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_table_max(s : DbstoretensorTable) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_table_to_string(s : DbstoretensorTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_graphn_make(size : Int) -> DbstoretensorGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_graphn_len(s : DbstoretensorGraphN) -> Int { s.size }

pub fn db_store_tensor_graphn_get(s : DbstoretensorGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_graphn_set(s : DbstoretensorGraphN, i : Int, v : Double) -> DbstoretensorGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_graphn_sum(s : DbstoretensorGraphN) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_graphn_mean(s : DbstoretensorGraphN) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_graphn_scale(s : DbstoretensorGraphN, f : Double) -> DbstoretensorGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_graphn_add(a : DbstoretensorGraphN, b : DbstoretensorGraphN) -> DbstoretensorGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_graphn_copy(s : DbstoretensorGraphN) -> DbstoretensorGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_graphn_fill(s : DbstoretensorGraphN, v : Double) -> DbstoretensorGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_graphn_min(s : DbstoretensorGraphN) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_graphn_max(s : DbstoretensorGraphN) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_graphn_to_string(s : DbstoretensorGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_node_make(size : Int) -> DbstoretensorNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_node_len(s : DbstoretensorNode) -> Int { s.size }

pub fn db_store_tensor_node_get(s : DbstoretensorNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_node_set(s : DbstoretensorNode, i : Int, v : Double) -> DbstoretensorNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_node_sum(s : DbstoretensorNode) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_node_mean(s : DbstoretensorNode) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_node_scale(s : DbstoretensorNode, f : Double) -> DbstoretensorNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_node_add(a : DbstoretensorNode, b : DbstoretensorNode) -> DbstoretensorNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_node_copy(s : DbstoretensorNode) -> DbstoretensorNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_node_fill(s : DbstoretensorNode, v : Double) -> DbstoretensorNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_node_min(s : DbstoretensorNode) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_node_max(s : DbstoretensorNode) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_node_to_string(s : DbstoretensorNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_edge_make(size : Int) -> DbstoretensorEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_edge_len(s : DbstoretensorEdge) -> Int { s.size }

pub fn db_store_tensor_edge_get(s : DbstoretensorEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_edge_set(s : DbstoretensorEdge, i : Int, v : Double) -> DbstoretensorEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_edge_sum(s : DbstoretensorEdge) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_edge_mean(s : DbstoretensorEdge) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_edge_scale(s : DbstoretensorEdge, f : Double) -> DbstoretensorEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_edge_add(a : DbstoretensorEdge, b : DbstoretensorEdge) -> DbstoretensorEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_edge_copy(s : DbstoretensorEdge) -> DbstoretensorEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_edge_fill(s : DbstoretensorEdge, v : Double) -> DbstoretensorEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_edge_min(s : DbstoretensorEdge) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_edge_max(s : DbstoretensorEdge) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_edge_to_string(s : DbstoretensorEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_path_make(size : Int) -> DbstoretensorPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_path_len(s : DbstoretensorPath) -> Int { s.size }

pub fn db_store_tensor_path_get(s : DbstoretensorPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_path_set(s : DbstoretensorPath, i : Int, v : Double) -> DbstoretensorPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_path_sum(s : DbstoretensorPath) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_path_mean(s : DbstoretensorPath) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_path_scale(s : DbstoretensorPath, f : Double) -> DbstoretensorPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_path_add(a : DbstoretensorPath, b : DbstoretensorPath) -> DbstoretensorPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_path_copy(s : DbstoretensorPath) -> DbstoretensorPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_path_fill(s : DbstoretensorPath, v : Double) -> DbstoretensorPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_path_min(s : DbstoretensorPath) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_path_max(s : DbstoretensorPath) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_path_to_string(s : DbstoretensorPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_cluster_make(size : Int) -> DbstoretensorCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_cluster_len(s : DbstoretensorCluster) -> Int { s.size }

pub fn db_store_tensor_cluster_get(s : DbstoretensorCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_cluster_set(s : DbstoretensorCluster, i : Int, v : Double) -> DbstoretensorCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_cluster_sum(s : DbstoretensorCluster) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_cluster_mean(s : DbstoretensorCluster) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_cluster_scale(s : DbstoretensorCluster, f : Double) -> DbstoretensorCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_cluster_add(a : DbstoretensorCluster, b : DbstoretensorCluster) -> DbstoretensorCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_cluster_copy(s : DbstoretensorCluster) -> DbstoretensorCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_cluster_fill(s : DbstoretensorCluster, v : Double) -> DbstoretensorCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_cluster_min(s : DbstoretensorCluster) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_cluster_max(s : DbstoretensorCluster) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_cluster_to_string(s : DbstoretensorCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_model_make(size : Int) -> DbstoretensorModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_model_len(s : DbstoretensorModel) -> Int { s.size }

pub fn db_store_tensor_model_get(s : DbstoretensorModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_model_set(s : DbstoretensorModel, i : Int, v : Double) -> DbstoretensorModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_model_sum(s : DbstoretensorModel) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_model_mean(s : DbstoretensorModel) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_model_scale(s : DbstoretensorModel, f : Double) -> DbstoretensorModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_model_add(a : DbstoretensorModel, b : DbstoretensorModel) -> DbstoretensorModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_model_copy(s : DbstoretensorModel) -> DbstoretensorModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_model_fill(s : DbstoretensorModel, v : Double) -> DbstoretensorModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_model_min(s : DbstoretensorModel) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_model_max(s : DbstoretensorModel) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_model_to_string(s : DbstoretensorModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_layer_make(size : Int) -> DbstoretensorLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_layer_len(s : DbstoretensorLayer) -> Int { s.size }

pub fn db_store_tensor_layer_get(s : DbstoretensorLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_layer_set(s : DbstoretensorLayer, i : Int, v : Double) -> DbstoretensorLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_layer_sum(s : DbstoretensorLayer) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_layer_mean(s : DbstoretensorLayer) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_layer_scale(s : DbstoretensorLayer, f : Double) -> DbstoretensorLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_layer_add(a : DbstoretensorLayer, b : DbstoretensorLayer) -> DbstoretensorLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_layer_copy(s : DbstoretensorLayer) -> DbstoretensorLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_layer_fill(s : DbstoretensorLayer, v : Double) -> DbstoretensorLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_layer_min(s : DbstoretensorLayer) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_layer_max(s : DbstoretensorLayer) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_layer_to_string(s : DbstoretensorLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_buffer_make(size : Int) -> DbstoretensorBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_buffer_len(s : DbstoretensorBuffer) -> Int { s.size }

pub fn db_store_tensor_buffer_get(s : DbstoretensorBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_buffer_set(s : DbstoretensorBuffer, i : Int, v : Double) -> DbstoretensorBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_buffer_sum(s : DbstoretensorBuffer) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_buffer_mean(s : DbstoretensorBuffer) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_buffer_scale(s : DbstoretensorBuffer, f : Double) -> DbstoretensorBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_buffer_add(a : DbstoretensorBuffer, b : DbstoretensorBuffer) -> DbstoretensorBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_buffer_copy(s : DbstoretensorBuffer) -> DbstoretensorBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_buffer_fill(s : DbstoretensorBuffer, v : Double) -> DbstoretensorBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_buffer_min(s : DbstoretensorBuffer) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_buffer_max(s : DbstoretensorBuffer) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_buffer_to_string(s : DbstoretensorBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_cursor_make(size : Int) -> DbstoretensorCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_cursor_len(s : DbstoretensorCursor) -> Int { s.size }

pub fn db_store_tensor_cursor_get(s : DbstoretensorCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_cursor_set(s : DbstoretensorCursor, i : Int, v : Double) -> DbstoretensorCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_cursor_sum(s : DbstoretensorCursor) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_cursor_mean(s : DbstoretensorCursor) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_cursor_scale(s : DbstoretensorCursor, f : Double) -> DbstoretensorCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_cursor_add(a : DbstoretensorCursor, b : DbstoretensorCursor) -> DbstoretensorCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_cursor_copy(s : DbstoretensorCursor) -> DbstoretensorCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_cursor_fill(s : DbstoretensorCursor, v : Double) -> DbstoretensorCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_cursor_min(s : DbstoretensorCursor) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_cursor_max(s : DbstoretensorCursor) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_cursor_to_string(s : DbstoretensorCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_view_make(size : Int) -> DbstoretensorView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_view_len(s : DbstoretensorView) -> Int { s.size }

pub fn db_store_tensor_view_get(s : DbstoretensorView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_view_set(s : DbstoretensorView, i : Int, v : Double) -> DbstoretensorView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_view_sum(s : DbstoretensorView) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_view_mean(s : DbstoretensorView) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_view_scale(s : DbstoretensorView, f : Double) -> DbstoretensorView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_view_add(a : DbstoretensorView, b : DbstoretensorView) -> DbstoretensorView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_view_copy(s : DbstoretensorView) -> DbstoretensorView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_view_fill(s : DbstoretensorView, v : Double) -> DbstoretensorView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_view_min(s : DbstoretensorView) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_view_max(s : DbstoretensorView) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_view_to_string(s : DbstoretensorView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_range_make(size : Int) -> DbstoretensorRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_range_len(s : DbstoretensorRange) -> Int { s.size }

pub fn db_store_tensor_range_get(s : DbstoretensorRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_range_set(s : DbstoretensorRange, i : Int, v : Double) -> DbstoretensorRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_range_sum(s : DbstoretensorRange) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_range_mean(s : DbstoretensorRange) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_range_scale(s : DbstoretensorRange, f : Double) -> DbstoretensorRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_range_add(a : DbstoretensorRange, b : DbstoretensorRange) -> DbstoretensorRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_range_copy(s : DbstoretensorRange) -> DbstoretensorRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_range_fill(s : DbstoretensorRange, v : Double) -> DbstoretensorRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_range_min(s : DbstoretensorRange) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_range_max(s : DbstoretensorRange) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_range_to_string(s : DbstoretensorRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_slice_make(size : Int) -> DbstoretensorSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_slice_len(s : DbstoretensorSlice) -> Int { s.size }

pub fn db_store_tensor_slice_get(s : DbstoretensorSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_slice_set(s : DbstoretensorSlice, i : Int, v : Double) -> DbstoretensorSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_slice_sum(s : DbstoretensorSlice) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_slice_mean(s : DbstoretensorSlice) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_slice_scale(s : DbstoretensorSlice, f : Double) -> DbstoretensorSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_slice_add(a : DbstoretensorSlice, b : DbstoretensorSlice) -> DbstoretensorSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_slice_copy(s : DbstoretensorSlice) -> DbstoretensorSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_slice_fill(s : DbstoretensorSlice, v : Double) -> DbstoretensorSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_slice_min(s : DbstoretensorSlice) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_slice_max(s : DbstoretensorSlice) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_slice_to_string(s : DbstoretensorSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

