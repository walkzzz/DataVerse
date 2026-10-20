///===
/// extcore/db_tx_2pc

pub(all) struct Dbtx2pcPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_2pc_make_point(x : Double, y : Double) -> Dbtx2pcPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_2pc_make_point3(x : Double, y : Double, z : Double) -> Dbtx2pcPoint {
  { x, y, z, label: 0 }
}

pub fn db_tx_2pc_point_x(pt : Dbtx2pcPoint) -> Double { pt.x }

pub fn db_tx_2pc_point_y(pt : Dbtx2pcPoint) -> Double { pt.y }

pub fn db_tx_2pc_point_z(pt : Dbtx2pcPoint) -> Double { pt.z }

pub fn db_tx_2pc_point_label(pt : Dbtx2pcPoint) -> Int { pt.label }

pub fn db_tx_2pc_point_dist(a : Dbtx2pcPoint, b : Dbtx2pcPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_tx_2pc_point_add(a : Dbtx2pcPoint, b : Dbtx2pcPoint) -> Dbtx2pcPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_tx_2pc_point_sub(a : Dbtx2pcPoint, b : Dbtx2pcPoint) -> Dbtx2pcPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_tx_2pc_point_scale(pt : Dbtx2pcPoint, s : Double) -> Dbtx2pcPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_tx_2pc_point_dot(a : Dbtx2pcPoint, b : Dbtx2pcPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_tx_2pc_point_cross(a : Dbtx2pcPoint, b : Dbtx2pcPoint) -> Dbtx2pcPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_tx_2pc_point_norm(pt : Dbtx2pcPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_tx_2pc_point_normalize(pt : Dbtx2pcPoint) -> Dbtx2pcPoint {
  let n = db_tx_2pc_point_norm(pt)
  if n < 0.0000001 { pt } else { db_tx_2pc_point_scale(pt, 1.0 / n) }
}

pub fn db_tx_2pc_point_negate(pt : Dbtx2pcPoint) -> Dbtx2pcPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_tx_2pc_point_mid(a : Dbtx2pcPoint, b : Dbtx2pcPoint) -> Dbtx2pcPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_tx_2pc_point_lerp(a : Dbtx2pcPoint, b : Dbtx2pcPoint, t : Double) -> Dbtx2pcPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_tx_2pc_point_to_string(pt : Dbtx2pcPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Dbtx2pcSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_2pc_make_series(vals : Array[Double], name : String) -> Dbtx2pcSeries {
  { vals, name, meta: 0 }
}

pub fn db_tx_2pc_series_len(s : Dbtx2pcSeries) -> Int { s.vals.length() }

pub fn db_tx_2pc_series_sum(s : Dbtx2pcSeries) -> Double { @_common.sum(s.vals) }

pub fn db_tx_2pc_series_mean(s : Dbtx2pcSeries) -> Double { @_common.mean(s.vals) }

pub fn db_tx_2pc_series_min(s : Dbtx2pcSeries) -> Double { @_common.min(s.vals) }

pub fn db_tx_2pc_series_max(s : Dbtx2pcSeries) -> Double { @_common.max(s.vals) }

pub fn db_tx_2pc_series_range(s : Dbtx2pcSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_tx_2pc_series_var(s : Dbtx2pcSeries) -> Double { @_common.variance(s.vals) }

pub fn db_tx_2pc_series_std(s : Dbtx2pcSeries) -> Double { @_common.std(s.vals) }

pub fn db_tx_2pc_series_median(s : Dbtx2pcSeries) -> Double { @_common.median(s.vals) }

pub fn db_tx_2pc_series_scale(s : Dbtx2pcSeries, f : Double) -> Dbtx2pcSeries {
  { vals: @_common.scale_arr(s.vals, f), name: s.name, meta: s.meta }
}

pub fn db_tx_2pc_series_add(a : Dbtx2pcSeries, b : Dbtx2pcSeries) -> Dbtx2pcSeries {
  { vals: @_common.add_arr(a.vals, b.vals), name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_tx_2pc_series_sub(a : Dbtx2pcSeries, b : Dbtx2pcSeries) -> Dbtx2pcSeries {
  { vals: @_common.sub_arr(a.vals, b.vals), name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_tx_2pc_series_normalize(s : Dbtx2pcSeries) -> Dbtx2pcSeries {
  let mn = db_tx_2pc_series_min(s)
  let mx = db_tx_2pc_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_tx_2pc_series_cumsum(s : Dbtx2pcSeries) -> Dbtx2pcSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_tx_2pc_series_to_string(s : Dbtx2pcSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Dbtx2pcMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_2pc_make_matrix(rows : Int, cols : Int, val : Double) -> Dbtx2pcMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_2pc_matrix_identity(n : Int) -> Dbtx2pcMatrix {
  let m = db_tx_2pc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_tx_2pc_matrix_get(m : Dbtx2pcMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_tx_2pc_matrix_transpose(m : Dbtx2pcMatrix) -> Dbtx2pcMatrix {
  let result = db_tx_2pc_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_tx_2pc_matrix_add(a : Dbtx2pcMatrix, b : Dbtx2pcMatrix) -> Dbtx2pcMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_tx_2pc_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_tx_2pc_matrix_scale(m : Dbtx2pcMatrix, s : Double) -> Dbtx2pcMatrix {
  let result = db_tx_2pc_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_tx_2pc_matrix_multiply(a : Dbtx2pcMatrix, b : Dbtx2pcMatrix) -> Dbtx2pcMatrix {
  if a.cols != b.rows { return db_tx_2pc_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_tx_2pc_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_tx_2pc_matrix_trace(m : Dbtx2pcMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_tx_2pc_matrix_det(m : Dbtx2pcMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_tx_2pc_matrix_norm(m : Dbtx2pcMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_tx_2pc_matrix_to_string(m : Dbtx2pcMatrix) -> String {
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

pub(all) struct Dbtx2pcVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_2pc_make_vector(comps : Array[Double]) -> Dbtx2pcVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_2pc_vector_zero(dim : Int) -> Dbtx2pcVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_tx_2pc_vector_add(a : Dbtx2pcVector, b : Dbtx2pcVector) -> Dbtx2pcVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.add_arr(a.comps, b.comps), dim: n }
}

pub fn db_tx_2pc_vector_sub(a : Dbtx2pcVector, b : Dbtx2pcVector) -> Dbtx2pcVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  { comps: @_common.sub_arr(a.comps, b.comps), dim: n }
}

pub fn db_tx_2pc_vector_scale(v : Dbtx2pcVector, s : Double) -> Dbtx2pcVector {
  { comps: @_common.scale_arr(v.comps, s), dim: v.dim }
}

pub fn db_tx_2pc_vector_dot(a : Dbtx2pcVector, b : Dbtx2pcVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_tx_2pc_vector_norm(v : Dbtx2pcVector) -> Double { @_common.sqrt(db_tx_2pc_vector_dot(v, v)) }

pub fn db_tx_2pc_vector_normalize(v : Dbtx2pcVector) -> Dbtx2pcVector {
  let n = db_tx_2pc_vector_norm(v)
  if n < 0.0000001 { v } else { db_tx_2pc_vector_scale(v, 1.0 / n) }
}

pub fn db_tx_2pc_vector_dist(a : Dbtx2pcVector, b : Dbtx2pcVector) -> Double {
  db_tx_2pc_vector_norm(db_tx_2pc_vector_sub(a, b))
}

pub fn db_tx_2pc_vector_to_string(v : Dbtx2pcVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_2pc_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_tx_2pc_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_tx_2pc_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_tx_2pc_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_tx_2pc_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_tx_2pc_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_tx_2pc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_tx_2pc_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_tx_2pc_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_tx_2pc_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_tx_2pc_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_tx_2pc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_tx_2pc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_tx_2pc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_tx_2pc_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_tx_2pc_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_tx_2pc_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_tx_2pc_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_tx_2pc_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_tx_2pc_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_tx_2pc_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_tx_2pc_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_tx_2pc_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_tx_2pc_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_tx_2pc_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_tx_2pc_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_tx_2pc_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_tx_2pc_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_tx_2pc_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Dbtx2pcFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_2pc_frame_make(size : Int) -> Dbtx2pcFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_2pc_frame_len(s : Dbtx2pcFrame) -> Int { s.size }

pub fn db_tx_2pc_frame_get(s : Dbtx2pcFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_2pc_frame_set(s : Dbtx2pcFrame, i : Int, v : Double) -> Dbtx2pcFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_frame_sum(s : Dbtx2pcFrame) -> Double { @_common.sum(s.data) }

pub fn db_tx_2pc_frame_mean(s : Dbtx2pcFrame) -> Double { @_common.mean(s.data) }

pub fn db_tx_2pc_frame_scale(s : Dbtx2pcFrame, f : Double) -> Dbtx2pcFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_frame_add(a : Dbtx2pcFrame, b : Dbtx2pcFrame) -> Dbtx2pcFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_2pc_frame_copy(s : Dbtx2pcFrame) -> Dbtx2pcFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_frame_fill(s : Dbtx2pcFrame, v : Double) -> Dbtx2pcFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_frame_min(s : Dbtx2pcFrame) -> Double { @_common.min(s.data) }

pub fn db_tx_2pc_frame_max(s : Dbtx2pcFrame) -> Double { @_common.max(s.data) }

pub fn db_tx_2pc_frame_to_string(s : Dbtx2pcFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx2pcTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_2pc_table_make(size : Int) -> Dbtx2pcTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_2pc_table_len(s : Dbtx2pcTable) -> Int { s.size }

pub fn db_tx_2pc_table_get(s : Dbtx2pcTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_2pc_table_set(s : Dbtx2pcTable, i : Int, v : Double) -> Dbtx2pcTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_table_sum(s : Dbtx2pcTable) -> Double { @_common.sum(s.data) }

pub fn db_tx_2pc_table_mean(s : Dbtx2pcTable) -> Double { @_common.mean(s.data) }

pub fn db_tx_2pc_table_scale(s : Dbtx2pcTable, f : Double) -> Dbtx2pcTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_table_add(a : Dbtx2pcTable, b : Dbtx2pcTable) -> Dbtx2pcTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_2pc_table_copy(s : Dbtx2pcTable) -> Dbtx2pcTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_table_fill(s : Dbtx2pcTable, v : Double) -> Dbtx2pcTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_table_min(s : Dbtx2pcTable) -> Double { @_common.min(s.data) }

pub fn db_tx_2pc_table_max(s : Dbtx2pcTable) -> Double { @_common.max(s.data) }

pub fn db_tx_2pc_table_to_string(s : Dbtx2pcTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx2pcGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_2pc_graphn_make(size : Int) -> Dbtx2pcGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_2pc_graphn_len(s : Dbtx2pcGraphN) -> Int { s.size }

pub fn db_tx_2pc_graphn_get(s : Dbtx2pcGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_2pc_graphn_set(s : Dbtx2pcGraphN, i : Int, v : Double) -> Dbtx2pcGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_graphn_sum(s : Dbtx2pcGraphN) -> Double { @_common.sum(s.data) }

pub fn db_tx_2pc_graphn_mean(s : Dbtx2pcGraphN) -> Double { @_common.mean(s.data) }

pub fn db_tx_2pc_graphn_scale(s : Dbtx2pcGraphN, f : Double) -> Dbtx2pcGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_graphn_add(a : Dbtx2pcGraphN, b : Dbtx2pcGraphN) -> Dbtx2pcGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_2pc_graphn_copy(s : Dbtx2pcGraphN) -> Dbtx2pcGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_graphn_fill(s : Dbtx2pcGraphN, v : Double) -> Dbtx2pcGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_graphn_min(s : Dbtx2pcGraphN) -> Double { @_common.min(s.data) }

pub fn db_tx_2pc_graphn_max(s : Dbtx2pcGraphN) -> Double { @_common.max(s.data) }

pub fn db_tx_2pc_graphn_to_string(s : Dbtx2pcGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx2pcNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_2pc_node_make(size : Int) -> Dbtx2pcNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_2pc_node_len(s : Dbtx2pcNode) -> Int { s.size }

pub fn db_tx_2pc_node_get(s : Dbtx2pcNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_2pc_node_set(s : Dbtx2pcNode, i : Int, v : Double) -> Dbtx2pcNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_node_sum(s : Dbtx2pcNode) -> Double { @_common.sum(s.data) }

pub fn db_tx_2pc_node_mean(s : Dbtx2pcNode) -> Double { @_common.mean(s.data) }

pub fn db_tx_2pc_node_scale(s : Dbtx2pcNode, f : Double) -> Dbtx2pcNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_node_add(a : Dbtx2pcNode, b : Dbtx2pcNode) -> Dbtx2pcNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_2pc_node_copy(s : Dbtx2pcNode) -> Dbtx2pcNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_node_fill(s : Dbtx2pcNode, v : Double) -> Dbtx2pcNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_node_min(s : Dbtx2pcNode) -> Double { @_common.min(s.data) }

pub fn db_tx_2pc_node_max(s : Dbtx2pcNode) -> Double { @_common.max(s.data) }

pub fn db_tx_2pc_node_to_string(s : Dbtx2pcNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx2pcEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_2pc_edge_make(size : Int) -> Dbtx2pcEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_2pc_edge_len(s : Dbtx2pcEdge) -> Int { s.size }

pub fn db_tx_2pc_edge_get(s : Dbtx2pcEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_2pc_edge_set(s : Dbtx2pcEdge, i : Int, v : Double) -> Dbtx2pcEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_edge_sum(s : Dbtx2pcEdge) -> Double { @_common.sum(s.data) }

pub fn db_tx_2pc_edge_mean(s : Dbtx2pcEdge) -> Double { @_common.mean(s.data) }

pub fn db_tx_2pc_edge_scale(s : Dbtx2pcEdge, f : Double) -> Dbtx2pcEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_edge_add(a : Dbtx2pcEdge, b : Dbtx2pcEdge) -> Dbtx2pcEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_2pc_edge_copy(s : Dbtx2pcEdge) -> Dbtx2pcEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_edge_fill(s : Dbtx2pcEdge, v : Double) -> Dbtx2pcEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_edge_min(s : Dbtx2pcEdge) -> Double { @_common.min(s.data) }

pub fn db_tx_2pc_edge_max(s : Dbtx2pcEdge) -> Double { @_common.max(s.data) }

pub fn db_tx_2pc_edge_to_string(s : Dbtx2pcEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx2pcPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_2pc_path_make(size : Int) -> Dbtx2pcPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_2pc_path_len(s : Dbtx2pcPath) -> Int { s.size }

pub fn db_tx_2pc_path_get(s : Dbtx2pcPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_2pc_path_set(s : Dbtx2pcPath, i : Int, v : Double) -> Dbtx2pcPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_path_sum(s : Dbtx2pcPath) -> Double { @_common.sum(s.data) }

pub fn db_tx_2pc_path_mean(s : Dbtx2pcPath) -> Double { @_common.mean(s.data) }

pub fn db_tx_2pc_path_scale(s : Dbtx2pcPath, f : Double) -> Dbtx2pcPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_path_add(a : Dbtx2pcPath, b : Dbtx2pcPath) -> Dbtx2pcPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_2pc_path_copy(s : Dbtx2pcPath) -> Dbtx2pcPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_path_fill(s : Dbtx2pcPath, v : Double) -> Dbtx2pcPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_path_min(s : Dbtx2pcPath) -> Double { @_common.min(s.data) }

pub fn db_tx_2pc_path_max(s : Dbtx2pcPath) -> Double { @_common.max(s.data) }

pub fn db_tx_2pc_path_to_string(s : Dbtx2pcPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx2pcCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_2pc_cluster_make(size : Int) -> Dbtx2pcCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_2pc_cluster_len(s : Dbtx2pcCluster) -> Int { s.size }

pub fn db_tx_2pc_cluster_get(s : Dbtx2pcCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_2pc_cluster_set(s : Dbtx2pcCluster, i : Int, v : Double) -> Dbtx2pcCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_cluster_sum(s : Dbtx2pcCluster) -> Double { @_common.sum(s.data) }

pub fn db_tx_2pc_cluster_mean(s : Dbtx2pcCluster) -> Double { @_common.mean(s.data) }

pub fn db_tx_2pc_cluster_scale(s : Dbtx2pcCluster, f : Double) -> Dbtx2pcCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_cluster_add(a : Dbtx2pcCluster, b : Dbtx2pcCluster) -> Dbtx2pcCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_2pc_cluster_copy(s : Dbtx2pcCluster) -> Dbtx2pcCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_cluster_fill(s : Dbtx2pcCluster, v : Double) -> Dbtx2pcCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_cluster_min(s : Dbtx2pcCluster) -> Double { @_common.min(s.data) }

pub fn db_tx_2pc_cluster_max(s : Dbtx2pcCluster) -> Double { @_common.max(s.data) }

pub fn db_tx_2pc_cluster_to_string(s : Dbtx2pcCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx2pcModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_2pc_model_make(size : Int) -> Dbtx2pcModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_2pc_model_len(s : Dbtx2pcModel) -> Int { s.size }

pub fn db_tx_2pc_model_get(s : Dbtx2pcModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_2pc_model_set(s : Dbtx2pcModel, i : Int, v : Double) -> Dbtx2pcModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_model_sum(s : Dbtx2pcModel) -> Double { @_common.sum(s.data) }

pub fn db_tx_2pc_model_mean(s : Dbtx2pcModel) -> Double { @_common.mean(s.data) }

pub fn db_tx_2pc_model_scale(s : Dbtx2pcModel, f : Double) -> Dbtx2pcModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_model_add(a : Dbtx2pcModel, b : Dbtx2pcModel) -> Dbtx2pcModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_2pc_model_copy(s : Dbtx2pcModel) -> Dbtx2pcModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_model_fill(s : Dbtx2pcModel, v : Double) -> Dbtx2pcModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_model_min(s : Dbtx2pcModel) -> Double { @_common.min(s.data) }

pub fn db_tx_2pc_model_max(s : Dbtx2pcModel) -> Double { @_common.max(s.data) }

pub fn db_tx_2pc_model_to_string(s : Dbtx2pcModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx2pcLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_2pc_layer_make(size : Int) -> Dbtx2pcLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_2pc_layer_len(s : Dbtx2pcLayer) -> Int { s.size }

pub fn db_tx_2pc_layer_get(s : Dbtx2pcLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_2pc_layer_set(s : Dbtx2pcLayer, i : Int, v : Double) -> Dbtx2pcLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_layer_sum(s : Dbtx2pcLayer) -> Double { @_common.sum(s.data) }

pub fn db_tx_2pc_layer_mean(s : Dbtx2pcLayer) -> Double { @_common.mean(s.data) }

pub fn db_tx_2pc_layer_scale(s : Dbtx2pcLayer, f : Double) -> Dbtx2pcLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_layer_add(a : Dbtx2pcLayer, b : Dbtx2pcLayer) -> Dbtx2pcLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_2pc_layer_copy(s : Dbtx2pcLayer) -> Dbtx2pcLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_layer_fill(s : Dbtx2pcLayer, v : Double) -> Dbtx2pcLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_layer_min(s : Dbtx2pcLayer) -> Double { @_common.min(s.data) }

pub fn db_tx_2pc_layer_max(s : Dbtx2pcLayer) -> Double { @_common.max(s.data) }

pub fn db_tx_2pc_layer_to_string(s : Dbtx2pcLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx2pcBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_2pc_buffer_make(size : Int) -> Dbtx2pcBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_2pc_buffer_len(s : Dbtx2pcBuffer) -> Int { s.size }

pub fn db_tx_2pc_buffer_get(s : Dbtx2pcBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_2pc_buffer_set(s : Dbtx2pcBuffer, i : Int, v : Double) -> Dbtx2pcBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_buffer_sum(s : Dbtx2pcBuffer) -> Double { @_common.sum(s.data) }

pub fn db_tx_2pc_buffer_mean(s : Dbtx2pcBuffer) -> Double { @_common.mean(s.data) }

pub fn db_tx_2pc_buffer_scale(s : Dbtx2pcBuffer, f : Double) -> Dbtx2pcBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_buffer_add(a : Dbtx2pcBuffer, b : Dbtx2pcBuffer) -> Dbtx2pcBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_2pc_buffer_copy(s : Dbtx2pcBuffer) -> Dbtx2pcBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_buffer_fill(s : Dbtx2pcBuffer, v : Double) -> Dbtx2pcBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_buffer_min(s : Dbtx2pcBuffer) -> Double { @_common.min(s.data) }

pub fn db_tx_2pc_buffer_max(s : Dbtx2pcBuffer) -> Double { @_common.max(s.data) }

pub fn db_tx_2pc_buffer_to_string(s : Dbtx2pcBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx2pcCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_2pc_cursor_make(size : Int) -> Dbtx2pcCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_2pc_cursor_len(s : Dbtx2pcCursor) -> Int { s.size }

pub fn db_tx_2pc_cursor_get(s : Dbtx2pcCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_2pc_cursor_set(s : Dbtx2pcCursor, i : Int, v : Double) -> Dbtx2pcCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_cursor_sum(s : Dbtx2pcCursor) -> Double { @_common.sum(s.data) }

pub fn db_tx_2pc_cursor_mean(s : Dbtx2pcCursor) -> Double { @_common.mean(s.data) }

pub fn db_tx_2pc_cursor_scale(s : Dbtx2pcCursor, f : Double) -> Dbtx2pcCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_cursor_add(a : Dbtx2pcCursor, b : Dbtx2pcCursor) -> Dbtx2pcCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_2pc_cursor_copy(s : Dbtx2pcCursor) -> Dbtx2pcCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_cursor_fill(s : Dbtx2pcCursor, v : Double) -> Dbtx2pcCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_cursor_min(s : Dbtx2pcCursor) -> Double { @_common.min(s.data) }

pub fn db_tx_2pc_cursor_max(s : Dbtx2pcCursor) -> Double { @_common.max(s.data) }

pub fn db_tx_2pc_cursor_to_string(s : Dbtx2pcCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx2pcView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_2pc_view_make(size : Int) -> Dbtx2pcView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_2pc_view_len(s : Dbtx2pcView) -> Int { s.size }

pub fn db_tx_2pc_view_get(s : Dbtx2pcView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_2pc_view_set(s : Dbtx2pcView, i : Int, v : Double) -> Dbtx2pcView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_view_sum(s : Dbtx2pcView) -> Double { @_common.sum(s.data) }

pub fn db_tx_2pc_view_mean(s : Dbtx2pcView) -> Double { @_common.mean(s.data) }

pub fn db_tx_2pc_view_scale(s : Dbtx2pcView, f : Double) -> Dbtx2pcView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_view_add(a : Dbtx2pcView, b : Dbtx2pcView) -> Dbtx2pcView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_2pc_view_copy(s : Dbtx2pcView) -> Dbtx2pcView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_view_fill(s : Dbtx2pcView, v : Double) -> Dbtx2pcView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_view_min(s : Dbtx2pcView) -> Double { @_common.min(s.data) }

pub fn db_tx_2pc_view_max(s : Dbtx2pcView) -> Double { @_common.max(s.data) }

pub fn db_tx_2pc_view_to_string(s : Dbtx2pcView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx2pcRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_2pc_range_make(size : Int) -> Dbtx2pcRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_2pc_range_len(s : Dbtx2pcRange) -> Int { s.size }

pub fn db_tx_2pc_range_get(s : Dbtx2pcRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_2pc_range_set(s : Dbtx2pcRange, i : Int, v : Double) -> Dbtx2pcRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_range_sum(s : Dbtx2pcRange) -> Double { @_common.sum(s.data) }

pub fn db_tx_2pc_range_mean(s : Dbtx2pcRange) -> Double { @_common.mean(s.data) }

pub fn db_tx_2pc_range_scale(s : Dbtx2pcRange, f : Double) -> Dbtx2pcRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_range_add(a : Dbtx2pcRange, b : Dbtx2pcRange) -> Dbtx2pcRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_2pc_range_copy(s : Dbtx2pcRange) -> Dbtx2pcRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_range_fill(s : Dbtx2pcRange, v : Double) -> Dbtx2pcRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_range_min(s : Dbtx2pcRange) -> Double { @_common.min(s.data) }

pub fn db_tx_2pc_range_max(s : Dbtx2pcRange) -> Double { @_common.max(s.data) }

pub fn db_tx_2pc_range_to_string(s : Dbtx2pcRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx2pcSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_2pc_slice_make(size : Int) -> Dbtx2pcSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_2pc_slice_len(s : Dbtx2pcSlice) -> Int { s.size }

pub fn db_tx_2pc_slice_get(s : Dbtx2pcSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_2pc_slice_set(s : Dbtx2pcSlice, i : Int, v : Double) -> Dbtx2pcSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_slice_sum(s : Dbtx2pcSlice) -> Double { @_common.sum(s.data) }

pub fn db_tx_2pc_slice_mean(s : Dbtx2pcSlice) -> Double { @_common.mean(s.data) }

pub fn db_tx_2pc_slice_scale(s : Dbtx2pcSlice, f : Double) -> Dbtx2pcSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_slice_add(a : Dbtx2pcSlice, b : Dbtx2pcSlice) -> Dbtx2pcSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_2pc_slice_copy(s : Dbtx2pcSlice) -> Dbtx2pcSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_slice_fill(s : Dbtx2pcSlice, v : Double) -> Dbtx2pcSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_2pc_slice_min(s : Dbtx2pcSlice) -> Double { @_common.min(s.data) }

pub fn db_tx_2pc_slice_max(s : Dbtx2pcSlice) -> Double { @_common.max(s.data) }

pub fn db_tx_2pc_slice_to_string(s : Dbtx2pcSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

