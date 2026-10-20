///===
/// extcore/db_tx_lock

pub(all) struct DbtxlockPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_lock_make_point(x : Double, y : Double) -> DbtxlockPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_lock_make_point3(x : Double, y : Double, z : Double) -> DbtxlockPoint {
  { x, y, z, label: 0 }
}

pub fn db_tx_lock_point_x(pt : DbtxlockPoint) -> Double { pt.x }

pub fn db_tx_lock_point_y(pt : DbtxlockPoint) -> Double { pt.y }

pub fn db_tx_lock_point_z(pt : DbtxlockPoint) -> Double { pt.z }

pub fn db_tx_lock_point_label(pt : DbtxlockPoint) -> Int { pt.label }

pub fn db_tx_lock_point_dist(a : DbtxlockPoint, b : DbtxlockPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_tx_lock_point_add(a : DbtxlockPoint, b : DbtxlockPoint) -> DbtxlockPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_tx_lock_point_sub(a : DbtxlockPoint, b : DbtxlockPoint) -> DbtxlockPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_tx_lock_point_scale(pt : DbtxlockPoint, s : Double) -> DbtxlockPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_tx_lock_point_dot(a : DbtxlockPoint, b : DbtxlockPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_tx_lock_point_cross(a : DbtxlockPoint, b : DbtxlockPoint) -> DbtxlockPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_tx_lock_point_norm(pt : DbtxlockPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_tx_lock_point_normalize(pt : DbtxlockPoint) -> DbtxlockPoint {
  let n = db_tx_lock_point_norm(pt)
  if n < 0.0000001 { pt } else { db_tx_lock_point_scale(pt, 1.0 / n) }
}

pub fn db_tx_lock_point_negate(pt : DbtxlockPoint) -> DbtxlockPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_tx_lock_point_mid(a : DbtxlockPoint, b : DbtxlockPoint) -> DbtxlockPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_tx_lock_point_lerp(a : DbtxlockPoint, b : DbtxlockPoint, t : Double) -> DbtxlockPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_tx_lock_point_to_string(pt : DbtxlockPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbtxlockSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_lock_make_series(vals : Array[Double], name : String) -> DbtxlockSeries {
  { vals, name, meta: 0 }
}

pub fn db_tx_lock_series_len(s : DbtxlockSeries) -> Int { s.vals.length() }

pub fn db_tx_lock_series_sum(s : DbtxlockSeries) -> Double { @_common.sum(s.vals) }

pub fn db_tx_lock_series_mean(s : DbtxlockSeries) -> Double { @_common.mean(s.vals) }

pub fn db_tx_lock_series_min(s : DbtxlockSeries) -> Double { @_common.min(s.vals) }

pub fn db_tx_lock_series_max(s : DbtxlockSeries) -> Double { @_common.max(s.vals) }

pub fn db_tx_lock_series_range(s : DbtxlockSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_tx_lock_series_var(s : DbtxlockSeries) -> Double { @_common.variance(s.vals) }

pub fn db_tx_lock_series_std(s : DbtxlockSeries) -> Double { @_common.std(s.vals) }

pub fn db_tx_lock_series_median(s : DbtxlockSeries) -> Double { @_common.median(s.vals) }

pub fn db_tx_lock_series_scale(s : DbtxlockSeries, f : Double) -> DbtxlockSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_tx_lock_series_add(a : DbtxlockSeries, b : DbtxlockSeries) -> DbtxlockSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_tx_lock_series_sub(a : DbtxlockSeries, b : DbtxlockSeries) -> DbtxlockSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_tx_lock_series_normalize(s : DbtxlockSeries) -> DbtxlockSeries {
  let mn = db_tx_lock_series_min(s)
  let mx = db_tx_lock_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_tx_lock_series_cumsum(s : DbtxlockSeries) -> DbtxlockSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_tx_lock_series_to_string(s : DbtxlockSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxlockMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_lock_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxlockMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_lock_matrix_identity(n : Int) -> DbtxlockMatrix {
  let m = db_tx_lock_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_tx_lock_matrix_get(m : DbtxlockMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_tx_lock_matrix_transpose(m : DbtxlockMatrix) -> DbtxlockMatrix {
  let result = db_tx_lock_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_tx_lock_matrix_add(a : DbtxlockMatrix, b : DbtxlockMatrix) -> DbtxlockMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_tx_lock_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_tx_lock_matrix_scale(m : DbtxlockMatrix, s : Double) -> DbtxlockMatrix {
  let result = db_tx_lock_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_tx_lock_matrix_multiply(a : DbtxlockMatrix, b : DbtxlockMatrix) -> DbtxlockMatrix {
  if a.cols != b.rows { return db_tx_lock_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_tx_lock_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_tx_lock_matrix_trace(m : DbtxlockMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_tx_lock_matrix_det(m : DbtxlockMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_tx_lock_matrix_norm(m : DbtxlockMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_tx_lock_matrix_to_string(m : DbtxlockMatrix) -> String {
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

pub(all) struct DbtxlockVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_lock_make_vector(comps : Array[Double]) -> DbtxlockVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_lock_vector_zero(dim : Int) -> DbtxlockVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_tx_lock_vector_add(a : DbtxlockVector, b : DbtxlockVector) -> DbtxlockVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_lock_vector_sub(a : DbtxlockVector, b : DbtxlockVector) -> DbtxlockVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_lock_vector_scale(v : DbtxlockVector, s : Double) -> DbtxlockVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_tx_lock_vector_dot(a : DbtxlockVector, b : DbtxlockVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_tx_lock_vector_norm(v : DbtxlockVector) -> Double { @_common.sqrt(db_tx_lock_vector_dot(v, v)) }

pub fn db_tx_lock_vector_normalize(v : DbtxlockVector) -> DbtxlockVector {
  let n = db_tx_lock_vector_norm(v)
  if n < 0.0000001 { v } else { db_tx_lock_vector_scale(v, 1.0 / n) }
}

pub fn db_tx_lock_vector_dist(a : DbtxlockVector, b : DbtxlockVector) -> Double {
  db_tx_lock_vector_norm(db_tx_lock_vector_sub(a, b))
}

pub fn db_tx_lock_vector_to_string(v : DbtxlockVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_lock_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_tx_lock_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_tx_lock_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_tx_lock_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_tx_lock_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_tx_lock_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_tx_lock_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_tx_lock_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_tx_lock_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_tx_lock_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_tx_lock_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_tx_lock_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_tx_lock_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_tx_lock_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_tx_lock_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_tx_lock_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_tx_lock_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_tx_lock_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_tx_lock_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_tx_lock_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_tx_lock_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_tx_lock_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_tx_lock_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_tx_lock_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_tx_lock_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_tx_lock_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_tx_lock_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_tx_lock_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_tx_lock_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbtxlockFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_frame_make(size : Int) -> DbtxlockFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_frame_len(s : DbtxlockFrame) -> Int { s.size }

pub fn db_tx_lock_frame_get(s : DbtxlockFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_frame_set(s : DbtxlockFrame, i : Int, v : Double) -> DbtxlockFrame {
  let result = db_tx_lock_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_frame_sum(s : DbtxlockFrame) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_frame_mean(s : DbtxlockFrame) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_frame_scale(s : DbtxlockFrame, f : Double) -> DbtxlockFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_frame_add(a : DbtxlockFrame, b : DbtxlockFrame) -> DbtxlockFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_frame_copy(s : DbtxlockFrame) -> DbtxlockFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_frame_fill(s : DbtxlockFrame, v : Double) -> DbtxlockFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_frame_min(s : DbtxlockFrame) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_frame_max(s : DbtxlockFrame) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_frame_to_string(s : DbtxlockFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_table_make(size : Int) -> DbtxlockTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_table_len(s : DbtxlockTable) -> Int { s.size }

pub fn db_tx_lock_table_get(s : DbtxlockTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_table_set(s : DbtxlockTable, i : Int, v : Double) -> DbtxlockTable {
  let result = db_tx_lock_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_table_sum(s : DbtxlockTable) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_table_mean(s : DbtxlockTable) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_table_scale(s : DbtxlockTable, f : Double) -> DbtxlockTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_table_add(a : DbtxlockTable, b : DbtxlockTable) -> DbtxlockTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_table_copy(s : DbtxlockTable) -> DbtxlockTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_table_fill(s : DbtxlockTable, v : Double) -> DbtxlockTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_table_min(s : DbtxlockTable) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_table_max(s : DbtxlockTable) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_table_to_string(s : DbtxlockTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_graphn_make(size : Int) -> DbtxlockGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_graphn_len(s : DbtxlockGraphN) -> Int { s.size }

pub fn db_tx_lock_graphn_get(s : DbtxlockGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_graphn_set(s : DbtxlockGraphN, i : Int, v : Double) -> DbtxlockGraphN {
  let result = db_tx_lock_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_graphn_sum(s : DbtxlockGraphN) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_graphn_mean(s : DbtxlockGraphN) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_graphn_scale(s : DbtxlockGraphN, f : Double) -> DbtxlockGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_graphn_add(a : DbtxlockGraphN, b : DbtxlockGraphN) -> DbtxlockGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_graphn_copy(s : DbtxlockGraphN) -> DbtxlockGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_graphn_fill(s : DbtxlockGraphN, v : Double) -> DbtxlockGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_graphn_min(s : DbtxlockGraphN) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_graphn_max(s : DbtxlockGraphN) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_graphn_to_string(s : DbtxlockGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_node_make(size : Int) -> DbtxlockNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_node_len(s : DbtxlockNode) -> Int { s.size }

pub fn db_tx_lock_node_get(s : DbtxlockNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_node_set(s : DbtxlockNode, i : Int, v : Double) -> DbtxlockNode {
  let result = db_tx_lock_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_node_sum(s : DbtxlockNode) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_node_mean(s : DbtxlockNode) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_node_scale(s : DbtxlockNode, f : Double) -> DbtxlockNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_node_add(a : DbtxlockNode, b : DbtxlockNode) -> DbtxlockNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_node_copy(s : DbtxlockNode) -> DbtxlockNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_node_fill(s : DbtxlockNode, v : Double) -> DbtxlockNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_node_min(s : DbtxlockNode) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_node_max(s : DbtxlockNode) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_node_to_string(s : DbtxlockNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_edge_make(size : Int) -> DbtxlockEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_edge_len(s : DbtxlockEdge) -> Int { s.size }

pub fn db_tx_lock_edge_get(s : DbtxlockEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_edge_set(s : DbtxlockEdge, i : Int, v : Double) -> DbtxlockEdge {
  let result = db_tx_lock_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_edge_sum(s : DbtxlockEdge) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_edge_mean(s : DbtxlockEdge) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_edge_scale(s : DbtxlockEdge, f : Double) -> DbtxlockEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_edge_add(a : DbtxlockEdge, b : DbtxlockEdge) -> DbtxlockEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_edge_copy(s : DbtxlockEdge) -> DbtxlockEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_edge_fill(s : DbtxlockEdge, v : Double) -> DbtxlockEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_edge_min(s : DbtxlockEdge) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_edge_max(s : DbtxlockEdge) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_edge_to_string(s : DbtxlockEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_path_make(size : Int) -> DbtxlockPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_path_len(s : DbtxlockPath) -> Int { s.size }

pub fn db_tx_lock_path_get(s : DbtxlockPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_path_set(s : DbtxlockPath, i : Int, v : Double) -> DbtxlockPath {
  let result = db_tx_lock_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_path_sum(s : DbtxlockPath) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_path_mean(s : DbtxlockPath) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_path_scale(s : DbtxlockPath, f : Double) -> DbtxlockPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_path_add(a : DbtxlockPath, b : DbtxlockPath) -> DbtxlockPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_path_copy(s : DbtxlockPath) -> DbtxlockPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_path_fill(s : DbtxlockPath, v : Double) -> DbtxlockPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_path_min(s : DbtxlockPath) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_path_max(s : DbtxlockPath) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_path_to_string(s : DbtxlockPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_cluster_make(size : Int) -> DbtxlockCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_cluster_len(s : DbtxlockCluster) -> Int { s.size }

pub fn db_tx_lock_cluster_get(s : DbtxlockCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_cluster_set(s : DbtxlockCluster, i : Int, v : Double) -> DbtxlockCluster {
  let result = db_tx_lock_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_cluster_sum(s : DbtxlockCluster) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_cluster_mean(s : DbtxlockCluster) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_cluster_scale(s : DbtxlockCluster, f : Double) -> DbtxlockCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_cluster_add(a : DbtxlockCluster, b : DbtxlockCluster) -> DbtxlockCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_cluster_copy(s : DbtxlockCluster) -> DbtxlockCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_cluster_fill(s : DbtxlockCluster, v : Double) -> DbtxlockCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_cluster_min(s : DbtxlockCluster) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_cluster_max(s : DbtxlockCluster) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_cluster_to_string(s : DbtxlockCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_model_make(size : Int) -> DbtxlockModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_model_len(s : DbtxlockModel) -> Int { s.size }

pub fn db_tx_lock_model_get(s : DbtxlockModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_model_set(s : DbtxlockModel, i : Int, v : Double) -> DbtxlockModel {
  let result = db_tx_lock_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_model_sum(s : DbtxlockModel) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_model_mean(s : DbtxlockModel) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_model_scale(s : DbtxlockModel, f : Double) -> DbtxlockModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_model_add(a : DbtxlockModel, b : DbtxlockModel) -> DbtxlockModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_model_copy(s : DbtxlockModel) -> DbtxlockModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_model_fill(s : DbtxlockModel, v : Double) -> DbtxlockModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_model_min(s : DbtxlockModel) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_model_max(s : DbtxlockModel) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_model_to_string(s : DbtxlockModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_layer_make(size : Int) -> DbtxlockLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_layer_len(s : DbtxlockLayer) -> Int { s.size }

pub fn db_tx_lock_layer_get(s : DbtxlockLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_layer_set(s : DbtxlockLayer, i : Int, v : Double) -> DbtxlockLayer {
  let result = db_tx_lock_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_layer_sum(s : DbtxlockLayer) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_layer_mean(s : DbtxlockLayer) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_layer_scale(s : DbtxlockLayer, f : Double) -> DbtxlockLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_layer_add(a : DbtxlockLayer, b : DbtxlockLayer) -> DbtxlockLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_layer_copy(s : DbtxlockLayer) -> DbtxlockLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_layer_fill(s : DbtxlockLayer, v : Double) -> DbtxlockLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_layer_min(s : DbtxlockLayer) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_layer_max(s : DbtxlockLayer) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_layer_to_string(s : DbtxlockLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_buffer_make(size : Int) -> DbtxlockBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_buffer_len(s : DbtxlockBuffer) -> Int { s.size }

pub fn db_tx_lock_buffer_get(s : DbtxlockBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_buffer_set(s : DbtxlockBuffer, i : Int, v : Double) -> DbtxlockBuffer {
  let result = db_tx_lock_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_buffer_sum(s : DbtxlockBuffer) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_buffer_mean(s : DbtxlockBuffer) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_buffer_scale(s : DbtxlockBuffer, f : Double) -> DbtxlockBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_buffer_add(a : DbtxlockBuffer, b : DbtxlockBuffer) -> DbtxlockBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_buffer_copy(s : DbtxlockBuffer) -> DbtxlockBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_buffer_fill(s : DbtxlockBuffer, v : Double) -> DbtxlockBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_buffer_min(s : DbtxlockBuffer) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_buffer_max(s : DbtxlockBuffer) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_buffer_to_string(s : DbtxlockBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_cursor_make(size : Int) -> DbtxlockCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_cursor_len(s : DbtxlockCursor) -> Int { s.size }

pub fn db_tx_lock_cursor_get(s : DbtxlockCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_cursor_set(s : DbtxlockCursor, i : Int, v : Double) -> DbtxlockCursor {
  let result = db_tx_lock_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_cursor_sum(s : DbtxlockCursor) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_cursor_mean(s : DbtxlockCursor) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_cursor_scale(s : DbtxlockCursor, f : Double) -> DbtxlockCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_cursor_add(a : DbtxlockCursor, b : DbtxlockCursor) -> DbtxlockCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_cursor_copy(s : DbtxlockCursor) -> DbtxlockCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_cursor_fill(s : DbtxlockCursor, v : Double) -> DbtxlockCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_cursor_min(s : DbtxlockCursor) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_cursor_max(s : DbtxlockCursor) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_cursor_to_string(s : DbtxlockCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_view_make(size : Int) -> DbtxlockView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_view_len(s : DbtxlockView) -> Int { s.size }

pub fn db_tx_lock_view_get(s : DbtxlockView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_view_set(s : DbtxlockView, i : Int, v : Double) -> DbtxlockView {
  let result = db_tx_lock_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_view_sum(s : DbtxlockView) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_view_mean(s : DbtxlockView) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_view_scale(s : DbtxlockView, f : Double) -> DbtxlockView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_view_add(a : DbtxlockView, b : DbtxlockView) -> DbtxlockView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_view_copy(s : DbtxlockView) -> DbtxlockView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_view_fill(s : DbtxlockView, v : Double) -> DbtxlockView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_view_min(s : DbtxlockView) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_view_max(s : DbtxlockView) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_view_to_string(s : DbtxlockView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_range_make(size : Int) -> DbtxlockRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_range_len(s : DbtxlockRange) -> Int { s.size }

pub fn db_tx_lock_range_get(s : DbtxlockRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_range_set(s : DbtxlockRange, i : Int, v : Double) -> DbtxlockRange {
  let result = db_tx_lock_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_range_sum(s : DbtxlockRange) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_range_mean(s : DbtxlockRange) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_range_scale(s : DbtxlockRange, f : Double) -> DbtxlockRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_range_add(a : DbtxlockRange, b : DbtxlockRange) -> DbtxlockRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_range_copy(s : DbtxlockRange) -> DbtxlockRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_range_fill(s : DbtxlockRange, v : Double) -> DbtxlockRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_range_min(s : DbtxlockRange) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_range_max(s : DbtxlockRange) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_range_to_string(s : DbtxlockRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_slice_make(size : Int) -> DbtxlockSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_slice_len(s : DbtxlockSlice) -> Int { s.size }

pub fn db_tx_lock_slice_get(s : DbtxlockSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_slice_set(s : DbtxlockSlice, i : Int, v : Double) -> DbtxlockSlice {
  let result = db_tx_lock_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_slice_sum(s : DbtxlockSlice) -> Double { @_common.sum(s.data) }

pub fn db_tx_lock_slice_mean(s : DbtxlockSlice) -> Double { @_common.mean(s.data) }

pub fn db_tx_lock_slice_scale(s : DbtxlockSlice, f : Double) -> DbtxlockSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_slice_add(a : DbtxlockSlice, b : DbtxlockSlice) -> DbtxlockSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_lock_slice_copy(s : DbtxlockSlice) -> DbtxlockSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_slice_fill(s : DbtxlockSlice, v : Double) -> DbtxlockSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_lock_slice_min(s : DbtxlockSlice) -> Double { @_common.min(s.data) }

pub fn db_tx_lock_slice_max(s : DbtxlockSlice) -> Double { @_common.max(s.data) }

pub fn db_tx_lock_slice_to_string(s : DbtxlockSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

