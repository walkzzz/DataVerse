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

pub fn db_store_series_series_sum(s : DbstoreseriesSeries) -> Double { @_common.sum(s.vals) }

pub fn db_store_series_series_mean(s : DbstoreseriesSeries) -> Double { @_common.mean(s.vals) }

pub fn db_store_series_series_min(s : DbstoreseriesSeries) -> Double { @_common.min(s.vals) }

pub fn db_store_series_series_max(s : DbstoreseriesSeries) -> Double { @_common.max(s.vals) }

pub fn db_store_series_series_range(s : DbstoreseriesSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_store_series_series_var(s : DbstoreseriesSeries) -> Double { @_common.variance(s.vals) }

pub fn db_store_series_series_std(s : DbstoreseriesSeries) -> Double { @_common.std(s.vals) }

pub fn db_store_series_series_median(s : DbstoreseriesSeries) -> Double { @_common.median(s.vals) }

pub fn db_store_series_series_scale(s : DbstoreseriesSeries, f : Double) -> DbstoreseriesSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn db_store_series_series_add(a : DbstoreseriesSeries, b : DbstoreseriesSeries) -> DbstoreseriesSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_store_series_series_sub(a : DbstoreseriesSeries, b : DbstoreseriesSeries) -> DbstoreseriesSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
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
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
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
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn db_store_series_vector_sub(a : DbstoreseriesVector, b : DbstoreseriesVector) -> DbstoreseriesVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn db_store_series_vector_scale(v : DbstoreseriesVector, s : Double) -> DbstoreseriesVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
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
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_frame_sum(s : DbstoreseriesFrame) -> Double { @_common.sum(s.data) }

pub fn db_store_series_frame_mean(s : DbstoreseriesFrame) -> Double { @_common.mean(s.data) }

pub fn db_store_series_frame_scale(s : DbstoreseriesFrame, f : Double) -> DbstoreseriesFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_frame_add(a : DbstoreseriesFrame, b : DbstoreseriesFrame) -> DbstoreseriesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_frame_copy(s : DbstoreseriesFrame) -> DbstoreseriesFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_frame_fill(s : DbstoreseriesFrame, v : Double) -> DbstoreseriesFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_frame_min(s : DbstoreseriesFrame) -> Double { @_common.min(s.data) }

pub fn db_store_series_frame_max(s : DbstoreseriesFrame) -> Double { @_common.max(s.data) }

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
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_table_sum(s : DbstoreseriesTable) -> Double { @_common.sum(s.data) }

pub fn db_store_series_table_mean(s : DbstoreseriesTable) -> Double { @_common.mean(s.data) }

pub fn db_store_series_table_scale(s : DbstoreseriesTable, f : Double) -> DbstoreseriesTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_table_add(a : DbstoreseriesTable, b : DbstoreseriesTable) -> DbstoreseriesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_table_copy(s : DbstoreseriesTable) -> DbstoreseriesTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_table_fill(s : DbstoreseriesTable, v : Double) -> DbstoreseriesTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_table_min(s : DbstoreseriesTable) -> Double { @_common.min(s.data) }

pub fn db_store_series_table_max(s : DbstoreseriesTable) -> Double { @_common.max(s.data) }

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
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_graphn_sum(s : DbstoreseriesGraphN) -> Double { @_common.sum(s.data) }

pub fn db_store_series_graphn_mean(s : DbstoreseriesGraphN) -> Double { @_common.mean(s.data) }

pub fn db_store_series_graphn_scale(s : DbstoreseriesGraphN, f : Double) -> DbstoreseriesGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_graphn_add(a : DbstoreseriesGraphN, b : DbstoreseriesGraphN) -> DbstoreseriesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_graphn_copy(s : DbstoreseriesGraphN) -> DbstoreseriesGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_graphn_fill(s : DbstoreseriesGraphN, v : Double) -> DbstoreseriesGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_graphn_min(s : DbstoreseriesGraphN) -> Double { @_common.min(s.data) }

pub fn db_store_series_graphn_max(s : DbstoreseriesGraphN) -> Double { @_common.max(s.data) }

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
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_node_sum(s : DbstoreseriesNode) -> Double { @_common.sum(s.data) }

pub fn db_store_series_node_mean(s : DbstoreseriesNode) -> Double { @_common.mean(s.data) }

pub fn db_store_series_node_scale(s : DbstoreseriesNode, f : Double) -> DbstoreseriesNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_node_add(a : DbstoreseriesNode, b : DbstoreseriesNode) -> DbstoreseriesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_node_copy(s : DbstoreseriesNode) -> DbstoreseriesNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_node_fill(s : DbstoreseriesNode, v : Double) -> DbstoreseriesNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_node_min(s : DbstoreseriesNode) -> Double { @_common.min(s.data) }

pub fn db_store_series_node_max(s : DbstoreseriesNode) -> Double { @_common.max(s.data) }

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
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_edge_sum(s : DbstoreseriesEdge) -> Double { @_common.sum(s.data) }

pub fn db_store_series_edge_mean(s : DbstoreseriesEdge) -> Double { @_common.mean(s.data) }

pub fn db_store_series_edge_scale(s : DbstoreseriesEdge, f : Double) -> DbstoreseriesEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_edge_add(a : DbstoreseriesEdge, b : DbstoreseriesEdge) -> DbstoreseriesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_edge_copy(s : DbstoreseriesEdge) -> DbstoreseriesEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_edge_fill(s : DbstoreseriesEdge, v : Double) -> DbstoreseriesEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_edge_min(s : DbstoreseriesEdge) -> Double { @_common.min(s.data) }

pub fn db_store_series_edge_max(s : DbstoreseriesEdge) -> Double { @_common.max(s.data) }

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
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_path_sum(s : DbstoreseriesPath) -> Double { @_common.sum(s.data) }

pub fn db_store_series_path_mean(s : DbstoreseriesPath) -> Double { @_common.mean(s.data) }

pub fn db_store_series_path_scale(s : DbstoreseriesPath, f : Double) -> DbstoreseriesPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_path_add(a : DbstoreseriesPath, b : DbstoreseriesPath) -> DbstoreseriesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_path_copy(s : DbstoreseriesPath) -> DbstoreseriesPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_path_fill(s : DbstoreseriesPath, v : Double) -> DbstoreseriesPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_path_min(s : DbstoreseriesPath) -> Double { @_common.min(s.data) }

pub fn db_store_series_path_max(s : DbstoreseriesPath) -> Double { @_common.max(s.data) }

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
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_cluster_sum(s : DbstoreseriesCluster) -> Double { @_common.sum(s.data) }

pub fn db_store_series_cluster_mean(s : DbstoreseriesCluster) -> Double { @_common.mean(s.data) }

pub fn db_store_series_cluster_scale(s : DbstoreseriesCluster, f : Double) -> DbstoreseriesCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_cluster_add(a : DbstoreseriesCluster, b : DbstoreseriesCluster) -> DbstoreseriesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_cluster_copy(s : DbstoreseriesCluster) -> DbstoreseriesCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_cluster_fill(s : DbstoreseriesCluster, v : Double) -> DbstoreseriesCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_cluster_min(s : DbstoreseriesCluster) -> Double { @_common.min(s.data) }

pub fn db_store_series_cluster_max(s : DbstoreseriesCluster) -> Double { @_common.max(s.data) }

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
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_model_sum(s : DbstoreseriesModel) -> Double { @_common.sum(s.data) }

pub fn db_store_series_model_mean(s : DbstoreseriesModel) -> Double { @_common.mean(s.data) }

pub fn db_store_series_model_scale(s : DbstoreseriesModel, f : Double) -> DbstoreseriesModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_model_add(a : DbstoreseriesModel, b : DbstoreseriesModel) -> DbstoreseriesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_model_copy(s : DbstoreseriesModel) -> DbstoreseriesModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_model_fill(s : DbstoreseriesModel, v : Double) -> DbstoreseriesModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_model_min(s : DbstoreseriesModel) -> Double { @_common.min(s.data) }

pub fn db_store_series_model_max(s : DbstoreseriesModel) -> Double { @_common.max(s.data) }

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
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_layer_sum(s : DbstoreseriesLayer) -> Double { @_common.sum(s.data) }

pub fn db_store_series_layer_mean(s : DbstoreseriesLayer) -> Double { @_common.mean(s.data) }

pub fn db_store_series_layer_scale(s : DbstoreseriesLayer, f : Double) -> DbstoreseriesLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_layer_add(a : DbstoreseriesLayer, b : DbstoreseriesLayer) -> DbstoreseriesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_layer_copy(s : DbstoreseriesLayer) -> DbstoreseriesLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_layer_fill(s : DbstoreseriesLayer, v : Double) -> DbstoreseriesLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_layer_min(s : DbstoreseriesLayer) -> Double { @_common.min(s.data) }

pub fn db_store_series_layer_max(s : DbstoreseriesLayer) -> Double { @_common.max(s.data) }

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
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_buffer_sum(s : DbstoreseriesBuffer) -> Double { @_common.sum(s.data) }

pub fn db_store_series_buffer_mean(s : DbstoreseriesBuffer) -> Double { @_common.mean(s.data) }

pub fn db_store_series_buffer_scale(s : DbstoreseriesBuffer, f : Double) -> DbstoreseriesBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_buffer_add(a : DbstoreseriesBuffer, b : DbstoreseriesBuffer) -> DbstoreseriesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_buffer_copy(s : DbstoreseriesBuffer) -> DbstoreseriesBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_buffer_fill(s : DbstoreseriesBuffer, v : Double) -> DbstoreseriesBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_buffer_min(s : DbstoreseriesBuffer) -> Double { @_common.min(s.data) }

pub fn db_store_series_buffer_max(s : DbstoreseriesBuffer) -> Double { @_common.max(s.data) }

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
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_cursor_sum(s : DbstoreseriesCursor) -> Double { @_common.sum(s.data) }

pub fn db_store_series_cursor_mean(s : DbstoreseriesCursor) -> Double { @_common.mean(s.data) }

pub fn db_store_series_cursor_scale(s : DbstoreseriesCursor, f : Double) -> DbstoreseriesCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_cursor_add(a : DbstoreseriesCursor, b : DbstoreseriesCursor) -> DbstoreseriesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_cursor_copy(s : DbstoreseriesCursor) -> DbstoreseriesCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_cursor_fill(s : DbstoreseriesCursor, v : Double) -> DbstoreseriesCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_cursor_min(s : DbstoreseriesCursor) -> Double { @_common.min(s.data) }

pub fn db_store_series_cursor_max(s : DbstoreseriesCursor) -> Double { @_common.max(s.data) }

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
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_view_sum(s : DbstoreseriesView) -> Double { @_common.sum(s.data) }

pub fn db_store_series_view_mean(s : DbstoreseriesView) -> Double { @_common.mean(s.data) }

pub fn db_store_series_view_scale(s : DbstoreseriesView, f : Double) -> DbstoreseriesView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_view_add(a : DbstoreseriesView, b : DbstoreseriesView) -> DbstoreseriesView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_view_copy(s : DbstoreseriesView) -> DbstoreseriesView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_view_fill(s : DbstoreseriesView, v : Double) -> DbstoreseriesView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_view_min(s : DbstoreseriesView) -> Double { @_common.min(s.data) }

pub fn db_store_series_view_max(s : DbstoreseriesView) -> Double { @_common.max(s.data) }

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
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_range_sum(s : DbstoreseriesRange) -> Double { @_common.sum(s.data) }

pub fn db_store_series_range_mean(s : DbstoreseriesRange) -> Double { @_common.mean(s.data) }

pub fn db_store_series_range_scale(s : DbstoreseriesRange, f : Double) -> DbstoreseriesRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_range_add(a : DbstoreseriesRange, b : DbstoreseriesRange) -> DbstoreseriesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_range_copy(s : DbstoreseriesRange) -> DbstoreseriesRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_range_fill(s : DbstoreseriesRange, v : Double) -> DbstoreseriesRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_range_min(s : DbstoreseriesRange) -> Double { @_common.min(s.data) }

pub fn db_store_series_range_max(s : DbstoreseriesRange) -> Double { @_common.max(s.data) }

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
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_series_slice_sum(s : DbstoreseriesSlice) -> Double { @_common.sum(s.data) }

pub fn db_store_series_slice_mean(s : DbstoreseriesSlice) -> Double { @_common.mean(s.data) }

pub fn db_store_series_slice_scale(s : DbstoreseriesSlice, f : Double) -> DbstoreseriesSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_series_slice_add(a : DbstoreseriesSlice, b : DbstoreseriesSlice) -> DbstoreseriesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_series_slice_copy(s : DbstoreseriesSlice) -> DbstoreseriesSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_series_slice_fill(s : DbstoreseriesSlice, v : Double) -> DbstoreseriesSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_series_slice_min(s : DbstoreseriesSlice) -> Double { @_common.min(s.data) }

pub fn db_store_series_slice_max(s : DbstoreseriesSlice) -> Double { @_common.max(s.data) }

pub fn db_store_series_slice_to_string(s : DbstoreseriesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

