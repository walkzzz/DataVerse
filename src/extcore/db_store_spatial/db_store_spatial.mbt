///===
/// extcore/db_store_spatial

pub(all) struct DbstorespatialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_spatial_make_point(x : Double, y : Double) -> DbstorespatialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_spatial_make_point3(x : Double, y : Double, z : Double) -> DbstorespatialPoint {
  { x, y, z, label: 0 }
}

pub fn db_store_spatial_point_x(pt : DbstorespatialPoint) -> Double { pt.x }

pub fn db_store_spatial_point_y(pt : DbstorespatialPoint) -> Double { pt.y }

pub fn db_store_spatial_point_z(pt : DbstorespatialPoint) -> Double { pt.z }

pub fn db_store_spatial_point_label(pt : DbstorespatialPoint) -> Int { pt.label }

pub fn db_store_spatial_point_dist(a : DbstorespatialPoint, b : DbstorespatialPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_store_spatial_point_add(a : DbstorespatialPoint, b : DbstorespatialPoint) -> DbstorespatialPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_store_spatial_point_sub(a : DbstorespatialPoint, b : DbstorespatialPoint) -> DbstorespatialPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_store_spatial_point_scale(pt : DbstorespatialPoint, s : Double) -> DbstorespatialPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_store_spatial_point_dot(a : DbstorespatialPoint, b : DbstorespatialPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_store_spatial_point_cross(a : DbstorespatialPoint, b : DbstorespatialPoint) -> DbstorespatialPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_store_spatial_point_norm(pt : DbstorespatialPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_store_spatial_point_normalize(pt : DbstorespatialPoint) -> DbstorespatialPoint {
  let n = db_store_spatial_point_norm(pt)
  if n < 0.0000001 { pt } else { db_store_spatial_point_scale(pt, 1.0 / n) }
}

pub fn db_store_spatial_point_negate(pt : DbstorespatialPoint) -> DbstorespatialPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_store_spatial_point_mid(a : DbstorespatialPoint, b : DbstorespatialPoint) -> DbstorespatialPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_store_spatial_point_lerp(a : DbstorespatialPoint, b : DbstorespatialPoint, t : Double) -> DbstorespatialPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_store_spatial_point_to_string(pt : DbstorespatialPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbstorespatialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_spatial_make_series(vals : Array[Double], name : String) -> DbstorespatialSeries {
  { vals, name, meta: 0 }
}

pub fn db_store_spatial_series_len(s : DbstorespatialSeries) -> Int { s.vals.length() }

pub fn db_store_spatial_series_sum(s : DbstorespatialSeries) -> Double { @_common.sum(s.vals) }

pub fn db_store_spatial_series_mean(s : DbstorespatialSeries) -> Double { @_common.mean(s.vals) }

pub fn db_store_spatial_series_min(s : DbstorespatialSeries) -> Double { @_common.min(s.vals) }

pub fn db_store_spatial_series_max(s : DbstorespatialSeries) -> Double { @_common.max(s.vals) }

pub fn db_store_spatial_series_range(s : DbstorespatialSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_store_spatial_series_var(s : DbstorespatialSeries) -> Double { @_common.variance(s.vals) }

pub fn db_store_spatial_series_std(s : DbstorespatialSeries) -> Double { @_common.std(s.vals) }

pub fn db_store_spatial_series_median(s : DbstorespatialSeries) -> Double { @_common.median(s.vals) }

pub fn db_store_spatial_series_scale(s : DbstorespatialSeries, f : Double) -> DbstorespatialSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_store_spatial_series_add(a : DbstorespatialSeries, b : DbstorespatialSeries) -> DbstorespatialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_store_spatial_series_sub(a : DbstorespatialSeries, b : DbstorespatialSeries) -> DbstorespatialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_store_spatial_series_normalize(s : DbstorespatialSeries) -> DbstorespatialSeries {
  let mn = db_store_spatial_series_min(s)
  let mx = db_store_spatial_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_store_spatial_series_cumsum(s : DbstorespatialSeries) -> DbstorespatialSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_store_spatial_series_to_string(s : DbstorespatialSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstorespatialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_spatial_make_matrix(rows : Int, cols : Int, val : Double) -> DbstorespatialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_spatial_matrix_identity(n : Int) -> DbstorespatialMatrix {
  let m = db_store_spatial_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_store_spatial_matrix_get(m : DbstorespatialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_store_spatial_matrix_transpose(m : DbstorespatialMatrix) -> DbstorespatialMatrix {
  let result = db_store_spatial_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_store_spatial_matrix_add(a : DbstorespatialMatrix, b : DbstorespatialMatrix) -> DbstorespatialMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_store_spatial_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_store_spatial_matrix_scale(m : DbstorespatialMatrix, s : Double) -> DbstorespatialMatrix {
  let result = db_store_spatial_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_store_spatial_matrix_multiply(a : DbstorespatialMatrix, b : DbstorespatialMatrix) -> DbstorespatialMatrix {
  if a.cols != b.rows { return db_store_spatial_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_store_spatial_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_store_spatial_matrix_trace(m : DbstorespatialMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_store_spatial_matrix_det(m : DbstorespatialMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_store_spatial_matrix_norm(m : DbstorespatialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_store_spatial_matrix_to_string(m : DbstorespatialMatrix) -> String {
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

pub(all) struct DbstorespatialVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_spatial_make_vector(comps : Array[Double]) -> DbstorespatialVector {
  { comps, dim: comps.length() }
}

pub fn db_store_spatial_vector_zero(dim : Int) -> DbstorespatialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_store_spatial_vector_add(a : DbstorespatialVector, b : DbstorespatialVector) -> DbstorespatialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_spatial_vector_sub(a : DbstorespatialVector, b : DbstorespatialVector) -> DbstorespatialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_spatial_vector_scale(v : DbstorespatialVector, s : Double) -> DbstorespatialVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_store_spatial_vector_dot(a : DbstorespatialVector, b : DbstorespatialVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_store_spatial_vector_norm(v : DbstorespatialVector) -> Double { @_common.sqrt(db_store_spatial_vector_dot(v, v)) }

pub fn db_store_spatial_vector_normalize(v : DbstorespatialVector) -> DbstorespatialVector {
  let n = db_store_spatial_vector_norm(v)
  if n < 0.0000001 { v } else { db_store_spatial_vector_scale(v, 1.0 / n) }
}

pub fn db_store_spatial_vector_dist(a : DbstorespatialVector, b : DbstorespatialVector) -> Double {
  db_store_spatial_vector_norm(db_store_spatial_vector_sub(a, b))
}

pub fn db_store_spatial_vector_to_string(v : DbstorespatialVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_spatial_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_spatial_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_spatial_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_spatial_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_spatial_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_spatial_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_spatial_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_spatial_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_spatial_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_spatial_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_spatial_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_spatial_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_spatial_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_spatial_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_spatial_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_spatial_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_spatial_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_spatial_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_spatial_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_spatial_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_spatial_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_spatial_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_spatial_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_spatial_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_spatial_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_spatial_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_spatial_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_spatial_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_spatial_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstorespatialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_frame_make(size : Int) -> DbstorespatialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_frame_len(s : DbstorespatialFrame) -> Int { s.size }

pub fn db_store_spatial_frame_get(s : DbstorespatialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_frame_set(s : DbstorespatialFrame, i : Int, v : Double) -> DbstorespatialFrame {
  let result = db_store_spatial_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_frame_sum(s : DbstorespatialFrame) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_frame_mean(s : DbstorespatialFrame) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_frame_scale(s : DbstorespatialFrame, f : Double) -> DbstorespatialFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_frame_add(a : DbstorespatialFrame, b : DbstorespatialFrame) -> DbstorespatialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_frame_copy(s : DbstorespatialFrame) -> DbstorespatialFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_frame_fill(s : DbstorespatialFrame, v : Double) -> DbstorespatialFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_frame_min(s : DbstorespatialFrame) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_frame_max(s : DbstorespatialFrame) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_frame_to_string(s : DbstorespatialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_table_make(size : Int) -> DbstorespatialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_table_len(s : DbstorespatialTable) -> Int { s.size }

pub fn db_store_spatial_table_get(s : DbstorespatialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_table_set(s : DbstorespatialTable, i : Int, v : Double) -> DbstorespatialTable {
  let result = db_store_spatial_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_table_sum(s : DbstorespatialTable) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_table_mean(s : DbstorespatialTable) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_table_scale(s : DbstorespatialTable, f : Double) -> DbstorespatialTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_table_add(a : DbstorespatialTable, b : DbstorespatialTable) -> DbstorespatialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_table_copy(s : DbstorespatialTable) -> DbstorespatialTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_table_fill(s : DbstorespatialTable, v : Double) -> DbstorespatialTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_table_min(s : DbstorespatialTable) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_table_max(s : DbstorespatialTable) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_table_to_string(s : DbstorespatialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_graphn_make(size : Int) -> DbstorespatialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_graphn_len(s : DbstorespatialGraphN) -> Int { s.size }

pub fn db_store_spatial_graphn_get(s : DbstorespatialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_graphn_set(s : DbstorespatialGraphN, i : Int, v : Double) -> DbstorespatialGraphN {
  let result = db_store_spatial_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_graphn_sum(s : DbstorespatialGraphN) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_graphn_mean(s : DbstorespatialGraphN) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_graphn_scale(s : DbstorespatialGraphN, f : Double) -> DbstorespatialGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_graphn_add(a : DbstorespatialGraphN, b : DbstorespatialGraphN) -> DbstorespatialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_graphn_copy(s : DbstorespatialGraphN) -> DbstorespatialGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_graphn_fill(s : DbstorespatialGraphN, v : Double) -> DbstorespatialGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_graphn_min(s : DbstorespatialGraphN) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_graphn_max(s : DbstorespatialGraphN) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_graphn_to_string(s : DbstorespatialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_node_make(size : Int) -> DbstorespatialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_node_len(s : DbstorespatialNode) -> Int { s.size }

pub fn db_store_spatial_node_get(s : DbstorespatialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_node_set(s : DbstorespatialNode, i : Int, v : Double) -> DbstorespatialNode {
  let result = db_store_spatial_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_node_sum(s : DbstorespatialNode) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_node_mean(s : DbstorespatialNode) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_node_scale(s : DbstorespatialNode, f : Double) -> DbstorespatialNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_node_add(a : DbstorespatialNode, b : DbstorespatialNode) -> DbstorespatialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_node_copy(s : DbstorespatialNode) -> DbstorespatialNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_node_fill(s : DbstorespatialNode, v : Double) -> DbstorespatialNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_node_min(s : DbstorespatialNode) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_node_max(s : DbstorespatialNode) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_node_to_string(s : DbstorespatialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_edge_make(size : Int) -> DbstorespatialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_edge_len(s : DbstorespatialEdge) -> Int { s.size }

pub fn db_store_spatial_edge_get(s : DbstorespatialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_edge_set(s : DbstorespatialEdge, i : Int, v : Double) -> DbstorespatialEdge {
  let result = db_store_spatial_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_edge_sum(s : DbstorespatialEdge) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_edge_mean(s : DbstorespatialEdge) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_edge_scale(s : DbstorespatialEdge, f : Double) -> DbstorespatialEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_edge_add(a : DbstorespatialEdge, b : DbstorespatialEdge) -> DbstorespatialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_edge_copy(s : DbstorespatialEdge) -> DbstorespatialEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_edge_fill(s : DbstorespatialEdge, v : Double) -> DbstorespatialEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_edge_min(s : DbstorespatialEdge) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_edge_max(s : DbstorespatialEdge) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_edge_to_string(s : DbstorespatialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_path_make(size : Int) -> DbstorespatialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_path_len(s : DbstorespatialPath) -> Int { s.size }

pub fn db_store_spatial_path_get(s : DbstorespatialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_path_set(s : DbstorespatialPath, i : Int, v : Double) -> DbstorespatialPath {
  let result = db_store_spatial_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_path_sum(s : DbstorespatialPath) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_path_mean(s : DbstorespatialPath) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_path_scale(s : DbstorespatialPath, f : Double) -> DbstorespatialPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_path_add(a : DbstorespatialPath, b : DbstorespatialPath) -> DbstorespatialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_path_copy(s : DbstorespatialPath) -> DbstorespatialPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_path_fill(s : DbstorespatialPath, v : Double) -> DbstorespatialPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_path_min(s : DbstorespatialPath) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_path_max(s : DbstorespatialPath) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_path_to_string(s : DbstorespatialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_cluster_make(size : Int) -> DbstorespatialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_cluster_len(s : DbstorespatialCluster) -> Int { s.size }

pub fn db_store_spatial_cluster_get(s : DbstorespatialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_cluster_set(s : DbstorespatialCluster, i : Int, v : Double) -> DbstorespatialCluster {
  let result = db_store_spatial_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_cluster_sum(s : DbstorespatialCluster) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_cluster_mean(s : DbstorespatialCluster) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_cluster_scale(s : DbstorespatialCluster, f : Double) -> DbstorespatialCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_cluster_add(a : DbstorespatialCluster, b : DbstorespatialCluster) -> DbstorespatialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_cluster_copy(s : DbstorespatialCluster) -> DbstorespatialCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_cluster_fill(s : DbstorespatialCluster, v : Double) -> DbstorespatialCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_cluster_min(s : DbstorespatialCluster) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_cluster_max(s : DbstorespatialCluster) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_cluster_to_string(s : DbstorespatialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_model_make(size : Int) -> DbstorespatialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_model_len(s : DbstorespatialModel) -> Int { s.size }

pub fn db_store_spatial_model_get(s : DbstorespatialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_model_set(s : DbstorespatialModel, i : Int, v : Double) -> DbstorespatialModel {
  let result = db_store_spatial_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_model_sum(s : DbstorespatialModel) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_model_mean(s : DbstorespatialModel) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_model_scale(s : DbstorespatialModel, f : Double) -> DbstorespatialModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_model_add(a : DbstorespatialModel, b : DbstorespatialModel) -> DbstorespatialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_model_copy(s : DbstorespatialModel) -> DbstorespatialModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_model_fill(s : DbstorespatialModel, v : Double) -> DbstorespatialModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_model_min(s : DbstorespatialModel) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_model_max(s : DbstorespatialModel) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_model_to_string(s : DbstorespatialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_layer_make(size : Int) -> DbstorespatialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_layer_len(s : DbstorespatialLayer) -> Int { s.size }

pub fn db_store_spatial_layer_get(s : DbstorespatialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_layer_set(s : DbstorespatialLayer, i : Int, v : Double) -> DbstorespatialLayer {
  let result = db_store_spatial_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_layer_sum(s : DbstorespatialLayer) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_layer_mean(s : DbstorespatialLayer) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_layer_scale(s : DbstorespatialLayer, f : Double) -> DbstorespatialLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_layer_add(a : DbstorespatialLayer, b : DbstorespatialLayer) -> DbstorespatialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_layer_copy(s : DbstorespatialLayer) -> DbstorespatialLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_layer_fill(s : DbstorespatialLayer, v : Double) -> DbstorespatialLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_layer_min(s : DbstorespatialLayer) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_layer_max(s : DbstorespatialLayer) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_layer_to_string(s : DbstorespatialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_buffer_make(size : Int) -> DbstorespatialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_buffer_len(s : DbstorespatialBuffer) -> Int { s.size }

pub fn db_store_spatial_buffer_get(s : DbstorespatialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_buffer_set(s : DbstorespatialBuffer, i : Int, v : Double) -> DbstorespatialBuffer {
  let result = db_store_spatial_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_buffer_sum(s : DbstorespatialBuffer) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_buffer_mean(s : DbstorespatialBuffer) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_buffer_scale(s : DbstorespatialBuffer, f : Double) -> DbstorespatialBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_buffer_add(a : DbstorespatialBuffer, b : DbstorespatialBuffer) -> DbstorespatialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_buffer_copy(s : DbstorespatialBuffer) -> DbstorespatialBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_buffer_fill(s : DbstorespatialBuffer, v : Double) -> DbstorespatialBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_buffer_min(s : DbstorespatialBuffer) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_buffer_max(s : DbstorespatialBuffer) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_buffer_to_string(s : DbstorespatialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_cursor_make(size : Int) -> DbstorespatialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_cursor_len(s : DbstorespatialCursor) -> Int { s.size }

pub fn db_store_spatial_cursor_get(s : DbstorespatialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_cursor_set(s : DbstorespatialCursor, i : Int, v : Double) -> DbstorespatialCursor {
  let result = db_store_spatial_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_cursor_sum(s : DbstorespatialCursor) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_cursor_mean(s : DbstorespatialCursor) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_cursor_scale(s : DbstorespatialCursor, f : Double) -> DbstorespatialCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_cursor_add(a : DbstorespatialCursor, b : DbstorespatialCursor) -> DbstorespatialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_cursor_copy(s : DbstorespatialCursor) -> DbstorespatialCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_cursor_fill(s : DbstorespatialCursor, v : Double) -> DbstorespatialCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_cursor_min(s : DbstorespatialCursor) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_cursor_max(s : DbstorespatialCursor) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_cursor_to_string(s : DbstorespatialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_view_make(size : Int) -> DbstorespatialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_view_len(s : DbstorespatialView) -> Int { s.size }

pub fn db_store_spatial_view_get(s : DbstorespatialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_view_set(s : DbstorespatialView, i : Int, v : Double) -> DbstorespatialView {
  let result = db_store_spatial_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_view_sum(s : DbstorespatialView) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_view_mean(s : DbstorespatialView) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_view_scale(s : DbstorespatialView, f : Double) -> DbstorespatialView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_view_add(a : DbstorespatialView, b : DbstorespatialView) -> DbstorespatialView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_view_copy(s : DbstorespatialView) -> DbstorespatialView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_view_fill(s : DbstorespatialView, v : Double) -> DbstorespatialView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_view_min(s : DbstorespatialView) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_view_max(s : DbstorespatialView) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_view_to_string(s : DbstorespatialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_range_make(size : Int) -> DbstorespatialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_range_len(s : DbstorespatialRange) -> Int { s.size }

pub fn db_store_spatial_range_get(s : DbstorespatialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_range_set(s : DbstorespatialRange, i : Int, v : Double) -> DbstorespatialRange {
  let result = db_store_spatial_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_range_sum(s : DbstorespatialRange) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_range_mean(s : DbstorespatialRange) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_range_scale(s : DbstorespatialRange, f : Double) -> DbstorespatialRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_range_add(a : DbstorespatialRange, b : DbstorespatialRange) -> DbstorespatialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_range_copy(s : DbstorespatialRange) -> DbstorespatialRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_range_fill(s : DbstorespatialRange, v : Double) -> DbstorespatialRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_range_min(s : DbstorespatialRange) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_range_max(s : DbstorespatialRange) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_range_to_string(s : DbstorespatialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_slice_make(size : Int) -> DbstorespatialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_slice_len(s : DbstorespatialSlice) -> Int { s.size }

pub fn db_store_spatial_slice_get(s : DbstorespatialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_slice_set(s : DbstorespatialSlice, i : Int, v : Double) -> DbstorespatialSlice {
  let result = db_store_spatial_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_slice_sum(s : DbstorespatialSlice) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_slice_mean(s : DbstorespatialSlice) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_slice_scale(s : DbstorespatialSlice, f : Double) -> DbstorespatialSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_slice_add(a : DbstorespatialSlice, b : DbstorespatialSlice) -> DbstorespatialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_slice_copy(s : DbstorespatialSlice) -> DbstorespatialSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_slice_fill(s : DbstorespatialSlice, v : Double) -> DbstorespatialSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_slice_min(s : DbstorespatialSlice) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_slice_max(s : DbstorespatialSlice) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_slice_to_string(s : DbstorespatialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

