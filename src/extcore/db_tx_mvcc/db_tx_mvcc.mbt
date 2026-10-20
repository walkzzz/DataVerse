///===
/// extcore/db_tx_mvcc

pub(all) struct DbtxmvccPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_mvcc_make_point(x : Double, y : Double) -> DbtxmvccPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_mvcc_make_point3(x : Double, y : Double, z : Double) -> DbtxmvccPoint {
  { x, y, z, label: 0 }
}

pub fn db_tx_mvcc_point_x(pt : DbtxmvccPoint) -> Double { pt.x }

pub fn db_tx_mvcc_point_y(pt : DbtxmvccPoint) -> Double { pt.y }

pub fn db_tx_mvcc_point_z(pt : DbtxmvccPoint) -> Double { pt.z }

pub fn db_tx_mvcc_point_label(pt : DbtxmvccPoint) -> Int { pt.label }

pub fn db_tx_mvcc_point_dist(a : DbtxmvccPoint, b : DbtxmvccPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_tx_mvcc_point_add(a : DbtxmvccPoint, b : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_tx_mvcc_point_sub(a : DbtxmvccPoint, b : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_tx_mvcc_point_scale(pt : DbtxmvccPoint, s : Double) -> DbtxmvccPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_tx_mvcc_point_dot(a : DbtxmvccPoint, b : DbtxmvccPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_tx_mvcc_point_cross(a : DbtxmvccPoint, b : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_tx_mvcc_point_norm(pt : DbtxmvccPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_tx_mvcc_point_normalize(pt : DbtxmvccPoint) -> DbtxmvccPoint {
  let n = db_tx_mvcc_point_norm(pt)
  if n < 0.0000001 { pt } else { db_tx_mvcc_point_scale(pt, 1.0 / n) }
}

pub fn db_tx_mvcc_point_negate(pt : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_tx_mvcc_point_mid(a : DbtxmvccPoint, b : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_tx_mvcc_point_lerp(a : DbtxmvccPoint, b : DbtxmvccPoint, t : Double) -> DbtxmvccPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_tx_mvcc_point_to_string(pt : DbtxmvccPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbtxmvccSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_mvcc_make_series(vals : Array[Double], name : String) -> DbtxmvccSeries {
  { vals, name, meta: 0 }
}

pub fn db_tx_mvcc_series_len(s : DbtxmvccSeries) -> Int { s.vals.length() }

pub fn db_tx_mvcc_series_sum(s : DbtxmvccSeries) -> Double { @_common.sum(s.vals) }

pub fn db_tx_mvcc_series_mean(s : DbtxmvccSeries) -> Double { @_common.mean(s.vals) }

pub fn db_tx_mvcc_series_min(s : DbtxmvccSeries) -> Double { @_common.min(s.vals) }

pub fn db_tx_mvcc_series_max(s : DbtxmvccSeries) -> Double { @_common.max(s.vals) }

pub fn db_tx_mvcc_series_range(s : DbtxmvccSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_tx_mvcc_series_var(s : DbtxmvccSeries) -> Double { @_common.variance(s.vals) }

pub fn db_tx_mvcc_series_std(s : DbtxmvccSeries) -> Double { @_common.std(s.vals) }

pub fn db_tx_mvcc_series_median(s : DbtxmvccSeries) -> Double { @_common.median(s.vals) }

pub fn db_tx_mvcc_series_scale(s : DbtxmvccSeries, f : Double) -> DbtxmvccSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_tx_mvcc_series_add(a : DbtxmvccSeries, b : DbtxmvccSeries) -> DbtxmvccSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_tx_mvcc_series_sub(a : DbtxmvccSeries, b : DbtxmvccSeries) -> DbtxmvccSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_tx_mvcc_series_normalize(s : DbtxmvccSeries) -> DbtxmvccSeries {
  let mn = db_tx_mvcc_series_min(s)
  let mx = db_tx_mvcc_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_tx_mvcc_series_cumsum(s : DbtxmvccSeries) -> DbtxmvccSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_tx_mvcc_series_to_string(s : DbtxmvccSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxmvccMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_mvcc_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxmvccMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_mvcc_matrix_identity(n : Int) -> DbtxmvccMatrix {
  let m = db_tx_mvcc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_tx_mvcc_matrix_get(m : DbtxmvccMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_tx_mvcc_matrix_transpose(m : DbtxmvccMatrix) -> DbtxmvccMatrix {
  let result = db_tx_mvcc_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_tx_mvcc_matrix_add(a : DbtxmvccMatrix, b : DbtxmvccMatrix) -> DbtxmvccMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_tx_mvcc_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_tx_mvcc_matrix_scale(m : DbtxmvccMatrix, s : Double) -> DbtxmvccMatrix {
  let result = db_tx_mvcc_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_tx_mvcc_matrix_multiply(a : DbtxmvccMatrix, b : DbtxmvccMatrix) -> DbtxmvccMatrix {
  if a.cols != b.rows { return db_tx_mvcc_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_tx_mvcc_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_tx_mvcc_matrix_trace(m : DbtxmvccMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_tx_mvcc_matrix_det(m : DbtxmvccMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_tx_mvcc_matrix_norm(m : DbtxmvccMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_tx_mvcc_matrix_to_string(m : DbtxmvccMatrix) -> String {
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

pub(all) struct DbtxmvccVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_mvcc_make_vector(comps : Array[Double]) -> DbtxmvccVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_mvcc_vector_zero(dim : Int) -> DbtxmvccVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_tx_mvcc_vector_add(a : DbtxmvccVector, b : DbtxmvccVector) -> DbtxmvccVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_mvcc_vector_sub(a : DbtxmvccVector, b : DbtxmvccVector) -> DbtxmvccVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_mvcc_vector_scale(v : DbtxmvccVector, s : Double) -> DbtxmvccVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_tx_mvcc_vector_dot(a : DbtxmvccVector, b : DbtxmvccVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_tx_mvcc_vector_norm(v : DbtxmvccVector) -> Double { @_common.sqrt(db_tx_mvcc_vector_dot(v, v)) }

pub fn db_tx_mvcc_vector_normalize(v : DbtxmvccVector) -> DbtxmvccVector {
  let n = db_tx_mvcc_vector_norm(v)
  if n < 0.0000001 { v } else { db_tx_mvcc_vector_scale(v, 1.0 / n) }
}

pub fn db_tx_mvcc_vector_dist(a : DbtxmvccVector, b : DbtxmvccVector) -> Double {
  db_tx_mvcc_vector_norm(db_tx_mvcc_vector_sub(a, b))
}

pub fn db_tx_mvcc_vector_to_string(v : DbtxmvccVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_mvcc_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_tx_mvcc_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_tx_mvcc_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_tx_mvcc_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_tx_mvcc_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_tx_mvcc_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_tx_mvcc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_tx_mvcc_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_tx_mvcc_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_tx_mvcc_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_tx_mvcc_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_tx_mvcc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_tx_mvcc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_tx_mvcc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_tx_mvcc_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_tx_mvcc_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_tx_mvcc_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_tx_mvcc_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_tx_mvcc_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_tx_mvcc_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_tx_mvcc_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_tx_mvcc_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_tx_mvcc_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_tx_mvcc_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_tx_mvcc_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_tx_mvcc_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_tx_mvcc_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_tx_mvcc_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_tx_mvcc_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbtxmvccFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_frame_make(size : Int) -> DbtxmvccFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_frame_len(s : DbtxmvccFrame) -> Int { s.size }

pub fn db_tx_mvcc_frame_get(s : DbtxmvccFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_frame_set(s : DbtxmvccFrame, i : Int, v : Double) -> DbtxmvccFrame {
  let result = db_tx_mvcc_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_frame_sum(s : DbtxmvccFrame) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_frame_mean(s : DbtxmvccFrame) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_frame_scale(s : DbtxmvccFrame, f : Double) -> DbtxmvccFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_frame_add(a : DbtxmvccFrame, b : DbtxmvccFrame) -> DbtxmvccFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_frame_copy(s : DbtxmvccFrame) -> DbtxmvccFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_frame_fill(s : DbtxmvccFrame, v : Double) -> DbtxmvccFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_frame_min(s : DbtxmvccFrame) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_frame_max(s : DbtxmvccFrame) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_frame_to_string(s : DbtxmvccFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_table_make(size : Int) -> DbtxmvccTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_table_len(s : DbtxmvccTable) -> Int { s.size }

pub fn db_tx_mvcc_table_get(s : DbtxmvccTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_table_set(s : DbtxmvccTable, i : Int, v : Double) -> DbtxmvccTable {
  let result = db_tx_mvcc_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_table_sum(s : DbtxmvccTable) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_table_mean(s : DbtxmvccTable) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_table_scale(s : DbtxmvccTable, f : Double) -> DbtxmvccTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_table_add(a : DbtxmvccTable, b : DbtxmvccTable) -> DbtxmvccTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_table_copy(s : DbtxmvccTable) -> DbtxmvccTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_table_fill(s : DbtxmvccTable, v : Double) -> DbtxmvccTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_table_min(s : DbtxmvccTable) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_table_max(s : DbtxmvccTable) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_table_to_string(s : DbtxmvccTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_graphn_make(size : Int) -> DbtxmvccGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_graphn_len(s : DbtxmvccGraphN) -> Int { s.size }

pub fn db_tx_mvcc_graphn_get(s : DbtxmvccGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_graphn_set(s : DbtxmvccGraphN, i : Int, v : Double) -> DbtxmvccGraphN {
  let result = db_tx_mvcc_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_graphn_sum(s : DbtxmvccGraphN) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_graphn_mean(s : DbtxmvccGraphN) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_graphn_scale(s : DbtxmvccGraphN, f : Double) -> DbtxmvccGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_graphn_add(a : DbtxmvccGraphN, b : DbtxmvccGraphN) -> DbtxmvccGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_graphn_copy(s : DbtxmvccGraphN) -> DbtxmvccGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_graphn_fill(s : DbtxmvccGraphN, v : Double) -> DbtxmvccGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_graphn_min(s : DbtxmvccGraphN) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_graphn_max(s : DbtxmvccGraphN) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_graphn_to_string(s : DbtxmvccGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_node_make(size : Int) -> DbtxmvccNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_node_len(s : DbtxmvccNode) -> Int { s.size }

pub fn db_tx_mvcc_node_get(s : DbtxmvccNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_node_set(s : DbtxmvccNode, i : Int, v : Double) -> DbtxmvccNode {
  let result = db_tx_mvcc_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_node_sum(s : DbtxmvccNode) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_node_mean(s : DbtxmvccNode) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_node_scale(s : DbtxmvccNode, f : Double) -> DbtxmvccNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_node_add(a : DbtxmvccNode, b : DbtxmvccNode) -> DbtxmvccNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_node_copy(s : DbtxmvccNode) -> DbtxmvccNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_node_fill(s : DbtxmvccNode, v : Double) -> DbtxmvccNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_node_min(s : DbtxmvccNode) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_node_max(s : DbtxmvccNode) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_node_to_string(s : DbtxmvccNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_edge_make(size : Int) -> DbtxmvccEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_edge_len(s : DbtxmvccEdge) -> Int { s.size }

pub fn db_tx_mvcc_edge_get(s : DbtxmvccEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_edge_set(s : DbtxmvccEdge, i : Int, v : Double) -> DbtxmvccEdge {
  let result = db_tx_mvcc_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_edge_sum(s : DbtxmvccEdge) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_edge_mean(s : DbtxmvccEdge) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_edge_scale(s : DbtxmvccEdge, f : Double) -> DbtxmvccEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_edge_add(a : DbtxmvccEdge, b : DbtxmvccEdge) -> DbtxmvccEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_edge_copy(s : DbtxmvccEdge) -> DbtxmvccEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_edge_fill(s : DbtxmvccEdge, v : Double) -> DbtxmvccEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_edge_min(s : DbtxmvccEdge) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_edge_max(s : DbtxmvccEdge) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_edge_to_string(s : DbtxmvccEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_path_make(size : Int) -> DbtxmvccPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_path_len(s : DbtxmvccPath) -> Int { s.size }

pub fn db_tx_mvcc_path_get(s : DbtxmvccPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_path_set(s : DbtxmvccPath, i : Int, v : Double) -> DbtxmvccPath {
  let result = db_tx_mvcc_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_path_sum(s : DbtxmvccPath) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_path_mean(s : DbtxmvccPath) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_path_scale(s : DbtxmvccPath, f : Double) -> DbtxmvccPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_path_add(a : DbtxmvccPath, b : DbtxmvccPath) -> DbtxmvccPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_path_copy(s : DbtxmvccPath) -> DbtxmvccPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_path_fill(s : DbtxmvccPath, v : Double) -> DbtxmvccPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_path_min(s : DbtxmvccPath) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_path_max(s : DbtxmvccPath) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_path_to_string(s : DbtxmvccPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_cluster_make(size : Int) -> DbtxmvccCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_cluster_len(s : DbtxmvccCluster) -> Int { s.size }

pub fn db_tx_mvcc_cluster_get(s : DbtxmvccCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_cluster_set(s : DbtxmvccCluster, i : Int, v : Double) -> DbtxmvccCluster {
  let result = db_tx_mvcc_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_cluster_sum(s : DbtxmvccCluster) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_cluster_mean(s : DbtxmvccCluster) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_cluster_scale(s : DbtxmvccCluster, f : Double) -> DbtxmvccCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_cluster_add(a : DbtxmvccCluster, b : DbtxmvccCluster) -> DbtxmvccCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_cluster_copy(s : DbtxmvccCluster) -> DbtxmvccCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_cluster_fill(s : DbtxmvccCluster, v : Double) -> DbtxmvccCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_cluster_min(s : DbtxmvccCluster) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_cluster_max(s : DbtxmvccCluster) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_cluster_to_string(s : DbtxmvccCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_model_make(size : Int) -> DbtxmvccModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_model_len(s : DbtxmvccModel) -> Int { s.size }

pub fn db_tx_mvcc_model_get(s : DbtxmvccModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_model_set(s : DbtxmvccModel, i : Int, v : Double) -> DbtxmvccModel {
  let result = db_tx_mvcc_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_model_sum(s : DbtxmvccModel) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_model_mean(s : DbtxmvccModel) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_model_scale(s : DbtxmvccModel, f : Double) -> DbtxmvccModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_model_add(a : DbtxmvccModel, b : DbtxmvccModel) -> DbtxmvccModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_model_copy(s : DbtxmvccModel) -> DbtxmvccModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_model_fill(s : DbtxmvccModel, v : Double) -> DbtxmvccModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_model_min(s : DbtxmvccModel) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_model_max(s : DbtxmvccModel) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_model_to_string(s : DbtxmvccModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_layer_make(size : Int) -> DbtxmvccLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_layer_len(s : DbtxmvccLayer) -> Int { s.size }

pub fn db_tx_mvcc_layer_get(s : DbtxmvccLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_layer_set(s : DbtxmvccLayer, i : Int, v : Double) -> DbtxmvccLayer {
  let result = db_tx_mvcc_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_layer_sum(s : DbtxmvccLayer) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_layer_mean(s : DbtxmvccLayer) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_layer_scale(s : DbtxmvccLayer, f : Double) -> DbtxmvccLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_layer_add(a : DbtxmvccLayer, b : DbtxmvccLayer) -> DbtxmvccLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_layer_copy(s : DbtxmvccLayer) -> DbtxmvccLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_layer_fill(s : DbtxmvccLayer, v : Double) -> DbtxmvccLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_layer_min(s : DbtxmvccLayer) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_layer_max(s : DbtxmvccLayer) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_layer_to_string(s : DbtxmvccLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_buffer_make(size : Int) -> DbtxmvccBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_buffer_len(s : DbtxmvccBuffer) -> Int { s.size }

pub fn db_tx_mvcc_buffer_get(s : DbtxmvccBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_buffer_set(s : DbtxmvccBuffer, i : Int, v : Double) -> DbtxmvccBuffer {
  let result = db_tx_mvcc_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_buffer_sum(s : DbtxmvccBuffer) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_buffer_mean(s : DbtxmvccBuffer) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_buffer_scale(s : DbtxmvccBuffer, f : Double) -> DbtxmvccBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_buffer_add(a : DbtxmvccBuffer, b : DbtxmvccBuffer) -> DbtxmvccBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_buffer_copy(s : DbtxmvccBuffer) -> DbtxmvccBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_buffer_fill(s : DbtxmvccBuffer, v : Double) -> DbtxmvccBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_buffer_min(s : DbtxmvccBuffer) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_buffer_max(s : DbtxmvccBuffer) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_buffer_to_string(s : DbtxmvccBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_cursor_make(size : Int) -> DbtxmvccCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_cursor_len(s : DbtxmvccCursor) -> Int { s.size }

pub fn db_tx_mvcc_cursor_get(s : DbtxmvccCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_cursor_set(s : DbtxmvccCursor, i : Int, v : Double) -> DbtxmvccCursor {
  let result = db_tx_mvcc_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_cursor_sum(s : DbtxmvccCursor) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_cursor_mean(s : DbtxmvccCursor) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_cursor_scale(s : DbtxmvccCursor, f : Double) -> DbtxmvccCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_cursor_add(a : DbtxmvccCursor, b : DbtxmvccCursor) -> DbtxmvccCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_cursor_copy(s : DbtxmvccCursor) -> DbtxmvccCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_cursor_fill(s : DbtxmvccCursor, v : Double) -> DbtxmvccCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_cursor_min(s : DbtxmvccCursor) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_cursor_max(s : DbtxmvccCursor) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_cursor_to_string(s : DbtxmvccCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_view_make(size : Int) -> DbtxmvccView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_view_len(s : DbtxmvccView) -> Int { s.size }

pub fn db_tx_mvcc_view_get(s : DbtxmvccView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_view_set(s : DbtxmvccView, i : Int, v : Double) -> DbtxmvccView {
  let result = db_tx_mvcc_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_view_sum(s : DbtxmvccView) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_view_mean(s : DbtxmvccView) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_view_scale(s : DbtxmvccView, f : Double) -> DbtxmvccView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_view_add(a : DbtxmvccView, b : DbtxmvccView) -> DbtxmvccView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_view_copy(s : DbtxmvccView) -> DbtxmvccView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_view_fill(s : DbtxmvccView, v : Double) -> DbtxmvccView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_view_min(s : DbtxmvccView) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_view_max(s : DbtxmvccView) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_view_to_string(s : DbtxmvccView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_range_make(size : Int) -> DbtxmvccRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_range_len(s : DbtxmvccRange) -> Int { s.size }

pub fn db_tx_mvcc_range_get(s : DbtxmvccRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_range_set(s : DbtxmvccRange, i : Int, v : Double) -> DbtxmvccRange {
  let result = db_tx_mvcc_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_range_sum(s : DbtxmvccRange) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_range_mean(s : DbtxmvccRange) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_range_scale(s : DbtxmvccRange, f : Double) -> DbtxmvccRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_range_add(a : DbtxmvccRange, b : DbtxmvccRange) -> DbtxmvccRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_range_copy(s : DbtxmvccRange) -> DbtxmvccRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_range_fill(s : DbtxmvccRange, v : Double) -> DbtxmvccRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_range_min(s : DbtxmvccRange) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_range_max(s : DbtxmvccRange) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_range_to_string(s : DbtxmvccRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_slice_make(size : Int) -> DbtxmvccSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_slice_len(s : DbtxmvccSlice) -> Int { s.size }

pub fn db_tx_mvcc_slice_get(s : DbtxmvccSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_slice_set(s : DbtxmvccSlice, i : Int, v : Double) -> DbtxmvccSlice {
  let result = db_tx_mvcc_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_slice_sum(s : DbtxmvccSlice) -> Double { @_common.sum(s.data) }

pub fn db_tx_mvcc_slice_mean(s : DbtxmvccSlice) -> Double { @_common.mean(s.data) }

pub fn db_tx_mvcc_slice_scale(s : DbtxmvccSlice, f : Double) -> DbtxmvccSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_slice_add(a : DbtxmvccSlice, b : DbtxmvccSlice) -> DbtxmvccSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_mvcc_slice_copy(s : DbtxmvccSlice) -> DbtxmvccSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_slice_fill(s : DbtxmvccSlice, v : Double) -> DbtxmvccSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_mvcc_slice_min(s : DbtxmvccSlice) -> Double { @_common.min(s.data) }

pub fn db_tx_mvcc_slice_max(s : DbtxmvccSlice) -> Double { @_common.max(s.data) }

pub fn db_tx_mvcc_slice_to_string(s : DbtxmvccSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

