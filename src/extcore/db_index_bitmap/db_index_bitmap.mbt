///===
/// extcore/db_index_bitmap

pub(all) struct DbindexbitmapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_bitmap_make_point(x : Double, y : Double) -> DbindexbitmapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_bitmap_make_point3(x : Double, y : Double, z : Double) -> DbindexbitmapPoint {
  { x, y, z, label: 0 }
}

pub fn db_index_bitmap_point_x(pt : DbindexbitmapPoint) -> Double { pt.x }

pub fn db_index_bitmap_point_y(pt : DbindexbitmapPoint) -> Double { pt.y }

pub fn db_index_bitmap_point_z(pt : DbindexbitmapPoint) -> Double { pt.z }

pub fn db_index_bitmap_point_label(pt : DbindexbitmapPoint) -> Int { pt.label }

pub fn db_index_bitmap_point_dist(a : DbindexbitmapPoint, b : DbindexbitmapPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_index_bitmap_point_add(a : DbindexbitmapPoint, b : DbindexbitmapPoint) -> DbindexbitmapPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_index_bitmap_point_sub(a : DbindexbitmapPoint, b : DbindexbitmapPoint) -> DbindexbitmapPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_index_bitmap_point_scale(pt : DbindexbitmapPoint, s : Double) -> DbindexbitmapPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_index_bitmap_point_dot(a : DbindexbitmapPoint, b : DbindexbitmapPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_index_bitmap_point_cross(a : DbindexbitmapPoint, b : DbindexbitmapPoint) -> DbindexbitmapPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_index_bitmap_point_norm(pt : DbindexbitmapPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_index_bitmap_point_normalize(pt : DbindexbitmapPoint) -> DbindexbitmapPoint {
  let n = db_index_bitmap_point_norm(pt)
  if n < 0.0000001 { pt } else { db_index_bitmap_point_scale(pt, 1.0 / n) }
}

pub fn db_index_bitmap_point_negate(pt : DbindexbitmapPoint) -> DbindexbitmapPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_index_bitmap_point_mid(a : DbindexbitmapPoint, b : DbindexbitmapPoint) -> DbindexbitmapPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_index_bitmap_point_lerp(a : DbindexbitmapPoint, b : DbindexbitmapPoint, t : Double) -> DbindexbitmapPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_index_bitmap_point_to_string(pt : DbindexbitmapPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbindexbitmapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_bitmap_make_series(vals : Array[Double], name : String) -> DbindexbitmapSeries {
  { vals, name, meta: 0 }
}

pub fn db_index_bitmap_series_len(s : DbindexbitmapSeries) -> Int { s.vals.length() }

pub fn db_index_bitmap_series_sum(s : DbindexbitmapSeries) -> Double { @_common.sum(s.vals) }

pub fn db_index_bitmap_series_mean(s : DbindexbitmapSeries) -> Double { @_common.mean(s.vals) }

pub fn db_index_bitmap_series_min(s : DbindexbitmapSeries) -> Double { @_common.min(s.vals) }

pub fn db_index_bitmap_series_max(s : DbindexbitmapSeries) -> Double { @_common.max(s.vals) }

pub fn db_index_bitmap_series_range(s : DbindexbitmapSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_index_bitmap_series_var(s : DbindexbitmapSeries) -> Double { @_common.variance(s.vals) }

pub fn db_index_bitmap_series_std(s : DbindexbitmapSeries) -> Double { @_common.std(s.vals) }

pub fn db_index_bitmap_series_median(s : DbindexbitmapSeries) -> Double { @_common.median(s.vals) }

pub fn db_index_bitmap_series_scale(s : DbindexbitmapSeries, f : Double) -> DbindexbitmapSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_index_bitmap_series_add(a : DbindexbitmapSeries, b : DbindexbitmapSeries) -> DbindexbitmapSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_index_bitmap_series_sub(a : DbindexbitmapSeries, b : DbindexbitmapSeries) -> DbindexbitmapSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_index_bitmap_series_normalize(s : DbindexbitmapSeries) -> DbindexbitmapSeries {
  let mn = db_index_bitmap_series_min(s)
  let mx = db_index_bitmap_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_index_bitmap_series_cumsum(s : DbindexbitmapSeries) -> DbindexbitmapSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_index_bitmap_series_to_string(s : DbindexbitmapSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexbitmapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_bitmap_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexbitmapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_bitmap_matrix_identity(n : Int) -> DbindexbitmapMatrix {
  let m = db_index_bitmap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_index_bitmap_matrix_get(m : DbindexbitmapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_index_bitmap_matrix_transpose(m : DbindexbitmapMatrix) -> DbindexbitmapMatrix {
  let result = db_index_bitmap_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_index_bitmap_matrix_add(a : DbindexbitmapMatrix, b : DbindexbitmapMatrix) -> DbindexbitmapMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_index_bitmap_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_index_bitmap_matrix_scale(m : DbindexbitmapMatrix, s : Double) -> DbindexbitmapMatrix {
  let result = db_index_bitmap_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_index_bitmap_matrix_multiply(a : DbindexbitmapMatrix, b : DbindexbitmapMatrix) -> DbindexbitmapMatrix {
  if a.cols != b.rows { return db_index_bitmap_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_index_bitmap_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_index_bitmap_matrix_trace(m : DbindexbitmapMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_index_bitmap_matrix_det(m : DbindexbitmapMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_index_bitmap_matrix_norm(m : DbindexbitmapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_index_bitmap_matrix_to_string(m : DbindexbitmapMatrix) -> String {
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

pub(all) struct DbindexbitmapVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_bitmap_make_vector(comps : Array[Double]) -> DbindexbitmapVector {
  { comps, dim: comps.length() }
}

pub fn db_index_bitmap_vector_zero(dim : Int) -> DbindexbitmapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_index_bitmap_vector_add(a : DbindexbitmapVector, b : DbindexbitmapVector) -> DbindexbitmapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_bitmap_vector_sub(a : DbindexbitmapVector, b : DbindexbitmapVector) -> DbindexbitmapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_bitmap_vector_scale(v : DbindexbitmapVector, s : Double) -> DbindexbitmapVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_index_bitmap_vector_dot(a : DbindexbitmapVector, b : DbindexbitmapVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_index_bitmap_vector_norm(v : DbindexbitmapVector) -> Double { @_common.sqrt(db_index_bitmap_vector_dot(v, v)) }

pub fn db_index_bitmap_vector_normalize(v : DbindexbitmapVector) -> DbindexbitmapVector {
  let n = db_index_bitmap_vector_norm(v)
  if n < 0.0000001 { v } else { db_index_bitmap_vector_scale(v, 1.0 / n) }
}

pub fn db_index_bitmap_vector_dist(a : DbindexbitmapVector, b : DbindexbitmapVector) -> Double {
  db_index_bitmap_vector_norm(db_index_bitmap_vector_sub(a, b))
}

pub fn db_index_bitmap_vector_to_string(v : DbindexbitmapVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_index_bitmap_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_index_bitmap_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_index_bitmap_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_index_bitmap_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_index_bitmap_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_index_bitmap_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_index_bitmap_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_index_bitmap_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_index_bitmap_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_index_bitmap_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_index_bitmap_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_index_bitmap_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_index_bitmap_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_index_bitmap_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_index_bitmap_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_index_bitmap_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_index_bitmap_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_index_bitmap_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_index_bitmap_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_index_bitmap_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_index_bitmap_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_index_bitmap_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_index_bitmap_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_index_bitmap_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_index_bitmap_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_index_bitmap_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_index_bitmap_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_index_bitmap_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_index_bitmap_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbindexbitmapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_frame_make(size : Int) -> DbindexbitmapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_frame_len(s : DbindexbitmapFrame) -> Int { s.size }

pub fn db_index_bitmap_frame_get(s : DbindexbitmapFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_frame_set(s : DbindexbitmapFrame, i : Int, v : Double) -> DbindexbitmapFrame {
  let result = db_index_bitmap_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_frame_sum(s : DbindexbitmapFrame) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_frame_mean(s : DbindexbitmapFrame) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_frame_scale(s : DbindexbitmapFrame, f : Double) -> DbindexbitmapFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_frame_add(a : DbindexbitmapFrame, b : DbindexbitmapFrame) -> DbindexbitmapFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_frame_copy(s : DbindexbitmapFrame) -> DbindexbitmapFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_frame_fill(s : DbindexbitmapFrame, v : Double) -> DbindexbitmapFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_frame_min(s : DbindexbitmapFrame) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_frame_max(s : DbindexbitmapFrame) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_frame_to_string(s : DbindexbitmapFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_table_make(size : Int) -> DbindexbitmapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_table_len(s : DbindexbitmapTable) -> Int { s.size }

pub fn db_index_bitmap_table_get(s : DbindexbitmapTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_table_set(s : DbindexbitmapTable, i : Int, v : Double) -> DbindexbitmapTable {
  let result = db_index_bitmap_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_table_sum(s : DbindexbitmapTable) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_table_mean(s : DbindexbitmapTable) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_table_scale(s : DbindexbitmapTable, f : Double) -> DbindexbitmapTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_table_add(a : DbindexbitmapTable, b : DbindexbitmapTable) -> DbindexbitmapTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_table_copy(s : DbindexbitmapTable) -> DbindexbitmapTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_table_fill(s : DbindexbitmapTable, v : Double) -> DbindexbitmapTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_table_min(s : DbindexbitmapTable) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_table_max(s : DbindexbitmapTable) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_table_to_string(s : DbindexbitmapTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_graphn_make(size : Int) -> DbindexbitmapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_graphn_len(s : DbindexbitmapGraphN) -> Int { s.size }

pub fn db_index_bitmap_graphn_get(s : DbindexbitmapGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_graphn_set(s : DbindexbitmapGraphN, i : Int, v : Double) -> DbindexbitmapGraphN {
  let result = db_index_bitmap_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_graphn_sum(s : DbindexbitmapGraphN) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_graphn_mean(s : DbindexbitmapGraphN) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_graphn_scale(s : DbindexbitmapGraphN, f : Double) -> DbindexbitmapGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_graphn_add(a : DbindexbitmapGraphN, b : DbindexbitmapGraphN) -> DbindexbitmapGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_graphn_copy(s : DbindexbitmapGraphN) -> DbindexbitmapGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_graphn_fill(s : DbindexbitmapGraphN, v : Double) -> DbindexbitmapGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_graphn_min(s : DbindexbitmapGraphN) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_graphn_max(s : DbindexbitmapGraphN) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_graphn_to_string(s : DbindexbitmapGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_node_make(size : Int) -> DbindexbitmapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_node_len(s : DbindexbitmapNode) -> Int { s.size }

pub fn db_index_bitmap_node_get(s : DbindexbitmapNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_node_set(s : DbindexbitmapNode, i : Int, v : Double) -> DbindexbitmapNode {
  let result = db_index_bitmap_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_node_sum(s : DbindexbitmapNode) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_node_mean(s : DbindexbitmapNode) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_node_scale(s : DbindexbitmapNode, f : Double) -> DbindexbitmapNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_node_add(a : DbindexbitmapNode, b : DbindexbitmapNode) -> DbindexbitmapNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_node_copy(s : DbindexbitmapNode) -> DbindexbitmapNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_node_fill(s : DbindexbitmapNode, v : Double) -> DbindexbitmapNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_node_min(s : DbindexbitmapNode) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_node_max(s : DbindexbitmapNode) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_node_to_string(s : DbindexbitmapNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_edge_make(size : Int) -> DbindexbitmapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_edge_len(s : DbindexbitmapEdge) -> Int { s.size }

pub fn db_index_bitmap_edge_get(s : DbindexbitmapEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_edge_set(s : DbindexbitmapEdge, i : Int, v : Double) -> DbindexbitmapEdge {
  let result = db_index_bitmap_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_edge_sum(s : DbindexbitmapEdge) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_edge_mean(s : DbindexbitmapEdge) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_edge_scale(s : DbindexbitmapEdge, f : Double) -> DbindexbitmapEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_edge_add(a : DbindexbitmapEdge, b : DbindexbitmapEdge) -> DbindexbitmapEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_edge_copy(s : DbindexbitmapEdge) -> DbindexbitmapEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_edge_fill(s : DbindexbitmapEdge, v : Double) -> DbindexbitmapEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_edge_min(s : DbindexbitmapEdge) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_edge_max(s : DbindexbitmapEdge) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_edge_to_string(s : DbindexbitmapEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_path_make(size : Int) -> DbindexbitmapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_path_len(s : DbindexbitmapPath) -> Int { s.size }

pub fn db_index_bitmap_path_get(s : DbindexbitmapPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_path_set(s : DbindexbitmapPath, i : Int, v : Double) -> DbindexbitmapPath {
  let result = db_index_bitmap_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_path_sum(s : DbindexbitmapPath) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_path_mean(s : DbindexbitmapPath) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_path_scale(s : DbindexbitmapPath, f : Double) -> DbindexbitmapPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_path_add(a : DbindexbitmapPath, b : DbindexbitmapPath) -> DbindexbitmapPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_path_copy(s : DbindexbitmapPath) -> DbindexbitmapPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_path_fill(s : DbindexbitmapPath, v : Double) -> DbindexbitmapPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_path_min(s : DbindexbitmapPath) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_path_max(s : DbindexbitmapPath) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_path_to_string(s : DbindexbitmapPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_cluster_make(size : Int) -> DbindexbitmapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_cluster_len(s : DbindexbitmapCluster) -> Int { s.size }

pub fn db_index_bitmap_cluster_get(s : DbindexbitmapCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_cluster_set(s : DbindexbitmapCluster, i : Int, v : Double) -> DbindexbitmapCluster {
  let result = db_index_bitmap_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_cluster_sum(s : DbindexbitmapCluster) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_cluster_mean(s : DbindexbitmapCluster) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_cluster_scale(s : DbindexbitmapCluster, f : Double) -> DbindexbitmapCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_cluster_add(a : DbindexbitmapCluster, b : DbindexbitmapCluster) -> DbindexbitmapCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_cluster_copy(s : DbindexbitmapCluster) -> DbindexbitmapCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_cluster_fill(s : DbindexbitmapCluster, v : Double) -> DbindexbitmapCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_cluster_min(s : DbindexbitmapCluster) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_cluster_max(s : DbindexbitmapCluster) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_cluster_to_string(s : DbindexbitmapCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_model_make(size : Int) -> DbindexbitmapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_model_len(s : DbindexbitmapModel) -> Int { s.size }

pub fn db_index_bitmap_model_get(s : DbindexbitmapModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_model_set(s : DbindexbitmapModel, i : Int, v : Double) -> DbindexbitmapModel {
  let result = db_index_bitmap_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_model_sum(s : DbindexbitmapModel) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_model_mean(s : DbindexbitmapModel) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_model_scale(s : DbindexbitmapModel, f : Double) -> DbindexbitmapModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_model_add(a : DbindexbitmapModel, b : DbindexbitmapModel) -> DbindexbitmapModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_model_copy(s : DbindexbitmapModel) -> DbindexbitmapModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_model_fill(s : DbindexbitmapModel, v : Double) -> DbindexbitmapModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_model_min(s : DbindexbitmapModel) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_model_max(s : DbindexbitmapModel) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_model_to_string(s : DbindexbitmapModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_layer_make(size : Int) -> DbindexbitmapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_layer_len(s : DbindexbitmapLayer) -> Int { s.size }

pub fn db_index_bitmap_layer_get(s : DbindexbitmapLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_layer_set(s : DbindexbitmapLayer, i : Int, v : Double) -> DbindexbitmapLayer {
  let result = db_index_bitmap_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_layer_sum(s : DbindexbitmapLayer) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_layer_mean(s : DbindexbitmapLayer) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_layer_scale(s : DbindexbitmapLayer, f : Double) -> DbindexbitmapLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_layer_add(a : DbindexbitmapLayer, b : DbindexbitmapLayer) -> DbindexbitmapLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_layer_copy(s : DbindexbitmapLayer) -> DbindexbitmapLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_layer_fill(s : DbindexbitmapLayer, v : Double) -> DbindexbitmapLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_layer_min(s : DbindexbitmapLayer) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_layer_max(s : DbindexbitmapLayer) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_layer_to_string(s : DbindexbitmapLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_buffer_make(size : Int) -> DbindexbitmapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_buffer_len(s : DbindexbitmapBuffer) -> Int { s.size }

pub fn db_index_bitmap_buffer_get(s : DbindexbitmapBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_buffer_set(s : DbindexbitmapBuffer, i : Int, v : Double) -> DbindexbitmapBuffer {
  let result = db_index_bitmap_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_buffer_sum(s : DbindexbitmapBuffer) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_buffer_mean(s : DbindexbitmapBuffer) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_buffer_scale(s : DbindexbitmapBuffer, f : Double) -> DbindexbitmapBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_buffer_add(a : DbindexbitmapBuffer, b : DbindexbitmapBuffer) -> DbindexbitmapBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_buffer_copy(s : DbindexbitmapBuffer) -> DbindexbitmapBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_buffer_fill(s : DbindexbitmapBuffer, v : Double) -> DbindexbitmapBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_buffer_min(s : DbindexbitmapBuffer) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_buffer_max(s : DbindexbitmapBuffer) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_buffer_to_string(s : DbindexbitmapBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_cursor_make(size : Int) -> DbindexbitmapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_cursor_len(s : DbindexbitmapCursor) -> Int { s.size }

pub fn db_index_bitmap_cursor_get(s : DbindexbitmapCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_cursor_set(s : DbindexbitmapCursor, i : Int, v : Double) -> DbindexbitmapCursor {
  let result = db_index_bitmap_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_cursor_sum(s : DbindexbitmapCursor) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_cursor_mean(s : DbindexbitmapCursor) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_cursor_scale(s : DbindexbitmapCursor, f : Double) -> DbindexbitmapCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_cursor_add(a : DbindexbitmapCursor, b : DbindexbitmapCursor) -> DbindexbitmapCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_cursor_copy(s : DbindexbitmapCursor) -> DbindexbitmapCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_cursor_fill(s : DbindexbitmapCursor, v : Double) -> DbindexbitmapCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_cursor_min(s : DbindexbitmapCursor) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_cursor_max(s : DbindexbitmapCursor) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_cursor_to_string(s : DbindexbitmapCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_view_make(size : Int) -> DbindexbitmapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_view_len(s : DbindexbitmapView) -> Int { s.size }

pub fn db_index_bitmap_view_get(s : DbindexbitmapView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_view_set(s : DbindexbitmapView, i : Int, v : Double) -> DbindexbitmapView {
  let result = db_index_bitmap_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_view_sum(s : DbindexbitmapView) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_view_mean(s : DbindexbitmapView) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_view_scale(s : DbindexbitmapView, f : Double) -> DbindexbitmapView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_view_add(a : DbindexbitmapView, b : DbindexbitmapView) -> DbindexbitmapView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_view_copy(s : DbindexbitmapView) -> DbindexbitmapView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_view_fill(s : DbindexbitmapView, v : Double) -> DbindexbitmapView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_view_min(s : DbindexbitmapView) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_view_max(s : DbindexbitmapView) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_view_to_string(s : DbindexbitmapView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_range_make(size : Int) -> DbindexbitmapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_range_len(s : DbindexbitmapRange) -> Int { s.size }

pub fn db_index_bitmap_range_get(s : DbindexbitmapRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_range_set(s : DbindexbitmapRange, i : Int, v : Double) -> DbindexbitmapRange {
  let result = db_index_bitmap_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_range_sum(s : DbindexbitmapRange) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_range_mean(s : DbindexbitmapRange) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_range_scale(s : DbindexbitmapRange, f : Double) -> DbindexbitmapRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_range_add(a : DbindexbitmapRange, b : DbindexbitmapRange) -> DbindexbitmapRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_range_copy(s : DbindexbitmapRange) -> DbindexbitmapRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_range_fill(s : DbindexbitmapRange, v : Double) -> DbindexbitmapRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_range_min(s : DbindexbitmapRange) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_range_max(s : DbindexbitmapRange) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_range_to_string(s : DbindexbitmapRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_slice_make(size : Int) -> DbindexbitmapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_slice_len(s : DbindexbitmapSlice) -> Int { s.size }

pub fn db_index_bitmap_slice_get(s : DbindexbitmapSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_slice_set(s : DbindexbitmapSlice, i : Int, v : Double) -> DbindexbitmapSlice {
  let result = db_index_bitmap_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_slice_sum(s : DbindexbitmapSlice) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_slice_mean(s : DbindexbitmapSlice) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_slice_scale(s : DbindexbitmapSlice, f : Double) -> DbindexbitmapSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_slice_add(a : DbindexbitmapSlice, b : DbindexbitmapSlice) -> DbindexbitmapSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_slice_copy(s : DbindexbitmapSlice) -> DbindexbitmapSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_slice_fill(s : DbindexbitmapSlice, v : Double) -> DbindexbitmapSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_slice_min(s : DbindexbitmapSlice) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_slice_max(s : DbindexbitmapSlice) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_slice_to_string(s : DbindexbitmapSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

