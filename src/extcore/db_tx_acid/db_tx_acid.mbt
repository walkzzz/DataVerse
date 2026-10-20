///===
/// extcore/db_tx_acid

pub(all) struct DbtxacidPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_acid_make_point(x : Double, y : Double) -> DbtxacidPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_acid_make_point3(x : Double, y : Double, z : Double) -> DbtxacidPoint {
  { x, y, z, label: 0 }
}

pub fn db_tx_acid_point_x(pt : DbtxacidPoint) -> Double { pt.x }

pub fn db_tx_acid_point_y(pt : DbtxacidPoint) -> Double { pt.y }

pub fn db_tx_acid_point_z(pt : DbtxacidPoint) -> Double { pt.z }

pub fn db_tx_acid_point_label(pt : DbtxacidPoint) -> Int { pt.label }

pub fn db_tx_acid_point_dist(a : DbtxacidPoint, b : DbtxacidPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_tx_acid_point_add(a : DbtxacidPoint, b : DbtxacidPoint) -> DbtxacidPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_tx_acid_point_sub(a : DbtxacidPoint, b : DbtxacidPoint) -> DbtxacidPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_tx_acid_point_scale(pt : DbtxacidPoint, s : Double) -> DbtxacidPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_tx_acid_point_dot(a : DbtxacidPoint, b : DbtxacidPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_tx_acid_point_cross(a : DbtxacidPoint, b : DbtxacidPoint) -> DbtxacidPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_tx_acid_point_norm(pt : DbtxacidPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_tx_acid_point_normalize(pt : DbtxacidPoint) -> DbtxacidPoint {
  let n = db_tx_acid_point_norm(pt)
  if n < 0.0000001 { pt } else { db_tx_acid_point_scale(pt, 1.0 / n) }
}

pub fn db_tx_acid_point_negate(pt : DbtxacidPoint) -> DbtxacidPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_tx_acid_point_mid(a : DbtxacidPoint, b : DbtxacidPoint) -> DbtxacidPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_tx_acid_point_lerp(a : DbtxacidPoint, b : DbtxacidPoint, t : Double) -> DbtxacidPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_tx_acid_point_to_string(pt : DbtxacidPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbtxacidSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_acid_make_series(vals : Array[Double], name : String) -> DbtxacidSeries {
  { vals, name, meta: 0 }
}

pub fn db_tx_acid_series_len(s : DbtxacidSeries) -> Int { s.vals.length() }

pub fn db_tx_acid_series_sum(s : DbtxacidSeries) -> Double { @_common.sum(s.vals) }

pub fn db_tx_acid_series_mean(s : DbtxacidSeries) -> Double { @_common.mean(s.vals) }

pub fn db_tx_acid_series_min(s : DbtxacidSeries) -> Double { @_common.min(s.vals) }

pub fn db_tx_acid_series_max(s : DbtxacidSeries) -> Double { @_common.max(s.vals) }

pub fn db_tx_acid_series_range(s : DbtxacidSeries) -> Double {
  @_common.max(s.vals) - @_common.min(s.vals)
}

pub fn db_tx_acid_series_var(s : DbtxacidSeries) -> Double { @_common.variance(s.vals) }

pub fn db_tx_acid_series_std(s : DbtxacidSeries) -> Double { @_common.std(s.vals) }

pub fn db_tx_acid_series_median(s : DbtxacidSeries) -> Double { @_common.median(s.vals) }

pub fn db_tx_acid_series_scale(s : DbtxacidSeries, f : Double) -> DbtxacidSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_tx_acid_series_add(a : DbtxacidSeries, b : DbtxacidSeries) -> DbtxacidSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_tx_acid_series_sub(a : DbtxacidSeries, b : DbtxacidSeries) -> DbtxacidSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_tx_acid_series_normalize(s : DbtxacidSeries) -> DbtxacidSeries {
  let mn = db_tx_acid_series_min(s)
  let mx = db_tx_acid_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_tx_acid_series_cumsum(s : DbtxacidSeries) -> DbtxacidSeries {
  { vals: @_common.cumsum(s.vals), name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_tx_acid_series_to_string(s : DbtxacidSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxacidMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_acid_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxacidMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_acid_matrix_identity(n : Int) -> DbtxacidMatrix {
  let m = db_tx_acid_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_tx_acid_matrix_get(m : DbtxacidMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_tx_acid_matrix_transpose(m : DbtxacidMatrix) -> DbtxacidMatrix {
  let result = db_tx_acid_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_tx_acid_matrix_add(a : DbtxacidMatrix, b : DbtxacidMatrix) -> DbtxacidMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_tx_acid_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_tx_acid_matrix_scale(m : DbtxacidMatrix, s : Double) -> DbtxacidMatrix {
  let result = db_tx_acid_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_tx_acid_matrix_multiply(a : DbtxacidMatrix, b : DbtxacidMatrix) -> DbtxacidMatrix {
  if a.cols != b.rows { return db_tx_acid_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_tx_acid_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_tx_acid_matrix_trace(m : DbtxacidMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_tx_acid_matrix_det(m : DbtxacidMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_tx_acid_matrix_norm(m : DbtxacidMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_tx_acid_matrix_to_string(m : DbtxacidMatrix) -> String {
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

pub(all) struct DbtxacidVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_acid_make_vector(comps : Array[Double]) -> DbtxacidVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_acid_vector_zero(dim : Int) -> DbtxacidVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_tx_acid_vector_add(a : DbtxacidVector, b : DbtxacidVector) -> DbtxacidVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_acid_vector_sub(a : DbtxacidVector, b : DbtxacidVector) -> DbtxacidVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_acid_vector_scale(v : DbtxacidVector, s : Double) -> DbtxacidVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_tx_acid_vector_dot(a : DbtxacidVector, b : DbtxacidVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_tx_acid_vector_norm(v : DbtxacidVector) -> Double { @_common.sqrt(db_tx_acid_vector_dot(v, v)) }

pub fn db_tx_acid_vector_normalize(v : DbtxacidVector) -> DbtxacidVector {
  let n = db_tx_acid_vector_norm(v)
  if n < 0.0000001 { v } else { db_tx_acid_vector_scale(v, 1.0 / n) }
}

pub fn db_tx_acid_vector_dist(a : DbtxacidVector, b : DbtxacidVector) -> Double {
  db_tx_acid_vector_norm(db_tx_acid_vector_sub(a, b))
}

pub fn db_tx_acid_vector_to_string(v : DbtxacidVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_acid_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_tx_acid_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_tx_acid_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_tx_acid_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_tx_acid_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_tx_acid_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_tx_acid_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_tx_acid_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_tx_acid_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_tx_acid_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_tx_acid_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_tx_acid_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_tx_acid_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_tx_acid_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_tx_acid_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_tx_acid_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_tx_acid_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_tx_acid_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_tx_acid_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_tx_acid_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_tx_acid_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_tx_acid_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_tx_acid_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_tx_acid_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_tx_acid_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_tx_acid_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_tx_acid_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_tx_acid_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_tx_acid_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbtxacidFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_frame_make(size : Int) -> DbtxacidFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_frame_len(s : DbtxacidFrame) -> Int { s.size }

pub fn db_tx_acid_frame_get(s : DbtxacidFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_frame_set(s : DbtxacidFrame, i : Int, v : Double) -> DbtxacidFrame {
  let result = db_tx_acid_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_frame_sum(s : DbtxacidFrame) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_frame_mean(s : DbtxacidFrame) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_frame_scale(s : DbtxacidFrame, f : Double) -> DbtxacidFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_frame_add(a : DbtxacidFrame, b : DbtxacidFrame) -> DbtxacidFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_frame_copy(s : DbtxacidFrame) -> DbtxacidFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_frame_fill(s : DbtxacidFrame, v : Double) -> DbtxacidFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_frame_min(s : DbtxacidFrame) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_frame_max(s : DbtxacidFrame) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_frame_to_string(s : DbtxacidFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_table_make(size : Int) -> DbtxacidTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_table_len(s : DbtxacidTable) -> Int { s.size }

pub fn db_tx_acid_table_get(s : DbtxacidTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_table_set(s : DbtxacidTable, i : Int, v : Double) -> DbtxacidTable {
  let result = db_tx_acid_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_table_sum(s : DbtxacidTable) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_table_mean(s : DbtxacidTable) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_table_scale(s : DbtxacidTable, f : Double) -> DbtxacidTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_table_add(a : DbtxacidTable, b : DbtxacidTable) -> DbtxacidTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_table_copy(s : DbtxacidTable) -> DbtxacidTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_table_fill(s : DbtxacidTable, v : Double) -> DbtxacidTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_table_min(s : DbtxacidTable) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_table_max(s : DbtxacidTable) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_table_to_string(s : DbtxacidTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_graphn_make(size : Int) -> DbtxacidGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_graphn_len(s : DbtxacidGraphN) -> Int { s.size }

pub fn db_tx_acid_graphn_get(s : DbtxacidGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_graphn_set(s : DbtxacidGraphN, i : Int, v : Double) -> DbtxacidGraphN {
  let result = db_tx_acid_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_graphn_sum(s : DbtxacidGraphN) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_graphn_mean(s : DbtxacidGraphN) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_graphn_scale(s : DbtxacidGraphN, f : Double) -> DbtxacidGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_graphn_add(a : DbtxacidGraphN, b : DbtxacidGraphN) -> DbtxacidGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_graphn_copy(s : DbtxacidGraphN) -> DbtxacidGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_graphn_fill(s : DbtxacidGraphN, v : Double) -> DbtxacidGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_graphn_min(s : DbtxacidGraphN) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_graphn_max(s : DbtxacidGraphN) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_graphn_to_string(s : DbtxacidGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_node_make(size : Int) -> DbtxacidNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_node_len(s : DbtxacidNode) -> Int { s.size }

pub fn db_tx_acid_node_get(s : DbtxacidNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_node_set(s : DbtxacidNode, i : Int, v : Double) -> DbtxacidNode {
  let result = db_tx_acid_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_node_sum(s : DbtxacidNode) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_node_mean(s : DbtxacidNode) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_node_scale(s : DbtxacidNode, f : Double) -> DbtxacidNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_node_add(a : DbtxacidNode, b : DbtxacidNode) -> DbtxacidNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_node_copy(s : DbtxacidNode) -> DbtxacidNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_node_fill(s : DbtxacidNode, v : Double) -> DbtxacidNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_node_min(s : DbtxacidNode) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_node_max(s : DbtxacidNode) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_node_to_string(s : DbtxacidNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_edge_make(size : Int) -> DbtxacidEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_edge_len(s : DbtxacidEdge) -> Int { s.size }

pub fn db_tx_acid_edge_get(s : DbtxacidEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_edge_set(s : DbtxacidEdge, i : Int, v : Double) -> DbtxacidEdge {
  let result = db_tx_acid_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_edge_sum(s : DbtxacidEdge) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_edge_mean(s : DbtxacidEdge) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_edge_scale(s : DbtxacidEdge, f : Double) -> DbtxacidEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_edge_add(a : DbtxacidEdge, b : DbtxacidEdge) -> DbtxacidEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_edge_copy(s : DbtxacidEdge) -> DbtxacidEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_edge_fill(s : DbtxacidEdge, v : Double) -> DbtxacidEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_edge_min(s : DbtxacidEdge) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_edge_max(s : DbtxacidEdge) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_edge_to_string(s : DbtxacidEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_path_make(size : Int) -> DbtxacidPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_path_len(s : DbtxacidPath) -> Int { s.size }

pub fn db_tx_acid_path_get(s : DbtxacidPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_path_set(s : DbtxacidPath, i : Int, v : Double) -> DbtxacidPath {
  let result = db_tx_acid_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_path_sum(s : DbtxacidPath) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_path_mean(s : DbtxacidPath) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_path_scale(s : DbtxacidPath, f : Double) -> DbtxacidPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_path_add(a : DbtxacidPath, b : DbtxacidPath) -> DbtxacidPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_path_copy(s : DbtxacidPath) -> DbtxacidPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_path_fill(s : DbtxacidPath, v : Double) -> DbtxacidPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_path_min(s : DbtxacidPath) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_path_max(s : DbtxacidPath) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_path_to_string(s : DbtxacidPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_cluster_make(size : Int) -> DbtxacidCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_cluster_len(s : DbtxacidCluster) -> Int { s.size }

pub fn db_tx_acid_cluster_get(s : DbtxacidCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_cluster_set(s : DbtxacidCluster, i : Int, v : Double) -> DbtxacidCluster {
  let result = db_tx_acid_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_cluster_sum(s : DbtxacidCluster) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_cluster_mean(s : DbtxacidCluster) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_cluster_scale(s : DbtxacidCluster, f : Double) -> DbtxacidCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_cluster_add(a : DbtxacidCluster, b : DbtxacidCluster) -> DbtxacidCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_cluster_copy(s : DbtxacidCluster) -> DbtxacidCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_cluster_fill(s : DbtxacidCluster, v : Double) -> DbtxacidCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_cluster_min(s : DbtxacidCluster) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_cluster_max(s : DbtxacidCluster) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_cluster_to_string(s : DbtxacidCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_model_make(size : Int) -> DbtxacidModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_model_len(s : DbtxacidModel) -> Int { s.size }

pub fn db_tx_acid_model_get(s : DbtxacidModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_model_set(s : DbtxacidModel, i : Int, v : Double) -> DbtxacidModel {
  let result = db_tx_acid_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_model_sum(s : DbtxacidModel) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_model_mean(s : DbtxacidModel) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_model_scale(s : DbtxacidModel, f : Double) -> DbtxacidModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_model_add(a : DbtxacidModel, b : DbtxacidModel) -> DbtxacidModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_model_copy(s : DbtxacidModel) -> DbtxacidModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_model_fill(s : DbtxacidModel, v : Double) -> DbtxacidModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_model_min(s : DbtxacidModel) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_model_max(s : DbtxacidModel) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_model_to_string(s : DbtxacidModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_layer_make(size : Int) -> DbtxacidLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_layer_len(s : DbtxacidLayer) -> Int { s.size }

pub fn db_tx_acid_layer_get(s : DbtxacidLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_layer_set(s : DbtxacidLayer, i : Int, v : Double) -> DbtxacidLayer {
  let result = db_tx_acid_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_layer_sum(s : DbtxacidLayer) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_layer_mean(s : DbtxacidLayer) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_layer_scale(s : DbtxacidLayer, f : Double) -> DbtxacidLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_layer_add(a : DbtxacidLayer, b : DbtxacidLayer) -> DbtxacidLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_layer_copy(s : DbtxacidLayer) -> DbtxacidLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_layer_fill(s : DbtxacidLayer, v : Double) -> DbtxacidLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_layer_min(s : DbtxacidLayer) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_layer_max(s : DbtxacidLayer) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_layer_to_string(s : DbtxacidLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_buffer_make(size : Int) -> DbtxacidBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_buffer_len(s : DbtxacidBuffer) -> Int { s.size }

pub fn db_tx_acid_buffer_get(s : DbtxacidBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_buffer_set(s : DbtxacidBuffer, i : Int, v : Double) -> DbtxacidBuffer {
  let result = db_tx_acid_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_buffer_sum(s : DbtxacidBuffer) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_buffer_mean(s : DbtxacidBuffer) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_buffer_scale(s : DbtxacidBuffer, f : Double) -> DbtxacidBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_buffer_add(a : DbtxacidBuffer, b : DbtxacidBuffer) -> DbtxacidBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_buffer_copy(s : DbtxacidBuffer) -> DbtxacidBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_buffer_fill(s : DbtxacidBuffer, v : Double) -> DbtxacidBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_buffer_min(s : DbtxacidBuffer) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_buffer_max(s : DbtxacidBuffer) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_buffer_to_string(s : DbtxacidBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_cursor_make(size : Int) -> DbtxacidCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_cursor_len(s : DbtxacidCursor) -> Int { s.size }

pub fn db_tx_acid_cursor_get(s : DbtxacidCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_cursor_set(s : DbtxacidCursor, i : Int, v : Double) -> DbtxacidCursor {
  let result = db_tx_acid_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_cursor_sum(s : DbtxacidCursor) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_cursor_mean(s : DbtxacidCursor) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_cursor_scale(s : DbtxacidCursor, f : Double) -> DbtxacidCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_cursor_add(a : DbtxacidCursor, b : DbtxacidCursor) -> DbtxacidCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_cursor_copy(s : DbtxacidCursor) -> DbtxacidCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_cursor_fill(s : DbtxacidCursor, v : Double) -> DbtxacidCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_cursor_min(s : DbtxacidCursor) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_cursor_max(s : DbtxacidCursor) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_cursor_to_string(s : DbtxacidCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_view_make(size : Int) -> DbtxacidView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_view_len(s : DbtxacidView) -> Int { s.size }

pub fn db_tx_acid_view_get(s : DbtxacidView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_view_set(s : DbtxacidView, i : Int, v : Double) -> DbtxacidView {
  let result = db_tx_acid_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_view_sum(s : DbtxacidView) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_view_mean(s : DbtxacidView) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_view_scale(s : DbtxacidView, f : Double) -> DbtxacidView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_view_add(a : DbtxacidView, b : DbtxacidView) -> DbtxacidView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_view_copy(s : DbtxacidView) -> DbtxacidView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_view_fill(s : DbtxacidView, v : Double) -> DbtxacidView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_view_min(s : DbtxacidView) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_view_max(s : DbtxacidView) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_view_to_string(s : DbtxacidView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_range_make(size : Int) -> DbtxacidRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_range_len(s : DbtxacidRange) -> Int { s.size }

pub fn db_tx_acid_range_get(s : DbtxacidRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_range_set(s : DbtxacidRange, i : Int, v : Double) -> DbtxacidRange {
  let result = db_tx_acid_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_range_sum(s : DbtxacidRange) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_range_mean(s : DbtxacidRange) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_range_scale(s : DbtxacidRange, f : Double) -> DbtxacidRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_range_add(a : DbtxacidRange, b : DbtxacidRange) -> DbtxacidRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_range_copy(s : DbtxacidRange) -> DbtxacidRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_range_fill(s : DbtxacidRange, v : Double) -> DbtxacidRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_range_min(s : DbtxacidRange) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_range_max(s : DbtxacidRange) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_range_to_string(s : DbtxacidRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_slice_make(size : Int) -> DbtxacidSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_slice_len(s : DbtxacidSlice) -> Int { s.size }

pub fn db_tx_acid_slice_get(s : DbtxacidSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_slice_set(s : DbtxacidSlice, i : Int, v : Double) -> DbtxacidSlice {
  let result = db_tx_acid_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_slice_sum(s : DbtxacidSlice) -> Double { @_common.sum(s.data) }

pub fn db_tx_acid_slice_mean(s : DbtxacidSlice) -> Double { @_common.mean(s.data) }

pub fn db_tx_acid_slice_scale(s : DbtxacidSlice, f : Double) -> DbtxacidSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_slice_add(a : DbtxacidSlice, b : DbtxacidSlice) -> DbtxacidSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_tx_acid_slice_copy(s : DbtxacidSlice) -> DbtxacidSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_slice_fill(s : DbtxacidSlice, v : Double) -> DbtxacidSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_tx_acid_slice_min(s : DbtxacidSlice) -> Double { @_common.min(s.data) }

pub fn db_tx_acid_slice_max(s : DbtxacidSlice) -> Double { @_common.max(s.data) }

pub fn db_tx_acid_slice_to_string(s : DbtxacidSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

